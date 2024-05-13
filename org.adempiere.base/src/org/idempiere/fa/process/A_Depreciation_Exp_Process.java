/******************************************************************************
 * Copyright (C) 2008 SC ARHIPAC SERVICE SRL. All Rights Reserved.            *
 *****************************************************************************/
package org.idempiere.fa.process;

import org.compiere.model.MDepreciationExp;
import org.compiere.process.SvrProcess;

/**
 * Process to process depreciation expenses ({@link MDepreciationExp})
 * @author Teo_Sarca, SC ARHIPAC SERVICE SRL
 */
@org.adempiere.base.annotation.Process
public class A_Depreciation_Exp_Process extends SvrProcess {
	
	@Override
	protected void prepare()
	{
	}
	
	@Override
	protected String doIt() throws Exception
	{
		MDepreciationExp depexp = new MDepreciationExp(getCtx(), getRecord_ID(), get_TrxName());
		depexp.process();
		return "@Processed@";
	}
}
