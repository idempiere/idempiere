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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *	GL Distribution Model
 *	
 *  @author Jorg Janke
 *  @author red1 FR: [ 2214883 ] Remove SQL code and Replace for Query
 *  @version $Id: MDistribution.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MDistribution extends X_GL_Distribution
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5964912910470166735L;

	/**
	 * 	Get Distribution for combination
	 *	@param acct account (ValidCombination)
	 *	@param PostingType only posting type
	 *	@param C_DocType_ID only document type
	 *	@param dateAcct date (to be tested with ValidFrom/ValidTo)
	 *	@return array of distributions
	 */
	@Deprecated
	public static MDistribution[] get (MAccount acct,  
		String PostingType, int C_DocType_ID, Timestamp dateAcct)
	{
		return get (acct.getCtx(), acct.getC_AcctSchema_ID(), 
			PostingType, C_DocType_ID, dateAcct,
			acct.getAD_Org_ID(), acct.getAccount_ID(),
			acct.getM_Product_ID(), acct.getC_BPartner_ID(), acct.getC_Project_ID(),
			acct.getC_Campaign_ID(), acct.getC_Activity_ID(), acct.getAD_OrgTrx_ID(),
			acct.getC_SalesRegion_ID(), acct.getC_LocTo_ID(), acct.getC_LocFrom_ID(),
			acct.getUser1_ID(), acct.getUser2_ID(), 0, 0, 0, 0, 0, 0, 0);
	}	//	get

	/**
	 * 	Get Distributions for combination
	 *	@param C_AcctSchema_ID schema
	 *	@param PostingType posting type
	 *	@param C_DocType_ID document type
	 *	@param dateAcct date (to be tested with ValidFrom/ValidTo)
	 *	@param AD_Org_ID org
	 *	@param Account_ID account
	 *	@param M_Product_ID product
	 *	@param C_BPartner_ID partner
	 *	@param C_Project_ID project
	 *	@param C_Campaign_ID campaign
	 *	@param C_Activity_ID activity
	 *	@param AD_OrgTrx_ID trx org
	 *	@param C_SalesRegion_ID
	 *	@param C_LocTo_ID location to
	 *	@param C_LocFrom_ID location from
	 *	@param User1_ID user 1
	 *	@param User2_ID user 2
	 *	@param C_CostCenter_ID 
	 *	@param C_Department_ID 
	 *	@param C_Employee_ID 
	 *	@param C_Charge_ID 
	 *	@param A_Asset_ID 
	 *	@param M_Warehouse_ID 
	 *	@param M_AttributeSetInstance_ID 
	 *	@return array of distributions or null
	 */
	public static MDistribution[] get(int C_AcctSchema_ID,
		String PostingType, int C_DocType_ID, Timestamp dateAcct,
		int AD_Org_ID, int Account_ID,
		int M_Product_ID, int C_BPartner_ID, int C_Project_ID,
		int C_Campaign_ID, int C_Activity_ID, int AD_OrgTrx_ID,
		int C_SalesRegion_ID, int C_LocTo_ID, int C_LocFrom_ID,
		int User1_ID, int User2_ID, int C_CostCenter_ID, int C_Department_ID,
		int C_Employee_ID, int C_Charge_ID, int A_Asset_ID, int M_Warehouse_ID, int M_AttributeSetInstance_ID)
	{
		return get(Env.getCtx(), C_AcctSchema_ID, PostingType, C_DocType_ID, dateAcct, AD_Org_ID, Account_ID, M_Product_ID, C_BPartner_ID,
						C_Project_ID, C_Campaign_ID, C_Activity_ID, AD_OrgTrx_ID, C_SalesRegion_ID, C_LocTo_ID, C_LocFrom_ID, User1_ID, User2_ID, C_CostCenter_ID, C_Department_ID, C_Employee_ID,
						C_Charge_ID, A_Asset_ID, M_Warehouse_ID, M_AttributeSetInstance_ID);
	}
	
	/**
	 * 	Get Distributions for combination
	 *	@param ctx context
	 *	@param C_AcctSchema_ID schema
	 *	@param PostingType posting type
	 *	@param C_DocType_ID document type
	 *	@param AD_Org_ID org
	 *	@param Account_ID account
	 *	@param M_Product_ID product
	 *	@param C_BPartner_ID partner
	 *	@param C_Project_ID project
	 *	@param C_Campaign_ID campaign
	 *	@param C_Activity_ID activity
	 *	@param AD_OrgTrx_ID trx org
	 *	@param C_SalesRegion_ID
	 *	@param C_LocTo_ID location to
	 *	@param C_LocFrom_ID location from
	 *	@param User1_ID user 1
	 *	@param User2_ID user 2
	 *	@param C_CostCenter_ID
	 *	@param C_Department_ID
	 *	@param C_Employee_ID
	 *	@param C_Charge_ID
	 *	@param A_Asset_ID
	 *	@param M_Warehouse_ID
	 *	@param M_AttributeSetInstance_ID
	 *	@return array of distributions or null
	 */
	public static MDistribution[] get (Properties ctx, int C_AcctSchema_ID, 
		String PostingType, int C_DocType_ID, Timestamp dateAcct,
		int AD_Org_ID, int Account_ID,
		int M_Product_ID, int C_BPartner_ID, int C_Project_ID,
		int C_Campaign_ID, int C_Activity_ID, int AD_OrgTrx_ID,
		int C_SalesRegion_ID, int C_LocTo_ID, int C_LocFrom_ID,
		int User1_ID, int User2_ID, int C_CostCenter_ID, int C_Department_ID,
		int C_Employee_ID, int C_Charge_ID, int A_Asset_ID, int M_Warehouse_ID, int M_AttributeSetInstance_ID)
	{
		MDistribution[] acctList = getAll();
		if (acctList == null || acctList.length == 0)
			return null;
		//
		ArrayList<MDistribution> list = new ArrayList<MDistribution>();
		for (int i = 0; i < acctList.length; i++)
		{
			MDistribution distribution = acctList[i];
			if (!distribution.isActive() || !distribution.isValid())
				continue;
			//	Mandatory Acct Schema
			if (distribution.getC_AcctSchema_ID() != C_AcctSchema_ID)
				continue;
			//	Only Posting Type / DocType / ValidFrom / ValidTo
			if (distribution.getPostingType() != null && !distribution.getPostingType().equals(PostingType))
				continue;
			if (distribution.getC_DocType_ID() != 0 && distribution.getC_DocType_ID() != C_DocType_ID)
				continue;
			if (distribution.getValidFrom() != null && distribution.getValidFrom().after(dateAcct))
				continue;
			if (distribution.getValidTo() != null && distribution.getValidTo().before(dateAcct))
				continue;
			
			//	Optional Elements - "non-Any"
			if (!distribution.isAnyOrg() && distribution.getOrg_ID() != AD_Org_ID)
				continue;
			if (!distribution.isAnyAcct() && distribution.getAccount_ID() != Account_ID)
				continue;
			if (!distribution.isAnyProduct() && distribution.getM_Product_ID() != M_Product_ID)
				continue;
			if (!distribution.isAnyBPartner() && distribution.getC_BPartner_ID() != C_BPartner_ID)
				continue;
			if (!distribution.isAnyProject() && distribution.getC_Project_ID() != C_Project_ID)
				continue;
			if (!distribution.isAnyCampaign() && distribution.getC_Campaign_ID() != C_Campaign_ID)
				continue;
			if (!distribution.isAnyActivity() && distribution.getC_Activity_ID() != C_Activity_ID)
				continue;
			if (!distribution.isAnyOrgTrx() && distribution.getAD_OrgTrx_ID() != AD_OrgTrx_ID)
				continue;
			if (!distribution.isAnySalesRegion() && distribution.getC_SalesRegion_ID() != C_SalesRegion_ID)
				continue;
			if (!distribution.isAnyLocTo() && distribution.getC_LocTo_ID() != C_LocTo_ID)
				continue;
			if (!distribution.isAnyLocFrom() && distribution.getC_LocFrom_ID() != C_LocFrom_ID)
				continue;
			if (!distribution.isAnyUser1() && distribution.getUser1_ID() != User1_ID)
				continue;
			if (!distribution.isAnyUser2() && distribution.getUser2_ID() != User2_ID)
				continue;
			if (!distribution.isAnyCostCenter() && distribution.getC_CostCenter_ID() != C_CostCenter_ID)
				continue;
			if (!distribution.isAnyDepartment() && distribution.getC_Department_ID() != C_Department_ID)
				continue;
			if (!distribution.isAnyEmployee() && distribution.getC_Employee_ID() != C_Employee_ID)
				continue;
			if (!distribution.isAnyCharge() && distribution.getC_Charge_ID() != C_Charge_ID)
				continue;
			if (!distribution.isAnyAsset() && distribution.getA_Asset_ID() != A_Asset_ID)
				continue;
			if (!distribution.isAnyWarehouse() && distribution.getM_Warehouse_ID() != M_Warehouse_ID)
				continue;
			if (!distribution.isAnyAttributeSetInstance() && distribution.getM_AttributeSetInstance_ID() != M_AttributeSetInstance_ID)
				continue;
			//
			list.add (distribution);
		}	//	 for all distributions with acct
		//
		MDistribution[] retValue = new MDistribution[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	get
	
	/**
	 * 	Get Distributions for Account
	 *	@param ctx ignore
	 *	@param Account_ID id
	 *	@return array of distributions
	 *  @deprecated
	 */
	@Deprecated
	public static MDistribution[] get (Properties ctx, int Account_ID)
	{
		return get(Account_ID);
	}
	
	/**
	 * 	Get Distributions for Account
	 *	@param Account_ID id
	 *	@return array of distributions
	 *  @deprecated - using the method to get a specific account ID doesn't make sense because of the flag IsAnyAcct
	 *                use method getAll() instead
	 */
	@Deprecated
	public static MDistribution[] get (int Account_ID)
	{
		Properties ctx = Env.getCtx();
		String key = Env.getAD_Client_ID(ctx) + "_" + Account_ID;
		MDistribution[] retValue = (MDistribution[])s_accounts.get(key);
		if (retValue != null)
			return retValue;
		String whereClause = "";
		Object[] parameters = null;
		if (Account_ID >= 0) {
			whereClause = "Account_ID=?";
			parameters = new Object[]{Account_ID};
		}
		List<MDistribution> list = new Query(ctx,I_GL_Distribution.Table_Name,whereClause,null)
			.setClient_ID()
			.setParameters(parameters)
			.setOrderBy("SeqNo, GL_Distribution_ID")
			.list();
		//
		retValue = new MDistribution[list.size ()];
		retValue = list.toArray (retValue);
		s_accounts.put(key, retValue);
		return retValue;
	}	//	get
	
	/**
	 * 	Get All Distributions
	 *	@param ctx ignore
	 *	@return array of distributions
	 */
	@Deprecated
	public static MDistribution[] getAll (Properties ctx)
	{
		return getAll();
	}
	
	/**
	 * 	Get All Distributions
	 *	@return array of distributions
	 */
	public static MDistribution[] getAll ()
	{
		return get(-1);
	}	//	get
	
	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MDistribution.class);
	/**	Distributions by Account			*/
	private static CCache<String,MDistribution[]> s_accounts 
		= new CCache<String,MDistribution[]>(Table_Name, 100);
		
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param GL_Distribution_UU  UUID key
     * @param trxName Transaction
     */
    public MDistribution(Properties ctx, String GL_Distribution_UU, String trxName) {
        super(ctx, GL_Distribution_UU, trxName);
		if (Util.isEmpty(GL_Distribution_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param GL_Distribution_ID id
	 *	@param trxName transaction
	 */
	public MDistribution (Properties ctx, int GL_Distribution_ID, String trxName)
	{
		super (ctx, GL_Distribution_ID, trxName);
		if (GL_Distribution_ID == 0)
			setInitialDefaults();
	}	//	MDistribution

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setAnyAcct (true);	// Y
		setAnyActivity (true);	// Y
		setAnyBPartner (true);	// Y
		setAnyCampaign (true);	// Y
		setAnyLocFrom (true);	// Y
		setAnyLocTo (true);	// Y
		setAnyOrg (true);	// Y
		setAnyOrgTrx (true);	// Y
		setAnyProduct (true);	// Y
		setAnyProject (true);	// Y
		setAnySalesRegion (true);	// Y
		setAnyUser1 (true);	// Y
		setAnyUser2 (true);	// Y
		//
		setIsValid (false);	// N
		setPercentTotal (Env.ZERO);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDistribution (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDistribution

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MDistribution(MDistribution copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MDistribution(Properties ctx, MDistribution copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MDistribution(Properties ctx, MDistribution copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_lines = copy.m_lines != null ? Arrays.stream(copy.m_lines).map(e -> {var v = new MDistributionLine(ctx, e, trxName); v.setParent(this); return v;}).toArray(MDistributionLine[]::new) : null;
	}
	
	/**	The Lines						*/
	private MDistributionLine[]		m_lines = null;
	
	/**
	 * 	Get Lines and calculate total
	 *	@param reload true to reload data
	 *	@return array of lines
	 */
	public MDistributionLine[] getLines (boolean reload)
	{
		if (m_lines != null && !reload) {
			set_TrxName(m_lines, get_TrxName());
			return m_lines;
		}		
		BigDecimal PercentTotal = Env.ZERO;
		//red1 Query
		final String whereClause = I_GL_DistributionLine.COLUMNNAME_GL_Distribution_ID+"=?";
		List<MDistributionLine> list = new Query(getCtx(),I_GL_DistributionLine.Table_Name,whereClause,get_TrxName())
		.setParameters(getGL_Distribution_ID())
		.setOrderBy("Line,GL_DistributionLine_ID")
		.list();
		//red1 Query  -end-
		boolean hasNullRemainder = false;
		for (MDistributionLine dl : list) {
			if (dl.isActive())
			{
				PercentTotal = PercentTotal.add(dl.getPercent());
				hasNullRemainder = Env.ZERO.compareTo(dl.getPercent()) == 0;
			}
			dl.setParent(this);
		}
		//	Update Ratio when saved and difference
		if (hasNullRemainder)
			PercentTotal = Env.ONEHUNDRED;
		if (get_ID() != 0 && PercentTotal.compareTo(getPercentTotal()) != 0)
		{
			setPercentTotal(PercentTotal);
			saveEx();
		}
		//	return
		m_lines = new MDistributionLine[list.size ()];
		list.toArray (m_lines);
		return m_lines;
	}	//	getLines
	
	/**
	 * 	Validate Distribution
	 *	@return error message or null
	 */
	public String validate()
	{
		String retValue = null;
		getLines(true);
		if (m_lines.length == 0)
			retValue = "@NoLines@";
		else if (getPercentTotal().compareTo(Env.ONEHUNDRED) != 0)
			retValue = "@PercentTotal@ <> 100";
		else
		{
			//	More then one line with 0
			int lineFound = -1;
			for (int i = 0; i < m_lines.length; i++)
			{
				if (m_lines[i].getPercent().compareTo(Env.ZERO) == 0)
				{
					if (lineFound >= 0 && m_lines[i].getPercent().compareTo(Env.ZERO) == 0)
					{
						retValue = "@Line@ " + lineFound
							+ " + " + m_lines[i].getLine() + ": == 0";
						break;
					}
					lineFound = m_lines[i].getLine();
				}
			}	//	for all lines
		}
		
		setIsValid (retValue == null);
		return retValue;
	}	//	validate
	
	
	/**
	 * 	Distribute Amount to Lines
	 * 	@param acct account
	 *	@param Amt amount
	 *  @param Qty 
	 *	@param C_Currency_ID currency
	 */
	public void distribute (MAccount acct, BigDecimal Amt, BigDecimal Qty, int C_Currency_ID)
	{
		if (log.isLoggable(Level.INFO)) log.info("distribute - Amt=" + Amt + " - Qty=" + Qty + " - " + acct);
		getLines(false);
		int precision = MCurrency.getStdPrecision(getCtx(), C_Currency_ID);
		//	First Round
		BigDecimal total = Env.ZERO;
		BigDecimal totalQty = Env.ZERO;
		int indexBiggest = -1;
		int indexZeroPercent = -1;
		for (int i = 0; i < m_lines.length; i++)
		{
			MDistributionLine dl = m_lines[i];
			if (!dl.isActive())
				continue;
			dl.setAccount(acct);
			//	Calculate Amount
			dl.calculateAmt (Amt, precision);	
			//	Calculate Quantity
			dl.calculateQty (Qty);	
			total = total.add(dl.getAmt());
			totalQty = totalQty.add(dl.getQty());
			//	Remainder
			if (dl.getPercent().compareTo(Env.ZERO) == 0)
				indexZeroPercent = i;
			if (indexZeroPercent == -1)
			{
				if (indexBiggest == -1)
					indexBiggest = i;
				else if (dl.getAmt().compareTo(m_lines[indexBiggest].getAmt()) > 0)
					indexBiggest = i;
			}
		}
		//	Adjust Remainder
		BigDecimal difference = Amt.subtract(total);
		if (difference.compareTo(Env.ZERO) != 0)
		{
			if (indexZeroPercent != -1)
			{
				m_lines[indexZeroPercent].setAmt (difference);
			}
			else if (indexBiggest != -1)
			{
				m_lines[indexBiggest].setAmt (m_lines[indexBiggest].getAmt().add(difference));
			}
			else
				log.warning("distribute - Remaining Difference=" + difference); 
		}
		//	Adjust Remainder
		BigDecimal differenceQty = Qty.subtract(totalQty);
		if (differenceQty.compareTo(Env.ZERO) != 0)
		{
			if (indexZeroPercent != -1)
			{
				m_lines[indexZeroPercent].setQty (differenceQty);
			}
			else if (indexBiggest != -1)
			{
				m_lines[indexBiggest].setQty (m_lines[indexBiggest].getQty().add(differenceQty));
			}
			else
				log.warning("distribute - Remaining Qty Difference=" + differenceQty); 
		}
		//
		if (CLogMgt.isLevelFinest())
		{
			for (int i = 0; i < m_lines.length; i++)
			{
				if (m_lines[i].isActive())
					if (log.isLoggable(Level.FINE)) log.fine("distribute = Amt=" + m_lines[i].getAmt() + " - " + m_lines[i].getAccount());
			}
		}
	}	//	distribute
		
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		//	Reset corresponding field to 0 if IsAny* is true
		if (isAnyAcct() && getAccount_ID() != 0)
			setAccount_ID(0);
		if (isAnyActivity() && getC_Activity_ID() != 0)
			setC_Activity_ID(0);
		if (isAnyBPartner() && getC_BPartner_ID() != 0)
			setC_BPartner_ID(0);
		if (isAnyCampaign() && getC_Campaign_ID() != 0)
			setC_Campaign_ID(0);
		if (isAnyLocFrom() && getC_LocFrom_ID() != 0)
			setC_LocFrom_ID(0);
		if (isAnyLocTo() && getC_LocTo_ID() != 0)
			setC_LocTo_ID(0);
		if (isAnyOrg() && getOrg_ID() != 0)
			setOrg_ID(0);
		if (isAnyOrgTrx() && getAD_OrgTrx_ID() != 0)
			setAD_OrgTrx_ID(0);
		if (isAnyProduct() && getM_Product_ID() != 0)
			setM_Product_ID(0);
		if (isAnyProject() && getC_Project_ID() != 0)
			setC_Project_ID(0);
		if (isAnySalesRegion() && getC_SalesRegion_ID() != 0)
			setC_SalesRegion_ID(0);
		if (isAnyUser1() && getUser1_ID() != 0)
			setUser1_ID(0);
		if (isAnyUser2() && getUser2_ID() != 0)
			setUser2_ID(0);
		if (isAnyCostCenter() && getC_CostCenter_ID() != 0)
			setC_CostCenter_ID(0);
		if (isAnyDepartment() && getC_Department_ID() != 0)
			setC_Department_ID(0);
		if (isAnyEmployee() && getC_Employee_ID() != 0)
			setC_Employee_ID(0);
		if (isAnyCharge() && getC_Charge_ID() != 0)
			setC_Charge_ID(0);
		if (isAnyAsset() && getA_Asset_ID() != 0)
			setA_Asset_ID(0);
		if (isAnyWarehouse() && getM_Warehouse_ID() != 0)
			setM_Warehouse_ID(0);
		if (isAnyAttributeSetInstance() && getM_AttributeSetInstance_ID() != 0)
			setM_AttributeSetInstance_ID(0);
		return true;
	}	//	beforeSave

}	//	MDistribution
