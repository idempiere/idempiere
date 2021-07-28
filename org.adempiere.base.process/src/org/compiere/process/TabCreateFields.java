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
package org.compiere.process;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MColumn;
import org.compiere.model.MField;
import org.compiere.model.MTab;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Util;


/**
 *	Create Field from Table Column.
 *	(which do not exist in the Tab yet)
 *	
 *  @author Jorg Janke
 *  @version $Id: TabCreateFields.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 * 
 * @author Teo Sarca
 * 			<li>BF [ 2827782 ] TabCreateFields process not setting entity type well
 * 				https://sourceforge.net/tracker/?func=detail&atid=879332&aid=2827782&group_id=176962
 * 
 * @author Silvano Trinchero
 *      <li>BF [ 2891218] Wrong behavior in entity type settings for customization entity types
 *        https://sourceforge.net/tracker/?func=detail&aid=2891218&group_id=176962&atid=879332 
 */
public class TabCreateFields extends SvrProcess
{
	/**	Tab Number				*/
	private int	p_AD_Tab_ID= 0;
	private String p_EntityType = null;
	private Timestamp p_CreatedSince = null;
	
	/**
	 * 	prepare
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("EntityType"))
				p_EntityType = (String)para[i].getParameter();
			else if (name.equals("CreatedSince"))
				p_CreatedSince = para[i].getParameterAsTimestamp();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_AD_Tab_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		MTab tab = new MTab (getCtx(), p_AD_Tab_ID, get_TrxName());
		if (p_AD_Tab_ID == 0 || tab == null || tab.get_ID() == 0)
			throw new AdempiereSystemError("@NotFound@: @AD_Tab_ID@ " + p_AD_Tab_ID);
		if (log.isLoggable(Level.INFO)) log.info(tab.toString());
		//
		int count = 0;
		String sql = "SELECT * FROM AD_Column c "
			+ "WHERE NOT EXISTS (SELECT * FROM AD_Field f "
				+ "WHERE c.AD_Column_ID=f.AD_Column_ID"
				+ " AND c.AD_Table_ID=?"	//	#1
				+ " AND f.AD_Tab_ID=?)"		//	#2
			+ " AND AD_Table_ID=?"			//	#3
			+ " AND NOT (Name LIKE 'Created%' OR Name LIKE 'Updated%')"
			+ " AND IsActive='Y' ";

		if(!Util.isEmpty(p_EntityType))
			sql += " AND c.entitytype = ?";
		if(p_CreatedSince != null)
			sql += " AND c.created >= ? ";

		sql += "ORDER  BY CASE "
			+ "            WHEN c.ColumnName = 'AD_Client_ID' THEN -100 "
			+ "            WHEN c.ColumnName = 'AD_Org_ID' THEN -90 "
			+ "            WHEN c.IsParent = 'Y' THEN -85 "
			+ "            WHEN c.ColumnName = 'Value' THEN -80 "
			+ "            WHEN c.ColumnName = 'Name' THEN -70 "
			+ "            WHEN c.ColumnName = 'Description' THEN -60 "
			+ "            WHEN c.ColumnName = 'Help' THEN -50 "
			+ "            WHEN c.ColumnName = 'IsActive' THEN 1000000000 "
			+ "            ELSE c.AD_Column_ID "
			+ "          END ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int seqno = DB.getSQLValue(null, "SELECT MAX(SeqNo) FROM AD_Field WHERE AD_Tab_ID=?", tab.getAD_Tab_ID());
		int seqnogrid = DB.getSQLValue(null, "SELECT MAX(SeqNoGrid) FROM AD_Field WHERE AD_Tab_ID=?", tab.getAD_Tab_ID());
		seqno = seqno + 10;
		seqnogrid = seqnogrid + 10;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, tab.getAD_Table_ID());
			pstmt.setInt (2, tab.getAD_Tab_ID());
			pstmt.setInt (3, tab.getAD_Table_ID());
			int i = 4;
			if(!Util.isEmpty(p_EntityType))
				pstmt.setString(i++, p_EntityType);
			if(p_CreatedSince != null)
				pstmt.setTimestamp(i++, p_CreatedSince);
			rs = pstmt.executeQuery ();
			String uuidcolname = PO.getUUIDColumnName(tab.getAD_Table().getTableName());
			while (rs.next ())
			{
				MColumn column = new MColumn (getCtx(), rs, get_TrxName());
				//
				MField field = new MField (tab);
				field.setColumn(column);
								
				// F3P: assign field entity type -> changed to obey to the following rule:
				//	if column entitytype == D, then get tab's entity type
				//  if not, keep field entity type (ie: entitytype is D if and only if both are D)
				
				if ("D".equals(column.getEntityType()))
					field.setEntityType(tab.getEntityType());
				else
					field.setEntityType(column.getEntityType());
				
				// end F3P
				
				if (column.isKey() || uuidcolname.equalsIgnoreCase(field.getName())) {
					field.setIsDisplayed(false);
					field.setIsDisplayedGrid(false);
				}

				// Assign some default formatting
				if (column.getAD_Reference_ID() == DisplayType.Button || column.getAD_Reference_ID() == DisplayType.YesNo) {
					field.setXPosition(2);
				}
				field.setColumnSpan(2);
				if (column.getFieldLength() >= 60) {
					field.setColumnSpan(5);
				}
				if (column.getAD_Reference_ID() == DisplayType.Text) {
					field.setNumLines(3);
				} else if (column.getAD_Reference_ID() == DisplayType.TextLong) {
					field.setNumLines(5);
				} else if (column.getAD_Reference_ID() == DisplayType.Memo) {
					field.setNumLines(8);
				}
				String accessLevel = tab.getAD_Table().getAccessLevel();
				if (column.getColumnName().equals("AD_Org_ID")) {
					field.setXPosition(4);
					if (   accessLevel.equals(MTable.ACCESSLEVEL_ClientOnly)
						|| accessLevel.equals(MTable.ACCESSLEVEL_SystemOnly)
						|| accessLevel.equals(MTable.ACCESSLEVEL_SystemPlusClient)) {
						field.setIsDisplayedGrid(false);
					}
				}
				if (column.getColumnName().equals("AD_Client_ID")) {
					if (! (accessLevel.equals(MTable.ACCESSLEVEL_All)
						|| accessLevel.equals(MTable.ACCESSLEVEL_SystemPlusClient))) {
						field.setIsDisplayedGrid(false);
					}
				}
				if (field.isDisplayed()) {
					field.setSeqNo(seqno);
					seqno = seqno + 10;
				}

				if (field.isDisplayedGrid()) {
					field.setSeqNoGrid(seqnogrid);
					seqnogrid = seqnogrid + 10;
				}

				//set display logic for accounting dimensions
				if (column.getColumnName().equalsIgnoreCase("AD_OrgTrx_ID")){
					field.setDisplayLogic("@$Element_OT@=Y");
				} else if (column.getColumnName().equalsIgnoreCase("C_Campaign_ID")) {
					field.setDisplayLogic("@$Element_MC@=Y");
				} else if (column.getColumnName().equalsIgnoreCase("C_Activity_ID")) {
					field.setDisplayLogic("@$Element_AY@=Y");
				} else if (column.getColumnName().equalsIgnoreCase("C_Project_ID")) {
					field.setDisplayLogic("@$Element_PJ@=Y");
				} else if (column.getColumnName().equalsIgnoreCase("User1_ID")) {
					field.setDisplayLogic("@$Element_U1@=Y");
				} else if (column.getColumnName().equalsIgnoreCase("User2_ID")) {
					field.setDisplayLogic("@$Element_U2@=Y");
				}  

				// set read-only for usual known-fields
				if (   column.getColumnName().equalsIgnoreCase("IsApproved")
					|| column.getColumnName().equalsIgnoreCase("DocStatus")
					|| column.getColumnName().equalsIgnoreCase("Processed")
					|| column.getColumnName().equalsIgnoreCase("ProcessedOn")
					|| column.getColumnName().equalsIgnoreCase("Processing")) {
					field.setIsReadOnly(true);
				}

				if (field.save())
				{
					addLog(0, null, null, column.getName());
					count++;
				}
			}
 		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		StringBuilder msgreturn = new StringBuilder("@Created@ #").append(count);
		return msgreturn.toString();
	}	//	doIt
	
}	//	TabCreateFields
