package org.compiere.process;

import java.math.BigDecimal;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.I_M_ProductionPlan;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionPlan;
import org.compiere.model.Query;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * 
 * Process to create production lines based on the plans
 * defined for a particular production header
 * @author Paul Bowden
 *
 */
@org.adempiere.base.annotation.Process
public class ProductionCreate extends SvrProcess {

	private int p_M_Production_ID=0;
	private MProduction m_production = null;
	private boolean mustBeStocked = false;  //not used
	private boolean recreate = false;
	private BigDecimal newQty = null;
	private int p_PP_Product_BOM_ID=0;
	
	
	protected void prepare() {
		
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if ("Recreate".equals(name))
				recreate = "Y".equals(para[i].getParameter());
			else if ("ProductionQty".equals(name))
				newQty  = (BigDecimal) para[i].getParameter();
			else if ("PP_Product_BOM_ID".equals(name))
				p_PP_Product_BOM_ID = para[i].getParameterAsInt();
			else
				log.log(Level.WARNING, "Unknown Parameter: " + name);		
		}
		
		p_M_Production_ID = getRecord_ID();
		m_production = new MProduction(getCtx(), p_M_Production_ID, get_TrxName());

	}	//prepare

	@Override
	protected String doIt() throws Exception {

		if ( m_production.get_ID() == 0 )
			throw new AdempiereUserError("Could not load production header");

		if ( m_production.isProcessed() )
			return "Already processed";

		return createLines();

	}
	
	protected String createLines() throws Exception {
		
		int created = 0;
		if (!m_production.isUseProductionPlan()) {
			String msg = validateEndProduct(m_production.getM_Product_ID());
			if (!Util.isEmpty(msg))
				throw new AdempiereUserError(msg);
			
			if (!recreate && "Y".equalsIgnoreCase(m_production.getIsCreated()))
				throw new AdempiereUserError("Production already created.");
			
			if (newQty != null )
				m_production.setProductionQty(newQty);
			
			m_production.deleteLines(get_TrxName());
			created = m_production.createLines(mustBeStocked, p_PP_Product_BOM_ID);
		} else {
			Query planQuery = new Query(getCtx(), I_M_ProductionPlan.Table_Name, "M_ProductionPlan.M_Production_ID=?", get_TrxName());
			List<MProductionPlan> plans = planQuery.setParameters(m_production.getM_Production_ID()).list();
			for(MProductionPlan plan : plans) {
				validateEndProduct(plan.getM_Product_ID());
				
				if (!recreate && "Y".equalsIgnoreCase(m_production.getIsCreated()))
					throw new AdempiereUserError("Production already created.");
				
				plan.deleteLines(get_TrxName());
				int n = plan.createLines(mustBeStocked);
				if ( n == 0 ) 
				{return "Failed to create production lines"; }
				created = created + n;
			}
		}
		if ( created == 0 ) 
		{return "Failed to create production lines"; }
		
		
		m_production.setIsCreated("Y");
		m_production.save(get_TrxName());
		StringBuilder msgreturn = new StringBuilder().append(created).append(" production lines were created");
		return msgreturn.toString();
	}

	private String validateEndProduct(int M_Product_ID) throws Exception {
		MProduction production = new MProduction(Env.getCtx(), 0, get_TrxName());
		return production.validateEndProduct(M_Product_ID);
	}	
}
