package org.compiere.process;

import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MPaymentTransaction;
import org.compiere.model.MProcessPara;
import org.compiere.util.Env;
import org.compiere.util.Msg;

@org.adempiere.base.annotation.Process
public class VoidOnlineAuthorizationPaymentTransaction extends SvrProcess {

	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			if (para[i].getParameter() == null)
				;
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}
	
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("Record_ID=" + getRecord_ID());
		//	get Payment
		MPaymentTransaction pt = new MPaymentTransaction (getCtx(), getRecord_ID(), get_TrxName());
		
		if (!pt.getTenderType().equals(MPaymentTransaction.TENDERTYPE_CreditCard) || !pt.isOnline() || !pt.getTrxType().equals(MPaymentTransaction.TRXTYPE_Authorization))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ActionNotSupported"));
		if (pt.isVoided())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PaymentTransactionAlreadyVoided"));
		if (pt.isDelayedCapture())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PaymentTransactionAlreadyDelayedCapture"));
		
		//  Process it
		boolean ok = pt.voidOnlineAuthorizationPaymentTransaction();
		pt.saveEx();
		if (!ok)
			throw new Exception(pt.getErrorMessage());
		return "OK";
	}
}
