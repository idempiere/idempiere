package org.idempiere.webservices.fault;

import javax.xml.namespace.QName;
import javax.xml.ws.WebFault;

@WebFault(name="IdempiereServiceFault")
public class IdempiereServiceFault extends RuntimeException{

	public IdempiereServiceFault(String string, QName qName) {
		// TODO Auto-generated constructor stub
	}

	public IdempiereServiceFault(String string, Throwable cause, QName qName) {
		// TODO Auto-generated constructor stub
	}

	public IdempiereServiceFault(Exception exception) {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -5899509711372844325L;


}
