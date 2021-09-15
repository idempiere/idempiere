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

import java.lang.reflect.Constructor;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 * Provides basic functionality for {@link PO} resolution and instantiation.
 * Based on legacy code in {@link MTable}.
 * @author Jorg Janke
 * @author hengsin
 */
public abstract class AbstractModelFactory implements IModelFactory {

	private final static CLogger s_log = CLogger.getCLogger(AbstractModelFactory.class);

	/**
	 * {@inheritDoc}
	 */
	@Override
	public PO getPO(String tableName, int Record_ID, String trxName) {
		Class<?> clazz = getClass(tableName);
		if (clazz == null)
		{
			return null;
		}

		boolean errorLogged = false;
		try
		{
			Constructor<?> constructor = null;
			try
			{
				constructor = clazz.getDeclaredConstructor(new Class[]{Properties.class, int.class, String.class});
			}
			catch (Exception e)
			{
				String msg = e.getMessage();
				if (msg == null)
					msg = e.toString();
				s_log.warning("No transaction Constructor for " + clazz + " (" + msg + ")");
			}

			PO po = constructor!=null ? (PO)constructor.newInstance(new Object[] {Env.getCtx(), Integer.valueOf(Record_ID), trxName}) : null;
			return po;
		}
		catch (Exception e)
		{
			if (e.getCause() != null)
			{
				Throwable t = e.getCause();
				s_log.log(Level.SEVERE, "(id) - Table=" + tableName + ",Class=" + clazz, t);
				errorLogged = true;
				if (t instanceof Exception)
					s_log.saveError("Error", (Exception)e.getCause());
				else
					s_log.saveError("Error", "Table=" + tableName + ",Class=" + clazz);
			}
			else
			{
				s_log.log(Level.SEVERE, "(id) - Table=" + tableName + ",Class=" + clazz, e);
				errorLogged = true;
				s_log.saveError("Error", "Table=" + tableName + ",Class=" + clazz);
			}
		}
		if (!errorLogged)
			s_log.log(Level.SEVERE, "(id) - Not found - Table=" + tableName
				+ ", Record_ID=" + Record_ID);
		return null;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public PO getPO(String tableName, ResultSet rs, String trxName) {
		Class<?> clazz = getClass(tableName);
		if (clazz == null)
		{
			return null;
		}

		boolean errorLogged = false;
		try
		{
			Constructor<?> constructor = clazz.getDeclaredConstructor(new Class[]{Properties.class, ResultSet.class, String.class});
			PO po = (PO)constructor.newInstance(new Object[] {Env.getCtx(), rs, trxName});
			return po;
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, "(rs) - Table=" + tableName + ",Class=" + clazz, e);
			errorLogged = true;
			s_log.saveError("Error", "Table=" + tableName + ",Class=" + clazz);
		}
		if (!errorLogged)
			s_log.log(Level.SEVERE, "(rs) - Not found - Table=" + tableName);
		return null;
	}

}
