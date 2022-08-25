/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.idempiere.model;

import java.sql.Timestamp;

/**
 *
 * @author Peter Takacs, Cloudempiere
 *
 */
public interface IProcessParameter {

    /** Load Meta Data */

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getAD_Org_ID();

	/** Set Process Parameter	  */
	public void setAD_Process_Para_ID (int AD_Process_Para_ID);

	/** Get Process Parameter	  */
	public int getAD_Process_Para_ID();

	public org.compiere.model.I_AD_Process_Para getAD_Process_Para() throws RuntimeException;

	/** Get Created.
	  * Date this record was created
	  */
	public Timestamp getCreated();

	/** Get Created By.
	  * User who created this records
	  */
	public int getCreatedBy();

	/** Set Description.
	  * Optional short description of the record
	  */
	public void setDescription (String Description);

	/** Get Description.
	  * Optional short description of the record
	  */
	public String getDescription();

	/** Set Active.
	  * The record is active in the system
	  */
	public void setIsActive (boolean IsActive);

	/** Get Active.
	  * The record is active in the system
	  */
	public boolean isActive();

	/** Set Default Parameter.
	  * Default value of the parameter
	  */
	public void setParameterDefault (String ParameterDefault);

	/** Get Default Parameter.
	  * Default value of the parameter
	  */
	public String getParameterDefault();

	/** Set Default To Parameter.
	  * Default value of the to parameter
	  */
	public void setParameterToDefault (String ParameterToDefault);

	/** Get Default To Parameter.
	  * Default value of the to parameter
	  */
	public String getParameterToDefault();

	/** Get Updated.
	  * Date this record was updated
	  */
	public Timestamp getUpdated();

	/** Get Updated By.
	  * User who updated this records
	  */
	public int getUpdatedBy();
	/**
	 * Set ID of the parent table
	 * @param id
	 */
	public void setParentID(int id);

	/**	 Update Value or create new record.	 */
	public void saveEx();
}
