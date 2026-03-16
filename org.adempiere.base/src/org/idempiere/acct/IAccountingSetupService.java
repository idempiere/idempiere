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

/**
 * Service for accounting setup operations.
 * Implementation provided by accounting module.
 */
public interface IAccountingSetupService {
    
	/**
     * Link dimension to accounting schema element
     * @param ctx context
     * @param C_AcctSchema_ID accounting schema
     * @param elementType element type (MC, SR, AY, BP, PR, PJ)
     * @param dimensionID dimension ID to link
     * @param trxName transaction
     * @return true if linked
     */
    boolean linkDimensionToAcctSchema(int C_AcctSchema_ID,
                                     String elementType, int dimensionID, 
                                     String trxName);
}
