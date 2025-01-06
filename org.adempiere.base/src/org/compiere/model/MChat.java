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

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Properties;

import org.apache.ecs.xhtml.b;
import org.apache.ecs.xhtml.hr;
import org.apache.ecs.xhtml.p;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Util;

/**
 * 	Chat Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MChat.java,v 1.4 2006/07/30 00:51:05 jjanke Exp $
 */
public class MChat extends X_CM_Chat
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1188256932717048308L;

	/**
	 * 	Get Chats Of Table - of client in context
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@return array of chats
	 */
	public static MChat[] getOfTable (Properties ctx, int AD_Table_ID)
	{
		List<MChat> list = new Query(ctx, Table_Name, "AD_Table_ID=?", null)
				.setClient_ID()
				.setParameters(AD_Table_ID)
				.setOrderBy(COLUMNNAME_Record_ID)
				.list();
		//
		MChat[] retValue = new MChat[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	get

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param CM_Chat_UU  UUID key
     * @param trxName Transaction
     */
    public MChat(Properties ctx, String CM_Chat_UU, String trxName) {
        super(ctx, CM_Chat_UU, trxName);
		if (Util.isEmpty(CM_Chat_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param CM_Chat_ID id
	 *	@param trxName transaction
	 */
	public MChat (Properties ctx, int CM_Chat_ID, String trxName)
	{
		super (ctx, CM_Chat_ID, trxName);
		if (CM_Chat_ID == 0)
			setInitialDefaults();
	}	//	MChat

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setConfidentialType (CONFIDENTIALTYPE_PublicInformation);
		setModerationType (MODERATIONTYPE_NotModerated);
	}

	/**
	 * 	Full Constructor
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param Description description
	 *	@param trxName transaction
	 */
	public MChat (Properties ctx, int AD_Table_ID, int Record_ID, 
		String Description, String trxName)
	{
		this (ctx, 0, trxName);
		setAD_Table_ID (AD_Table_ID);
		setRecord_ID (Record_ID);
		setDescription (Description);
	}	//	MChat

	/**
	 * 	Full Constructor
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param Record_UU record UUI
	 *	@param Description description
	 *	@param trxName transaction
	 */
	public MChat (Properties ctx, int AD_Table_ID, int Record_ID, String Record_UU,
		String Description, String trxName)
	{
		this (ctx, 0, trxName);
		setAD_Table_ID (AD_Table_ID);
		setRecord_ID (Record_ID);
		setRecord_UU (Record_UU);
		setDescription (Description);
	}	//	MChat

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MChat (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MChat
	
	/**	The Lines						*/
	private MChatEntry[] 		m_entries = null;
	/**	Date Format						*/
	private SimpleDateFormat	m_format = null;
		
	/**
	 *	Get Entries
	 *	@param reload reload data
	 *	@return array of chat entries
	 */
	public MChatEntry[] getEntries (boolean reload)
	{
		if (m_entries != null && !reload)
			return m_entries;
		List<MChatEntry> list = new Query(getCtx(), MChatEntry.Table_Name, "CM_Chat_ID=?", null)
				.setParameters(getCM_Chat_ID())
				.setOrderBy(COLUMNNAME_Created)
				.list();
		//
		m_entries = new MChatEntry[list.size ()];
		list.toArray (m_entries);
		return m_entries;
	}	// getEntries

	
	/**
     * Set Description
     * 
     * @param Description
     */
	public void setDescription (String Description)
	{
		if (Description != null && Description.length() > 0)
			super.setDescription (Description);
		else{
			StringBuilder msgsd = new StringBuilder().append(getAD_Table_ID()).append("#").append(getRecord_ID());
			super.setDescription (msgsd.toString());
		}	
	}	//	setDescription
	
	/**
	 * 	Get History as html paragraph
	 * 	@param ConfidentialType confidentiality
	 *	@return html paragraph
	 */
	public p getHistory (String ConfidentialType)
	{
		p history = new p();
		getEntries(false);
		boolean first = true;
		for (int i = 0; i < m_entries.length; i++)
		{
			MChatEntry entry = m_entries[i];
			if (!entry.isActive() || !entry.isConfidentialType(ConfidentialType))
				continue;
			if (first)
				first = false;
			else
				history.addElement(new hr());
			//	User & Date
			b b = new b();
			MUser user = MUser.get(getCtx(), entry.getCreatedBy());
			b.addElement(user.getName());
			b.addElement(" \t");
			Timestamp created = entry.getCreated();
			if (m_format == null)
				m_format = DisplayType.getDateFormat(DisplayType.DateTime);
			b.addElement(m_format.format(created));
			history.addElement(b);
			//
			p p = new p();
			String data = entry.getCharacterData();
			data = Util.maskHTML(data, true);
			p.addElement(data);
			history.addElement(p);
		}	//	entry
		//
		return history;
	}	//	getHistory

	/**
	 * IDEMPIERE-530
	 * Get the chat ID based on table_id and record_id
	 * @param Table_ID
	 * @param Record_ID
	 * @return CM_Chat_ID
 	 * @deprecated Use {@link MChat#getID(int, int, String)} instead
	 */
	@Deprecated
	public static int getID(int Table_ID, int Record_ID) {
		String sql="SELECT CM_Chat_ID FROM CM_Chat WHERE AD_Table_ID=? AND Record_ID=?";
		int chatID = DB.getSQLValueEx(null, sql, Table_ID, Record_ID);
		return chatID;
	}

	/**
	 * Get the chat ID based on table_id and record_uu
	 * @param Table_ID
	 * @param Record_UU
	 * @param Record_ID
	 * @return CM_Chat_ID 
	 */
	public static int getID(int Table_ID, int Record_ID, String Record_UU) {
		if (Util.isEmpty(Record_UU))
			return getID(Table_ID, Record_ID);
		String sql="SELECT CM_Chat_ID FROM CM_Chat WHERE AD_Table_ID=? AND Record_UU=?";
		int chatID = DB.getSQLValueEx(null, sql, Table_ID, Record_UU);
		return chatID;
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Set Record_UU from Record_ID.
		if (getRecord_ID() > 0 && getAD_Table_ID() > 0 && Util.isEmpty(getRecord_UU())) {
			MTable table = MTable.get(getAD_Table_ID());
			PO po = table.getPO(getRecord_ID(), get_TrxName());
			if (po != null)
				setRecord_UU(po.get_UUID());
		}
		return true;
	}

}	//	MChat
