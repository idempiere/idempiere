package org.compiere.wf;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.model.Query;
import org.compiere.model.X_AD_WF_Node_Var;

public class MWFNodeVar extends X_AD_WF_Node_Var
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 82706241630223131L;

	/**
	 * 
	 * @param ctx
	 * @param id
	 * @param trxName
	 */
	public MWFNodeVar (Properties ctx, int id, String trxName)
	{
		super (ctx, id, trxName);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MWFNodeVar (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param AD_WF_Node_ID
	 * @return
	 */
	public static MWFNodeVar[] getNodeVars (Properties ctx, int AD_WF_Node_ID) {
		List<MWFNodeVar> list = new Query(ctx, Table_Name, "AD_WF_Node_ID=?", null)
				.setOnlyActiveRecords(true)
				.setParameters(new Object[]{AD_WF_Node_ID})
				.list();
		MWFNodeVar[] retValue = new MWFNodeVar[list.size ()];
			list.toArray (retValue);
			return retValue;
	}
}
