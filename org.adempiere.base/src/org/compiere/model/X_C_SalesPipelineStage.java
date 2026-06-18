/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for C_SalesPipelineStage
 *  @author iDempiere (generated)
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="C_SalesPipelineStage")
public class X_C_SalesPipelineStage extends PO implements I_C_SalesPipelineStage, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20260608L;

    /** Standard Constructor */
    public X_C_SalesPipelineStage (Properties ctx, int C_SalesPipelineStage_ID, String trxName)
    {
      super (ctx, C_SalesPipelineStage_ID, trxName);
      /** if (C_SalesPipelineStage_ID == 0)
        {
			setC_SalesPipeline_ID (0);
			setC_SalesStage_ID (0);
			setProbability (Env.ZERO);
			setSeqNo (0);
// @SQL=SELECT NVL(MAX(SeqNo), 0) + 10 AS DefaultValue FROM C_SalesPipelineStage WHERE C_SalesPipeline_ID =@C_SalesPipeline_ID@
        } */
    }

    /** Standard Constructor */
    public X_C_SalesPipelineStage (Properties ctx, int C_SalesPipelineStage_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_SalesPipelineStage_ID, trxName, virtualColumns);
      /** if (C_SalesPipelineStage_ID == 0)
        {
			setC_SalesPipeline_ID (0);
			setC_SalesStage_ID (0);
			setProbability (Env.ZERO);
			setSeqNo (0);
// @SQL=SELECT NVL(MAX(SeqNo), 0) + 10 AS DefaultValue FROM C_SalesPipelineStage WHERE C_SalesPipeline_ID =@C_SalesPipeline_ID@
        } */
    }

    /** Standard Constructor */
    public X_C_SalesPipelineStage (Properties ctx, String C_SalesPipelineStage_UU, String trxName)
    {
      super (ctx, C_SalesPipelineStage_UU, trxName);
      /** if (C_SalesPipelineStage_UU == null)
        {
			setC_SalesPipeline_ID (0);
			setC_SalesStage_ID (0);
			setProbability (Env.ZERO);
			setSeqNo (0);
// @SQL=SELECT NVL(MAX(SeqNo), 0) + 10 AS DefaultValue FROM C_SalesPipelineStage WHERE C_SalesPipeline_ID =@C_SalesPipeline_ID@
        } */
    }

    /** Standard Constructor */
    public X_C_SalesPipelineStage (Properties ctx, String C_SalesPipelineStage_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, C_SalesPipelineStage_UU, trxName, virtualColumns);
      /** if (C_SalesPipelineStage_UU == null)
        {
			setC_SalesPipeline_ID (0);
			setC_SalesStage_ID (0);
			setProbability (Env.ZERO);
			setSeqNo (0);
// @SQL=SELECT NVL(MAX(SeqNo), 0) + 10 AS DefaultValue FROM C_SalesPipelineStage WHERE C_SalesPipeline_ID =@C_SalesPipeline_ID@
        } */
    }

    /** Load Constructor */
    public X_C_SalesPipelineStage (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuilder sb = new StringBuilder ("X_C_SalesPipelineStage[")
        .append(get_UUID()).append("]");
      return sb.toString();
    }

	/** Set C_SalesPipelineStage_UU.
		@param C_SalesPipelineStage_UU C_SalesPipelineStage_UU
	*/
	public void setC_SalesPipelineStage_UU (String C_SalesPipelineStage_UU)
	{
		set_Value (COLUMNNAME_C_SalesPipelineStage_UU, C_SalesPipelineStage_UU);
	}

	/** Get C_SalesPipelineStage_UU.
		@return C_SalesPipelineStage_UU	  */
	public String getC_SalesPipelineStage_UU()
	{
		return (String)get_Value(COLUMNNAME_C_SalesPipelineStage_UU);
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_SalesPipeline getC_SalesPipeline() throws RuntimeException
	{
		return (org.compiere.model.I_C_SalesPipeline)MTable.get(getCtx(), org.compiere.model.I_C_SalesPipeline.Table_ID)
			.getPO(getC_SalesPipeline_ID(), get_TrxName());
	}

	/** Set Sales Pipeline.
		@param C_SalesPipeline_ID Defines a sales pipeline (e.g. &quot;Standard Sales&quot;, &quot;Complex Project&quot;, etc.)
	*/
	public void setC_SalesPipeline_ID (int C_SalesPipeline_ID)
	{
		if (C_SalesPipeline_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_SalesPipeline_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_SalesPipeline_ID, Integer.valueOf(C_SalesPipeline_ID));
	}

	/** Get Sales Pipeline.
		@return Defines a sales pipeline (e.g. &quot;Standard Sales&quot;, &quot;Complex Project&quot;, etc.)
	  */
	public int getC_SalesPipeline_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_SalesPipeline_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_SalesStage getC_SalesStage() throws RuntimeException
	{
		return (org.compiere.model.I_C_SalesStage)MTable.get(getCtx(), org.compiere.model.I_C_SalesStage.Table_ID)
			.getPO(getC_SalesStage_ID(), get_TrxName());
	}

	/** Set Sales Stage.
		@param C_SalesStage_ID Stages of the sales process
	*/
	public void setC_SalesStage_ID (int C_SalesStage_ID)
	{
		if (C_SalesStage_ID < 1)
			set_Value (COLUMNNAME_C_SalesStage_ID, null);
		else
			set_Value (COLUMNNAME_C_SalesStage_ID, Integer.valueOf(C_SalesStage_ID));
	}

	/** Get Sales Stage.
		@return Stages of the sales process
	  */
	public int getC_SalesStage_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_SalesStage_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Probability.
		@param Probability Probability
	*/
	public void setProbability (BigDecimal Probability)
	{
		set_Value (COLUMNNAME_Probability, Probability);
	}

	/** Get Probability.
		@return Probability	  */
	public BigDecimal getProbability()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Probability);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Sequence.
		@param SeqNo Method of ordering records; lowest number comes first
	*/
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}