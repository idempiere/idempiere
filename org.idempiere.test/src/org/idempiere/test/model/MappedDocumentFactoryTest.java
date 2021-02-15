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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.ResultSet;

import org.adempiere.base.Core;
import org.adempiere.base.IMappedDocumentFactory;
import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.acct.Doc_InOut;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClientInfo;
import org.compiere.model.MInOut;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MappedDocumentFactoryTest extends AbstractTestCase {

	public MappedDocumentFactoryTest() {
	}

	@Test
	public void testDefaultMappedDocumentFactory() {
		IMappedDocumentFactory factory = Core.getMappedDocumentFactory();
		factory.addMapping(null, MInOut.Table_Name, (p) -> new MyDocInOut(p.as, p.rs, p.trxName));
		
		//need to reset cache if you are replacing doc classes from core
		CacheMgt.get().reset(DocManager.IDOC_FACTORY_CACHE_TABLE_NAME);
		
		int C_AcctSchema_ID = MClientInfo.get().getC_AcctSchema1_ID();
		MAcctSchema as = new MAcctSchema(Env.getCtx(), C_AcctSchema_ID, getTrxName());
		Doc doc = DocManager.getDocument(as, MInOut.Table_ID, 100, getTrxName());
		assertTrue(doc != null && doc instanceof MyDocInOut, "Doc not instanceof MyDocInOut. " + (doc == null ? "Doc is Null" : "Doc="+doc.getClass().getName()));
	}
	
	private final static class MyDocInOut extends Doc_InOut {

		public MyDocInOut(MAcctSchema as, ResultSet rs, String trxName) {
			super(as, rs, trxName);
		}		
	}
}
