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

import javax.script.ScriptEngine;
import javax.script.ScriptEngineFactory;
import javax.script.ScriptEngineManager;

import org.adempiere.model.IAddressValidation;
import org.adempiere.model.IShipmentProcessor;
import org.adempiere.model.ITaxProvider;
import org.adempiere.model.MShipperFacade;
import org.compiere.impexp.BankStatementLoaderInterface;
import org.compiere.impexp.BankStatementMatcherInterface;
import org.compiere.model.Callout;
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
import org.compiere.util.PaymentExport;
import org.compiere.util.ReplenishInterface;
import org.idempiere.fa.service.api.DepreciationFactoryLookupDTO;
import org.idempiere.fa.service.api.IDepreciationMethod;
import org.idempiere.fa.service.api.IDepreciationMethodFactory;

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

	// IDEMPIERE-2732
	/**
	 *
	 * @param className
	 * @param method 
	 * @return callout for className
	 */
	public static Callout getCallout(String className, String methodName) {
		List<ICalloutFactory> factories = Service.locator().list(ICalloutFactory.class).getServices();
		if (factories != null) {
			for(ICalloutFactory factory : factories) {
				Callout callout = factory.getCallout(className, methodName);
				if (callout != null) {
					return callout;
				}
			}
		}
		return null;
	}

	/**
	 *
	 * @param processId Java class name or equinox extension id
	 * @return ProcessCall instance or null if processId not found
	 */
	public static ProcessCall getProcess(String processId) {
		List<IProcessFactory> factories = getProcessFactories();
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
	 * This method load the process factories waiting until the DefaultProcessFactory on base is loaded (IDEMPIERE-3829)
	 * @return List of factories implementing IProcessFactory
	 */
	private static List<IProcessFactory> getProcessFactories() {
		List<IProcessFactory> factories = null;
		int maxIterations = 5;
		int waitMillis = 1000;
		int iterations = 0;
		boolean foundDefault = false;
		while (true) {
			factories = Service.locator().list(IProcessFactory.class).getServices();
			if (factories != null && !factories.isEmpty()) {
				for(IProcessFactory factory : factories) {
					// wait until DefaultProcessFactory is loaded
					if (factory instanceof DefaultProcessFactory) {
						foundDefault = true;
						break;
					}
				}
			}
			iterations++;
			if (foundDefault || iterations >= maxIterations) {
				break;
			}
			try {
				Thread.sleep(waitMillis);
			} catch (InterruptedException e) {
			}
		}
		return factories;
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
	 * get BankStatementLoader instance
	 * 
	 * @param className
	 * @return instance of the BankStatementLoaderInterface or null
	 */
	public static BankStatementLoaderInterface getBankStatementLoader(String className){
		if (className == null || className.length() == 0) {
			s_log.log(Level.SEVERE, "No BankStatementLoaderInterface class name");
			return null;
		}

		BankStatementLoaderInterface myBankStatementLoader = null;
		
		List<IBankStatementLoaderFactory> factoryList = 
				Service.locator().list(IBankStatementLoaderFactory.class).getServices();
		if (factoryList != null) {
			for(IBankStatementLoaderFactory factory : factoryList) {
				BankStatementLoaderInterface loader = factory.newBankStatementLoaderInstance(className);
				if (loader != null) {
					myBankStatementLoader = loader;
					break;
				}
			}
		}
		
		if (myBankStatementLoader == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myBankStatementLoader;
	}
	
	/**
	 * get BankStatementMatcher instance
	 * 
	 * @param className
	 * @return instance of the BankStatementMatcherInterface or null
	 */
	public static BankStatementMatcherInterface getBankStatementMatcher(String className){
		if (className == null || className.length() == 0) {
			s_log.log(Level.SEVERE, "No BankStatementMatcherInterface class name");
			return null;
		}

		BankStatementMatcherInterface myBankStatementMatcher = null;
		
		List<IBankStatementMatcherFactory> factoryList = 
				Service.locator().list(IBankStatementMatcherFactory.class).getServices();
		if (factoryList != null) {
			for(IBankStatementMatcherFactory factory : factoryList) {
				BankStatementMatcherInterface matcher = factory.newBankStatementMatcherInstance(className);
				if (matcher != null) {
					myBankStatementMatcher = matcher;
					break;
				}
			}
		}
		
		if (myBankStatementMatcher == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myBankStatementMatcher;
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
			s_log.log(Level.SEVERE, "Shipment processor or class not defined for shipper " + sf);
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
			
			if (!provider.isActive())
			{
				s_log.log(Level.SEVERE, "Tax provider is inactive: " + provider);
				return null;
			}
			
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
	
	/**
	 * get Custom Replenish instance
	 * 
	 * @param className
	 * @return instance of the ReplenishInterface or null
	 */
	public static ReplenishInterface getReplenish(String className){
		if (className == null || className.length() == 0) {
			s_log.log(Level.SEVERE, "No ReplenishInterface class name");
			return null;
		}

		ReplenishInterface myReplenishInstance = null;
		
		List<IReplenishFactory> factoryList = 
				Service.locator().list(IReplenishFactory.class).getServices();
		if (factoryList != null) {
			for(IReplenishFactory factory : factoryList) {
				ReplenishInterface loader = factory.newReplenishInstance(className);
				if (loader != null) {
					myReplenishInstance = loader;
					break;
				}
			}
		}
		
		if (myReplenishInstance == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myReplenishInstance;
	}
	

	/** Get script engine 
	 * 
	 * @param engineName
	 * @return ScriptEngine found, or null
	 */
	public static ScriptEngine getScriptEngine(String engineName)
	{
		ScriptEngineManager manager = new ScriptEngineManager(Core.class.getClassLoader());
		ScriptEngine engine = manager.getEngineByName(engineName);
		if (engine != null)
			return engine;
		
		List<ScriptEngineFactory> factoryList = 
				Service.locator().list(ScriptEngineFactory.class).getServices();
		if (factoryList != null) {
			for(ScriptEngineFactory factory : factoryList) {
				for (String name : factory.getNames()) {
					if (engineName.equals(name)) {
						return factory.getScriptEngine();
					}
				}
			}
		}
		
		return null;
	}
	
	/**
	 * get PaymentExporter instance
	 * 
	 * @param className
	 * @return instance of the PaymentExporterInterface or null
	 */
	public static PaymentExport getPaymentExporter (String className){
		if (className == null || className.length() == 0) {
			s_log.log(Level.SEVERE, "No PaymentExporter class name");
			return null;
		}

		PaymentExport myPaymentExporter = null;
		
		List<IPaymentExporterFactory> factoryList = 
				Service.locator().list(IPaymentExporterFactory.class).getServices();
		if (factoryList != null) {
			for(IPaymentExporterFactory factory : factoryList) {
				PaymentExport exporter = factory.newPaymentExporterInstance(className);
				if (exporter != null) {
					myPaymentExporter = exporter;
					break;
				}
			}
		}
		
		if (myPaymentExporter == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myPaymentExporter;
	}	

	/**
	 * get ProductPricing instance
	 * 
	 * @return instance of the IProductPricing or null
	 */
	public static IProductPricing getProductPricing() {

		List<IProductPricingFactory> factoryList = 
				Service.locator().list(IProductPricingFactory.class).getServices();
		if (factoryList != null) {
			for(IProductPricingFactory factory : factoryList) {
				IProductPricing myProductPricing = factory.newProductPricingInstance();
				if (myProductPricing != null) {
					return myProductPricing;
				}
			}
		}

		return null;
	}
	
	/**
	 * lookup implement {@link IDepreciationMethod}
	 * @param factoryLookupDTO
	 * @return
	 */
	public static IDepreciationMethod getDepreciationMethod(DepreciationFactoryLookupDTO factoryLookupDTO) {

		List<IDepreciationMethodFactory> factoryList = 
				Service.locator().list(IDepreciationMethodFactory.class).getServices();
		if (factoryList != null) {
			for(IDepreciationMethodFactory factory : factoryList) {
				IDepreciationMethod depreciationMethod = factory.getDepreciationMethod(factoryLookupDTO);
				if (depreciationMethod != null) {
					return depreciationMethod;
				}
			}
		}

		return null;
	}

}
