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
package org.idempiere.test.event;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.base.annotation.EventTopicDelegate;
import org.adempiere.base.annotation.ModelEventTopic;
import org.adempiere.base.event.FactsEventData;
import org.adempiere.base.event.annotations.doc.AfterReverseAccrual;
import org.adempiere.base.event.annotations.doc.BeforeReverseAccrual;
import org.adempiere.base.event.annotations.doc.FactsValidateDelegate;
import org.compiere.model.MInvoice;
import org.osgi.service.event.Event;

@EventTopicDelegate
@ModelEventTopic(modelClass = MInvoice.class)
public class MInvoiceEventDelegate extends FactsValidateDelegate<MInvoice> {

	public static List<String> eventLog = new ArrayList<>();

	public MInvoiceEventDelegate(MInvoice po, Event event) {
		super(po, event);
	}

	@BeforeReverseAccrual
	public void onBeforeReverseAccrual() {
		eventLog.add("BeforeReverseAccrual");
	}

	@AfterReverseAccrual
	public void onAfterReverseAccrual() {
		eventLog.add("AfterReverseAccrual");
	}

	@Override
	protected void onFactsValidate(FactsEventData data) {
		eventLog.add("FactsValidate");
	}
}
