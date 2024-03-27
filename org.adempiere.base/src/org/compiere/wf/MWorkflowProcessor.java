/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.wf;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.model.AdempiereProcessor;
import org.compiere.model.AdempiereProcessor2;
import org.compiere.model.AdempiereProcessorLog;
import org.compiere.model.MClientInfo;
import org.compiere.model.MOrgInfo;
import org.compiere.model.MSchedule;
import org.compiere.model.Query;
import org.compiere.model.X_AD_WorkflowProcessor;
import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 *	Extended Workflow Processor Model for AD_WorkflowProcessor
 *	
 *  @author Jorg Janke
 *  @version $Id: MWorkflowProcessor.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MWorkflowProcessor extends X_AD_WorkflowProcessor
	implements AdempiereProcessor,AdempiereProcessor2
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 6110376502075157361L;

	/**
	 * 	Get active workflow processors
	 *	@param ctx context
	 *	@return active workflow processors
	 */
	public static MWorkflowProcessor[] getActive (Properties ctx)
	{
		List<MWorkflowProcessor> list = new Query(ctx, Table_Name, null, null)
					.setOnlyActiveRecords(true)
					.list();
		MWorkflowProcessor[] retValue = new MWorkflowProcessor[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getActive
		
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_WorkflowProcessor_UU  UUID key
     * @param trxName Transaction
     */
    public MWorkflowProcessor(Properties ctx, String AD_WorkflowProcessor_UU, String trxName) {
        super(ctx, AD_WorkflowProcessor_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_WorkflowProcessor_ID id
	 * 	@param trxName transaction
	 */
	public MWorkflowProcessor (Properties ctx, int AD_WorkflowProcessor_ID, String trxName)
	{
		super (ctx, AD_WorkflowProcessor_ID, trxName);
	}	//	MWorkflowProcessor

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 * 	@param trxName transaction
	 */
	public MWorkflowProcessor (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MWorkflowProcessor

	/**
	 * 	Get Server ID
	 *	@return server id
	 */
	@Override
	public String getServerID ()
	{
		return "WorkflowProcessor" + get_ID();
	}	//	getServerID

	/**
	 * 	Get Date Next Run
	 *	@param requery true to reload from DB
	 *	@return next run date
	 */
	public Timestamp getDateNextRun (boolean requery)
	{
		if (requery)
			load(get_TrxName());
		return getDateNextRun();
	}	//	getDateNextRun

	/**
	 * 	Get process logs
	 *	@return processor logs
	 */
	@Override
	public AdempiereProcessorLog[] getLogs ()
	{
		List<MWorkflowProcessorLog> list = new Query(getCtx(), MWorkflowProcessorLog.Table_Name, "AD_WorkflowProcessor_ID=?", get_TrxName())
			.setParameters(new Object[]{getAD_WorkflowProcessor_ID()})
			.setOrderBy("Created DESC")
			.list();
		MWorkflowProcessorLog[] retValue = new MWorkflowProcessorLog[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getLogs
	
	/**
	 * 	Delete old processor logs
	 *	@return number of records deleted
	 */
	public int deleteLog()
	{
		if (getKeepLogDays() < 1)
			return 0;
		String sql = "DELETE FROM AD_WorkflowProcessorLog "
			+ "WHERE AD_WorkflowProcessor_ID=" + getAD_WorkflowProcessor_ID() 
			+ " AND (Created+" + getKeepLogDays() + ") < getDate()";
		int no = DB.executeUpdate(sql, get_TrxName());
		return no;
	}	//	deleteLog

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		// Calculate DateNextRun for new record or if schedule has change
		if (newRecord || is_ValueChanged("AD_Schedule_ID")) {
			String timeZoneId = null;
			if((getAD_Client_ID() == 0 && getAD_Org_ID() == 0) || getAD_Org_ID() > 0) {
				MOrgInfo orgInfo = MOrgInfo.get(getAD_Org_ID());
				timeZoneId = orgInfo.getTimeZone();
			}
			
			if(Util.isEmpty(timeZoneId, true)) {
				MClientInfo clientInfo = MClientInfo.get(getCtx(), getAD_Client_ID());
				if (clientInfo == null)
					clientInfo = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName());
				timeZoneId = clientInfo.getTimeZone();
			}
			long nextWork = MSchedule.getNextRunMS(System.currentTimeMillis(), getScheduleType(), getFrequencyType(), getFrequency(), getCronPattern(),
					timeZoneId);
			if (nextWork > 0)
				setDateNextRun(new Timestamp(nextWork));
		}
		
		return true;
	}	//	beforeSave

	@Override
	public String getFrequencyType() {
	   return MSchedule.get(getCtx(),getAD_Schedule_ID()).getFrequencyType();
	}

	@Override
	public int getFrequency() {
	   return MSchedule.get(getCtx(),getAD_Schedule_ID()).getFrequency();
	}

	@Override
	public boolean isIgnoreProcessingTime() {
	   return MSchedule.get(getCtx(),getAD_Schedule_ID()).isIgnoreProcessingTime();
	}

	@Override
	public String getScheduleType() {
	   return MSchedule.get(getCtx(),getAD_Schedule_ID()).getScheduleType();
	}

	@Override
	public String getCronPattern() {
	   return MSchedule.get(getCtx(),getAD_Schedule_ID()).getCronPattern();
	}

}	//	MWorkflowProcessor
