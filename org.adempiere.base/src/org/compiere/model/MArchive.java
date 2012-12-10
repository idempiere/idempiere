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
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Archive Model
 * 
 * @author Jorg Janke
 * @version $Id: MArchive.java,v 1.3 2006/07/30 00:58:36 jjanke Exp $
 */
public class MArchive extends X_AD_Archive {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3217541537768473865L;

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
		ArrayList<MArchive> list = new ArrayList<MArchive>();
		PreparedStatement pstmt = null;
		StringBuilder sql = new StringBuilder("SELECT * FROM AD_Archive WHERE AD_Client_ID=?");
		if (whereClause != null && whereClause.length() > 0)
			sql.append(whereClause);
		sql.append(" ORDER BY Created");

		try {
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, Env.getAD_Client_ID(ctx));
			ResultSet rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MArchive(ctx, rs, null));
			rs.close();
			pstmt.close();
			pstmt = null;
		} catch (Exception e) {
			s_log.log(Level.SEVERE, sql.toString(), e);
		}
		try {
			if (pstmt != null)
				pstmt.close();
			pstmt = null;
		} catch (Exception e) {
			pstmt = null;
		}
		if (list.size() == 0)
			s_log.fine(sql.toString());
		else
			s_log.finer(sql.toString());
		//
		MArchive[] retValue = new MArchive[list.size()];
		list.toArray(retValue);
		return retValue;
	} // get

	/** Logger */
	private static CLogger s_log = CLogger.getCLogger(MArchive.class);

	/***************************************************************************
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
		setC_BPartner_ID(info.getC_BPartner_ID());
	} // MArchive

	public MStorageProvider provider;
	/**
	 * Get the isStoreArchiveOnFileSystem and archivePath for the client.
	 * 
	 * @param ctx
	 * @param trxName
	 */
	private void initArchiveStoreDetails(Properties ctx, String trxName) {
		MClientInfo clientInfo = MClientInfo.get(ctx);
		provider=new MStorageProvider(ctx, clientInfo.getStorageArchive_ID(), trxName);		
	}

	/**
	 * String Representation
	 * 
	 * @return info
	 */
	public String toString() {
		StringBuilder sb = new StringBuilder("MArchive[");
		sb.append(get_ID()).append(",Name=").append(getName());
		sb.append("]");
		return sb.toString();
	} // toString

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
	 * Save Binary Data to file system or db.
	 * 
	 * @param inflatedData
	 *            inflated data
	 */
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
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, getCreatedBy());
			ResultSet rs = pstmt.executeQuery();
			if (rs.next())
				name = rs.getString(1);
			rs.close();
			pstmt.close();
			pstmt = null;
		} catch (Exception e) {
			log.log(Level.SEVERE, sql, e);
		}
		try {
			if (pstmt != null)
				pstmt.close();
			pstmt = null;
		} catch (Exception e) {
			pstmt = null;
		}
		return name;
	} // getCreatedByName

	/**
	 * Returns the archive path (snippet), containing client, org and archive
	 * id. The process, table and record id are only included when they are not
	 * null.
	 * 
	 * @return String
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
		}
		// path = path + this.get_ID() + ".pdf";
		return path.toString();
	}

	public byte[] getByteData(){
		return super.getBinaryData();
	}
	
	public void setByteData(byte[] BinaryData){
		super.setBinaryData(BinaryData);
	}

	/**
	 * Before Save
	 * 
	 * @param newRecord
	 *            new
	 * @return true if can be saved
	 */
	protected boolean beforeSave(boolean newRecord) {
		// Binary Data is Mandatory
		byte[] data = super.getBinaryData();
		if (data == null || data.length == 0)
			return false;
		//
		log.fine(toString());
		return true;
	} // beforeSave
	
	protected boolean beforeDelete ()
	{
		IArchiveStore prov = provider.getArchiveStore();
		if (prov != null)
			return prov.deleteArchive(this,provider);
		return true;
		
	}

} // MArchive
