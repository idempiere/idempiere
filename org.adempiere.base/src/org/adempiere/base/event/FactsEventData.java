/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.base.event;

import java.util.List;

import org.compiere.acct.Fact;
import org.compiere.model.MAcctSchema;
import org.compiere.model.PO;

/**
 *
 * @author hengsin
 *
 */
public class FactsEventData {
	private MAcctSchema acctSchema;
	private List<Fact> facts;
	private PO po;

	/**
	 * @param acctSchema
	 * @param facts
	 * @param po
	 */
	public FactsEventData(MAcctSchema acctSchema, List<Fact> facts, PO po) {
		super();
		this.acctSchema = acctSchema;
		this.facts = facts;
		this.po = po;
	}

	/**
	 * @return the acctSchema
	 */
	public MAcctSchema getAcctSchema() {
		return acctSchema;
	}

	/**
	 * @return the facts
	 */
	public List<Fact> getFacts() {
		return facts;
	}

	/**
	 * @return the po
	 */
	public PO getPo() {
		return po;
	}
}
