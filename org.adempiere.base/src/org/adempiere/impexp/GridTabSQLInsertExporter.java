/***********************************************************************
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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.impexp;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.db.Database;
import org.compiere.model.GridTab;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Export data as SQL insert statement
 * @author hengsin
 */
public class GridTabSQLInsertExporter implements IGridTabExporter {

	/**
	 * Default constructor
	 */
	public GridTabSQLInsertExporter() {
	}

	@Override
	public void export(GridTab gridTab, List<GridTab> childs, boolean isCurrentRowOnly, File file,
			int indxDetailSelected) {			
		try (FileOutputStream fos = new FileOutputStream (file); ZipOutputStream zos = new ZipOutputStream(fos);){			
			// create directory "oracle"
	        ZipEntry directoryEntry = new ZipEntry("oracle/");
	        zos.putNextEntry(directoryEntry);
	        zos.closeEntry();
	        
	        // create directory "postgresql"
	        directoryEntry = new ZipEntry("postgresql/");
	        zos.putNextEntry(directoryEntry);
	        zos.closeEntry();
	        
	        //export header tab 
	        MTable table = MTable.get(gridTab.getAD_Table_ID());
	        List<String> oracles = new ArrayList<>();
	        List<String> pgs = new ArrayList<>();
	        if (isCurrentRowOnly) {
	        	PO po = getPO(gridTab, table, gridTab.getCurrentRow());
	        	if (po != null)        		
					addSQLInsert(po, oracles, pgs);
	        } else {
	        	for(int i = 0; i < gridTab.getRowCount(); i++) {
	        		PO po = getPO(gridTab, table, i);
	        		if (po != null)         		
						addSQLInsert(po, oracles, pgs);
	        	}
	        }
	        
	        ZipEntry fileEntry = new ZipEntry("oracle/" + table.getTableName() + ".sql");
	        zos.putNextEntry(fileEntry);
	        for(String oracle : oracles)
	        	zos.write(!(oracle.endsWith("/")) ? (oracle+"\n;\n").getBytes() : (oracle+"\n").getBytes());
	        zos.closeEntry();
	        
	        fileEntry = new ZipEntry("postgresql/" + table.getTableName() + ".sql");
	        zos.putNextEntry(fileEntry);
	        for(String pg : pgs)
	        	zos.write((pg+"\n;\n").getBytes());
	        zos.closeEntry();
	        
	        //export child tabs
	        if (isCurrentRowOnly) {
		        for(GridTab childTab : childs) {
		        	if (!childTab.isLoadComplete()){
						childTab.initTab(false);
						childTab.query(false, 0, 0);
					}										
		        	if (childTab.getRowCount() == 0)
		        		continue;
		        	table = MTable.get(childTab.getAD_Table_ID());
			        oracles = new ArrayList<>();
			        pgs = new ArrayList<>();
			        for(int i = 0; i < childTab.getRowCount(); i++) {
		        		PO po = getPO(childTab, table, i);
		        		if (po != null)
		        			addSQLInsert(po, oracles, pgs);
		        	}
			        fileEntry = new ZipEntry("oracle/" + table.getTableName() + ".sql");
			        zos.putNextEntry(fileEntry);
			        for(String oracle : oracles)
			        	zos.write((oracle+"\n;\n").getBytes());
			        zos.closeEntry();
			        
			        fileEntry = new ZipEntry("postgresql/" + table.getTableName() + ".sql");
			        zos.putNextEntry(fileEntry);
			        for(String pg : pgs)
			        	zos.write((pg+"\n;\n").getBytes());
			        zos.closeEntry();
		        }
	        }
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
    }

	/**
	 * Create SQL insert script for po
	 * @param po
	 * @param oracles list to add oracle insert script
	 * @param pgs list to add postgresql insert script
	 */
	protected void addSQLInsert(PO po, List<String> oracles, List<String> pgs) {
		String oracle = Database.getDatabase(Database.DB_ORACLE).convertStatement(po.toInsertSQL(Database.DB_ORACLE));
		String pg = Database.getDatabase(Database.DB_POSTGRESQL).convertStatement(po.toInsertSQL(Database.DB_POSTGRESQL));
		oracles.add(oracle);
		pgs.add(pg);
	}

	/**
	 * Load PO by record ID or UUID
	 * @param gridTab
	 * @param table
	 * @param row
	 * @return PO
	 */
	protected PO getPO(GridTab gridTab, MTable table, int row) {
		int recordId = gridTab.getKeyID(row);
    	if (recordId >= 0) {
    		return table.getPO(gridTab.getKeyID(row), null);
    	} else {
    		UUID uuid = gridTab.getTableModel().getUUID(row);
    		if (uuid != null)
    			return table.getPOByUU(uuid.toString(), null);
    	}
    	return null;
	}
	
	@Override
	public String getFileExtension() {
		return "zip";
	}

	@Override
	public String getFileExtensionLabel() {
		return Msg.getMsg(Env.getCtx(), "FileSQLInsertZip");
	}

	@Override
	public String getContentType() {
		return "application/zip";
	}

	@Override
	public String getSuggestedFileName(GridTab gridTab) {
		return gridTab.getName() + "." + getFileExtension();
	}

	@Override
	public boolean isExportableTab(GridTab gridTab) {
		if (!gridTab.isDisplayed())
			return false;
		return true;
	}

	@Override
	public boolean isAdvanced() {
		return true;
	}

	@Override
	public boolean isExportChildTabsForCurrentRowOnly() {
		return true;
	}

	@Override
	public int maxDeepOfChildTab() {
		return 1;
	}	
}
