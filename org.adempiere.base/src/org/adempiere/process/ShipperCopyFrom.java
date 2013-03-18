package org.adempiere.process;

import java.math.BigDecimal;
import java.util.logging.Level;

import org.compiere.model.X_M_ShipperCfg;
import org.compiere.model.X_M_ShipperLabelsCfg;
import org.compiere.model.X_M_ShipperPackagingCfg;
import org.compiere.model.X_M_ShipperPickupTypesCfg;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

public class ShipperCopyFrom extends SvrProcess
{
	private int		p_M_ShipperCfg_ID = 0;

	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals(X_M_ShipperCfg.COLUMNNAME_M_ShipperCfg_ID))
				p_M_ShipperCfg_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception 
	{
		int To_M_ShipperCfg_ID = getRecord_ID();
		if (log.isLoggable(Level.INFO)) log.info("From M_ShipperCfg_ID=" + p_M_ShipperCfg_ID + " to " + To_M_ShipperCfg_ID);
		if (To_M_ShipperCfg_ID == 0)
			throw new IllegalArgumentException("Target M_ShipperCfg_ID == 0");
		if (p_M_ShipperCfg_ID == 0)
			throw new IllegalArgumentException("Source M_ShipperCfg_ID == 0");
		
		createShipperPackaging(To_M_ShipperCfg_ID);
		createShipperLabels(To_M_ShipperCfg_ID);
		createShipperPickupTypes(To_M_ShipperCfg_ID);
		
		return "OK";
	}
	
	private void createShipperPackaging(int To_M_ShipperCfg_ID)
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("M_ShipperCfg_ID=" + p_M_ShipperCfg_ID + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND M_ShipperPackagingCfg_ID NOT IN ( ");
		whereClause.append("SELECT M_ShipperPackagingCfg_ID ");
		whereClause.append("FROM M_ShipperPackagingCfg ");
		whereClause.append("WHERE M_ShipperCfg_ID=" + To_M_ShipperCfg_ID + ")");
		
		int[] xspIds = X_M_ShipperPackagingCfg.getAllIDs(X_M_ShipperPackagingCfg.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xspId : xspIds)
		{
			X_M_ShipperPackagingCfg xsp = new X_M_ShipperPackagingCfg(getCtx(), xspId, get_TrxName());
			X_M_ShipperPackagingCfg sp = new X_M_ShipperPackagingCfg(getCtx(), 0, null);
			sp.setDescription(xsp.getDescription());
			sp.setIsActive(xsp.isActive());
			sp.setIsDefault(xsp.isDefault());
			sp.setName(xsp.getName());
			sp.setValue(xsp.getValue());
			sp.setWeight(xsp.getWeight());
			sp.setM_ShipperCfg_ID(To_M_ShipperCfg_ID);
			sp.saveEx();				
		}
	}
	
	private void createShipperLabels(int To_M_ShipperCfg_ID)
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("M_ShipperCfg_ID=" + p_M_ShipperCfg_ID + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND M_ShipperLabelsCfg_ID NOT IN ( ");
		whereClause.append("SELECT M_ShipperLabelsCfg_ID ");
		whereClause.append("FROM M_ShipperLabelsCfg ");
		whereClause.append("WHERE M_ShipperCfg_ID=" + To_M_ShipperCfg_ID + ")");
		
		int[] xslIds = X_M_ShipperLabelsCfg.getAllIDs(X_M_ShipperLabelsCfg.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xslId : xslIds)
		{
			X_M_ShipperLabelsCfg xsl = new X_M_ShipperLabelsCfg(getCtx(), xslId, get_TrxName());
			X_M_ShipperLabelsCfg sl = new X_M_ShipperLabelsCfg(getCtx(), 0, null);
			sl.setDescription(xsl.getDescription());
			sl.setHeight(xsl.getHeight());
			sl.setIsActive(xsl.isActive());
			sl.setIsDefault(xsl.isDefault());
			sl.setLabelPrintMethod(xsl.getLabelPrintMethod());
			sl.setName(xsl.getName());
			sl.setValue(xsl.getValue());
			sl.setWidth(xsl.getWidth());
			sl.setM_ShipperCfg_ID(To_M_ShipperCfg_ID);
			sl.saveEx();				
		}
	}
	
	private void createShipperPickupTypes(int To_M_ShipperCfg_ID)
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("M_ShipperCfg_ID=" + p_M_ShipperCfg_ID + " ");
		whereClause.append("AND IsActive='Y' ");
		whereClause.append("AND M_ShipperPickupTypesCfg_ID NOT IN ( ");
		whereClause.append("SELECT M_ShipperPickupTypesCfg_ID ");
		whereClause.append("FROM M_ShipperPickupTypesCfg ");
		whereClause.append("WHERE M_ShipperCfg_ID=" + To_M_ShipperCfg_ID + ")");
		
		int[] xsptIds = X_M_ShipperPickupTypesCfg.getAllIDs(X_M_ShipperPickupTypesCfg.Table_Name, whereClause.toString(), get_TrxName());		
		for (int xsptId : xsptIds)
		{
			X_M_ShipperPickupTypesCfg xspt = new X_M_ShipperPickupTypesCfg(getCtx(), xsptId, get_TrxName());
			X_M_ShipperPickupTypesCfg spt = new X_M_ShipperPickupTypesCfg(getCtx(), 0, null);
			spt.setDescription(xspt.getDescription());
			spt.setIsActive(xspt.isActive());
			spt.setIsDefault(xspt.isDefault());
			spt.setName(xspt.getName());
			spt.setValue(xspt.getValue());
			spt.setM_ShipperCfg_ID(To_M_ShipperCfg_ID);			
			spt.saveEx();				
		}
	}

}
