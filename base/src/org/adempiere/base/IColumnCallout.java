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

import java.util.Properties;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;

/**
 *  Column Callout Interface
 */
public interface IColumnCallout extends IService
{
	/**
	 *	Start Callout.
	 *  <p>
	 *	Callout's are used for cross field validation and setting values in other fields
	 *	when returning a non empty (error message) string, an exception is raised
	 *  <p>
	 *	When invoked, the Tab model has the new value!
	 *
	 *  @param ctx      Context
	 *  @param WindowNo current Window No
	 *  @param mTab     Model Tab
	 *  @param mField   Model Field
	 *  @param value    The new value
	 *  @param oldValue The old value
	 *  @return Error message or ""
	 */
	public String start (Properties ctx, int WindowNo,
		GridTab mTab, GridField mField, Object value, Object oldValue);

}
