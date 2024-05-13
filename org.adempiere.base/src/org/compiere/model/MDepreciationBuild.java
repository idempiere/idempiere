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
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/** 
 *  Depreciation Build
 *  @author Teo Sarca, SC ARHIPAC SRL
 *  @version $Id$ -- Release 2.5.3a - 2006-06-22 18:03:22.896
 */
public class MDepreciationBuild extends X_A_Depreciation_Build
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2075917470265913988L;
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Depreciation_Build_UU  UUID key
     * @param trxName Transaction
     */
    public MDepreciationBuild(Properties ctx, String A_Depreciation_Build_UU, String trxName) {
        super(ctx, A_Depreciation_Build_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param A_Depreciation_Build_ID
	 * @param trxName
	 */
	public MDepreciationBuild (Properties ctx, int A_Depreciation_Build_ID, String trxName)
	{
		super (ctx, A_Depreciation_Build_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDepreciationBuild (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
}
