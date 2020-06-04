/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Trifon Trifonov.                                      *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software, you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation, either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY, without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program, if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Trifon Trifonov (trifonnt@users.sourceforge.net)                  *
* - Teo Sarca (teo.sarca@arhipac.ro)                                  *
*                                                                     *
* Sponsors:                                                           *
* - Company (http://www.d3-soft.com)                                  *
* - ARHIPAC (http://www.arhipac.ro)                                   *
**********************************************************************/

package org.adempiere.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.StringTokenizer;
import java.util.TreeSet;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.Adempiere;
import org.compiere.model.MEntityType;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *	@author Trifon Trifonov
 *	@version $Id$
 *
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 				<li>BF [ 1781629 ] Don't use Env.NL in model class/interface generators
 * 				<li>FR [ 1781630 ] Generated class/interfaces have a lot of unused imports
 * 				<li>BF [ 1781632 ] Generated class/interfaces should be UTF-8
 * 				<li>better formating of generated source
 * 				<li>BF [ 1787833 ] ModelInterfaceGenerator: don't write timestamp
 * 				<li>FR [ 1803309 ] Model generator: generate get method for Search cols
 * 				<li>BF [ 1817768 ] Isolate hardcoded table direct columns
 * 					https://sourceforge.net/tracker/?func=detail&atid=879332&aid=1817768&group_id=176962
 * 				<li>FR [ 2343096 ] Model Generator: Improve Reference Class Detection
 * 				<li>BF [ 2528434 ] ModelInterfaceGenerator: generate getters for common fields
 * 				<li>--
 * 				<li>FR [ 2848449 ] ModelClassGenerator: Implement model getters
 *					https://sourceforge.net/tracker/?func=detail&atid=879335&aid=2848449&group_id=176962
 * @author Teo Sarca, teo.sarca@gmail.com
 * 				<li>FR [ 3020635 ] Model Generator should use FQ class names
 * 					https://sourceforge.net/tracker/?func=detail&aid=3020635&group_id=176962&atid=879335
 * @author Victor Perez, e-Evolution
 * 				<li>FR [ 1785001 ] Using ModelPackage of EntityType to Generate Model Class
 */
public class ModelInterfaceGenerator
{

	private String packageName = "";

	public static final String NL = "\n";

	/** File Header			*/
	public static final String COPY =
		 "/******************************************************************************\n"
		+" * Product: iDempiere ERP & CRM Smart Business Solution                       *\n"
		+" * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *\n"
		+" * This program is free software, you can redistribute it and/or modify it    *\n"
		+" * under the terms version 2 of the GNU General Public License as published   *\n"
		+" * by the Free Software Foundation. This program is distributed in the hope   *\n"
		+" * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *\n"
		+" * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *\n"
		+" * See the GNU General Public License for more details.                       *\n"
		+" * You should have received a copy of the GNU General Public License along    *\n"
		+" * with this program, if not, write to the Free Software Foundation, Inc.,    *\n"
		+" * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *\n"
		+" * For the text or an alternative of this public license, you may reach us    *\n"
		+" * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *\n"
		+" * or via info@compiere.org or http://www.compiere.org/license.html           *\n"
		+" *****************************************************************************/\n";

	/** Logger */
	private static final CLogger log = CLogger.getCLogger(ModelInterfaceGenerator.class);

	/**
	 * 
	 * @param AD_Table_ID
	 * @param directory
	 * @param packageName
	 * @param entityTypeFilter entity type filter for column
	 */
	public ModelInterfaceGenerator(int AD_Table_ID, String directory, String packageName, String entityTypeFilter) {
		this.packageName = packageName;
		// create column access methods
		StringBuilder mandatory = new StringBuilder();
		StringBuilder sb = createColumns(AD_Table_ID, mandatory, entityTypeFilter);

		// Header
		String tableName = createHeader(AD_Table_ID, sb, mandatory);

		// Save
		if (directory.endsWith("/") || directory.endsWith("\\"))
		{

		} else {
			directory = directory + File.separator;
		}
		writeToFile(sb, directory + tableName + ".java");
	}

	/**
	 * Add Header info to buffer
	 *
	 * @param AD_Table_ID	table
	 * @param sb			buffer
	 * @param mandatory		init call for mandatory columns
	 * @param packageName	package name
	 * @return class name
	 */
	private String createHeader(int AD_Table_ID, StringBuilder sb, StringBuilder mandatory) {
		String tableName = "";
		int accessLevel = 0;
		String sql = "SELECT TableName, AccessLevel FROM AD_Table WHERE AD_Table_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Table_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				tableName = rs.getString(1);
				accessLevel = rs.getInt(2);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (tableName == null)
			throw new RuntimeException("TableName not found for ID=" + AD_Table_ID);
		//
		StringBuilder accessLevelInfo = new StringBuilder().append(accessLevel).append(" ");
		if (accessLevel >= 4 )
			accessLevelInfo.append("- System ");
		if (accessLevel == 2 || accessLevel == 3 || accessLevel == 6 || accessLevel == 7)
			accessLevelInfo.append("- Client ");
		if (accessLevel == 1 || accessLevel == 3 || accessLevel == 5 || accessLevel == 7)
			accessLevelInfo.append("- Org ");

		//
		StringBuilder className = new StringBuilder("I_").append(tableName);
		//
		StringBuilder start = new StringBuilder()
			.append (COPY)
			.append("package ").append(packageName).append(";").append(NL)
		;

		if (!packageName.equals("org.compiere.model")) {
			addImportClass("org.compiere.model.*");
		}
		addImportClass(java.math.BigDecimal.class);
		addImportClass(org.compiere.util.KeyNamePair.class);

		createImports(start);
		// Interface
		start.append("/** Generated Interface for ").append(tableName).append("\n")
			 .append(" *  @author iDempiere (generated) \n")
			 .append(" *  @version ").append(Adempiere.MAIN_VERSION).append(NL) //.append(" - ").append(s_run).append("\n")
			 .append(" */\n");
		if (!packageName.equals("org.compiere.model")) {
			 start.append("@SuppressWarnings(\"all\")\n");
		}
		start.append("public interface ").append(className).append(" {").append("\n")

			 .append("    /** TableName=").append(tableName).append(" */\n")
			 .append("    public static final String Table_Name = \"").append(tableName).append("\";\n")

			 .append("    /** AD_Table_ID=").append(AD_Table_ID).append(" */\n");

		//MTable.getTable_ID unnecessary for official ID
		if (AD_Table_ID <= MTable.MAX_OFFICIAL_ID)
			start.append("    public static final int Table_ID = ").append(AD_Table_ID).append(";\n");
		else
			start.append("    public static final int Table_ID = MTable.getTable_ID(Table_Name);\n");

			 //.append("    protected KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);\n")
		start.append("    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);\n") // INFO - Should this be here???

			 .append("    /** AccessLevel = ").append(accessLevelInfo).append("\n")
			 .append("     */\n")
			 //.append("    protected BigDecimal AccessLevel = new BigDecimal(").append(accessLevel).append(");\n")
			 .append("    BigDecimal accessLevel = BigDecimal.valueOf(").append(accessLevel).append(");\n") // INFO - Should this be here???

			 .append("    /** Load Meta Data */\n")
			 //.append("    protected POInfo initPO (Properties ctx);")
			 //.append("    POInfo initPO (Properties ctx);") // INFO - Should this be here???
		;

		String end = "}";
		//
		sb.insert(0, start);
		sb.append(end);

		return className.toString();
	}

	/**
	 * Create Column access methods
	 *
	 * @param AD_Table_ID table
	 * @param mandatory   init call for mandatory columns
	 * @param entityTypeFilter
	 * @return set/get method
	 */
	private StringBuilder createColumns(int AD_Table_ID, StringBuilder mandatory, String entityTypeFilter) {
		StringBuilder sb = new StringBuilder();
		String sql = "SELECT c.ColumnName, c.IsUpdateable, c.IsMandatory," // 1..3
				+ " c.AD_Reference_ID, c.AD_Reference_Value_ID, DefaultValue, SeqNo, " // 4..7
				+ " c.FieldLength, c.ValueMin, c.ValueMax, c.VFormat, c.Callout, " // 8..12
				+ " c.Name, c.Description, c.ColumnSQL, c.IsEncrypted, c.IsKey "   // 13..17
				+ "FROM AD_Column c "
				+ "WHERE c.AD_Table_ID=?"

//				+ " AND c.ColumnName <> 'AD_Client_ID'"
//				+ " AND c.ColumnName <> 'AD_Org_ID'"
//				+ " AND c.ColumnName <> 'IsActive'"
//				+ " AND c.ColumnName NOT LIKE 'Created%'"
//				+ " AND c.ColumnName NOT LIKE 'Updated%' "
				+ " AND c.IsActive='Y'"
				+ (!Util.isEmpty(entityTypeFilter) ? " AND c." + entityTypeFilter : "")
				+ " ORDER BY c.ColumnName";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Table_ID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String columnName = rs.getString(1);
				boolean isUpdateable = "Y".equals(rs.getString(2));
				boolean isMandatory = "Y".equals(rs.getString(3));
				int displayType = rs.getInt(4);
				int AD_Reference_Value_ID = rs.getInt(5);
				String defaultValue = rs.getString(6);
				//int seqNo = rs.getInt(7);
				int fieldLength = rs.getInt(8);
				String ValueMin = rs.getString(9);
				String ValueMax = rs.getString(10);
				String VFormat = rs.getString(11);
				String Callout = rs.getString(12);
				String Name = rs.getString(13);
				String Description = rs.getString(14);
				String ColumnSQL = rs.getString(15);
				boolean virtualColumn = ColumnSQL != null
						&& ColumnSQL.length() > 0;
				boolean IsEncrypted = "Y".equals(rs.getString(16));
				boolean IsKey = "Y".equals(rs.getString(17));

				// Create COLUMNNAME_ property (teo_sarca, [ 1662447 ])
				sb.append("\n")
				  .append("    /** Column name ").append(columnName).append(" */\n")
				  .append("    public static final String COLUMNNAME_").append(columnName)
				  .append(" = \"").append(columnName).append("\";");

				//
				sb.append(createColumnMethods(mandatory, columnName,
						isUpdateable, isMandatory, displayType,
						AD_Reference_Value_ID, fieldLength, defaultValue,
						ValueMin, ValueMax, VFormat, Callout, Name,
						Description, virtualColumn, IsEncrypted, IsKey, AD_Table_ID));
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return sb;
	}

	/**
	 * Create set/get methods for column
	 *
	 * @param mandatory        init call for mandatory columns
	 * @param columnName       column name
	 * @param isUpdateable     updateable
	 * @param isMandatory      mandatory
	 * @param displayType      display type
	 * @param AD_Reference_ID  validation reference
	 * @param fieldLength    int
	 * @param defaultValue   default value
	 * @param ValueMin       String
	 * @param ValueMax       String
	 * @param VFormat        String
	 * @param Callout        String
	 * @param Name           String
	 * @param Description    String
	 * @param virtualColumn  virtual column
	 * @param IsEncrypted    stored encrypted
	 * @return set/get method
	 */
	private String createColumnMethods(StringBuilder mandatory,
			String columnName, boolean isUpdateable, boolean isMandatory,
			int displayType, int AD_Reference_ID, int fieldLength,
			String defaultValue, String ValueMin, String ValueMax,
			String VFormat, String Callout, String Name, String Description,
			boolean virtualColumn, boolean IsEncrypted, boolean IsKey, int AD_Table_ID)
	{
		Class<?> clazz = getClass(columnName, displayType, AD_Reference_ID);
		String dataType = getDataTypeName(clazz, displayType);
		if (defaultValue == null)
			defaultValue = "";

		StringBuilder sb = new StringBuilder();

		if (isGenerateSetter(columnName))
		{
			// Create Java Comment
			generateJavaComment("Set", Name, Description, sb);
			// public void setColumn (xxx variable)
			sb.append("\tpublic void set").append(columnName).append(" (")
				.append(dataType).append(" ").append(columnName).append(");");
		}

		// ****** Get Comment ******
		generateJavaComment("Get", Name, Description, sb);

		sb.append("\tpublic ").append(dataType);
		if (clazz.equals(Boolean.class)) {
			sb.append(" is");
			if (columnName.toLowerCase().startsWith("is"))
				sb.append(columnName.substring(2));
			else
				sb.append(columnName);
		} else
			sb.append(" get").append(columnName);
		sb.append("();");
		//

		if (isGenerateModelGetter(columnName) && DisplayType.isID(displayType) && !IsKey)
		{
			String fieldName = getFieldName(columnName);
			String referenceClassName = getReferenceClassName(AD_Table_ID, columnName, displayType, AD_Reference_ID);
			//
			if (fieldName != null && referenceClassName != null)
			{
				sb.append("\n")
				  .append("\tpublic "+referenceClassName+" get").append(fieldName).append("() throws RuntimeException;");
			}
		}
		addImportClass(clazz);
		return sb.toString();
	}

	// ****** Set/Get Comment ******
	public void generateJavaComment(String startOfComment, String propertyName,	String description, StringBuilder result) {
		result.append("\n")
			  .append("\t/** ").append(startOfComment).append(" ")
			  .append(propertyName);

		if (description != null && description.length() > 0)
			result.append(".\n\t  * ").append(description).append(NL);

		result.append("\t  */\n");
	}

	/*
	 * Write to file
	 *
	 * @param sb string buffer
	 * @param fileName file name
	 */
	private void writeToFile(StringBuilder sb, String fileName) {
		try {
			File out = new File(fileName);
			Writer fw = new OutputStreamWriter(new FileOutputStream(out, false), "UTF-8");
			for (int i = 0; i < sb.length(); i++) {
				char c = sb.charAt(i);
				// after
				if (c == ';' || c == '}') {
					fw.write(c);
					if (sb.substring(i + 1).startsWith("//"))
						fw.write('\t');
					else
						fw.write(NL);
				}
				// before & after
				else if (c == '{') {
					fw.write(NL);
					fw.write(c);
					fw.write(NL);
				} else
					fw.write(c);
			}
			fw.flush();
			fw.close();
			float size = out.length();
			size /= 1024;
			StringBuilder msgout = new StringBuilder().append(out.getAbsolutePath()).append(" - ").append(size).append(" kB");
			System.out.println(msgout.toString());
		} catch (Exception ex) {
			log.log(Level.SEVERE, fileName, ex);
			throw new RuntimeException(ex);
		}
	}

	/** Import classes */
	private Collection<String> s_importClasses = new TreeSet<String>();
	/**
	 * Add class name to class import list
	 * @param className
	 */
	private void addImportClass(String className) {
		if (className == null
				|| (className.startsWith("java.lang.") && !className.startsWith("java.lang.reflect."))
				|| className.startsWith(packageName+"."))
			return;
		for(String name : s_importClasses) {
			if (className.equals(name))
				return;
		}
		if (className.equals("byte[]")) {
			log.warning("Invalid type - "+className);
			return;
		}
		s_importClasses.add(className);
	}
	/**
	 * Add class to class import list
	 * @param cl
	 */
	private void addImportClass(Class<?> cl) {
		if (cl.isArray()) {
			cl = cl.getComponentType();
		}
		if (cl.isPrimitive())
			return;
		addImportClass(cl.getCanonicalName());
	}
	/**
	 * Generate java imports
	 * @param sb
	 */
	private void createImports(StringBuilder sb) {
		for (String name : s_importClasses) {
			sb.append("import ").append(name).append(";"); //.append(NL);
		}
		sb.append(NL);
	}


	/**
	 * Get class for given display type and reference
	 * @param displayType
	 * @param AD_Reference_ID
	 * @return class
	 */
	public static Class<?> getClass(String columnName, int displayType, int AD_Reference_ID)
	{
		// Handle Posted
		// TODO: hardcoded
		if (columnName.equalsIgnoreCase("Posted")
				|| columnName.equalsIgnoreCase("Processed")
				|| columnName.equalsIgnoreCase("Processing"))
		{
			return Boolean.class;
		}
		// Record_ID
		// TODO: hardcoded
		else if (columnName.equalsIgnoreCase("Record_ID"))
		{
			return Integer.class;
		}
		// Reference Table
		else if ((DisplayType.Table == displayType || DisplayType.Search == displayType)
				&& AD_Reference_ID > 0)
		{
			String sql = "SELECT c.AD_Reference_ID, c.AD_Reference_Value_ID"
						+" FROM AD_Ref_Table rt"
						+" INNER JOIN AD_Column c ON (c.AD_Column_ID=rt.AD_Key)"
						+" WHERE rt.AD_Reference_ID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, AD_Reference_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					displayType = rs.getInt(1);
					AD_Reference_ID = rs.getInt(2);
				}
				else
				{
					throw new IllegalStateException("Not found AD_Ref_Table/AD_Column - DisplayType="+displayType+", AD_Reference_ID="+AD_Reference_ID);
				}
			}
			catch (SQLException e)
			{
				throw new DBException(e, sql);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
			//
			return getClass(columnName, displayType, AD_Reference_ID); // recursive call with new parameters
		}
		else if (displayType == DisplayType.Button && columnName.endsWith("_ID"))
		{
			return Integer.class;
		}
		else
		{
			return DisplayType.getClass(displayType, true);
		}
	}

	public static String getDataTypeName(Class<?> cl, int displayType)
	{
		String dataType = cl.getName();
		dataType = dataType.substring(dataType.lastIndexOf('.')+1);
		if (dataType.equals("Boolean")) {
			dataType = "boolean";
		} else if (dataType.equals("Integer")) {
			dataType = "int";
		} else if (displayType == DisplayType.Binary || displayType == DisplayType.Image) {
			dataType = "byte[]";
		}
		return dataType;
	}

	/**
	 * @param columnName
	 * @return true if a setter method should be generated
	 */
	public static boolean isGenerateSetter(String columnName)
	{
		return
			!"AD_Client_ID".equals(columnName)
			//&& !"AD_Org_ID".equals(columnName)
			//&& !"IsActive".equals(columnName)
			&& !"Created".equals(columnName)
			&& !"CreatedBy".equals(columnName)
			&& !"Updated".equals(columnName)
			&& !"UpdatedBy".equals(columnName)
		;
	}

	/**
	 * @param columnName
	 * @return true if a model getter method (method that is returning referenced PO) should be generated
	 */
	public static boolean isGenerateModelGetter(String columnName)
	{
		return
			!"AD_Client_ID".equals(columnName)
			&& !"AD_Org_ID".equals(columnName)
			&& !"CreatedBy".equals(columnName)
			&& !"UpdatedBy".equals(columnName)
		;
	}

	/**
	 *
	 * @param AD_Table_ID
	 * @param toEntityType
	 * @return true if a model getter method (method that is returning referenced PO) should be generated
	 */
	public static boolean isGenerateModelGetterForEntity(int AD_Table_ID, String toEntityType)
	{
		final String fromEntityType = DB.getSQLValueString(null, "SELECT EntityType FROM AD_Table where AD_Table_ID=?", AD_Table_ID);
		final MEntityType fromEntity = MEntityType.get(Env.getCtx(), fromEntityType);
		final MEntityType toEntity = MEntityType.get(Env.getCtx(), toEntityType);
		return
			// Same entities
			fromEntityType.equals(toEntityType)
			// Both are system entities
			|| (fromEntity.isSystemMaintained() && toEntity.isSystemMaintained())
			// Not Sys Entity referencing a Sys Entity
			|| (!fromEntity.isSystemMaintained() && toEntity.isSystemMaintained())
		;
	}

	/**
	 * Get EntityType Model Package.
	 * @author Victor Perez - [ 1785001 ] Using ModelPackage of EntityType to Generate Model Class
	 * @param entityType
	 * @return
	 */
	public static String getModelPackage(String entityType)
	{
		if ("D".equals(entityType))
			return "org.compiere.model";

		MEntityType entity = MEntityType.get(Env.getCtx(), entityType);
		if (entity != null)
			return entity.getModelPackage();
		return null;
	}

	public static String getFieldName(String columnName)
	{
		String fieldName;
		if (columnName.endsWith("_ID_To"))
			fieldName = columnName.substring(0, columnName.length() - 6) + "_To";
		else
			fieldName = columnName.substring(0, columnName.length() - 3);
		return fieldName;
	}

	public static String getReferenceClassName(int AD_Table_ID, String columnName, int displayType, int AD_Reference_ID)
	{
		String referenceClassName = null;
		//
		if (displayType == DisplayType.TableDir
				|| (displayType == DisplayType.Search && AD_Reference_ID == 0))
		{
			String refTableName = MQuery.getZoomTableName(columnName); // teo_sarca: BF [ 1817768 ] Isolate hardcoded table direct columns
			referenceClassName = "I_"+refTableName;

			MTable table = MTable.get(Env.getCtx(), refTableName);
			if (table != null)
			{
				String entityType = table.getEntityType();
				String modelpackage = getModelPackage(entityType) ;
				if (modelpackage != null)
				{
					referenceClassName = modelpackage+"."+referenceClassName;
				}
				if (!isGenerateModelGetterForEntity(AD_Table_ID, entityType))
				{
					referenceClassName = null;
				}
			}
			else
			{
				throw new RuntimeException("No table found for "+refTableName);
			}
		}
		else if (displayType == DisplayType.Table
				|| (displayType == DisplayType.Search && AD_Reference_ID > 0))
		{
			// TODO: HARDCODED: do not generate model getter for Fact_Acct.Account_ID
			if (AD_Table_ID == 270 && columnName.equals("Account_ID"))
				return null;
			// TODO: HARDCODED: do not generate model getter for GL_DistributionLine.Account_ID
			if (AD_Table_ID == 707 && columnName.equals("Account_ID"))
				return null;
			//
			final String sql = "SELECT t.TableName, t.EntityType, ck.AD_Reference_ID"
				+" FROM AD_Ref_Table rt"
				+" INNER JOIN AD_Table t ON (t.AD_Table_ID=rt.AD_Table_ID)"
				+" INNER JOIN AD_Column ck ON (ck.AD_Table_ID=rt.AD_Table_ID AND ck.AD_Column_ID=rt.AD_Key)"
				+" WHERE rt.AD_Reference_ID=?"
			;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, AD_Reference_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					final String refTableName = rs.getString(1);
					final String entityType = rs.getString(2);
					final int refDisplayType = rs.getInt(3);
					if (refDisplayType == DisplayType.ID)
					{
						referenceClassName = "I_"+refTableName;
						String modelpackage = getModelPackage(entityType);
						if (modelpackage != null)
						{
							referenceClassName = modelpackage+"."+referenceClassName;
						}
						if (!isGenerateModelGetterForEntity(AD_Table_ID, entityType))
						{
							referenceClassName = null;
						}
					}
				}
			}
			catch (SQLException e)
			{
				throw new DBException(e, sql);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}
		else if (displayType == DisplayType.Location)
		{
			referenceClassName = "I_C_Location";
		}
		else if (displayType == DisplayType.Locator)
		{
			referenceClassName = "I_M_Locator";
		}
		else if (displayType == DisplayType.Account)
		{
			referenceClassName = "I_C_ValidCombination";
		}
		else if (displayType == DisplayType.PAttribute)
		{
			referenceClassName = "I_M_AttributeSetInstance";
		}
		else
		{
			// TODO - Handle other types
			//sb.append("\tpublic I_"+columnName+" getI_").append(columnName).append("(){return null; };");
		}
		//
		return referenceClassName;
	}


	/**
	 * String representation
	 *
	 * @return string representation
	 */
	public String toString() {
		StringBuilder sb = new StringBuilder("GenerateModel[").append("]");
		return sb.toString();
	}

	/**
	 * @param sourceFolder
	 * @param packageName
	 * @param entityType
	 * @param tableLike
	 * @param columnEntityType
	 */
	public static void generateSource(String sourceFolder, String packageName, String entityType, String tableName, String columnEntityType)
	{
		if (sourceFolder == null || sourceFolder.trim().length() == 0)
			throw new IllegalArgumentException("Must specify source folder");

		File file = new File(sourceFolder);
		if (!file.exists())
			throw new IllegalArgumentException("Source folder doesn't exists. sourceFolder="+sourceFolder);

		if (packageName == null || packageName.trim().length() == 0)
			throw new IllegalArgumentException("Must specify package name");

		if (tableName == null || tableName.trim().length() == 0)
			throw new IllegalArgumentException("Must specify table name");

		StringBuilder tableLike = new StringBuilder().append(tableName.trim());
		if (!tableLike.toString().startsWith("'") || !tableLike.toString().endsWith("'"))
			tableLike = new StringBuilder("'").append(tableLike).append("'");

		StringBuilder entityTypeFilter = new StringBuilder();
		if (entityType != null && entityType.trim().length() > 0)
		{
			entityTypeFilter.append("EntityType IN (");
			StringTokenizer tokenizer = new StringTokenizer(entityType, ",");
			int i = 0;
			while(tokenizer.hasMoreTokens()) {
				StringBuilder token = new StringBuilder(tokenizer.nextToken().trim());
				if (!token.toString().startsWith("'") || !token.toString().endsWith("'"))
					token = new StringBuilder("'").append(token).append("'");
				if (i > 0)
					entityTypeFilter.append(",");
				entityTypeFilter.append(token);
				i++;
			}
			entityTypeFilter.append(")");
		}
		else
		{
			entityTypeFilter.append("EntityType IN ('U','A')");
		}

		StringBuilder directory = new StringBuilder().append(sourceFolder.trim());
		String packagePath = packageName.replace(".", File.separator);
		if (!(directory.toString().endsWith("/") || directory.toString().endsWith("\\")))
		{
			directory.append(File.separator);
		}
		if (File.separator.equals("/"))
			directory = new StringBuilder(directory.toString().replaceAll("[\\\\]", File.separator));
		else
			directory = new StringBuilder(directory.toString().replaceAll("[/]", File.separator));
		directory = new StringBuilder(directory).append(packagePath);
		file = new File(directory.toString());
		if (!file.exists())
			file.mkdirs();

		//	complete sql
		String filterViews = null;
		if (tableLike.toString().contains("%")) {
			filterViews = "AND (TableName IN ('RV_WarehousePrice','RV_BPartner') OR IsView='N')"; 	//	special views
		}
		if (tableLike.toString().equals("'%'")) {
			filterViews += " AND TableName NOT LIKE 'W|_%' ESCAPE '|'"; 	//	exclude webstore from general model generator
		}
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT AD_Table_ID ")
			.append("FROM AD_Table ")
			.append("WHERE IsActive = 'Y' AND TableName NOT LIKE '%_Trl' ");
		// Autodetect if we need to use IN or LIKE clause - teo_sarca [ 3020640 ]
		if (tableLike.indexOf(",") == -1)
			sql.append(" AND TableName LIKE ").append(tableLike);
		else
			sql.append(" AND TableName IN (").append(tableLike).append(")"); // only specific tables
		sql.append(" AND ").append(entityTypeFilter.toString());
		if (filterViews != null) {
			sql.append(filterViews);
		}
		sql.append(" ORDER BY TableName");

		//
		StringBuilder columnFilterBuilder = new StringBuilder();
		if (!Util.isEmpty(columnEntityType, true))
		{
			columnFilterBuilder.append("EntityType IN (");
			StringTokenizer tokenizer = new StringTokenizer(columnEntityType, ",");
			int i = 0;
			while(tokenizer.hasMoreTokens()) {
				StringBuilder token = new StringBuilder().append(tokenizer.nextToken().trim());
				if (!token.toString().startsWith("'") || !token.toString().endsWith("'"))
					token = new StringBuilder("'").append(token).append("'");
				if (i > 0)
					columnFilterBuilder.append(",");
				columnFilterBuilder.append(token);
				i++;
			}
			columnFilterBuilder.append(")");
		}
		String columnFilter = columnFilterBuilder.length() > 0 ? columnFilterBuilder.toString() : null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				new ModelInterfaceGenerator(rs.getInt(1), directory.toString(), packageName, columnFilter);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql.toString());
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}
}