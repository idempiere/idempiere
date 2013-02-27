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
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.MimeType;


/**
 *	Attachment Model.
 *	One Attachment can have multiple entries
 *	
 *  @author Jorg Janke
 *  
  * @author Silvano Trinchero
 *      <li>BF [ 2992291] MAttachment.addEntry not closing streams if an exception occur
 *        http://sourceforge.net/tracker/?func=detail&aid=2992291&group_id=176962&atid=879332
 *
 *  @version $Id: MAttachment.java,v 1.4 2006/07/30 00:58:37 jjanke Exp $
 */
public class MAttachment extends X_AD_Attachment
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8261865873158774665L;

	/**
	 * 
	 * @param ctx
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @return attachment or null
	 */
	public static MAttachment get (Properties ctx, int AD_Table_ID, int Record_ID)
	{
		return get(ctx, AD_Table_ID, Record_ID, (String)null);
	}
	
	/**
	 * 	Get Attachment (if there are more than one attachment it gets the first in no specific order)
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *  @param trxName
	 *	@return attachment or null
	 */
	public static MAttachment get (Properties ctx, int AD_Table_ID, int Record_ID, String trxName)
	{
		final String whereClause = I_AD_Attachment.COLUMNNAME_AD_Table_ID+"=? AND "+I_AD_Attachment.COLUMNNAME_Record_ID+"=?";
		MAttachment retValue = new Query(ctx,I_AD_Attachment.Table_Name,whereClause, trxName)
		.setParameters(AD_Table_ID, Record_ID)
		.first();
		return retValue;
	}	//	get
	
	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MAttachment.class);
	
	private MStorageProvider provider;

	
	/**************************************************************************
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
	 * 	New Constructor
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param trxName transaction
	 */
	public MAttachment(Properties ctx, int AD_Table_ID, int Record_ID, String trxName)
	{
		this (ctx, MAttachment.getID(AD_Table_ID, Record_ID) > 0 ? MAttachment.getID(AD_Table_ID, Record_ID) : 0, trxName);
		if (get_ID() == 0) {
			setAD_Table_ID (AD_Table_ID);
			setRecord_ID (Record_ID);
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
	 * Get the isStoreAttachmentsOnFileSystem and attachmentPath for the client.
	 * @param ctx
	 * @param trxName
	 */
	private void initAttachmentStoreDetails(Properties ctx, String trxName)
	{
		MClientInfo clientInfo = MClientInfo.get(ctx);
		provider=new MStorageProvider(ctx, clientInfo.getAD_StorageProvider_ID(), trxName);		
	}
	
	/**
	 * 	Set Client Org
	 *	@param AD_Client_ID client
	 *	@param AD_Org_ID org
	 */
	public void setClientOrg(int AD_Client_ID, int AD_Org_ID) 
	{
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
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
	 * 	Add new Data Entry
	 *	@param file file
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
	 * 	Add new Data Entry
	 *	@param name name
	 *	@param data data
	 *	@return true if added
	 */
	public boolean addEntry (String name, byte[] data)
	{
		if (name == null || data == null)
			return false;
		return addEntry (new MAttachmentEntry (name, data));	//	random index
	}	//	addEntry
	
	/**
	 * 	Add Entry
	 * 	@param item attachment entry
	 * 	@return true if added
	 */
	public boolean addEntry (MAttachmentEntry item)
	{
		boolean replaced = false;
		boolean retValue = false;
		if (item == null)
			return false;
		if (m_items == null)
			loadLOBData();
		for (int i = 0; i < m_items.size(); i++) {
			if (m_items.get(i).getName().equals(item.getName()) ) {
				m_items.set(i, item);
				replaced = true;
			}
		}
		if (!replaced) {
			 retValue = m_items.add(item);
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
	 * 	@return array or null
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
	 *            index
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
	 *            index
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
	 * 	Dump Entry Names
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
	 * 	@param index index
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
	 * 	@param index index
	 *	@param fileName optional file name
	 *	@return file
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
	 * 	@param index index
	 *	@param file file
	 *	@return file
	 */	
	public File getEntryFile (int index, File file)
	{
		MAttachmentEntry item = getEntry(index);
		if (item != null)
			return item.getFile(file);
		return null;
	}	//	getEntryFile

	/**
	 * 	Save Entry Data in Zip File format
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
	 * 	Load Data into local m_data
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
	protected boolean beforeSave (boolean newRecord)
	{
		return saveLOBData();		//	save in BinaryData
	}	//	beforeSave

	/**
	 * 	Executed before Delete operation.
	 *	@return true if record can be deleted
	 */
	protected boolean beforeDelete ()
	{
		return deleteLOBData();
	}
	
	/**
	 * 	Delete Entry Data in Zip File format
	 *	@return true if saved
	 */
	private boolean deleteLOBData()
	{
		if (m_items == null)
			loadLOBData();
		IAttachmentStore prov = provider.getAttachmentStore();
		if (prov != null)
			return prov.delete(this,provider);
		return false;
	} 	//	beforeDelete
	
	/**************************************************************************
	 * 	Test
	 *	@param args ignored
	 */
	public static void main (String[] args)
	{
	//	System.setProperty("javax.activation.debug", "true");
	
		System.out.println(MimeType.getMimeType("data.xls"));
		System.out.println(MimeType.getMimeType("data.cvs"));
		System.out.println(MimeType.getMimeType("data.txt"));
		System.out.println(MimeType.getMimeType("data.log"));
		System.out.println(MimeType.getMimeType("data.html"));
		System.out.println(MimeType.getMimeType("data.htm"));
		System.out.println(MimeType.getMimeType("data.png"));
		System.out.println(MimeType.getMimeType("data.gif"));
		System.out.println(MimeType.getMimeType("data.jpg"));
		System.out.println(MimeType.getMimeType("data.xml"));
		System.out.println(MimeType.getMimeType("data.rtf"));

		System.exit(0);
		
		org.compiere.Adempiere.startupEnvironment(true);
		MAttachment att = new MAttachment(Env.getCtx(), 100, 0, null);
		att.addEntry(new File ("C:\\Adempiere\\Dev.properties"));
		att.addEntry(new File ("C:\\Adempiere\\index.html"));
		att.saveEx();
		System.out.println (att);
		att.dumpEntryNames();
		int AD_Attachment_ID = att.getAD_Attachment_ID();
		//
		System.out.println ("===========================================");
		att = new MAttachment (Env.getCtx(), AD_Attachment_ID, null);
		System.out.println (att);
		att.dumpEntryNames();
		System.out.println ("===========================================");
		MAttachmentEntry[] entries = att.getEntries();
		for (int i = 0; i < entries.length; i++)
		{
			MAttachmentEntry entry = entries[i];
			entry.dump();
		}
		System.out.println ("===========================================");
		att.delete(true);		
	}	//	main

	/**
	 * Update existing entry
	 * @param i
	 * @param file
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
	 * @param i
	 * @param data
	 * @return true if success, false otherwise
	 */
	public boolean updateEntry(int i, byte[] data)
	{
		MAttachmentEntry entry = getEntry(i);
		if (entry == null) return false;
		entry.setData(data);
		return true;
	}

	/**
	 * IDEMPIERE-530
	 * Get the attachment ID based on table_id and record_id
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @return AD_Attachment_ID 
	 */
	public static int getID(int Table_ID, int Record_ID) {
		String sql="SELECT AD_Attachment_ID FROM AD_Attachment WHERE AD_Table_ID=? AND Record_ID=?";
		int attachid = DB.getSQLValue(null, sql, Table_ID, Record_ID);
		return attachid;
	}

}	//	MAttachment
