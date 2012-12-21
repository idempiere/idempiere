package org.adempiere.process;

import java.math.BigDecimal;
import java.util.logging.Level;

import org.compiere.model.X_X_Shipper;
import org.compiere.model.X_X_ShipperLabels;
import org.compiere.model.X_X_ShipperPackaging;
import org.compiere.model.X_X_ShipperPickupTypes;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

public class ShipperCopyFrom extends SvrProcess
{
	private int		p_X_Shipper_ID = 0;

	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals(X_X_Shipper.COLUMNNAME_X_Shipper_ID))
				p_X_Shipper_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception 
	{
		int To_X_Shipper_ID = getRecord_ID();
		log.info("From X_Shipper_ID=" + p_X_Shipper_ID + " to " + To_X_Shipper_ID);
		if (To_X_Shipper_ID == 0)
			throw new IllegalArgumentException("Target X_Shipper_ID == 0");
		if (p_X_Shipper_ID == 0)
			throw new IllegalArgumentException("Source X_Shipper_ID == 0");
		
		createShipperPackaging(To_X_Shipper_ID);
		createShipperLabels(To_X_Shipper_ID);
		createShipperPickupTypes(To_X_Shipper_ID);
		
		return "OK";
	}
	
	private void createShipperPackaging(int To_X_Shipper_ID)
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("X_Shipper_ID=" + p_X_Shipper_ID + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND X_ShipperPackaging_ID NOT IN ( ");
		whereClause.append("SELECT X_ShipperPackaging_ID ");
		whereClause.append("FROM X_ShipperPackaging ");
		whereClause.append("WHERE X_Shipper_ID=" + To_X_Shipper_ID + ")");
		
		int[] xspIds = X_X_ShipperPackaging.getAllIDs(X_X_ShipperPackaging.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xspId : xspIds)
		{
			X_X_ShipperPackaging xsp = new X_X_ShipperPackaging(getCtx(), xspId, get_TrxName());
			X_X_ShipperPackaging sp = new X_X_ShipperPackaging(getCtx(), 0, null);
			sp.setDescription(xsp.getDescription());
			sp.setIsActive(xsp.isActive());
			sp.setIsDefault(xsp.isDefault());
			sp.setName(xsp.getName());
			sp.setValue(xsp.getValue());
			sp.setWeight(xsp.getWeight());
			sp.setX_Shipper_ID(To_X_Shipper_ID);
			sp.saveEx();				
		}
	}
	
	private void createShipperLabels(int To_X_Shipper_ID)
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("X_Shipper_ID=" + p_X_Shipper_ID + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND X_ShipperLabels_ID NOT IN ( ");
		whereClause.append("SELECT X_ShipperLabels_ID ");
		whereClause.append("FROM X_ShipperLabels ");
		whereClause.append("WHERE X_Shipper_ID=" + To_X_Shipper_ID + ")");
		
		int[] xslIds = X_X_ShipperLabels.getAllIDs(X_X_ShipperLabels.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xslId : xslIds)
		{
			X_X_ShipperLabels xsl = new X_X_ShipperLabels(getCtx(), xslId, get_TrxName());
			X_X_ShipperLabels sl = new X_X_ShipperLabels(getCtx(), 0, null);
			sl.setDescription(xsl.getDescription());
			sl.setHeight(xsl.getHeight());
			sl.setIsActive(xsl.isActive());
			sl.setIsDefault(xsl.isDefault());
			sl.setLabelPrintMethod(xsl.getLabelPrintMethod());
			sl.setName(xsl.getName());
			sl.setValue(xsl.getValue());
			sl.setWidth(xsl.getWidth());
			sl.setX_Shipper_ID(To_X_Shipper_ID);
			sl.saveEx();				
		}
	}
	
	private void createShipperPickupTypes(int To_X_Shipper_ID)
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("X_Shipper_ID=" + p_X_Shipper_ID + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND X_ShipperPickupTypes_ID NOT IN ( ");
		whereClause.append("SELECT X_ShipperPickupTypes_ID ");
		whereClause.append("FROM X_ShipperPickupTypes ");
		whereClause.append("WHERE X_Shipper_ID=" + To_X_Shipper_ID + ")");
		
		int[] xsptIds = X_X_ShipperPickupTypes.getAllIDs(X_X_ShipperPickupTypes.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xsptId : xsptIds)
		{
			X_X_ShipperPickupTypes xspt = new X_X_ShipperPickupTypes(getCtx(), xsptId, get_TrxName());
			X_X_ShipperPickupTypes spt = new X_X_ShipperPickupTypes(getCtx(), 0, null);
			spt.setDescription(xspt.getDescription());
			spt.setIsActive(xspt.isActive());
			spt.setIsDefault(xspt.isDefault());
			spt.setName(xspt.getName());
			spt.setValue(xspt.getValue());
			spt.setX_Shipper_ID(To_X_Shipper_ID);			
			spt.saveEx();				
		}
	}

}
