/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import java.util.logging.Level;

import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.compiere.model.PaymentProcessor;
import org.compiere.util.CLogger;

/**
 * @author hengsin
 *
 */
public class DefaultPaymentProcessorFactory implements IPaymentProcessorFactory {

	private final static CLogger s_log = CLogger.getCLogger(IPaymentProcessorFactory.class);
			
	/**
	 * default constructor
	 */
	public DefaultPaymentProcessorFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IPaymentProcessorFactory#newPaymentProcessorInstance(java.lang.String)
	 */
	@Override
	public PaymentProcessor newPaymentProcessorInstance(String className) {
		PaymentProcessor myProcessor = null;
		myProcessor = EquinoxExtensionLocator.instance().locate(PaymentProcessor.class, className, null).getExtension();
		if (myProcessor == null) {
			//fall back to dynamic java class loadup
			try {
				Class<?> ppClass = Class.forName(className);
				if (ppClass != null)
					myProcessor = (PaymentProcessor)ppClass.newInstance();
			} catch (Error e1) {   //  NoClassDefFound
				s_log.log(Level.SEVERE, className + " - Error=" + e1.getMessage());
				return null;
			} catch (Exception e2) {
				s_log.log(Level.SEVERE, className, e2);
				return null;
			}
		}
		
		return myProcessor;
	}

}
