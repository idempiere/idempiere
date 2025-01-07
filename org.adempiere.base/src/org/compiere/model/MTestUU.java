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

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Test UUID Based Table Model
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class MTestUU extends X_TestUU {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 5182486896440407051L;

	/**
	 * Constructor
	 * 
	 * @param ctx context
	 * @param Test_UU
	 * @param trxName transaction
	 */
	public MTestUU(Properties ctx, String Test_UU, String trxName) {
		this(ctx, Test_UU, trxName, (String[]) null);
	} // MTestUU

	/**
	 * @param ctx
	 * @param Test_UU
	 * @param trxName
	 * @param virtualColumns
	 */
	public MTestUU(Properties ctx, String Test_UU, String trxName, String... virtualColumns) {
		super(ctx, Test_UU, trxName, virtualColumns);
	} // MTestUU

	/**
	 * Load Constructor
	 * 
	 * @param ctx     context
	 * @param rs      result set
	 * @param trxName transaction
	 */
	public MTestUU(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MTestUU

	@Override
	protected boolean beforeSave(boolean newRecord) {
		log.warning("Capturing beforeSave event on TestUU table");
		return true;
	}

} // MTestUU
