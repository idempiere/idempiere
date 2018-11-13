/******************************************************************************
 * Product: iDempiere Business Suite ERP/CRM/SCM                              *
 * Copyright (C) 2017 Markus Bozem                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *         *
 *****************************************************************************/
package org.adempiere.base;

import java.util.logging.Level;

import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.compiere.util.CLogger;
import org.compiere.util.PaymentExport;

/**
 * @author mbozem
 *
 */
public class DefaultPaymentExporterFactory implements IPaymentExporterFactory {

	private final static CLogger s_log = CLogger.getCLogger(DefaultPaymentExporterFactory.class);
			
	/**
	 * default constructor
	 */
	public DefaultPaymentExporterFactory() {
	}

	@Override
	public PaymentExport newPaymentExporterInstance(String className) {
		PaymentExport myExporter = null;
		myExporter = EquinoxExtensionLocator.instance().locate(PaymentExport.class, className, null).getExtension();
		if (myExporter == null) {
			//fall back to dynamic java class loadup
			try {
				Class<?> peClass = Class.forName(className);
				if (peClass != null)
					myExporter = (PaymentExport)peClass.getDeclaredConstructor().newInstance();
			} catch (Error e1) {   //  NoClassDefFound
				s_log.log(Level.SEVERE, className + " - Error=" + e1.getMessage());
				return null;
			} catch (Exception e2) {
				s_log.log(Level.SEVERE, className, e2);
				return null;
			}
		}
		
		return myExporter;
	}

}
