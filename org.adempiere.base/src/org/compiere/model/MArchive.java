/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Target;
import org.apache.tools.ant.taskdefs.Zip;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Archive Model
 * 
 * @author Jorg Janke
 * @version $Id: MArchive.java,v 1.3 2006/07/30 00:58:36 jjanke Exp $
 */
public class MArchive extends X_AD_Archive {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1195510484179775189L;

	/**
	 * Get Archives
	 * 
	 * @param ctx
	 *            context
	 * @param whereClause
	 *            optional where clause (starting with AND)
	 * @return archives
	 */
	public static MArchive[] get(Properties ctx, String whereClause) {
		return get(ctx, whereClause, null);
	}
	
	/**
	 * Get Archives
	 * 
	 * @param ctx
	 *            context
	 * @param whereClause
	 *            optional where clause (starting with AND)
	 * @param trxName optional trx name
	 * @return archives
	 */
	public static MArchive[] get(Properties ctx, String whereClause, String trxName) {
		StringBuilder sql = new StringBuilder("AD_Client_ID=?");
		if (!Util.isEmpty(whereClause))
			sql.append(whereClause);

		List<MArchive> list = new Query(ctx, Table_Name, sql.toString(),trxName)
				.setParameters(Env.getAD_Client_ID(ctx))
				.setOrderBy(COLUMNNAME_Created)
				.list();

		if (list.size() == 0)
			s_log.fine(sql.toString());
		else
			if (s_log.isLoggable(Level.FINER)) s_log.finer(sql.toString());
		//
		MArchive[] retValue = new MArchive[list.size()];
		list.toArray(retValue);
		return retValue;
	} // get

	/** Logger */
	private static CLogger s_log = CLogger.getCLogger(MArchive.class);

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Archive_UU  UUID key
     * @param trxName Transaction
     */
    public MArchive(Properties ctx, String AD_Archive_UU, String trxName) {
        super(ctx, AD_Archive_UU, trxName);
		initArchiveStoreDetails(ctx, trxName);
    }

	/**
	 * Standard Constructor
	 * 
	 * @param ctx
	 *            context
	 * @param AD_Archive_ID
	 *            id
	 * @param trxName
	 *            transaction
	 */
	public MArchive(Properties ctx, int AD_Archive_ID, String trxName) {
		super(ctx, AD_Archive_ID, trxName);
		initArchiveStoreDetails(ctx, trxName);
	} // MArchive

	/**
	 * Load Constructor
	 * 
	 * @param ctx
	 *            context
	 * @param rs
	 *            result set
	 * @param trxName
	 *            transaction
	 */
	public MArchive(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
		initArchiveStoreDetails(ctx, trxName);
	} // MArchive

	/**
	 * Constructor
	 * 
	 * @param ctx
	 *            context
	 * @param info
	 *            print info
	 * @param trxName
	 *            transaction
	 */
	public MArchive(Properties ctx, PrintInfo info, String trxName) {
		this(ctx, 0, trxName);
		setName(info.getName());
		setIsReport(info.isReport());
		//
		setAD_Process_ID(info.getAD_Process_ID());
		setAD_Table_ID(info.getAD_Table_ID());
		setRecord_ID(info.getRecord_ID());
		setRecord_UU(info.getRecord_UU());
		setC_BPartner_ID(info.getC_BPartner_ID());
	} // MArchive

	protected MStorageProvider provider;
	
	/**
	 * Initialize storage provider
	 * 
	 * @param ctx
	 * @param trxName
	 */
	private void initArchiveStoreDetails(Properties ctx, String trxName) {
		if (is_new()) {
			MClientInfo clientInfo = MClientInfo.get(ctx, getAD_Client_ID());
			setStorageProvider(MStorageProvider.get(ctx, clientInfo.getStorageArchive_ID()));
		} else {
			setStorageProvider(MStorageProvider.get(ctx, getAD_StorageProvider_ID()));
		}
	}

	/**
	 * String Representation
	 * 
	 * @return info
	 */
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("MArchive[");
		sb.append(get_ID()).append(",Name=").append(getName());
		sb.append("]");
		return sb.toString();
	} // toString

	/**
	 * Get data as byte[] from storage provider
	 * 
	 * @return byte[] or null
	 */
	@Override
	public byte[] getBinaryData() {		
		IArchiveStore prov = provider.getArchiveStore();
		if (prov != null)
			return prov.loadLOBData(this,provider);
		return null;
	}

	/**
	 * Get Data as Input Stream
	 * 
	 * @return input stream or null
	 */
	public InputStream getInputStream() {
		byte[] inflatedData = getBinaryData();
		if (inflatedData == null)
			return null;
		return new ByteArrayInputStream(inflatedData);
	} // getInputStream

	/**
	 * Save Binary Data through storage provider
	 * 
	 * @param inflatedData
	 *            inflated data
	 */
	@Override
	public void setBinaryData(byte[] inflatedData) {
		IArchiveStore prov = provider.getArchiveStore();
		if (prov != null)
			 prov.save(this,provider,inflatedData);
	}

	/**
	 * Get Created By (User) Name
	 * 
	 * @return name
	 */
	public String getCreatedByName() {
		String name = "?";
		String sql = "SELECT Name FROM AD_User WHERE AD_User_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, getCreatedBy());
			rs = pstmt.executeQuery();
			if (rs.next())
				name = rs.getString(1);
		} catch (Exception e) {
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		return name;
	} // getCreatedByName

	/**
	 * Returns the archive path (snippet), containing client, org and archive
	 * id. The process, table and record id are only included when they are not
	 * null.
	 * 
	 * @return archive path
	 */
	public String getArchivePathSnippet() {
		StringBuilder path = new StringBuilder().append(this.getAD_Client_ID()).append(File.separator).append(this.getAD_Org_ID())
				.append(File.separator);
		if (this.getAD_Process_ID() > 0) {
			path.append(this.getAD_Process_ID()).append(File.separator);
		}
		if (this.getAD_Table_ID() > 0) {
			path.append(this.getAD_Table_ID()).append(File.separator);
		}
		if (this.getRecord_ID() > 0) {
			path.append(this.getRecord_ID()).append(File.separator);
		} else if (!Util.isEmpty(this.getRecord_UU())) {
			path.append(this.getRecord_UU()).append(File.separator);
		}

		return path.toString();
	}

	/**
	 * Get byte data from BinaryData column.
	 * Usually, your code should call getBinaryData() instead (using provider).
	 * @return byte[]
	 */
	public byte[] getByteData(){
		return super.getBinaryData();
	}
	
	/**
	 * Store byte data to BinaryData column.
	 * Usually, your code should call setBinaryData() instead (using provider).
	 * @param BinaryData
	 */
	public void setByteData(byte[] BinaryData){
		super.setBinaryData(BinaryData);
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Binary Data is Mandatory
		byte[] data = super.getBinaryData();
		if (data == null || data.length == 0)
			return false;
		// Set Record_UU from Record_ID
		if (getRecord_ID() > 0 && getAD_Table_ID() > 0 && Util.isEmpty(getRecord_UU())) {
			MTable table = MTable.get(getAD_Table_ID());
			PO po = table.getPO(getRecord_ID(), get_TrxName());
			if (po != null)
				setRecord_UU(po.get_UUID());
		}
		//
		if (log.isLoggable(Level.FINE)) log.fine(toString());
		return true;
	} // beforeSave
	
	/**
	 * Ask provider to remove archive content
	 */
	@Override
	protected boolean postDelete()
	{
		IArchiveStore prov = provider.getArchiveStore();
		if (prov != null)
			return prov.deleteArchive(this,provider);
		return true;
		
	}

	/**
	 * Ask provider to flush buffer data (if any)
	 */
	@Override
	protected void saveNew_afterSetID()
	{
		IArchiveStore prov = provider.getArchiveStore();
		if (prov != null && prov.isPendingFlush())
			 prov.flush(this,provider);
	}

	/**
	 * Set Storage Provider.
	 * Also used temporarily for the migration of storage provider.
	 * @param p Storage provider
	 */
	public void setStorageProvider(MStorageProvider p) {
		provider = p;
		setAD_StorageProvider_ID(p.getAD_StorageProvider_ID());
	}

	/**
	 * Save the Archive as zip file, used by Pack Out when storage provider is not DB
	 * @return File - the temporary file
	 */
	public File saveAsZip() {
		StringBuilder name = new StringBuilder(MTable.get(Env.getCtx(), getAD_Table_ID()).getTableName())
				.append("_");
		if (getRecord_ID() > 0)
			name.append(getRecord_ID()).append("_");
		else if (!Util.isEmpty(getRecord_UU()))
			name.append(getRecord_UU()).append("_");

		File tempfolder = null; 
		try {
			Path tempPath = Files.createTempDirectory(name.toString());
			tempfolder = tempPath.toFile();
		} catch (IOException e1) {
			throw new AdempiereException("Unable to create temp folder", e1);
		}

		File destZipFile = null;
		try {
			destZipFile = File.createTempFile("IdempiereArchive", ".zip");
		} catch (Throwable e) {
			throw new AdempiereException("Unable to create temp file", e);
		}
		destZipFile.delete();

		File destArchiveFile = null;
		try {
			destArchiveFile = File.createTempFile("IdempiereArchive", ".pdf", tempfolder);
		} catch (Throwable e) {
			throw new AdempiereException("Unable to create temp file", e);
		}
		destArchiveFile.delete();

		Path path = destArchiveFile.toPath();
		try {
			Files.write(path, getBinaryData());
		} catch (IOException e1) {
			throw new AdempiereException(e1);
		}
		
		Zip zipper = new Zip();
		zipper.setDestFile(destZipFile);
		zipper.setBasedir(tempfolder);
		zipper.setUpdate(true);
		zipper.setCompress(true);
		zipper.setCaseSensitive(false);
		zipper.setFilesonly(true);
		zipper.setTaskName("zip");
		zipper.setTaskType("zip");
		zipper.setProject(new Project());
		zipper.setOwningTarget(new Target());
		zipper.execute();

		try {
			FileUtil.deleteDirectory(tempfolder);
		} catch (IOException e) {}
		
		return destZipFile;
	}

	/**
	 * Get number of document and report archive by table and record id
	 * 
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param trxName
	 * @return int[], [0] = report count and [1] = document count
	 * @deprecated - use {@link #getReportAndDocumentCountByRecordId(int, int, String, String)} instead
	 */
	@Deprecated
	public static int[] getReportAndDocumentCountByRecordId(int AD_Table_ID, int Record_ID, String trxName) {
		return getReportAndDocumentCountByRecordId(AD_Table_ID, Record_ID, null, trxName);
	}

	/**
	 * Get number of document and report archive by table and record UUID
	 * 
	 * @param AD_Table_ID
	 * @param Record_ID - record ID used when UUID is empty, or as C_BPartner_ID when searching for C_BPartner
	 * @param Record_UU - record UUID
	 * @param trxName
	 * @return int[], [0] = report count and [1] = document count
	 */
	public static int[] getReportAndDocumentCountByRecordId(int AD_Table_ID, int Record_ID, String Record_UU, String trxName) {
		int reportCount = 0;
		int documentCount = 0;
		StringBuilder sql = new StringBuilder("SELECT IsReport, COUNT(*) FROM AD_Archive ");
		if (Util.isEmpty(Record_UU))
			sql.append("WHERE (AD_Table_ID=? AND Record_ID=?) ");
		else
			sql.append("WHERE (AD_Table_ID=? AND Record_UU=?) ");
		if (AD_Table_ID == MBPartner.Table_ID)
			sql.append(" OR C_BPartner_ID=?");
		sql.append(" GROUP BY IsReport"); 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), trxName);
			pstmt.setInt(1, AD_Table_ID);
			if (Util.isEmpty(Record_UU))
				pstmt.setInt(2, Record_ID);
			else
				pstmt.setString(2, Record_UU);
			if (AD_Table_ID == MBPartner.Table_ID)
				pstmt.setInt(3, Record_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				if ("Y".equals(rs.getString(1)))
					reportCount += rs.getInt(2);
				else
					documentCount += rs.getInt(2);
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		return new int[] {reportCount, documentCount};
	}
	
	/**
	 * Get number of report archive by table id
	 * 
	 * @param AD_Table_ID
	 * @param trxName
	 * @return Number of report archive for AD_Table_ID
	 */
	public static int getReportCountByTableId(int AD_Table_ID, String trxName) {
		final String sql = "SELECT COUNT(*) FROM AD_Archive WHERE AD_Table_ID=? AND IsReport='Y'";
		return DB.getSQLValueEx(trxName, sql, AD_Table_ID);
	}
} // MArchive
