package org.adempiere.pipo2;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;

public class PoFiller{

	PO po = null;
	private AbstractElementHandler handler;
	private Properties ctx;
	private Element element;

	/**
	 *
	 * @param po
	 * @param atts
	 * @param handler
	 */
	public PoFiller(Properties ctx, PO po, Element element, AbstractElementHandler handler){

		this.ctx = ctx;
		this.po = po;
		this.element = element;
		this.handler = handler;
	}

	/**
	 *
	 * @param columnName
	 */
	public void setString(String columnName){

		Element e = element.properties.get(columnName);
		String value = e != null ? e.contents.toString() : null;

		value = "".equals(value) ? null : value;

		po.set_ValueOfColumn(columnName, value);
	}

	/**
	 *
	 * @param columnName
	 */
	public void setBoolean(String columnName){

		Element e = element.properties.get(columnName);
		String value = e != null ? e.contents.toString() : null;

		boolean bool = "true".equals(value) ? true : false;

		po.set_ValueOfColumn(columnName, bool);
	}

	/**
	 *
	 * @param qName
	 */
	public void setTimestamp(String qName) {
		Element e = element.properties.get(qName);
		String value = e != null ? e.contents.toString() : null;

		if (value.trim().length() == 0)
			value = null;
		Timestamp ts = value != null ? Timestamp.valueOf(value) : null;

		po.set_ValueOfColumn(qName, ts);
	}

	/**
	 *
	 * @param qName
	 */
	public void setInteger(String qName) {
		Element e = element.properties.get(qName);
		String value = e != null ? e.contents.toString() : null;

		if (value.trim().length() == 0)
			value = null;
		Integer i = value != null ? new Integer(value) : null;

		po.set_ValueOfColumn(qName, i);
	}

	/**
	 *
	 * @param qName
	 */
	public void setBigDecimal(String qName) {
		Element e = element.properties.get(qName);
		String value = e != null ? e.contents.toString() : null;

		if (value.trim().length() == 0)
			value = null;
		BigDecimal bd = value != null ? new BigDecimal(value) : null;

		po.set_ValueOfColumn(qName, bd);
	}

	public static int findTableReference(Properties ctx, AbstractElementHandler handler, Element element, String qName) {
		Element propertyElement = element.properties.get(qName);
		if (propertyElement == null)
			return 0;

		int id = 0;
		String value = propertyElement.contents.toString();
		if (value != null && value.trim().length() > 0)
		{
			String[] names = qName.split("[.]");
			if (names.length < 2)
				return 0;
			String columnName = names[0];
			if (names.length != 3)
				columnName = columnName + "_ID";
			String tableName = names.length == 3 ? names[1] : names[0];
			String searchColumn = names.length == 3 ? names[2] : names[1];

			id = handler.findIdByColumn(ctx, tableName, searchColumn, value.trim());
		}
		return id;
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
			int id = ReferenceUtils.resolveReference(ctx, e, po.get_TrxName());
			if (columnName.equals("AD_Client_ID") && id > 0) {
				if (id != Env.getAD_Client_ID(ctx)) {
					return -1;
				}
			}
			if (po.get_ColumnIndex(columnName) >= 0) {
				if (id > 0) {
					po.set_ValueOfColumn(columnName, id);
					return id;
				}
				return -1;
			} else {
				return 0;
			}
		} else {
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

		//special treatment for ad_org_id
		Element orgElement = element.properties.get("AD_Org_ID");
		String sAD_Org_ID = orgElement != null ? orgElement.contents.toString() : null;
		if (sAD_Org_ID != null && sAD_Org_ID.equals("0"))
			po.setAD_Org_ID(0);
		else if (sAD_Org_ID != null && sAD_Org_ID.equals("@AD_Org_ID@"))
			po.setAD_Org_ID(Env.getAD_Org_ID(ctx));
		else {
			if (setTableReference("AD_Client_ID") >= 0)
				setTableReference("AD_Org_ID");
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
			if ("table".equalsIgnoreCase(e.attributes.getValue("reference"))) {
				int id = setTableReference(qName);
				if (id < 0) {
					notFounds.add(qName);
				}
			} else {
				int index = info.getColumnIndex(qName);
				if (index < 0)
					continue;
				if (info.getColumnClass(index) == Boolean.class) {
					setBoolean(qName);
				} else if (info.getColumnClass(index) == BigDecimal.class){
					setBigDecimal(qName);
				} else if (info.getColumnClass(index) == Integer.class) {
					setInteger(qName);
				} else if (info.getColumnClass(index) == Timestamp.class) {
					setTimestamp(qName);
				} else if (DisplayType.isLOB(info.getColumnDisplayType(index))) {
					setBlob(qName);
				} else {
					setString(qName);
				}
			}
		}
		return notFounds;
	}

	private void setBlob(String qName) {
		Element pe = element.properties.get(qName);
		String value = pe != null ? pe.contents.toString() : null;
		Object data = null;
		if (value != null && value.trim().length() > 0) {
			String[] component = value.split("[|]");
			if (component.length == 2) {
				String fileName = component[0];
				String dataType = component[1];
				PackIn packIn = handler.getPackIn(ctx);
				try {
					byte[] bytes = packIn.readBlob(fileName);
					if ("byte[]".equals(dataType)) {
						data = bytes;
					} else {
						data = new String(bytes, "UTF-8");
					}
				} catch (IOException e) {
					throw new AdempiereException(e.getLocalizedMessage(), e);
				}
			}
		}
		po.set_ValueOfColumn(qName, data);
	}
}
