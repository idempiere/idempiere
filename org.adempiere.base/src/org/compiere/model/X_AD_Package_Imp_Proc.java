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
import java.sql.Timestamp;
import java.util.Properties;

/** Generated Model for AD_Package_Imp_Proc
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_AD_Package_Imp_Proc extends PO implements I_AD_Package_Imp_Proc, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_AD_Package_Imp_Proc (Properties ctx, int AD_Package_Imp_Proc_ID, String trxName)
    {
      super (ctx, AD_Package_Imp_Proc_ID, trxName);
      /** if (AD_Package_Imp_Proc_ID == 0)
        {
			setAD_Package_Imp_Proc_ID (0);
			setAD_Package_Source_Type (null);
// 'File'
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Package_Imp_Proc (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client 
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
      StringBuffer sb = new StringBuffer ("X_AD_Package_Imp_Proc[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Update System Maintained Application Dictionary.
		@param AD_Override_Dict Update System Maintained Application Dictionary	  */
	public void setAD_Override_Dict (boolean AD_Override_Dict)
	{
		set_Value (COLUMNNAME_AD_Override_Dict, Boolean.valueOf(AD_Override_Dict));
	}

	/** Get Update System Maintained Application Dictionary.
		@return Update System Maintained Application Dictionary	  */
	public boolean isAD_Override_Dict () 
	{
		Object oo = get_Value(COLUMNNAME_AD_Override_Dict);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Package Directory.
		@param AD_Package_Dir 
		Package directory, default to AdempiereHome/packages
	  */
	public void setAD_Package_Dir (String AD_Package_Dir)
	{
		set_Value (COLUMNNAME_AD_Package_Dir, AD_Package_Dir);
	}

	/** Get Package Directory.
		@return Package directory, default to AdempiereHome/packages
	  */
	public String getAD_Package_Dir () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_Dir);
	}

	/** Set Package Imp. Proc..
		@param AD_Package_Imp_Proc_ID Package Imp. Proc.	  */
	public void setAD_Package_Imp_Proc_ID (int AD_Package_Imp_Proc_ID)
	{
		if (AD_Package_Imp_Proc_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Imp_Proc_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Imp_Proc_ID, Integer.valueOf(AD_Package_Imp_Proc_ID));
	}

	/** Get Package Imp. Proc..
		@return Package Imp. Proc.	  */
	public int getAD_Package_Imp_Proc_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Package_Imp_Proc_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Package_Imp_Proc_UU.
		@param AD_Package_Imp_Proc_UU AD_Package_Imp_Proc_UU	  */
	public void setAD_Package_Imp_Proc_UU (String AD_Package_Imp_Proc_UU)
	{
		set_Value (COLUMNNAME_AD_Package_Imp_Proc_UU, AD_Package_Imp_Proc_UU);
	}

	/** Get AD_Package_Imp_Proc_UU.
		@return AD_Package_Imp_Proc_UU	  */
	public String getAD_Package_Imp_Proc_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_Imp_Proc_UU);
	}

	/** Set Package Source.
		@param AD_Package_Source 
		Fully qualified package source file name
	  */
	public void setAD_Package_Source (String AD_Package_Source)
	{
		set_Value (COLUMNNAME_AD_Package_Source, AD_Package_Source);
	}

	/** Get Package Source.
		@return Fully qualified package source file name
	  */
	public String getAD_Package_Source () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_Source);
	}

	/** AD_Package_Source_Type AD_Reference_ID=50005 */
	public static final int AD_PACKAGE_SOURCE_TYPE_AD_Reference_ID=50005;
	/** File = File */
	public static final String AD_PACKAGE_SOURCE_TYPE_File = "File";
	/** WebService = WS */
	public static final String AD_PACKAGE_SOURCE_TYPE_WebService = "WS";
	/** Set Package Source Type.
		@param AD_Package_Source_Type 
		Type of package source - file, ftp, webservice etc
	  */
	public void setAD_Package_Source_Type (String AD_Package_Source_Type)
	{

		set_Value (COLUMNNAME_AD_Package_Source_Type, AD_Package_Source_Type);
	}

	/** Get Package Source Type.
		@return Type of package source - file, ftp, webservice etc
	  */
	public String getAD_Package_Source_Type () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_Source_Type);
	}

	/** Set Date Processed.
		@param DateProcessed Date Processed	  */
	public void setDateProcessed (Timestamp DateProcessed)
	{
		set_Value (COLUMNNAME_DateProcessed, DateProcessed);
	}

	/** Get Date Processed.
		@return Date Processed	  */
	public Timestamp getDateProcessed () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateProcessed);
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set Process Message.
		@param P_Msg Process Message	  */
	public void setP_Msg (String P_Msg)
	{
		set_Value (COLUMNNAME_P_Msg, P_Msg);
	}

	/** Get Process Message.
		@return Process Message	  */
	public String getP_Msg () 
	{
		return (String)get_Value(COLUMNNAME_P_Msg);
	}

	/** Set Process Now.
		@param Processing Process Now	  */
	public void setProcessing (boolean Processing)
	{
		set_Value (COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}

	/** Get Process Now.
		@return Process Now	  */
	public boolean isProcessing () 
	{
		Object oo = get_Value(COLUMNNAME_Processing);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}
}