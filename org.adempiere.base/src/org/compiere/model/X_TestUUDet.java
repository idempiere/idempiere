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

/** Generated Model for TestUUDet
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="TestUUDet")
public class X_TestUUDet extends PO implements I_TestUUDet, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_TestUUDet (Properties ctx, String TestUUDet_UU, String trxName)
    {
      super (ctx, TestUUDet_UU, trxName);
      /** if (TestUUDet_UU == null)
        {
			setName (null);
			setTestUU_UU (null);
        } */
    }

    /** Standard Constructor */
    public X_TestUUDet (Properties ctx, String TestUUDet_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, TestUUDet_UU, trxName, virtualColumns);
      /** if (TestUUDet_UU == null)
        {
			setName (null);
			setTestUU_UU (null);
        } */
    }

    /** Load Constructor */
    public X_TestUUDet (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_TestUUDet[")
        .append(get_UUID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** AltTestUU_UU AD_Reference_ID=200236 */
	public static final int ALTTESTUU_UU_AD_Reference_ID=200236;
	/** Set Alternate Test UU.
		@param AltTestUU_UU Alternate Test UU
	*/
	public void setAltTestUU_UU (String AltTestUU_UU)
	{

		set_Value (COLUMNNAME_AltTestUU_UU, AltTestUU_UU);
	}

	/** Get Alternate Test UU.
		@return Alternate Test UU	  */
	public String getAltTestUU_UU()
	{
		return (String)get_Value(COLUMNNAME_AltTestUU_UU);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set TestUUDet_UU.
		@param TestUUDet_UU TestUUDet_UU
	*/
	public void setTestUUDet_UU (String TestUUDet_UU)
	{
		set_Value (COLUMNNAME_TestUUDet_UU, TestUUDet_UU);
	}

	/** Get TestUUDet_UU.
		@return TestUUDet_UU	  */
	public String getTestUUDet_UU()
	{
		return (String)get_Value(COLUMNNAME_TestUUDet_UU);
	}

	/** Set Test UU.
		@param TestUU_UU Test UU
	*/
	public void setTestUU_UU (String TestUU_UU)
	{
		set_Value (COLUMNNAME_TestUU_UU, TestUU_UU);
	}

	/** Get Test UU.
		@return Test UU	  */
	public String getTestUU_UU()
	{
		return (String)get_Value(COLUMNNAME_TestUU_UU);
	}

	/** TestUU_UUs AD_Reference_ID=200236 */
	public static final int TESTUU_UUS_AD_Reference_ID=200236;
	/** Set Multi Test UU.
		@param TestUU_UUs Multi Test UU
	*/
	public void setTestUU_UUs (String TestUU_UUs)
	{

		set_Value (COLUMNNAME_TestUU_UUs, TestUU_UUs);
	}

	/** Get Multi Test UU.
		@return Multi Test UU	  */
	public String getTestUU_UUs()
	{
		return (String)get_Value(COLUMNNAME_TestUU_UUs);
	}
}