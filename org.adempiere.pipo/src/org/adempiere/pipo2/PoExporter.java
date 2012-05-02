package org.adempiere.pipo2;

import java.math.BigDecimal;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.X_AD_Client;
import org.compiere.model.X_AD_Org;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class PoExporter {

	private PO po = null;

	@SuppressWarnings("unused")
	private CLogger log = CLogger.getCLogger(getClass());
	private PIPOContext ctx;

	private TransformerHandler transformerHandler;

	private void addTextElement(String qName, String text, AttributesImpl atts) {
		try {
			transformerHandler.startElement("", "", qName, atts);
			append(text);
			transformerHandler.endElement("", "", qName);
		} catch (SAXException e) {
			throw new RuntimeException(e);
		}
	}

	private void append(String str) throws SAXException
	{
		char[] contents = str != null ? str.toCharArray() : new char[0];
		transformerHandler.characters(contents,0,contents.length);
	}

	/**
	 * @param ctx
	 * @param po
	 */
	public PoExporter(PIPOContext ctx, TransformerHandler handler, PO po){
		this.ctx = ctx;
		this.po = po;
		transformerHandler = handler;
	}

	/**
	 *
	 * @param name
	 * @param value
	 */
	public void addUnchecked(String name, String value, AttributesImpl atts){
		addTextElement(name, value, atts);
	}

	/**
	 *
	 * @param name
	 * @param stringValue
	 * @param atts
	 */
	public void addString(String name, String stringValue, AttributesImpl atts){
		addString(name, stringValue, "", atts);
	}

	/**
	 *
	 * @param name
	 * @param defaultValue
	 * @param stringValue
	 */
	public void addString(String name, String stringValue, String defaultValue, AttributesImpl atts){
		addTextElement(name, stringValue != null ? stringValue : defaultValue, atts);
	}

	/**
	 *
	 * @param name
	 * @param boolValue
	 */
	public void addBoolean(String name, boolean boolValue, AttributesImpl atts){
		addTextElement(name, boolValue == true ? "true" : "false", atts);
	}


	/**
	 *
	 * @param name
	 * @param columnName
	 */
	public void add(String columnName, AttributesImpl atts) {
		add(columnName, "", atts);
	}

	/**
	 *
	 * @param name
	 * @param columnName
	 * @param defaultValue
	 */
	public void add(String columnName, String defaultValue, AttributesImpl atts) {
		Object value = po.get_Value(columnName);

		if(value == null){
			addTextElement(columnName, defaultValue, atts);
			return;
		}

		if(value instanceof String){
			addTextElement(columnName, (String)value, atts);
		} else if(value instanceof Boolean) {
			addTextElement(columnName, (Boolean)value == true ? "true" : "false", atts);
		} else if(value instanceof Integer) {
			addTextElement(columnName, value.toString(), atts);
		} else if(value instanceof BigDecimal) {
			addTextElement(columnName, value.toString(), atts);
		} else{
			addTextElement(columnName, value.toString(), atts);
		}
	}

	/**
	 * @param columnName
	 * @param defaultValue
	 */
	public void add(String columnName, boolean defaultValue, AttributesImpl atts) {
		Object oo = po.get_Value(columnName);
		boolean value = defaultValue;
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 value = ((Boolean)oo).booleanValue();
			 else
				 value = "Y".equals(oo);
		}
		addBoolean(columnName, value, atts);
	}

	/**
	 *
	 *
	 */
	public void addIsActive(AttributesImpl atts){
		addTextElement("IsActive", (Boolean)po.isActive() == true ? "true" : "false", atts);
	}

	public void addTableReference(String tableName, String searchColumn, AttributesImpl atts) {
		String columnName = tableName + "_ID";
		addTableReference(columnName, tableName, searchColumn, atts);
	}

	public void addTableReference(String columnName, String tableName, String searchColumn, AttributesImpl atts) {
		int id = po.get_Value(columnName) != null ? (Integer)po.get_Value(columnName) : 0;
		addTableReference(columnName, tableName, searchColumn, id, atts);
	}

	public void addTableReference(String columnName, String tableName, String searchColumn, int id, AttributesImpl atts) {
		String value = ReferenceUtils.getTableReference(tableName, searchColumn, id, atts);
		addString(columnName, value, atts);
	}

	public void export(List<String> excludes) {
		export(excludes, false);
	}

	public void export(List<String> excludes, boolean preservedOrg) {
		POInfo info = POInfo.getPOInfo(po.getCtx(), po.get_Table_ID());
		int count = info.getColumnCount();
		//special treatment for ad_org_id
		int AD_Client_ID = po.getAD_Client_ID();
		if (AD_Client_ID == 0)
		{
			addString("AD_Client_ID", "0", new AttributesImpl());
			if (excludes == null || !excludes.contains("AD_Org_ID"))
				addString("AD_Org_ID", "0", new AttributesImpl());
		}
		else
		{
			if (excludes == null || !excludes.contains("AD_Org_ID"))
			{
				int AD_Org_ID = po.getAD_Org_ID();
				if (AD_Org_ID == 0)
				{
					addString("AD_Org_ID", "0", new AttributesImpl());
				}
				else
				{
					if (!preservedOrg)
						addString("AD_Org_ID", "@AD_Org_ID@", new AttributesImpl());
					else {
						addTableReference(X_AD_Client.Table_Name, "Value", new AttributesImpl());
						addTableReference(X_AD_Org.Table_Name, "Value", new AttributesImpl());
					}
				}
			}
		}

		for(int i = 0; i < count; i++) {
			String columnName = info.getColumnName(i);
			if (excludes != null) {
				boolean exclude = false;
				for(String ex : excludes)
				{
					if (ex.equalsIgnoreCase(columnName))
					{
						exclude = true;
						break;
					}
				}
				if (exclude)
					continue;
			}

			int displayType = info.getColumnDisplayType(i);
			if (DisplayType.YesNo == displayType) {
				add(columnName, false, new AttributesImpl());
			} else if (DisplayType.TableDir == displayType || DisplayType.ID == displayType) {
				String tableName = null;
				String searchColumn = null;
				if ("Record_ID".equalsIgnoreCase(columnName) && po.get_ColumnIndex("AD_Table_ID") >= 0) {
					int AD_Table_ID = po.get_Value(po.get_ColumnIndex("AD_Table_ID")) != null
							? (Integer)po.get_Value(po.get_ColumnIndex("AD_Table_ID")) : 0;
					tableName = MTable.getTableName(ctx.ctx, AD_Table_ID);
					searchColumn = tableName + "_ID";
				} else if (po.get_TableName().equals("AD_TreeNode") && columnName.equals("Parent_ID")) {
					int AD_Tree_ID = po.get_ValueAsInt("AD_Tree_ID");
					int AD_Table_ID = DB.getSQLValue(po.get_TrxName(), "SELECT AD_Table_ID From AD_Tree WHERE AD_Tree_ID="+AD_Tree_ID);
					tableName = MTable.getTableName(po.getCtx(), AD_Table_ID);
					searchColumn = tableName+"_ID";
				} else if (po.get_TableName().equals("AD_TreeNode") && columnName.equals("Node_ID")) {
					int AD_Tree_ID = po.get_ValueAsInt("AD_Tree_ID");
					int AD_Table_ID = DB.getSQLValue(po.get_TrxName(), "SELECT AD_Table_ID From AD_Tree WHERE AD_Tree_ID="+AD_Tree_ID);
					tableName = MTable.getTableName(po.getCtx(), AD_Table_ID);
					searchColumn = tableName+"_ID";
				} else {
					//remove _ID
					searchColumn = columnName;
					tableName = columnName.substring(0, columnName.length() - 3);
					if (tableName.equalsIgnoreCase("ad_table")) {
						searchColumn = "TableName";
					} else if (tableName.equalsIgnoreCase("ad_column") || tableName.equalsIgnoreCase("ad_element")) {
						searchColumn = "ColumnName";
					}
				}
				if (searchColumn.endsWith("_ID")) {
					int AD_Table_ID = MTable.getTable_ID(tableName);
					POInfo pInfo = POInfo.getPOInfo(po.getCtx(), AD_Table_ID);
					if (pInfo.getColumnIndex("Value") >= 0) {
						searchColumn = "Value";
					} else if (pInfo.getColumnIndex("Name") >= 0) {
						searchColumn = "Name";
					} else if (pInfo.getColumnIndex("DocumentNo") >= 0) {
						searchColumn = "DocumentNo";
					}
				}
				addTableReference(columnName, tableName, searchColumn, new AttributesImpl());
			} else if (DisplayType.List == displayType) {
				add(columnName, "", new AttributesImpl());
			} else if (DisplayType.isLookup(displayType)) {
				String searchColumn = null;
				String tableName = null;
				if ("Record_ID".equalsIgnoreCase(columnName) && po.get_ColumnIndex("AD_Table_ID") >= 0) {
					int AD_Table_ID = po.get_Value(po.get_ColumnIndex("AD_Table_ID")) != null
						? (Integer)po.get_Value(po.get_ColumnIndex("AD_Table_ID")) : 0;
					tableName = MTable.getTableName(ctx.ctx, AD_Table_ID);
					searchColumn = tableName + "_ID";
				} else if (info.getColumnLookup(i) != null){
					searchColumn = info.getColumnLookup(i).getColumnName();
					tableName = searchColumn.substring(0, searchColumn.indexOf("."));
					searchColumn = searchColumn.substring(searchColumn.indexOf(".")+1);
				} else {
					searchColumn = columnName;
				}
				if (searchColumn.endsWith("_ID")) {
					if (tableName.equalsIgnoreCase("ad_table")) {
						searchColumn = "TableName";
					} else if (tableName.equalsIgnoreCase("ad_column") || tableName.equalsIgnoreCase("ad_element")){
						searchColumn = "ColumnName";
					} else {
						int AD_Table_ID = MTable.getTable_ID(tableName);
						POInfo pInfo = POInfo.getPOInfo(po.getCtx(), AD_Table_ID);
						if (pInfo.getColumnIndex("Value") >= 0) {
							searchColumn = "Value";
						} else if (pInfo.getColumnIndex("Name") >= 0) {
							searchColumn = "Name";
						} else if (pInfo.getColumnIndex("DocumentNo") >= 0) {
							searchColumn = "DocumentNo";
						}
					}
				}
				addTableReference(columnName, tableName, searchColumn, new AttributesImpl());
			} else if (DisplayType.isLOB(displayType)) {
				addBlob(columnName);
			} else if (columnName.equals(po.getUUIDColumnName()) && po.get_Value(columnName) == null) {
				continue;
			} else {
				add(columnName, "", new AttributesImpl());
			}
		}
	}

	public void addBlob(String columnName) {
		Object value = po.get_Value(columnName);
		if (value == null) {
			addString(columnName, "", new AttributesImpl());
			return;
		}

		PackOut packOut = ctx.packOut;
		byte[] data = null;
		String dataType = null;
		String fileName = null;
		try {
			if (value instanceof String) {
				data = ((String)value).getBytes("UTF-8");
				dataType = "string";
			} else {
				data = (byte[]) value;
				dataType = "byte[]";
			}

			fileName = packOut.writeBlob(data);
		} catch (Exception e) {
			throw new AdempiereException(e.getLocalizedMessage(), e);
		}

		addString(columnName, fileName + "|" + dataType, new AttributesImpl());
	}
}
