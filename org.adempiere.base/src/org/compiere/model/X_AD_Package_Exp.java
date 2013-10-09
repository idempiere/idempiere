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
import org.compiere.util.KeyNamePair;

/** Generated Model for AD_Package_Exp
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_AD_Package_Exp extends PO implements I_AD_Package_Exp, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131009L;

    /** Standard Constructor */
    public X_AD_Package_Exp (Properties ctx, int AD_Package_Exp_ID, String trxName)
    {
      super (ctx, AD_Package_Exp_ID, trxName);
      /** if (AD_Package_Exp_ID == 0)
        {
			setAD_Package_Exp_ID (0);
			setIsExportDictionaryEntity (false);
// N
			setName (null);
			setPK_Version (null);
			setProcessing (false);
        } */
    }

    /** Load Constructor */
    public X_AD_Package_Exp (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_Package_Exp[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Package Exp..
		@param AD_Package_Exp_ID Package Exp.	  */
	public void setAD_Package_Exp_ID (int AD_Package_Exp_ID)
	{
		if (AD_Package_Exp_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Exp_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Package_Exp_ID, Integer.valueOf(AD_Package_Exp_ID));
	}

	/** Get Package Exp..
		@return Package Exp.	  */
	public int getAD_Package_Exp_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Package_Exp_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Package_Exp_UU.
		@param AD_Package_Exp_UU AD_Package_Exp_UU	  */
	public void setAD_Package_Exp_UU (String AD_Package_Exp_UU)
	{
		set_Value (COLUMNNAME_AD_Package_Exp_UU, AD_Package_Exp_UU);
	}

	/** Get AD_Package_Exp_UU.
		@return AD_Package_Exp_UU	  */
	public String getAD_Package_Exp_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_Exp_UU);
	}

	/** AD_Package_Type AD_Reference_ID=50001 */
	public static final int AD_PACKAGE_TYPE_AD_Reference_ID=50001;
	/** Local Transfer = L */
	public static final String AD_PACKAGE_TYPE_LocalTransfer = "L";
	/** Remote Transfer = R */
	public static final String AD_PACKAGE_TYPE_RemoteTransfer = "R";
	/** XML File = X */
	public static final String AD_PACKAGE_TYPE_XMLFile = "X";
	/** Set Package Type.
		@param AD_Package_Type Package Type	  */
	public void setAD_Package_Type (String AD_Package_Type)
	{

		set_Value (COLUMNNAME_AD_Package_Type, AD_Package_Type);
	}

	/** Get Package Type.
		@return Package Type	  */
	public String getAD_Package_Type () 
	{
		return (String)get_Value(COLUMNNAME_AD_Package_Type);
	}

	/** Set Date From.
		@param DateFrom 
		Starting date for a range
	  */
	public void setDateFrom (Timestamp DateFrom)
	{
		set_Value (COLUMNNAME_DateFrom, DateFrom);
	}

	/** Get Date From.
		@return Starting date for a range
	  */
	public Timestamp getDateFrom () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateFrom);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set EMail Address.
		@param EMail 
		Electronic Mail Address
	  */
	public void setEMail (String EMail)
	{
		set_Value (COLUMNNAME_EMail, EMail);
	}

	/** Get EMail Address.
		@return Electronic Mail Address
	  */
	public String getEMail () 
	{
		return (String)get_Value(COLUMNNAME_EMail);
	}

	/** Set File_Directory.
		@param File_Directory File_Directory	  */
	public void setFile_Directory (String File_Directory)
	{
		set_Value (COLUMNNAME_File_Directory, File_Directory);
	}

	/** Get File_Directory.
		@return File_Directory	  */
	public String getFile_Directory () 
	{
		return (String)get_Value(COLUMNNAME_File_Directory);
	}

	/** Set Instructions.
		@param Instructions Instructions	  */
	public void setInstructions (String Instructions)
	{
		set_Value (COLUMNNAME_Instructions, Instructions);
	}

	/** Get Instructions.
		@return Instructions	  */
	public String getInstructions () 
	{
		return (String)get_Value(COLUMNNAME_Instructions);
	}

	/** Set Export Dictionary Entity.
		@param IsExportDictionaryEntity Export Dictionary Entity	  */
	public void setIsExportDictionaryEntity (boolean IsExportDictionaryEntity)
	{
		set_Value (COLUMNNAME_IsExportDictionaryEntity, Boolean.valueOf(IsExportDictionaryEntity));
	}

	/** Get Export Dictionary Entity.
		@return Export Dictionary Entity	  */
	public boolean isExportDictionaryEntity () 
	{
		Object oo = get_Value(COLUMNNAME_IsExportDictionaryEntity);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Package Version.
		@param PK_Version Package Version	  */
	public void setPK_Version (String PK_Version)
	{
		set_Value (COLUMNNAME_PK_Version, PK_Version);
	}

	/** Get Package Version.
		@return Package Version	  */
	public String getPK_Version () 
	{
		return (String)get_Value(COLUMNNAME_PK_Version);
	}

	/** Set Processed.
		@param Processed 
		The document has been processed
	  */
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed () 
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
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

	/** ReleaseNo AD_Reference_ID=50002 */
	public static final int RELEASENO_AD_Reference_ID=50002;
	/** Release 2.5.2a = Release 2.5.2a */
	public static final String RELEASENO_Release252a = "Release 2.5.2a";
	/** Release 2.5.2b = Release 2.5.2b */
	public static final String RELEASENO_Release252b = "Release 2.5.2b";
	/** Release 2.5.2c = Release 2.5.2c */
	public static final String RELEASENO_Release252c = "Release 2.5.2c";
	/** Release 2.5.2d = Release 2.5.2d */
	public static final String RELEASENO_Release252d = "Release 2.5.2d";
	/** Release 2.5.2e = Release 2.5.2e */
	public static final String RELEASENO_Release252e = "Release 2.5.2e";
	/** Release 2.5.3a = Release 2.5.3a */
	public static final String RELEASENO_Release253a = "Release 2.5.3a";
	/** Release 2.5.3b = Release 2.5.3b */
	public static final String RELEASENO_Release253b = "Release 2.5.3b";
	/** No specific release = all */
	public static final String RELEASENO_NoSpecificRelease = "all";
	/** Release 3.1.0 = Release 3.1.0 */
	public static final String RELEASENO_Release310 = "Release 3.1.0";
	/** Release 3.2.0 = Release 3.2.0 */
	public static final String RELEASENO_Release320 = "Release 3.2.0";
	/** Release 3.3.0 = Release 3.3.0 */
	public static final String RELEASENO_Release330 = "Release 3.3.0";
	/** Set Release No.
		@param ReleaseNo 
		Internal Release Number
	  */
	public void setReleaseNo (String ReleaseNo)
	{

		set_Value (COLUMNNAME_ReleaseNo, ReleaseNo);
	}

	/** Get Release No.
		@return Internal Release Number
	  */
	public String getReleaseNo () 
	{
		return (String)get_Value(COLUMNNAME_ReleaseNo);
	}

	/** Set User Name.
		@param UserName User Name	  */
	public void setUserName (String UserName)
	{
		set_Value (COLUMNNAME_UserName, UserName);
	}

	/** Get User Name.
		@return User Name	  */
	public String getUserName () 
	{
		return (String)get_Value(COLUMNNAME_UserName);
	}

	/** Set Version.
		@param Version 
		Version of the table definition
	  */
	public void setVersion (String Version)
	{
		set_Value (COLUMNNAME_Version, Version);
	}

	/** Get Version.
		@return Version of the table definition
	  */
	public String getVersion () 
	{
		return (String)get_Value(COLUMNNAME_Version);
	}
}