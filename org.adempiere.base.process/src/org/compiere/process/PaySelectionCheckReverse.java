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
 * - Nicolas Micoud (TGI)                                              *
 **********************************************************************/
package org.compiere.process;

import java.util.List;

import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPaySelectionLine;
import org.compiere.model.Query;

/**
 *	IDEMPIERE-5170 - Reverse Prepare Payment process (PaySelectionCreateCheck.java)
 *  @author Nicolas Micoud - TGI
 */
@org.adempiere.base.annotation.Process
public class PaySelectionCheckReverse extends SvrProcess {

	protected void prepare() {}

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception {

		MPaySelection ps = new MPaySelection(getCtx(), getRecord_ID(), get_TrxName());

		List <MPaySelectionCheck> list = new Query(getCtx(), MPaySelectionCheck.Table_Name, "C_PaySelection_ID = ?", get_TrxName())
				.setParameters(ps.getC_PaySelection_ID())
				.setOrderBy(MPaySelectionCheck.COLUMNNAME_C_PaySelectionCheck_ID)
				.list();

		for (MPaySelectionCheck psc : list) {
			if (psc.getC_Payment_ID() > 0)
				return "@Error@ @C_PaySelectionCheck_ID@ @Processed@";

			for (MPaySelectionLine psl : psc.getPaySelectionLines(false)) {
				psl.setC_PaySelectionCheck_ID(0);
				psl.setProcessed(false);
				psl.saveEx();
			}

			psc.deleteEx(true);
		}

		ps.setProcessed(false);
		ps.saveEx();

		return new StringBuilder("@Deleted@ #").append(list.size()).toString();
	}
}	// PaySelectionCheckReverse
