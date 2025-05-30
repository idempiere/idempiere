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

import java.sql.ResultSet;
import java.util.Properties;

/** Generated Model for AD_TreeNodeCMC
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_TreeNodeCMC")
public class X_AD_TreeNodeCMC extends PO implements I_AD_TreeNodeCMC, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_TreeNodeCMC (Properties ctx, int AD_TreeNodeCMC_ID, String trxName)
    {
      super (ctx, AD_TreeNodeCMC_ID, trxName);
      /** if (AD_TreeNodeCMC_ID == 0)
        {
			setAD_Tree_ID (0);
			setNode_ID (0);
			setParent_ID (0);
			setSeqNo (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TreeNodeCMC (Properties ctx, int AD_TreeNodeCMC_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TreeNodeCMC_ID, trxName, virtualColumns);
      /** if (AD_TreeNodeCMC_ID == 0)
        {
			setAD_Tree_ID (0);
			setNode_ID (0);
			setParent_ID (0);
			setSeqNo (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TreeNodeCMC (Properties ctx, String AD_TreeNodeCMC_UU, String trxName)
    {
      super (ctx, AD_TreeNodeCMC_UU, trxName);
      /** if (AD_TreeNodeCMC_UU == null)
        {
			setAD_Tree_ID (0);
			setNode_ID (0);
			setParent_ID (0);
			setSeqNo (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TreeNodeCMC (Properties ctx, String AD_TreeNodeCMC_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TreeNodeCMC_UU, trxName, virtualColumns);
      /** if (AD_TreeNodeCMC_UU == null)
        {
			setAD_Tree_ID (0);
			setNode_ID (0);
			setParent_ID (0);
			setSeqNo (0);
        } */
    }

    /** Load Constructor */
    public X_AD_TreeNodeCMC (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 7 - System - Client - Org
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
      StringBuilder sb = new StringBuilder ("X_AD_TreeNodeCMC[")
        .append(get_UUID()).append("]");
      return sb.toString();
    }

	/** Set AD_TreeNodeCMC_UU.
		@param AD_TreeNodeCMC_UU AD_TreeNodeCMC_UU
	*/
	public void setAD_TreeNodeCMC_UU (String AD_TreeNodeCMC_UU)
	{
		set_Value (COLUMNNAME_AD_TreeNodeCMC_UU, AD_TreeNodeCMC_UU);
	}

	/** Get AD_TreeNodeCMC_UU.
		@return AD_TreeNodeCMC_UU	  */
	public String getAD_TreeNodeCMC_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_TreeNodeCMC_UU);
	}

	public org.compiere.model.I_AD_Tree getAD_Tree() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Tree)MTable.get(getCtx(), org.compiere.model.I_AD_Tree.Table_ID)
			.getPO(getAD_Tree_ID(), get_TrxName());
	}

	/** Set Tree.
		@param AD_Tree_ID Identifies a Tree
	*/
	public void setAD_Tree_ID (int AD_Tree_ID)
	{
		if (AD_Tree_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Tree_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Tree_ID, Integer.valueOf(AD_Tree_ID));
	}

	/** Get Tree.
		@return Identifies a Tree
	  */
	public int getAD_Tree_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Tree_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Node.
		@param Node_ID Node
	*/
	public void setNode_ID (int Node_ID)
	{
		if (Node_ID < 0)
			set_ValueNoCheck (COLUMNNAME_Node_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_Node_ID, Integer.valueOf(Node_ID));
	}

	/** Get Node.
		@return Node	  */
	public int getNode_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Node_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Parent.
		@param Parent_ID Parent of Entity
	*/
	public void setParent_ID (int Parent_ID)
	{
		if (Parent_ID < 1)
			set_Value (COLUMNNAME_Parent_ID, null);
		else
			set_Value (COLUMNNAME_Parent_ID, Integer.valueOf(Parent_ID));
	}

	/** Get Parent.
		@return Parent of Entity
	  */
	public int getParent_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Parent_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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