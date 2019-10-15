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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.idempiere.server.cluster.callable;

import java.io.Serializable;
import java.util.concurrent.Callable;

import org.compiere.util.CLogMgt;
import org.compiere.util.Ini;

/**
 * @author hengsin
 *
 */
public class SetTraceLevelCallable implements Callable<Boolean>, Serializable {

	/**
	 * generated serial idd 
	 */
	private static final long serialVersionUID = 6699443869769763231L;
	
	private String traceLevel;

	/**
	 * 
	 */
	public SetTraceLevelCallable(String traceLevel) {
		this.traceLevel = traceLevel;
	}

	@Override
	public Boolean call() throws Exception {
		CLogMgt.setLevel(traceLevel);
		Ini.setProperty(Ini.P_TRACELEVEL, traceLevel);
		Ini.saveProperties(false);
		return true;
	}
}
