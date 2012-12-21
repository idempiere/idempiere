package org.adempiere.process;

import org.compiere.model.MShipper;
import org.compiere.model.MShipperLabels;
import org.compiere.model.MShipperPackaging;
import org.compiere.model.MShipperPickupTypes;
import org.compiere.model.X_X_ShipperLabels;
import org.compiere.model.X_X_ShipperPackaging;
import org.compiere.model.X_X_ShipperPickupTypes;
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
		whereClause.append("X_Shipper_ID=" + m_shipper.getX_Shipper_ID() + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND X_ShipperPackaging_ID NOT IN ( ");
		whereClause.append("SELECT X_ShipperPackaging_ID ");
		whereClause.append("FROM M_ShipperPackaging ");
		whereClause.append("WHERE M_Shipper_ID=" + m_shipper.getM_Shipper_ID() + ")");
		
		int[] xspIds = X_X_ShipperPackaging.getAllIDs(X_X_ShipperPackaging.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xspId : xspIds)
		{
			X_X_ShipperPackaging xsp = new X_X_ShipperPackaging(getCtx(), xspId, get_TrxName());
			MShipperPackaging sp = new MShipperPackaging(getCtx(), 0, null);
			sp.setM_Shipper_ID(m_shipper.getM_Shipper_ID());
			sp.setX_ShipperPackaging_ID(xsp.getX_ShipperPackaging_ID());
			sp.setIsDefault(xsp.isDefault());
			sp.setWeight(xsp.getWeight());
			sp.saveEx();				
		}
	}
	
	private void createShipperLabels()
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("X_Shipper_ID=" + m_shipper.getX_Shipper_ID() + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND X_ShipperLabels_ID NOT IN ( ");
		whereClause.append("SELECT X_ShipperLabels_ID ");
		whereClause.append("FROM M_ShipperLabels ");
		whereClause.append("WHERE M_Shipper_ID=" + m_shipper.getM_Shipper_ID() + ")");
		
		int[] xslIds = X_X_ShipperLabels.getAllIDs(X_X_ShipperLabels.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xslId : xslIds)
		{
			X_X_ShipperLabels xsl = new X_X_ShipperLabels(getCtx(), xslId, get_TrxName());
			MShipperLabels sl = new MShipperLabels(getCtx(), 0, null);
			sl.setM_Shipper_ID(m_shipper.getM_Shipper_ID());
			sl.setX_ShipperLabels_ID(xsl.getX_ShipperLabels_ID());
			sl.setIsDefault(xsl.isDefault());
			sl.setLabelPrintMethod(xsl.getLabelPrintMethod());
			sl.saveEx();				
		}
	}
	
	private void createShipperPickupTypes()
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("X_Shipper_ID=" + m_shipper.getX_Shipper_ID() + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND X_ShipperPickupTypes_ID NOT IN ( ");
		whereClause.append("SELECT X_ShipperPickupTypes_ID ");
		whereClause.append("FROM M_ShipperPickupTypes ");
		whereClause.append("WHERE M_Shipper_ID=" + m_shipper.getM_Shipper_ID() + ")");
		
		int[] xsptIds = X_X_ShipperPickupTypes.getAllIDs(X_X_ShipperPickupTypes.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xsptId : xsptIds)
		{
			X_X_ShipperPickupTypes xspt = new X_X_ShipperPickupTypes(getCtx(), xsptId, get_TrxName());
			MShipperPickupTypes spt = new MShipperPickupTypes(getCtx(), 0, null);
			spt.setM_Shipper_ID(m_shipper.getM_Shipper_ID());
			spt.setX_ShipperPickupTypes_ID(xspt.getX_ShipperPickupTypes_ID());
			spt.setIsDefault(xspt.isDefault());
			spt.saveEx();				
		}
	}

}
