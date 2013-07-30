package com.trekglobal.ws;

import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.ParameterStyle;
import javax.jws.soap.SOAPBinding.Style;
import javax.jws.soap.SOAPBinding.Use;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import org.idempiere.adInterface.x10.CompositeRequestDocument;
import org.idempiere.adInterface.x10.CompositeResponsesDocument;

@Path("/composite_service/")
@Consumes("application/xml") 
@Produces("application/xml")
@WebService(targetNamespace="http://idempiere.org/ADInterface/1_0")
@SOAPBinding(style=Style.RPC,use=Use.LITERAL,parameterStyle=ParameterStyle.WRAPPED)
public interface CompositeService {

	/**
	 * 
	 * @param reqs
	 * @return CompositeResponsesDocument 
	 */
    @POST
	@Path("/composite_operation") 
	public CompositeResponsesDocument compositeOperation(CompositeRequestDocument reqs);
}
