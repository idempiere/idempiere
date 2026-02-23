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

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.adempiere.base.acct.info.IAccountInfo;
import org.adempiere.base.acct.info.IFactAcctInfo;
import org.compiere.model.I_Fact_Acct;
import org.compiere.model.PO;
import org.idempiere.acct.model.MAccount;
import org.idempiere.acct.model.MFactAcct;

/**
 * Wrapper for {@link MFactAcct} to provide {@link IFactAcctInfo} access.
 * 
 * @author etantg
 */
public class FactAcctInfo implements IFactAcctInfo {

	private final MFactAcct fact;
	
	public FactAcctInfo(MFactAcct fact) {
        if (fact == null)
            throw new IllegalArgumentException("MFactAcct cannot be null");
        this.fact = fact;
    }
	
	public MFactAcct getModel() {
		return fact;
	}
	
	@Override
	public I_Fact_Acct getRecord() {
		return fact;
	}

	@Override
	public PO getPO() {
		return fact;
	}

	@Override
	public void setClientOrg(PO po) {
		if (po.getAD_Client_ID() != fact.getAD_Client_ID())
			fact.set_ValueNoCheck ("AD_Client_ID", Integer.valueOf(po.getAD_Client_ID()));
		if (po.getAD_Org_ID() != fact.getAD_Org_ID())
			fact.setAD_Org_ID(po.getAD_Org_ID());
	}

	@Override
	public IAccountInfo getAccountInfo() {
		MAccount account = fact.getMAccount();
		return AccountInfo.wrap(account);
	}
	
	public static IFactAcctInfo wrap(MFactAcct fact) {
        if (fact == null)
            return null;
        if (fact instanceof IFactAcctInfo)
            return (IFactAcctInfo) fact;
        return new FactAcctInfo(fact);
    }
	
	public static List<IFactAcctInfo> wrapList(List<MFactAcct> list) {
	    return list == null
	    		? new ArrayList<>()
	            : list.stream()
	            	.map(FactAcctInfo::wrap)
	            	.collect(Collectors.toList());
	}
	
}
