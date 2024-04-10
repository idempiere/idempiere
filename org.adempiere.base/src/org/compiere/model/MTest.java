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
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Env;

/**
 *	Test Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MTest.java,v 1.3 2006/07/30 00:58:37 jjanke Exp $
 */
public class MTest extends X_Test
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5390179651635427303L;

	/**
	 * 	Constructor
	 *	@param ctx context
	 *	@param Test_ID
	 *	@param trxName transaction
	 */
	public MTest(Properties ctx, int Test_ID, String trxName)
	{
		super (ctx, Test_ID, trxName);
	}	//	MTest

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTest(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MTest

	/**
	 * 	Constructor
	 *	@param ctx context
	 *	@param Test_UU
	 *	@param trxName transaction
	 */
	public MTest(Properties ctx, String Test_UU, String trxName)
	{
		super (ctx, Test_UU, trxName);
	}	//	MTest

	/**
	 * 	new Test record Constructor
	 *	@param ctx context
	 *	@param testString test string
	 *	@param testNo test no
	 */
	public MTest (Properties ctx, String testString, int testNo)
	{
		this(ctx, testString, testNo, null);
	}

	/**
	 * 	new Test record Constructor
	 *	@param ctx context
	 *	@param testString test string
	 *	@param testNo test no
	 *  @param trxName
	 */
	public MTest (Properties ctx, String testString, int testNo, String trxName)
	{
		super(ctx, 0, trxName);
		testString = testString + "_" + testNo;
		setName(testString);
		setDescription(testString + " " + testString + " " + testString);
		setHelp (getDescription() + " - " + getDescription());
		setT_Date(new Timestamp (System.currentTimeMillis()));
		setT_DateTime(new Timestamp (System.currentTimeMillis()));
		setT_Integer(testNo);
		setT_Amount(new BigDecimal(testNo));
		setT_Number(Env.ONE.divide(new BigDecimal(testNo), RoundingMode.HALF_UP));
		//
		setC_Currency_ID(100);		//	USD
		setC_Location_ID(109);		//	Monroe
		setC_UOM_ID(100);			//	Each
	}	//	MTest

	/**
	 * @param ctx
	 * @param Test_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MTest(Properties ctx, int Test_ID, String trxName, String... virtualColumns) {
		super(ctx, Test_ID, trxName, virtualColumns);
	}

	@Override
	protected boolean beforeDelete ()
	{
		log.info("***");
		return true;
	}
	
	@Override
	protected boolean afterDelete (boolean success)
	{
		if (log.isLoggable(Level.INFO)) log.info("*** Success=" + success);
		return success;
	}
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (log.isLoggable(Level.INFO)) log.info("New=" + newRecord + " ***");
		return true;
	}
	
	/**
	 * 	After Save
	 *	@param newRecord
	 *	@param success
	 *	@return success
	 */
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (log.isLoggable(Level.INFO)) log.info("New=" + newRecord + ", Success=" + success + " ***");
		return success;
	}	//	afterSave

}	//	MTest
