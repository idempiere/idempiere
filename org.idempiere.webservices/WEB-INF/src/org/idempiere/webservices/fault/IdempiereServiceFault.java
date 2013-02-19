/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.webservices.fault;

import javax.xml.namespace.QName;
import javax.xml.ws.WebFault;

@WebFault(name="IdempiereServiceFault")
public class IdempiereServiceFault extends RuntimeException{

	public IdempiereServiceFault(String string, QName qName) {
		super(string);
	}

	public IdempiereServiceFault(String string, Throwable cause, QName qName) {
		super(string, cause);
	}

	public IdempiereServiceFault(Exception exception) {
		super(exception);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -5899509711372844325L;


}
