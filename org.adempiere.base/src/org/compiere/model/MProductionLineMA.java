package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

public class MProductionLineMA extends X_M_ProductionLineMA {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2633782218494352620L;

	public MProductionLineMA(Properties ctx, int M_ProductionLineMA_ID,
			String trxName) {
		super(ctx, M_ProductionLineMA_ID, trxName);
	}

	public MProductionLineMA(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * Parent constructor
	 * @param parent
	 * @param asi
	 * @param qty
	 * @param dateMaterialPolicy
	 */
	public MProductionLineMA( MProductionLine parent, int asi, BigDecimal qty,Timestamp dateMaterialPolicy)	{		
		super(parent.getCtx(),0,parent.get_TrxName());
		setM_AttributeSetInstance_ID(asi);
		setM_ProductionLine_ID(parent.get_ID());
		setMovementQty(qty);
		setAD_Org_ID(parent.getAD_Org_ID());
		if (dateMaterialPolicy == null)
		{
			if (asi > 0)
			{
				dateMaterialPolicy = MStorageOnHand.getDateMaterialPolicy(parent.getM_Product_ID(), asi, parent.get_TrxName());
			}
			if (dateMaterialPolicy == null)
			{
				dateMaterialPolicy = parent.getM_Production().getMovementDate();
			}
		}
		setDateMaterialPolicy(dateMaterialPolicy);
	}
	
	@Override
	public void setDateMaterialPolicy(Timestamp DateMaterialPolicy) {
		if (DateMaterialPolicy != null)
			DateMaterialPolicy = Util.removeTime(DateMaterialPolicy);
		super.setDateMaterialPolicy(DateMaterialPolicy);
	}
	
	public static MProductionLineMA get( MProductionLine parent, int asi, Timestamp dateMPolicy )  {
		String where = " M_ProductionLine_ID = ? AND M_AttributeSetInstance_ID = ? ";
		if(dateMPolicy==null){
			dateMPolicy = new Timestamp(new Date().getTime());
		}
		where = where + "AND DateMaterialPolicy = trunc(cast(? as date))";
		
		MProductionLineMA lineMA = MTable.get(parent.getCtx(), MProductionLineMA.Table_Name).createQuery(where, parent.get_TrxName())
		.setParameters(parent.getM_ProductionLine_ID(), asi,dateMPolicy).first();
		
		if (lineMA != null)
			return lineMA;
		else
			return new MProductionLineMA( parent,
				asi,
				Env.ZERO,dateMPolicy);
	}

	/**
	 * 	Get Material Allocations for Line
	 *	@param ctx context
	 *	@param M_ProductionLine_ID line
	 *	@param trxName trx
	 *	@return allocations
	 */
	public static MProductionLineMA[] get (Properties ctx, int M_ProductionLine_ID, String trxName)
	{
	
		Query query = MTable.get(ctx, MProductionLineMA.Table_Name)
							.createQuery(I_M_ProductionLineMA.COLUMNNAME_M_ProductionLine_ID+"=?", trxName);
		query.setParameters(M_ProductionLine_ID);
		List<MProductionLineMA> list = query.list();		
		MProductionLineMA[] retValue = list.toArray (new MProductionLineMA[0]);		
		return retValue;
	}	//	get
	
	@Override
	protected boolean beforeSave(boolean newRecord) 
	{
		MProductionLine parentLine = new MProductionLine(getCtx(), getM_ProductionLine_ID(), get_TrxName());
		MProduction prodParent;
		if (parentLine.getM_Production_ID() > 0) {
			prodParent = new MProduction(getCtx(), parentLine.getM_Production_ID(), get_TrxName());
		} else {
			MProductionPlan plan = new MProductionPlan(getCtx(), parentLine.getM_ProductionPlan_ID(), get_TrxName());
			prodParent = new MProduction(getCtx(), plan.getM_Production_ID(), get_TrxName());
		}
		if (newRecord && prodParent.isProcessed()) {
			log.saveError("ParentComplete", Msg.translate(getCtx(), "M_Production_ID"));
			return false;
		}
		return true;
	}

}
