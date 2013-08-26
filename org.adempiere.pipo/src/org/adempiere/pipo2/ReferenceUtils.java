package org.adempiere.pipo2;

import java.util.Properties;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceUtils {

	@SuppressWarnings("unused")
	private final static CLogger log = CLogger.getCLogger(ReferenceUtils.class);
	
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
			if (isIDLookup(e))
			{
				int id = Integer.parseInt(value);
				return id;
			}
			else if (isUUIDLookup(e))
			{
				String uuid = value.trim();
				String target = Env.getAD_Client_ID(ctx) > 0 ? POFinder.getTargetUUID(ctx, referenceKey, uuid, trxName) : uuid;
				int id = IDFinder.findIdByColumn(referenceKey, PO.getUUIDColumnName(referenceKey), target, Env.getAD_Client_ID(ctx), trxName);
				return id;
			}
			else
			{
				throw new IllegalArgumentException("Unknown column reference type="+e.attributes.getValue("reference"));
			}
		}
		else
		{
			return 0;
		}
	}

	public static boolean isLookup(Element element)
	{
		if (isIDLookup(element) || isUUIDLookup(element))
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

	public static String getTableReference(String tableName, int id, AttributesImpl atts)
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
		else if (id <= 0)
		{
			//no id, -1 indicates it was read a null
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
		}
		
		//should never reach here
		atts.addAttribute("", "", "reference", "CDATA", "id");
		return "";
	}
}


