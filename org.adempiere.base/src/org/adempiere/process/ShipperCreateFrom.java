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
package org.adempiere.process;

import org.compiere.model.MShipper;
import org.compiere.model.MShipperLabels;
import org.compiere.model.MShipperPackaging;
import org.compiere.model.MShipperPickupTypes;
import org.compiere.model.X_M_ShipperLabelsCfg;
import org.compiere.model.X_M_ShipperPackagingCfg;
import org.compiere.model.X_M_ShipperPickupTypesCfg;
import org.compiere.process.SvrProcess;

/**
 * Process to create shipper child records from M_ShipperCfg child records.
 */
@org.adempiere.base.annotation.Process
public class ShipperCreateFrom extends SvrProcess
{
	private MShipper m_shipper;

	@Override
	protected void prepare() 
	{
		m_shipper = new MShipper(getCtx(), getRecord_ID(), get_TrxName());
	}

	@Override
	protected String doIt() throws Exception 
	{		
		createShipperPackaging();
		createShipperLabels();
		createShipperPickupTypes();
		
		return "OK";
	}
	
	/**
	 * Create M_ShipperPackaging records from M_ShipperPackagingCfg records.
	 */
	private void createShipperPackaging()
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("M_ShipperCfg_ID=" + m_shipper.getM_ShipperCfg_ID() + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND M_ShipperPackagingCfg_ID NOT IN ( ");
		whereClause.append("SELECT M_ShipperPackagingCfg_ID ");
		whereClause.append("FROM M_ShipperPackaging ");
		whereClause.append("WHERE M_Shipper_ID=" + m_shipper.getM_Shipper_ID() + ")");
		
		int[] xspIds = X_M_ShipperPackagingCfg.getAllIDs(X_M_ShipperPackagingCfg.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xspId : xspIds)
		{
			X_M_ShipperPackagingCfg xsp = new X_M_ShipperPackagingCfg(getCtx(), xspId, get_TrxName());
			MShipperPackaging sp = new MShipperPackaging(getCtx(), 0, null);
			sp.setM_Shipper_ID(m_shipper.getM_Shipper_ID());
			sp.setM_ShipperPackagingCfg_ID(xsp.getM_ShipperPackagingCfg_ID());
			sp.setName(xsp.getName());
			sp.setIsDefault(xsp.isDefault());
			sp.setWeight(xsp.getWeight());
			sp.saveEx();				
		}
	}
	
	/**
	 * Create M_ShipperLabels records from M_ShipperLabelsCfg records.
	 */
	private void createShipperLabels()
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("M_ShipperCfg_ID=" + m_shipper.getM_ShipperCfg_ID() + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND M_ShipperLabelsCfg_ID NOT IN ( ");
		whereClause.append("SELECT M_ShipperLabelsCfg_ID ");
		whereClause.append("FROM M_ShipperLabels ");
		whereClause.append("WHERE M_Shipper_ID=" + m_shipper.getM_Shipper_ID() + ")");
		
		int[] xslIds = X_M_ShipperLabelsCfg.getAllIDs(X_M_ShipperLabelsCfg.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xslId : xslIds)
		{
			X_M_ShipperLabelsCfg xsl = new X_M_ShipperLabelsCfg(getCtx(), xslId, get_TrxName());
			MShipperLabels sl = new MShipperLabels(getCtx(), 0, null);
			sl.setM_Shipper_ID(m_shipper.getM_Shipper_ID());
			sl.setM_ShipperLabelsCfg_ID(xsl.getM_ShipperLabelsCfg_ID());
			sl.setName(xsl.getName());
			sl.setIsDefault(xsl.isDefault());
			sl.setLabelPrintMethod(xsl.getLabelPrintMethod());
			sl.saveEx();				
		}
	}
	
	/**
	 * Create M_ShipperPickupTypes records from M_ShipperPickupTypesCfg records.
	 */
	private void createShipperPickupTypes()
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("M_ShipperCfg_ID=" + m_shipper.getM_ShipperCfg_ID() + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND M_ShipperPickupTypesCfg_ID NOT IN ( ");
		whereClause.append("SELECT M_ShipperPickupTypesCfg_ID ");
		whereClause.append("FROM M_ShipperPickupTypes ");
		whereClause.append("WHERE M_Shipper_ID=" + m_shipper.getM_Shipper_ID() + ")");
		
		int[] xsptIds = X_M_ShipperPickupTypesCfg.getAllIDs(X_M_ShipperPickupTypesCfg.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xsptId : xsptIds)
		{
			X_M_ShipperPickupTypesCfg xspt = new X_M_ShipperPickupTypesCfg(getCtx(), xsptId, get_TrxName());
			MShipperPickupTypes spt = new MShipperPickupTypes(getCtx(), 0, null);
			spt.setM_Shipper_ID(m_shipper.getM_Shipper_ID());
			spt.setM_ShipperPickupTypesCfg_ID(xspt.getM_ShipperPickupTypesCfg_ID());
			spt.setName(xspt.getName());
			spt.setIsDefault(xspt.isDefault());
			spt.saveEx();				
		}
	}
}