package org.compiere.wf;

import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfo;
import org.compiere.process.StateEngine;
import org.compiere.util.CLogger;

/**
 * State machine Workflow Controller
 */
public class StateMachineWorkflowCtl {
    
    private static final CLogger s_log = CLogger.getCLogger(StateMachineWorkflowCtl.class);
    
    /**
     * Start a new state machine workflow for a record
     * 
     * @param ctx Context
     * @param record The record for which to start the workflow
     * @param workflowId The workflow ID to start
     * @param tableId The table ID of the record
     * @param recordId The record ID
     * @param trxName Transaction name
     * @return The workflow process that was started, or null if no workflow was found/started
     */
    public static MWFProcess startStateMachineWorkflow(Properties ctx, PO record, int workflowId, int tableId, int recordId, String trxName) {
        if (record == null || workflowId <= 0 || tableId <= 0 || recordId <= 0)
            return null;
        
        if (record.getActiveWorkflows().contains(workflowId))
        	return null;
        
        try {
            MWorkflow workflow = MWorkflow.get(ctx, workflowId);
            if (workflow == null || workflow.get_ID() == 0) {
                s_log.warning("Workflow not found: " + workflowId);
                return null;
            }
            
            // Only process General workflows
            if (!MWorkflow.WORKFLOWTYPE_General.equals(workflow.getWorkflowType())) {
                s_log.warning("Workflow " + workflow.getName() + " is not of type General: " + workflow.getWorkflowType());
                return null;
            }
            
            // Start workflow
            ProcessInfo pi = new ProcessInfo("State machine Workflow", 0, tableId, recordId);
            pi.setTransactionName(trxName);
            workflow.start(pi, true, trxName);
            
        } catch (Exception e) {
            s_log.log(Level.SEVERE, "Error starting workflow: " + e.getMessage(), e);
        }
        
        return null;
    }
    
    /**
     * Continue an existing state machine workflow for a record
     * 
     * @param ctx Context
     * @param record The record for which to continue the workflow
     * @param tableId The table ID of the record
     * @param recordId The record ID
     * @param trxName Transaction name
     * @return true if the workflow was continued successfully
     */
    public static boolean continueStateMachineWorkflow(Properties ctx, PO record, int tableId, int recordId, String trxName) {
        try {
        	MWFProcess process = findSuspendedStateMachineWorkflowProcess(ctx, tableId, recordId, trxName);
        	if (process == null) {
        		return false;
        	}			
        	if (record.getActiveWorkflows().contains(process.getWorkflow().getAD_Workflow_ID()))
        		return false;
			process.checkActivities(trxName, record, false, process.getLastActivity());
			
			if (process.isFinalNodeCompleted())
				process.checkCloseActivities(true, trxName);
			
		} catch (Exception e) {
			s_log.log(Level.SEVERE, "Error continuing workflow for request: " + e.getMessage(), e);
		}
		
		return true;
    }
    
    /**
     * Find an active workflow process for a given record
     * 
     * @param ctx Context
     * @param tableId Table ID
     * @param recordId Record ID
     * @param trxName Transaction name
     * @return Active workflow process or null if not found
     */
    public static MWFProcess findSuspendedStateMachineWorkflowProcess(Properties ctx, int tableId, int recordId, String trxName) {
        return new Query(ctx, MWFProcess.Table_Name,
                "AD_Table_ID=? AND Record_ID=? AND Processed=? AND WFState=?", trxName)
            .setParameters(tableId, recordId, false, StateEngine.STATE_Suspended)
            .setOrderBy("Created DESC") // Get the most recent one
            .first();
    }
    
}