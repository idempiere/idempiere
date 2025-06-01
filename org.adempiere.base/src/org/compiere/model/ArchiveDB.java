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
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 * DB backed implementation of {@link IArchiveStore}
 * @author juliana
 */
public class ArchiveDB implements IArchiveStore {

	private static final String AD_ARCHIVE_BLOB_GET = "SELECT BinaryData FROM AD_Archive_Blob WHERE AD_Archive_ID = ?";
	
	private static final String AD_ARCHIVE_BLOB_INSERT = "INSERT INTO AD_Archive_Blob(AD_Archive_ID, BinaryData) Values (?, ?)";
	
	private static final String AD_ARCHIVE_BLOB_DELETE = "DELETE FROM AD_Archive_Blob WHERE AD_Archive_ID=?";

	private static final CLogger log = CLogger.getCLogger(ArchiveDB.class);
	
	private static final byte[] marker = "::AD_Archive_Blob".getBytes(StandardCharsets.US_ASCII);

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
		
		boolean isExternal = deflatedData.length == marker.length;
		if (isExternal) {
			for(int i= 0; i < marker.length; i++) {
				if (deflatedData[i] != marker[i]) {
					isExternal = false;
					break;
				}
			}
		}
		
		if (isExternal) {
			return getExternalDataAsBytes(archive);
		} 
		
		// keep the old behavior for backward compatibility
		if (log.isLoggable(Level.FINE)) log.fine("ZipSize=" + deflatedData.length);
		byte[] inflatedData = null;
		try {
			ByteArrayInputStream in = new ByteArrayInputStream(deflatedData);
			ZipInputStream zip = new ZipInputStream(in);
			ZipEntry entry = zip.getNextEntry();
			if (entry != null) // just one entry
			{
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				byte[] buffer = new byte[2048];
				int length = zip.read(buffer);
				while (length != -1) {
					out.write(buffer, 0, length);
					length = zip.read(buffer);
				}
				//
				inflatedData = out.toByteArray();
				if (log.isLoggable(Level.FINE)) log.fine("Size=" + inflatedData.length + " - zip=" + entry.getCompressedSize()
						+ "(" + entry.getSize() + ") "
						+ (entry.getCompressedSize() * 100 / entry.getSize()) + "%");
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "", e);
			inflatedData = null;
		}
		return inflatedData;		
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
						try (InputStream in = blob.getBinaryStream()) {
							ByteArrayOutputStream out = new ByteArrayOutputStream();
							byte[] buffer = new byte[2048];
							int length = 0;
							while ((length = in.read(buffer)) != -1) 
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
				
		boolean isExternal = deflatedData.length == marker.length;
		if (isExternal) {
			for(int i= 0; i < marker.length; i++) {
				if (deflatedData[i] != marker[i]) {
					isExternal = false;
					break;
				}
			}
		}
		
		if (isExternal) {
			return getExternalDataAsStream(archive);
		}
		
		return IArchiveStore.super.loadLOBDataAsStream(archive, prov);
	}

	/**
	 * Convert Blob stream to ByteArrayInputStream (if < 2MB) or FileInputStream depends on size
	 * @param blob
	 * @return ByteArrayInputStream or FileInputStream
	 * @throws IOException
	 */
	private InputStream blobToLocalInputStream(Blob blob) throws IOException {
		// If the blob is small enough, read it into memory
		try {
			if (blob.length() < (1024 * 1024 * 2)) { 
				try (InputStream inputStream = blob.getBinaryStream()) {
					ByteArrayOutputStream out = new ByteArrayOutputStream();
					byte[] buffer = new byte[2048];
					int length = 0;
					while ((length = inputStream.read(buffer)) != -1) {
						out.write(buffer, 0, length);
					}
					return new ByteArrayInputStream(out.toByteArray());
				}
			}
		} catch (SQLException e) {
			throw new DBException("Error reading blob data", e);
		} catch (IOException e) {
			throw new AdempiereException("Error reading blob data", e);
		}
		
		// If the blob is too large, write it to a temporary file
		Path tempDir = Files.createTempDirectory("archive_blob_");
		try (InputStream inputStream = blob.getBinaryStream()) {
			Path tempFile = tempDir.resolve("blob_data");
			Files.copy(inputStream, tempFile);
			return Files.newInputStream(tempFile);
		} catch (SQLException e) {
			throw new DBException("Error reading blob data", e);
		}
	}
	
	/**
	 * Get data stream from AD_Archive_Blob table
	 * @param archive
	 * @return InputStream of the archive data
	 */
	private InputStream getExternalDataAsStream(MArchive archive) {
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
						InputStream in = null;
						if (conn != null) {
							in = blobToLocalInputStream(blob);
						} else {
							in = blob.getBinaryStream();
						}
						return in;
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
	    	boolean updateBlob = false;
			try (PreparedStatement pstmt = conn != null 
					? DB.prepareStatement(conn, sql) 
					: DB.prepareStatement(sql, archive.get_TrxName())) {
				pstmt.setInt(1, archive.getAD_Archive_ID());
				try (ResultSet rs = pstmt.executeQuery()) {
					if (rs.next()) {
						updateBlob = true;
						Blob blob = rs.getBlob(1);
						try (OutputStream os = blob.setBinaryStream(1)) {
							byte[] buffer = new byte[2048];
							int length = 0;
							while ((length = inputStream.read(buffer)) != -1) {
								os.write(buffer, 0, length);
							}
						} finally {
							blob.free();
						}
						return;
					}
				}
			} catch (Exception e) {
				if (conn != null) {
					conn.rollback();
				}
				archive.setByteData(null);
				throw new RuntimeException(e);
			} finally {
				if (updateBlob && conn != null)
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
			try {
				try (PreparedStatement pstmt = conn != null 
						? DB.prepareStatement(conn, sql) 
						: DB.prepareStatement(sql, archive.get_TrxName())) {
					pstmt.setInt(1, archive.getAD_Archive_ID());
					if (inputStream != null)
						pstmt.setBlob(2, inputStream);
					else
						pstmt.setBlob(2, new ByteArrayInputStream(byteDatas));
					pstmt.executeUpdate();
					archive.setByteData(marker);
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
