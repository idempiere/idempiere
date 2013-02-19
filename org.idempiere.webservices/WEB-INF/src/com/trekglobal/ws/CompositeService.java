package com.trekglobal.ws;

import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.ParameterStyle;
import javax.jws.soap.SOAPBinding.Style;
import javax.jws.soap.SOAPBinding.Use;

import org.idempiere.adInterface.x10.CompositeRequestDocument;
import org.idempiere.adInterface.x10.CompositeResponsesDocument;

@WebService(targetNamespace="http://idempiere.org/ADInterface/1_0")
@SOAPBinding(style=Style.RPC,use=Use.LITERAL,parameterStyle=ParameterStyle.WRAPPED)
public interface CompositeService {

	/**
	 * 
	 * @param reqs
	 * @return CompositeResponsesDocument 
	 */
	public CompositeResponsesDocument compositeOperation(CompositeRequestDocument reqs);
}
