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
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Invoice Schedule Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MInvoiceSchedule.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MInvoiceSchedule extends X_C_InvoiceSchedule implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2480759794244343907L;

	/**
	 * 	Get MInvoiceSchedule (Immutable) from Cache
	 *	@param C_InvoiceSchedule_ID id
	 *	@param trxName transaction
	 *	@return MInvoiceSchedule
	 */
	public static MInvoiceSchedule get (int C_InvoiceSchedule_ID, String trxName)
	{
		return get(Env.getCtx(), C_InvoiceSchedule_ID, trxName);
	}
	
	/**
	 * 	Get MInvoiceSchedule (Immutable) from Cache
	 *	@param C_InvoiceSchedule_ID id
	 *	@return MInvoiceSchedule
	 */
	public static MInvoiceSchedule get (int C_InvoiceSchedule_ID)
	{
		return get(C_InvoiceSchedule_ID, (String)null);
	}
	
	/**
	 * 	Get MInvoiceSchedule (Immutable) from Cache
	 *  @param ctx context
	 *	@param C_InvoiceSchedule_ID id
	 *	@param trxName transaction
	 *	@return MInvoiceSchedule
	 */
	public static MInvoiceSchedule get (Properties ctx, int C_InvoiceSchedule_ID, String trxName)
	{
		Integer key = Integer.valueOf(C_InvoiceSchedule_ID);
		MInvoiceSchedule retValue = (MInvoiceSchedule) s_cache.get (ctx, key, e -> new MInvoiceSchedule(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MInvoiceSchedule (Env.getCtx(), C_InvoiceSchedule_ID, trxName);
		if (retValue.get_ID () == C_InvoiceSchedule_ID) 
		{
			s_cache.put (key, retValue, e -> new MInvoiceSchedule(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MInvoiceSchedule>	s_cache	= new ImmutableIntPOCache<Integer,MInvoiceSchedule>(Table_Name, 5);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_InvoiceSchedule_ID id
	 *	@param trxName transaction
	 */
	public MInvoiceSchedule (Properties ctx, int C_InvoiceSchedule_ID, String trxName)
	{
		super (ctx, C_InvoiceSchedule_ID, trxName);
	}	//	MInvoiceSchedule

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MInvoiceSchedule (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MInvoiceSchedule
	
	/**
	 * 
	 * @param copy
	 */
	public MInvoiceSchedule(MInvoiceSchedule copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MInvoiceSchedule(Properties ctx, MInvoiceSchedule copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MInvoiceSchedule(Properties ctx, MInvoiceSchedule copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Can I send Invoice
	 * 	@param xDate date
	 * 	@param orderAmt order amount
	 *	@return true if I can send Invoice
	 */
	@Deprecated
	// Deprecation note: consider using just canInvoice(Timestamp)
	// validating the order amount doesn't make sense as the total must be calculated based on shipments
	public boolean canInvoice (Timestamp xDate, BigDecimal orderAmt)
	{
		//	Amount
		if (isAmount() && getAmt() != null && orderAmt != null 
			&& orderAmt.compareTo(getAmt()) >= 0)
			return true;

		return canInvoice(xDate);
	}	//	canInvoice
	
	/**
	 * 	Can I send Invoice
	 * 	@param xDate date
	 *	@return true if I can send Invoice
	 */
	public boolean canInvoice (Timestamp xDate)
	{
		//	Daily
		if (INVOICEFREQUENCY_Daily.equals(getInvoiceFrequency()))
			return true;

		//	Remove time
		xDate = TimeUtil.getDay(xDate);
		Calendar today = TimeUtil.getToday();
		
		//	Weekly
		if (INVOICEFREQUENCY_Weekly.equals(getInvoiceFrequency()))
		{
			Calendar cutoff = TimeUtil.getToday();
			cutoff.set(Calendar.DAY_OF_WEEK, getCalendarDay(getInvoiceWeekDayCutoff()));
			if (cutoff.after(today))
				cutoff.add(Calendar.DAY_OF_YEAR, -7);
			Timestamp cutoffDate = new Timestamp (cutoff.getTimeInMillis());
			if (log.isLoggable(Level.FINE)) log.fine("canInvoice - Date=" + xDate + " > Cutoff=" + cutoffDate 
				+ " - " + xDate.after(cutoffDate));
			if (xDate.after(cutoffDate))
				return false;
			//
			Calendar invoice = TimeUtil.getToday();
			invoice.set(Calendar.DAY_OF_WEEK, getCalendarDay(getInvoiceWeekDay()));
			if (invoice.after(today))
				invoice.add(Calendar.DAY_OF_YEAR, -7);
			Timestamp invoiceDate = new Timestamp (invoice.getTimeInMillis());
			if (log.isLoggable(Level.FINE)) log.fine("canInvoice - Date=" + xDate + " > Invoice=" + invoiceDate 
				+ " - " + xDate.after(invoiceDate));
			if (xDate.after(invoiceDate))
				return false;
			return true;
		}
		
		//	Monthly
		if (INVOICEFREQUENCY_Monthly.equals(getInvoiceFrequency())
			|| INVOICEFREQUENCY_TwiceMonthly.equals(getInvoiceFrequency()))
		{
			if (getInvoiceDayCutoff() > 0)
			{
				Calendar cutoff = TimeUtil.getToday();
				cutoff.set(Calendar.DAY_OF_MONTH, getInvoiceDayCutoff());
				if (cutoff.after(today))
					cutoff.add(Calendar.MONTH, -1);
				Timestamp cutoffDate = new Timestamp (cutoff.getTimeInMillis());
				if (log.isLoggable(Level.FINE)) log.fine("canInvoice - Date=" + xDate + " > Cutoff=" + cutoffDate 
					+ " - " + xDate.after(cutoffDate));
				if (xDate.after(cutoffDate))
					return false;
			}
			Calendar invoice = TimeUtil.getToday();
			invoice.set(Calendar.DAY_OF_MONTH, getInvoiceDay());
			if (invoice.after(today))
				invoice.add(Calendar.MONTH, -1);
			Timestamp invoiceDate = new Timestamp (invoice.getTimeInMillis());
			if (log.isLoggable(Level.FINE)) log.fine("canInvoice - Date=" + xDate + " > Invoice=" + invoiceDate 
				+ " - " + xDate.after(invoiceDate));
			if (xDate.after(invoiceDate))
				return false;
			return true;
		}

		//	Bi-Monthly (+15)
		if (INVOICEFREQUENCY_TwiceMonthly.equals(getInvoiceFrequency()))
		{
			if (getInvoiceDayCutoff() > 0)
			{
				Calendar cutoff = TimeUtil.getToday();
				cutoff.set(Calendar.DAY_OF_MONTH, getInvoiceDayCutoff() +15);
				if (cutoff.after(today))
					cutoff.add(Calendar.MONTH, -1);
				Timestamp cutoffDate = new Timestamp (cutoff.getTimeInMillis());
				if (xDate.after(cutoffDate))
					return false;
			}
			Calendar invoice = TimeUtil.getToday();
			invoice.set(Calendar.DAY_OF_MONTH, getInvoiceDay() +15);
			if (invoice.after(today))
				invoice.add(Calendar.MONTH, -1);
			Timestamp invoiceDate = new Timestamp (invoice.getTimeInMillis());
			if (xDate.after(invoiceDate))
				return false;
			return true;
		}
		return false;
	}	//	canInvoice
	
	/**
	 * 	Convert to Calendar day
	 *	@param day Invoice Week Day
	 *	@return day
	 */
	private int getCalendarDay (String day)
	{
		if (INVOICEWEEKDAY_Friday.equals(day))
			return Calendar.FRIDAY;
		if (INVOICEWEEKDAY_Saturday.equals(day))
			return Calendar.SATURDAY;
		if (INVOICEWEEKDAY_Sunday.equals(day))
			return Calendar.SUNDAY;
		if (INVOICEWEEKDAY_Monday.equals(day))
			return Calendar.MONDAY;
		if (INVOICEWEEKDAY_Tuesday.equals(day))
			return Calendar.TUESDAY;
		if (INVOICEWEEKDAY_Wednesday.equals(day))
			return Calendar.WEDNESDAY;
	//	if (INVOICEWEEKDAY_Thursday.equals(day))
		return Calendar.THURSDAY;
	}	//	getCalendarDay

	@Override
	public MInvoiceSchedule markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MInvoiceSchedule
