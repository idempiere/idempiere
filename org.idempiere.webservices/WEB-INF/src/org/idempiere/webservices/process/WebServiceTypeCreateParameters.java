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
 *                                                                     *
 * Contributors:                                                       *
 * - Nicolas Micoud - TGI                                              *
 **********************************************************************/

package org.idempiere.webservices.process;

import org.compiere.model.MWebServiceType;
import org.compiere.process.SvrProcess;

/**
 * @author Nicolas Micoud - TGI
 */
public class WebServiceTypeCreateParameters extends SvrProcess {

	// The web service type (record on screen)
	private int p_WS_WebServiceType_ID;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		p_WS_WebServiceType_ID = getRecord_ID();
	}

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception {
		MWebServiceType ws = new MWebServiceType(getCtx(), p_WS_WebServiceType_ID, get_TrxName());
		ws.insertParameters();
		return "@ProcessOK@";
	} // doIt

} // WebServiceTypeCreateParameters
