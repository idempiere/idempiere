package org.adempiere.pipo2;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipInputStream;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MArchive;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MColumn;
import org.compiere.model.MImage;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;

public class PoFiller{

	PO po = null;
	@SuppressWarnings("unused")
	private AbstractElementHandler handler;
	private PIPOContext ctx;
	private Element element;

	/**
	 *
	 * @param po
	 * @param atts
	 * @param handler
	 */
	public PoFiller(PIPOContext ctx, PO po, Element element, AbstractElementHandler handler){

		this.ctx = ctx;
		this.po = po;
		this.element = element;
		this.handler = handler;
	}

	protected String getStringValue (String columnName){
		Element e = element.properties.get(columnName);
		String value = e != null ? e.contents.toString() : null;

		value = "".equals(value) ? null : value;
		return value;
	}
	
	protected boolean isBlobOnPackinFile (String columnName){
		String value = getStringValue(columnName);
		if(value == null)
			return false;

		String strParts [] = value.split("[|]");
		return (   strParts.length == 2
				&& strParts[0].endsWith(PackOut.PACKOUT_BLOB_FILE_EXTENSION)
				&& (   PoExporter.POEXPORTER_BLOB_TYPE_STRING.equals(strParts[1]) // see PoExporter.addBlob
					|| PoExporter.POEXPORTER_BLOB_TYPE_BYTEARRAY.equals(strParts[1])));
	}
	
	/**
	 *
	 * @param columnName
	 */
	public void setString(String columnName){
		String value = getStringValue(columnName);

		Object oldValue = po.get_Value(columnName);
		if (value == null && oldValue == null)
			return;
		else if (oldValue != null && oldValue.toString().equals(value))
			return;
		else {
			if (po instanceof MColumn && "IsToolbarButton".equals(columnName)) {
				// IDEMPIERE-2064 - backward compatibility with 2packs generated before IDEMPIERE-2477
				if ("true".equals(value))
					value ="Y";
				else if ("false".equals(value))
					value ="N";
			}
			po.set_ValueNoCheck(columnName, value);
		}
	}

	/**
	 *
	 * @param columnName
	 */
	public void setBoolean(String columnName){

		Element e = element.properties.get(columnName);
		String value = e != null ? e.contents.toString() : null;

		boolean bool = "true".equals(value) || "Y".equals(value) ? true : false;

		if (po.get_Value(columnName) != null && po.get_ValueAsBoolean(columnName) == bool)
			return;
		else
			po.set_ValueNoCheck(columnName, bool);
	}

	/**
	 *
	 * @param qName
	 */
	public void setTimestamp(String qName) {
		Element e = element.properties.get(qName);
		String value = e != null ? e.contents.toString() : null;

		if (value!=null && value.trim().length() == 0)
			value = null;
		Timestamp ts = value != null ? Timestamp.valueOf(value) : null;

		Object oldValue = po.get_Value(qName);
		if (oldValue == null && ts == null)
			return;
		else if (oldValue != null && oldValue.equals(ts))
			return;
		else
			po.set_ValueNoCheck(qName, ts);
	}

	/**
	 *
	 * @param qName
	 */
	public void setInteger(String qName) {
		Element e = element.properties.get(qName);
		String value = e != null ? e.contents.toString() : null;

		if (value!=null && value.trim().length() == 0)
			value = null;
		Integer i = value != null ? Integer.valueOf(value) : null;

		Object oldValue = po.get_Value(qName);
		if (oldValue == null && i == null)
			return;
		else if (oldValue != null && oldValue.equals(i))
			return;
		else
			po.set_ValueNoCheck(qName, i);
	}

	/**
	 *
	 * @param qName
	 */
	public void setBigDecimal(String qName) {
		Element e = element.properties.get(qName);
		String value = e != null ? e.contents.toString() : null;

		if (value!=null && value.trim().length() == 0)
			value = null;
		BigDecimal bd = value != null ? new BigDecimal(value) : null;

		Object oldValue = po.get_Value(qName);
		if (oldValue == null && bd == null)
			return;
		else if (oldValue != null && oldValue.equals(bd))
			return;
		else
			po.set_ValueNoCheck(qName, bd);
	}

	/**
	 *
	 * @param qName
	 */
	public int setTableReference(String qName) {
		Element e = element.properties.get(qName);
		if (e == null)
			return 0;

		String value = e.contents.toString();
		String columnName = qName;
		if (value != null && value.trim().length() > 0) {
			int id = ReferenceUtils.resolveReference(ctx.ctx, e, po.get_TrxName());
			if (columnName.equals("AD_Client_ID") && id > 0) {
				if (id != Env.getAD_Client_ID(ctx.ctx)) {
					return -1;
				}
			}
			if (po.get_ColumnIndex(columnName) >= 0) {
				MColumn col = MColumn.get(ctx.ctx, po.get_TableName(), columnName, po.get_TrxName());
				MTable foreignTable = null;
				String refTableName = col.getReferenceTableName();
				if (refTableName != null) {
					foreignTable = MTable.get(Env.getCtx(), refTableName, po.get_TrxName());
				} else {
					if ("Record_ID".equalsIgnoreCase(columnName)) {
						// special case - get the foreign table using AD_Table_ID
						int tableID = 0;
						try {
							// try it first from the XML element, is possible that the table is still not filled in the po object
							tableID = Integer.parseInt(e.parent.properties.get("AD_Table_ID").contents.toString());
						} catch (Exception e1) {}
						if (tableID == 0) {
							// XML didn't work, try the po object
							int idxTableID = po.get_ColumnIndex("AD_Table_ID");
							if (idxTableID >= 0) {
								tableID = po.get_ValueAsInt(idxTableID);
							}
						}
						if (tableID > 0) {
							foreignTable = MTable.get(Env.getCtx(), tableID, po.get_TrxName());
							refTableName = foreignTable.getTableName();
						}
					}
				}
				if (id > 0 && refTableName != null) {
					if (foreignTable != null) {
						/* Allow to read here from another tenant, cross tenant control is implemented later in a safe way */
						PO subPo = null;
		    			try {
		    				PO.setCrossTenantSafe();
		    				subPo = foreignTable.getPO(id, po.get_TrxName());
		    			} finally {
		    				PO.clearCrossTenantSafe();
		    			}
						if (subPo != null && subPo.getAD_Client_ID() != Env.getAD_Client_ID(ctx.ctx)) {
							String accessLevel = foreignTable.getAccessLevel();
							if ((MTable.ACCESSLEVEL_All.equals(accessLevel)
									|| MTable.ACCESSLEVEL_SystemOnly.equals(accessLevel)
									|| MTable.ACCESSLEVEL_SystemPlusClient.equals(accessLevel)) && 
									subPo.getAD_Client_ID() != 0)
								return -1;
						}
					}

					if (po.get_ValueAsInt(columnName) != id) {
						po.set_ValueNoCheck(columnName, id);
					}
					return id;
				} else if (id == 0) {
					if (refTableName != null && MTable.isZeroIDTable(refTableName)) {
						po.set_ValueNoCheck(columnName, id);
						return id;
					}
				}				
				return -1;
			} else {
				return 0;
			}
		} else {
			po.set_ValueNoCheck(columnName, null);
			return 0;
		}
	}

	/**
	 * process all attributes
	 * @param excludes list of attribute to exclude
	 */
	public List<String> autoFill(List<String> excludes) {
		POInfo info = POInfo.getPOInfo(po.getCtx(), po.get_Table_ID());
		List<String>notFounds = new ArrayList<String>();

		//special treatment for ad_client_id and ad_org_id
		Element clientElement = element.properties.get("AD_Client_ID");
		String sAD_Client_ID = clientElement != null ? clientElement.contents.toString() : null;
		if (sAD_Client_ID != null && sAD_Client_ID.equals("0"))
		{
			if (po.getAD_Client_ID() != 0)
				po.set_ValueNoCheck("AD_Client_ID", 0);
			if (po.getAD_Org_ID() != 0)
				po.setAD_Org_ID(0);
		}
		else
		{
			Element orgElement = element.properties.get("AD_Org_ID");
			String sAD_Org_ID = orgElement != null ? orgElement.contents.toString() : null;
			if (sAD_Org_ID != null && sAD_Org_ID.equals("0")) {
				if (po.getAD_Org_ID() != 0) {
					po.setAD_Org_ID(0);
				}
			} else if (sAD_Org_ID != null && sAD_Org_ID.equals("@AD_Org_ID@")) {
				po.setAD_Org_ID(Env.getAD_Org_ID(ctx.ctx));
			} else {
				if (setTableReference("AD_Client_ID") >= 0)
					setTableReference("AD_Org_ID");
			}
		}

		for(String qName : element.properties.keySet()) {
			if (excludes != null ){
				boolean exclude = false;
				for(String ex : excludes)
				{
					if (ex.equalsIgnoreCase(qName))
					{
						exclude = true;
						break;
					}
				}
				if (exclude)
					continue;
			}
			Element e = element.properties.get(qName);
			if (ReferenceUtils.isLookup(e)) {
				int id = setTableReference(qName);
				if (id < 0) {
					notFounds.add(qName);
				}
			} else {
				int index = info.getColumnIndex(qName);
				if (index < 0)
					continue;
				
				//only import official id
				if (qName.equalsIgnoreCase(po.get_TableName()+"_ID")) {
					String value = e != null ? e.contents.toString() : null;
					Integer i = !Util.isEmpty(value) ? Integer.valueOf(value) : null;
					if (i != null && i.intValue() > 0 && i.intValue() <= MTable.MAX_OFFICIAL_ID) {
						if (po.get_ID() != i.intValue()) {
							//make sure id have not been used by other client
							int AD_Client_ID = Env.getAD_Client_ID(ctx.ctx); 
							int tmp = DB.getSQLValue(ctx.trx.getTrxName(), 
								"SELECT AD_Client_ID FROM " + po.get_TableName() + " WHERE " +
								po.get_TableName() + "_ID=?", i.intValue());
							if (tmp <= 0 || tmp == AD_Client_ID) {
								setInteger(qName);
							} 
						}
					}
					continue;
				} else if (qName.equals(po.getUUIDColumnName())) {
					if (Env.getAD_Client_ID(ctx.ctx) > 0) {
						String uuid = e != null ? e.contents.toString() : null;
						if (!Util.isEmpty(uuid)) {
							uuid = POFinder.getTargetUUID(ctx.ctx, po.get_TableName(), uuid, ctx.trx.getTrxName());
							po.set_ValueNoCheck(qName, uuid);
						}
					} else {
						setString(qName);
					}
					continue;
				}
				
				if (info.getColumnClass(index) == Boolean.class) {
					setBoolean(qName);
				} else if (info.getColumnClass(index) == BigDecimal.class){
					setBigDecimal(qName);
				} else if (info.getColumnClass(index) == Integer.class) {
					setInteger(qName);
				} else if (info.getColumnClass(index) == Timestamp.class) {
					setTimestamp(qName);
				}else if(DisplayType.TextLong == info.getColumnDisplayType(index)) {// export column from system have type is normal string, but import to system have this column but type is textlong (mean blob)
					if (getStringValue (qName) != null && !isBlobOnPackinFile(qName)) {
						setString(qName);
					}else {
						setBlob(qName);
					}
				} else if (DisplayType.isLOB(info.getColumnDisplayType(index))) {
					setBlob(qName);
				} else {
					if (isBlobOnPackinFile(qName)) {
						setBlob(qName);
					} else {
						setString(qName);
					}
				}
			}
		}
		return notFounds;
	}

	private void setBlob(String qName) {
		Element pe = element.properties.get(qName);
		String value = pe != null ? pe.contents.toString() : null;
		if (value != null && value.trim().length() > 0) {
			if (po instanceof MAttachment && "BinaryData".equals(qName)) {
				PackIn packIn = ctx.packIn;
				String fileName = null;
				String[] component = value.split("[|]");
				if (component.length == 2) {
					fileName = component[0];
					File[] files;
					try {
						files = packIn.readFilesFromBlob(fileName);
					} catch (IOException e) {
						throw new AdempiereException(e.getLocalizedMessage(), e);
					}
					MAttachment attach = ((MAttachment)po);
					for (File file : files) {
						boolean found = false;
						int index = -1;
						for (MAttachmentEntry entry : attach.getEntries()) {
							index++;
							if (entry.getName().equals(file.getName())) {
								found = true;
								attach.updateEntry(index, file);
								break;
							}
						}
						if (! found)
							attach.addEntry(file);
					}
					if (!attach.is_Changed())
						attach.set_ValueNoCheck("Updated", new Timestamp(System.currentTimeMillis()));
				}
			} else {
				Object data = null;
				byte[] bytes = null;
				String fileName = null;
				String[] component = value.split("[|]");
				if (component.length == 2) {
					fileName = component[0];
					String dataType = component[1];
					PackIn packIn = ctx.packIn;
					try {
						bytes = packIn.readBlob(fileName);
						if (PoExporter.POEXPORTER_BLOB_TYPE_BYTEARRAY.equals(dataType)) {
							data = bytes;
						} else {
							data = new String(bytes, "UTF-8");
						}
					} catch (IOException e) {
						throw new AdempiereException(e.getLocalizedMessage(), e);
					}
				}
				if ("BinaryData".equals(qName) && data instanceof byte[]) {
					if (po instanceof MArchive) {
						/* it comes as a zip file with a single PDF file */
					    byte[] output = null;
					    try (ZipInputStream zipStream = new ZipInputStream(new ByteArrayInputStream((byte[]) data));) {
							if (zipStream.getNextEntry() != null) {
								output = zipStream.readAllBytes();
							}
						} catch (Exception e) {
							throw new AdempiereException(e.getLocalizedMessage(), e);
						}
						if (output != null) {
						    ((MArchive) po).setBinaryData((byte[]) output);
						} else {
							throw new AdempiereException("Zip file for Archive could not be decompressed");
						}
					} else if (po instanceof MImage) {
						((MImage) po).setBinaryData((byte[]) data);
					} else {
						po.set_ValueNoCheck(qName, data);
					}
				} else {
					po.set_ValueNoCheck(qName, data);
				}
			}
		}
	}
}
