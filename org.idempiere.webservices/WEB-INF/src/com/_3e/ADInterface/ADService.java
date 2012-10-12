package com._3e.ADInterface;


import javax.jws.WebParam;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.ParameterStyle;
import javax.jws.soap.SOAPBinding.Style;
import javax.jws.soap.SOAPBinding.Use;

import pl.x3E.adInterface.ADLoginRequestDocument;
import pl.x3E.adInterface.ADLoginResponseDocument;
import pl.x3E.adInterface.ADMenuDocument;
import pl.x3E.adInterface.DocActionDocument;
import pl.x3E.adInterface.GetLookupSearchDataReqDocument;
import pl.x3E.adInterface.GetProcessParamsDocument;
import pl.x3E.adInterface.LocationDocument;
import pl.x3E.adInterface.ProcessParamsDocument;
import pl.x3E.adInterface.RunProcessDocument;
import pl.x3E.adInterface.RunProcessResponseDocument;
import pl.x3E.adInterface.StandardResponseDocument;
import pl.x3E.adInterface.WindowDocument;
import pl.x3E.adInterface.WindowTabDataDocument;
import pl.x3E.adInterface.WindowTabDataReqDocument;

@WebService(targetNamespace="http://3e.pl/ADInterface")
@SOAPBinding(style=Style.RPC,use=Use.LITERAL,parameterStyle=ParameterStyle.WRAPPED)
public interface ADService {

    public WindowDocument getADWindow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="AD_Window_ID") int AD_Window_ID,@WebParam(name="AD_Menu_ID") int AD_Menu_ID);
    //public WindowTabDataDocument getWindowTabData(int WindowNo, int AD_Window_ID, int AD_Menu_ID, int TabNo, int PrevTabNo, int PrevRecNo, boolean GetData) throws XFireFault;
    //public WindowTabDataDocument getWindowTabData(int WindowNo, int AD_Window_ID, int AD_Menu_ID, int TabNo, int PrevTabNo, int PrevRecNo, boolean GetData, int RowStart, int RowCount) throws XFireFault;
    public WindowTabDataDocument getWindowTabData(WindowTabDataReqDocument reqd);
    
    public WindowTabDataDocument getDataRow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo") int RowNo );
    public WindowTabDataDocument updateDataRow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo, WindowTabDataDocument data );
    public WindowTabDataDocument saveDataRow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo, WindowTabDataDocument data );
    public WindowTabDataDocument addNewDataRow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo );
    public WindowTabDataDocument deleteDataRow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo );
    public WindowTabDataDocument ignoreDataRow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo );
    public WindowTabDataDocument refreshDataRow(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo );
    
    public WindowTabDataDocument getLookupSearchData(GetLookupSearchDataReqDocument req);
    public WindowTabDataDocument getLookupData(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo,@WebParam(name="columnName") String columnName );
    
    public ADMenuDocument getADMenu(@WebParam(name="AD_Role_ID")int AD_Role_ID);
    
    public ADLoginResponseDocument login( ADLoginRequestDocument req );
    
    public ProcessParamsDocument getProcessParams( GetProcessParamsDocument req );
    public RunProcessResponseDocument runProcess( RunProcessDocument req );

    public StandardResponseDocument saveLocation( LocationDocument req );
    public LocationDocument getLocation( LocationDocument req );
    
    public DocActionDocument getDocAction(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo,@WebParam(name="ColName") String ColName );
    public StandardResponseDocument setDocAction(@WebParam(name="WindowNo") int WindowNo,@WebParam(name="TabNo") int TabNo,@WebParam(name="RowNo")  int RowNo,@WebParam(name="ColName")  String ColName,@WebParam(name="docAction") String docAction );    

    public String getVersion();
    
    public boolean isLoggedIn();

}
