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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.model.IAddressValidation;
import org.adempiere.model.IShipmentProcessor;
import org.adempiere.model.ITaxProvider;
import org.adempiere.model.MShipperFacade;
import org.compiere.model.MAddressValidation;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MPaymentProcessor;
import org.compiere.model.MTaxProvider;
import org.compiere.model.ModelValidator;
import org.compiere.model.PaymentInterface;
import org.compiere.model.PaymentProcessor;
import org.compiere.model.StandardTaxProvider;
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
		List<IColumnCallout> list = new ArrayList<IColumnCallout>();
		List<IColumnCalloutFactory> factories = Service.locator().list(IColumnCalloutFactory.class).getServices();
		if (factories != null) {
			for(IColumnCalloutFactory factory : factories) {
				IColumnCallout[] callouts = factory.getColumnCallouts(tableName, columnName);
				if (callouts != null && callouts.length > 0) {
					for(IColumnCallout callout : callouts) {
						list.add(callout);
					}
				}
			}
		}
		return list;
	}

	/**
	 *
	 * @param processId Java class name or equinox extension id
	 * @return ProcessCall instance or null if processId not found
	 */
	public static ProcessCall getProcess(String processId) {
		List<IProcessFactory> factories = Service.locator().list(IProcessFactory.class).getServices();
		if (factories != null && !factories.isEmpty()) {
			for(IProcessFactory factory : factories) {
				ProcessCall process = factory.newProcessInstance(processId);
				if (process != null)
					return process;
			}
		}
		return null; 		
	}

	/**
	 *
	 * @param validatorId Java class name or equinox extension Id
	 * @return ModelValidator instance of null if validatorId not found
	 */
	public static ModelValidator getModelValidator(String validatorId) {
		List<IModelValidatorFactory> factoryList = Service.locator().list(IModelValidatorFactory.class).getServices();
		if (factoryList != null) {
			for(IModelValidatorFactory factory : factoryList) {
				ModelValidator validator = factory.newModelValidatorInstance(validatorId);
				if (validator != null)
					return validator;
			}
		}
		
		return null;
	}

	/**
	 * 
	 * @return keystore
	 */
	public static IKeyStore getKeyStore(){
		return Service.locator().locate(IKeyStore.class).getService();
	}
	
	/**
	 *  Get payment processor instance
	 * 	@param mbap payment processor model
	 * 	@param mp payment model
	 *  @return initialized PaymentProcessor or null
	 */
	public static PaymentProcessor getPaymentProcessor(MBankAccountProcessor mbap, PaymentInterface mp) {
		if (s_log.isLoggable(Level.FINE)) s_log.fine("create for " + mbap);
		
		MPaymentProcessor mpp = new MPaymentProcessor(mbap.getCtx(), mbap.getC_PaymentProcessor_ID(), mbap.get_TrxName());
		String className = mpp.getPayProcessorClass();
		if (className == null || className.length() == 0) {
			s_log.log(Level.SEVERE, "No PaymentProcessor class name in " + mbap);
			return null;
		}
		//
		PaymentProcessor myProcessor = null;
		
		List<IPaymentProcessorFactory> factoryList = Service.locator().list(IPaymentProcessorFactory.class).getServices();
		if (factoryList != null) {
			for(IPaymentProcessorFactory factory : factoryList) {
				PaymentProcessor processor = factory.newPaymentProcessorInstance(className);
				if (processor != null) {
					myProcessor = processor;
					break;
				}
			}
		}
		
		if (myProcessor == null) {
			s_log.log(Level.SEVERE, "Not found in service/extension registry and classpath");
			return null;
		}

		//  Initialize
		myProcessor.initialize(mbap, mp);
		//
		return myProcessor;
	}
	
	/**
	 * 
	 * @param sf
	 * @return shipment process instance or null if not found
	 */
	public static IShipmentProcessor getShipmentProcessor(MShipperFacade sf) 
	{
		if (s_log.isLoggable(Level.FINE)) s_log.fine("create for " + sf);
		
		String className = sf.getShippingProcessorClass();
		if (className == null || className.length() == 0) 
		{
			s_log.log(Level.SEVERE, "Shipment processor class not define for shipper " + sf);
			return null;
		}
		
		List<IShipmentProcessorFactory> factoryList = Service.locator().list(IShipmentProcessorFactory.class).getServices();
		if (factoryList == null) 
			return null;
		for (IShipmentProcessorFactory factory : factoryList)
		{
			IShipmentProcessor processor = factory.newShipmentProcessorInstance(className);
			if (processor != null)
				return processor;
		}
		
		return null;
	}
	
	/**
	 * Get address validation instance
	 * @param validation
	 * @return address validation instance or null if not found
	 */
	public static IAddressValidation getAddressValidation(MAddressValidation validation) 
	{
		String className = validation.getAddressValidationClass();
		if (className == null || className.length() == 0) 
		{
			s_log.log(Level.SEVERE, "Address validation class not defined: " + validation);
			return null;
		}
		
		List<IAddressValidationFactory> factoryList = Service.locator().list(IAddressValidationFactory.class).getServices();
		if (factoryList == null) 
			return null;
		for (IAddressValidationFactory factory : factoryList)
		{
			IAddressValidation processor = factory.newAddressValidationInstance(className);
			if (processor != null)
				return processor;
		}
		
		return null;
	}
	
	/**
	 * Get tax provider instance
	 * @param provider
	 * @return tax provider instance or null if not found
	 */
	public static ITaxProvider getTaxProvider(MTaxProvider provider) 
	{
		ITaxProvider calculator = null;
		if (provider != null)
		{
			if (provider.getC_TaxProvider_ID() == 0)
				return new StandardTaxProvider();
			
			String className = provider.getTaxProviderClass();
			if (className == null || className.length() == 0) 
			{
				s_log.log(Level.SEVERE, "Tax provider class not defined: " + provider);
				return null;
			}
			
			List<ITaxProviderFactory> factoryList = Service.locator().list(ITaxProviderFactory.class).getServices();
			if (factoryList == null) 
				return null;
			for (ITaxProviderFactory factory : factoryList)
			{
				calculator = factory.newTaxProviderInstance(className);
				if (calculator != null)
					return calculator;
			}
		}
		
		return null;
	}
}
