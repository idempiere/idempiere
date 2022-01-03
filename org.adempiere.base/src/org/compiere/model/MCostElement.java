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
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Cost Element Model
 *  @author Jorg Janke
 *  @version $Id: MCostElement.java,v 1.2 2006/07/30 00:58:04 jjanke Exp $
 *  
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>BF [ 2664529 ] More then one Labor/Burden//Overhead is not allowed
 *  		<li>BF [ 2667470 ] MCostElement.getMaterialCostElement should check only material
 *  @author red1
 *  		<li>FR: [ 2214883 ] Remove SQL code and Replace for Query -- JUnit tested
 */
public class MCostElement extends X_M_CostElement implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4914952212171251715L;

	/**
	 * 	Get Material Cost Element or create it
	 *	@param po parent
	 *	@param CostingMethod method
	 *	@return cost element
	 */
	public static MCostElement getMaterialCostElement (PO po, String CostingMethod)
	{
		if (CostingMethod == null || CostingMethod.length() == 0)
		{
			s_log.severe("No CostingMethod");
			return null;
		}
		//
		final String whereClause = "AD_Client_ID=? AND CostingMethod=? AND CostElementType=?";
		MCostElement retValue = new Query(po.getCtx(), Table_Name, whereClause, po.get_TrxName())
			.setParameters(po.getAD_Client_ID(), CostingMethod, COSTELEMENTTYPE_Material)
			.setOrderBy("AD_Org_ID")
			.firstOnly();
		if (retValue != null)
			return retValue;
		
		//	Create New
		retValue = new MCostElement (po.getCtx(), 0, po.get_TrxName());
		retValue.setClientOrg(po.getAD_Client_ID(), 0);
		String name = MRefList.getListName(po.getCtx(), COSTINGMETHOD_AD_Reference_ID, CostingMethod);
		if (name == null || name.length() == 0)
			name = CostingMethod;
		retValue.setName(name);
		retValue.setCostElementType(COSTELEMENTTYPE_Material);
		retValue.setCostingMethod(CostingMethod);
		retValue.saveEx();
		
		//
		return retValue;
	}	//	getMaterialCostElement

	/**
	 * 	Get first Material Cost Element
	 *	@param ctx context
	 *	@param CostingMethod costing method
	 *	@return Cost Element or null
	 */
	public static MCostElement getMaterialCostElement(Properties ctx, String CostingMethod)
	{
		final String whereClause = "AD_Client_ID=? AND CostingMethod=? AND CostElementType=?";
		List<MCostElement> list = new Query(ctx, I_M_CostElement.Table_Name, whereClause, null)
		.setParameters(Env.getAD_Client_ID(ctx),CostingMethod,COSTELEMENTTYPE_Material)
		.setOrderBy(I_M_CostElement.COLUMNNAME_AD_Org_ID)
		.list();
		MCostElement retValue = null;
		if (list.size() > 0)
			retValue = list.get(0);
		if (list.size() > 1)
			if (s_log.isLoggable(Level.INFO)) s_log.info("More then one Material Cost Element for CostingMethod=" + CostingMethod);
		return retValue;
	}	//	getMaterialCostElement
	
	/**
	 * 	Get first Material Cost Element
	 *	@param ctx context
	 *	@param CostingMethod costing method
	 *	@return Cost Element or null
	 */
	public static MCostElement getMaterialCostElement(Properties ctx, String CostingMethod, int AD_Org_ID)
	{
		final String whereClause = "AD_Client_ID=? AND CostingMethod=? AND CostElementType=? AND AD_Org_ID In (0, ?)";
		List<MCostElement> list = new Query(ctx, I_M_CostElement.Table_Name, whereClause, null)
		.setParameters(Env.getAD_Client_ID(ctx),CostingMethod,COSTELEMENTTYPE_Material,AD_Org_ID)
		.setOrderBy(I_M_CostElement.COLUMNNAME_AD_Org_ID + " Desc")
		.list();
		MCostElement retValue = null;
		if (list.size() > 0)
			retValue = list.get(0);
		if (list.size() > 1)
			if (s_log.isLoggable(Level.INFO)) s_log.info("More then one Material Cost Element for CostingMethod=" + CostingMethod);
		return retValue;
	}	//	getMaterialCostElement
	
	/**
	 * 	Get active Material Cost Element for client 
	 *	@param po parent
	 *	@return cost element array
	 */
	public static List<MCostElement> getCostElementsWithCostingMethods (PO po)
	{
		final String whereClause = "AD_Client_ID=? AND CostingMethod IS NOT NULL";
		return new Query(po.getCtx(),MCostElement.Table_Name,whereClause,po.get_TrxName())
		.setParameters(po.getAD_Client_ID())
		.setOnlyActiveRecords(true)
		.list();
	}	//	getCostElementCostingMethod	
	
	/**
	 * 	Get active Material Cost Element for client 
	 *	@param po parent
	 *	@return cost element array
	 */
	public static MCostElement[] getCostingMethods (PO po)
	{
		final String whereClause ="AD_Client_ID=? AND CostElementType=? AND CostingMethod IS NOT NULL";
		List<MCostElement> list = new Query(po.getCtx(), I_M_CostElement.Table_Name, whereClause, po.get_TrxName())
		.setParameters(po.getAD_Client_ID(),COSTELEMENTTYPE_Material)
		.setOnlyActiveRecords(true)
		.list();
		//
		MCostElement[] retValue = new MCostElement[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getMaterialCostElement

	// MZ Goodwill
	/**
	 * 	Get active non Material Cost Element for client 
	 *	@param po parent
	 *	@return cost element array
	 */
	public static MCostElement[] getNonCostingMethods (PO po)
	{
		final String whereClause = "AD_Client_ID=? AND CostingMethod IS NULL";
		List<MCostElement>list = new Query(po.getCtx(),I_M_CostElement.Table_Name, whereClause, po.get_TrxName())
		.setParameters(po.getAD_Client_ID())
		.setOnlyActiveRecords(true)
		.list(); 
		//
		MCostElement[] retValue = new MCostElement[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getMaterialCostElement
	// end MZ
	
	/**
	 * 	Get Cost Element from Cache (immutable)
	 *	@param M_CostElement_ID id
	 *	@return Cost Element
	 */
	public static MCostElement get (int M_CostElement_ID)
	{
		return get(Env.getCtx(), M_CostElement_ID);
	}
	
	/**
	 * 	Get Cost Element from Cache (immutable)
	 *	@param ctx context
	 *	@param M_CostElement_ID id
	 *	@return Cost Element
	 */
	public static MCostElement get (Properties ctx, int M_CostElement_ID)
	{
		Integer key = Integer.valueOf(M_CostElement_ID);
		MCostElement retValue = s_cache.get (ctx, key, e -> new MCostElement(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MCostElement (ctx, M_CostElement_ID, (String)null);
		if (retValue.get_ID () == M_CostElement_ID)
		{
			s_cache.put (key, retValue, e -> new MCostElement(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get
	
	/**
	 * Get updateable copy of MCostElement from cache
	 * @param ctx
	 * @param M_CostElement_ID
	 * @param trxName
	 * @return MCostElement
	 */
	public static MCostElement getCopy(Properties ctx, int M_CostElement_ID, String trxName)
	{
		MCostElement ce = get(M_CostElement_ID);
		if (ce != null)
			ce = new MCostElement(ctx, ce, trxName);
		return ce;
	}
	
	/**
	 * Get All Cost Elements for current AD_Client_ID
	 * @param ctx context
	 * @param trxName transaction
	 * @return array cost elements
	 */
	public static MCostElement[] getElements (Properties ctx, String trxName)
	{
		int AD_Org_ID = 0; // Org is always ZERO - see beforeSave
		
		final String whereClause = "AD_Client_ID = ? AND AD_Org_ID=?";
		List<MCostElement> list = new Query(ctx, Table_Name, whereClause, trxName)
					.setParameters(Env.getAD_Client_ID(ctx),AD_Org_ID)
					.list();
		MCostElement[] retValue = new MCostElement[list.size()];
		list.toArray(retValue);
		return retValue;	
	}
	
	/**
	 * Get All Cost Elements for current AD_Client_ID
	 * @param ctx context
	 * @param CostingMethod
	 * @return array cost elements
	 **/
	/**
	 * @return
	 */
	public static List<MCostElement> getByCostingMethod (Properties ctx, String CostingMethod)
	{		
		final String whereClause = "AD_Client_ID = ? AND CostingMethod=?";
		return new Query(ctx, Table_Name, whereClause, null)
					.setOnlyActiveRecords(true)
					.setParameters(Env.getAD_Client_ID(ctx),CostingMethod)
					.list();	
	}	

	/**	Cache						*/
	protected static ImmutableIntPOCache<Integer,MCostElement>	s_cache	= new ImmutableIntPOCache<Integer,MCostElement>(Table_Name, 20);
	
	/**	Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MCostElement.class);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_CostElement_ID id
	 *	@param trxName trx
	 */
	public MCostElement (Properties ctx, int M_CostElement_ID, String trxName)
	{
		super (ctx, M_CostElement_ID, trxName);
		if (M_CostElement_ID == 0)
		{
			setCostElementType (COSTELEMENTTYPE_Material);
			setIsCalculated (false);
		}
	}	//	MCostElement

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MCostElement (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MCostElement
	
	/**
	 * 
	 * @param copy
	 */
	public MCostElement(MCostElement copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MCostElement(Properties ctx, MCostElement copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MCostElement(Properties ctx, MCostElement copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		//	Check Unique Costing Method
		if (
			(  COSTELEMENTTYPE_Material.equals(getCostElementType())
			|| COSTELEMENTTYPE_OutsideProcessing.equals(getCostElementType())
			)
			&& (newRecord || is_ValueChanged(COLUMNNAME_CostingMethod)))
		{
			String sql = "SELECT  COALESCE(MAX(M_CostElement_ID),0) FROM M_CostElement "
				+ "WHERE AD_Client_ID=? AND CostingMethod=? AND CostElementType=?";
			int id = DB.getSQLValue(get_TrxName(), sql, getAD_Client_ID(), getCostingMethod() , getCostElementType());
			if (id > 0 && id != get_ID())
			{
				log.saveError("AlreadyExists", Msg.getElement(getCtx(), "CostingMethod"));
				return false;
			}
		}
		
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		return true;
	}	//	beforeSave
	
	/**
	 * 	Before Delete
	 *	@return true if can be deleted
	 */
	protected boolean beforeDelete ()
	{
		String cm = getCostingMethod();
		if (cm == null
			|| !COSTELEMENTTYPE_Material.equals(getCostElementType()))
			return true;
		
		//	Costing Methods on AS level
		MAcctSchema[] ass = MAcctSchema.getClientAcctSchema(getCtx(), getAD_Client_ID());
		for (int i = 0; i < ass.length; i++)
		{
			if (ass[i].getCostingMethod().equals(getCostingMethod()))
			{
				log.saveError("CannotDeleteUsed", Msg.getElement(getCtx(), "C_AcctSchema_ID") 
					+ " - " + ass[i].getName());
				return false;
			}
		}
		
		//	Costing Methods on PC level
		int M_Product_Category_ID = 0;
		final String whereClause ="AD_Client_ID=? AND CostingMethod=?";
		MProductCategoryAcct retValue = new Query(getCtx(), I_M_Product_Category_Acct.Table_Name, whereClause, null)
		.setParameters(getAD_Client_ID(), getCostingMethod())
		.first();
		if (retValue != null)
			M_Product_Category_ID = retValue.getM_Product_Category_ID();
		if (M_Product_Category_ID != 0)
		{
			log.saveError("CannotDeleteUsed", Msg.getElement(getCtx(), "M_Product_Category_ID") 
				+ " (ID=" + M_Product_Category_ID + ")");
			return false;
		}
		return true;
	}	//	beforeDelete
	
	/**
	 * 	Is this a Costing Method
	 *	@return true if not Material cost or no costing method.
	 */
	public boolean isCostingMethod()
	{
		return COSTELEMENTTYPE_Material.equals(getCostElementType())
			&& getCostingMethod() != null;
	}	//	isCostingMethod
	
	/**
	 * 	Is Avg Invoice Costing Method
	 *	@return true if AverageInvoice
	 */
	public boolean isAverageInvoice()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_AverageInvoice)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isAverageInvoice
	
	/**
	 * 	Is Avg PO Costing Method
	 *	@return true if AveragePO
	 */
	public boolean isAveragePO()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_AveragePO)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isAveragePO
	/**
	 * 	Is FiFo Costing Method
	 *	@return true if Fifo
	 */
	public boolean isFifo()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_Fifo)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isFifo
	/**
	 * 	Is Last Invoice Costing Method
	 *	@return true if LastInvoice
	 */
	public boolean isLastInvoice()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_LastInvoice)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isLastInvoice
	/**
	 * 	Is Last PO Costing Method
	 *	@return true if LastPOPrice
	 */
	public boolean isLastPOPrice()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_LastPOPrice)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isLastPOPrice
	/**
	 * 	Is LiFo Costing Method
	 *	@return true if Lifo
	 */
	public boolean isLifo()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_Lifo)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isLiFo
	/**
	 * 	Is Std Costing Method
	 *	@return true if StandardCosting
	 */
	public boolean isStandardCosting()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_StandardCosting)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isStandardCosting
	/**
	 * 	Is User Costing Method
	 *	@return true if User Defined
	 */
	public boolean isUserDefined()
	{
		String cm = getCostingMethod();
		return cm != null 
			&& cm.equals(COSTINGMETHOD_UserDefined)
			&& COSTELEMENTTYPE_Material.equals(getCostElementType());
	}	//	isAveragePO
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MCostElement[");
		sb.append (get_ID ())
			.append ("-").append (getName())
			.append(",Type=").append(getCostElementType())
			.append(",Method=").append(getCostingMethod())
			.append ("]");
		return sb.toString ();
	} //	toString
	
	@Override
	public MCostElement markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MCostElement
