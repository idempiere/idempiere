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
