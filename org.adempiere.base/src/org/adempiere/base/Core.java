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
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.PaymentExport;
import org.compiere.util.ReplenishInterface;
import org.idempiere.distributed.ICacheService;
import org.idempiere.distributed.IClusterService;
import org.idempiere.distributed.IMessageService;
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

	private static final CCache<String, IServiceReferenceHolder<IResourceFinder>> s_resourceFinderCache = new CCache<>(null, "IResourceFinder", 100, false);
	
	/**
	 * @return list of active resource finder
	 */
	public static IResourceFinder getResourceFinder() {
		return new IResourceFinder() {

			public URL getResource(String name) {
				IServiceReferenceHolder<IResourceFinder> cache = s_resourceFinderCache.get(name);
				if (cache != null) {
					IResourceFinder service = cache.getService();
					if (service != null) {
						URL url = service.getResource(name);
						if (url!=null)
							return url;
					}
					s_resourceFinderCache.remove(name);
				}
				List<IServiceReferenceHolder<IResourceFinder>> f = Service.locator().list(IResourceFinder.class).getServiceReferences();
				for (IServiceReferenceHolder<IResourceFinder> finder : f) {
					IResourceFinder service = finder.getService();
					if (service != null) {
						URL url = service.getResource(name);
						if (url!=null) {
							s_resourceFinderCache.put(name, finder);
							return url;
						}
					}
				}
				return null;
			}
		};
	}
	
	private static final CCache<String, List<IServiceReferenceHolder<IColumnCalloutFactory>>> s_columnCalloutFactoryCache = new CCache<>(null, "List<IColumnCalloutFactory>", 100, false);

	/**
	 *
	 * @param tableName
	 * @param columnName
	 * @return list of callout register for tableName.columnName
	 */
	public static List<IColumnCallout> findCallout(String tableName, String columnName) {
		List<IColumnCallout> list = new ArrayList<IColumnCallout>();
		
		String cacheKey = tableName + "." + columnName;
		List<IServiceReferenceHolder<IColumnCalloutFactory>> cache = s_columnCalloutFactoryCache.get(cacheKey);
		if (cache != null) {
			boolean staleReference = false;
			for (IServiceReferenceHolder<IColumnCalloutFactory> factory : cache) {
				IColumnCalloutFactory service = factory.getService();
				if (service != null) {
					IColumnCallout[] callouts = service.getColumnCallouts(tableName, columnName);
					if (callouts != null && callouts.length > 0) {
						for(IColumnCallout callout : callouts) {
							list.add(callout);
						}
					} else {						
						staleReference = true;
						break;
					}
				} else {
					staleReference = true;
					break;
				}
			}
			if (!staleReference)
				return list;
			else
				s_columnCalloutFactoryCache.remove(cacheKey);
		}
		
		List<IServiceReferenceHolder<IColumnCalloutFactory>> factories = Service.locator().list(IColumnCalloutFactory.class).getServiceReferences();
		List<IServiceReferenceHolder<IColumnCalloutFactory>> found = new ArrayList<>();
		if (factories != null) {
			for(IServiceReferenceHolder<IColumnCalloutFactory> factory : factories) {
				IColumnCalloutFactory service = factory.getService();
				if (service != null) {
					IColumnCallout[] callouts = service.getColumnCallouts(tableName, columnName);
					if (callouts != null && callouts.length > 0) {
						for(IColumnCallout callout : callouts) {
							list.add(callout);						
						}
						found.add(factory);
					}
				}
			}
			s_columnCalloutFactoryCache.put(cacheKey, found);
		}
		return list;
	}

	private static final CCache<String, IServiceReferenceHolder<ICalloutFactory>> s_calloutFactoryCache = new CCache<>(null, "ICalloutFactory", 100, false);
	
	// IDEMPIERE-2732
	/**
	 *
	 * @param className
	 * @param method 
	 * @return callout for className
	 */
	public static Callout getCallout(String className, String methodName) {
		String cacheKey = className + "::" + methodName;
		IServiceReferenceHolder<ICalloutFactory> cache = s_calloutFactoryCache.get(cacheKey);
		if (cache != null) {
			ICalloutFactory service = cache.getService();
			if (service != null) {
				Callout callout = service.getCallout(className, methodName);
				if (callout != null) {
					return callout;
				}
			}
			s_calloutFactoryCache.remove(cacheKey);
		}
		List<IServiceReferenceHolder<ICalloutFactory>> factories = Service.locator().list(ICalloutFactory.class).getServiceReferences();
		if (factories != null) {
			for(IServiceReferenceHolder<ICalloutFactory> factory : factories) {
				ICalloutFactory service = factory.getService();
				if (service != null) {
					Callout callout = service.getCallout(className, methodName);
					if (callout != null) {
						s_calloutFactoryCache.put(cacheKey, factory);
						return callout;
					}
				}
			}
		}
		return null;
	}

	private static final CCache<String, IServiceReferenceHolder<IProcessFactory>> s_processFactoryCache = new CCache<>(null, "IProcessFactory", 100, false);
	
	/**
	 *
	 * @param processId Java class name or equinox extension id
	 * @return ProcessCall instance or null if processId not found
	 */
	public static ProcessCall getProcess(String processId) {
		IServiceReferenceHolder<IProcessFactory> cache = s_processFactoryCache.get(processId);
		if (cache != null) {
			IProcessFactory service = cache.getService();
			if (service != null) {
				ProcessCall process = service.newProcessInstance(processId);
				if (process != null)
					return process;
			}
			s_processFactoryCache.remove(processId);
		}
		
		List<IServiceReferenceHolder<IProcessFactory>> factories = getProcessFactories();
		if (factories != null && !factories.isEmpty()) {
			for(IServiceReferenceHolder<IProcessFactory> factory : factories) {
				IProcessFactory service = factory.getService();
				if (service != null) {
					ProcessCall process = service.newProcessInstance(processId);
					if (process != null) {
						s_processFactoryCache.put(processId, factory);
						return process;
					}
				}
			}
		}
		return null; 		
	}

	/**
	 * This method load the process factories waiting until the DefaultProcessFactory on base is loaded (IDEMPIERE-3829)
	 * @return List of factories implementing IProcessFactory
	 */
	private static List<IServiceReferenceHolder<IProcessFactory>> getProcessFactories() {
		List<IServiceReferenceHolder<IProcessFactory>> factories = null;
		int maxIterations = 5;
		int waitMillis = 1000;
		int iterations = 0;
		boolean foundDefault = false;
		while (true) {
			factories = Service.locator().list(IProcessFactory.class).getServiceReferences();
			if (factories != null && !factories.isEmpty()) {
				for(IServiceReferenceHolder<IProcessFactory> factory : factories) {
					// wait until DefaultProcessFactory is loaded
					IProcessFactory service = factory.getService();
					if (service instanceof DefaultProcessFactory) {
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

	private static final CCache<String, IServiceReferenceHolder<IModelValidatorFactory>> s_modelValidatorFactoryCache = new CCache<>(null, "IModelValidatorFactory", 100, false);
	
	/**
	 *
	 * @param validatorId Java class name or equinox extension Id
	 * @return ModelValidator instance of null if validatorId not found
	 */
	public static ModelValidator getModelValidator(String validatorId) {
		IServiceReferenceHolder<IModelValidatorFactory> cache = s_modelValidatorFactoryCache.get(validatorId);
		if (cache != null) {
			IModelValidatorFactory service = cache.getService();
			if (service != null) {
				ModelValidator validator = service.newModelValidatorInstance(validatorId);
				if (validator != null)
					return validator;
			}
			s_modelValidatorFactoryCache.remove(validatorId);
		}
		List<IServiceReferenceHolder<IModelValidatorFactory>> factoryList = Service.locator().list(IModelValidatorFactory.class).getServiceReferences();
		if (factoryList != null) {
			for(IServiceReferenceHolder<IModelValidatorFactory> factory : factoryList) {
				IModelValidatorFactory service = factory.getService();
				if (service != null) {
					ModelValidator validator = service.newModelValidatorInstance(validatorId);
					if (validator != null) {
						s_modelValidatorFactoryCache.put(validatorId, factory);
						return validator;
					}
				}
			}
		}
		
		return null;
	}

	private static IServiceReferenceHolder<IKeyStore> s_keystoreServiceReference = null;
	
	/**
	 * 
	 * @return {@link IKeyStore}
	 */
	public static IKeyStore getKeyStore(){
		IKeyStore keystoreService = null;
		if (s_keystoreServiceReference != null) {
			keystoreService = s_keystoreServiceReference.getService();
			if (keystoreService != null)
				return keystoreService;
		}
		IServiceReferenceHolder<IKeyStore> serviceReference = Service.locator().locate(IKeyStore.class).getServiceReference();
		if (serviceReference != null) {
			keystoreService = serviceReference.getService();
			s_keystoreServiceReference = serviceReference;
		}
		return keystoreService;
	}
	
	private static final CCache<String, IServiceReferenceHolder<IPaymentProcessorFactory>> s_paymentProcessorFactoryCache = new CCache<>(null, "IPaymentProcessorFactory", 100, false);
	
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
		IServiceReferenceHolder<IPaymentProcessorFactory> cache = s_paymentProcessorFactoryCache.get(className);
		if (cache != null) {
			IPaymentProcessorFactory service = cache.getService();
			if (service != null) {
				PaymentProcessor processor = service.newPaymentProcessorInstance(className);
				if (processor != null) 
					myProcessor = processor;
			}
			if (myProcessor == null)
				s_paymentProcessorFactoryCache.remove(className);
		}
		
		if (myProcessor == null) {
			List<IServiceReferenceHolder<IPaymentProcessorFactory>> factoryList = Service.locator().list(IPaymentProcessorFactory.class).getServiceReferences();
			if (factoryList != null) {
				for(IServiceReferenceHolder<IPaymentProcessorFactory> factory : factoryList) {
					IPaymentProcessorFactory service = factory.getService();
					if (service != null) {
						PaymentProcessor processor = service.newPaymentProcessorInstance(className);
						if (processor != null) {
							myProcessor = processor;
							s_paymentProcessorFactoryCache.put(className, factory);
							break;
						}
					}
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
	
	private static final CCache<String, IServiceReferenceHolder<IBankStatementLoaderFactory>> s_bankStatementLoaderFactoryCache = new CCache<>(null, "IBankStatementLoaderFactory", 100, false);
	
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
		IServiceReferenceHolder<IBankStatementLoaderFactory> cache = s_bankStatementLoaderFactoryCache.get(className);
		if (cache != null) {
			IBankStatementLoaderFactory service = cache.getService();
			if (service != null) {
				BankStatementLoaderInterface loader = service.newBankStatementLoaderInstance(className);
				if (loader != null) 
					myBankStatementLoader = loader;
			}
			if (myBankStatementLoader == null)
				s_bankStatementLoaderFactoryCache.remove(className);
		}
		if (myBankStatementLoader == null) {
			List<IServiceReferenceHolder<IBankStatementLoaderFactory>> factoryList = Service.locator().list(IBankStatementLoaderFactory.class).getServiceReferences();
			if (factoryList != null) {
				for(IServiceReferenceHolder<IBankStatementLoaderFactory> factory : factoryList) {
					IBankStatementLoaderFactory service = factory.getService();
					if (service != null) {
						BankStatementLoaderInterface loader = service.newBankStatementLoaderInstance(className);
						if (loader != null) {
							myBankStatementLoader = loader;
							s_bankStatementLoaderFactoryCache.put(className, factory);
							break;
						}
					}
				}
			}
		}
		
		if (myBankStatementLoader == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myBankStatementLoader;
	}
	
	private static final CCache<String, IServiceReferenceHolder<IBankStatementMatcherFactory>> s_bankStatementMatcherFactoryCache = new CCache<>(null, "IBankStatementMatcherFactory", 100, false);
	
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
		IServiceReferenceHolder<IBankStatementMatcherFactory> cache = s_bankStatementMatcherFactoryCache.get(className);
		if (cache != null) {
			IBankStatementMatcherFactory service = cache.getService();
			if (service != null) {
				BankStatementMatcherInterface matcher = service.newBankStatementMatcherInstance(className);
				if (matcher != null) 
					myBankStatementMatcher = matcher;
			}
			if (myBankStatementMatcher == null)
				s_bankStatementMatcherFactoryCache.remove(className);
		}
		if (myBankStatementMatcher == null) {
			List<IServiceReferenceHolder<IBankStatementMatcherFactory>> factoryList = Service.locator().list(IBankStatementMatcherFactory.class).getServiceReferences();
			if (factoryList != null) {
				for(IServiceReferenceHolder<IBankStatementMatcherFactory> factory : factoryList) {
					IBankStatementMatcherFactory service = factory.getService();
					if (service != null) {
						BankStatementMatcherInterface matcher = service.newBankStatementMatcherInstance(className);
						if (matcher != null) {
							myBankStatementMatcher = matcher;
							s_bankStatementMatcherFactoryCache.put(className, factory);
							break;
						}
					}
				}
			}
		}
		
		if (myBankStatementMatcher == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myBankStatementMatcher;
	}
	
	private static final CCache<String, IServiceReferenceHolder<IShipmentProcessorFactory>> s_shipmentProcessorFactoryCache = new CCache<>(null, "IShipmentProcessorFactory", 100, false);
	
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
	
		IServiceReferenceHolder<IShipmentProcessorFactory> cache = s_shipmentProcessorFactoryCache.get(className);
		if (cache != null) {
			IShipmentProcessorFactory service = cache.getService();
			if (service != null) {
				IShipmentProcessor processor = service.newShipmentProcessorInstance(className);
				if (processor != null)
					return processor;
			}
			s_shipmentProcessorFactoryCache.remove(className);
		}
		List<IServiceReferenceHolder<IShipmentProcessorFactory>> factoryList = Service.locator().list(IShipmentProcessorFactory.class).getServiceReferences();
		if (factoryList == null) 
			return null;
		for (IServiceReferenceHolder<IShipmentProcessorFactory> factory : factoryList)
		{
			IShipmentProcessorFactory service = factory.getService();
			if (service != null) {
				IShipmentProcessor processor = service.newShipmentProcessorInstance(className);
				if (processor != null) {
					s_shipmentProcessorFactoryCache.put(className, factory);
					return processor;
				}
			}
		}
		
		return null;
	}
	
	private static final CCache<String, IServiceReferenceHolder<IAddressValidationFactory>> s_addressValidationFactoryCache = new CCache<>(null, "IAddressValidationFactory", 100, false);
	
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
		
		IServiceReferenceHolder<IAddressValidationFactory> cache = s_addressValidationFactoryCache.get(className);
		if (cache != null) {
			IAddressValidationFactory service = cache.getService();
			if (service != null) {
				IAddressValidation processor = service.newAddressValidationInstance(className);
				if (processor != null)
					return processor;
			}
			s_addressValidationFactoryCache.remove(className);
		}
		List<IServiceReferenceHolder<IAddressValidationFactory>> factoryList = Service.locator().list(IAddressValidationFactory.class).getServiceReferences();
		if (factoryList == null) 
			return null;
		for (IServiceReferenceHolder<IAddressValidationFactory> factory : factoryList)
		{
			IAddressValidationFactory service = factory.getService();
			if (service != null) {
				IAddressValidation processor = service.newAddressValidationInstance(className);
				if (processor != null) {
					s_addressValidationFactoryCache.put(className, factory);
					return processor;
				}
			}
		}
		
		return null;
	}
	
	private static final CCache<String, IServiceReferenceHolder<ITaxProviderFactory>> s_taxProviderFactoryCache = new CCache<>(null, "ITaxProviderFactory", 100, false);
	
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
	
			IServiceReferenceHolder<ITaxProviderFactory> cache = s_taxProviderFactoryCache.get(className);
			if (cache != null) {
				ITaxProviderFactory service = cache.getService();
				if (service != null) {
					calculator = service.newTaxProviderInstance(className);
					if (calculator != null)
						return calculator;
				}
				s_taxProviderFactoryCache.remove(className);
			}
			List<IServiceReferenceHolder<ITaxProviderFactory>> factoryList = Service.locator().list(ITaxProviderFactory.class).getServiceReferences();
			if (factoryList == null) 
				return null;
			for (IServiceReferenceHolder<ITaxProviderFactory> factory : factoryList)
			{
				ITaxProviderFactory service = factory.getService();
				if (service != null) {
					calculator = service.newTaxProviderInstance(className);
					if (calculator != null) {
						s_taxProviderFactoryCache.put(className, factory);
						return calculator;
					}
				}
			}
		}
		
		return null;
	}
	
	private static final CCache<String, IServiceReferenceHolder<IReplenishFactory>> s_replenishFactoryCache = new CCache<>(null, "IReplenishFactory", 100, false);
	
	/**
	 * get Custom Replenish instance
	 * 
	 * @param className
	 * @return instance of the ReplenishInterface or null
	 */
	public static ReplenishInterface getReplenish(String className) {
		if (className == null || className.length() == 0) {
			s_log.log(Level.SEVERE, "No ReplenishInterface class name");
			return null;
		}

		ReplenishInterface myReplenishInstance = null;
		IServiceReferenceHolder<IReplenishFactory> cache = s_replenishFactoryCache.get(className);
		if (cache != null) {
			IReplenishFactory service = cache.getService();
			if (service != null) {
				ReplenishInterface loader = service.newReplenishInstance(className);
				if (loader != null) 
					myReplenishInstance = loader;
			}
			if (myReplenishInstance == null)
				s_replenishFactoryCache.remove(className);
		}
		if (myReplenishInstance == null) {
			List<IServiceReferenceHolder<IReplenishFactory>> factoryList = Service.locator().list(IReplenishFactory.class).getServiceReferences();
			if (factoryList != null) {
				for(IServiceReferenceHolder<IReplenishFactory> factory : factoryList) {
					IReplenishFactory service = factory.getService();
					if (service != null) {
						ReplenishInterface loader = service.newReplenishInstance(className);
						if (loader != null) {
							myReplenishInstance = loader;
							s_replenishFactoryCache.put(className, factory);
							break;
						}
					}
				}
			}
		}
		
		if (myReplenishInstance == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myReplenishInstance;
	}
	
	private final static CCache<String, IServiceReferenceHolder<ScriptEngineFactory>> s_scriptEngineFactoryCache = new CCache<>(null, "ScriptEngineFactory", 100, false);
	
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
		
		IServiceReferenceHolder<ScriptEngineFactory> cache = s_scriptEngineFactoryCache.get(engineName);
		if (cache != null) {
			ScriptEngineFactory service = cache.getService();
			if (service != null)
				return service.getScriptEngine();
			s_scriptEngineFactoryCache.remove(engineName);
		}
		List<IServiceReferenceHolder<ScriptEngineFactory>> factoryList = Service.locator().list(ScriptEngineFactory.class).getServiceReferences();
		if (factoryList != null) {
			for(IServiceReferenceHolder<ScriptEngineFactory> factory : factoryList) {
				ScriptEngineFactory service = factory.getService();
				if (service != null) {
					for (String name : service.getNames()) {
						if (engineName.equals(name)) {
							s_scriptEngineFactoryCache.put(engineName, factory);
							return service.getScriptEngine();
						}
					}
				}
			}
		}
		
		return null;
	}
	
	private static final CCache<String, IServiceReferenceHolder<IPaymentExporterFactory>> s_paymentExporterFactory = new CCache<>(null, "IPaymentExporterFactory", 100, false);
	
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
		IServiceReferenceHolder<IPaymentExporterFactory> cache = s_paymentExporterFactory.get(className);
		if (cache != null) {
			IPaymentExporterFactory service = cache.getService();
			if (service != null) {
				PaymentExport exporter = service.newPaymentExporterInstance(className);
				if (exporter != null) 
					myPaymentExporter = exporter;
			}
			if (myPaymentExporter == null)
				s_paymentExporterFactory.remove(className);
		}
		if (myPaymentExporter == null) {
			List<IServiceReferenceHolder<IPaymentExporterFactory>> factoryList = Service.locator().list(IPaymentExporterFactory.class).getServiceReferences();
			if (factoryList != null) {
				for(IServiceReferenceHolder<IPaymentExporterFactory> factory : factoryList) {
					IPaymentExporterFactory service = factory.getService();
					if (service != null) {
						PaymentExport exporter = service.newPaymentExporterInstance(className);
						if (exporter != null) {
							myPaymentExporter = exporter;
							s_paymentExporterFactory.put(className, factory);
							break;
						}
					}
				}
			}
		}
		
		if (myPaymentExporter == null) {
			s_log.log(Level.CONFIG, className + " not found in service/extension registry and classpath");
			return null;
		}
		
		return myPaymentExporter;
	}	

	private static IServiceReferenceHolder<IProductPricingFactory> s_productPricingFactoryCache = null;
	
	/**
	 * get ProductPricing instance
	 * 
	 * @return instance of the IProductPricing or null
	 */
	public static synchronized IProductPricing getProductPricing() {
		if (s_productPricingFactoryCache != null) {
			IProductPricingFactory service = s_productPricingFactoryCache.getService();
			if (service != null) {
				IProductPricing myProductPricing = service.newProductPricingInstance();
				if (myProductPricing != null)
					return myProductPricing;
			}
			s_productPricingFactoryCache = null;
		}
		IServiceReferenceHolder<IProductPricingFactory> factoryReference = Service.locator().locate(IProductPricingFactory.class).getServiceReference();
		if (factoryReference != null) {
			IProductPricingFactory service = factoryReference.getService();
			if (service != null) {
				IProductPricing myProductPricing = service.newProductPricingInstance();
				if (myProductPricing != null) {
					s_productPricingFactoryCache = factoryReference;
					return myProductPricing;
				}
			}
		}

		return null;
	}
	
	private final static CCache<String, IServiceReferenceHolder<IDepreciationMethodFactory>> s_depreciationMethodFactoryCache = new CCache<>(null, "IDepreciationMethodFactory", 100, false);
	
	/**
	 * lookup implement {@link IDepreciationMethod}
	 * @param factoryLookupDTO
	 * @return {@link IDepreciationMethod}
	 */
	public static IDepreciationMethod getDepreciationMethod(DepreciationFactoryLookupDTO factoryLookupDTO) {
		String cacheKey = factoryLookupDTO.depreciationType;
		IServiceReferenceHolder<IDepreciationMethodFactory> cache = s_depreciationMethodFactoryCache.get(cacheKey);
		if (cache != null) {
			IDepreciationMethodFactory service = cache.getService();
			if (service != null) {
				IDepreciationMethod depreciationMethod = service.getDepreciationMethod(factoryLookupDTO);
				if (depreciationMethod != null) 
					return depreciationMethod;
			}
			s_depreciationMethodFactoryCache.remove(cacheKey);
		}
		List<IServiceReferenceHolder<IDepreciationMethodFactory>> factoryList = Service.locator().list(IDepreciationMethodFactory.class).getServiceReferences();
		if (factoryList != null) {
			for(IServiceReferenceHolder<IDepreciationMethodFactory> factory : factoryList) {
				IDepreciationMethodFactory service = factory.getService();
				if (service != null) {
					IDepreciationMethod depreciationMethod = service.getDepreciationMethod(factoryLookupDTO);
					if (depreciationMethod != null) {
						s_depreciationMethodFactoryCache.put(cacheKey, factory);
						return depreciationMethod;
					}
				}
			}
		}

		return null;
	}

	private static IServiceReferenceHolder<IMessageService> s_messageServiceReference = null;
	
	/**
	 * 
	 * @return {@link IMessageService}
	 */
	public static synchronized IMessageService getMessageService() {
		IMessageService messageService = null;
		if (s_messageServiceReference != null) {
			messageService = s_messageServiceReference.getService();
			if (messageService != null)
				return messageService;
		}
		IServiceReferenceHolder<IMessageService> serviceReference = Service.locator().locate(IMessageService.class).getServiceReference();
		if (serviceReference != null) {
			messageService = serviceReference.getService();
			s_messageServiceReference = serviceReference;
		}
		return messageService;
	}
	
	private static IServiceReferenceHolder<IClusterService> s_clusterServiceReference = null;
	
	/**
	 * 
	 * @return {@link IClusterService}
	 */
	public static synchronized IClusterService getClusterService() {
		IClusterService clusterService = null;
		if (s_clusterServiceReference != null) {
			clusterService = s_clusterServiceReference.getService();
			if (clusterService != null)
				return clusterService;
		}
		IServiceReferenceHolder<IClusterService> serviceReference = Service.locator().locate(IClusterService.class).getServiceReference();
		if (serviceReference != null) {
			clusterService = serviceReference.getService();
			s_clusterServiceReference = serviceReference;
		}
		return clusterService;
	}
	
	private static IServiceReferenceHolder<ICacheService> s_cacheServiceReference = null;
	
	/**
	 * 
	 * @return {@link ICacheService}
	 */
	public static synchronized ICacheService getCacheService() {
		ICacheService cacheService = null;
		if (s_cacheServiceReference != null) {
			cacheService = s_cacheServiceReference.getService();
			if (cacheService != null)
				return cacheService;
		}
		IServiceReferenceHolder<ICacheService> serviceReference = Service.locator().locate(ICacheService.class).getServiceReference();
		if (serviceReference != null) {
			cacheService = serviceReference.getService();
			s_cacheServiceReference = serviceReference;
		}
		return cacheService;
	}
	
	private static IServiceReferenceHolder<IDictionaryService> s_dictionaryServiceReference = null;
	
	/**
	 * 
	 * @return {@link IDictionaryService}
	 */
	public static synchronized IDictionaryService getDictionaryService() {
		IDictionaryService ids = null;
		if (s_dictionaryServiceReference != null) {
			ids = s_dictionaryServiceReference.getService();
			if (ids != null)
				return ids;
		}
		IServiceReferenceHolder<IDictionaryService> serviceReference = Service.locator().locate(IDictionaryService.class).getServiceReference();
		if (serviceReference != null) {
			ids = serviceReference.getService();
			s_dictionaryServiceReference = serviceReference;
		}
		return ids;
	}
		
}
