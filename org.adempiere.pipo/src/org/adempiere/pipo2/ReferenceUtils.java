package org.adempiere.pipo2;

import java.util.Properties;

import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceUtils {

	public static int resolveReference(Properties ctx, Element e)
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

				return IDFinder.findIdByColumn(tableName, searchColumn, value.trim(), Env.getAD_Client_ID(ctx), null);
			}
			else if (isIDLookup(e))
			{
				int id = Integer.parseInt(value);
				return id;
			}
			else if (isUUIDLookup(e))
			{
				return IDFinder.findIdByColumn(referenceKey, referenceKey + "_UU", value.trim(), Env.getAD_Client_ID(ctx), null);
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
		String sql = "SELECT " + searchColumn + " FROM "
			+ tableName + " WHERE " + keyColumn + " = ?";
		if (id > 0 && id <= PackOut.MAX_OFFICIAL_ID)
		{
			atts.addAttribute("", "", "reference", "CDATA", "id");
			String value = Integer.toString(id);
			return value;
		}
		else if (id == 0)
		{
			atts.addAttribute("", "", "reference", "CDATA", "id");
			return "";
		}
		else
		{
			MTable table = MTable.get(Env.getCtx(), tableName);
			if (table.get_ColumnIndex(tableName + "_UU") >= 0 )
			{
				sql = "SELECT " + tableName + "_UU" + " FROM "
						+ tableName + " WHERE " + keyColumn + " = ?";
				String value = DB.getSQLValueString(null, sql, id);
				if (value != null && value.trim().length() > 0)
				{
					atts.addAttribute("", "", "reference", "CDATA", "uuid");
					atts.addAttribute("", "", "reference-key", "CDATA", tableName);
					return value.trim();
				}
			}

			String value = DB.getSQLValueString(null, sql, id);
			StringBuffer buffer = new StringBuffer();
			buffer.append(tableName).append(".").append(searchColumn);
			atts.addAttribute("", "", "reference", "CDATA", "table");
			atts.addAttribute("", "", "reference-key", "CDATA", buffer.toString());
			return value;
		}
	}
}


