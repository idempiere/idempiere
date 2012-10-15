package org.adempiere.webui.apps.form;

import java.util.HashMap;
import java.util.logging.Level;

import org.compiere.grid.IPaymentForm;
import org.compiere.grid.PaymentFormCash;
import org.compiere.grid.PaymentFormCheck;
import org.compiere.grid.PaymentFormCreditCard;
import org.compiere.grid.PaymentFormDirectDebit;
import org.compiere.grid.PaymentFormDirectDeposit;
import org.compiere.grid.PaymentFormMixedPOS;
import org.compiere.grid.PaymentFormOnCredit;
import org.compiere.model.GridTab;
import org.compiere.util.CLogger;

public class WPaymentFormFactory {

	/**	Static Logger	*/
	private static CLogger 	s_log = CLogger.getCLogger (WPaymentFormFactory.class);

	private static HashMap<String, Class<? extends IPaymentForm>> s_registeredClasses = null;
	
	/**
	 * Register custom WPaymentForm* class
	 * @param ad_table_id
	 * @param cl custom class
	 */
	public static final void registerClass(String paymentRule, Class<? extends IPaymentForm> cl)
	{
		s_registeredClasses.put(paymentRule, cl);
		s_log.info("Registered PaymentRule="+paymentRule+", Class="+cl);
	}
	
	static
	{
		// Register defaults:
		s_registeredClasses = new HashMap<String, Class<? extends IPaymentForm>>();
		s_registeredClasses.put(PaymentFormCash.PAYMENTRULE, WPaymentFormCash.class);
		s_registeredClasses.put(PaymentFormCheck.PAYMENTRULE, WPaymentFormCheck.class);
		s_registeredClasses.put(PaymentFormCreditCard.PAYMENTRULE, WPaymentFormCreditCard.class);
		s_registeredClasses.put(PaymentFormDirectDebit.PAYMENTRULE, WPaymentFormDirectDebit.class);
		s_registeredClasses.put(PaymentFormDirectDeposit.PAYMENTRULE, WPaymentFormDirectDeposit.class);
		s_registeredClasses.put(PaymentFormMixedPOS.PAYMENTRULE, WPaymentFormMixedPOS.class);
		s_registeredClasses.put(PaymentFormOnCredit.PAYMENTRULE, WPaymentFormOnCredit.class);
	}
	
	public static IPaymentForm create(int windowNo, GridTab mTab, String paymentRule)
	{
		IPaymentForm retValue = null;
		Class<? extends IPaymentForm> cl = s_registeredClasses.get(paymentRule);
		if (cl != null)
		{
			try
			{
				java.lang.reflect.Constructor<? extends IPaymentForm> ctor = cl.getConstructor(int.class, GridTab.class);
				retValue = ctor.newInstance(windowNo, mTab);
			}
			catch (Throwable e)
			{
				s_log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				return null;
			}
		}
		if (retValue == null)
		{
			s_log.info("Unsupported PaymentRule=" + paymentRule);
			return null;
		}
		return retValue;
	}   //  create
}