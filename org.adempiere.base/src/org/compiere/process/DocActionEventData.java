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
package org.compiere.process;

import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicInteger;

import org.adempiere.base.event.IEventTopics;
import org.adempiere.base.event.POEventData;
import org.compiere.model.PO;

/**
 * Event data for {@link IEventTopics#DOCACTION}.
 */
public class DocActionEventData implements POEventData {

	public String docStatus;
	public Object processing;
	public String orderType;
	public String isSOTrx;
	public int AD_Table_ID;
	public ArrayList<String> docAction;
	public ArrayList<String> options;
	/** End index of valid options (exclusive) */
	public AtomicInteger indexObj;
	public PO po;

	/**
	 * @param docStatus
	 * @param processing
	 * @param orderType
	 * @param isSOTrx
	 * @param AD_Table_ID
	 * @param docAction
	 * @param options
	 * @param indexObj
	 * @param po
	 */
	public DocActionEventData(String docStatus, Object processing, String orderType, String isSOTrx,
			int AD_Table_ID, ArrayList<String> docAction, ArrayList<String> options, AtomicInteger indexObj, PO po) {
		this.docStatus = docStatus;
		this.processing = processing;
		this.orderType = orderType;
		this.isSOTrx = isSOTrx;
		this.AD_Table_ID = AD_Table_ID;
		this.docAction = docAction;
		this.options = options;
		this.indexObj = indexObj;
		this.po = po;
	}

	@Override
	public PO getPo() {
		return po;
	}

}
