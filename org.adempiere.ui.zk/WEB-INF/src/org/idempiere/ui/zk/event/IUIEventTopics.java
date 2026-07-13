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
package org.idempiere.ui.zk.event;

/**
 * UI Event topic constants
 */
public interface IUIEventTopics {

	/* zkwebui Events */
	public static final String UI_EVENT_PREFIX = "idempiere/ui/";
	public static final String UI_OPEN_WINDOW = UI_EVENT_PREFIX+"openWindow";
	public static final String UI_OPEN_FORM = UI_EVENT_PREFIX+"openForm";
	public static final String UI_OPEN_INFO = UI_EVENT_PREFIX+"openInfo";
	public static final String UI_OPEN_PROCESS = UI_EVENT_PREFIX+"openProcess";
	public static final String UI_ACCESS_RECORD = UI_EVENT_PREFIX+"accessRecord";
	public static final String UI_DOWNLOAD_ATTACHMENT = UI_EVENT_PREFIX+"downloadAttachment";

}
