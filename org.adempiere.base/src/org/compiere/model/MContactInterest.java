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
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
 
/**
 *  <pre>
 *  Business Partner Contact Interest (subscription).
 *  Adempiere complies with spam laws.
 *  If the opt out date is set (by the user), you should not subscribe the user again.
 *  Internally, the isActive flag is used.
 *  </pre>
 *  @author Jorg Janke
 *  @version $Id: MContactInterest.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 *  @author red1 FR: [ 2214883 ] Remove SQL code and Replace for Query 
 */
public class MContactInterest extends X_R_ContactInterest
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4720845687902863428L;

	/**
	 * 	Get or create Contact Interest
	 *	@param ctx context
	 *	@param R_InterestArea_ID interest ares
	 *	@param AD_User_ID user
	 * 	@param isActive isActive value for create
	 *	@param trxName transaction
	 *	@return Contact Interest 
	 */
	public static MContactInterest get (Properties ctx, 
		int R_InterestArea_ID, int AD_User_ID, boolean isActive, String trxName)
	{
		final String whereClause = I_R_ContactInterest.COLUMNNAME_R_InterestArea_ID+"=? AND "+I_R_ContactInterest.COLUMNNAME_AD_User_ID+"=?";
		MContactInterest retValue = new Query(ctx,I_R_ContactInterest.Table_Name,whereClause,trxName)
		.setParameters(R_InterestArea_ID,AD_User_ID)
		.first();

		if (retValue == null)
		{
			retValue = new MContactInterest (ctx, R_InterestArea_ID, AD_User_ID, 
				isActive, trxName);
			if (s_log.isLoggable(Level.FINE)) s_log.fine("NOT found - " + retValue);
		}
		else
			if (s_log.isLoggable(Level.FINE)) s_log.fine("Found - " + retValue);
		return retValue;
	}	//	get
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param R_ContactInterest_UU  UUID key
     * @param trxName Transaction
     */
    public MContactInterest(Properties ctx, String R_ContactInterest_UU, String trxName) {
        super(ctx, R_ContactInterest_UU, trxName);
    }

	/**
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MContactInterest (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MContactInterest

	/**
	 * 	Constructor
	 * 	@param ctx context
	 * 	@param R_InterestArea_ID interest area
	 * 	@param AD_User_ID partner contact
	 * 	@param isActive create as active
	 *	@param trxName transaction
	 */
	public MContactInterest (Properties ctx, int R_InterestArea_ID, int AD_User_ID, 
		boolean isActive, String trxName)
	{
		super(ctx, 0, trxName);
		setR_InterestArea_ID (R_InterestArea_ID);
		setAD_User_ID (AD_User_ID);
		setIsActive(isActive);
	}	//	MContactInterest

	/**
	 *  Create and Load existing Persistent Object.
	 *  @param ctx context
	 *  @param rs load from current result set position (no navigation, not closed)
	 *	@param trxName transaction
	 */
	public MContactInterest (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MContactInterest

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MContactInterest(MContactInterest copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MContactInterest(Properties ctx, MContactInterest copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MContactInterest(Properties ctx, MContactInterest copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**	Static Logger				*/
	private static CLogger		s_log = CLogger.getCLogger (MContactInterest.class);

	/**
	 * 	Set OptOut Date.
	 * 	User action only.
	 *	@param OptOutDate opt out date, null to use current date
	 */
	@Override
	public void setOptOutDate (Timestamp OptOutDate)
	{
		if (OptOutDate == null)
			OptOutDate = new Timestamp(System.currentTimeMillis());
		if (log.isLoggable(Level.FINE)) log.fine("" + OptOutDate);
		super.setOptOutDate(OptOutDate);
		setIsActive(false);
	}	//	setOptOutDate
	
	/**
	 * 	Unsubscribe.
	 * 	User action only.
	 */
	public void unsubscribe()
	{
		setOptOutDate(null);
	}	//	unsubscribe

	/**
	 * 	Is Opted Out
	 *	@return true if opted out
	 */
	public boolean isOptOut()
	{
		return getOptOutDate() != null;
	}	//	isOptOut
	
	/**
	 * 	Set Subscribe Date.
	 * 	User action only.
	 *	@param SubscribeDate subscribe date, null to use current date
	 */
	public void setSubscribeDate (Timestamp SubscribeDate)
	{
		if (SubscribeDate == null)
			SubscribeDate = new Timestamp(System.currentTimeMillis());
		if (log.isLoggable(Level.FINE)) log.fine("" + SubscribeDate);
		super.setSubscribeDate(SubscribeDate);
		super.setOptOutDate(null);
		setIsActive(true);
	}	//	setSubscribeDate

	/**
	 * 	Subscribe.
	 * 	User action only.
	 */
	public void subscribe()
	{
		setSubscribeDate(null);
		if (!isActive())
			setIsActive(true);
	}	//	subscribe

	/**
	 * 	Subscribe.
	 * 	User action only.
	 * 	@param subscribe true to subscribe, false to opt out
	 */
	public void subscribe (boolean subscribe)
	{
		if (subscribe)
			setSubscribeDate(null);
		else
			setOptOutDate(null);
	}	//	subscribe


	/**
	 * 	Is Subscribed.
	 * 	Active is set internally, 
	 * 	the opt out date is set by the user via the web UI.
	 *	@return true if subscribed
	 */
	public boolean isSubscribed()
	{
		return isActive() && getOptOutDate() == null;
	}	//	isSubscribed


	/**
	 * 	String representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MContactInterest[")
			.append("R_InterestArea_ID=").append(getR_InterestArea_ID())
			.append(",AD_User_ID=").append(getAD_User_ID())
			.append(",Subscribed=").append(isSubscribed())
			.append ("]");
		return sb.toString ();
	}	//	toString

}	//	MContactInterest
