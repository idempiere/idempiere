package org.adempiere.pipo2;

import java.util.Properties;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
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
	public static int resolveReferenceAsInt(Properties ctx, Element e, String trxName)
	{
		Object id = resolveReference(ctx, e, trxName);
		if (id instanceof Number)
			return ((Number)id).intValue();
		return -1;
	}

	/**
	 *
	 * @param ctx
	 * @param e
	 * @param trxName
	 * @return positive id if found
	 */
	public static Object resolveReference(Properties ctx, Element e, String trxName)
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
				Object id = IDFinder.findIdByColumn(referenceKey, PO.getUUIDColumnName(referenceKey), target, Env.getAD_Client_ID(ctx), trxName);
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

	/**
	 *
	 * @param ctx
	 * @param e
	 * @param trxName
	 * @return list of IDs or UUIDs if found
	 */
	public static Object resolveReferenceMulti(Properties ctx, Element e, String trxName)
	{
		String values = e.contents.toString();
		String referenceKey = e.attributes.getValue("reference-key");
		if (values != null && values.trim().length() > 0) {
			String target_values = null;
			for (String uuid : values.split(",")) {
				// multi is always UUID, even for official IDs
				String target = Env.getAD_Client_ID(ctx) > 0 ? POFinder.getTargetUUID(ctx, referenceKey, uuid, trxName) : uuid;
				Object id = IDFinder.findIdByColumn(referenceKey, PO.getUUIDColumnName(referenceKey), target, Env.getAD_Client_ID(ctx), trxName);
				if (id == null) // one of the multi UUID was not found, invalidate the complete string
					return -1;
				if (target_values == null)
					target_values = id.toString();
				else
					target_values += "," + id.toString();
			}
			return target_values;
		} else {
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

	public static String getTableReference(String tableName, int id, AttributesImpl atts, String trxName)
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
			MTable table = MTable.get(Env.getCtx(), tableName, trxName);
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

	public static String getTableReferenceUUID(String tableName, String uuid, AttributesImpl atts)
	{
		if (Util.isEmpty(uuid))
		{
			//no uuid
			atts.addAttribute("", "", "reference", "CDATA", "uuid");
			return "";
		}
		else
		{
			//uuid
			atts.addAttribute("", "", "reference", "CDATA", "uuid");
			atts.addAttribute("", "", "reference-key", "CDATA", tableName);
			return uuid.trim();
		}
	}

	public static String getTableReferenceMulti(String tableName, String values, AttributesImpl atts, String trxName)
	{
		atts.addAttribute("", "", "reference", "CDATA", "uuid");
		if (Util.isEmpty(values)) {
			return "";
		}
		MTable table = MTable.get(Env.getCtx(), tableName, trxName);
		if (table == null)
			throw new RuntimeException("Table Not Found. TableName="+tableName);
		if (table.isUUIDKeyTable()) {
			//uuid
			atts.addAttribute("", "", "reference-key", "CDATA", tableName);
			return values.trim();
		}

		// convert multi-IDs to multi-UUIDs
		String target_values = "";
		String keyColumn = tableName + "_ID";
		String uuidColumnName = PO.getUUIDColumnName(tableName);
		for (String value : values.split(",")) {
			int id = Integer.valueOf(value);
			// Translate always IDs to UUIDs, even for official IDs,
			// because it would be more complex to manage a combination of official IDs and UUIDs
			if (table.getColumn(uuidColumnName) != null) {
				//uuid
				String sql = "SELECT " + uuidColumnName + " FROM "
						+ tableName + " WHERE " + keyColumn + " = ?";
				String valuePartial = DB.getSQLValueString(null, sql, id);
				if (!Util.isEmpty(valuePartial, true)) {
					if (target_values.length() == 0)
						target_values = valuePartial;
					else
						target_values += "," + valuePartial;
				}
			}
		}
		atts.addAttribute("", "", "reference-key", "CDATA", tableName);
		return target_values;
	}

}