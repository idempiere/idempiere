/**********************************************************************
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
 *                                                                     *
 * Contributors:                                                       *
 * - Nicolas Micoud - TGI                                              *
 **********************************************************************/

package org.idempiere.webservices.process;

import org.adempiere.base.IProcessFactory;
import org.compiere.process.ProcessCall;

/**
 * @author nmicoud - TGI
 *
 */
public class WebServicesProcessFactory implements IProcessFactory {

	public ProcessCall newProcessInstance(String className) {
		ProcessCall process = null;
		if (className.startsWith("org.idempiere.webservices.process")) {
			try {
				Class<?> clazz = getClass().getClassLoader().loadClass(className);
				process =  (ProcessCall) clazz.getDeclaredConstructor().newInstance();
			} catch (Exception e) {
			}	
		}

		return process;
	}
}