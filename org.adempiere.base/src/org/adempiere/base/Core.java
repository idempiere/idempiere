/******************************************************************************
 * This file is part of Adempiere ERP Bazaar                                  *
 * http://www.adempiere.org                                                   *
 *                                                                            *
 * Copyright (C) Jorg Viola			                                          *
 * Copyright (C) Contributors												  *
 *                                                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * Contributors:                                                              *
 * - Heng Sin Low                                                             *
 *****************************************************************************/
package org.adempiere.base;

import java.net.URL;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MPaymentProcessor;
import org.compiere.model.ModelValidator;
import org.compiere.model.PaymentInterface;
import org.compiere.model.PaymentProcessor;
import org.compiere.process.ProcessCall;
import org.compiere.util.CLogger;

/**
 * This is a facade class for the Service Locator.
 * It provides simple access to all core services.
 *
 * @author viola
 * @author hengsin
 */
public class Core {

	private final static CLogger s_log = CLogger.getCLogger(Core.class);

	/**
	 * @return list of active resource finder
	 */
	public static IResourceFinder getResourceFinder() {
		return new IResourceFinder() {

			public URL getResource(String name) {
				List<IResourceFinder> f = Service.locator().list(IResourceFinder.class).getServices();
				for (IResourceFinder finder : f) {
					URL url = finder.getResource(name);
					if (url!=null)
						return url;
				}
				return null;
			}
		};
	}

	/**
	 *
	 * @param tableName
	 * @param columnName
	 * @return list of callout register for tableName.columnName
	 */
	public static List<IColumnCallout> findCallout(String tableName, String columnName) {
		ServiceQuery query = new ServiceQuery();
		query.put("tableName", tableName);
		query.put("columnName", columnName);

		return Service.locator().list(IColumnCallout.class, query).getServices();
	}

	/**
	 *
	 * @param serviceId
	 * @return ProcessCall instance or null if serviceId not found
	 */
	public static ProcessCall getProcess(String serviceId) {
		return Service.locator().locate(ProcessCall.class, "org.adempiere.base.Process", serviceId, null).getService();
	}

	/**
	 *
	 * @param serviceId
	 * @return ModelValidator instance of null if serviceId not found
	 */
	public static ModelValidator getModelValidator(String serviceId) {
		return Service.locator().locate(ModelValidator.class, "org.adempiere.base.ModelValidator", serviceId, null).getService();
	}

	/**
	 *  Get payment processor instance
	 * 	@param mpp payment processor model
	 * 	@param mp payment model
	 *  @return initialized PaymentProcessor or null
	 */
	public static PaymentProcessor getPaymentProcessor(MPaymentProcessor mpp, PaymentInterface mp) {
		if (s_log.isLoggable(Level.FINE))
			s_log.fine("create for " + mpp);
		
		String className = mpp.getPayProcessorClass();
		if (className == null || className.length() == 0) {
			s_log.log(Level.SEVERE, "No PaymentProcessor class name in " + mpp);
			return null;
		}
		//
		PaymentProcessor myProcessor = null;
		myProcessor = Service.locator().locate(PaymentProcessor.class, className, null).getService();
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
		if (myProcessor == null) {
			s_log.log(Level.SEVERE, "Not found in service/extension registry and classpath");
			return null;
		}

		//  Initialize
		myProcessor.initialize(mpp, mp);
		//
		return myProcessor;
	}
}
