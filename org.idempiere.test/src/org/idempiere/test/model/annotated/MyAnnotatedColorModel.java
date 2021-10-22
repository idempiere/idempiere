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
package org.idempiere.test.model.annotated;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.MColor;

/**
 * 
 * @author hengsin
 *
 */
@org.adempiere.base.Model(table = MColor.Table_Name)
public class MyAnnotatedColorModel extends MColor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public MyAnnotatedColorModel(Properties ctx, int Test_ID, String trxName) {
		super(ctx, Test_ID, trxName);
	}

	public MyAnnotatedColorModel(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}	
}
