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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import org.compiere.util.KeyNamePair;

/** Generated Interface for AD_AttachmentFile
 *  @author iDempiere (generated) 
 *  @version Release 13
 */
public interface I_AD_AttachmentFile 
{

    /** TableName=AD_AttachmentFile */
    public static final String Table_Name = "AD_AttachmentFile";

    /** AD_Table_ID=200432 */
    public static final int Table_ID = 200432;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_AttachmentFile_UU */
    public static final String COLUMNNAME_AD_AttachmentFile_UU = "AD_AttachmentFile_UU";

	/** Set AD_AttachmentFile_UU	  */
	public void setAD_AttachmentFile_UU (String AD_AttachmentFile_UU);

	/** Get AD_AttachmentFile_UU	  */
	public String getAD_AttachmentFile_UU();

    /** Column name AD_Attachment_ID */
    public static final String COLUMNNAME_AD_Attachment_ID = "AD_Attachment_ID";

	/** Set Attachment.
	  * Attachment for the document
	  */
	public void setAD_Attachment_ID (int AD_Attachment_ID);

	/** Get Attachment.
	  * Attachment for the document
	  */
	public int getAD_Attachment_ID();

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_AD_Attachment getAD_Attachment() throws RuntimeException;

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getAD_Org_ID();

    /** Column name Created */
    public static final String COLUMNNAME_Created = "Created";

	/** Get Created.
	  * Date this record was created
	  */
	public Timestamp getCreated();

    /** Column name CreatedBy */
    public static final String COLUMNNAME_CreatedBy = "CreatedBy";

	/** Get Created By.
	  * User who created this records
	  */
	public int getCreatedBy();

    /** Column name FileName */
    public static final String COLUMNNAME_FileName = "FileName";

	/** Set File Name.
	  * Name of the local file or URL
	  */
	public void setFileName (String FileName);

	/** Get File Name.
	  * Name of the local file or URL
	  */
	public String getFileName();

    /** Column name FilePath */
    public static final String COLUMNNAME_FilePath = "FilePath";

	/** Set File Path.
	  * Path where the file can be found
	  */
	public void setFilePath (String FilePath);

	/** Get File Path.
	  * Path where the file can be found
	  */
	public String getFilePath();

    /** Column name FileSize */
    public static final String COLUMNNAME_FileSize = "FileSize";

	/** Set File Size.
	  * Size of the File in bytes
	  */
	public void setFileSize (BigDecimal FileSize);

	/** Get File Size.
	  * Size of the File in bytes
	  */
	public BigDecimal getFileSize();

    /** Column name IsActive */
    public static final String COLUMNNAME_IsActive = "IsActive";

	/** Set Active.
	  * The record is active in the system
	  */
	public void setIsActive (boolean IsActive);

	/** Get Active.
	  * The record is active in the system
	  */
	public boolean isActive();

    /** Column name MIMEType */
    public static final String COLUMNNAME_MIMEType = "MIMEType";

	/** Set MIME Type	  */
	public void setMIMEType (String MIMEType);

	/** Get MIME Type	  */
	public String getMIMEType();

    /** Column name SHA256Checksum */
    public static final String COLUMNNAME_SHA256Checksum = "SHA256Checksum";

	/** Set SHA256 Checksum	  */
	public void setSHA256Checksum (String SHA256Checksum);

	/** Get SHA256 Checksum	  */
	public String getSHA256Checksum();

    /** Column name SeqNo */
    public static final String COLUMNNAME_SeqNo = "SeqNo";

	/** Set Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public void setSeqNo (int SeqNo);

	/** Get Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public int getSeqNo();

    /** Column name Updated */
    public static final String COLUMNNAME_Updated = "Updated";

	/** Get Updated.
	  * Date this record was updated
	  */
	public Timestamp getUpdated();

    /** Column name UpdatedBy */
    public static final String COLUMNNAME_UpdatedBy = "UpdatedBy";

	/** Get Updated By.
	  * User who updated this records
	  */
	public int getUpdatedBy();
}
