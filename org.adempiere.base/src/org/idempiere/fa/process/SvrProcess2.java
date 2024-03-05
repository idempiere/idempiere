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
package org.idempiere.fa.process;

import java.lang.reflect.Field;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.CLogger;

/**
 * Server Process Template (v2).<br/>
 * In this version, parameters fields will be automatically filled if they start with p_ and are accessible.
 * 
 * @author Teo Sarca, www.arhipac.ro
 */
public abstract class SvrProcess2 extends SvrProcess
{
	/** Logger */
	private static final CLogger s_log = CLogger.getCLogger(SvrProcess2.class);
	
	@Override
	protected final void prepare()
	{
		readParameters(this, getParameter());
	}

	/**
	 * Fill process parameter field using reflection API.
	 * @param process
	 * @param params
	 */
	private static void readParameters(SvrProcess process, ProcessInfoParameter[] params)
	{
		try
		{
			for (Field field : process.getClass().getFields())
			{
				if (!field.getName().startsWith("p_"))
				{
					continue;
				}
				final String parameterName;
				final boolean isTo;
				if (field.getName().endsWith("_To"))
				{
					parameterName = field.getName().substring(2, field.getName().length() - 3);
					isTo = true;
				}
				else
				{
					parameterName = field.getName().substring(2);
					isTo = false;
				}
				//
				boolean isSet = false;
				for (ProcessInfoParameter para : params)
				{
					if (!parameterName.equals(para.getParameterName()))
					{
						continue;
					}
					if (field.getType() == int.class)
					{
						if (isTo)
							field.setInt(process, para.getParameter_ToAsInt());
						else
							field.setInt(process, para.getParameterAsInt());
					}
					else if (field.getType() == boolean.class)
					{
						if (isTo)
							field.setBoolean(process, para.getParameter_ToAsBoolean());
						else
							field.setBoolean(process, para.getParameterAsBoolean());
					}
					else
					{
						if (isTo)
							field.set(process, para.getParameter_To());
						else
							field.set(process, para.getParameter());
					}
					isSet = true;
					break;
				} // for ProcessInfoParameter
				//
				if (!isSet)
				{
					if (s_log.isLoggable(Level.INFO)) s_log.info("Parameter not set - "+parameterName);
				}
			} // for Field
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
	}
}
