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

import org.compiere.util.CLogFile;

/**
 * @author hengsin
 *
 */
public class RotateLogCallable implements Callable<Boolean>, Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 33969865104073117L;

	/**
	 * default constructor
	 */
	public RotateLogCallable() {
	}

	@Override
	public Boolean call() throws Exception {
		CLogFile fileHandler = CLogFile.get (false, null, false);
		//
		if (fileHandler != null) {
			fileHandler.rotateLog();
			return true;
		} else {
			return false;
		}
	}
}
