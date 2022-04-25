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
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  Account Schema Element Object
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: MAcctSchemaElement.java,v 1.4 2006/08/10 01:00:44 jjanke Exp $
 * 
 * @author victor.perez@e-evolution.com, www.e-evolution.com
 *    			<li>RF [ 2214883 ] Remove SQL code and Replace for Query https://sourceforge.net/p/adempiere/feature-requests/557/
 */
public class MAcctSchemaElement extends X_C_AcctSchema_Element implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -747934131394469553L;

	/**
	 * Get ArrayList of Account Schema Elements from cache
	 * @param as Accounting Schema
	 * @return ArrayList with Elements
	 */
	public static MAcctSchemaElement[] getAcctSchemaElements (MAcctSchema as)
	{
		Integer key = Integer.valueOf(as.getC_AcctSchema_ID());
		MAcctSchemaElement[] retValue = (MAcctSchemaElement[]) s_cache.get (key);
		if (retValue != null)
			return retValue;

		if (s_log.isLoggable(Level.FINE)) s_log.fine("C_AcctSchema_ID=" + as.getC_AcctSchema_ID());
		ArrayList<MAcctSchemaElement> list = new ArrayList<MAcctSchemaElement>();
		
		final String whereClause = "C_AcctSchema_ID=? AND IsActive=?";
		List<MAcctSchemaElement> elements= new Query(as.getCtx(), I_C_AcctSchema_Element.Table_Name,whereClause,as.get_TrxName())
		.setParameters(as.getC_AcctSchema_ID(),"Y")
		.setOrderBy("SeqNo")
		.list();
		
		for(MAcctSchemaElement ase : elements)
		{
			if (s_log.isLoggable(Level.FINE)) s_log.fine(" - " + ase);
			if (ase.isMandatory() && ase.getDefaultValue() == 0)
				s_log.log(Level.SEVERE, "No default value for " + ase.getName());
			ase.markImmutable();
			list.add(ase);
		}
		
		retValue = new MAcctSchemaElement[list.size()];
		list.toArray(retValue);
		s_cache.put(key, retValue);
		return retValue;
	}   //  getAcctSchemaElements

	/**
	 * Get Column Name of ELEMENTTYPE 
	 * @param elementType ELEMENTTYPE 
	 * @return column name or "" if not found
	 */
	public static String getColumnName(String elementType)
	{
		if (elementType.equals(ELEMENTTYPE_Organization))
			return "AD_Org_ID";
		else if (elementType.equals(ELEMENTTYPE_Account))
			return I_C_ValidCombination.COLUMNNAME_Account_ID;
		else if (elementType.equals(ELEMENTTYPE_BPartner))
			return I_C_ValidCombination.COLUMNNAME_C_BPartner_ID;
		else if (elementType.equals(ELEMENTTYPE_Product))
			return I_C_ValidCombination.COLUMNNAME_M_Product_ID;
		else if (elementType.equals(ELEMENTTYPE_Activity))
			return I_C_ValidCombination.COLUMNNAME_C_Activity_ID;
		else if (elementType.equals(ELEMENTTYPE_LocationFrom))
			return I_C_ValidCombination.COLUMNNAME_C_LocFrom_ID;
		else if (elementType.equals(ELEMENTTYPE_LocationTo))
			return I_C_ValidCombination.COLUMNNAME_C_LocTo_ID;
		else if (elementType.equals(ELEMENTTYPE_Campaign))
			return I_C_ValidCombination.COLUMNNAME_C_Campaign_ID;
		else if (elementType.equals(ELEMENTTYPE_OrgTrx))
			return I_C_ValidCombination.COLUMNNAME_AD_OrgTrx_ID;
		else if (elementType.equals(ELEMENTTYPE_Project))
			return I_C_ValidCombination.COLUMNNAME_C_Project_ID;
		else if (elementType.equals(ELEMENTTYPE_SalesRegion))
			return I_C_ValidCombination.COLUMNNAME_C_SalesRegion_ID;
		else if (elementType.equals(ELEMENTTYPE_UserElementList1))
			return I_C_ValidCombination.COLUMNNAME_User1_ID;
		else if (elementType.equals(ELEMENTTYPE_UserElementList2))
			return I_C_ValidCombination.COLUMNNAME_User2_ID;
		else if (elementType.equals(ELEMENTTYPE_UserColumn1))
			return I_C_ValidCombination.COLUMNNAME_UserElement1_ID;
		else if (elementType.equals(ELEMENTTYPE_UserColumn2))
			return I_C_ValidCombination.COLUMNNAME_UserElement2_ID;
		//
		return "";
	}   //  getColumnName

	/**
	 * Get Value Query for ELEMENTTYPE Type
	 * @param elementType ELEMENTTYPE type
	 * @return query "SELECT Value,Name FROM Table WHERE ID=" or "" if not found
	 */
	public static String getValueQuery (String elementType)
	{
		String baseLanguage = Language.getBaseAD_Language(); 
		String language = Language.getLoginLanguage().getAD_Language();
		boolean translated = Env.isMultiLingualDocument(Env.getCtx()) && ! language.equalsIgnoreCase(baseLanguage);
		if (elementType.equals(ELEMENTTYPE_Organization)) {
			return "SELECT Value,Name FROM AD_Org WHERE AD_Org_ID=";
		} else if (   elementType.equals(ELEMENTTYPE_Account)
				   || elementType.equals(ELEMENTTYPE_UserElementList1)
				   || elementType.equals(ELEMENTTYPE_UserElementList2)) {
			if (translated)
				return "SELECT o.Value,t.Name FROM C_ElementValue o JOIN C_ElementValue_Trl t ON (o.C_ElementValue_ID=t.C_ElementValue_ID AND t.AD_Language=" + DB.TO_STRING(language)+ ") WHERE o.C_ElementValue_ID=";
			else
				return "SELECT Value,Name FROM C_ElementValue WHERE C_ElementValue_ID=";
		} else if (elementType.equals(ELEMENTTYPE_SubAccount)) {
			return "SELECT Value,Name FROM C_SubAccount WHERE C_SubAccount_ID=";
		} else if (elementType.equals(ELEMENTTYPE_BPartner)) {
			return "SELECT Value,Name FROM C_BPartner WHERE C_BPartner_ID=";
		} else if (elementType.equals(ELEMENTTYPE_Product)) {
			if (translated)
				return "SELECT o.Value,t.Name FROM M_Product o JOIN M_Product_Trl t ON (o.M_Product_ID=t.M_Product_ID AND t.AD_Language=" + DB.TO_STRING(language)+ ") WHERE o.M_Product_ID=";
			else
				return "SELECT Value,Name FROM M_Product WHERE M_Product_ID=";
		} else if (elementType.equals(ELEMENTTYPE_Activity)) {
			if (translated)
				return "SELECT Value,Name FROM C_Activity o JOIN C_Activity_Trl t ON (o.C_Activity_ID=t.C_Activity_ID AND t.AD_Language=" + DB.TO_STRING(language)+ ") WHERE o.C_Activity_ID=";
			else
				return "SELECT Value,Name FROM C_Activity WHERE C_Activity_ID=";
		} else if (   elementType.equals(ELEMENTTYPE_LocationFrom)
				   || elementType.equals(ELEMENTTYPE_LocationTo)) {
			return "SELECT City,Address1 FROM C_Location WHERE C_Location_ID=";
		} else if (elementType.equals(ELEMENTTYPE_Campaign)) {
			if (translated)
				return "SELECT Value,Name FROM C_Campaign o JOIN C_Campaign_Trl t ON (o.C_Campaign_ID=t.C_Campaign_ID AND t.AD_Language=" + DB.TO_STRING(language)+ ") WHERE o.C_Campaign_ID=";
			else
				return "SELECT Value,Name FROM C_Campaign WHERE C_Campaign_ID=";
		} else if (elementType.equals(ELEMENTTYPE_OrgTrx)) {
			return "SELECT Value,Name FROM AD_Org WHERE AD_Org_ID=";
		} else if (elementType.equals(ELEMENTTYPE_Project)) {
			return "SELECT Value,Name FROM C_Project WHERE C_Project_ID=";
		} else if (elementType.equals(ELEMENTTYPE_SalesRegion)) {
			if (translated)
				return "SELECT Value,Name FROM C_SalesRegion o JOIN C_SalesRegion_Trl t ON (o.C_SalesRegion_ID=t.C_SalesRegion_ID AND t.AD_Language=" + DB.TO_STRING(language)+ ") WHERE o.C_SalesRegion_ID="; // ADEMPIERE-119 / Freepath
			else
				return "SELECT Value,Name FROM C_SalesRegion WHERE C_SalesRegion_ID="; // ADEMPIERE-119 / Freepath
		//
		} else if (   elementType.equals(ELEMENTTYPE_UserColumn1)
				   || elementType.equals(ELEMENTTYPE_UserColumn2)) {
			return null;
		}
		//
		return "";
	}   //  getColumnName

	/**	Logger						*/
	private static CLogger		s_log = CLogger.getCLogger (MAcctSchemaElement.class);

	/**	Cache						*/
	private static CCache<Integer,MAcctSchemaElement[]> s_cache = new CCache<Integer,MAcctSchemaElement[]>(Table_Name, 10);
	
	
	/*************************************************************************
	 * Standard Constructor
	 * @param ctx context
	 * @param C_AcctSchema_Element_ID id
	 * @param trxName transaction
	 */
	public MAcctSchemaElement (Properties ctx, int C_AcctSchema_Element_ID, String trxName)
	{
		super (ctx, C_AcctSchema_Element_ID, trxName);
		if (C_AcctSchema_Element_ID == 0)
		{
			setIsBalanced (false);
			setIsMandatory (false);
		}
	}	//	MAcctSchemaElement

	/**
	 * Load Constructor
	 * @param ctx context
	 * @param rs result set
	 * @param trxName transaction
	 */	
	public MAcctSchemaElement (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAcctSchemaElement

	/**
	 * Parent Constructor
	 * @param as accounting schema
	 */
	public MAcctSchemaElement (MAcctSchema as)
	{
		this (as.getCtx(), 0, as.get_TrxName());
		setClientOrg(as);
		setC_AcctSchema_ID (as.getC_AcctSchema_ID());
	}	//	MAcctSchemaElement

	/**
	 * 
	 * @param copy
	 */
	public MAcctSchemaElement(MAcctSchemaElement copy)
	{
		this(Env.getCtx(), copy);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MAcctSchemaElement(Properties ctx, MAcctSchemaElement copy)
	{
		this(ctx, copy, (String)null);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MAcctSchemaElement(Properties ctx, MAcctSchemaElement copy, String trxName) 
	{
		super(ctx, 0, trxName);
		copyPO(copy);
		this.m_ColumnName = copy.m_ColumnName;
	}

	/** User Element Column Name		*/
	private String		m_ColumnName = null;
	
	/**
	 * Set Organization Type
	 * @param SeqNo sequence
	 * @param Name name 
	 * @param Org_ID id
	 */
	public void setTypeOrg (int SeqNo, String Name, int Org_ID)
	{
		setElementType (ELEMENTTYPE_Organization);
		setSeqNo(SeqNo);
		setName (Name);
		setOrg_ID(Org_ID);
	}	//	setTypeOrg

	/**
	 * Set Type Account
	 * @param SeqNo squence
	 * @param Name name
	 * @param C_Element_ID element
	 * @param C_ElementValue_ID element value
	 */
	public void setTypeAccount (int SeqNo, String Name, int C_Element_ID, int C_ElementValue_ID)
	{
		setElementType (ELEMENTTYPE_Account);
		setSeqNo(SeqNo);
		setName (Name);
		setC_Element_ID (C_Element_ID);
		setC_ElementValue_ID(C_ElementValue_ID);
	}	//	setTypeAccount

	/**
	 * Set Type BPartner
	 * @param SeqNo sequence
	 * @param Name name
	 * @param C_BPartner_ID id
	 */
	public void setTypeBPartner (int SeqNo, String Name, int C_BPartner_ID)
	{
		setElementType (ELEMENTTYPE_BPartner);
		setSeqNo(SeqNo);
		setName (Name);
		setC_BPartner_ID(C_BPartner_ID);
	}	//	setTypeBPartner

	/**
	 * Set Type Product
	 * @param SeqNo sequence
	 * @param Name name
	 * @param M_Product_ID id
	 */
	public void setTypeProduct (int SeqNo, String Name, int M_Product_ID)
	{
		setElementType (ELEMENTTYPE_Product);
		setSeqNo(SeqNo);
		setName (Name);
		setM_Product_ID(M_Product_ID);
	}	//	setTypeProduct
	
	/**
	 * Set Type Project
	 * @param SeqNo sequence
	 * @param Name name
	 * @param C_Project_ID id
	 */
	public void setTypeProject (int SeqNo, String Name, int C_Project_ID)
	{
		setElementType (ELEMENTTYPE_Project);
		setSeqNo(SeqNo);
		setName (Name);
		setC_Project_ID(C_Project_ID);
	}	//	setTypeProject

	/**
	 * Is Element Type
	 * @param elementType type
	 * @return ELEMENTTYPE type
	 */
	public boolean isElementType (String elementType)
	{
		if (elementType == null)
			return false;
		return elementType.equals(getElementType());
	}   //  isElementType

	/**
	 * Get Default element value
	 * @return default
	 */
	public int getDefaultValue()
	{
		String elementType = getElementType();
		int defaultValue = 0;
		if (elementType.equals(ELEMENTTYPE_Organization))
			defaultValue = getOrg_ID();
		else if (elementType.equals(ELEMENTTYPE_Account))
			defaultValue = getC_ElementValue_ID();
		else if (elementType.equals(ELEMENTTYPE_BPartner))
			defaultValue = getC_BPartner_ID();
		else if (elementType.equals(ELEMENTTYPE_Product))
			defaultValue = getM_Product_ID();
		else if (elementType.equals(ELEMENTTYPE_Activity))
			defaultValue = getC_Activity_ID();
		else if (elementType.equals(ELEMENTTYPE_LocationFrom))
			defaultValue = getC_Location_ID();
		else if (elementType.equals(ELEMENTTYPE_LocationTo))
			defaultValue = getC_Location_ID();
		else if (elementType.equals(ELEMENTTYPE_Campaign))
			defaultValue = getC_Campaign_ID();
		else if (elementType.equals(ELEMENTTYPE_OrgTrx))
			defaultValue = getOrg_ID();
		else if (elementType.equals(ELEMENTTYPE_Project))
			defaultValue = getC_Project_ID();
		else if (elementType.equals(ELEMENTTYPE_SalesRegion))
			defaultValue = getC_SalesRegion_ID();
		else if (elementType.equals(ELEMENTTYPE_UserElementList1))
			defaultValue = getC_ElementValue_ID();
		else if (elementType.equals(ELEMENTTYPE_UserElementList2))
			defaultValue = getC_ElementValue_ID();
		else if (elementType.equals(ELEMENTTYPE_UserColumn1))
			defaultValue = 0;
		else if (elementType.equals(ELEMENTTYPE_UserColumn2))
			defaultValue = 0;
		return defaultValue;
	}	//	getDefault


	/**
	 * Get Acct Fact ColumnName
	 * @return column name
	 */
	public String getColumnName()
	{
		String et = getElementType();
		return getColumnName(et);
	}	//	getColumnName

	/**
	 * Get Display ColumnName
	 * @return column name
	 */
	public String getDisplayColumnName()
	{
		String et = getElementType();
		if (ELEMENTTYPE_UserColumn1.equals(et) || ELEMENTTYPE_UserColumn2.equals(et))
		{
			if (m_ColumnName == null)
				m_ColumnName = MColumn.getColumnName(getCtx(), getAD_Column_ID());
			return m_ColumnName;
		}
		return getColumnName(et);
	}	//	getDisplayColumnName

	
	/**
	 * String representation
	 * @return info
	 */
	public String toString()
	{
		StringBuilder msgreturn = new StringBuilder("AcctSchemaElement[").append(get_ID()) 
				.append("-").append(getName()) 
				.append("(").append(getElementType()).append(")=").append(getDefaultValue())  
				.append(",Pos=").append(getSeqNo()).append("]");
		return msgreturn.toString();
	}   //  toString

	
	
	/**
	 * Before Save
	 * @param newRecord new
	 * @return true if it can be saved
	 */
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		String et = getElementType();
		if (isMandatory() &&
			(ELEMENTTYPE_UserElementList1.equals(et) || ELEMENTTYPE_UserElementList2.equals(et)
			|| ELEMENTTYPE_UserColumn1.equals(et) || ELEMENTTYPE_UserColumn2.equals(et)))
			setIsMandatory(false);
		else if (isMandatory())
		{
			String errorField = null;
			if (ELEMENTTYPE_Account.equals(et) && getC_ElementValue_ID() == 0)
				errorField = COLUMNNAME_C_ElementValue_ID;
			else if (ELEMENTTYPE_Activity.equals(et) && getC_Activity_ID() == 0)
				errorField = COLUMNNAME_C_Activity_ID;
			else if (ELEMENTTYPE_BPartner.equals(et) && getC_BPartner_ID() == 0)
				errorField = COLUMNNAME_C_BPartner_ID;
			else if (ELEMENTTYPE_Campaign.equals(et) && getC_Campaign_ID() == 0)
				errorField = COLUMNNAME_C_Campaign_ID;
			else if (ELEMENTTYPE_LocationFrom.equals(et) && getC_Location_ID() == 0)
				errorField = COLUMNNAME_C_Location_ID;
			else if (ELEMENTTYPE_LocationTo.equals(et) && getC_Location_ID() == 0)
				errorField = COLUMNNAME_C_Location_ID;
			else if (ELEMENTTYPE_Organization.equals(et) && getOrg_ID() == 0)
				errorField = COLUMNNAME_Org_ID;
			else if (ELEMENTTYPE_OrgTrx.equals(et) && getOrg_ID() == 0)
				errorField = COLUMNNAME_Org_ID;
			else if (ELEMENTTYPE_Product.equals(et) && getM_Product_ID() == 0)
				errorField = COLUMNNAME_M_Product_ID;
			else if (ELEMENTTYPE_Project.equals(et) && getC_Project_ID() == 0)
				errorField = COLUMNNAME_C_Project_ID;
			else if (ELEMENTTYPE_SalesRegion.equals(et) && getC_SalesRegion_ID() == 0)
				errorField = COLUMNNAME_C_SalesRegion_ID;
			if (errorField != null)
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), "@IsMandatory@: @" + errorField + "@"));
				return false;
			}
		}
		//
		if (getAD_Column_ID() == 0
			&& (ELEMENTTYPE_UserColumn1.equals(et) || ELEMENTTYPE_UserColumn2.equals(et)))
		{
			log.saveError("Error", Msg.parseTranslation(getCtx(), "@IsMandatory@: @AD_Column_ID@"));
			return false;
		}
		return true;
	}	//	beforeSave
	
	/**
	 * After Save
	 * @param newRecord new
	 * @param success success
	 * @return success
	 */
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		//	Default Value
		if (isMandatory() && is_ValueChanged(COLUMNNAME_IsMandatory))
		{
			if (ELEMENTTYPE_Activity.equals(getElementType()))
				updateData (COLUMNNAME_C_Activity_ID, getC_Activity_ID());
			else if (ELEMENTTYPE_BPartner.equals(getElementType()))
				updateData (COLUMNNAME_C_BPartner_ID, getC_BPartner_ID());
			else if (ELEMENTTYPE_Product.equals(getElementType()))
				updateData (COLUMNNAME_M_Product_ID, getM_Product_ID());
			else if (ELEMENTTYPE_Project.equals(getElementType()))
				updateData (COLUMNNAME_C_Project_ID, getC_Project_ID());
		}

		//	Clear Cache
		s_cache.clear();
		
		//	Resequence
		if (newRecord || is_ValueChanged(COLUMNNAME_SeqNo)){
			StringBuilder msguvd = new StringBuilder("AD_Client_ID=").append(getAD_Client_ID());
			MAccount.updateValueDescription(getCtx(), msguvd.toString(), get_TrxName());
		}
		return success;
	}	//	afterSave
	
	/**
	 * Update ValidCombination and Fact with mandatory value
	 * @param element element
	 * @param id new default
	 */
	private void updateData (String element, int id)
	{
		StringBuilder sql = new StringBuilder("UPDATE C_ValidCombination SET ").append(element).append("=").append(id)
			.append(" WHERE ").append(element).append(" IS NULL AND AD_Client_ID=").append(getAD_Client_ID());
		int noC = DB.executeUpdate(sql.toString(), get_TrxName());
		//
		sql = new StringBuilder("UPDATE Fact_Acct SET ").append(element).append("=").append(id)
			.append(" WHERE ").append(element).append(" IS NULL AND C_AcctSchema_ID=").append(getC_AcctSchema_ID());
		int noF = DB.executeUpdate(sql.toString(), get_TrxName());
		//
		if (log.isLoggable(Level.FINE)) log.fine("ValidCombination=" + noC + ", Fact=" + noF);
		//
		StringBuilder msguvd = new StringBuilder(element).append("=").append(id);
		MAccount.updateValueDescription(getCtx(),msguvd.toString(), get_TrxName());
	}	//	updateData

	/**
	 * After Delete
	 * @param success success
	 * @return success
	 */
	@Override
	protected boolean afterDelete (boolean success)
	{
		if (!success)
			return success;
		//	Update Account Info
		StringBuilder msguvd = new StringBuilder("AD_Client_ID=").append(getAD_Client_ID());
		MAccount.updateValueDescription(getCtx(),msguvd.toString(), get_TrxName());
		//
		s_cache.clear();
		return success;
	}	//	afterDelete

	@Override
	public MAcctSchemaElement markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}   //  AcctSchemaElement
