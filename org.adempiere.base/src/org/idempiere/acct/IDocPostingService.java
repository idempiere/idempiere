/***********************************************************************
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
 **********************************************************************/
package org.idempiere.acct;

import org.compiere.model.MAcctSchema;

public interface IDocPostingService {

	/**
	 *  Post document immediately
	 * 	@param ass accounting schema
	 * 	@param AD_Table_ID	Transaction table
	 *  @param Record_ID    Record ID of this document
	 *  @param force        force posting
	 *  @param trxName	    transaction
	 *  @return null if the document was posted or error message
	 */
	String postImmediate(MAcctSchema[] ass, int AD_Table_ID, 
			int Record_ID, boolean force, String trxName);

	/**
	 * Manual posting by user
	 * @param WindowNo
	 * @param AD_Client_ID
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param force
	 * @return error message ( if any )
	 */
	String manualPosting(int WindowNo, int AD_Client_ID, 
			int AD_Table_ID, int Record_ID, boolean force);

}
