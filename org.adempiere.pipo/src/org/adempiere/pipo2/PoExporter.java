package org.adempiere.pipo2;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.I_AD_Org;
import org.compiere.model.MArchive;
import org.compiere.model.MAttachment;
import org.compiere.model.MClientInfo;
import org.compiere.model.MImage;
import org.compiere.model.MStorageProvider;
import org.compiere.model.MTable;
import org.compiere.model.MTree;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.X_AD_Client;
import org.compiere.model.X_AD_Image;
import org.compiere.model.X_AD_Org;
import org.compiere.model.X_C_Location;
import org.compiere.model.X_M_Locator;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class PoExporter {

	private PO po = null;

	@SuppressWarnings("unused")
	private static final CLogger log = CLogger.getCLogger(PoExporter.class);
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
		addTextElement(name, boolValue == true ? "Y" : "N", atts);
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
			addTextElement(columnName, (Boolean)value == true ? "Y" : "N", atts);
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

	public void addTableReference(String tableName, AttributesImpl atts) {
		String columnName = tableName + "_ID";
		addTableReference(columnName, tableName, atts);
	}

	public void addTableReference(String columnName, String tableName, AttributesImpl atts) {
		int id = po.get_Value(columnName) != null ? (Integer)po.get_Value(columnName) : -1;
		addTableReference(columnName, tableName, id, atts);
	}

	public void addTableReference(String columnName, String tableName, int id, AttributesImpl atts) {
		String value = ReferenceUtils.getTableReference(tableName, id, atts);
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
			if (excludes == null || !excludes.contains("ad_org_id"))
				addString("AD_Org_ID", "0", new AttributesImpl());
		}
		else
		{
			if (excludes == null || !excludes.contains("ad_org_id"))
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
						addTableReference("AD_Client_ID", X_AD_Client.Table_Name, new AttributesImpl());
						if (!(I_AD_Org.Table_Name.equals(po.get_TableName())))
							addTableReference("AD_Org_ID", X_AD_Org.Table_Name, new AttributesImpl());
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
			
			//only export official id
			if (columnName.equalsIgnoreCase(info.getTableName()+"_ID")) {
				int id = po.get_ID();
				if (id > 0 && id <= MTable.MAX_OFFICIAL_ID) {
					add(columnName, new AttributesImpl());
				}
				continue;
			}

			int displayType = info.getColumnDisplayType(i);
			if (DisplayType.YesNo == displayType) {
				add(columnName, false, new AttributesImpl());
			} else if (DisplayType.TableDir == displayType || DisplayType.ID == displayType) {
				String tableName = null;
				if ("Record_ID".equalsIgnoreCase(columnName) && po.get_ColumnIndex("AD_Table_ID") >= 0) {
					int AD_Table_ID = po.get_Value(po.get_ColumnIndex("AD_Table_ID")) != null
							? (Integer)po.get_Value(po.get_ColumnIndex("AD_Table_ID")) : 0;
					tableName = MTable.getTableName(ctx.ctx, AD_Table_ID);
				} else if (po.get_TableName().equals("AD_TreeNode") && columnName.equals("Parent_ID")) {
					int AD_Tree_ID = po.get_ValueAsInt("AD_Tree_ID");
					MTree tree = new MTree(ctx.ctx, AD_Tree_ID, ctx.trx.getTrxName());
					tableName = tree.getSourceTableName(true);
				} else if (po.get_TableName().equals("AD_TreeNode") && columnName.equals("Node_ID")) {
					int AD_Tree_ID = po.get_ValueAsInt("AD_Tree_ID");
					MTree tree = new MTree(ctx.ctx, AD_Tree_ID, ctx.trx.getTrxName());
					tableName = tree.getSourceTableName(true);
				} else {
					tableName = columnName.substring(0, columnName.length() - 3);
				}
				addTableReference(columnName, tableName, new AttributesImpl());
			} else if (DisplayType.isList(displayType)) {
				add(columnName, "", new AttributesImpl());
			} else if (DisplayType.isLookup(displayType)) {
				String tableName = null;
				if ("Record_ID".equalsIgnoreCase(columnName) && po.get_ColumnIndex("AD_Table_ID") >= 0) {
					int AD_Table_ID = po.get_Value(po.get_ColumnIndex("AD_Table_ID")) != null
						? (Integer)po.get_Value(po.get_ColumnIndex("AD_Table_ID")) : 0;
					tableName = MTable.getTableName(ctx.ctx, AD_Table_ID);
				} else if (info.getColumnLookup(i) != null){
					String lookupColumn = info.getColumnLookup(i).getColumnName();
					tableName = lookupColumn.substring(0, lookupColumn.indexOf("."));
				} 
				addTableReference(columnName, tableName, new AttributesImpl());
			} else if (DisplayType.Account == displayType) {
				String tableName = "C_ValidCombination";
				addTableReference(columnName, tableName, new AttributesImpl());
			} else if (DisplayType.isLOB(displayType)) {
				addBlob(columnName);
			} else if (columnName.equals(po.getUUIDColumnName()) && po.get_Value(columnName) == null) {
				continue;
			} else if (DisplayType.Locator == displayType) {
			    addTableReference(columnName, X_M_Locator.Table_Name, new AttributesImpl());
			} else if (DisplayType.Location == displayType) {
			    addTableReference(columnName, X_C_Location.Table_Name, new AttributesImpl());
			} else if (DisplayType.Image == displayType) {
				addTableReference(columnName, X_AD_Image.Table_Name, new AttributesImpl());
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

		if ("BinaryData".equals(columnName)) {
			MClientInfo ci = MClientInfo.get(po.getAD_Client_ID());
			if (po.get_Table_ID() == MAttachment.Table_ID && ci.getAD_StorageProvider_ID() > 0) {
				MStorageProvider sp = new MStorageProvider(po.getCtx(), ci.getAD_StorageProvider_ID(), po.get_TrxName());
				if (! MStorageProvider.METHOD_Database.equals(sp.getMethod())) {
					MAttachment att = new MAttachment(po.getCtx(), po.get_ID(), po.get_TrxName());
					File tmpfile = att.saveAsZip();
					try {
						value = Files.readAllBytes(tmpfile.toPath());
					} catch (IOException e) {
						throw new AdempiereException(e);
					}
				}
			} else if (po.get_Table_ID() == MImage.Table_ID && ci.getStorageImage_ID() > 0) {
				MStorageProvider sp = new MStorageProvider(po.getCtx(), ci.getStorageImage_ID(), po.get_TrxName());
				if (! MStorageProvider.METHOD_Database.equals(sp.getMethod())) {
					MImage image = new MImage(po.getCtx(), po.get_ID(), po.get_TrxName());
					value = image.getBinaryData();
				}
			} else if (po.get_Table_ID() == MArchive.Table_ID && ci.getStorageArchive_ID() > 0) {
				MStorageProvider sp = new MStorageProvider(po.getCtx(), ci.getStorageArchive_ID(), po.get_TrxName());
				if (! MStorageProvider.METHOD_Database.equals(sp.getMethod())) {
					MArchive archive = new MArchive(po.getCtx(), po.get_ID(), po.get_TrxName());
					File tmpfile = archive.saveAsZip();
					try {
						value = Files.readAllBytes(tmpfile.toPath());
					} catch (IOException e) {
						throw new AdempiereException(e);
					}
				}
			}
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
