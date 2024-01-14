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

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.stream.Collectors;

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
 *	Attachment Model.
 *	One Attachment can have multiple entries (usually stored as zip files).
 *	
 *  @author Jorg Janke
 *  
  * @author Silvano Trinchero
 *      <li>BF [ 2992291] MAttachment.addEntry not closing streams if an exception occur
 *        https://sourceforge.net/p/adempiere/bugs/2392/
 *
 *  @version $Id: MAttachment.java,v 1.4 2006/07/30 00:58:37 jjanke Exp $
 */
public class MAttachment extends X_AD_Attachment
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 5615231734722570658L;

	/**
	 * @param ctx
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @return attachment or null
	 */
	public static MAttachment get (Properties ctx, int AD_Table_ID, int Record_ID)
	{
		return get(ctx, AD_Table_ID, Record_ID, (String)null, (String)null);
	}
	
	/**
	 * 	Get Attachment (if there are more than one attachment, it gets the first in no specific order)
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *  @param trxName
	 *	@return attachment or null
	 */
	public static MAttachment get (Properties ctx, int AD_Table_ID, int Record_ID, String trxName)
	{
		return get(ctx, AD_Table_ID, Record_ID, (String)null, trxName);
	}	//	get
	
	/**
	 * 	Get Attachment (if there are more than one attachment, it gets the first in no specific order)
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param Record_UU record UUID
	 *  @param trxName
	 *	@return attachment or null
	 */
	public static MAttachment get (Properties ctx, int AD_Table_ID, int Record_ID, String Record_UU, String trxName)
	{
		StringBuilder whereClause = new StringBuilder("AD_Table_ID=?");
		List<Object> params = new ArrayList<Object>();
		params.add(AD_Table_ID);
		if (Record_ID > 0) {
			whereClause.append(" AND Record_ID=?");
			params.add(Record_ID);
		} else if (!Util.isEmpty(Record_UU)) {
			whereClause.append(" AND Record_UU=?");
			params.add(Record_UU);
		}
		if (params.size() == 1) {
			s_log.warning("Wrong call, no Record_ID neither Record_UU for AD_Table_ID=" + AD_Table_ID + " TrxName=" + trxName);
			return null;
		}
		MAttachment retValue = new Query(ctx, Table_Name, whereClause.toString(), trxName)
				.setParameters(params)
				.first();
		return retValue;
	}	//	get
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MAttachment.class);
	
	private MStorageProvider provider;
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Attachment_UU  UUID key
     * @param trxName Transaction
     */
    public MAttachment(Properties ctx, String AD_Attachment_UU, String trxName) {
        super(ctx, AD_Attachment_UU, trxName);
		initAttachmentStoreDetails(ctx, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Attachment_ID id
	 *	@param trxName transaction
	 */
	public MAttachment(Properties ctx, int AD_Attachment_ID, String trxName)
	{
		super (ctx, AD_Attachment_ID, trxName);
		initAttachmentStoreDetails(ctx, trxName);

	}	//	MAttachment

	/**
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param trxName transaction
	 *  @deprecated Use {@link MAttachment#MAttachment(Properties, int, int, String, String)} instead
	 */
	public MAttachment(Properties ctx, int AD_Table_ID, int Record_ID, String trxName)
	{
		this(ctx, AD_Table_ID, Record_ID, null, trxName);
		// Record_UU will be set in beforeSave
	}

	/**
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param Record_UU record UUID
	 *	@param trxName transaction
	 */
	public MAttachment(Properties ctx, int AD_Table_ID, int Record_ID, String Record_UU, String trxName)
	{
		this (ctx, (MAttachment.getID(AD_Table_ID, Record_ID, Record_UU) > 0 ? MAttachment.getID(AD_Table_ID, Record_ID, Record_UU) : 0), trxName);
		if (get_ID() == 0) {
			setAD_Table_ID (AD_Table_ID);
			setRecord_ID (Record_ID);
			setRecord_UU (Record_UU);
		}
	}	//	MAttachment

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAttachment(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		initAttachmentStoreDetails(ctx, trxName);
	}	//	MAttachment
	
	/**
	 * Copy constructor
	 * @param copy
	 */
	public MAttachment(MAttachment copy)
	{
		this(Env.getCtx(), 0, (String)null);
		copyPO(copy);
		this.m_items = copy.m_items != null ? copy.m_items.stream().map(MAttachmentEntry::new).collect(Collectors.toCollection(ArrayList::new)) : null;
	}
	
	/** Indicator for no data   */
	public static final String 	NONE = ".";
	/** Indicator for zip data  */
	public static final String 	ZIP = "zip";
	/** Indicator for xml data (store on file system) */
	public static final String 	XML = "xml";

	/**	List of Entry Data		*/
	public ArrayList<MAttachmentEntry> m_items = null;

	/** string replaces the attachment root in stored xml file
	 * to allow the changing of the attachment root. */
	public final String ATTACHMENT_FOLDER_PLACEHOLDER = "%ATTACHMENT_FOLDER%";
	
	/**
	 * Initialize storage provider
	 * @param ctx
	 * @param trxName
	 */
	private void initAttachmentStoreDetails(Properties ctx, String trxName)
	{
		if (is_new()) {
			MClientInfo clientInfo = MClientInfo.get(ctx, getAD_Client_ID());
			setStorageProvider(MStorageProvider.get(ctx, clientInfo.getAD_StorageProvider_ID()));
		} else {
			setStorageProvider(MStorageProvider.get(ctx, getAD_StorageProvider_ID()));
		}
	}
	
	/**
	 * 	Set Client Org
	 *	@param AD_Client_ID client
	 *	@param AD_Org_ID org
	 */
	@Override
	public void setClientOrg(int AD_Client_ID, int AD_Org_ID) 
	{
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
		initAttachmentStoreDetails(getCtx(), get_TrxName());
	}	//	setClientOrg

	/**
	 * 	Add to Text Msg
	 *	@param added text
	 */
	public void addTextMsg (String added)
	{
		String oldTextMsg = getTextMsg();
		if (oldTextMsg == null)
			setTextMsg (added);
		else if (added != null)
			setTextMsg (oldTextMsg + added);
	}	//	addTextMsg
	
	/**
	 * 	Get Text Msg
	 *	@return trimmed message
	 */
	@Override
	public String getTextMsg ()
	{
		String msg = super.getTextMsg ();
		if (msg == null)
			return null;
		return msg.trim();
	}	//	setTextMsg
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MAttachment[");
		sb.append(getAD_Attachment_ID()).append(",Title=").append(getTitle())
			.append(",Entries=").append(getEntryCount());
		for (int i = 0; i < getEntryCount(); i++)
		{
			if (i == 0)
				sb.append(":");
			else
				sb.append(",");
			sb.append(getEntryName(i));
		}
		sb.append("]");
		return sb.toString();
	}	//	toString

	/**
	 * 	Add new item to attachment
	 *	@param file file content of new item
	 *	@return true if added
	 */
	public boolean addEntry (File file)
	{
		
		if (file == null)
		{
			log.warning("No File");
			return false;
		}
		if (!file.exists() || file.isDirectory() || !file.canRead())
		{
			log.warning("not added - " + file
				+ ", Exists=" + file.exists() + ", Directory=" + file.isDirectory());
			return false;
		}
		if (log.isLoggable(Level.FINE)) log.fine("addEntry - " + file);
		//
		String name = file.getName();
		byte[] data = null;
		
		// F3P: BF [2992291] modified to be able to close streams in "finally" block 		
		
		FileInputStream fis = null;
		ByteArrayOutputStream os = null;
		
		try
		{
			fis = new FileInputStream (file);
			os = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024*8];   //  8kB
			int length = -1;
			while ((length = fis.read(buffer)) != -1)
				os.write(buffer, 0, length);
			
			data = os.toByteArray();			
		}
		catch (IOException ioe)
		{
			log.log(Level.SEVERE, "(file)", ioe);
		}
		finally
		{
			if(fis != null)
			{
				try { fis.close(); } catch (IOException ex) { log.log(Level.SEVERE, "(file)", ex); }; 
			}
							
			if(os != null)
			{
				try { os.close(); } catch (IOException ex) { log.log(Level.SEVERE, "(file)", ex); };
			}
		}
		
		return addEntry (name, data);
	}	//	addEntry

	/**
	 * 	Add new item to attachment
	 *	@param name name of new item
	 *	@param data data content of new item
	 *	@return true if added
	 */
	public boolean addEntry (String name, byte[] data)
	{
		if (name == null || data == null)
			return false;
		return addEntry (new MAttachmentEntry (name, data));	//	random index
	}	//	addEntry
	
	/**
	 * 	Add item to attachment
	 * 	@param item attachment entry
	 * 	@return true if added
	 */
	public boolean addEntry (MAttachmentEntry item)
	{
		boolean replaced = false;
		boolean retValue = false;
		if (item == null)
			return false;
		item.getData(); // in case of lazy load enforce reading
		if (m_items == null)
			loadLOBData();
		for (int i = 0; i < m_items.size(); i++) {
			String itemName = m_items.get(i).getName();
			// Filesystem (and store other plugins can) mark not found files surrounding it with ~
			// avoid duplicating the file in this case
			if (itemName.startsWith("~") && itemName.endsWith("~"))
				itemName = itemName.substring(1, itemName.length()-1);
			if (itemName.equals(item.getName()) ) {
				m_items.set(i, item);
				replaced = true;
			}
		}
		if (!replaced) {
			 retValue = m_items.add(item);
			 item.setIndex(m_items.size());
		}
		if (log.isLoggable(Level.FINE)) log.fine(item.toStringX());
		setBinaryData(new byte[0]); // ATTENTION! HEAVY HACK HERE... Else it will not save :(
		return retValue || replaced;
	}	//	addEntry

	/**
	 * 	Get Attachment Entry
	 * 	@param index index of the item
	 * 	@return Entry or null
	 */
	public MAttachmentEntry getEntry (int index)
	{
		if (m_items == null)
			loadLOBData();
		if (index < 0 || index >= m_items.size())
			return null;
		return (MAttachmentEntry)m_items.get(index);
	}	//	getEntry
	
	/**
	 * 	Get Attachment Entries as array
	 * 	@return array of attachment item or null
	 */
	public MAttachmentEntry[] getEntries ()
	{
		if (m_items == null)
			loadLOBData();
		MAttachmentEntry[] retValue = new MAttachmentEntry[m_items.size()];
		m_items.toArray (retValue);
		return retValue;
	}	//	getEntries
	
	/**
	 * Delete Entry
	 * 
	 * @param index
	 *            index of item to delete
	 * @return true if deleted
	 */
	public boolean deleteEntry(int index) {
		if (m_items == null)
			loadLOBData();
		if (index >= 0 && index < m_items.size()) {
			IAttachmentStore prov = provider.getAttachmentStore();
			if (prov != null)
			{
				if(prov.deleteEntry(this,provider,index))
					return set_ValueNoCheck("Updated", new Timestamp(System.currentTimeMillis()));
				return false;
			}
			return false;
		}
		log.warning("Not deleted Index=" + index + " - Size=" + m_items.size());
		return false;
	} // deleteEntry
	
	/**
	 * 	Get Entry Count
	 *	@return number of entries
	 */
	public int getEntryCount()
	{
		if (m_items == null)
			loadLOBData();
		return m_items.size();
	}	//	getEntryCount
		
	/**
	 * Get Entry Name
	 * 
	 * @param index
	 *            index of item
	 * @return name or null
	 */
	public String getEntryName(int index) {
		String method=provider.getMethod();
		if(method == null)
			method="DB";
		MAttachmentEntry item = getEntry(index);
		if (item != null){
			//strip path
			String name = item.getName();
			if(name!=null && "FileSystem".equals(method)){
				name = name.substring(name.lastIndexOf(File.separator)+1);
			}
			return name;
		}
		return null;
	} // getEntryName

	/**
	 * 	Dump Entry Names to standard out
	 */
	public void dumpEntryNames()
	{
		if (m_items == null)
			loadLOBData();
		if (m_items == null || m_items.size() == 0)
		{
			System.out.println("- no entries -");
			return;
		}
		StringBuilder msgout = new StringBuilder("- entries: ").append(m_items.size());
		System.out.println(msgout.toString());
		for (int i = 0; i < m_items.size(); i++){
			msgout = new StringBuilder("  - ").append(getEntryName(i));
			System.out.println(msgout.toString());
		}	
	}	//	dumpEntryNames

	/**
	 * 	Get Entry Data
	 * 	@param index index of item
	 * 	@return data or null
	 */
	public byte[] getEntryData (int index)
	{
		MAttachmentEntry item = getEntry(index);
		if (item != null)
			return item.getData();
		return null;
	}	//	getEntryData
	
	/**
	 * 	Get Entry File with name
	 * 	@param index index of item
	 *	@param fileName optional file name
	 *	@return file or null
	 */	
	public File getEntryFile (int index, String fileName)
	{
		MAttachmentEntry item = getEntry(index);
		if (item != null)
			return item.getFile(fileName);
		return null;
	}	//	getEntryFile

	/**
	 * 	Get Entry File with name
	 * 	@param index index of item
	 *	@param file file
	 *	@return file or null
	 */	
	public File getEntryFile (int index, File file)
	{
		MAttachmentEntry item = getEntry(index);
		if (item != null)
			return item.getFile(file);
		return null;
	}	//	getEntryFile

	/**
	 * 	Save attachment content through storage provider
	 *	@return true if saved
	 */
	private boolean saveLOBData()
	{
		IAttachmentStore prov = provider.getAttachmentStore();
		if (prov != null)
			return prov.save(this,provider);
		return false;
	}
	
	/**
	 * 	Ask storage provider to load attachment data into local m_data
	 *	@return true if success
	 */
	private boolean loadLOBData ()
	{
		IAttachmentStore prov = provider.getAttachmentStore();
		if (prov != null)
			return prov.loadLOBData(this,provider);
		return false;
	}

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true if can be saved
	 */
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (Util.isEmpty(getTitle()))
			setTitle(NONE);
		if (getRecord_ID() > 0 && getAD_Table_ID() > 0 && Util.isEmpty(getRecord_UU())) {
			MTable table = MTable.get(getAD_Table_ID());
			PO po = table.getPO(getRecord_ID(), get_TrxName());
			if (po != null)
				setRecord_UU(po.get_UUID());
		}
		return saveLOBData();		//	save in BinaryData
	}	//	beforeSave

	/**
	 * 	Ask storage provider to remove attachment content
	 *	@return true if saved
	 */
	@Override
	protected boolean postDelete()
	{
		if (m_items == null)
			loadLOBData();
		IAttachmentStore prov = provider.getAttachmentStore();
		if (prov != null)
			return prov.delete(this,provider);
		return true;
	} 	//	postDelete
	
	/**
	 * Update existing entry
	 * @param i index of item
	 * @param file file content of item
	 * @return true if success, false otherwise
	 */
	public boolean updateEntry(int i, File file) 
	{
		if (file == null)
		{
			log.warning("No File");
			return false;
		}
		if (!file.exists() || file.isDirectory() || !file.canRead())
		{
			log.warning("not added - " + file
				+ ", Exists=" + file.exists() + ", Directory=" + file.isDirectory());
			return false;
		}
		if (log.isLoggable(Level.FINE)) log.fine("updateEntry - " + file);
		//
		byte[] data = null;
		try
		{
			FileInputStream fis = new FileInputStream (file);
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024*8];   //  8kB
			int length = -1;
			while ((length = fis.read(buffer)) != -1)
				os.write(buffer, 0, length);
			fis.close();
			data = os.toByteArray();
			os.close();
		}
		catch (IOException ioe)
		{
			log.log(Level.SEVERE, "(file)", ioe);
		}
		return updateEntry (i, data);
		
	}
	
	/**
	 * Update existing entry
	 * @param i index of item
	 * @param data byte[] content of item 
	 * @return true if success, false otherwise
	 */
	public boolean updateEntry(int i, byte[] data)
	{
		MAttachmentEntry entry = getEntry(i);
		if (entry == null) return false;
		entry.setData(data);
		entry.setUpdated(true);
		return true;
	}

	/**
	 * IDEMPIERE-530
	 * Get the attachment ID based on table_id and record_id
	 * @param Table_ID
	 * @param Record_ID
	 * @return AD_Attachment_ID
 	 * @deprecated Use {@link MAttachment#getID(int, int, String)} instead
	 */
	public static int getID(int Table_ID, int Record_ID) {
		String sql="SELECT AD_Attachment_ID FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID=?";
		int attachid = DB.getSQLValue(null, sql, Table_ID, Record_ID);
		return attachid;
	}

	/**
	 * IDEMPIERE-530
	 * Get the attachment ID based on table_id and record_uu
	 * @param Table_ID
	 * @param Record_ID
	 * @param Record_UU record UUID
	 * @return AD_Attachment_ID 
	 */
	public static int getID(int Table_ID, int Record_ID, String Record_UU) {
		if (Util.isEmpty(Record_UU))
			return getID(Table_ID, Record_ID);
		String sql="SELECT AD_Attachment_ID FROM AD_Attachment WHERE AD_Table_ID=? AND Record_UU=?";
		int attachid = DB.getSQLValue(null, sql, Table_ID, Record_UU);
		return attachid;
	}

	/**
	 * Save attachment as zip file
	 * @return zip file
	 */
	public File saveAsZip() {
		if (getEntryCount() < 1) {
			return null;
		}

		String name = MTable.get(Env.getCtx(), getAD_Table_ID()).getTableName() + "_"
				+ (getRecord_ID() > 0 ? getRecord_ID() : getRecord_UU());

		File tempfolder = null; 
		try {
			Path tempPath = Files.createTempDirectory(name);
			tempfolder = tempPath.toFile();
		} catch (IOException e1) {
			throw new AdempiereException("Unable to create temp folder", e1);
		}

		File destZipFile = null;
		try {
			destZipFile = File.createTempFile(name, ".zip");
		} catch (Throwable e) {
			throw new AdempiereException("Unable to create temp file", e);
		}
		destZipFile.delete();

		MAttachmentEntry[] entries = getEntries();
		MAttachmentEntry entry = null;
		int index = 0;

		for (int i = 0; i < entries.length; i++) {
			entry = entries[i];
			index = i;
			File destinationFile = new File(tempfolder, entry.getName());
			FileUtil.copy(this, destinationFile, index);
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
	 * Set Storage Provider.
	 * Used temporarily by the storage migration process to migrate storage provider.
	 * @param p Storage provider
	 */
	public void setStorageProvider(MStorageProvider p) {
		provider = p;
		setAD_StorageProvider_ID(p.getAD_StorageProvider_ID());
	}

}	//	MAttachment
