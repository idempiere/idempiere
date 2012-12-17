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
package com.bizidium.ws;

import java.util.ArrayList;
import java.util.Properties;

import javax.jws.WebService;

import org.compiere.util.CLogger;
import org.compiere.util.Trx;
import org.idempiere.adInterface.x10.ADLoginRequest;
import org.idempiere.adInterface.x10.CompositeRequest;
import org.idempiere.adInterface.x10.CompositeRequestDocument;
import org.idempiere.adInterface.x10.CompositeResponse;
import org.idempiere.adInterface.x10.CompositeResponses;
import org.idempiere.adInterface.x10.CompositeResponsesDocument;
import org.idempiere.adInterface.x10.DataField;
import org.idempiere.adInterface.x10.ModelCRUD;
import org.idempiere.adInterface.x10.ModelCRUDRequest;
import org.idempiere.adInterface.x10.ModelCRUDRequestDocument;
import org.idempiere.adInterface.x10.ModelRunProcessRequest;
import org.idempiere.adInterface.x10.ModelRunProcessRequestDocument;
import org.idempiere.adInterface.x10.ModelSetDocActionRequest;
import org.idempiere.adInterface.x10.ModelSetDocActionRequestDocument;
import org.idempiere.adInterface.x10.Operation;
import org.idempiere.adInterface.x10.Operation.TargetPort;
import org.idempiere.adInterface.x10.Operations;
import org.idempiere.adInterface.x10.RunProcessResponseDocument;
import org.idempiere.adInterface.x10.StandardResponse;
import org.idempiere.adInterface.x10.StandardResponseDocument;
import org.idempiere.adInterface.x10.WindowTabDataDocument;
import org.idempiere.adinterface.CompiereService;
import org.idempiere.adinterface.ModelADServiceImpl;
import org.idempiere.webservices.AbstractService;


/**
 * Composite service interface for combining request and transaction management
 * 
 * @author Deepak Pansheriya
 * 
 */
@WebService(endpointInterface = "com.bizidium.ws.CompositeService", serviceName = "compositeInterface" ,targetNamespace="http://idempiere.org/ADInterface/1_0")
public class CompositeServiceImpl extends AbstractService implements CompositeService {
	private static CLogger log = CLogger.getCLogger(CompositeServiceImpl.class);

	private static String webServiceName = new String("CompositeInterface");

	public CompositeServiceImpl() {

		log.info("Creating session object BiziInterface");
	}

	
	public CompositeResponsesDocument compositeOperation(CompositeRequestDocument reqs) {

		CompiereService m_cs = getCompiereService();

		CompositeResponsesDocument ret = CompositeResponsesDocument.Factory.newInstance();
		CompositeResponses resps = ret.addNewCompositeResponses();

		CompositeRequest req = reqs.getCompositeRequest();
		String serviceType = req.getServiceType();

		ADLoginRequest reqlogin = req.getADLoginRequest();
		String err = login(reqlogin, webServiceName, "composite", serviceType);
		if (err != null && err.length() > 0) {
			CompositeResponse resp = resps.addNewCompositeResponse();
			StandardResponse stdResp = resp.addNewStandardResponse();
			stdResp.setError(err);
			stdResp.setIsError(true);
			return ret;
		}

		ModelADServiceImpl modelADService = new ModelADServiceImpl(ctx);

		String trxName = m_cs.getM_trx_name();
		trxName = Trx.createTrxName("ws_biziInterface");

		Trx trx = Trx.get(trxName, true);

		modelADService.setLocalTrxName(trxName);

		Operations operationsArr[] = req.getOperationsArray();

		for (Operations operations : operationsArr) {
			Operation operationArr[] = operations.getOperationArray();
			if (operationArr.length > 0) {
				CompositeResponse compResp = resps.addNewCompositeResponse();
				ArrayList<StandardResponse> respAggregator = new ArrayList<StandardResponse>();
				boolean isSuccess = performOperations(trx, operationArr, modelADService, compResp, respAggregator, reqlogin);

				// Committing after each operation set
				if (isSuccess) {
					commitTrx(trx, compResp, respAggregator, "Cannot commit at end of process", false);
				}

			}
		}

		trx.close();

		return ret;
	}

	/**
	 * Perform operation
	 * @param trx
	 * @param ops
	 * @param modelADService
	 * @param compResp
	 * @param respAggregator
	 * @param reqlogin
	 * @return isError
	 */
	private boolean performOperations(Trx trx, Operation ops[], ModelADServiceImpl modelADService, CompositeResponse compResp,
			ArrayList<StandardResponse> respAggregator, ADLoginRequest reqlogin) {
		for (Operation operation : ops) {

			if (operation.getPreCommit()) {
				if (!commitTrx(trx, compResp, respAggregator, "Cannot commit before Operation", true)) {
					return false;
				}
			}

			modelADService.setManageTrx(false);

			TargetPort.Enum portEnum = operation.getTargetPort();

			StandardResponseDocument respDoc = null;
			if (portEnum == TargetPort.CREATE_DATA) {
				ModelCRUDRequestDocument wrapperDoc = getWrappedCRUD(operation, reqlogin);
				if (wrapperDoc == null) {
					rollbackAndSetError(trx, compResp, respAggregator, "Operation createData must required ModelCRUD");
					return false;
				} else {
					respDoc = modelADService.createData(wrapperDoc);
				}
			} else if (portEnum == TargetPort.DELETE_DATA) {
				ModelCRUDRequestDocument wrapperDoc = getWrappedCRUD(operation, reqlogin);
				if (wrapperDoc == null) {
					rollbackAndSetError(trx, compResp, respAggregator, "Operation deleteData must required ModelCRUD");
					return false;
				} else {
					respDoc = modelADService.deleteData(wrapperDoc);
				}
			} else if (portEnum == TargetPort.CREATE_UPDATE_DATA) {
				ModelCRUDRequestDocument wrapperDoc = getWrappedCRUD(operation, reqlogin);
				if (wrapperDoc == null) {
					rollbackAndSetError(trx, compResp, respAggregator, "Operation createUpdateData must required ModelCRUD");
					return false;
				} else {
					respDoc = modelADService.createUpdateData(wrapperDoc);
				}
			} else if (portEnum == TargetPort.READ_DATA) {
				ModelCRUDRequestDocument wrapperDoc = getWrappedCRUD(operation, reqlogin);
				if (wrapperDoc == null) {
					// Do not rollback, Continue with consecutive operations
					respDoc = StandardResponseDocument.Factory.newInstance();
					StandardResponse resp = respDoc.addNewStandardResponse();
					resp.setIsError(false);
					resp.setError("Operation readData must required ModelCRUD");
				} else {
					WindowTabDataDocument dataResponse = modelADService.readData(wrapperDoc);
					if (dataResponse != null) {
						respDoc = StandardResponseDocument.Factory.newInstance();
						StandardResponse resp = respDoc.addNewStandardResponse();
						// Do not fail though read is failed
						resp.setIsError(false);
						resp.setWindowTabData(dataResponse.getWindowTabData());
					}
				}
			} else if (portEnum == TargetPort.RUN_PROCESS) {
				if (operation.getModelRunProcess() == null) {
					rollbackAndSetError(trx, compResp, respAggregator, "Operation runProcess must required ModelRunProcess");
					return false;
				}

				ModelRunProcessRequestDocument wrapperDoc = ModelRunProcessRequestDocument.Factory.newInstance();
				ModelRunProcessRequest runProcessReq = wrapperDoc.addNewModelRunProcessRequest();
				runProcessReq.setADLoginRequest(reqlogin);
				runProcessReq.setModelRunProcess(operation.getModelRunProcess());

				RunProcessResponseDocument runResponse = modelADService.runProcess(wrapperDoc);
				if (runResponse != null) {
					respDoc = StandardResponseDocument.Factory.newInstance();
					StandardResponse resp = respDoc.addNewStandardResponse();
					resp.setIsError(runResponse.getRunProcessResponse().getIsError());
					resp.setRunProcessResponse(runResponse.getRunProcessResponse());
				}
			} else if (portEnum == TargetPort.SET_DOC_ACTION) {
				if (operation.getModelSetDocAction() == null) {
					rollbackAndSetError(trx, compResp, respAggregator, "Operation updateData must required ModelSetDocAction");
					return false;
				}

				ModelSetDocActionRequestDocument wrapperDoc = ModelSetDocActionRequestDocument.Factory.newInstance();
				ModelSetDocActionRequest actionReq = wrapperDoc.addNewModelSetDocActionRequest();
				actionReq.setADLoginRequest(reqlogin);
				actionReq.setModelSetDocAction(operation.getModelSetDocAction());

				respDoc = modelADService.setDocAction(wrapperDoc);

			} else if (portEnum == TargetPort.UPDATE_DATA) {
				ModelCRUDRequestDocument wrapperDoc = getWrappedCRUD(operation, reqlogin);
				if (wrapperDoc == null) {
					rollbackAndSetError(trx, compResp, respAggregator, "Operation updateData must required ModelCRUD");
					return false;
				} else {
					respDoc = modelADService.updateData(wrapperDoc);
				}
			}

			if (respDoc != null)
				respAggregator.add(respDoc.getStandardResponse());

			if (respDoc != null && respDoc.getStandardResponse().getIsError()) {
				rollbackAndSetError(trx, compResp, respAggregator, null);
				return false;
			}

			if (operation.getPostCommit()) {

				if (!commitTrx(trx, compResp, respAggregator, "Cannot commit after operation", false)) {
					return false;
				}
			}

		}
		return true;
	}

	/**
	 * create ModelCRUDRequestDocument for operation element
	 * @param operation
	 * @param reqlogin
	 * @return
	 */
	private ModelCRUDRequestDocument getWrappedCRUD(Operation operation, ADLoginRequest reqlogin) {
		if (operation.getModelCRUD() == null)
			return null;

		ModelCRUDRequestDocument wrapperDoc = ModelCRUDRequestDocument.Factory.newInstance();
		ModelCRUDRequest wrapperCRUD = wrapperDoc.addNewModelCRUDRequest();
		wrapperCRUD.setModelCRUD(operation.getModelCRUD());
		wrapperCRUD.setADLoginRequest(reqlogin);

		return wrapperDoc;
	}

	public void resolveContextCRUD(Properties ctx, ModelCRUD crud) {
		DataField fields[] = crud.getDataRow().getFieldArray();
		for (DataField field : fields) {
			String val = field.getVal();
			if (val != null && val.startsWith("#")) {
				// Replace value from context variables
				String key = val.substring(1);
				val = (String) ctx.get(key);
				field.setVal(val);
			}
		}
	}

	/**
	 * Rollback and set error on response
	 * @param trx
	 * @param compResp
	 * @param respAggregator
	 * @param string
	 */
	protected void rollbackAndSetError(Trx trx, CompositeResponse compResp, ArrayList<StandardResponse> respAggregator, String string) {
		if (respAggregator == null) {
			StandardResponse resp = compResp.addNewStandardResponse();
			resp.setError(string);
			resp.setIsError(true);
		} else {
			int ind = 0;
			StandardResponse orgArr[] = compResp.getStandardResponseArray();
			StandardResponse respArr[] = new StandardResponse[orgArr.length + respAggregator.size()];

			for (StandardResponse resp : orgArr) {
				respArr[ind++] = resp;
			}
			// Set all response as Failed
			for (StandardResponse resp : respAggregator) {
				resp.setIsRolledBack(true);
				respArr[ind++] = resp;
			}
			if (string != null && respAggregator.size() > 0) {
				StandardResponse resp = respAggregator.get(respAggregator.size() - 1);
				resp.setError(string);
				resp.setIsError(true);
			}
			compResp.setStandardResponseArray(respArr);
			respAggregator.clear();
		}
		trx.rollback();
		trx.close();
	}

	/**
	 * Commit transaction and prepare response document
	 * @param trx
	 * @param compResp
	 * @param respAggregator
	 * @param string
	 * @param addNewResp
	 * @return
	 */
	protected boolean commitTrx(Trx trx, CompositeResponse compResp, ArrayList<StandardResponse> respAggregator, String string,
			boolean addNewResp) {

		if (trx.isActive() && !trx.commit()) {
			if (addNewResp)
				respAggregator.add(StandardResponse.Factory.newInstance());

			rollbackAndSetError(trx, compResp, respAggregator, string);
			return false;
		}

		int ind = 0;
		StandardResponse orgArr[] = compResp.getStandardResponseArray();
		StandardResponse respArr[] = new StandardResponse[orgArr.length + respAggregator.size()];

		for (StandardResponse resp : orgArr) {
			respArr[ind++] = resp;
		}
		// Set all committed response
		for (StandardResponse resp : respAggregator) {
			respArr[ind++] = resp;
		}

		compResp.setStandardResponseArray(respArr);
		respAggregator.clear();

		return true;
	}
}
