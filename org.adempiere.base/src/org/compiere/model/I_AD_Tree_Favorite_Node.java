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

/** Generated Interface for AD_Tree_Favorite_Node
 *  @author iDempiere (generated) 
 *  @version Development 9.0
 */
public interface I_AD_Tree_Favorite_Node 
{

    /** TableName=AD_Tree_Favorite_Node */
    public static final String Table_Name = "AD_Tree_Favorite_Node";

    /** AD_Table_ID=200221 */
    public static final int Table_ID = 200221;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 7 - System - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(7);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Menu_ID */
    public static final String COLUMNNAME_AD_Menu_ID = "AD_Menu_ID";

	/** Set Menu.
	  * Identifies a Menu
	  */
	public void setAD_Menu_ID (int AD_Menu_ID);

	/** Get Menu.
	  * Identifies a Menu
	  */
	public int getAD_Menu_ID();

	public org.compiere.model.I_AD_Menu getAD_Menu() throws RuntimeException;

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within client
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within client
	  */
	public int getAD_Org_ID();

    /** Column name AD_Tree_Favorite_ID */
    public static final String COLUMNNAME_AD_Tree_Favorite_ID = "AD_Tree_Favorite_ID";

	/** Set Favorite Tree	  */
	public void setAD_Tree_Favorite_ID (int AD_Tree_Favorite_ID);

	/** Get Favorite Tree	  */
	public int getAD_Tree_Favorite_ID();

	public org.compiere.model.I_AD_Tree_Favorite getAD_Tree_Favorite() throws RuntimeException;

    /** Column name AD_Tree_Favorite_Node_ID */
    public static final String COLUMNNAME_AD_Tree_Favorite_Node_ID = "AD_Tree_Favorite_Node_ID";

	/** Set Favorite Node Tree	  */
	public void setAD_Tree_Favorite_Node_ID (int AD_Tree_Favorite_Node_ID);

	/** Get Favorite Node Tree	  */
	public int getAD_Tree_Favorite_Node_ID();

    /** Column name AD_Tree_Favorite_Node_UU */
    public static final String COLUMNNAME_AD_Tree_Favorite_Node_UU = "AD_Tree_Favorite_Node_UU";

	/** Set Favorite Node Tree	  */
	public void setAD_Tree_Favorite_Node_UU (String AD_Tree_Favorite_Node_UU);

	/** Get Favorite Node Tree	  */
	public String getAD_Tree_Favorite_Node_UU();

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

    /** Column name IsCollapsible */
    public static final String COLUMNNAME_IsCollapsible = "IsCollapsible";

	/** Set Collapsible.
	  * Flag to indicate the state of the dashboard panel
	  */
	public void setIsCollapsible (boolean IsCollapsible);

	/** Get Collapsible.
	  * Flag to indicate the state of the dashboard panel
	  */
	public boolean isCollapsible();

    /** Column name IsFavourite */
    public static final String COLUMNNAME_IsFavourite = "IsFavourite";

	/** Set Favourite.
	  * This record is a favourite
	  */
	public void setIsFavourite (boolean IsFavourite);

	/** Get Favourite.
	  * This record is a favourite
	  */
	public boolean isFavourite();

    /** Column name IsSummary */
    public static final String COLUMNNAME_IsSummary = "IsSummary";

	/** Set Summary Level.
	  * This is a summary entity
	  */
	public void setIsSummary (boolean IsSummary);

	/** Get Summary Level.
	  * This is a summary entity
	  */
	public boolean isSummary();

    /** Column name LoginOpenSeqNo */
    public static final String COLUMNNAME_LoginOpenSeqNo = "LoginOpenSeqNo";

	/** Set Login automatic open sequence.
	  * Determine the order items will be automatically opened when user logs in
	  */
	public void setLoginOpenSeqNo (int LoginOpenSeqNo);

	/** Get Login automatic open sequence.
	  * Determine the order items will be automatically opened when user logs in
	  */
	public int getLoginOpenSeqNo();

    /** Column name Name */
    public static final String COLUMNNAME_Name = "Name";

	/** Set Name.
	  * Alphanumeric identifier of the entity
	  */
	public void setName (String Name);

	/** Get Name.
	  * Alphanumeric identifier of the entity
	  */
	public String getName();

    /** Column name Parent_ID */
    public static final String COLUMNNAME_Parent_ID = "Parent_ID";

	/** Set Parent.
	  * Parent of Entity
	  */
	public void setParent_ID (int Parent_ID);

	/** Get Parent.
	  * Parent of Entity
	  */
	public int getParent_ID();

	public org.compiere.model.I_AD_Tree_Favorite_Node getParent() throws RuntimeException;

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
