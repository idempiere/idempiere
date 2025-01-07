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

/**
 * Event data for {@link IEventTopics#REPORT_SEND_EMAIL} event topic.
 */
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
	private String m_recordUU;

	/**
	 * @param windowNo
	 * @param tableId
	 * @param recordId
	 * @param printInfo
	 * @param subject
	 */
	public ReportSendEMailEventData(int windowNo, int tableId, int recordId, PrintInfo printInfo, String subject) {
		this(windowNo, tableId, recordId, null, printInfo, subject);
	}

	/**
	 * @param windowNo
	 * @param tableId
	 * @param recordId
	 * @param recordUU
	 * @param printInfo
	 * @param subject
	 */
	public ReportSendEMailEventData(int windowNo, int tableId, int recordId, String recordUU, PrintInfo printInfo, String subject) {
		m_windowNo = windowNo;
		m_tableId = tableId;
		m_recordId = recordId;
		m_recordUU = recordUU;
		m_printInfo = printInfo;
		m_subject = subject;
	}

	/**
	 * @return window number
	 */
	public int getWindowNo() {
		return m_windowNo;
	}

	/**
	 * @param windowNo
	 */
	public void setWindowNo(int windowNo) {
		m_windowNo = windowNo;
	}

	/**
	 * @return AD_Table_ID
	 */
	public int getTableId() {
		return m_tableId;
	}

	/**
	 * @param tableId AD_Table_ID
	 */
	public void setTableId(int tableId) {
		m_tableId = tableId;
	}

	/**
	 * @return record id
	 */
	public int getRecordId() {
		return m_recordId;
	}

	/**
	 * @param recordId
	 */
	public void setRecordId(int recordId) {
		m_recordId = recordId;
	}

	/**
	 * @return record uuid
	 */
	public String getRecordUU() {
		return m_recordUU;
	}

	/**
	 * @param recordUU record uuid
	 */
	public void setRecordUU(String recordUU) {
		m_recordUU = recordUU;
	}

	/**
	 * @return PrintInfo
	 */
	public PrintInfo getFrom() {
		return m_printInfo;
	}

	/**
	 * @param printInfo
	 */
	public void setFrom(PrintInfo printInfo) {
		m_printInfo = printInfo;
	}

	/**
	 * @return subject
	 */
	public String getSubject() {
		return m_subject;
	}

	/**
	 * @param subject
	 */
	public void setSubject(String subject) {
		m_subject = subject;
	}

}
