/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.pipo2;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.Adempiere;
import org.compiere.model.GridTab;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * @author hengsin
 *
 */
public class GridTab2PackExporter implements IGridTabExporter {

	private final static CLogger logger = CLogger.getCLogger(GridTab2PackExporter.class);

	/* (non-Javadoc)
	 * @see org.adempiere.base.IGridTabExporter#export(org.compiere.model.GridTab, java.io.File)
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void export(GridTab gridTab, List<GridTab> childs, boolean currentRowOnly, File file,int indxDetailSelected) {
		String tableName = gridTab.getTableName();
		PackOut packOut = new PackOut();
		packOut.setCtx(Env.getCtx());
		packOut.setExportDictionaryEntity(true);
		Map properties = new HashMap();
		properties.putAll(Env.getCtx());
		List<PackoutItem> packoutItems = new ArrayList<PackoutItem>();
		if (packOut.getHandler(tableName) == null) {
			properties.put(DataElementParameters.AD_TABLE_ID, gridTab.getAD_Table_ID());
			StringBuilder sql = new StringBuilder("SELECT * FROM ");
			sql.append(tableName);
			if (currentRowOnly) {
				sql.append(" WHERE ").append(gridTab.getTableModel().getWhereClause(gridTab.getCurrentRow()));
			} else {
				for(int i = 0; i < gridTab.getRowCount(); i++) {
					if (i == 0)
						sql.append(" WHERE ((");
					else
						sql.append(") OR (");
					gridTab.navigate(i);
					sql.append(gridTab.getTableModel().getWhereClause(gridTab.getCurrentRow()));
				}
				sql.append("))");
			}
			for(GridTab child : childs) {
				if (child.getTabLevel() > gridTab.getTabLevel()+1) {
					sql = sql.append(">").append(child.getTableName());
				} else {
					sql = sql.append(";").append(child.getTableName());
				}
			}
			properties.put(DataElementParameters.SQL_STATEMENT, sql.toString());
			PackoutItem packoutItem = new PackoutItem(IHandlerRegistry.TABLE_GENERIC_HANDLER, gridTab.getRecord_ID(),
					properties);
			packoutItems.add(packoutItem);
		} else {
			if (currentRowOnly) {
				PackoutItem packoutItem = new PackoutItem(tableName, gridTab.getRecord_ID(),
						properties);
				packoutItems.add(packoutItem);
			} else {
				for(int i = 0; i < gridTab.getRowCount(); i++) {
					PackoutItem packoutItem = new PackoutItem(tableName, gridTab.getKeyID(i),
							properties);
					packoutItems.add(packoutItem);
				}
			}
		}
		MUser user = MUser.get(Env.getCtx());
		PackoutDocument packoutDocument = new PackoutDocument(tableName, "1.0.0", Adempiere.getVersion(),
				Adempiere.DB_VERSION, "", "", user.getName(), user.getEMail(), new Date(), new Date());
		if (file == null) {
			try {
				file = File.createTempFile(tableName + "_", ".zip");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		try {
			packOut.export(getPackoutDirectory(), file!=null ? file.getAbsolutePath() : null , packoutDocument, packoutItems, null);
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	private String getPackoutDirectory() {
		// Create Target directory if required
		String packageDirectory = Adempiere.getAdempiereHome();
		String result = packageDirectory + File.separator
				+ "packages";
		File docDir = new File( result+File.separator+"doc");

		if (!docDir.exists()) {
			boolean success = docDir.mkdirs();
			if (!success) {
				logger.info("Target directory creation failed");
			}
		}
		return result+File.separator;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IGridTabExporter#getFileExtension()
	 */
	@Override
	public String getFileExtension() {
		return "zip";
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IGridTabExporter#getFileExtensionLabel()
	 */
	@Override
	public String getFileExtensionLabel() {
		return Msg.getMsg(Env.getCtx(), "File2PackZip");
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IGridTabExporter#getContentType()
	 */
	@Override
	public String getContentType() {
		return "application/zip";
	}

	@Override
	public String getSuggestedFileName(GridTab gridTab) {
		return gridTab.getName() + "." + getFileExtension();
	}
}
