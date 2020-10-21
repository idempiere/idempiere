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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.DBException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  Product Attribute Set
 *
 *	@author Jorg Janke
 *	@version $Id: MAttributeSet.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 *
 * @author Teo Sarca, www.arhipac.ro
 *			<li>FR [ 2214883 ] Remove SQL code and Replace for Query
 */
public class MAttributeSet extends X_M_AttributeSet implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6570475541239019293L;

	/**
	 * 	Get MAttributeSet from Cache
	 *	@param M_AttributeSet_ID id
	 *	@return MAttributeSet
	 */
	public static MAttributeSet get (int M_AttributeSet_ID)
	{
		return get(Env.getCtx(), M_AttributeSet_ID);
	}
	
	/**
	 * 	Get MAttributeSet from Cache
	 *	@param ctx context
	 *	@param M_AttributeSet_ID id
	 *	@return MAttributeSet
	 */
	public static MAttributeSet get (Properties ctx, int M_AttributeSet_ID)
	{
		Integer key = Integer.valueOf(M_AttributeSet_ID);
		MAttributeSet retValue = s_cache.get (ctx, key, e -> new MAttributeSet(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MAttributeSet (ctx, M_AttributeSet_ID, (String)null);
		if (retValue.get_ID () == M_AttributeSet_ID)
		{
			s_cache.put (key, retValue, e -> new MAttributeSet(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get updateable copy of MAttributeSet from cache
	 * @param ctx
	 * @param M_AttributeSet_ID
	 * @return MAttributeSet
	 */
	public static MAttributeSet getCopy(Properties ctx, int M_AttributeSet_ID, String trxName)
	{
		MAttributeSet mas = get(M_AttributeSet_ID);
		if (mas != null)
			mas = new MAttributeSet(ctx, mas, trxName);
		return mas;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MAttributeSet> s_cache
		= new ImmutableIntPOCache<Integer,MAttributeSet> (Table_Name, 20);
	
	
	/**
	 * 	Standard constructor
	 *	@param ctx context
	 *	@param M_AttributeSet_ID id
	 *	@param trxName transaction
	 */
	public MAttributeSet (Properties ctx, int M_AttributeSet_ID, String trxName)
	{
		super (ctx, M_AttributeSet_ID, trxName);
		if (M_AttributeSet_ID == 0)
		{
		//	setName (null);
			setIsGuaranteeDate (false);
			setIsGuaranteeDateMandatory (false);
			setIsLot (false);
			setIsLotMandatory (false);
			setIsSerNo (false);
			setIsSerNoMandatory (false);
			setIsInstanceAttribute(false);
			setMandatoryType (MANDATORYTYPE_NotMandatory);
		}
	}	//	MAttributeSet

	/**
	 * 	Load constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAttributeSet (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAttributeSet

	/**
	 * 
	 * @param copy
	 */
	public MAttributeSet(MAttributeSet copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MAttributeSet(Properties ctx, MAttributeSet copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MAttributeSet(Properties ctx, MAttributeSet copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_instanceAttributes = copy.m_instanceAttributes != null ? Arrays.stream(copy.m_instanceAttributes).map(e -> {return new MAttribute(ctx, e, trxName);}).toArray(MAttribute[]::new) : null;
		this.m_productAttributes = copy.m_productAttributes != null ? Arrays.stream(copy.m_productAttributes).map(e -> {return new MAttribute(ctx, e, trxName);}).toArray(MAttribute[]::new) : null;
		this.m_excludes = copy.m_excludes != null ? Arrays.copyOf(copy.m_excludes, copy.m_excludes.length) : null;
		this.m_excludeLots = copy.m_excludeLots != null ? Arrays.copyOf(copy.m_excludeLots, copy.m_excludeLots.length) : null;
		this.m_excludeSerNos = copy.m_excludeSerNos != null ? Arrays.copyOf(copy.m_excludeSerNos, copy.m_excludeSerNos.length) : null;
	}

	/**	Instance Attributes					*/
	private MAttribute[]		m_instanceAttributes = null;
	/**	Instance Attributes					*/
	private MAttribute[]		m_productAttributes = null;
	
	/** Entry Exclude						*/
	private MAttributeSetExclude[] m_excludes = null;
	/** Lot create Exclude						*/
	private MLotCtlExclude[] 	m_excludeLots = null;
	/** Serial No create Exclude				*/
	private MSerNoCtlExclude[]	m_excludeSerNos = null;

	/**
	 * 	Get Attribute Array
	 * 	@param instanceAttributes true if for instance
	 *	@return instance or product attribute array
	 */
	public MAttribute[] getMAttributes (boolean instanceAttributes)
	{
		if ((m_instanceAttributes == null && instanceAttributes)
			|| m_productAttributes == null && !instanceAttributes)
		{
			String sql = "SELECT mau.M_Attribute_ID "
				+ "FROM M_AttributeUse mau"
				+ " INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) "
				+ "WHERE mau.IsActive='Y' AND ma.IsActive='Y'"
				+ " AND mau.M_AttributeSet_ID=? AND ma.IsInstanceAttribute=? "	//	#1,2
				+ "ORDER BY mau.SeqNo";
			ArrayList<MAttribute> list = new ArrayList<MAttribute>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, get_TrxName());
				pstmt.setInt(1, getM_AttributeSet_ID());
				pstmt.setString(2, instanceAttributes ? "Y" : "N");
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					MAttribute ma = new MAttribute (getCtx(), rs.getInt(1), get_TrxName());
					list.add (ma);
				}
			}
			catch (SQLException ex)
			{
				throw new DBException(ex, sql);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
			
			//	Differentiate attributes
			if (instanceAttributes)
			{
				m_instanceAttributes = new MAttribute[list.size()];
				list.toArray (m_instanceAttributes);
				if (m_instanceAttributes.length > 0 && is_Immutable())
					Arrays.stream(m_instanceAttributes).forEach(e -> e.markImmutable());
			}
			else
			{
				m_productAttributes = new MAttribute[list.size()];
				list.toArray (m_productAttributes);
				if (m_productAttributes.length > 0 && is_Immutable())
					Arrays.stream(m_productAttributes).forEach(e -> e.markImmutable());
			}
		}
		//
		if (instanceAttributes)
		{
			if (isInstanceAttribute() != m_instanceAttributes.length > 0)
				setIsInstanceAttribute(m_instanceAttributes.length > 0);
		}
		
		//	Return
		if (instanceAttributes)
			return m_instanceAttributes;
		return m_productAttributes;
	}	//	getMAttributes

	/**
	 * 	Something is Mandatory
	 *	@return true if something is mandatory
	 */
	public boolean isMandatory()
	{
		return !MANDATORYTYPE_NotMandatory.equals(getMandatoryType())
			|| isLotMandatory()
			|| isSerNoMandatory()
			|| isGuaranteeDateMandatory();
	}	//	isMandatory
	
	/**
	 * 	Is always mandatory
	 *	@return mandatory 
	 */
	public boolean isMandatoryAlways()
	{
		return MANDATORYTYPE_AlwaysMandatory.equals(getMandatoryType());
	}	//	isMandatoryAlways
	
	/**
	 * 	Is Mandatory when Shipping
	 *	@return true if required for shipping
	 */
	public boolean isMandatoryShipping()
	{
		return MANDATORYTYPE_WhenShipping.equals(getMandatoryType());
	}	//	isMandatoryShipping
	
	/**
	 * 	Exclude column entry
	 *	@param AD_Column_ID column
	 *	@param isSOTrx sales order
	 *	@return true if excluded
	 */
	public boolean excludeEntry (int AD_Column_ID, boolean isSOTrx)
	{
		MColumn column = MColumn.get(getCtx(), AD_Column_ID);
		return excludeTableEntry(column.getAD_Table_ID(), isSOTrx);
	}	//	excludeEntry
	
	/**
	 * 	Exclude table entry
	 *	@param AD_Table_ID column
	 *	@param isSOTrx sales order
	 *	@return true if excluded
	 */
	public boolean excludeTableEntry (int AD_Table_ID, boolean isSOTrx)
	{
		loadExcludes();
		//	Find it
		if (m_excludes != null && m_excludes.length > 0)
		{
			for (int i = 0; i < m_excludes.length; i++)
			{
				if (m_excludes[i].getAD_Table_ID() == AD_Table_ID
					&& m_excludes[i].isSOTrx() == isSOTrx)
					return true;
			}
		}
		return false;
	}	//	excludeTableEntry

	private void loadExcludes() {
		if (m_excludes == null)
		{
			final String whereClause = MAttributeSetExclude.COLUMNNAME_M_AttributeSet_ID+"=?";
			List<MAttributeSetExclude> list = new Query(getCtx(), MAttributeSetExclude.Table_Name, whereClause, null)
				.setParameters(get_ID())
				.setOnlyActiveRecords(true)
				.list();
			m_excludes = new MAttributeSetExclude[list.size ()];
			list.toArray (m_excludes);
		}
	}
	
	/**
	 * 	Exclude Lot creation
	 *	@param AD_Column_ID column
	 *	@param isSOTrx SO
	 *	@return true if excluded
	 */
	public boolean isExcludeLot (int AD_Column_ID, boolean isSOTrx)
	{
		if (getM_LotCtl_ID() == 0)
			return true;
		if (m_excludeLots == null)
		{
			final String whereClause = MLotCtlExclude.COLUMNNAME_M_LotCtl_ID+"=?";
			List<MLotCtlExclude> list = new Query(getCtx(), MLotCtlExclude.Table_Name, whereClause, null)
			.setParameters(getM_LotCtl_ID())
			.setOnlyActiveRecords(true)
			.list();
			m_excludeLots = new MLotCtlExclude[list.size ()];
			list.toArray (m_excludeLots);
		}
		//	Find it
		if (m_excludeLots != null && m_excludeLots.length > 0)
		{
			MColumn column = MColumn.get(getCtx(), AD_Column_ID);
			for (int i = 0; i < m_excludeLots.length; i++)
			{
				if (m_excludeLots[i].getAD_Table_ID() == column.getAD_Table_ID()
					&& m_excludeLots[i].isSOTrx() == isSOTrx)
					return true;
			}
		}
		return false;
	}	//	isExcludeLot
	
	/**
	 *	Exclude SerNo creation
	 *	@param AD_Column_ID column
	 *	@param isSOTrx SO
	 *	@return true if excluded
	 */
	public boolean isExcludeSerNo (int AD_Column_ID, boolean isSOTrx)
	{
		if (getM_SerNoCtl_ID() == 0)
			return true;
		if (m_excludeSerNos == null)
		{
			final String whereClause = MSerNoCtlExclude.COLUMNNAME_M_SerNoCtl_ID+"=?";
			List<MSerNoCtlExclude> list = new Query(getCtx(), MSerNoCtlExclude.Table_Name, whereClause, null)
			.setParameters(getM_SerNoCtl_ID())
			.setOnlyActiveRecords(true)
			.list();
			m_excludeSerNos = new MSerNoCtlExclude[list.size ()];
			list.toArray (m_excludeSerNos);
		}
		//	Find it
		if (m_excludeSerNos != null && m_excludeSerNos.length > 0)
		{
			MColumn column = MColumn.get(getCtx(), AD_Column_ID);
			for (int i = 0; i < m_excludeSerNos.length; i++)
			{
				if (m_excludeSerNos[i].getAD_Table_ID() == column.getAD_Table_ID()
					&& m_excludeSerNos[i].isSOTrx() == isSOTrx)
					return true;
			}
		}
		return false;
	}	//	isExcludeSerNo

	/**
	 * 	Get Lot Char Start
	 *	@return defined or \u00ab 
	 */
	public String getLotCharStart()
	{
		String s = super.getLotCharSOverwrite ();
		if (s != null && s.length() == 1 && !s.equals(" "))
			return s;
		return "\u00ab";
	}	//	getLotCharStart

	/**
	 * 	Get Lot Char End
	 *	@return defined or \u00bb 
	 */
	public String getLotCharEnd()
	{
		String s = super.getLotCharEOverwrite ();
		if (s != null && s.length() == 1 && !s.equals(" "))
			return s;
		return "\u00bb";
	}	//	getLotCharEnd
	
	/**
	 * 	Get SerNo Char Start
	 *	@return defined or #
	 */
	public String getSerNoCharStart()
	{
		String s = super.getSerNoCharSOverwrite ();
		if (s != null && s.length() == 1 && !s.equals(" "))
			return s;
		return "#";
	}	//	getSerNoCharStart

	/**
	 * 	Get SerNo Char End
	 *	@return defined or none
	 */
	public String getSerNoCharEnd()
	{
		String s = super.getSerNoCharEOverwrite ();
		if (s != null && s.length() == 1 && !s.equals(" "))
			return s;
		return "";
	}	//	getSerNoCharEnd
	
	
	/**
	 * 	Before Save.
	 * 	- set instance attribute flag
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (!isInstanceAttribute()
			&& (isSerNo() || isLot() || isGuaranteeDate()) )
			setIsInstanceAttribute(true);
		return true;
	}	//	beforeSave
	
	
	/**
	 * 	After Save.
	 * 	- Verify Instance Attribute
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		//	Set Instance Attribute
		if (!success)
			return success;
		if (!isInstanceAttribute())
		{
			StringBuilder sql = new StringBuilder("UPDATE M_AttributeSet mas")
				.append(" SET IsInstanceAttribute='Y' ")
				.append("WHERE M_AttributeSet_ID=").append(getM_AttributeSet_ID())
				.append(" AND IsInstanceAttribute='N'")
				.append(" AND (IsSerNo='Y' OR IsLot='Y' OR IsGuaranteeDate='Y'")
					.append(" OR EXISTS (SELECT * FROM M_AttributeUse mau")
						.append(" INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) ")
						.append("WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID")
						.append(" AND mau.IsActive='Y' AND ma.IsActive='Y'")
						.append(" AND ma.IsInstanceAttribute='Y')")
						.append(")");
			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (no != 0)
			{
				log.warning("Set Instance Attribute");
				setIsInstanceAttribute(true);
			}
		}
		//	Reset Instance Attribute
		if (isInstanceAttribute() && !isSerNo() && !isLot() && !isGuaranteeDate())
		{
			StringBuilder sql = new StringBuilder("UPDATE M_AttributeSet mas")
				.append(" SET IsInstanceAttribute='N' ")
				.append("WHERE M_AttributeSet_ID=").append(getM_AttributeSet_ID())
				.append(" AND IsInstanceAttribute='Y'")
				.append("	AND IsSerNo='N' AND IsLot='N' AND IsGuaranteeDate='N'")
				.append(" AND NOT EXISTS (SELECT * FROM M_AttributeUse mau")
					.append(" INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) ")
					.append("WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID")
					.append(" AND mau.IsActive='Y' AND ma.IsActive='Y'")
					.append(" AND ma.IsInstanceAttribute='Y')");
			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (no != 0)
			{
				log.warning("Reset Instance Attribute");
				setIsInstanceAttribute(false);
			}
		}
		return success;
	}	//	afterSave
	
	@Override
	public MAttributeSet markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_instanceAttributes != null && m_instanceAttributes.length > 0)
			Arrays.stream(m_instanceAttributes).forEach(e -> e.markImmutable());
		if (m_productAttributes != null && m_productAttributes.length > 0)
			Arrays.stream(m_productAttributes).forEach(e -> e.markImmutable());
		return this;
	}

}	//	MAttributeSet
