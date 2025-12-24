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

/** Generated Model for AD_AttachmentFile
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="AD_AttachmentFile")
public class X_AD_AttachmentFile extends PO implements I_AD_AttachmentFile, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20251223L;

    /** Standard Constructor */
    public X_AD_AttachmentFile (Properties ctx, String AD_AttachmentFile_UU, String trxName)
    {
      super (ctx, AD_AttachmentFile_UU, trxName);
      /** if (AD_AttachmentFile_UU == null)
        {
        } */
    }

    /** Standard Constructor */
    public X_AD_AttachmentFile (Properties ctx, String AD_AttachmentFile_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_AttachmentFile_UU, trxName, virtualColumns);
      /** if (AD_AttachmentFile_UU == null)
        {
        } */
    }

    /** Load Constructor */
    public X_AD_AttachmentFile (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_AttachmentFile[")
        .append(get_UUID()).append("]");
      return sb.toString();
    }

	/** Set AD_AttachmentFile_UU.
		@param AD_AttachmentFile_UU AD_AttachmentFile_UU
	*/
	public void setAD_AttachmentFile_UU (String AD_AttachmentFile_UU)
	{
		set_Value (COLUMNNAME_AD_AttachmentFile_UU, AD_AttachmentFile_UU);
	}

	/** Get AD_AttachmentFile_UU.
		@return AD_AttachmentFile_UU	  */
	public String getAD_AttachmentFile_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_AttachmentFile_UU);
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_AD_Attachment getAD_Attachment() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Attachment)MTable.get(getCtx(), org.compiere.model.I_AD_Attachment.Table_ID)
			.getPO(getAD_Attachment_ID(), get_TrxName());
	}

	/** Set Attachment.
		@param AD_Attachment_ID Attachment for the document
	*/
	public void setAD_Attachment_ID (int AD_Attachment_ID)
	{
		if (AD_Attachment_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Attachment_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Attachment_ID, Integer.valueOf(AD_Attachment_ID));
	}

	/** Get Attachment.
		@return Attachment for the document
	  */
	public int getAD_Attachment_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Attachment_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set File Name.
		@param FileName Name of the local file or URL
	*/
	public void setFileName (String FileName)
	{
		set_Value (COLUMNNAME_FileName, FileName);
	}

	/** Get File Name.
		@return Name of the local file or URL
	  */
	public String getFileName()
	{
		return (String)get_Value(COLUMNNAME_FileName);
	}

	/** Set File Path.
		@param FilePath Path where the file can be found
	*/
	public void setFilePath (String FilePath)
	{
		set_Value (COLUMNNAME_FilePath, FilePath);
	}

	/** Get File Path.
		@return Path where the file can be found
	  */
	public String getFilePath()
	{
		return (String)get_Value(COLUMNNAME_FilePath);
	}

	/** Set File Size.
		@param FileSize Size of the File in bytes
	*/
	public void setFileSize (BigDecimal FileSize)
	{
		set_Value (COLUMNNAME_FileSize, FileSize);
	}

	/** Get File Size.
		@return Size of the File in bytes
	  */
	public BigDecimal getFileSize()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_FileSize);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set MIME Type.
		@param MIMEType MIME Type
	*/
	public void setMIMEType (String MIMEType)
	{
		set_Value (COLUMNNAME_MIMEType, MIMEType);
	}

	/** Get MIME Type.
		@return MIME Type	  */
	public String getMIMEType()
	{
		return (String)get_Value(COLUMNNAME_MIMEType);
	}

	/** Set SHA256 Checksum.
		@param SHA256Checksum SHA256 Checksum
	*/
	public void setSHA256Checksum (String SHA256Checksum)
	{
		set_Value (COLUMNNAME_SHA256Checksum, SHA256Checksum);
	}

	/** Get SHA256 Checksum.
		@return SHA256 Checksum	  */
	public String getSHA256Checksum()
	{
		return (String)get_Value(COLUMNNAME_SHA256Checksum);
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