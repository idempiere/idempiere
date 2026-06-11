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
import org.adempiere.base.annotation.ProcessEventTopic;
import org.adempiere.base.event.annotations.process.AfterProcess;
import org.adempiere.base.event.annotations.process.BeforeProcess;
import org.adempiere.base.event.annotations.process.PostProcess;
import org.adempiere.base.event.annotations.process.ProcessEventDelegate;
import org.osgi.service.event.Event;

@EventTopicDelegate
@ProcessEventTopic(processUUID = "e11a39ce-1e2c-40c8-a93d-b03d78f8a219")
public class CacheResetProcessEventDelegate extends ProcessEventDelegate {

	public static List<String> eventLog = new ArrayList<>();

	public CacheResetProcessEventDelegate(Event event) {
		super(event);
	}

	@BeforeProcess
	public void onBeforeProcess() {
		eventLog.add("BeforeProcess");
	}

	@AfterProcess
	public void onAfterProcess() {
		eventLog.add("AfterProcess");
	}

	@PostProcess
	public void onPostProcess() {
		eventLog.add("PostProcess");
	}
}
