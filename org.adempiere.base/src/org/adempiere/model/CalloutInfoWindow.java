/**
 * 
 */
package org.adempiere.model;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.compiere.model.AccessSqlParser;
import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_AD_InfoColumn;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.M_Element;
import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class CalloutInfoWindow implements IColumnCallout {

	/**
	 * 
	 */
	public CalloutInfoWindow() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IColumnCallout#start(java.util.Properties, int, org.compiere.model.GridTab, org.compiere.model.GridField, java.lang.Object, java.lang.Object)
	 */
	@Override
	public String start(Properties ctx, int WindowNo, GridTab mTab,
			GridField mField, Object value, Object oldValue) {
		if (mTab.getTableName().equals("AD_InfoColumn"))
			return element(mTab, value);
		else if (mTab.getTableName().equals("AD_InfoWindow"))
			return table(mTab, value);
		else
			return "";
	}

	private String table(GridTab mTab, Object value) {
		if (value != null) {			
			int id = ((Number)value).intValue();
			if (id > 0) {
				I_AD_InfoWindow infoWindow = GridTabWrapper.create(mTab, I_AD_InfoWindow.class);
				if (infoWindow.getFromClause() == null || infoWindow.getFromClause().trim().length() == 0) {
					MTable table = MTable.get(Env.getCtx(), id);
					if (table != null) {
						infoWindow.setFromClause(table.getTableName() + " a");
						if (infoWindow.getName() == null || infoWindow.getName().trim().length() == 0) {
							infoWindow.setName(table.getName());
						}
					}						
				}
			}
		}
		return null;
	}

	protected String element(GridTab mTab, Object value) {		
		if (value != null) {			
			int id = ((Number)value).intValue();
			if (id > 0) {
				I_AD_InfoColumn infoColumn = GridTabWrapper.create(mTab, I_AD_InfoColumn.class);
				M_Element element = new M_Element(Env.getCtx(), id, (String)null);
				infoColumn.setColumnName(element.getColumnName());
				infoColumn.setDescription(element.getDescription());
				infoColumn.setHelp(element.getHelp());
				infoColumn.setName(element.getName());
				if (infoColumn.getSelectClause() == null || infoColumn.getSelectClause().trim().length() == 0) {
					String fromClause = infoColumn.getAD_InfoWindow().getFromClause();
					AccessSqlParser parser = new AccessSqlParser("SELECT * FROM " + fromClause);
					TableInfo[] tableInfos = parser.getTableInfo(0);
					Map<String, MTable> map = new HashMap<String, MTable>();
					for(TableInfo ti : tableInfos) {
						String alias = ti.getSynonym();
						String tableName = ti.getTableName();
						
						MTable table = map.get(tableName);
						if (table == null) {
							table = MTable.get(Env.getCtx(), tableName);
							if (table == null) continue;
							map.put(tableName, table);
						}
						MColumn col = table.getColumn(element.getColumnName());
						if (col != null) {
							infoColumn.setSelectClause(alias+"."+element.getColumnName());
							infoColumn.setAD_Reference_ID(col.getAD_Reference_ID());
							infoColumn.setAD_Reference_Value_ID(col.getAD_Reference_Value_ID());
							infoColumn.setAD_Val_Rule_ID(col.getAD_Val_Rule_ID());
							if ((col.isSelectionColumn() || col.isIdentifier()) && !col.isKey())
								infoColumn.setIsQueryCriteria(true);
							break;
						}
					}
				}
			}
		}
		return "";
	}

}
