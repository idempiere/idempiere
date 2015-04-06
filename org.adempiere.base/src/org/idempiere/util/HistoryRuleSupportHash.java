/******************************************************************************
 * Copyright (C) 2015 iDempiere                                               *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.idempiere.util;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.SecureEngine;
import org.passay.HistoryRule;
import org.passay.PasswordData.HistoricalReference;
import org.passay.PasswordData.Reference;

/**
 * implement history password rule support hash password
 * @author hieplq
 *
 */
public class HistoryRuleSupportHash extends HistoryRule {
	/**
	 * use salt in hex form and password hashed in reference compare with plant password
	 */
	@Override
	protected boolean matches(String password, Reference reference) {
		if (reference instanceof HistoricalReference){
			String salt = ((HistoricalReference) reference).getLabel();
			if (salt != null){
				return SecureEngine.isMatchHash (reference.getPassword(), ((HistoricalReference) reference).getLabel(), password);
			}else{
				return reference.getPassword().equals(password);
			}
		}else{
			throw new AdempiereException("Wrong sub type of org.passay.PasswordData.Reference");
		}
	}
}
