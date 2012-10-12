/**
 * 
 */
package com.adaxa.ws;

import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.ParameterStyle;
import javax.jws.soap.SOAPBinding.Style;
import javax.jws.soap.SOAPBinding.Use;


/**
 * @author ashley
 * 
 */
@WebService(targetNamespace="http://3e.pl/ADInterface")
@SOAPBinding(style=Style.RPC,use=Use.LITERAL,parameterStyle=ParameterStyle.WRAPPED)
public interface WebstoreService
{
    public ProcessResponseDocument runProcess(ProcessRequestDocument requestDoc);
}
