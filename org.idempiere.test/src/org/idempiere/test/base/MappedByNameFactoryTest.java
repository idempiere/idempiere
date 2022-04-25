/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Properties;

import org.adempiere.base.Core;
import org.adempiere.base.IAddressValidationFactory;
import org.adempiere.base.IBankStatementLoaderFactory;
import org.adempiere.base.IBankStatementMatcherFactory;
import org.adempiere.base.IModelValidatorFactory;
import org.adempiere.base.IPaymentExporterFactory;
import org.adempiere.base.IPaymentProcessorFactory;
import org.adempiere.base.IReplenishFactory;
import org.adempiere.base.IShipmentProcessorFactory;
import org.adempiere.base.ITaxProviderFactory;
import org.adempiere.base.MappedByNameFactory;
import org.adempiere.model.IAddressValidation;
import org.adempiere.model.IShipmentProcessor;
import org.adempiere.model.ITaxProvider;
import org.adempiere.model.MFreightShipmentProcessor;
import org.adempiere.model.MShipperFacade;
import org.compiere.impexp.BankStatementLoaderInterface;
import org.compiere.impexp.BankStatementMatchInfo;
import org.compiere.impexp.BankStatementMatcherInterface;
import org.compiere.model.MAddressTransaction;
import org.compiere.model.MAddressValidation;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MBankStatementLine;
import org.compiere.model.MBankStatementLoader;
import org.compiere.model.MClient;
import org.compiere.model.MShipper;
import org.compiere.model.MTable;
import org.compiere.model.MTaxProvider;
import org.compiere.model.MWarehouse;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.PaymentInterface;
import org.compiere.model.PaymentProcessor;
import org.compiere.model.Query;
import org.compiere.model.StandardTaxProvider;
import org.compiere.model.X_C_AddressValidationCfg;
import org.compiere.model.X_C_TaxProviderCfg;
import org.compiere.model.X_I_BankStatement;
import org.compiere.model.X_T_Replenish;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.GenericPaymentExport;
import org.compiere.util.PaymentExport;
import org.compiere.util.ReplenishInterface;
import org.idempiere.fa.service.api.DepreciationDTO;
import org.idempiere.fa.service.api.DepreciationFactoryLookupDTO;
import org.idempiere.fa.service.api.IDepreciationMethod;
import org.idempiere.fa.service.api.IDepreciationMethodFactory;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

/**
 * 
 * @author hengsin
 *
 */
public class MappedByNameFactoryTest extends AbstractTestCase {

	public MappedByNameFactoryTest() {
	}

	private final static class MyModelValidator implements ModelValidator {
		@Override
		public void initialize(ModelValidationEngine engine, MClient client) {
		}

		@Override
		public int getAD_Client_ID() {
			return 0;
		}

		@Override
		public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {
			return null;
		}

		@Override
		public String modelChange(PO po, int type) throws Exception {
			return null;
		}

		@Override
		public String docValidate(PO po, int timing) {
			return null;
		}		
	}
	
	private final static class MyModelValidatorFactory extends MappedByNameFactory<ModelValidator> implements IModelValidatorFactory {

		public MyModelValidatorFactory() {
			addMapping(MyModelValidator.class.getName(), () -> new MyModelValidator());
		}
		
		@Override
		public ModelValidator newModelValidatorInstance(String className) {
			return newInstance(className);
		}		
	}
	
	@Test
	public void testModelValidatorFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IModelValidatorFactory.class, new MyModelValidatorFactory(), properties);
		
		var validator = Core.getModelValidator(MyModelValidator.class.getName());
		assertNotNull(validator);
		assertTrue(validator instanceof MyModelValidator, "validator not instanceof MyModelValidator. validator="+validator.getClass().getName());
	}
	
	private final static class MyPaymentProcessor extends PaymentProcessor {
		@Override
		public boolean processCC() throws IllegalArgumentException {
			return false;
		}

		@Override
		public boolean isProcessedOK() {
			return false;
		}		
	}
	
	private final static class MyPaymentProcessFactory extends MappedByNameFactory<PaymentProcessor> implements IPaymentProcessorFactory {
		public MyPaymentProcessFactory() {
			addMapping("org.compiere.model.PP_PayFlowPro", () -> new MyPaymentProcessor());
		}

		@Override
		public PaymentProcessor newPaymentProcessorInstance(String className) {
			return newInstance(className);
		}
		
	}
	
	@Test
	public void testPaymentProcessorFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		ServiceRegistration<IPaymentProcessorFactory> registration = bc.registerService(IPaymentProcessorFactory.class, new MyPaymentProcessFactory(), properties);
		
		CacheMgt.get().reset(Core.IPAYMENT_PROCESSOR_FACTORY_CACHE_TABLE_NAME);
		
		PaymentInterface mp = null;
		MBankAccountProcessor mbap;
		Query query = new Query(Env.getCtx(), MBankAccountProcessor.Table_Name, MTable.getUUIDColumnName(MBankAccountProcessor.Table_Name)+"=?", null);
		mbap = query.setParameters("f4a64026-bf68-4c8c-b238-8cdf006aae04").first();
		var pp = Core.getPaymentProcessor(mbap, mp);
		assertNotNull(pp);
		assertTrue(pp instanceof MyPaymentProcessor, "pp not instanceof MyPaymentProcessor. pp="+pp.getClass().getName());
		
		registration.unregister();
	}
	
	private final static class MyBankStatementLoader implements BankStatementLoaderInterface {

		@Override
		public boolean init(MBankStatementLoader controller) {
			// TODO Auto-generated method stub
			return false;
		}

		@Override
		public boolean isValid() {
			return false;
		}

		@Override
		public boolean loadLines() {
			return false;
		}

		@Override
		public String getLastErrorMessage() {
			return null;
		}

		@Override
		public String getLastErrorDescription() {
			return null;
		}

		@Override
		public Timestamp getDateLastRun() {
			return null;
		}

		@Override
		public String getRoutingNo() {
			return null;
		}

		@Override
		public String getBankAccountNo() {
			return null;
		}

		@Override
		public String getIBAN() {
			return null;
		}

		@Override
		public String getStatementReference() {
			return null;
		}

		@Override
		public Timestamp getStatementDate() {
			return null;
		}

		@Override
		public String getTrxID() {
			return null;
		}

		@Override
		public String getReference() {
			return null;
		}

		@Override
		public String getCheckNo() {
			return null;
		}

		@Override
		public String getPayeeName() {
			return null;
		}

		@Override
		public String getPayeeAccountNo() {
			return null;
		}

		@Override
		public Timestamp getStatementLineDate() {
			return null;
		}

		@Override
		public Timestamp getValutaDate() {
			return null;
		}

		@Override
		public String getTrxType() {
			return null;
		}

		@Override
		public boolean getIsReversal() {
			return false;
		}

		@Override
		public String getCurrency() {
			return null;
		}

		@Override
		public BigDecimal getStmtAmt() {
			return null;
		}

		@Override
		public BigDecimal getTrxAmt() {
			return null;
		}

		@Override
		public BigDecimal getInterestAmt() {
			return null;
		}

		@Override
		public String getMemo() {
			return null;
		}

		@Override
		public String getChargeName() {
			return null;
		}

		@Override
		public BigDecimal getChargeAmt() {
			return null;
		}
		
	}
	
	private final static class MyBankStatementLoaderFactory extends MappedByNameFactory<BankStatementLoaderInterface> implements IBankStatementLoaderFactory {

		public MyBankStatementLoaderFactory() {
			addMapping(MyBankStatementLoader.class.getName(), () -> new MyBankStatementLoader());
		}

		@Override
		public BankStatementLoaderInterface newBankStatementLoaderInstance(String className) {
			return newInstance(className);
		}		
	}
	
	@Test
	public void testBankStatementLoaderFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IBankStatementLoaderFactory.class, new MyBankStatementLoaderFactory(), properties);
		var loader = Core.getBankStatementLoader(MyBankStatementLoader.class.getName());
		assertNotNull(loader);
		assertTrue(loader instanceof MyBankStatementLoader, "loader not instanceof MyBankStatementLoader. loader="+loader.getClass().getName());
	}
	
	private static final class MyBankStatementMatcher implements BankStatementMatcherInterface {
		@Override
		public BankStatementMatchInfo findMatch(MBankStatementLine bsl) {
			return null;
		}

		@Override
		public BankStatementMatchInfo findMatch(X_I_BankStatement ibs) {
			return null;
		}
	}
	
	private final static class MyBankStatementMatcherFactory extends MappedByNameFactory<BankStatementMatcherInterface> implements IBankStatementMatcherFactory {
		public MyBankStatementMatcherFactory() {
			addMapping(MyBankStatementMatcher.class.getName(), () -> new MyBankStatementMatcher());
		}

		@Override
		public BankStatementMatcherInterface newBankStatementMatcherInstance(String className) {
			return newInstance(className);
		}		
	}
	
	@Test
	public void testBankStatementMatcherFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IBankStatementMatcherFactory.class, new MyBankStatementMatcherFactory(), properties);
		var loader = Core.getBankStatementMatcher(MyBankStatementMatcher.class.getName());
		assertNotNull(loader);
		assertTrue(loader instanceof MyBankStatementMatcher, "loader not instanceof MyBankStatementMatcher. loader="+loader.getClass().getName());
	}
	
	private final static class MyShipmentProcessor extends MFreightShipmentProcessor {		
	}
	
	private final static class MyShipmentProcessorFactory extends MappedByNameFactory<IShipmentProcessor> implements IShipmentProcessorFactory {
		public MyShipmentProcessorFactory() {
			addMapping("org.adempiere.model.MFreightShipmentProcessor", () -> new MyShipmentProcessor());
		}

		@Override
		public IShipmentProcessor newShipmentProcessorInstance(String className) {
			return newInstance(className);
		}		
	}
	
	@Test
	public void testShipmentProcessorFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		ServiceRegistration<IShipmentProcessorFactory> sr = bc.registerService(IShipmentProcessorFactory.class, new MyShipmentProcessorFactory(), properties);
		
		CacheMgt.get().reset(Core.ISHIPMENT_PROCESSOR_FACTORY_CACHE_TABLE_NAME);
		
		MShipper shipper = new MShipper(Env.getCtx(), 100, getTrxName());
		MShipperFacade sf = new MShipperFacade(shipper);
		var loader = Core.getShipmentProcessor(sf);
		assertNotNull(loader);
		assertTrue(loader instanceof MyShipmentProcessor, "loader not instanceof MyShipmentProcessor. loader="+loader.getClass().getName());
		sr.unregister();
	}
	
	private final static class MyAddressValidation implements IAddressValidation {
		@Override
		public boolean onlineValidate(Properties ctx, MAddressTransaction addressTransaction, String trxName) {
			return false;
		}		
	}
	
	private final static class MyAddressValidationFactory extends MappedByNameFactory<IAddressValidation> implements IAddressValidationFactory {
		public MyAddressValidationFactory() {
			addMapping(MyAddressValidation.class.getName(), () -> new MyAddressValidation());
		}

		@Override
		public IAddressValidation newAddressValidationInstance(String className) {
			return newInstance(className);
		}		
	}
	
	@Test
	public void testAddressVallidationFactory() { 
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		ServiceRegistration<IAddressValidationFactory> sr = bc.registerService(IAddressValidationFactory.class, new MyAddressValidationFactory(), properties);
		X_C_AddressValidationCfg cfg = new X_C_AddressValidationCfg(Env.getCtx(), 0, getTrxName());
		cfg.setAddressValidationClass(MyAddressValidation.class.getName());
		cfg.setHostAddress("localhost");
		cfg.setHostPort(8080);
		cfg.setName("testAddressVallidation cfg");
		cfg.saveEx();
		MAddressValidation adv = new MAddressValidation(Env.getCtx(), 0, getTrxName());
		adv.setC_AddressValidationCfg_ID(cfg.get_ID());
		adv.setUserID("test");
		adv.setConnectionPassword("test01");
		adv.setSeqNo(10);
		adv.setName("testAddressVallidation");
		var loader = Core.getAddressValidation(adv);
		assertNotNull(loader);
		assertTrue(loader instanceof MyAddressValidation, "loader not instanceof MyAddressValidation. loader="+loader.getClass().getName());
		sr.unregister();
	}
	
	private static final class MyTaxProvider extends StandardTaxProvider {		
	}
	
	private static final class MyTaxProviderFactory extends MappedByNameFactory<ITaxProvider> implements ITaxProviderFactory {
		public MyTaxProviderFactory() {
			addMapping("MyTaxProvider", () -> new MyTaxProvider());
		}

		@Override
		public ITaxProvider newTaxProviderInstance(String className) {
			return newInstance(className);
		}
	}
	
	@Test
	public void testTaxProviderFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		ServiceRegistration<ITaxProviderFactory> sr = bc.registerService(ITaxProviderFactory.class, new MyTaxProviderFactory(), properties);
		X_C_TaxProviderCfg cfg = new X_C_TaxProviderCfg(Env.getCtx(), 0, getTrxName());
		cfg.setName("testTaxProviderFactory cfg");
		cfg.setTaxProviderClass("MyTaxProvider");
		cfg.saveEx();
		MTaxProvider tp = new MTaxProvider(Env.getCtx(), 0, getTrxName());
		tp.setName("testTaxProviderFactory");
		tp.setC_TaxProviderCfg_ID(cfg.get_ID());
		tp.saveEx();
		var loader = Core.getTaxProvider(tp);
		assertNotNull(loader);
		assertTrue(loader instanceof MyTaxProvider, "loader not instanceof MyTaxProvider. loader="+loader.getClass().getName());
		sr.unregister();
	}
	
	private final static class MyReplenishInterface implements ReplenishInterface {
		@Override
		public BigDecimal getQtyToOrder(MWarehouse wh, X_T_Replenish replenish) {
			return null;
		}		
	}
	
	private final static class MyReplenishInterfaceFactory extends MappedByNameFactory<MyReplenishInterface> implements IReplenishFactory {
		public MyReplenishInterfaceFactory() {
			addMapping(MyReplenishInterface.class.getName(), () -> new MyReplenishInterface());
		}

		@Override
		public ReplenishInterface newReplenishInstance(String className) {
			return newInstance(className);
		}		
	}
	
	@Test
	public void testReplenishFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IReplenishFactory.class, new MyReplenishInterfaceFactory(), properties);
		var loader = Core.getReplenish(MyReplenishInterface.class.getName());
		assertNotNull(loader);
		assertTrue(loader instanceof MyReplenishInterface, "loader not instanceof MyReplenishInterface. loader="+loader.getClass().getName());		
	}
	
	private final static class MyPaymentExport extends GenericPaymentExport {
	}
	
	private final static class MyPaymentExportFactory extends MappedByNameFactory<PaymentExport> implements IPaymentExporterFactory {
		public MyPaymentExportFactory() {
			addMapping(MyPaymentExport.class.getName(), () -> new MyPaymentExport());
		}

		@Override
		public PaymentExport newPaymentExporterInstance(String className) {
			return newInstance(className);
		}		
	}
	
	@Test
	public void testPaymentExporterFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IPaymentExporterFactory.class, new MyPaymentExportFactory(), properties);
		var loader = Core.getPaymentExporter(MyPaymentExport.class.getName());
		assertNotNull(loader);
		assertTrue(loader instanceof MyPaymentExport, "loader not instanceof MyPaymentExport loader="+loader.getClass().getName());				
	}
	
	private final static class MyDepreciationMethod implements IDepreciationMethod {
		@Override
		public BigDecimal caclulateDepreciation(DepreciationDTO depreciationDTO) {
			return null;
		}

		@Override
		public long getCountPeriod(DepreciationDTO depreciationDTO) {
			return 0;
		}

		@Override
		public boolean isPeriodAdjustment() {
			return false;
		}		
	}
	
	private final static class MyDepreciationMethodFactory extends MappedByNameFactory<IDepreciationMethod> implements IDepreciationMethodFactory {
		public MyDepreciationMethodFactory() {
			addMapping("MyDepreciationMethod", () -> new MyDepreciationMethod());
		}

		@Override
		public IDepreciationMethod getDepreciationMethod(DepreciationFactoryLookupDTO factoryLookupDTO) {
			return newInstance(factoryLookupDTO.depreciationType);
		}		
	}
	
	@Test
	public void testDepreciationMethodFactory() {
		//simulate osgi component service
		BundleContext bc = TestActivator.context;
		Dictionary<String, Object> properties = new Hashtable<String, Object>();
		properties.put("service.ranking", Integer.valueOf(1));
		bc.registerService(IDepreciationMethodFactory.class, new MyDepreciationMethodFactory(), properties);
		DepreciationFactoryLookupDTO dto = new DepreciationFactoryLookupDTO();
		dto.depreciationType = "MyDepreciationMethod";
		var loader = Core.getDepreciationMethod(dto);
		assertNotNull(loader);
		assertTrue(loader instanceof MyDepreciationMethod, "loader not instanceof MyDepreciationMethod. loader="+loader.getClass().getName());						
	}
}
