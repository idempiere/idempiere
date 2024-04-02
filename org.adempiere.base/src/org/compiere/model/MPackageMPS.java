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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 * Multiple Package Shipment (for e.g Fedex MPS)  for Shipment Package (MPackage) 
 */
public class MPackageMPS extends X_M_PackageMPS
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2426722699419960060L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_PackageMPS_UU  UUID key
     * @param trxName Transaction
     */
    public MPackageMPS(Properties ctx, String M_PackageMPS_UU, String trxName) {
        super(ctx, M_PackageMPS_UU, trxName);
		if (Util.isEmpty(M_PackageMPS_UU))
			setInitialDefaults(ctx);
    }

    /**
     * @param ctx
     * @param M_PackageMPS_ID
     * @param trxName
     */
	public MPackageMPS(Properties ctx, int M_PackageMPS_ID, String trxName)
	{
		super(ctx, M_PackageMPS_ID, trxName);
		if (M_PackageMPS_ID == 0)
			setInitialDefaults(ctx);
	}
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults(Properties ctx) {
		MClientInfo clientInfo = MClientInfo.get(ctx, getAD_Client_ID());
		setC_UOM_Weight_ID(clientInfo.getC_UOM_Weight_ID());
		setC_UOM_Length_ID(clientInfo.getC_UOM_Length_ID());
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MPackageMPS(Properties ctx, ResultSet rs, String trxName) 
	{
		super(ctx, rs, trxName);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		// Set SeqNo
		if (getSeqNo() == 0)
		{
			String sql = "SELECT COALESCE(MAX(SeqNo),0)+10 FROM M_PackageMPS WHERE M_Package_ID=?";
			int ii = DB.getSQLValue (get_TrxName(), sql, getM_Package_ID());
			setSeqNo(ii);
		}
		// Update weight from X_PackageLineWeight.LineWeight
		if (getWeight() == null || getWeight().compareTo(BigDecimal.ZERO) == 0)
		{
			String sql = "SELECT SUM(LineWeight) FROM X_PackageLineWeight plw WHERE plw.M_PackageMPS_ID=?";
			BigDecimal weight = DB.getSQLValueBD(get_TrxName(), sql, getM_PackageMPS_ID());
			if (weight == null)
				weight = BigDecimal.ZERO;
			setWeight(weight);
		}
		
		return true;
	}

	@Override
	protected boolean beforeDelete()
	{
		// Delete package lines
		String sql = "DELETE FROM M_PackageLine WHERE M_PackageMPS_ID = ?";
		DB.executeUpdate(sql, getM_PackageMPS_ID(), get_TrxName());
		return true;
	}
}
