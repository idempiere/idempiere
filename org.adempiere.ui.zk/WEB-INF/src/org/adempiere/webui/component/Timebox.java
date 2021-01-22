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
 * - Carlos Ruiz - globalqss           								   *
 **********************************************************************/
package org.adempiere.webui.component;

import org.compiere.model.MLanguage;
import org.compiere.util.Env;
import org.compiere.util.Language;

public class Timebox extends org.zkoss.zul.Timebox
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3904468791491496039L;

	public Timebox() {
		super();
		MLanguage mlang = MLanguage.get(Env.getCtx(), Language.getLoginLanguage());
		if (mlang != null && mlang.get_ID() > 0 && mlang.getTimePattern() != null) {
			setFormat(mlang.getTimePattern());
		}
	}

}
