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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.report.MReportTree;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  Accounting Schema Model (base)
 *
 *  @author 	Jorg Janke
 *  @author     victor.perez@e-evolution.com, www.e-evolution.com
 *    			<li>RF [ 2214883 ] Remove SQL code and Replace for Query https://sourceforge.net/p/adempiere/feature-requests/557/
 *  @version 	$Id: MAcctSchema.java,v 1.4 2006/07/30 00:58:04 jjanke Exp $
 */
public class MAcctSchema extends X_C_AcctSchema implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 405097978362430053L;


	/**
	 *  Get AccountSchema
	 *  @param C_AcctSchema_ID schema id
	 *  @return Accounting schema
	 */
	public static MAcctSchema get (int C_AcctSchema_ID)
	{
		return get(Env.getCtx(), C_AcctSchema_ID);
	}
	
	/**
	 *  Get AccountSchema
	 * 	@param ctx context
	 *  @param C_AcctSchema_ID schema id
	 *  @return Accounting schema
	 */
	public static MAcctSchema get (Properties ctx, int C_AcctSchema_ID)
	{
		return get(ctx, C_AcctSchema_ID, (String)null);
	}	//	get

	/**
	 *  Get AccountSchema
	 * 	@param ctx context
	 *  @param C_AcctSchema_ID schema id
	 *  @param trxName optional trx
	 *  @return Accounting schema
	 */
	public static MAcctSchema get (Properties ctx, int C_AcctSchema_ID, String trxName)
	{
		//  Check Cache
		Integer key = Integer.valueOf(C_AcctSchema_ID);
		MAcctSchema retValue = s_cache.get(ctx, key, e -> new MAcctSchema(ctx, e));
		if (retValue != null)
			return retValue;
		
		retValue = new MAcctSchema (ctx, C_AcctSchema_ID, trxName);
		if (retValue.get_ID() == C_AcctSchema_ID)
		{
			s_cache.put(key, retValue, e -> new MAcctSchema(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get
	
	/**
	 * Get updateable copy of MAcctSchema from cache
	 * @param ctx
	 * @param C_AcctSchema_ID
	 * @param trxName
	 * @return MAcctSchema
	 */
	public static MAcctSchema getCopy(Properties ctx, int C_AcctSchema_ID, String trxName)
	{
		MAcctSchema as = get(ctx, C_AcctSchema_ID, trxName);
		if (as != null)
			as = new MAcctSchema(ctx, as, trxName);
		return as;
	}
	
	/**
	 *  Get AccountSchema of Client
	 * 	@param ctx context
	 *  @param AD_Client_ID client or 0 for all
	 *  @return Array of AcctSchema of Client
	 */
	public static MAcctSchema[] getClientAcctSchema (Properties ctx, int AD_Client_ID)
	{
		return getClientAcctSchema(ctx, AD_Client_ID, null);
	}	//	getClientAcctSchema
	
	/**
	 *  Get AccountSchema of Client
	 * 	@param ctx context
	 *  @param AD_Client_ID client or 0 for all
	 *  @param trxName optional trx 
	 *  @return Array of AcctSchema of Client
	 */
	public static synchronized MAcctSchema[] getClientAcctSchema (Properties ctx, int AD_Client_ID, String trxName)
	{
		//  Check Cache
		Integer key = Integer.valueOf(AD_Client_ID);
		if (s_schema.containsKey(key))
		{
			if (ctx == Env.getCtx())
				return s_schema.get(key);
			else
				return Arrays.stream(s_schema.get(key)).map(e -> { return new MAcctSchema(ctx, e).markImmutable(); }).toArray(MAcctSchema[]::new);
		}

		//  Create New
		ArrayList<MAcctSchema> list = new ArrayList<MAcctSchema>();
		MClientInfo info = MClientInfo.get(ctx, AD_Client_ID, trxName); 
		MAcctSchema as = MAcctSchema.get (ctx, info.getC_AcctSchema1_ID(), trxName);
		if (as.get_ID() != 0)
			list.add(as);
		
		ArrayList<Object> params = new ArrayList<Object>();
		StringBuilder whereClause = new StringBuilder("IsActive=? ")
			.append(" AND EXISTS (SELECT * FROM C_AcctSchema_GL gl WHERE C_AcctSchema.C_AcctSchema_ID=gl.C_AcctSchema_ID)")
			.append(" AND EXISTS (SELECT * FROM C_AcctSchema_Default d WHERE C_AcctSchema.C_AcctSchema_ID=d.C_AcctSchema_ID)"); 
			params.add("Y");
		if (AD_Client_ID != 0)
		{	
			whereClause.append(" AND AD_Client_ID=?");
			params.add(AD_Client_ID);
		}	
		
		List <MAcctSchema> ass = new Query(ctx, I_C_AcctSchema.Table_Name,whereClause.toString(),trxName)
		.setParameters(params)
		.setOrderBy(MAcctSchema.COLUMNNAME_C_AcctSchema_ID)
		.list();
		
		for(MAcctSchema acctschema : ass)
		{
			if (acctschema.get_ID() != info.getC_AcctSchema1_ID())	//	already in list
			{
				if (acctschema.get_ID() != 0)
				{
					acctschema.markImmutable();
					list.add(acctschema);
				}
			}
		}
		//  Save
		MAcctSchema[] retValue = new MAcctSchema [list.size()];
		list.toArray(retValue);
		if (ctx == Env.getCtx())
			s_schema.put(key, retValue);
		else
			s_schema.put(key, Arrays.stream(retValue).map(e -> {return new MAcctSchema(Env.getCtx(), e).markImmutable();}).toArray(MAcctSchema[]::new));
		return retValue;
	}   //  getClientAcctSchema

	/** Cache of Client AcctSchema Arrays		**/
	private static CCache<Integer,MAcctSchema[]> s_schema = new CCache<Integer,MAcctSchema[]>(I_AD_ClientInfo.Table_Name, I_AD_ClientInfo.Table_Name+"|MAcctSchema[]", 3, 120, false);	//  3 clients
	/**	Cache of AcctSchemas 					**/
	private static ImmutableIntPOCache<Integer,MAcctSchema> s_cache = new ImmutableIntPOCache<Integer,MAcctSchema>(Table_Name, 3, 120);	//  3 accounting schemas
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_AcctSchema_ID id
	 *	@param trxName transaction
	 */
	public MAcctSchema (Properties ctx, int C_AcctSchema_ID, String trxName)
	{
		super (ctx, C_AcctSchema_ID, trxName);
		if (C_AcctSchema_ID == 0)
		{
			setAutoPeriodControl (true);
			setPeriod_OpenFuture(2);
			setPeriod_OpenHistory(2);
			setCostingMethod (COSTINGMETHOD_StandardCosting);
			setCostingLevel(COSTINGLEVEL_Client);
			setIsAdjustCOGS(false);
			setGAAP (GAAP_InternationalGAAP);
			setHasAlias (true);
			setHasCombination (false);
			setIsAccrual (true);	// Y
			setCommitmentType(COMMITMENTTYPE_None);
			setIsDiscountCorrectsTax (false);
			setTaxCorrectionType(TAXCORRECTIONTYPE_None);
			setIsTradeDiscountPosted (false);
			setIsPostServices(false);
			setIsExplicitCostAdjustment(false);
			setSeparator ("-");	// -
		}
	}	//	MAcctSchema
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAcctSchema (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAcctSchema

	/**
	 * 	Parent Constructor
	 *	@param client client
	 *	@param currency currency
	 */
	public MAcctSchema (MClient client, KeyNamePair currency)
	{
		this (client.getCtx(), 0, client.get_TrxName());
		setClientOrg(client);
		setC_Currency_ID (currency.getKey());
		StringBuilder msgset = new StringBuilder().append(client.getName()).append(" ").append(getGAAP()).append("/").append(get_ColumnCount()).append(" ").append(currency.getName());
		setName (msgset.toString());
	}	//	MAcctSchema

	/**
	 * 
	 * @param copy
	 */
	public MAcctSchema(MAcctSchema copy)
	{
		this(Env.getCtx(), copy);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MAcctSchema(Properties ctx, MAcctSchema copy)
	{
		this(ctx, copy, (String)null);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MAcctSchema(Properties ctx, MAcctSchema copy, String trxName) 
	{
		super(ctx, 0, trxName);
		copyPO(copy);
		this.m_gl = copy.m_gl != null ? new MAcctSchemaGL(ctx, copy.m_gl) : null;
		this.m_default = copy.m_default != null ? new MAcctSchemaDefault(ctx, copy.m_default) : null;
		this.m_SuspenseError_Acct = copy.m_SuspenseError_Acct != null ? new MAccount(ctx, copy.m_SuspenseError_Acct) : null;
		this.m_CurrencyBalancing_Acct = copy.m_CurrencyBalancing_Acct != null ? new MAccount(ctx, copy.m_CurrencyBalancing_Acct) : null;
		this.m_DueTo_Acct = copy.m_DueTo_Acct != null ? new MAccount(ctx, copy.m_DueTo_Acct) : null;
		this.m_DueFrom_Acct = copy.m_DueFrom_Acct != null ? new MAccount(ctx, copy.m_DueFrom_Acct) : null;
		this.m_stdPrecision = copy.m_stdPrecision;
		this.m_costPrecision = copy.m_costPrecision;
		this.m_onlyOrg = copy.m_onlyOrg != null ? new MOrg(ctx, copy.m_onlyOrg) : null;
		this.m_onlyOrgs = copy.m_onlyOrgs;
	}

	/** GL Info				*/
	private MAcctSchemaGL			m_gl = null;
	/** Default Info		*/
	private MAcctSchemaDefault		m_default = null;
	
	private MAccount				m_SuspenseError_Acct = null;
	private MAccount				m_CurrencyBalancing_Acct = null;
	private MAccount				m_DueTo_Acct = null;
	private MAccount				m_DueFrom_Acct = null;
	/** Accounting Currency Precision	*/
	private int						m_stdPrecision = -1;
	/** Costing Currency Precision		*/
	private int						m_costPrecision = -1;
	
	/** Only Post Org					*/
	private MOrg					m_onlyOrg = null;
	/** Only Post Org Childs			*/
	private Integer[] 				m_onlyOrgs = null; 

	/**************************************************************************
	 *  AcctSchema Elements
	 *  @return ArrayList of AcctSchemaElement
	 */
	public MAcctSchemaElement[] getAcctSchemaElements()
	{
		return MAcctSchemaElement.getAcctSchemaElements(this);
	}   //  getAcctSchemaElements

	/**
	 *  Get AcctSchema Element
	 *  @param elementType segment type - AcctSchemaElement.ELEMENTTYPE_
	 *  @return AcctSchemaElement
	 */
	public MAcctSchemaElement getAcctSchemaElement (String elementType)
	{
		/** Element List       */
		for (MAcctSchemaElement ase : getAcctSchemaElements()) {
			if (ase.getElementType().equals(elementType))
				return ase;
		}
		return null;
	}   //  getAcctSchemaElement

	/**
	 *  Has AcctSchema Element
	 *  @param segmentType segment type - AcctSchemaElement.SEGMENT_
	 *  @return true if schema has segment type
	 */
	public boolean isAcctSchemaElement (String segmentType)
	{
		return getAcctSchemaElement(segmentType) != null;
	}   //  isAcctSchemaElement

	/**
	 * 	Get AcctSchema GL info
	 *	@return GL info
	 */
	public MAcctSchemaGL getAcctSchemaGL()
	{
		if (m_gl == null)
		{
			m_gl = MAcctSchemaGL.get(getCtx(), getC_AcctSchema_ID());
			if (m_gl != null && is_Immutable())
				m_gl.markImmutable();
		}
		if (m_gl == null)
			throw new IllegalStateException("No GL Definition for C_AcctSchema_ID=" + getC_AcctSchema_ID());
		return m_gl;
	}	//	getAcctSchemaGL
	
	/**
	 * 	Get AcctSchema Defaults
	 *	@return defaults
	 */
	public MAcctSchemaDefault getAcctSchemaDefault()
	{
		if (m_default == null)
		{
			m_default = MAcctSchemaDefault.get(getCtx(), getC_AcctSchema_ID());
			if (m_default != null && is_Immutable())
				m_default.markImmutable();
		}
		if (m_default == null)
			throw new IllegalStateException("No Default Definition for C_AcctSchema_ID=" + getC_AcctSchema_ID());
		return m_default;
	}	//	getAcctSchemaDefault

	/**
	 *	String representation
	 *  @return String rep
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("AcctSchema[");
			sb.append(get_ID()).append("-").append(getName())
				.append("]");
		return sb.toString();
	}	//	toString

	/**
	 * 	Is Suspense Balancing active
	 *	@return suspense balancing
	 */
	public boolean isSuspenseBalancing()
	{
		if (m_gl == null)
			getAcctSchemaGL();
		return m_gl.isUseSuspenseBalancing() && m_gl.getSuspenseBalancing_Acct() != 0;
	}	//	isSuspenseBalancing

	/**
	 *	Get Suspense Error Account
	 *  @return suspense error account
	 */
	public MAccount getSuspenseBalancing_Acct()
	{
		if (m_SuspenseError_Acct != null)
			return m_SuspenseError_Acct;
		if (m_gl == null)
			getAcctSchemaGL();
		int C_ValidCombination_ID = m_gl.getSuspenseBalancing_Acct();
		m_SuspenseError_Acct = MAccount.get(C_ValidCombination_ID);
		return m_SuspenseError_Acct;
	}	//	getSuspenseBalancing_Acct

	/**
	 * 	Is Currency Balancing active
	 *	@return suspense balancing
	 */
	public boolean isCurrencyBalancing()
	{
		if (m_gl == null)
			getAcctSchemaGL();
		return m_gl.isUseCurrencyBalancing();
	}	//	isSuspenseBalancing

	/**
	 *	Get Currency Balancing Account
	 *  @return currency balancing account
	 */
	public MAccount getCurrencyBalancing_Acct()
	{
		if (m_CurrencyBalancing_Acct != null)
			return m_CurrencyBalancing_Acct;
		if (m_gl == null)
			getAcctSchemaGL();
		int C_ValidCombination_ID = m_gl.getCurrencyBalancing_Acct();
		m_CurrencyBalancing_Acct = MAccount.get(C_ValidCombination_ID);
		return m_CurrencyBalancing_Acct;
	}	//	getCurrencyBalancing_Acct


	/**
	 *	Get Due To Account for Segment
	 *  @param segment ignored
	 *  @return Account
	 */
	public MAccount getDueTo_Acct(String segment)
	{
		if (m_DueTo_Acct != null)
			return m_DueTo_Acct;
		if (m_gl == null)
			getAcctSchemaGL();
		int C_ValidCombination_ID = m_gl.getIntercompanyDueTo_Acct();
		m_DueTo_Acct = MAccount.get(C_ValidCombination_ID);
		return m_DueTo_Acct;
	}	//	getDueTo_Acct

	/**
	 *	Get Due From Account for Segment
	 *  @param segment ignored
	 *  @return Account
	 */
	public MAccount getDueFrom_Acct(String segment)
	{
		if (m_DueFrom_Acct != null)
			return m_DueFrom_Acct;
		if (m_gl == null)
			getAcctSchemaGL();
		int C_ValidCombination_ID = m_gl.getIntercompanyDueFrom_Acct();
		m_DueFrom_Acct = MAccount.get(C_ValidCombination_ID);
		return m_DueFrom_Acct;
	}	//	getDueFrom_Acct

	/**
	 * Set Only Org Childs
	 * @param orgs
	 * @deprecated only orgs are now fetched automatically
	 * @throws IllegalStateException every time when you call it 
	 */
	public void setOnlyOrgs (Integer[] orgs)
	{
//		m_onlyOrgs = orgs;
		throw new IllegalStateException("The OnlyOrgs are now fetched automatically");
	}	//	setOnlyOrgs
	
	/**
	 * Get Only Org Children
	 * @return array of AD_Org_ID
	 */
	public synchronized Integer[] getOnlyOrgs()
	{
		if (m_onlyOrgs == null)
		{
			MReportTree tree = new MReportTree (getCtx(), 0, true, MAcctSchemaElement.ELEMENTTYPE_Organization);
			m_onlyOrgs = tree.getChildIDs(getAD_OrgOnly_ID());
		}
		return m_onlyOrgs;
	}	//	getOnlyOrgs

	/**
	 * 	Skip creating postings for this Org.
	 *	@param AD_Org_ID
	 *	@return true if to skip
	 */
	public synchronized boolean isSkipOrg (int AD_Org_ID)
	{
		if (getAD_OrgOnly_ID() == 0)
			return false;
		//	Only Organization
		if (getAD_OrgOnly_ID() == AD_Org_ID)
			return false;
		if (m_onlyOrg == null)
			m_onlyOrg = MOrg.get(getAD_OrgOnly_ID());
		//	Not Summary Only - i.e. skip it
		if (!m_onlyOrg.isSummary())
			return true;
		final Integer[] onlyOrgs = getOnlyOrgs();
		if (onlyOrgs == null)
		{
			return false;
		}
		for (int i = 0; i < onlyOrgs.length; i++)
		{
			if (AD_Org_ID == onlyOrgs[i].intValue())
				return false;
		}
		return true;
	}	//	isSkipOrg
	
	/**
	 * 	Get Std Precision of accounting Currency
	 *	@return precision
	 */
	public int getStdPrecision()
	{
		if (m_stdPrecision < 0)
		{
			MCurrency cur = MCurrency.get(getCtx(), getC_Currency_ID());
			m_stdPrecision = cur.getStdPrecision();
			m_costPrecision = cur.getCostingPrecision();
		}
		return m_stdPrecision;
	}	//	getStdPrecision

	/**
	 * 	Get Costing Precision of accounting Currency
	 *	@return precision
	 */
	public int getCostingPrecision()
	{
		if (m_costPrecision < 0)
			getStdPrecision();
		return m_costPrecision;
	}	//	getCostingPrecision
	
	
	/**
	 * 	Check Costing Setup.
	 * 	Make sure that there is a Cost Type and Cost Element
	 */
	public void checkCosting()
	{
		if (log.isLoggable(Level.INFO)) log.info(toString());
		//	Create Cost Type
		if (getM_CostType_ID() == 0)
		{
			MCostType ct = new MCostType (getCtx(), 0, get_TrxName());
			ct.setClientOrg(getAD_Client_ID(), 0);
			ct.setName(getName());
			ct.saveEx();
			setM_CostType_ID(ct.getM_CostType_ID());
		}
		
		//	Create Cost Elements
		MCostElement.getMaterialCostElement(this, getCostingMethod());
		
		//	Default Costing Level
		if (getCostingLevel() == null)
			setCostingLevel(COSTINGLEVEL_Client);
		if (getCostingMethod() == null)
			setCostingMethod (COSTINGMETHOD_StandardCosting);
		if (getGAAP() == null)
			setGAAP (GAAP_InternationalGAAP);
	}	//	checkCosting
	
	/**
	 * 	Is Client Costing Level (default)
	 *	@return true if Client
	 */
	public boolean isCostingLevelClient()
	{
		String s = getCostingLevel();
		if (s == null || COSTINGLEVEL_Client.equals(s))
			return true;
		return false;
	}	//	isCostingLevelClient
	
	/**
	 * 	Is Org Costing Level
	 *	@return true if Org
	 */
	public boolean isCostingLevelOrg()
	{
		return COSTINGLEVEL_Organization.equals(getCostingLevel());
	}	//	isCostingLevelOrg
	
	/**
	 * 	Is Batch Costing Level
	 *	@return true if Batch
	 */
	public boolean isCostingLevelBatch()
	{
		return COSTINGLEVEL_BatchLot.equals(getCostingLevel());
	}	//	isCostingLevelBatch

	/**
	 * 	Create PO Commitment Accounting
	 *	@return true if creaet commitments
	 */
	public boolean isCreatePOCommitment()
	{
		String s = getCommitmentType();
		if (s == null)
			return false;
		return COMMITMENTTYPE_POCommitmentOnly.equals(s)
			|| COMMITMENTTYPE_POCommitmentReservation.equals(s)
			|| COMMITMENTTYPE_POSOCommitmentReservation.equals(s)
			|| COMMITMENTTYPE_POSOCommitment.equals(s);
	}	//	isCreateCommitment

	/**
	 * 	Create SO Commitment Accounting
	 *	@return true if creaet commitments
	 */
	public boolean isCreateSOCommitment()
	{
		String s = getCommitmentType();
		if (s == null)
			return false;
		return COMMITMENTTYPE_SOCommitmentOnly.equals(s)
			|| COMMITMENTTYPE_POSOCommitmentReservation.equals(s)
			|| COMMITMENTTYPE_POSOCommitment.equals(s);
	}	//	isCreateCommitment

	/**
	 * 	Create Commitment/Reservation Accounting
	 *	@return true if create reservations
	 */
	public boolean isCreateReservation()
	{
		String s = getCommitmentType();
		if (s == null)
			return false;
		return COMMITMENTTYPE_POCommitmentReservation.equals(s)
			|| COMMITMENTTYPE_POSOCommitmentReservation.equals(s);
	}	//	isCreateReservation

	/**
	 * 	Get Tax Correction Type
	 *	@return tax correction type
	 */
	public String getTaxCorrectionType()
	{
		if (super.getTaxCorrectionType() == null)	//	created 07/23/06 2.5.3d
			setTaxCorrectionType(isDiscountCorrectsTax() 
				? TAXCORRECTIONTYPE_Write_OffAndDiscount : TAXCORRECTIONTYPE_None);
		return super.getTaxCorrectionType ();
	}	//	getTaxCorrectionType
	
	/**
	 * 	Tax Correction
	 *	@return true if not none
	 */
	public boolean isTaxCorrection()
	{
		return !getTaxCorrectionType().equals(TAXCORRECTIONTYPE_None);
	}	//	isTaxCorrection
	
	/**
	 * 	Tax Correction for Discount
	 *	@return true if tax is corrected for Discount 
	 */
	public boolean isTaxCorrectionDiscount()
	{
		return getTaxCorrectionType().equals(TAXCORRECTIONTYPE_DiscountOnly)
			|| getTaxCorrectionType().equals(TAXCORRECTIONTYPE_Write_OffAndDiscount);
	}	//	isTaxCorrectionDiscount

	/**
	 * 	Tax Correction for WriteOff
	 *	@return true if tax is corrected for WriteOff 
	 */
	public boolean isTaxCorrectionWriteOff()
	{
		return getTaxCorrectionType().equals(TAXCORRECTIONTYPE_Write_OffOnly)
			|| getTaxCorrectionType().equals(TAXCORRECTIONTYPE_Write_OffAndDiscount);
	}	//	isTaxCorrectionWriteOff

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		if (super.getTaxCorrectionType() == null)
			setTaxCorrectionType(isDiscountCorrectsTax() 
				? TAXCORRECTIONTYPE_Write_OffAndDiscount : TAXCORRECTIONTYPE_None);
		checkCosting();
		//	Check Primary
		if (getAD_OrgOnly_ID() != 0)
		{
			MClientInfo info = MClientInfo.get(getCtx(), getAD_Client_ID());
			if (info.getC_AcctSchema1_ID() == getC_AcctSchema_ID())
				setAD_OrgOnly_ID(0);
		}
		if (!newRecord && is_ValueChanged(COLUMNNAME_CostingLevel)) 
		{
			String products = getProductsWithCost();
			if (!Util.isEmpty(products)) {
				log.saveError("Error", Msg.getMsg(getCtx(), "ChangeCostingLevelError") + ". Products: " + products);
				return false; 
			}
		}
		return true;
	}	//	beforeSave
	
	private String getProductsWithCost() {
		StringBuilder products = new StringBuilder();
		StringBuilder sql = new StringBuilder("SELECT DISTINCT p.Value FROM M_Product p JOIN M_CostDetail d ON p.M_Product_ID=d.M_Product_ID");
		sql.append(" JOIN M_Product_Category_Acct pc ON p.M_Product_Category_ID=pc.M_Product_Category_ID AND d.C_AcctSchema_ID=pc.C_AcctSchema_ID");
		sql.append(" WHERE p.IsActive='Y' AND pc.IsActive='Y' AND pc.CostingLevel IS NULL AND d.C_AcctSchema_ID=?");
		String query = DB.getDatabase().addPagingSQL(sql.toString(), 0, 50);
		List<List<Object>> list = DB.getSQLArrayObjectsEx(get_TrxName(), query, getC_AcctSchema_ID());
		if (list != null) {
			for(List<Object> entry : list) {
				String value = (String) entry.get(0);
				if (products.length() > 0)
					products.append(",");
				products.append(value);
			}
		}
		return products.toString();
	}
	
	@Override
	public MAcctSchema markImmutable() 
	{
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_gl != null)
			m_gl.markImmutable();
		if (m_default != null)
			m_default.markImmutable();
		return this;
	}

}	//	MAcctSchema
