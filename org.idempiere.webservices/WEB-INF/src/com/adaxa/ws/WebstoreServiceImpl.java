/**
 * 
 */
package com.adaxa.ws;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;

import javax.jws.WebService;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.Lookup;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MWebService;
import org.compiere.model.MWebServiceType;
import org.compiere.model.X_WS_WebServiceMethod;
import org.compiere.model.X_WS_WebService_Para;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

import com._3e.ADInterface.CompiereService;

/**
 * @author ashley
 */
@WebService(endpointInterface="com.adaxa.ws.WebstoreService", serviceName="WebstoreService", targetNamespace="http://3e.pl/ADInterface")
public class WebstoreServiceImpl implements WebstoreService
{

    protected static final CLogger logger = CLogger
            .getCLogger(WebstoreService.class);
    public static final String WEB_SERVICE_NAME = "WebstoreService";
    private CompiereService compiereService;
    private MWebService webService;
    private X_WS_WebServiceMethod webServiceMethod;
    private MWebServiceType webServiceType;

    public WebstoreServiceImpl()
    {
        compiereService = new CompiereService();
        compiereService.connect();
    }

    protected void login(LoginRequest loginRequest) throws Exception
    {
        Login login = new Login(compiereService.getM_ctx());

        // Validate user credentials
        KeyNamePair[] roles = login.getRoles(loginRequest.getUser(),
                loginRequest.getPass());

        if (roles == null)
        {
            throw new Exception("Login Error: Invalid user credentials");
        }

        // Validate role
        KeyNamePair loginRole = null;
        for (KeyNamePair role : roles)
        {
            if (role.getKey() == loginRequest.getRoleID())
            {
                loginRole = role;
                break;
            }
        }

        if (loginRole == null)
        {
            throw new Exception(
                    "Login Error: Role is not allowed for this user");
        }

        // Validate client
        KeyNamePair[] clients = login.getClients(loginRole);

        if (clients == null)
        {
            throw new Exception(
                    "Login Error: Client is not allowed for this user with the defined role");
        }

        KeyNamePair loginClient = null;
        for (KeyNamePair client : clients)
        {
            if (client.getKey() == loginRequest.getClientID())
            {
                loginClient = client;
                break;
            }
        }

        if (loginClient == null)
        {
            throw new Exception(
                    "Login Error: Client is not allowed for this user with the defined role");
        }

        compiereService.getM_ctx().setProperty("#AD_Client_ID", "" + loginRequest.getClientID());
        
        // Validate org
        KeyNamePair[] orgs = login.getOrgs(loginRole);
        if (orgs == null)
        {
            throw new Exception(
                    "Login Error: Organization is not allowed for this user");
        }

        KeyNamePair loginOrg = null;
        for (KeyNamePair org : orgs)
        {
            if (org.getKey() == loginRequest.getOrgID())
            {
                loginOrg = org;
                break;
            }
        }

        if (loginOrg == null)
        {
            throw new Exception(
                    "Login Error: Organization is not allowed for this user");
        }

        // Validate Warehouse
        KeyNamePair[] warehouses = login.getWarehouses(loginOrg);

        if (warehouses == null)
        {
            throw new Exception(
                    "Login Error: Warehouse is not allowed for this user");
        }

        KeyNamePair loginWarehouse = null;
        for (KeyNamePair warehouse : warehouses)
        {
            if (warehouse.getKey() == loginRequest.getWarehouseID())
            {
                loginWarehouse = warehouse;
                break;
            }
        }

        if (loginWarehouse == null)
        {
            throw new Exception(
                    "Login Error: Warehouse is not allowed for this user");
        }

        String error = login.validateLogin(loginOrg);

        if (error != null && error.length() > 0)
        {
            throw new Exception("Login Error: " + error);
        }

        int AD_User_ID = Env.getAD_User_ID(compiereService.getM_ctx());

        if (!compiereService.login(AD_User_ID, loginRequest.getRoleID(),
                loginRequest.getClientID(), loginRequest.getOrgID(),
                loginRequest.getWarehouseID(), loginRequest.getLang()))
        {
            throw new Exception(
                    "Login Error: Could not initialize login details");
        }
    }

    private void initWebServiceType(String webserviceValue, String methodValue,
            String serviceTypeValue) throws Exception
    {
        webService = MWebService.get(compiereService.getM_ctx(),
                webserviceValue);
        if (webService == null || !webService.isActive())
        {
            throw new Exception("Web Service Configuration Error: Web Service "
                    + webserviceValue + " not registered");
        }

        webServiceMethod = webService.getMethod(methodValue);
        if (webServiceMethod == null || !webServiceMethod.isActive())
        {
            throw new Exception("Web Service Configuration Error: Method "
                    + methodValue + " not registered");
        }

        String sql = "SELECT * FROM WS_WebServiceType "
                + "WHERE AD_Client_ID=? " + "AND WS_WebService_ID=? "
                + "AND WS_WebServiceMethod_ID=? " + "AND Value=? "
                + "AND IsActive='Y'";
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try
        {
            pstmt = DB.prepareStatement(sql, null);
            pstmt.setInt(1, compiereService.getM_AD_Client_ID());
            pstmt.setInt(2, webService.getWS_WebService_ID());
            pstmt.setInt(3, webServiceMethod.getWS_WebServiceMethod_ID());
            pstmt.setString(4, serviceTypeValue);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
                webServiceType = new MWebServiceType(
                        compiereService.getM_ctx(), rs, null);
            }
        }
        catch (Exception ex)
        {
            logger.log(Level.SEVERE, "Could not get web service type", ex);
            throw new Exception(
                    "Web Service Error: Could not get web service with type '"
                            + serviceTypeValue + "'");
        }
        finally
        {
            DB.close(rs, pstmt);
        }

        if (webServiceType == null)
        {
            throw new Exception("Web Service Error: Web service type '"
                    + serviceTypeValue + "' is not configured");
        }

        String accessSql = "SELECT IsReadWrite FROM WS_WebServiceTypeAccess WHERE AD_Role_ID=? "
                + "AND WS_WebServiceType_ID=? AND IsActive='Y'";

        String hasAccess = DB.getSQLValueString(null, accessSql,
                Env.getAD_Role_ID(compiereService.getM_ctx()),
                webServiceType.get_ID());

        if (!"Y".equals(hasAccess))
        {
            throw new Exception(
                    "Web Service Error: Login role does not have access to the service type");
        }
    }

    @SuppressWarnings("unchecked")
    private <T> T formatValue(String value, Class<T> type) throws Exception
    {
        try
        {
            if (value == null)
            {
                return null;
            }
            else if (String.class == type)
            {
                return (T) value;
            }
            else if (value.trim().length() == 0)
            {
                return null;
            }
            else if (Integer.class == type)
            {
                return (T) Integer.valueOf(value);
            }
            else if (BigDecimal.class == type)
            {
                return (T) new BigDecimal(value);
            }
            else if (Boolean.class == type)
            {
                if ("Y".equalsIgnoreCase(value))
                {
                    return (T) Boolean.TRUE;
                }
                else if ("N".equalsIgnoreCase(value))
                {
                    return (T) Boolean.FALSE;
                }

                return (T) Boolean.valueOf(value);
            }
            else if (Timestamp.class == type)
            {
                Date date = compiereService.dateFormat.parse(value);
                return (T) new Timestamp(date.getTime());
            }
            else
            {

                throw new Exception("Casting to type '"
                        + type.getClass().getName() + "' is not defined");
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Cannot cast parameter to type: "
                    + type.getClass().getName() + ", cause: " + ex.getMessage());
        }
    }

    public String formatValue(Object value)
    {
        if (value == null)
        {
            return "";
        }
        else if (value instanceof Timestamp)
        {
            Date date = new Date(((Timestamp) value).getTime());
            return compiereService.dateFormat.format(date);
        }

        return String.valueOf(value);
    }

    private <T> T getConstantParameterValue(MWebServiceType serviceType,
            String parameterName, Class<T> type) throws Exception
    {
        X_WS_WebService_Para processIdParameter = webServiceType
                .getParameter(parameterName);

        if (processIdParameter == null
                || !X_WS_WebService_Para.PARAMETERTYPE_Constant
                        .equals(processIdParameter.getParameterType()))
        {
            logger.severe("Invalid configuration for '" + parameterName
                    + "' parameter in the web service type: "
                    + serviceType.getName());
            throw new Exception("Web Service Error: Invalid configuraiton");
        }

        String parameterValue = processIdParameter.getConstantValue();

        try
        {
            return formatValue(parameterValue, type);
        }
        catch (Exception ex)
        {
            logger.severe("Error in formatting value, cause: "
                    + ex.getMessage());
            throw new Exception(
                    "Web Service Error: Invalid configuration for parameter '"
                            + parameterName + "' and service type '"
                            + serviceType.getName() + "'");
        }
    }

    private MPInstance fillParameters(MProcess process,
            Parameter parameters[], int recordId) throws Exception
    {
        MPInstance processInstance = new MPInstance(process, recordId);
        MPInstancePara[] instanceParameters = processInstance.getParameters();
        HashMap<String, String> parametersMap = new HashMap<String, String>();
        for (Parameter parameter : parameters)
        {
            parametersMap.put(parameter.getName(), parameter.getValue());
        }

        for (int i = 0; i < instanceParameters.length; i++)
        {
            MPInstancePara instanceParameter = instanceParameters[i];
            String parameterName = instanceParameter.getParameterName();
            MProcessPara processParameter = process.getParameter(parameterName);

            if (processParameter == null)
            {
                logger.severe("Parameter '" + parameterName
                        + "' not found for process with value '"
                        + process.getValue() + "'");
                continue;
            }

            int displayType = processParameter.getAD_Reference_ID();

            String value = parametersMap.get(parameterName);
            String valueTo = null;
            
            if (value != null)
            {
                value = value.trim();
            }

            if (processParameter.isRange())
            {
                valueTo = parametersMap.get(parameterName + "_2");
                
                if (valueTo != null)
                {
                    valueTo = valueTo.trim();
                }
            }

            if (value != null && value.length() == 0)
                value = null;

            if (value != null
                    && (DisplayType.List == displayType
                            || DisplayType.TableDir == displayType || DisplayType.Table == displayType)
                    && value.equals("-1"))
            {
                value = null;
            }

            if (value == null && processParameter.isMandatory())
            {
                throw new Exception("Parameter '" + parameterName
                        + "' is mandatory");
            }

            if (DisplayType.isNumeric(displayType)
                    || DisplayType.isID(displayType))
            {
                instanceParameter.setP_Number(formatValue(value,
                        BigDecimal.class));
                if (processParameter.isRange())
                {
                    instanceParameter.setP_Number_To(formatValue(valueTo,
                            BigDecimal.class));
                }
            }
            else if (DisplayType.isDate(displayType))
            {
                instanceParameter
                        .setP_Date(formatValue(value, Timestamp.class));
                if (processParameter.isRange())
                {
                    instanceParameter.setP_Date_To(formatValue(valueTo,
                            Timestamp.class));
                }
            }
            else if (DisplayType.YesNo == processParameter.getAD_Reference_ID())
            {
                boolean booleanValue = formatValue(value, Boolean.class);
                instanceParameter.setP_String((booleanValue ? "Y" : "N"));
            }
            if (processParameter.isLookup())
            {
                Lookup lookup = processParameter.getLookup();
                if (lookup != null)
                {
                    NamePair namePair = lookup.getDirect(value, false, false);
                    if (namePair != null)
                    {
                        instanceParameter.setInfo(namePair.getName());
                    }
                }
            }
            else
            {
                instanceParameter.setP_String(value);
                instanceParameter.setP_String_To(valueTo);
            }

            instanceParameter.saveEx();
        }

        processInstance.saveEx();

        return processInstance;
    }

    private void fillOutputValues(MProcess process, ProcessInfo processInfo,
            ProcessResponse processResponse)
    {
        if (processInfo.getSerializableObject() != null
                && processInfo.getSerializableObject() instanceof List)
        {
            List<?> outputValues = (List<?>) processInfo
                    .getSerializableObject();
            for (Object obj : outputValues)
            {
                if (obj instanceof ValueNamePair)
                {
                    ValueNamePair outputValueNamePair = (ValueNamePair)obj;
                    OutputData outputData = processResponse.addNewOuptutData();
                    outputData.setName(outputValueNamePair.getName());
                    outputData.setValue(formatValue(outputValueNamePair.getValueObject()));
                }
            }
        }
    }

    public ProcessResponseDocument runProcess(ProcessRequestDocument requestDoc)
    {
        ProcessResponseDocument responseDoc = ProcessResponseDocument.Factory.newInstance();
        ProcessResponse response = responseDoc.addNewProcessResponse();
        
        LoginRequest loginRequest = requestDoc.getProcessRequest()
                .getLoginRequest();

        String serviceType = requestDoc.getProcessRequest().getServiceType();

        try
        {
            login(loginRequest);
            initWebServiceType(WEB_SERVICE_NAME, "runProcess", serviceType);
            String processValue = getConstantParameterValue(webServiceType,
                    "PROCESS", String.class);

            int processId = MProcess.getProcess_ID(processValue, null);
            
            if (processId <= 0)
            {
                logger.severe("Process with value '" + processValue + "' not found");
                throw new Exception("Configuration error - Process not found");
            }
            
            MProcess process = MProcess.get(compiereService.getM_ctx(),
                    processId);

            String accessSql = "SELECT IsReadWrite FROM AD_Process_Access "
                    + "WHERE AD_Role_ID=? AND AD_Process_ID=? AND IsActive='Y'";
            String hasAccess = DB.getSQLValueString(null, accessSql,
                    Env.getAD_Role_ID(compiereService.getM_ctx()), processId);
            
            if (!"Y".equals(hasAccess))
            {
                throw new Exception("Configuration Error: Login role doesn not have access to the process");
            }
            
            Parameter[] parameters = requestDoc.getProcessRequest().getProcessData().getParameterArray();
            MPInstance processInstance = fillParameters(process, parameters, 0);
            
            ProcessInfo processInfo = new ProcessInfo (process.getName(), process.getAD_Process_ID());
            processInfo.setAD_User_ID(Env.getAD_User_ID(compiereService.getM_ctx()));
            processInfo.setAD_Client_ID(Env.getAD_Client_ID(compiereService.getM_ctx()));
            processInfo.setAD_PInstance_ID(processInstance.getAD_PInstance_ID());
            
            boolean success = false;
            
            Trx trx = Trx.get(Trx.createTrxName("WSProcess"), true);
            try
            {
                success = process.processIt(processInfo, trx);
                fillOutputValues(process, processInfo, response);
                trx.commit();
            }
            finally
            {
                trx.rollback();
                trx.close();
            }
            
            if (success && !processInfo.isError())
            {
                response.setIsError(false);
            }
            else
            {
                response.setIsError(true);
                response.setError(processInfo.getSummary());
            }
        }
        catch (AdempiereException ex)
        {
            response.setIsError(true);
            response.setError(ex.getMessage());
        }
        catch (Exception ex)
        {
            response.setIsError(true);
            response.setError(ex.getMessage());
        }

        return responseDoc;
    }
}
