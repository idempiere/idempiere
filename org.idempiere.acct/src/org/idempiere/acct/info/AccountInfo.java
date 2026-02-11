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
import org.adempiere.base.acct.info.IElementValueInfo;
import org.compiere.model.I_C_ValidCombination;
import org.compiere.model.PO;
import org.idempiere.acct.model.MAccount;
import org.idempiere.acct.model.MElementValue;

/**
 * Wrapper for {@link MAccount} to provide {@link IAccountInfo} access.
 * 
 * @author etantg
 */
public class AccountInfo implements IAccountInfo {
	
	private final MAccount account;
	
	public AccountInfo(MAccount account) {
        if (account == null)
            throw new IllegalArgumentException("MAccount cannot be null");
        this.account = account;
    }
	
	public MAccount getModel() {
		return account;
	}
	
	@Override
	public I_C_ValidCombination getRecord() {
		return account;
	}

	@Override
	public PO getPO() {
		return account;
	}

	@Override
	public boolean isActiva() {
		return account.isActiva();
	}

	@Override
	public boolean isBalanceSheet() {
		return account.isBalanceSheet();
	}
	
	@Override
	public IElementValueInfo getAccountInfo() {
		MElementValue value = account.getAccount();
		return ElementValueInfo.wrap(value);
	}

	public static IAccountInfo wrap(MAccount account) {
        if (account == null)
            return null;
        if (account instanceof IAccountInfo)
            return (IAccountInfo) account;
        return new AccountInfo(account);
    }
	
	public static List<IAccountInfo> wrapList(List<MAccount> accountList) {
	    return accountList == null
	    		? new ArrayList<>()
	            : accountList.stream()
	            	.map(AccountInfo::wrap)
	            	.collect(Collectors.toList());
	}

}
