package org.adempiere.process;

import org.compiere.model.MShipper;
import org.compiere.model.MShipperLabels;
import org.compiere.model.MShipperPackaging;
import org.compiere.model.MShipperPickupTypes;
import org.compiere.model.X_M_ShipperLabelsCfg;
import org.compiere.model.X_M_ShipperPackagingCfg;
import org.compiere.model.X_M_ShipperPickupTypesCfg;
import org.compiere.process.SvrProcess;

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