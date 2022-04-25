/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 * Contributor(s): Carlos Ruiz - globalqss                                    *
 *****************************************************************************/
package org.adempiere.base;

import java.util.logging.Level;

import org.compiere.model.MEntityType;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Default model factory implementation base on legacy code in {@link MTable}.
 * @author Jorg Janke
 * @author hengsin
 * @deprecated
 */
public class DefaultModelFactory extends AbstractModelFactory {

	private CCache<String,Class<?>> s_classCache = new CCache<String,Class<?>>(null, "PO_Class", 100, 120, false, 2000);

	private final static CLogger s_log = CLogger.getCLogger(DefaultModelFactory.class);

	/**	Packages for Model Classes	*/
	private static final String[]	s_packages = new String[] {

		"org.compiere.model", "org.compiere.wf",
		"org.compiere.print", "org.compiere.impexp",
		"compiere.model",			//	globalqss allow compatibility with other plugins
		"adempiere.model",			//	Extensions
		"org.adempiere.model"
	};

	/**	Special Classes				*/
	private static final String[]	s_special = new String[] {
		"AD_Element", "org.compiere.model.M_Element",
		"AD_Registration", "org.compiere.model.M_Registration",
		"AD_Tree", "org.compiere.model.MTree_Base",
		"R_Category", "org.compiere.model.MRequestCategory",
		"GL_Category", "org.compiere.model.MGLCategory",
		"K_Category", "org.compiere.model.MKCategory",
		"C_ValidCombination", "org.compiere.model.MAccount",
		"C_Phase", "org.compiere.model.MProjectTypePhase",
		"C_Task", "org.compiere.model.MProjectTypeTask"
	//	AD_Attribute_Value, AD_TreeNode
	};

	/* (non-Javadoc)
	 * @see org.adempiere.base.IModelFactory#getClass(java.lang.String)
	 */
	@Override
	public Class<?> getClass(String tableName) {
//		Not supported
		if (tableName == null || tableName.endsWith("_Trl"))
			return null;

		//check cache
		Class<?> cache = s_classCache.get(tableName);
		if (cache != null)
		{
			//Object.class indicate no generated PO class for tableName
			if (cache.equals(Object.class))
				return null;
			else
				return cache;
		}

		MTable table = MTable.get(Env.getCtx(), tableName);
		String entityType = table.getEntityType();

		//	Import Tables (Name conflict)
		//  Import Tables doesn't manage model M classes, just X_
		if (tableName.startsWith("I_"))
		{
			MEntityType et = MEntityType.get(Env.getCtx(), entityType);
			String etmodelpackage = et.getModelPackage();
			if (etmodelpackage == null || MEntityType.ENTITYTYPE_Dictionary.equals(entityType))
				etmodelpackage = "org.compiere.model"; // fallback for dictionary or empty model package on entity type
			Class<?> clazz = getPOclass(etmodelpackage + ".X_" + tableName, tableName);
			if (clazz != null)
			{
				s_classCache.put(tableName, clazz);
				return clazz;
			}
			s_log.warning("No class for table: " + tableName);
			return null;
		}

		//	Special Naming
		for (int i = 0; i < s_special.length; i++)
		{
			if (s_special[i++].equals(tableName))
			{
				Class<?> clazz = getPOclass(s_special[i], tableName);
				if (clazz != null)
				{
					s_classCache.put(tableName, clazz);
					return clazz;
				}
				break;
			}
		}

		//begin [ 1784588 ] Use ModelPackage of EntityType to Find Model Class - vpj-cd
		if (!MEntityType.ENTITYTYPE_Dictionary.equals(entityType))
		{
			MEntityType et = MEntityType.get(Env.getCtx(), entityType);
			String etmodelpackage = et.getModelPackage();
			if (etmodelpackage != null)
			{
				Class<?> clazz = null;
				clazz = getPOclass(etmodelpackage + ".M" + Util.replace(tableName, "_", ""), tableName);
				if (clazz != null) {
					s_classCache.put(tableName, clazz);
					return clazz;
				}
				clazz = getPOclass(etmodelpackage + ".X_" + tableName, tableName);
				if (clazz != null) {
					s_classCache.put(tableName, clazz);
					return clazz;
				}
				s_log.warning("No class for table with it entity: " + tableName);
			}
		}
		//end [ 1784588 ]

		//	Strip table name prefix (e.g. AD_) Customizations are 3/4
		String className = tableName;
		int index = className.indexOf('_');
		if (index > 0)
		{
			if (index < 3)		//	AD_, A_
				 className = className.substring(index+1);
			/* DELETEME: this part is useless - teo_sarca, [ 1648850 ]
			else
			{
				String prefix = className.substring(0,index);
				if (prefix.equals("Fact"))		//	keep custom prefix
					className = className.substring(index+1);
			}
			*/
		}
		//	Remove underlines
		className = Util.replace(className, "_", "");

		//	Search packages
		for (int i = 0; i < s_packages.length; i++)
		{
			StringBuilder name = new StringBuilder(s_packages[i]).append(".M").append(className);
			Class<?> clazz = getPOclass(name.toString(), tableName);
			if (clazz != null)
			{
				s_classCache.put(tableName, clazz);
				return clazz;
			}
		}


		//	Adempiere Extension
		Class<?> clazz = getPOclass("adempiere.model.X_" + tableName, tableName);
		if (clazz != null)
		{
			s_classCache.put(tableName, clazz);
			return clazz;
		}

		//hengsin - allow compatibility with compiere plugins
		//Compiere Extension
		clazz = getPOclass("compiere.model.X_" + tableName, tableName);
		if (clazz != null)
		{
			s_classCache.put(tableName, clazz);
			return clazz;
		}

		//	Default
		clazz = getPOclass("org.compiere.model.X_" + tableName, tableName);
		if (clazz != null)
		{
			s_classCache.put(tableName, clazz);
			return clazz;
		}

		//Object.class to indicate no PO class for tableName
		s_classCache.put(tableName, Object.class);
		return null;
	}

	/**
	 * Get PO class
	 * @param className fully qualified class name
	 * @param tableName Optional. If specified, the loaded class will be validated for that table name
	 * @return class or null
	 */
	private Class<?> getPOclass (String className, String tableName)
	{
		try
		{
			Class<?> clazz = Class.forName(className);
			// Validate if the class is for specified tableName
			if (tableName != null)
			{
				String classTableName = clazz.getField("Table_Name").get(null).toString();
				if (!tableName.equals(classTableName))
				{
					if (s_log.isLoggable(Level.FINEST)) s_log.finest("Invalid class for table: " + className+" (tableName="+tableName+", classTableName="+classTableName+")");
					return null;
				}
			}
			//	Make sure that it is a PO class
			Class<?> superClazz = clazz.getSuperclass();
			while (superClazz != null)
			{
				if (superClazz == PO.class)
				{
					if (s_log.isLoggable(Level.FINE)) s_log.fine("Use: " + className);
					return clazz;
				}
				superClazz = superClazz.getSuperclass();
			}
		}
		catch (Exception e)
		{
		}
		if (s_log.isLoggable(Level.FINEST)) s_log.finest("Not found: " + className);
		return null;
	}	//	getPOclass

}
