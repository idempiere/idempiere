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

import it.sauronsoftware.cron4j.Predictor;
import it.sauronsoftware.cron4j.SchedulingPattern;

import java.net.InetAddress;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import org.compiere.util.DisplayType;

public class MSchedule extends X_AD_Schedule 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2532063246191430056L;
	
	private static Pattern VALID_IPV4_PATTERN = null;
	private static Pattern VALID_IPV6_PATTERN = null;
	private static final String ipv4Pattern = "(([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\.){3}([01]?\\d\\d?|2[0-4]\\d|25[0-5])";
    private static final String ipv6Pattern = "([0-9a-f]{1,4}:){7}([0-9a-f]){1,4}";

    private it.sauronsoftware.cron4j.Scheduler cronScheduler;
	private Predictor predictor;

	public MSchedule(Properties ctx, int AD_Schedule_ID, String trxName) {
		super(ctx, AD_Schedule_ID, trxName);
		// TODO Auto-generated constructor stub
	}

	public MSchedule(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
		// TODO Auto-generated constructor stub
	}
	
	protected boolean beforeSave()
	{
        //		Set Schedule Type & Frequencies
			if (SCHEDULETYPE_Frequency.equals(getScheduleType()))
			{
				if (getFrequencyType() == null)
					setFrequencyType(FREQUENCYTYPE_Day);
				if (getFrequency() < 1)
					setFrequency(1);
				setCronPattern(null);
			}
			else if (SCHEDULETYPE_CronSchedulingPattern.equals(getScheduleType()))
			{
				String pattern = getCronPattern();
				if (pattern != null && pattern.trim().length() > 0)
				{
					if (!SchedulingPattern.validate(pattern))
					{
						log.saveError("Error", "InvalidCronPattern");
						return false;
					}
				}
			}
			return true;
	}
	
   	
	
	
	/**
	 *  Brought from Compiere Open Source Community version 3.3.0
	 * 	Is it OK to Run process On IP of this box
	 *	@return
	 */
	public boolean isOKtoRunOnIP()
	{
		String ipOnly = getRunOnlyOnIP();
		if ((ipOnly == null) || (ipOnly.length() == 0))
			return true;

		StringTokenizer st = new StringTokenizer(ipOnly, ";");
		while (st.hasMoreElements())
		{
			String ip = st.nextToken();
			if (checkIP(ip))
				return true;
		}
		return false;
	}	//	isOKtoRunOnIP

	/**
	 * 
	 *  Brought from Compiere Open Source Community version 3.3.0
	 * 	check whether this IP is allowed to process
	 *	@param ipOnly
	 *	@return true if IP is correct
	 */
	private boolean checkIP(String ipOnly)
	{
		try
		{
			InetAddress box = InetAddress.getLocalHost();
			String ip = box.getHostAddress();
			if (chekIPFormat()) {
				if (ipOnly.indexOf(ip) == -1) {
					
					log.fine("Not allowed here - IP=" + ip + " does not match "+ ipOnly);
					return false;
				}
				log.fine("Allowed here - IP=" + ip + " matches " + ipOnly);
			}
			else{
				String hostname=box.getHostName();
				if(ipOnly.equals(hostname)){
					log.fine("Not Allowed here -hostname " + hostname + " does not match "+ipOnly);
					return false;
				}
				log.fine("Allowed here - hostname=" + hostname + " matches " + ipOnly);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
			return false;
		}
		return true;
	}	// checkIP

	public static MSchedule get(Properties ctx, int AD_Schedule_ID) 
	{
		if(AD_Schedule_ID > 0)
		{
		  MSchedule schedule=new MSchedule(ctx, AD_Schedule_ID, null);
		   return schedule;
		}
		return null;
		
	}
	
	public boolean chekIPFormat()
	{
		boolean IsIp = false;
		try {
			VALID_IPV4_PATTERN = Pattern.compile(ipv4Pattern,Pattern.CASE_INSENSITIVE);
			VALID_IPV6_PATTERN = Pattern.compile(ipv6Pattern,Pattern.CASE_INSENSITIVE);
			
			Matcher m1 = VALID_IPV4_PATTERN.matcher(getRunOnlyOnIP());
			if (m1.matches()) {
				IsIp = true;
			} else {
				Matcher m2 = VALID_IPV6_PATTERN.matcher(getRunOnlyOnIP());
				if (m2.matches()) {
					IsIp = true;
				} else {
					IsIp = false;
				}
			}
		} catch (PatternSyntaxException e) {
			// TODO: handle exception
			log.fine("Error: " + e.getLocalizedMessage());
		}
		return IsIp;
	}
	/**
	 * Brought from Compiere 330
	 * 	Get Next Run
	 *	@param last in MS
	 *	@return next run in MS
	 */
	public long getNextRunMS (long last)
	{
		Calendar calNow = Calendar.getInstance();
		calNow.setTimeInMillis (last);
		//
		Calendar calNext = Calendar.getInstance();
		calNext.setTimeInMillis (last);
		
		
		String scheduleType = getScheduleType();
		if (SCHEDULETYPE_Frequency.equals(scheduleType))
		{
			String frequencyType = getFrequencyType();
			int frequency = getFrequency();

			boolean increment=true;


			/*****	DAY		******/
			if (X_AD_Schedule.FREQUENCYTYPE_Day.equals(frequencyType))
			{
				calNext.set (Calendar.HOUR_OF_DAY, 0);
				calNext.set (Calendar.MINUTE, 0);
				if(increment)
				{
					calNext.add(Calendar.DAY_OF_YEAR, frequency);
				}
			}	//	Day

			/*****	HOUR	******/
			else if (X_AD_Schedule.FREQUENCYTYPE_Hour.equals(frequencyType))
			{
				calNext.set (Calendar.MINUTE, 0);
				if(increment)
				{
					calNext.add (Calendar.HOUR_OF_DAY, frequency);
				}

			}	//	Hour

			/*****	MINUTE	******/
			else if (X_AD_Schedule.FREQUENCYTYPE_Minute.equals(frequencyType))
			{
				if(increment)
				{
					calNext.add(Calendar.MINUTE, frequency);
				}
			}	//	Minute

			long delta = calNext.getTimeInMillis() - calNow.getTimeInMillis();
			StringBuilder info = new StringBuilder("Now=") .append(calNow.getTime().toString())
				.append( ", Next=" + calNext.getTime().toString())
				.append( ", Delta=" + delta)
				.append( ", " + toString());
			
			if (delta < 0)
			{
				log.warning(info.toString());
			}
			else
				log.info (info.toString());

			return calNext.getTimeInMillis();
		}
		else
		{
			String cronPattern = (String) getCronPattern();
			if (cronPattern != null && cronPattern.trim().length() > 0
					&& SchedulingPattern.validate(cronPattern)) {
				cronScheduler = new it.sauronsoftware.cron4j.Scheduler();				
				predictor = new Predictor(cronPattern);
				long next = predictor.nextMatchingTime();
				return next;
			}
			
		}
		
		return 0;
	
	}	//	getNextRunMS

}
