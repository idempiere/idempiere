package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.idempiere.cache.ImmutablePOSupport;

public class MProcessDrillRulePara extends X_AD_Process_DrillRule_Para implements ImmutablePOSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1460684182951511710L;
	
	public MProcessDrillRulePara(Properties ctx, int AD_Process_DrillRule_Para_ID, String trxName) {
		super(ctx, AD_Process_DrillRule_Para_ID, trxName);
	}

	public MProcessDrillRulePara(Properties ctx, int AD_Process_DrillRule_Para_ID, String trxName,
			String[] virtualColumns) {
		super(ctx, AD_Process_DrillRule_Para_ID, trxName, virtualColumns);
	}

	public MProcessDrillRulePara(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/** Parameter Column Name		*/
	private MProcessPara	m_parameter = null;


	/**
	 * 	Get Parameter Column Name
	 *	@return column name
	 */
	public String getColumnName()
	{
		if (m_parameter == null)
			m_parameter = MProcessPara.get(getCtx(), getAD_Process_Para_ID());
		return m_parameter.getColumnName();
	}	//	getColumnName

	/**
	 * 	Get Display Type
	 *	@return display type
	 */
	public int getDisplayType()
	{
		if (m_parameter == null)
			m_parameter = MProcessPara.get(getCtx(), getAD_Process_Para_ID());
		return m_parameter.getAD_Reference_ID();
	}	//	getDisplayType

	@Override
	public PO markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
}