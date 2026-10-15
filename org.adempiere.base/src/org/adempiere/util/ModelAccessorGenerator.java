/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.adempiere.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.TreeSet;

import org.adempiere.exceptions.DBException;
import org.compiere.Adempiere;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Util;

/**
 * Generate an accessor class for the columns of a table selected by the column entity type filter: typed getters and
 * setters over any {@link org.compiere.model.PO} of that table, with the behaviour of the generated X_ accessors.
 * <p>
 * Example: {@code C_OrderSource_XYZ.of(orderSource).getShippingRule()}. The class needs no model factory and works
 * on any object of the table, also one that core created with {@code new MOrderSource(...)}. In a callout,
 * {@code C_OrderSource_XYZ.of(mTab)} reads and writes the fields of the tab. With the interface generated in the same
 * run, the class implements it ({@code I_C_OrderSource_XYZ}).
 * <ul>
 * <li>int getter: 0 when empty; boolean getter: Boolean, "Y" true, otherwise false; BigDecimal getter: zero when empty</li>
 * <li>_ID setter: null below 1 (below 0 for the columns where 0 is valid, as in {@link ModelClassGenerator})</li>
 * <li>a column that is not updateable is written with set_ValueNoCheck; a virtual column cannot be set</li>
 * <li>set_Value reports a column the table does not have, so a renamed column fails at the first write</li>
 * <li>list columns get the value constants of the X_ class, for example {@code SHIPPINGRULE_Force}</li>
 * <li>on a GridTab: values go through GridTab.setValue, so dependent callouts run and the field's read-only rules
 * apply, also for a column that is not updateable (there is no NoCheck on a tab); an error of setValue or a column
 * the tab does not have is reported with an exception</li>
 * <li>an encrypted column is refused ({@link #checkColumns}): the accessor reads and writes through the public PO
 * methods, which do not encrypt</li>
 * </ul>
 */
public class ModelAccessorGenerator {

	private static final String NL = "\n";

	/**
	 * @param AD_Table_ID table
	 * @param directory output directory, package path included
	 * @param packageName package of the generated class
	 * @param entityTypeFilter column filter, as for the interface generator, or null for all columns
	 * @param suffix owner of the columns, class name {@code <Table>_<suffix>}; required
	 * @param implementInterface true when the interface of the same run ({@code I_<Table>[_<suffix>]}) is implemented
	 */
	public ModelAccessorGenerator(int AD_Table_ID, String directory, String packageName, String entityTypeFilter,
			String suffix, boolean implementInterface) {
		MTable table = MTable.get(AD_Table_ID);
		String tableName = table.getTableName();
		String className = className(tableName, suffix);
		String interfaceName = "I_" + className;

		TreeSet<String> imports = new TreeSet<>();
		imports.add("java.util.Properties");
		imports.add("org.adempiere.exceptions.AdempiereException");
		imports.add("org.compiere.model.GridTab");
		imports.add("org.compiere.model.PO");
		imports.add("org.compiere.util.Env");
		imports.add("org.compiere.util.Util");
		StringBuilder constants = new StringBuilder();
		StringBuilder listConstants = new StringBuilder();
		StringBuilder methods = new StringBuilder();

		String sql = "SELECT c.ColumnName, c.IsUpdateable, c.AD_Reference_ID, c.AD_Reference_Value_ID, c.ColumnSQL, c.IsKey, c.Name "
				+ "FROM AD_Column c WHERE c.AD_Table_ID=? AND c.IsActive='Y' "
				+ "AND (c.ColumnSQL IS NULL OR c.ColumnSQL NOT LIKE '@SQL%') "
				+ (!Util.isEmpty(entityTypeFilter) ? " AND c." + entityTypeFilter : "")
				+ " ORDER BY c.ColumnName";
		if (DB.isPostgreSQL())
			sql += " COLLATE \"C\"";
		else if (DB.isOracle())
			sql += " COLLATE \"BINARY\"";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Table_ID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String columnName = rs.getString(1);
				boolean updateable = "Y".equals(rs.getString(2));
				int displayType = rs.getInt(3);
				int referenceValueId = rs.getInt(4);
				boolean virtual = !Util.isEmpty(rs.getString(5), true);
				boolean key = "Y".equals(rs.getString(6));
				String name = rs.getString(7);
				Class<?> clazz = ModelInterfaceGenerator.getClass(columnName, displayType, referenceValueId);
				String dataType = ModelInterfaceGenerator.getDataTypeName(clazz, displayType);
				if (clazz == java.math.BigDecimal.class) { imports.add("java.math.BigDecimal"); }
				if (clazz == java.sql.Timestamp.class) imports.add("java.sql.Timestamp");
				String col = "COLUMNNAME_" + columnName;
				if (!implementInterface)
					constants.append("    /** Column name ").append(columnName).append(" */").append(NL)
						.append("    public static final String ").append(col).append(" = \"").append(columnName).append("\";").append(NL);
				String override = implementInterface ? "\t@Override" + NL : "";
				// list value constants, as in the X_ class
				if (referenceValueId != 0 && clazz == String.class)
					listConstants.append(ModelClassGenerator.addListValidation(new StringBuilder(), referenceValueId, columnName));

				// setter
				if (ModelInterfaceGenerator.isGenerateSetter(columnName)) {
					String set = updateable ? "set_Value" : "set_ValueNoCheck";
					methods.append(NL).append("\t/** Set ").append(name).append(" */").append(NL).append(override)
						.append("\tpublic void set").append(columnName).append(" (").append(dataType).append(" ").append(columnName).append(")").append(NL)
						.append("\t{").append(NL);
					if (virtual) {
						methods.append("\t\tthrow new IllegalArgumentException (\"").append(columnName).append(" is virtual column\");").append(NL);
					} else if (clazz == Integer.class) {
						if (columnName.endsWith("_ID")) {
							int firstOK = ModelClassGenerator.isZeroValidIdColumn(columnName) ? 0 : 1;
							methods.append("\t\tif (").append(columnName).append(" < ").append(firstOK).append(")").append(NL)
								.append("\t\t\t").append(set).append(" (").append(col).append(", null);").append(NL)
								.append("\t\telse").append(NL).append("\t");
						}
						methods.append("\t\t").append(set).append(" (").append(col).append(", Integer.valueOf(").append(columnName).append("));").append(NL);
					} else if (clazz == Boolean.class) {
						methods.append("\t\t").append(set).append(" (").append(col).append(", Boolean.valueOf(").append(columnName).append("));").append(NL);
					} else {
						methods.append("\t\t").append(set).append(" (").append(col).append(", ").append(columnName).append(");").append(NL);
					}
					methods.append("\t}").append(NL);
				}

				// getter
				String getter = clazz == Boolean.class
						? "is" + (columnName.toLowerCase().startsWith("is") ? columnName.substring(2) : columnName)
						: "get" + columnName;
				methods.append(NL).append("\t/** Get ").append(name).append(" */").append(NL).append(override)
					.append("\tpublic ").append(dataType).append(" ").append(getter).append("()").append(NL).append("\t{").append(NL);
				if (clazz == Integer.class) {
					methods.append("\t\tInteger ii = (Integer)get_Value(").append(col).append(");").append(NL)
						.append("\t\tif (ii == null)").append(NL).append("\t\t\t return 0;").append(NL)
						.append("\t\treturn ii.intValue();").append(NL);
				} else if (clazz == java.math.BigDecimal.class) {
					methods.append("\t\tBigDecimal bd = (BigDecimal)get_Value(").append(col).append(");").append(NL)
						.append("\t\tif (bd == null)").append(NL).append("\t\t\t return Env.ZERO;").append(NL)
						.append("\t\treturn bd;").append(NL);
				} else if (clazz == Boolean.class) {
					methods.append("\t\tObject oo = get_Value(").append(col).append(");").append(NL)
						.append("\t\tif (oo != null)").append(NL).append("\t\t{").append(NL)
						.append("\t\t\t if (oo instanceof Boolean)").append(NL)
						.append("\t\t\t\t return ((Boolean)oo).booleanValue();").append(NL)
						.append("\t\t\treturn \"Y\".equals(oo);").append(NL)
						.append("\t\t}").append(NL).append("\t\treturn false;").append(NL);
				} else if ("Object".equals(dataType)) {
					methods.append("\t\treturn get_Value(").append(col).append(");").append(NL);
				} else {
					methods.append("\t\treturn (").append(dataType).append(")get_Value(").append(col).append(");").append(NL);
				}
				methods.append("\t}").append(NL);

				// referenced object, as the interface declares it
				if (ModelInterfaceGenerator.isGenerateModelGetter(columnName) && DisplayType.isID(displayType) && !key) {
					String fieldName = ModelInterfaceGenerator.getFieldName(columnName);
					String referenceClassName = ModelInterfaceGenerator.getReferenceClassName(AD_Table_ID, columnName, displayType, referenceValueId);
					if (fieldName != null && referenceClassName != null) {
						imports.add("org.compiere.model.MTable");
						methods.append(NL).append(override)
							.append("\t@Deprecated(since=\"13\") // use better methods with cache").append(NL)
							.append("\tpublic ").append(referenceClassName).append(" get").append(fieldName).append("() throws RuntimeException").append(NL)
							.append("\t{").append(NL)
							.append("\t\treturn (").append(referenceClassName).append(")MTable.get(getCtx(), ").append(referenceClassName).append(".Table_ID)").append(NL)
							.append("\t\t\t.getPO(get").append(columnName).append("(), get_TrxName());").append(NL)
							.append("\t}").append(NL);
					}
				}
				count++;
			}
		} catch (SQLException e) {
			throw new DBException(e, sql);
		} finally {
			DB.close(rs, pstmt);
		}

		StringBuilder sb = new StringBuilder(ModelInterfaceGenerator.COPY)
			.append("package ").append(packageName).append(";").append(NL).append(NL);
		if (!packageName.equals("org.compiere.model"))
			imports.add("org.compiere.model.*");
		for (String imp : imports)
			sb.append("import ").append(imp).append(";").append(NL);
		sb.append(NL).append("/** Generated accessor for ").append(tableName)
			.append(!Util.isEmpty(entityTypeFilter) ? ", " + entityTypeFilter : "").append(NL)
			.append(" *  Usage: ").append(className).append(".of(po).get...() / set...(...), then po.saveEx(); in a callout ").append(className).append(".of(mTab)").append(NL)
			.append(" *  @author iDempiere (generated) ").append(NL)
			.append(" *  @version ").append(Adempiere.MAIN_VERSION).append(NL).append(" */").append(NL)
			.append("public final class ").append(className)
			.append(implementInterface ? " implements " + interfaceName : "").append(NL).append("{").append(NL);
		if (!implementInterface)
			sb.append("    /** TableName=").append(tableName).append(" */").append(NL)
				.append("    public static final String Table_Name = \"").append(tableName).append("\";").append(NL).append(NL)
				.append(constants);
		sb.append(listConstants).append(NL)
			.append(NL).append("\t/** model object, or null when the accessor works on a grid tab */").append(NL)
			.append("\tprivate final PO po;").append(NL)
			.append("\t/** grid tab of a callout, or null when the accessor works on a model object */").append(NL)
			.append("\tprivate final GridTab tab;").append(NL).append(NL)
			.append("\tprivate ").append(className).append(" (PO po, GridTab tab)").append(NL).append("\t{").append(NL)
			.append("\t\tthis.po = po;").append(NL).append("\t\tthis.tab = tab;").append(NL).append("\t}").append(NL).append(NL)
			.append("\t/**").append(NL)
			.append("\t * @param po a model object of ").append(tableName).append(NL)
			.append("\t * @return accessor of the given object").append(NL)
			.append("\t */").append(NL)
			.append("\tpublic static ").append(className).append(" of (PO po)").append(NL).append("\t{").append(NL)
			.append("\t\tif (po == null || !Table_Name.equalsIgnoreCase(po.get_TableName()))").append(NL)
			.append("\t\t\tthrow new IllegalArgumentException(\"Not a \" + Table_Name + \" object - \" + po);").append(NL)
			.append("\t\treturn new ").append(className).append("(po, null);").append(NL).append("\t}").append(NL).append(NL)
			.append("\t/**").append(NL)
			.append("\t * @param tab a grid tab of ").append(tableName).append(", for example the mTab of a callout").append(NL)
			.append("\t * @return accessor of the current row of the tab").append(NL)
			.append("\t */").append(NL)
			.append("\tpublic static ").append(className).append(" of (GridTab tab)").append(NL).append("\t{").append(NL)
			.append("\t\tif (tab == null || !Table_Name.equalsIgnoreCase(tab.getTableName()))").append(NL)
			.append("\t\t\tthrow new IllegalArgumentException(\"Not a \" + Table_Name + \" tab - \" + tab);").append(NL)
			.append("\t\treturn new ").append(className).append("(null, tab);").append(NL).append("\t}").append(NL).append(NL)
			.append("\t/** @return the wrapped model object, null for a grid tab */").append(NL)
			.append("\tpublic PO getPO()").append(NL).append("\t{").append(NL).append("\t\treturn po;").append(NL).append("\t}").append(NL).append(NL)
			.append("\t/** @return the wrapped grid tab, null for a model object */").append(NL)
			.append("\tpublic GridTab getGridTab()").append(NL).append("\t{").append(NL).append("\t\treturn tab;").append(NL).append("\t}").append(NL).append(NL)
			.append("\tprivate Object get_Value (String columnName)").append(NL).append("\t{").append(NL)
			.append("\t\treturn po != null ? po.get_Value(columnName) : tab.getValue(columnName);").append(NL).append("\t}").append(NL).append(NL)
			.append("\tprivate void set_Value (String columnName, Object value)").append(NL).append("\t{").append(NL)
			.append("\t\tif (po != null)").append(NL).append("\t\t\tpo.set_Value(columnName, value);").append(NL)
			.append("\t\telse").append(NL).append("\t\t\tsetTabValue(columnName, value);").append(NL).append("\t}").append(NL).append(NL)
			.append("\tprivate void set_ValueNoCheck (String columnName, Object value)").append(NL).append("\t{").append(NL)
			.append("\t\tif (po != null)").append(NL).append("\t\t\tpo.set_ValueNoCheck(columnName, value);").append(NL)
			.append("\t\telse").append(NL).append("\t\t\tsetTabValue(columnName, value);").append(NL).append("\t}").append(NL).append(NL)
			.append("\tprivate void setTabValue (String columnName, Object value)").append(NL).append("\t{").append(NL)
			.append("\t\tif (tab.getField(columnName) == null)").append(NL)
			.append("\t\t\tthrow new AdempiereException(\"Column not found - \" + Table_Name + \".\" + columnName);").append(NL)
			.append("\t\tString error = tab.setValue(columnName, value);").append(NL)
			.append("\t\tif (!Util.isEmpty(error, true))").append(NL)
			.append("\t\t\tthrow new AdempiereException(error);").append(NL).append("\t}").append(NL).append(NL)
			.append("\tprivate Properties getCtx()").append(NL).append("\t{").append(NL)
			.append("\t\treturn po != null ? po.getCtx() : Env.getCtx();").append(NL).append("\t}").append(NL).append(NL)
			.append("\tprivate String get_TrxName()").append(NL).append("\t{").append(NL)
			.append("\t\treturn po != null ? po.get_TrxName() : tab.getTableModel().get_TrxName();").append(NL).append("\t}").append(NL)
			.append(methods)
			.append("}").append(NL);

		String fileName = directory + (directory.endsWith(File.separator) ? "" : File.separator) + className + ".java";
		try (Writer w = new OutputStreamWriter(new FileOutputStream(fileName, false), StandardCharsets.UTF_8)) {
			w.write(sb.toString());
		} catch (Exception e) {
			throw new RuntimeException(fileName, e);
		}
		System.out.println(new File(fileName).getAbsolutePath() + " - " + count + " columns");
	}

	/**
	 * Refuse a table whose selected columns cannot get an accessor with the behaviour of the X_ class.
	 * @param AD_Table_ID table
	 * @param entityTypeFilter column filter, as for the constructor, or null for all columns
	 * @throws IllegalArgumentException for an encrypted column: X_ uses set_ValueE / get_ValueE, which PO does not
	 *         offer to other classes, so the accessor would store the value in plain text
	 */
	public static void checkColumns(int AD_Table_ID, String entityTypeFilter) {
		String sql = "SELECT c.ColumnName FROM AD_Column c WHERE c.AD_Table_ID=? AND c.IsActive='Y' AND c.IsEncrypted='Y' "
				+ "AND (c.ColumnSQL IS NULL OR c.ColumnSQL NOT LIKE '@SQL%') "
				+ (!Util.isEmpty(entityTypeFilter) ? " AND c." + entityTypeFilter : "")
				+ " ORDER BY c.ColumnName";
		String encrypted = DB.getSQLValueStringEx(null, sql, AD_Table_ID);
		if (encrypted != null)
			throw new IllegalArgumentException("Column " + MTable.get(AD_Table_ID).getTableName() + "." + encrypted
					+ " is encrypted; the accessor cannot encrypt it. Use the X_ class or a model class of the owner.");
	}

	/**
	 * @return class name {@code <Table>_<suffix>}; the interface of the same owner is {@code I_<Table>_<suffix>}
	 */
	public static String className(String tableName, String suffix) {
		if (Util.isEmpty(suffix, true))
			throw new IllegalArgumentException("The accessor needs a suffix, the owner of the columns: " + tableName + "_<suffix>");
		return tableName + "_" + suffix.trim();
	}
}
