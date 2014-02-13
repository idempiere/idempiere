package org.compiere.process;

import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.I_M_ProductionPlan;
import org.compiere.model.MClient;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
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
public class ProductionProcess extends SvrProcess {

	private int p_M_Production_ID=0;
	private Timestamp p_MovementDate = null;
	private MProduction m_production = null;
	private boolean mustBeStocked = false;  //not used
	
	
	protected void prepare() {
		
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
		//	log.fine("prepare - " + para[i]);
			if (para[i].getParameter() == null)
				;
			else if (name.equals("MovementDate"))
				p_MovementDate = (Timestamp)para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);		
		}
		
		p_M_Production_ID = getRecord_ID();
		if (p_M_Production_ID > 0)
			m_production = new MProduction(getCtx(), p_M_Production_ID, get_TrxName());

	}	//prepare

	@Override
	protected String doIt() throws Exception {
		if ( m_production == null || m_production.get_ID() == 0 )
			throw new AdempiereUserError("Could not load production header");
		
		try {
			int processed = ProductionProcess.procesProduction(m_production, p_MovementDate, mustBeStocked);
			StringBuilder msgreturn = new StringBuilder("@Processed@ #").append(processed);
			return msgreturn.toString();
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			return e.getMessage();
		}
	}

	public static int procesProduction(MProduction production, Timestamp movementDate, boolean mustBeStocked) {
		if ( production.getIsCreated().equals("N") )
			throw new AdempiereUserError("Not created");
		
		if ( production.isProcessed() )
			throw new AdempiereUserError("Already processed");
		
		if (movementDate != null)
			production.setMovementDate(movementDate);
		StringBuilder errors = new StringBuilder();
		int processed = 0;
		
		if (!production.isUseProductionPlan()) {
			MProductionLine[] lines = production.getLines();
			errors.append(processLines(production, lines, mustBeStocked));
			if (errors.length() > 0) {
				throw new AdempiereException(errors.toString());
			}
			processed = processed + lines.length;
		} else {
			Query planQuery = new Query(Env.getCtx(), I_M_ProductionPlan.Table_Name, "M_ProductionPlan.M_Production_ID=?", production.get_TrxName());
			List<MProductionPlan> plans = planQuery.setParameters(production.getM_Production_ID()).list();
			for(MProductionPlan plan : plans) {
				MProductionLine[] lines = plan.getLines();
				if (lines.length > 0) {
					errors.append(processLines(production, lines, mustBeStocked));
					if (errors.length() > 0) {
						throw new AdempiereException(errors.toString());
					}
					processed = processed + lines.length;
				}
				plan.setProcessed(true);
				plan.saveEx();
			}
		}
		
		production.setProcessed(true);		
		production.saveEx();
		
		/* Immediate accounting */
		if (MClient.isClientAccountingImmediate()) {
			@SuppressWarnings("unused")
			String ignoreError = DocumentEngine.postImmediate(Env.getCtx(), production.getAD_Client_ID(), production.get_Table_ID(), production.get_ID(), true, production.get_TrxName());						
		}
		
		return processed;		
	}
	
	protected static String processLines(MProduction production, MProductionLine[] lines, boolean mustBeStocked) {
		
		StringBuilder errors = new StringBuilder();
		for ( int i = 0; i<lines.length; i++) {
			String error = lines[i].createTransactions(production.getMovementDate(), mustBeStocked);
			if (!Util.isEmpty(error)) {
				errors.append(error);
			} else { 
				lines[i].setProcessed( true );
				lines[i].saveEx(production.get_TrxName());
			}
		}
		
		return errors.toString();				
	}
}
