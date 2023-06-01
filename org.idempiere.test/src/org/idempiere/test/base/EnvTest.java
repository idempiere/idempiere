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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.text.SimpleDateFormat;

import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MOrder;
import org.compiere.model.MTable;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class EnvTest extends AbstractTestCase {

	/**
	 * default constructor
	 */
	public EnvTest() {
		// TODO Auto-generated constructor stub
	}

	@Test
	public void testParseVariable() {
		//test bean property, i.e order.getSummary()
		MOrder order = new MOrder(Env.getCtx(), 100, getTrxName());
		String summary = order.getSummary();
		String expr = "@=Summary@";
		String parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(summary, parsedText, "Unexpected parsed text for "+expr);
		expr = "@=summary@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(summary, parsedText, "Unexpected parsed text for "+expr);
		
		//test po column access
		String docNo = order.getDocumentNo();
		expr = "@DocumentNo@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(docNo, parsedText, "Unexpected parsed text for "+expr);
		
		//test formatting of date
		String dateOrdered = DisplayType.getDateFormat(MTable.get(MOrder.Table_ID).getColumn(MOrder.COLUMNNAME_DateOrdered).getAD_Reference_ID())
				.format(order.getDateOrdered());
		expr = "@DateOrdered@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(dateOrdered, parsedText, "Unexpected parsed text for "+expr);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		dateOrdered = sdf.format(order.getDateOrdered());
		expr = "@DateOrdered<"+sdf.toPattern()+">@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(dateOrdered, parsedText, "Unexpected parsed text for "+expr);
		
		//test foreign table access
		String clientId = Env.getContext(Env.getCtx(), Env.AD_CLIENT_ID);
		expr = "@#AD_Client_ID@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(clientId, parsedText, "Unexpected parsed text for "+expr);
		
		String clientName = MClient.get(getAD_Client_ID()).getName();
		expr = "@#AD_Client_ID<Name>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(clientName, parsedText, "Unexpected parsed text for "+expr);
		
		String bpartnerValue = MBPartner.get(Env.getCtx(), order.getC_BPartner_ID()).getValue();
		expr = "@C_BPartner_ID<Value>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(bpartnerValue, parsedText, "Unexpected parsed text for "+expr);
		
		//test list expression
		String docStatusName = order.getDocStatusName();
		expr = "@DocStatus<Name>@";
		parsedText = Env.parseVariable(expr, order, getTrxName(), true, true, true);
		assertEquals(docStatusName, parsedText, "Unexpected parsed text for "+expr);
	}
}
