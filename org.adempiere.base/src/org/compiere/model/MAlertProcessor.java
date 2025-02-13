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
package org.compiere.model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 *	Alert Processor
 *	
 *  @author Jorg Janke
 *  @version $Id: MAlertProcessor.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MAlertProcessor extends X_AD_AlertProcessor
	implements AdempiereProcessor, AdempiereProcessor2
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6566030540146374829L;

	/**
	 * 	Get active alert processors
	 *	@param ctx context
	 *	@return active alert processors
	 */
	public static MAlertProcessor[] getActive (Properties ctx)
	{
		List <MAlertProcessor> list = new Query(ctx,I_AD_AlertProcessor.Table_Name,  null, null)
		.setOnlyActiveRecords(true)
		.list();
		MAlertProcessor[] retValue = new MAlertProcessor[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getActive

	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MAlertProcessor.class);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_AlertProcessor_UU  UUID key
     * @param trxName Transaction
     */
    public MAlertProcessor(Properties ctx, String AD_AlertProcessor_UU, String trxName) {
        super(ctx, AD_AlertProcessor_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_AlertProcessorLog_ID id
	 *	@param trxName transaction
	 */
	public MAlertProcessor (Properties ctx, int AD_AlertProcessorLog_ID, String trxName)
	{
		super (ctx, AD_AlertProcessorLog_ID, trxName);
	}	//	MAlertProcessor

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAlertProcessor (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAlertProcessor

	/** Cache: Alerts array */
	private MAlert[] m_alerts = null;

	/**
	 * 	Get Server ID
	 *	@return id
	 */
	@Override
	public String getServerID ()
	{
		return "AlertProcessor" + get_ID();
	}	//	getServerID

	/**
	 * 	Get Date Next Run
	 *	@param requery requery
	 *	@return date next run
	 */
	@Override
	public Timestamp getDateNextRun (boolean requery)
	{
		if (requery)
			load(get_TrxName());
		return getDateNextRun();
	}	//	getDateNextRun

	/**
	 * 	Get Logs
	 *	@return logs
	 */
	@Override
	public AdempiereProcessorLog[] getLogs ()
	{
		final String whereClause ="AD_AlertProcessor_ID=?"; 
		List <MAlertProcessorLog> list = new Query(getCtx(), I_AD_AlertProcessorLog.Table_Name,  whereClause, null)
		.setParameters(getAD_AlertProcessor_ID())
		.setOrderBy("Created DESC")
		.list();
		MAlertProcessorLog[] retValue = new MAlertProcessorLog[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getLogs

	/**
	 * 	Delete old Request Log
	 *	@return number of records
	 */
	public int deleteLog()
	{
		if (getKeepLogDays() < 1)
			return 0;
		String sql = "DELETE FROM AD_AlertProcessorLog "
			+ "WHERE AD_AlertProcessor_ID=" + getAD_AlertProcessor_ID() 
			+ " AND (Created+" + getKeepLogDays() + ") < getDate()";
		int no = DB.executeUpdate(sql, get_TrxName());
		return no;
	}	//	deleteLog
	
	/**
	 * 	Get Alerts
	 *	@param reload true to always reload from DB
	 *	@return array of alerts
	 */
	public MAlert[] getAlerts (boolean reload)
	{
		if (m_alerts != null && !reload)
			return m_alerts;
		
		final String whereClause ="AD_AlertProcessor_ID=?"; 
		List <MAlert> list = new Query(getCtx(), I_AD_Alert.Table_Name,  whereClause, null)
		.setParameters(getAD_AlertProcessor_ID())
		.setOnlyActiveRecords(true)
		.list();
		
		//
		m_alerts = new MAlert[list.size ()];
		list.toArray (m_alerts);
		return m_alerts;
	}	//	getAlerts

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

}	//	MAlertProcessor
