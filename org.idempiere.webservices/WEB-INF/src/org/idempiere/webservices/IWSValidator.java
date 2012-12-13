package org.idempiere.webservices;

import java.util.Map;
import java.util.Properties;

import org.compiere.model.MWebServiceType;
import org.compiere.model.PO;
import org.idempiere.webservices.fault.IdempiereServiceFault;

import org.idempiere.adInterface.x10.ADLoginRequest;
import org.idempiere.adInterface.x10.DataField;

public interface IWSValidator {
	public static final int TIME_BEFORE_PARSE=1;
	public static final int TIME_AFTER_PARSE=2;
	public static final int TIME_BEFORE_SAVE=3;
	public static final int TIME_AFTER_SAVE=4;
	
	public static final int TIME_BEFORE_LOGIN=5;
	public static final int TIME_AFTER_LOGIN=6;
	public static final int TIME_ON_AUTHENTICATION=7;
	
	public static final int TIME_BEFORE_PROCESS=8;
	public static final int TIME_AFTER_PROCESS=9;
	
	public void validate(PO po,MWebServiceType m_webserviceType,DataField[] fields,int time,String trxName,Map<String, Object> requestCtx) throws IdempiereServiceFault;
	public void  login(ADLoginRequest loginRequest,Properties ctx,MWebServiceType m_webserviceType,int time) throws IdempiereServiceFault; 
}
