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
package org.idempiere.acct.info;

import org.adempiere.base.acct.info.IFactReconciliationInfo;
import org.compiere.model.I_Fact_Reconciliation;
import org.compiere.model.PO;
import org.idempiere.acct.model.MFactReconciliation;

/**
 * Wrapper for {@link MFactReconciliation} to provide {@link IFactReconciliationInfo} access.
 * 
 * @author etantg
 */
public class FactReconciliationInfo implements IFactReconciliationInfo {
	
	private final MFactReconciliation reconciliation;
	
	public FactReconciliationInfo(MFactReconciliation reconciliation) {
        if (reconciliation == null)
            throw new IllegalArgumentException("MFactReconciliation cannot be null");
        this.reconciliation = reconciliation;
    }
	
	public MFactReconciliation getModel() {
		return reconciliation;
	}

	@Override
    public I_Fact_Reconciliation getRecord() {
        return reconciliation;
    }

	@Override
	public PO getPO() {
		return reconciliation;
	}
	
	public static IFactReconciliationInfo wrap(MFactReconciliation reconciliation) {
        if (reconciliation == null)
            return null;
        if (reconciliation instanceof IFactReconciliationInfo)
            return (IFactReconciliationInfo) reconciliation;
        return new FactReconciliationInfo(reconciliation);
    }
}
