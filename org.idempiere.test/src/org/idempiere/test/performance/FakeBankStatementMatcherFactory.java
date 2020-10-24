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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.performance;

import org.adempiere.base.IBankStatementMatcherFactory;
import org.compiere.impexp.BankStatementMatchInfo;
import org.compiere.impexp.BankStatementMatcherInterface;
import org.compiere.model.MBankStatementLine;
import org.compiere.model.X_I_BankStatement;

/**
 * @author hengsin
 *
 */
public class FakeBankStatementMatcherFactory implements IBankStatementMatcherFactory {

	/**
	 * 
	 */
	public FakeBankStatementMatcherFactory() {
	}

	@Override
	public BankStatementMatcherInterface newBankStatementMatcherInstance(String className) {
		if (FakeBankStatementMatcherFactory.class.getName().equals(className)) {
			return new BankStatementMatcherInterface() {
				
				@Override
				public BankStatementMatchInfo findMatch(X_I_BankStatement ibs) {
					return null;
				}
				
				@Override
				public BankStatementMatchInfo findMatch(MBankStatementLine bsl) {
					return null;
				}
			};
		}
		return null;
	}

}
