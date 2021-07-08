/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - BX Service GmbH                                                   *
* - Diego Ruiz                                                        *
**********************************************************************/
package org.compiere.process;

import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MColumn;
import org.compiere.model.MMenu;
import org.compiere.model.MPInstance;
import org.compiere.model.MTab;
import org.compiere.model.MTable;
import org.compiere.model.MWindow;
import org.compiere.model.SystemIDs;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 *	Create Menu - Window/tab & field from a table 
 *	
 *  @author Diego Ruiz - BX Service GmbH
 *  @contributor Andreas Sumerauer IDEMPIERE-4745
 */
public class CreateWindowFromTable extends SvrProcess
{
	/** Table		*/
	private int		p_AD_Table_ID = 0;
	
	/** Window Type		*/
	private String		p_WindowType = null;
	
	/** Sales transaction		*/
	private boolean		p_IsSOTrx = false;
	
	/** Is a New Window?		*/
	private boolean		p_isNewWindow = false;
	
	/** AD_Window_ID    		*/
	private int		p_AD_Window_ID = 0;
	
	/** Tab Level    		*/
	private int		p_TabLevel = 0;
	
	/** Create Menu Record		*/
	private boolean		p_isCreateMenu = false;
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("WindowType"))
				p_WindowType = para[i].getParameterAsString();
			else if (name.equals("IsSOTrx"))
				p_IsSOTrx = para[i].getParameterAsBoolean();
			else if (name.equals("IsNewWindow"))
				p_isNewWindow = para[i].getParameterAsBoolean();
			else if (name.equals("AD_Window_ID"))
				p_AD_Window_ID = para[i].getParameterAsInt();
			else if (name.equals("TabLevel"))
				p_TabLevel = para[i].getParameterAsInt();
			else if (name.equals("IsCreateMenu"))
				p_isCreateMenu = para[i].getParameterAsBoolean();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_AD_Table_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (p_AD_Table_ID == 0)
			throw new AdempiereException("@NotFound@ @AD_Table_ID@ " + p_AD_Table_ID);
		if (!p_isNewWindow && p_AD_Window_ID == 0)
			throw new AdempiereException("@Mandatory@ @AD_Window_ID@");
		if (log.isLoggable(Level.INFO)) 
			log.info("Source AD_Table_ID=" + p_AD_Table_ID);
		
		MTable table = new MTable(getCtx(), p_AD_Table_ID, get_TrxName());
		if (table != null) {
			
			String entityType = table.getEntityType();
			
			if (!isTableValid(table))
				throw new AdempiereException(Msg.getMsg(getCtx(), "NewWindowNoValid"));
			
			MWindow window;
			int tabSeqNo = 0;
			if (p_isNewWindow) {
				if (MWindow.WINDOWTYPE_Transaction.equals(p_WindowType) && ! table.columnExistsInDB("Processed"))
					throw new AdempiereException(Msg.getMsg(getCtx(), "TrxWindowMandatoryProcessed"));
				
				int i = DB.getSQLValue(get_TrxName(), "SELECT 1 FROM AD_Window WHERE AD_Window.name = ?", table.getName());

				if (i == 1)
					throw new AdempiereException(Msg.getMsg(getCtx(), "DuplicatedWindowName", new Object[] {table.getName()}));

				window = new MWindow(getCtx(), 0, get_TrxName());
				window.setName(table.getName());
				window.setIsSOTrx(p_IsSOTrx);
				window.setWindowType(p_WindowType);
				window.setEntityType(entityType);
				window.saveEx();
				addLog(window.getAD_Window_ID(), null, null, "@AD_Window_ID@: " + window.getName(),
						window.get_Table_ID(), window.getAD_Window_ID());
				p_TabLevel = 0;
				tabSeqNo = 10;
			} else {
				//If no new window but a detail tab
				if (p_TabLevel > 0) {
					boolean hasParentLinkColumn = false;
					for (MColumn column : table.getColumns(false)) {
						if (column.isParent()) {
							hasParentLinkColumn = true;
							break;
						}
					}
					
					if (!hasParentLinkColumn)
						throw new AdempiereException(Msg.getMsg(getCtx(), "NoParentLink"));
				}
				window = new MWindow(getCtx(), p_AD_Window_ID, get_TrxName());

				int maxTabLevel = -1;
				int maxTabSeqNo = 0;
				for (MTab tab : window.getTabs(true, get_TrxName())) {
					if (tab.getTabLevel() > maxTabLevel) {
						maxTabLevel = tab.getTabLevel();
					}
					if (tab.getSeqNo() > maxTabSeqNo) {
						maxTabSeqNo = tab.getSeqNo();
					}
				}

				tabSeqNo = maxTabSeqNo + 10;

				if (   (maxTabLevel == 0 && p_TabLevel == 0)
					|| p_TabLevel > maxTabLevel+1)
					throw new AdempiereException(Msg.getMsg(getCtx(), "MaxTabLevel", new Object[] {maxTabLevel+1}));
			}

			MTab tab = new MTab(window);
			tab.setSeqNo(tabSeqNo);
			tab.setName(table.getName());
			tab.setAD_Table_ID(p_AD_Table_ID);
			tab.setTabLevel(p_TabLevel);
			tab.setIsSingleRow(true); //Default

			//Set order by
			if (table.columnExistsInDB("Value"))
				tab.setOrderByClause(table.getTableName() + ".Value");
			else if (table.columnExistsInDB("Name"))
				tab.setOrderByClause(table.getTableName() + ".Name");
			else 
				tab.setOrderByClause(table.getTableName() + ".Created DESC");

			if (table.getTableName().toLowerCase().endsWith("_trl")) {
				tab.setIsTranslationTab(true);
				tab.setIsInsertRecord(false);
				if (table.columnExistsInDB("AD_Language"))
					tab.setOrderByClause(table.getTableName() + ".AD_Language");
			}

			tab.saveEx();
			addLog(tab.getAD_Tab_ID(), null, null, "@AD_Tab_ID@: " + tab.getName(), 
					tab.get_Table_ID(), tab.getAD_Tab_ID());

			//Create Fields
			ProcessInfo processInfo = new ProcessInfo("", SystemIDs.PROCESS_AD_TAB_CREATEFIELDS, 0, tab.getAD_Tab_ID());

			MPInstance instance = new MPInstance(getCtx(), SystemIDs.PROCESS_AD_TAB_CREATEFIELDS, 0);
			instance.saveEx();
			processInfo.setAD_PInstance_ID(instance.getAD_PInstance_ID());

			TabCreateFields createFields = new TabCreateFields();
			boolean success = createFields.startProcess(getCtx(), processInfo, Trx.get(get_TrxName(), false));
			if (!success) {
				StringBuilder msgout = new StringBuilder("Process=").append(processInfo.getTitle())
						.append(" Called from=").append("CreateWindowFromTable")
						.append(" Error=").append(processInfo.isError())
						.append(" Summary=").append(processInfo.getSummary());
				log.severe(msgout.toString());
				throw new AdempiereException(processInfo.getSummary());
			}

			if (p_isCreateMenu && p_isNewWindow) {
				MMenu menu = new MMenu(getCtx(), 0, get_TrxName());
				menu.setName(window.getName());
				menu.setEntityType(entityType);
				menu.setIsSOTrx(p_IsSOTrx);
				menu.setAction(MMenu.ACTION_Window);
				menu.setAD_Window_ID(window.getAD_Window_ID());
				menu.saveEx();
				addLog(menu.getAD_Menu_ID(), null, null, "@AD_Menu_ID@: " + menu.getName(), 
						menu.get_Table_ID(), menu.getAD_Menu_ID());
			}

			//If AD_Window_ID is empty in the Table record
			if (table.getAD_Window_ID() <= 0)
				table.setAD_Window_ID(window.getAD_Window_ID());
			
			table.saveEx();
		}

		return "@OK@";
	}	//	doIt

	/**
	 * 
	 * @param table Table to be verifies
	 * @return true if the table has all recommended columns
	 */
	public boolean isTableValid(MTable table) {
		
		boolean hasIsActive = false;
		boolean hasAD_Client_ID = false;
		boolean hasAD_Org_ID = false;
		boolean hasCreated = false;
		boolean hasUpdated = false;
		boolean hasCreatedBy = false;
		boolean hasUpdatedBy = false;

		for (MColumn column : table.getColumns(true)) {
			if (column.getAD_Element_ID() == SystemIDs.ELEMENT_AD_CLIENT_ID)
				hasAD_Client_ID = true;
			else if (column.getAD_Element_ID() == SystemIDs.ELEMENT_AD_ORG_ID)
				hasAD_Org_ID = true;
			else if (column.getAD_Element_ID() == SystemIDs.ELEMENT_CREATED)
				hasCreated = true;
			else if (column.getAD_Element_ID() == SystemIDs.ELEMENT_CREATEDBY)
				hasCreatedBy = true;
			else if (column.getAD_Element_ID() == SystemIDs.ELEMENT_ISACTIVE)
				hasIsActive = true;
			else if (column.getAD_Element_ID() == SystemIDs.ELEMENT_UPDATED)
				hasUpdated = true;
			else if (column.getAD_Element_ID() == SystemIDs.ELEMENT_UPDATEDBY)
				hasUpdatedBy = true;
		}

		return hasIsActive && hasAD_Client_ID && hasAD_Org_ID && hasCreated &&
				hasUpdated && hasCreatedBy && hasUpdatedBy;
	} // isTableValid
	
}