/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.base;

import java.util.List;

/**
 * A service locator looks up services.
 * This is the central authority for adempiere service definition,
 * because each service defined has to be looked up via this interface.
 * 
 * A service in adempiere is an interface extended from the tagging interface IService.
 * 
 * @author viola
 *
 */
public interface IServiceLocator {
	<T extends IService> T locate(Class<T> type);
	<T extends IService> T locate(Class<T> type, String id);
	<T extends IService> T locate(Class<T> type, ServiceQuery query);
	<T extends IService> T locate(Class<T> type, String id, ServiceQuery query);
	<T extends IService> List<T> list(Class<T> type);
	<T extends IService> List<T> list(Class<T> type, String id);
	<T extends IService> List<T> list(Class<T> type, ServiceQuery query);
	<T extends IService> List<T> list(Class<T> type, String id, ServiceQuery query);
}
