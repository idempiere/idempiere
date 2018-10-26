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
 * - Hiep Le Quy                                                       *
 * - Thomas Bayen                                                      *
 * - Carlos Ruiz                                                       *
 **********************************************************************/

package org.idempiere.process;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.IGridTabImporter;
import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.GridWindow;
import org.compiere.model.MImportTemplate;
import org.compiere.model.MLookup;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;

public class ImportCSVProcess extends SvrProcess implements DataStatusListener {

	private InputStream m_file_istream = null;
	private int p_AD_ImportTemplate_ID = 0;
	private MImportTemplate m_importTemplate;
	private String p_FileName = "";
	private String p_ImportMode = "I";

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("AD_ImportTemplate_ID".equals(name)) {
				p_AD_ImportTemplate_ID = para.getParameterAsInt();
			} else if ("FileName".equals(name)) {
				p_FileName = para.getParameterAsString();
			} else if ("ImportMode".equals(name)) {
				p_ImportMode = para.getParameterAsString();
			} else {
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			}
		}
	}

	GridWindow m_gridWindow = null;
	GridTab m_gridTab = null;
	List<GridTab> m_Childs = null;

	@Override
	protected String doIt() throws Exception {

		try {
			initGridTab();
			IGridTabImporter csvImport = initImporter();
			importFile (p_FileName, csvImport, m_gridTab, m_Childs);
		} finally {
			Env.clearWinContext(-1);
		}

		return "@OK@";
	}

	protected void initGridTab() throws Exception {
		m_importTemplate = new MImportTemplate(getCtx(), p_AD_ImportTemplate_ID, get_TrxName());
		int l_AD_Window_ID = m_importTemplate.getAD_Window_ID();
		int l_AD_Tab_ID = m_importTemplate.getAD_Tab_ID();

		// Verify ImportMode permission for the role on the template
		if (!m_importTemplate.isAllowed(p_ImportMode, Env.getAD_Role_ID(Env.getCtx())))
			throw new AdempiereException("Template/Mode not allowed for this role");

		m_gridWindow = GridWindow.get(getCtx(), -1, l_AD_Window_ID);
		Env.setContext(getCtx(), -1, "IsSOTrx", m_gridWindow.isSOTrx());
		m_Childs = new ArrayList<GridTab>();
		for (int i = 0; i < m_gridWindow.getTabCount(); i++) {
			GridTab gridtab = m_gridWindow.getTab(i);
			if (!gridtab.isLoadComplete())
				m_gridWindow.initTab(i);
			if (m_gridWindow.getTab(i).getAD_Tab_ID() == l_AD_Tab_ID) {
				m_gridTab  = m_gridWindow.getTab(i);
			} else {
				if (m_gridTab != null && gridtab.getTabLevel() > m_gridTab.getTabLevel())
					m_Childs.add(gridtab);
			}
		}

		if (m_gridTab == null)
			throw new Exception("No Active Tab");
		m_gridTab.addDataStatusListener(this);
		for (GridTab childTab : m_Childs)
			childTab.addDataStatusListener(this);
	}

	protected IGridTabImporter initImporter() throws Exception {
		IGridTabImporter csvImport = null;
		List<IGridTabImporter> importerList = EquinoxExtensionLocator.instance().list(IGridTabImporter.class).getExtensions();
		for (IGridTabImporter importer : importerList){
			if ("csv".equals(importer.getFileExtension())) {
				csvImport = importer;
				break;
			}
		}

		if (csvImport == null)
			throw new Exception ("No CSV importer");

		return csvImport;
	}

	protected void importFile(String filePath, IGridTabImporter csvImporter, GridTab activeTab, List<GridTab> childTabs) throws Exception {
		m_file_istream = new FileInputStream(filePath);

		m_file_istream = m_importTemplate.validateFile(m_file_istream);
		File outFile = csvImporter.fileImport(activeTab, childTabs, m_file_istream, Charset.forName(m_importTemplate.getCharacterSet()), p_ImportMode, processUI);
		// TODO: Potential improvement - traverse the outFile and call addLog with the results

		if (processUI != null)
			processUI.download(outFile);
		else if( getProcessInfo() != null ){
			ProcessInfo m_pi = getProcessInfo();
			m_pi.setExportFile(outFile);
			m_pi.setExportFileExtension("csv");
		}

		m_file_istream.close();
	}

    /**
     * @param e
     * @see DataStatusListener#dataStatusChanged(DataStatusEvent)
     */
	public void dataStatusChanged(DataStatusEvent e)
    {
        int col = e.getChangedColumn();
        if (col < 0)
        	return;

        GridTab l_gridTab = null;
        if (e.getSource() != null && e.getSource() instanceof GridTable) {
        	GridTable gt = (GridTable) e.getSource();
        	l_gridTab = m_gridWindow.getTab(gt.getTabNo());
        	if (l_gridTab.getAD_Table_ID() != e.AD_Table_ID)
        		throw new RuntimeException("Table doesn't match with updated tab");
        }
        if (log.isLoggable(Level.CONFIG)) log.config("(" + l_gridTab + ") Col=" + col + ": " + e.toString());

        //  Process Callout
        GridField mField = l_gridTab.getField(col);
        if (mField != null
            && (mField.getCallout().length() > 0
            		|| (Core.findCallout(l_gridTab.getTableName(), mField.getColumnName())).size()>0
            		|| l_gridTab.hasDependants(mField.getColumnName())))
        {
            String msg = l_gridTab.processFieldChange(mField);     //  Dependencies & Callout
            if (msg.length() > 0)
            {
            	log.warning(msg);
            }

            // Refresh the list on dependant fields
    		for (GridField dependentField : l_gridTab.getDependantFields(mField.getColumnName()))
    		{
    			//  if the field has a lookup
    			if (dependentField != null && dependentField.getLookup() instanceof MLookup)
    			{
    				MLookup mLookup = (MLookup)dependentField.getLookup();
    				//  if the lookup is dynamic (i.e. contains this columnName as variable)
    				if (mLookup.getValidation().indexOf("@"+mField.getColumnName()+"@") != -1)
    				{
    					mLookup.refresh();
    				}
    			}
    		}   //  for all dependent fields

        }
    }

}
