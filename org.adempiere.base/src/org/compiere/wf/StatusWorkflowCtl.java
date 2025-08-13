package org.compiere.wf;

import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfo;
import org.compiere.process.StateEngine;
import org.compiere.util.CLogger;

public class StatusWorkflowCtl {

	private static final CLogger s_log = CLogger.getCLogger(StatusWorkflowCtl.class);
    
    /**
     * Start a new status workflow for a record
     * 
     * @param ctx Context
     * @param record The record for which to start the workflow
     * @param workflowId The workflow ID to start
     * @param tableId The table ID of the record
     * @param recordId The record ID
     * @param trxName Transaction name
     * @return The workflow process that was started, or null if no workflow was found/started
     */
    public static MWFProcess startStatusWorkflow(Properties ctx, PO record, int workflowId, int tableId, int recordId, String trxName) {
        if (record == null || workflowId <= 0 || tableId <= 0 || recordId <= 0)
            return null;
            
        try {
            // Get the workflow definition
            MWorkflow workflow = MWorkflow.get(ctx, workflowId);
			workflow.setDisallowAutoStartNextNode(true);
            
            if (workflow == null || workflow.get_ID() == 0) {
                s_log.warning("Workflow not found: " + workflowId);
                return null;
            }
            
            // Only process General workflows
            if (!MWorkflow.WORKFLOWTYPE_General.equals(workflow.getWorkflowType())) {
                s_log.warning("Workflow " + workflow.getName() + " is not of type General: " + workflow.getWorkflowType());
                return null;
            }
            
            // Create the process info for this record
            ProcessInfo pi = new ProcessInfo("Status Workflow", 0, tableId, recordId);
            pi.setTransactionName(trxName);
            
            // Start workflow with an immediate suspension at first node
            MWFProcess process = workflow.start(pi, trxName);
            
            if (process != null) {
                // Get the active activity (should be the first node at this point)
                MWFActivity[] activities = process.getActivities(true, true, trxName);
                if (activities != null && activities.length > 0) {
                    MWFActivity activity = activities[0];
                    
                    // Suspend the workflow at this point (prevent auto progression)
                    activity.setWFState(StateEngine.STATE_Suspended);
                    activity.saveEx();
                    
                    s_log.fine("Started workflow " + workflow.getName() + 
                             " for record ID " + recordId +
                             " - suspended at node " + activity.getNode().getName());
                }
                
                return process;
            } else {
                s_log.warning("Failed to start workflow " + workflow.getName() + " for record ID " + recordId);
            }
        } catch (Exception e) {
            s_log.log(Level.SEVERE, "Error starting status workflow: " + e.getMessage(), e);
        }
        
        return null;
    }
    
    /**
     * Continue an existing status workflow for a record
     * 
     * @param ctx Context
     * @param record The record for which to continue the workflow
     * @param tableId The table ID of the record
     * @param recordId The record ID
     * @param trxName Transaction name
     * @return true if the workflow was continued successfully
     */
    public static boolean continueStatusWorkflow(Properties ctx, PO record, int tableId, int recordId, String trxName) {
        try {
        	MWFProcess process = findSuspendedStatusWorkflowProcess(ctx, tableId, recordId, trxName);
        	if (process == null) {
        		s_log.fine("No active workflow process found for record ID: " + recordId);
        		return false;
        	}
			
			process.checkActivities(trxName, record, false, process.getLastActivity());
			
			if (process.isFinalNodeCompleted())
				process.checkCloseActivities(trxName);
			
			
		} catch (Exception e) {
			s_log.log(Level.SEVERE, "Error continuing workflow for request: " + e.getMessage(), e);
		}
		
		return false;
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
    public static MWFProcess findSuspendedStatusWorkflowProcess(java.util.Properties ctx, int tableId, int recordId, String trxName) {
        return new Query(ctx, MWFProcess.Table_Name,
                "AD_Table_ID=? AND Record_ID=? AND Processed=? AND WFState=?", trxName)
            .setParameters(tableId, recordId, false, StateEngine.STATE_Suspended)
            .setOrderBy("Created DESC") // Get the most recent one
            .first();
    }
	
}
