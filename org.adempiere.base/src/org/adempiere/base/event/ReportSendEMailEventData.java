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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */

package org.adempiere.base.event;

import org.compiere.model.PrintInfo;

public class ReportSendEMailEventData {
	
	public static final String CONTEXT_EMAIL_TO = "_EMAIL_TO_";
	public static final String CONTEXT_EMAIL_USER_TO = "_EMAIL_USER_TO_";
	public static final String CONTEXT_EMAIL_CC = "_EMAIL_CC_";
	public static final String CONTEXT_EMAIL_USER_CC = "_EMAIL_USER_CC_";
	public static final String CONTEXT_EMAIL_SUBJECT = "_EMAIL_SUBJECT_";
	public static final String CONTEXT_EMAIL_MESSAGE = "_EMAIL_MESSAGE_";

	private int m_windowNo;
	private PrintInfo m_printInfo;
	private String m_subject;
	private int m_tableId;
	private int m_recordId;

	public ReportSendEMailEventData(int windowNo, int tableId, int recordId, PrintInfo printInfo, String subject) {
		m_windowNo = windowNo;
		m_tableId = tableId;
		m_recordId = recordId;
		m_printInfo = printInfo;
		m_subject = subject;
	}

	public int getWindowNo() {
		return m_windowNo;
	}

	public void setWindowNo(int windowNo) {
		m_windowNo = windowNo;
	}

	public int getTableId() {
		return m_tableId;
	}

	public void setTableId(int tableId) {
		m_tableId = tableId;
	}

	public int getRecordId() {
		return m_recordId;
	}

	public void setRecordId(int recordId) {
		m_recordId = recordId;
	}

	public PrintInfo getFrom() {
		return m_printInfo;
	}

	public void setFrom(PrintInfo printInfo) {
		m_printInfo = printInfo;
	}

	public String getSubject() {
		return m_subject;
	}

	public void setSubject(String subject) {
		m_subject = subject;
	}

}
