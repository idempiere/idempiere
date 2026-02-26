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
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.doc.AfterClose;
import org.adempiere.base.event.annotations.doc.AfterComplete;
import org.adempiere.base.event.annotations.doc.AfterPost;
import org.adempiere.base.event.annotations.doc.AfterPrepare;
import org.adempiere.base.event.annotations.doc.AfterReactivate;
import org.adempiere.base.event.annotations.doc.AfterReverseAccrual;
import org.adempiere.base.event.annotations.doc.AfterReverseCorrect;
import org.adempiere.base.event.annotations.doc.AfterVoid;
import org.adempiere.base.event.annotations.doc.BeforeClose;
import org.adempiere.base.event.annotations.doc.BeforeComplete;
import org.adempiere.base.event.annotations.doc.BeforePost;
import org.adempiere.base.event.annotations.doc.BeforePrepare;
import org.adempiere.base.event.annotations.doc.BeforeReactivate;
import org.adempiere.base.event.annotations.doc.BeforeReverseAccrual;
import org.adempiere.base.event.annotations.doc.BeforeReverseCorrect;
import org.adempiere.base.event.annotations.doc.BeforeVoid;
import org.compiere.model.MOrder;
import org.osgi.service.event.Event;

@EventTopicDelegate
@ModelEventTopic(modelClass = MOrder.class)
public class MOrderEventDelegate extends ModelEventDelegate<MOrder> {

	public static List<String> eventLog = new ArrayList<>();

	public MOrderEventDelegate(MOrder po, Event event) {
		super(po, event);
	}

	@BeforePrepare
	public void onBeforePrepare() {
		eventLog.add("BeforePrepare");
	}

	@AfterPrepare
	public void onAfterPrepare() {
		eventLog.add("AfterPrepare");
	}

	@BeforeComplete
	public void onBeforeComplete() {
		eventLog.add("BeforeComplete");
	}

	@AfterComplete
	public void onAfterComplete() {
		eventLog.add("AfterComplete");
	}

	@BeforeVoid
	public void onBeforeVoid() {
		eventLog.add("BeforeVoid");
	}

	@AfterVoid
	public void onAfterVoid() {
		eventLog.add("AfterVoid");
	}

	@BeforeClose
	public void onBeforeClose() {
		eventLog.add("BeforeClose");
	}

	@AfterClose
	public void onAfterClose() {
		eventLog.add("AfterClose");
	}

	@BeforeReactivate
	public void onBeforeReactivate() {
		eventLog.add("BeforeReactivate");
	}

	@AfterReactivate
	public void onAfterReactivate() {
		eventLog.add("AfterReactivate");
	}

	@BeforeReverseCorrect
	public void onBeforeReverseCorrect() {
		eventLog.add("BeforeReverseCorrect");
	}

	@AfterReverseCorrect
	public void onAfterReverseCorrect() {
		eventLog.add("AfterReverseCorrect");
	}

	@BeforeReverseAccrual
	public void onBeforeReverseAccrual() {
		eventLog.add("BeforeReverseAccrual");
	}

	@AfterReverseAccrual
	public void onAfterReverseAccrual() {
		eventLog.add("AfterReverseAccrual");
	}

	@BeforePost
	public void onBeforePost() {
		eventLog.add("BeforePost");
	}

	@AfterPost
	public void onAfterPost() {
		eventLog.add("AfterPost");
	}
}
