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
 * Contributors:                                                       *
 * - Diego Ruiz - TrekGlobal           								   *
 **********************************************************************/
package org.adempiere.base;

import org.compiere.model.PO;

/**
 * Service interface for PO accounting operations.
 * Implementations can be provided by ERP layer via OSGi.
 */
public interface IPOAccountingService {
	
	/**
     * Insert accounting records for PO
     * @param po Persistent Object
     * @param acctTableName accounting table name
     * @param acctBaseTable base table
     * @param whereClause optional where clause
     * @return true if successful
     */
    boolean insertAccounting(PO po, String acctTableName, 
                            String acctBaseTable, String whereClause);
    
    /**
     * Get the Doc associated with this PO (for accounting purposes)
     * @param po persistent object
     * @return Doc or null
     */
    Object getDoc(PO po);
    
    /**
     * Set the Doc associated with this PO (for accounting purposes)
     * @param po persistent object
     * @param doc document
     */
    void setDoc(PO po, Object doc);

}
