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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

/**
 *	Revenue Recognition Plan
 *	
 *  @author Jorg Janke
 *  @version $Id: MRevenueRecognitionPlan.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MRevenueRecognitionPlan extends X_C_RevenueRecognition_Plan
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8437258098744762898L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_RevenueRecognition_Plan_ID id
	 */
	public MRevenueRecognitionPlan (Properties ctx, int C_RevenueRecognition_Plan_ID, String trxName)
	{
		super (ctx, C_RevenueRecognition_Plan_ID, trxName);
		if (C_RevenueRecognition_Plan_ID == 0)
		{
			setTotalAmt (Env.ZERO);
			setRecognizedAmt (Env.ZERO);
		}	
	}	//	MRevenueRecognitionPlan

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MRevenueRecognitionPlan (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRevenueRecognitionPlan

	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (newRecord)
		{
			MRevenueRecognition rr = new MRevenueRecognition(getCtx(), getC_RevenueRecognition_ID(), get_TrxName());
			if (rr.isTimeBased())
			{
				MInvoiceLine il = (MInvoiceLine) getC_InvoiceLine();

				Calendar cal = Calendar.getInstance();
				Timestamp startDate = new Timestamp(cal.getTimeInMillis());
				if ( il.getRRStartDate() != null )
					startDate = il.getRRStartDate();
				else if ( il.getParent().getDateInvoiced() != null )
					startDate = il.getParent().getDateInvoiced();
				
				cal.setTimeInMillis(startDate.getTime());
				
				int interval = 1;
				if ( MRevenueRecognition.RECOGNITIONFREQUENCY_Quarter.equals(rr.getRecognitionFrequency()))
					interval = 3;
				else if ( MRevenueRecognition.RECOGNITIONFREQUENCY_Year.equals(rr.getRecognitionFrequency()))
					interval = 12;
				

				int periods = rr.getNoMonths();
				BigDecimal amt = getTotalAmt().divide(new BigDecimal(periods + ""), RoundingMode.HALF_UP);
				BigDecimal total = Env.ZERO;
				BigDecimal startAmt = amt;
				
				int monthOffset = cal.get(Calendar.MONTH);

				double startDay = cal.get(Calendar.DAY_OF_MONTH);
				
				if ( MRevenueRecognition.RECOGNITIONFREQUENCY_Month.equals(rr.getRecognitionFrequency()) &&
						rr.getFixedRecogDay() != 0 )
				{  // include start day
					double daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
					periods = periods + 1;
					
					double totalDays = rr.getFixedRecogDay() > daysInMonth ? daysInMonth : rr.getFixedRecogDay();
					
					double noDays = totalDays - (startDay-1);

					if ( noDays <= 0 ) // start recognition following month
					{
						monthOffset +=1;
						noDays = noDays + daysInMonth;
					}
					
					BigDecimal proportion = new BigDecimal( noDays / daysInMonth);
					startAmt = amt.multiply(proportion);
					startAmt = startAmt.setScale(2, RoundingMode.HALF_UP);
					cal.set(Calendar.DAY_OF_MONTH, rr.getFixedRecogDay());
				}
				
				cal.set(Calendar.MONTH, 0);  // January
				
				
				for ( int i = 0; i <= periods - 1; i++ )
				{
					Calendar cal2 = Calendar.getInstance();
					cal2.setTimeInMillis(cal.getTimeInMillis());
					cal2.add(Calendar.MONTH, (interval*i)+monthOffset);

					MRevenueRecognitionRun run = new MRevenueRecognitionRun(getCtx(), 0, get_TrxName());
					run.setClientOrg(this);
					run.setC_RevenueRecognition_Plan_ID(getC_RevenueRecognition_Plan_ID());
					run.setDateRecognized(new Timestamp(cal2.getTimeInMillis()));
					BigDecimal recogAmt = amt;

					if ( i == 0)
						recogAmt = startAmt;
					if ( i == periods - 1 )
						recogAmt = getTotalAmt().subtract(total);
					run.setRecognizedAmt(recogAmt);
					if ( recogAmt.signum() != 0 )
						run.saveEx();
					total = total.add(recogAmt);
				}
			}
			else
			{
				List<MRevenueRecogService> services = rr.getServicesList();
				BigDecimal totalAmt = Env.ZERO;
				MRevenueRecognitionRun last = null;
				for (MRevenueRecogService service : services )
				{
					BigDecimal recogAmt = getTotalAmt().multiply(service.getPercent()).divide(Env.ONEHUNDRED, 4, RoundingMode.HALF_UP);
					MRevenueRecognitionRun run = new MRevenueRecognitionRun(getCtx(), 0, get_TrxName());
					run.setClientOrg(this);
					run.setC_RevenueRecognition_Plan_ID(getC_RevenueRecognition_Plan_ID());
					run.setRecognizedAmt(recogAmt);
					run.setC_RevenueRecog_Service_ID(service.getC_RevenueRecog_Service_ID());
					run.saveEx();
					
					last = run;
					totalAmt = totalAmt.add(recogAmt);
				}
				
				if ( getTotalAmt().subtract(totalAmt).compareTo(Env.ZERO) != 0)
				{
					last.setRecognizedAmt(last.getRecognizedAmt().add(getTotalAmt().subtract(totalAmt)));
					last.saveEx();
				}


			}
		}
		return success;
	}	//	afterSave
}	//	MRevenueRecognitionPlan
