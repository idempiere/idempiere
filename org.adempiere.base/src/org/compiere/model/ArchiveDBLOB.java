/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Trek Global                                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.osgi.service.component.annotations.Component;

/**
 * DB LOB implementation of {@link IArchiveStore}
 */
@Component(immediate = true, service = {IArchiveStore.class}, property = {"method=DB_LOB"})
public class ArchiveDBLOB implements IArchiveStore {

	private static final String AD_ARCHIVE_BLOB_GET = "SELECT BinaryData FROM AD_Archive_Blob WHERE AD_Archive_ID = ?";
	
	private static final String AD_ARCHIVE_BLOB_INSERT = "INSERT INTO AD_Archive_Blob(AD_Archive_ID, BinaryData) Values (?, ?)";
	
	private static final String AD_ARCHIVE_BLOB_DELETE = "DELETE FROM AD_Archive_Blob WHERE AD_Archive_ID=?";

	private static final CLogger log = CLogger.getCLogger(ArchiveDB.class);
	
	//temporary buffer when AD_Archive_ID=0;
	private byte[] buffer;
	private InputStream bufferInputStream;
		
	/* (non-Javadoc)
	 * @see org.compiere.model.IArchiveStore#loadLOBData(org.compiere.model.MArchive, org.compiere.model.MStorageProvider)
	 */
	@Override
	public byte[] loadLOBData(MArchive archive, MStorageProvider prov) {
		buffer = null;
		bufferInputStream = null;
		
		byte[] deflatedData = archive.getByteData();
		if (deflatedData == null)
			return null;
		//		
		if (deflatedData.length == 0)
			return null;
		
		return getExternalDataAsBytes(archive);
	}
	
	/**
	 * Get data from AD_Archive_Blob table
	 * @param archive
	 * @return byte[] of the archive data
	 */
	private byte[] getExternalDataAsBytes(MArchive archive) {
		Connection conn = null; 
		// With Postgresql, you need to keep transaction open to access blob
    	if (archive.get_TrxName() == null && DB.isPostgreSQL()) {
    		conn = DB.createConnection(true, Connection.TRANSACTION_READ_COMMITTED);
    		try {
				conn.setAutoCommit(false);
			} catch (SQLException e) {
				try {
					conn.close();
				} catch (SQLException e1) {
				}
				throw new RuntimeException("Error setting auto commit to false", e);
			}
    	}
    	
		String sql = AD_ARCHIVE_BLOB_GET;
		try (PreparedStatement pstmt = conn != null
				? DB.prepareStatement(conn, sql)
				: DB.prepareStatement(sql, archive.get_TrxName())) {
			pstmt.setInt(1, archive.getAD_Archive_ID());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					Blob blob = rs.getBlob(1);
					if (blob != null) {
						try (InputStream inputStream = blob.getBinaryStream();
	                        ZipInputStream zis = new ZipInputStream(inputStream)) {
							ZipEntry entry = zis.getNextEntry();
                            assert entry != null;
							ByteArrayOutputStream out = new ByteArrayOutputStream();
							byte[] buffer = new byte[2048];
							int length;
							while ((length = zis.read(buffer)) != -1) 
								out.write(buffer, 0, length);
							return out.toByteArray();
						} finally {
							blob.free();
						}
					}
				}
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getMessage(), e);
		} finally {
			if (conn != null) {
				try {
					conn.commit();
				} catch (SQLException e) {
				}
				try {
					conn.setAutoCommit(true);
				} catch (SQLException e) {
				}
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
		return null;
	}

	@Override
	public InputStream loadLOBDataAsStream(MArchive archive, MStorageProvider prov) {
		buffer = null;
		bufferInputStream = null;
		
		byte[] deflatedData = archive.getByteData();
		if (deflatedData == null || deflatedData.length == 0)
			return null;
		
		String strValue = new String(deflatedData, StandardCharsets.US_ASCII);
		long size = Long.parseLong(strValue);
		return getExternalDataAsStream(archive, size);
	}

	/**
	 * Convert Blob stream to ByteArrayInputStream (if < 2MB) or FileInputStream depends on size
	 * @param blob
	 * @param size 
	 * @return ByteArrayInputStream or FileInputStream
	 * @throws IOException
	 */
	private InputStream blobToLocalInputStream(Blob blob, long size) throws IOException {
		// If the blob is small enough, read it into memory
		try {
			if (size < (1024 * 1024 * 2)) { 
				try (InputStream inputStream = blob.getBinaryStream();
                    ZipInputStream zis = new ZipInputStream(inputStream)) {
					ZipEntry entry = zis.getNextEntry();
                    assert entry != null;
					ByteArrayOutputStream out = new ByteArrayOutputStream();
					byte[] buffer = new byte[2048];
					int length = 0;
					while ((length = zis.read(buffer)) != -1) {
						out.write(buffer, 0, length);
					}
					return new ByteArrayInputStream(out.toByteArray());
				} finally {
					blob.free();
				}
			}
		} catch (SQLException e) {
			throw new DBException("Error reading blob data", e);
		} catch (IOException e) {
			throw new AdempiereException("Error reading blob data", e);
		}
		
		// If the blob is too large, write it to a temporary file
		Path tempDir = Files.createTempDirectory("archive_blob_");
		try (InputStream inputStream = blob.getBinaryStream();
            ZipInputStream zis = new ZipInputStream(inputStream)) {
			ZipEntry entry = zis.getNextEntry();
            assert entry != null;
			Path tempFile = tempDir.resolve("blob_data");
			Files.copy(zis, tempFile, StandardCopyOption.REPLACE_EXISTING);
			return Files.newInputStream(tempFile);
		} catch (SQLException e) {
			throw new DBException("Error reading blob data", e);
		} finally {
			try {
				blob.free();
			} catch (SQLException e) {
			}
		}
	}
	
	/**
	 * Get data stream from AD_Archive_Blob table
	 * @param archive
	 * @param size 
	 * @return InputStream of the archive data
	 */
	private InputStream getExternalDataAsStream(MArchive archive, long size) {
		Connection conn = null; 
		// With Postgresql, you need to keep transaction open to access blob
		if (archive.get_TrxName() == null && DB.isPostgreSQL()) {
    		conn = DB.createConnection(true, Connection.TRANSACTION_READ_COMMITTED);
    		try {
				conn.setAutoCommit(false);
			} catch (SQLException e) {
				try {
					conn.close();
				} catch (SQLException e1) {
				}
				throw new RuntimeException("Error setting auto commit to false", e);
			}
    	}
		String sql = AD_ARCHIVE_BLOB_GET;
		try (PreparedStatement pstmt = conn != null 
				? DB.prepareStatement(conn, sql) 
				: DB.prepareStatement(sql, archive.get_TrxName())) {
			pstmt.setInt(1, archive.getAD_Archive_ID());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					Blob blob = rs.getBlob(1);
					if (blob != null) {
						return blobToLocalInputStream(blob, size);
					}
				}
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getMessage(), e);
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException e1) {
				}
			}
		} finally {
			if (conn != null) {
				try {
					conn.commit();
				} catch (SQLException e) {
				}
				try {
					conn.setAutoCommit(true);
				} catch (SQLException e) {
				}
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}

		return null;
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.IArchiveStore#save(org.compiere.model.MArchive, org.compiere.model.MStorageProvider, byte[])
	 */
	@Override
	public void save(MArchive archive, MStorageProvider prov,byte[] byteDatas) {
		if (byteDatas == null || byteDatas.length == 0)
			throw new IllegalArgumentException("byteDatas is NULL");
		
		if(archive.get_ID()==0){
			//set binary data otherwise save will fail
			archive.setByteData(new byte[]{'0'});
			buffer = byteDatas;
			bufferInputStream = null;
		} else {		
			write(archive, prov, byteDatas, null);			
		}
	}

	@Override
	public void save(MArchive archive, MStorageProvider prov, InputStream inputStream) {
		if (inputStream == null) {
			throw new IllegalArgumentException("inputStream is NULL");
		}
		if(archive.get_ID()==0){
			//set binary data otherwise save will fail
			archive.setByteData(new byte[]{'0'});
			bufferInputStream = inputStream;
			buffer = null;
		} else {		
			write(archive, prov, null, inputStream);			
		}
	}

	/**
	 * Write archive data to AD_Archive_Blob table
	 * @param archive
	 * @param prov
	 * @param byteDatas archive data
	 * @param inputStream InputStream to read data from, if null, byteDatas will be used
	 */
	private void write(MArchive archive, MStorageProvider prov,
			byte[] byteDatas, InputStream inputStream) {
		if ((byteDatas == null || byteDatas.length == 0) && inputStream == null) {
			throw new IllegalArgumentException("Both byteDatas and inputStream is NULL");
		}
		
		BufferedOutputStream out = null;
		try {
			Connection conn = null; 
			// With Postgresql, you need to keep transaction open to access blob
	    	if (archive.get_TrxName() == null && DB.isPostgreSQL()) {
	    		conn = DB.createConnection(true, Connection.TRANSACTION_READ_COMMITTED);
	    		try {
					conn.setAutoCommit(false);
				} catch (SQLException e) {
					try {
						conn.close();
					} catch (SQLException e1) {
					}
					throw new RuntimeException("Error setting auto commit to false", e);
				}
	    	}
	    	
	    	// try to find existing blob
	    	String sql = AD_ARCHIVE_BLOB_GET;
	    	if (DB.isOracle())
	            sql += " FOR UPDATE ";
	    	boolean updateBlob = false;
			try (PreparedStatement pstmt = conn != null 
					? DB.prepareStatement(conn, sql) 
					: DB.prepareStatement(sql, archive.get_TrxName())) {
				pstmt.setInt(1, archive.getAD_Archive_ID());
				try (ResultSet rs = pstmt.executeQuery()) {
					if (rs.next()) {
						updateBlob = true;
						Blob blob = rs.getBlob(1);
						long size = 0;
						if (inputStream != null) {
							try (ZipOutputStream zos = new ZipOutputStream(blob.setBinaryStream(1))) {
	                            ZipEntry zipEntry = new ZipEntry(archive.getName());
	                            zos.putNextEntry(zipEntry);
								byte[] buffer = new byte[2048];
								int length = 0;							
								while ((length = inputStream.read(buffer)) != -1) {
									zos.write(buffer, 0, length);
									size += length;
								}
							} finally {
								blob.free();
							}
						} else if (byteDatas != null && byteDatas.length > 0) {
							try (ZipOutputStream zos = new ZipOutputStream(blob.setBinaryStream(1))) {
	                            ZipEntry zipEntry = new ZipEntry(archive.getName());
	                            zos.putNextEntry(zipEntry);
								zos.write(byteDatas);
								size = byteDatas.length;
							} finally {
								blob.free();
							}
						}
						if (size > 0)
							archive.setByteData(String.valueOf(size).getBytes(StandardCharsets.US_ASCII));
						else
							archive.setByteData(null);
						return;
					}
				}
				if (updateBlob && conn != null)
					conn.commit();
			} catch (Exception e) {
				if (conn != null) {
					conn.rollback();
				}
				archive.setByteData(null);
				throw new RuntimeException(e);
			} finally {
				if (conn != null)
	    		{
	    			try {
						conn.setAutoCommit(true);
					} catch (SQLException e) {
					}
	    			try {
						conn.close();
					} catch (SQLException e) {
					}
	    		}
			}
			
			// no existing blob found, create a new one
			sql = AD_ARCHIVE_BLOB_INSERT;
			Path tempFile = null;
			try {
				long size = 0;
				try (PreparedStatement pstmt = conn != null 
						? DB.prepareStatement(conn, sql) 
						: DB.prepareStatement(sql, archive.get_TrxName())) {
					pstmt.setInt(1, archive.getAD_Archive_ID());
					try {
		                Path tempDir = Files.createTempDirectory("attachment_");
		                tempFile = tempDir.resolve(archive.getName() + ".zip");
		                try (ZipOutputStream zos = new ZipOutputStream(Files.newOutputStream(tempFile))) {
		                    ZipEntry zipEntry = new ZipEntry(archive.getName());
		                    zos.putNextEntry(zipEntry);
		                    byte[] buffer = new byte[2048];
		                    int length;
		                    InputStream inputStreamToUse = null;
		                    if (inputStream != null) {
		                        inputStreamToUse = inputStream;
		                    } else if (byteDatas != null && byteDatas.length > 0) {
		                    	inputStreamToUse = new ByteArrayInputStream(byteDatas);
		                    } 
		                    if (inputStreamToUse != null) {
		                        while ((length = inputStreamToUse.read(buffer)) != -1) {
		                            zos.write(buffer, 0, length);
		                            size += length;
		                        }
		                    }
		                }
		            } catch (Exception e) {
		                throw new AdempiereException(e);
		            }
					pstmt.setBlob(2, Files.newInputStream(tempFile));
					pstmt.executeUpdate();
					if (size > 0)
						archive.setByteData(String.valueOf(size).getBytes(StandardCharsets.US_ASCII));
					else
						archive.setByteData(null);
				} catch (Exception e) {
					if (conn != null) {
						conn.rollback();
					}
					throw e;
				}
				if (conn != null) {
					conn.commit();
				}
			} finally {
				if (conn != null)
	    		{
	    			try {
						conn.setAutoCommit(true);
					} catch (SQLException e) {
					}
	    			try {
						conn.close();
					} catch (SQLException e) {
					}
	    		}
				if (tempFile != null) {
	                File f = tempFile.toFile();
	                if (f.exists()) {
	                    if (!f.delete())
	                        f.deleteOnExit();;
	                }
	            }
			}
		} catch (Exception e) {
			archive.setByteData(null);
			throw new RuntimeException(e);
		} finally {
			if(out != null){
				try {
					out.close();
				} catch (Exception e) {	}
			}
		}
	}
	
	@Override
	public boolean deleteArchive(MArchive archive, MStorageProvider prov) {
		DB.executeUpdateEx(AD_ARCHIVE_BLOB_DELETE, new Object[] {archive.getAD_Archive_ID()}, archive.get_TrxName());
		return true;
	}

	@Override
	public boolean isPendingFlush() {
		return (buffer != null && buffer.length > 0) || bufferInputStream != null;
	}

	@Override
	public void flush(MArchive archive, MStorageProvider prov) {
		try {
			if ((buffer != null && buffer.length > 0) || bufferInputStream != null) {
				write(archive, prov, buffer, bufferInputStream);			
			}
		} finally {
			buffer = null;
			bufferInputStream = null;
		}
	}
}
