package org.adempiere.pipo2;

import java.io.UnsupportedEncodingException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.adempiere.exceptions.DBException;
import org.apache.commons.codec.binary.Hex;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceUtils {

	/**
	 *
	 * @param ctx
	 * @param e
	 * @param trxName
	 * @return positive id if found
	 */
	public static int resolveReference(Properties ctx, Element e, String trxName)
	{
		String value = e.contents.toString();
		String referenceKey = e.attributes.getValue("reference-key");
		if (value != null && value.trim().length() > 0)
		{
			if (isTableLookup(e))
			{
				String[] names = referenceKey.split("[.]");
				if (names.length < 2)
					return 0;
				String tableName = names[0];
				String searchColumn = names[1];

				return IDFinder.findIdByColumn(tableName, searchColumn, value.trim(), Env.getAD_Client_ID(ctx), trxName);
			}
			else if (isIDLookup(e))
			{
				int id = Integer.parseInt(value);
				return id;
			}
			else if (isUUIDLookup(e))
			{
				return IDFinder.findIdByColumn(referenceKey, PO.getUUIDColumnName(referenceKey), value.trim(), Env.getAD_Client_ID(ctx), trxName);
			}
			else
			{
				throw new IllegalArgumentException("Unknown table reference type="+e.attributes.getValue("reference"));
			}
		}
		else
		{
			return 0;
		}
	}

	public static boolean isLookup(Element element)
	{
		if (isIDLookup(element) || isUUIDLookup(element) || isTableLookup(element))
			return true;
		else
			return false;
	}

	public static boolean isIDLookup(Element element)
	{
		return "id".equals(element.attributes.getValue("reference"));
	}

	public static boolean isUUIDLookup(Element element)
	{
		return "uuid".equals(element.attributes.getValue("reference"));
	}

	public static boolean isTableLookup(Element element)
	{
		return "table".equals(element.attributes.getValue("reference"));
	}

	public static String getTableReference(String tableName, String searchColumn, int id, AttributesImpl atts)
	{
		String keyColumn = tableName + "_ID";
		if (   (id > 0 && id <= PackOut.MAX_OFFICIAL_ID)
			|| (id == 0 && MTable.isZeroIDTable(tableName)))
		{
			//official id
			atts.addAttribute("", "", "reference", "CDATA", "id");
			String value = Integer.toString(id);
			return value;
		}
		else if (id == 0)
		{
			//no id, should never happen
			atts.addAttribute("", "", "reference", "CDATA", "id");
			return "";
		}
		else
		{
			MTable table = MTable.get(Env.getCtx(), tableName);
			if (table == null)
				throw new RuntimeException("Table Not Found. TableName="+tableName);
			String uuidColumnName = PO.getUUIDColumnName(tableName);
			if (table.getColumn(uuidColumnName) != null)
			{
				//uuid
				String sql = "SELECT " + uuidColumnName + " FROM "
						+ tableName + " WHERE " + keyColumn + " = ?";
				String value = DB.getSQLValueString(null, sql, id);
				if (value != null && value.trim().length() > 0)
				{
					atts.addAttribute("", "", "reference", "CDATA", "uuid");
					atts.addAttribute("", "", "reference-key", "CDATA", tableName);
					return value.trim();
				}
			}

			//search column
			if (searchColumn.indexOf(",") > 0) {
				//composite search column
				String value = "";
				String[] columns = searchColumn.split("[,]");
				PreparedStatement stmt = null;
				ResultSet rs = null;
				try {
					stmt = DB.prepareStatement("SELECT " + searchColumn + " FROM " + tableName, null);
					rs = stmt.executeQuery();
					if (rs.next()) {
						for(int i = 0; i < columns.length; i++) {
							Object o = rs.getObject(i+1);
							String s = o != null ? o.toString() : "";
							if (s.length() > 0) {
								char[] chars = Hex.encodeHex(s.getBytes("UTF-8"));
								s = new String(chars);
							}
							if (i == 0) {
								value = s;
							} else {
								value = value+","+s;
							}
						}
					}
				} catch (SQLException e) {
					throw new DBException(e);
				} catch (UnsupportedEncodingException e) {
					throw new RuntimeException(e);
				} finally {
					DB.close(rs, stmt);
				}
				StringBuilder buffer = new StringBuilder();
				buffer.append(tableName).append(".").append(searchColumn);
				atts.addAttribute("", "", "reference", "CDATA", "table");
				atts.addAttribute("", "", "reference-key", "CDATA", buffer.toString());
				return value;
			} else {
				String sql = "SELECT " + searchColumn + " FROM "
					+ tableName + " WHERE " + keyColumn + " = ?";
				String value = DB.getSQLValueString(null, sql, id);
				StringBuilder buffer = new StringBuilder();
				buffer.append(tableName).append(".").append(searchColumn);
				atts.addAttribute("", "", "reference", "CDATA", "table");
				atts.addAttribute("", "", "reference-key", "CDATA", buffer.toString());
				return value;
			}
		}
	}
}


