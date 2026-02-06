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
package org.idempiere.test.performance;

import static org.assertj.core.api.Assertions.assertThatNoException;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineFactory;

import org.adempiere.base.Core;
import org.adempiere.base.DefaultPaymentExporterFactory;
import org.adempiere.base.IAddressValidationFactory;
import org.adempiere.base.IBankStatementLoaderFactory;
import org.adempiere.base.IBankStatementMatcherFactory;
import org.adempiere.base.IColumnCallout;
import org.adempiere.base.IDisplayTypeFactory;
import org.adempiere.base.IPaymentExporterFactory;
import org.adempiere.base.IReplenishFactory;
import org.adempiere.base.IResourceFinder;
import org.adempiere.base.LookupFactoryHelper;
import org.adempiere.base.ServiceQuery;
import org.adempiere.model.IAddressValidation;
import org.adempiere.model.IShipmentProcessor;
import org.adempiere.model.ITaxProvider;
import org.adempiere.model.MShipperFacade;
import org.adempiere.model.ProductPriceValidator;
import org.compiere.acct.Doc;
import org.compiere.acct.DocManager;
import org.compiere.db.AdempiereDatabase;
import org.compiere.db.Database;
import org.compiere.impexp.BankStatementLoaderInterface;
import org.compiere.impexp.BankStatementMatcherInterface;
import org.compiere.impexp.OFXFileBankStatementLoader;
import org.compiere.model.Callout;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridTabVO;
import org.compiere.model.GridWindowVO;
import org.compiere.model.IArchiveStore;
import org.compiere.model.IAttachmentStore;
import org.compiere.model.IImageStore;
import org.compiere.model.I_AD_Table;
import org.compiere.model.I_M_InventoryLine;
import org.compiere.model.Lookup;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAddressValidation;
import org.compiere.model.MAddressValidationCfg;
import org.compiere.model.MBPartner;
import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.MClientInfo;
import org.compiere.model.MColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MProduct;
import org.compiere.model.MRefTable;
import org.compiere.model.MShipper;
import org.compiere.model.MStorageProvider;
import org.compiere.model.MTable;
import org.compiere.model.MTaxProvider;
import org.compiere.model.MTaxProviderCfg;
import org.compiere.model.MTest;
import org.compiere.model.MTestUU;
import org.compiere.model.MWarehouse;
import org.compiere.model.MZoomCondition;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.PaymentProcessor;
import org.compiere.model.Query;
import org.compiere.model.StandardTaxProvider;
import org.compiere.print.MPrintFormat;
import org.compiere.process.BPartnerValidate;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CCache;
import org.compiere.util.CacheInterface;
import org.compiere.util.CacheMgt;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.GenericPaymentExport;
import org.compiere.util.PaymentExport;
import org.compiere.util.ReplenishInterface;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.CalloutBOM;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.fa.service.api.DepreciationFactoryLookupDTO;
import org.idempiere.fa.service.api.IDepreciationMethod;
import org.idempiere.fa.service.api.IDepreciationMethodFactory;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * 
 * @author hengsin
 *
 */
@Isolated
public class CacheTest extends AbstractTestCase {

	private static final int ORDER_HEADER_PRINT_FORMAT_ID = 118;
	private static final int SHIPMENT_HEADER_PRINT_FORMAT_ID = 122;
		
	public CacheTest() {
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-2698
	 */
	public void testZoomConditionCache() {
		MZoomCondition[] conditions1 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions1 != null && conditions1.length > 0);
		MZoomCondition[] conditions2 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions2 != null && conditions2.length > 0);
		assertTrue(conditions1 == conditions2);
		CacheMgt.get().reset();
		MZoomCondition[] conditions3 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions3 != null && conditions3.length == conditions1.length);
		assertTrue(conditions1 != conditions3);
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-2699
	 */
	public void testTableCache() {
		MTable table = MTable.get(Env.getCtx(), MOrder.Table_ID);
		
		//find table cache instance
		CCache<?, ?> tblCache = findByTableNameAndKey(MTable.Table_Name, MOrder.Table_ID);
		if (tblCache == null)
			fail("Table cache instance missing");
		
		long hit = tblCache.getHit();
		
		MColumn column = table.getColumn(MOrder.COLUMNNAME_C_Order_ID);
		@SuppressWarnings("unused")
		I_AD_Table table2 = column.getAD_Table();
		assertEquals(hit+1, tblCache.getHit());
		
		//M_Warehouse of Client
		table = MTable.get(Env.getCtx(), MWarehouse.Table_ID);		
		MRefTable refTable = MRefTable.get(Env.getCtx(), 197);
		
		tblCache = findByTableNameAndKey(MTable.Table_Name, MWarehouse.Table_ID);
		if (tblCache == null)
			fail("Table cache instance missing");
		
		hit = tblCache.getHit();
		table2 = refTable.getAD_Table();
		assertEquals(hit+1, tblCache.getHit());
	}
	
	@SuppressWarnings({"unchecked"})
	@Test
	public void testPOCacheAfterUpdate() throws InterruptedException {
		int mulch = 137;
		int oak = 123;
		//init cache
		MProduct p1 = MProduct.get(Env.getCtx(), mulch);
		CCache<Integer, MProduct> pc = (CCache<Integer, MProduct>) findByTableNameAndKey(MProduct.Table_Name, mulch);
		if (pc == null)
			fail("Product cache instance missing");
		
		//second get, hit should increase
		long hit = pc.getHit();
		p1 = MProduct.get(Env.getCtx(), mulch);
		assertEquals(mulch, p1.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Second get of product Mulch, cache hit should increase");
		
		//first get for p2, miss should increase
		long miss = pc.getMiss();
		MProduct p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getMiss() > miss, "First get of product Oak, cache miss should increase");
		
		//second get for p2, hit should increase
		hit = pc.getHit();
		p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Second get of product Oak, cache hit should increase");
		
		String oakDescription = p2.getDescription();
		p2 = new MProduct(Env.getCtx(), p2, getTrxName());
		p2.setDescription("Test Update @ " + System.currentTimeMillis());
		p2.saveEx();
		commit();
		
		//get after p2 update, miss should increase
		//wait 500ms since cache reset after update is async
		Thread.sleep(500);
		miss = pc.getMiss();
		p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getMiss() > miss, "Get of product Oak after update of product Oak, cache miss should increase. before="+miss+" after="+pc.getMiss());
		
		//cache for p1 not effected by p2 update, hit should increase
		hit = pc.getHit();
		p1 = MProduct.get(Env.getCtx(), mulch);
		assertEquals(mulch, p1.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Get of product Mulch after update of product Oak, cache hit should increase. before="+hit+" after="+pc.getHit());
		
		//create p3 to test delete
		MProduct p3 = new MProduct(Env.getCtx(), 0, getTrxName());
		String name = "Test@"+System.currentTimeMillis();
		p3.setValue(name);
		p3.setName(name);
		p3.setM_Product_Category_ID(p1.getM_Product_Category_ID());
		p3.setC_UOM_ID(p1.getC_UOM_ID());
		p3.setC_TaxCategory_ID(p1.getC_TaxCategory_ID());
		p3.saveEx();
		
		p3.deleteEx(true);
		commit();
		
		//cache for p2 not effected by p3 delete, hit should increase
		hit = pc.getHit();
		p2 = MProduct.get(Env.getCtx(), oak);
		assertEquals(oak, p2.getM_Product_ID());
		assertTrue(pc.getHit() > hit, "Get of product Oak after delete of product Mulch, cache hit should increase");
		
		//test update when cache is empty
		CacheMgt.get().reset();
		p2 = new MProduct(Env.getCtx(), p2, getTrxName());
		p2.setDescription("Test1@"+System.currentTimeMillis());
		p2.saveEx();
		
		rollback();
		
		//revert description update
		p2 = new MProduct(Env.getCtx(), oak, null);
		p2.setDescription(oakDescription);
		p2.saveEx();
	}
	
	@Test
	public void testServices() {
		//IResourceFinder
		TestActivator.context.registerService(IResourceFinder.class, new FakeResourceFinder(), null);
		IResourceFinder resourceFinder = Core.getResourceFinder();
		assertNotNull(resourceFinder, "Can't find resource finder service");
		String cacheKey = FakeResourceFinder.class.getName();
		URL url = Core.getResourceFinder().getResource(cacheKey);
		assertNotNull(url);
		String cacheName = "IResourceFinder";
		CCache<?, ?> cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);		
		long hit = cache.getHit();
		url = Core.getResourceFinder().getResource(cacheKey);
		assertNotNull(url);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IColumnCalloutFactory
		List<IColumnCallout> callouts = Core.findCallout(I_M_InventoryLine.Table_Name, I_M_InventoryLine.COLUMNNAME_M_Product_ID);
		assertTrue(callouts.size() > 0, "Can't find callouts for " + I_M_InventoryLine.Table_Name + ", " + I_M_InventoryLine.COLUMNNAME_M_Product_ID);		
		cacheKey = I_M_InventoryLine.Table_Name + "." + I_M_InventoryLine.COLUMNNAME_M_Product_ID;
		cacheName = "List<IColumnCalloutFactory>";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);		
		hit = cache.getHit();
		callouts = Core.findCallout(I_M_InventoryLine.Table_Name, I_M_InventoryLine.COLUMNNAME_M_Product_ID);
		assertTrue(callouts.size() > 0, "Can't find callouts for " + I_M_InventoryLine.Table_Name + ", " + I_M_InventoryLine.COLUMNNAME_M_Product_ID);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected"); 
		
		//ICalloutFactory
		cacheKey = CalloutBOM.class.getName() + "::" + "parent";
		Callout callout = Core.getCallout(CalloutBOM.class.getName(), "parent");
		assertNotNull(callout, "Can't find callout for " + cacheKey);
		cacheName = "ICalloutFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		callout = Core.getCallout(CalloutBOM.class.getName(), "parent");
		assertNotNull(callout, "Can't find callout for " + cacheKey);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IProcessFactory
		cacheKey = BPartnerValidate.class.getName();
		ProcessCall process = Core.getProcess(cacheKey);
		assertNotNull(process, "Can't find process for " + cacheKey);
		cacheName = "IProcessFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		process = Core.getProcess(cacheKey);
		assertNotNull(process, "Can't find process for " + cacheKey);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
						
		//IModelValidatorFactory
		cacheKey = ProductPriceValidator.class.getName();
		ModelValidator modelValidator = Core.getModelValidator(cacheKey);
		assertNotNull(modelValidator, "Can't find model validator for " + cacheKey);
		cacheName = "IModelValidatorFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		modelValidator = Core.getModelValidator(cacheKey);
		assertNotNull(modelValidator, "Can't find model validator for " + cacheKey);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IKeyStore
		assertNotNull(Core.getKeyStore(), "Can't find key store service");
		//second call to check service reference cache is working
		assertNotNull(Core.getKeyStore(), "Can't find key store service"); 
		
		//IPaymentProcessorFactory
		int pp_payflowpro_id = 100;
		MBankAccountProcessor bankAccountProcessor = MBankAccountProcessor.get(Env.getCtx(), pp_payflowpro_id, pp_payflowpro_id, getTrxName());
		assertNotNull(bankAccountProcessor, "Can't load bank account processor for PP_PayFlowPro");
		PaymentProcessor paymentProcessor = Core.getPaymentProcessor(bankAccountProcessor, null);
		assertNotNull(paymentProcessor, "Can't load payment processor for PP_PayFlowPro");
		cacheKey = "org.compiere.model.PP_PayFlowPro";
		cacheName = "IPaymentProcessorFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		paymentProcessor = Core.getPaymentProcessor(bankAccountProcessor, null);
		assertNotNull(paymentProcessor, "Can't load payment processor for PP_PayFlowPro");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IBankStatementLoaderFactory
		TestActivator.context.registerService(IBankStatementLoaderFactory.class, new FakeBankStatementLoaderFactory(), null);
		cacheKey = OFXFileBankStatementLoader.class.getName();
		BankStatementLoaderInterface bankStatementLoader = Core.getBankStatementLoader(cacheKey);
		assertNotNull(bankStatementLoader, "Can't find BankStatementLoader for " + cacheKey);
		cacheName = "IBankStatementLoaderFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		bankStatementLoader = Core.getBankStatementLoader(cacheKey);
		assertNotNull(bankStatementLoader, "Can't find BankStatementLoader for " + cacheKey);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IBankStatementMatcherFactory
		TestActivator.context.registerService(IBankStatementMatcherFactory.class, new FakeBankStatementMatcherFactory(), null);
		cacheKey = FakeBankStatementMatcherFactory.class.getName();
		BankStatementMatcherInterface bankStatementMatcher = Core.getBankStatementMatcher(cacheKey);
		assertNotNull(bankStatementMatcher, "Can't find bank statement matcher service");
		cacheName = "IBankStatementMatcherFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		bankStatementMatcher = Core.getBankStatementMatcher(cacheKey);
		assertNotNull(bankStatementMatcher, "Can't find bank statement matcher service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IShipmentProcessorFactory
		int m_shipper_id=100;
		MShipperFacade shipperFacade = new MShipperFacade(new MShipper(Env.getCtx(), m_shipper_id, getTrxName()));
		cacheKey = shipperFacade.getShippingProcessorClass();
		cacheName = "IShipmentProcessorFactory";
		IShipmentProcessor shipmentProcessor = Core.getShipmentProcessor(shipperFacade);
		assertNotNull(shipmentProcessor, "Can't find shipment processor");
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		shipmentProcessor = Core.getShipmentProcessor(shipperFacade);
		assertNotNull(shipmentProcessor, "Can't find shipment processor");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IAddressValidationFactory
		MAddressValidationCfg cfg = new MAddressValidationCfg(Env.getCtx(), 0, getTrxName());
		cfg.setHostAddress("10.8.0.1");
		cfg.setHostPort(433);
		cfg.setName("Test Cfg");
		cacheKey = FakeAddressValidationFactory.class.getName();
		cfg.setAddressValidationClass(cacheKey);
		cfg.saveEx();		
		MAddressValidation addressValidation = new MAddressValidation(Env.getCtx(), 0, getTrxName());
		addressValidation.setC_AddressValidationCfg_ID(cfg.get_ID());
		addressValidation.setConnectionPassword("password");
		addressValidation.setName("Test Address Validation");
		addressValidation.setUserID("userid");
		addressValidation.setSeqNo(10);
		addressValidation.saveEx();		
		TestActivator.context.registerService(IAddressValidationFactory.class, new FakeAddressValidationFactory(), null);
		IAddressValidation addressValidationService = Core.getAddressValidation(addressValidation);
		assertNotNull(addressValidationService, "Can't find address validation service");
		cacheName = "IAddressValidationFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		addressValidationService = Core.getAddressValidation(addressValidation);
		assertNotNull(addressValidationService, "Can't find address validation service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//ITaxProviderFactory
		MTaxProviderCfg taxProviderCfg = new MTaxProviderCfg(Env.getCtx(), 0, getTrxName());
		taxProviderCfg.setName("Standard Provider Configuration");
		taxProviderCfg.setTaxProviderClass(StandardTaxProvider.class.getName());
		taxProviderCfg.saveEx();
		MTaxProvider taxProvider = new MTaxProvider(Env.getCtx(), 0, getTrxName());
		taxProvider.setC_TaxProviderCfg_ID(taxProviderCfg.get_ID());
		taxProvider.setName("Standard Provider");
		taxProvider.saveEx();
		ITaxProvider taxProviderService = Core.getTaxProvider(taxProvider);
		assertNotNull(taxProviderService, "Can't find tax provider service");
		cacheKey = StandardTaxProvider.class.getName();
		cacheName = "ITaxProviderFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		taxProviderService = Core.getTaxProvider(taxProvider);
		assertNotNull(taxProviderService, "Can't find tax provider service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IReplenishFactory
		TestActivator.context.registerService(IReplenishFactory.class, new FakeReplenishFactory(), null);
		cacheKey = FakeReplenishFactory.class.getName();
		ReplenishInterface replenishService = Core.getReplenish(cacheKey);
		assertNotNull(replenishService, "Can't find replenish service");
		cacheName = "IReplenishFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		replenishService = Core.getReplenish(cacheKey);
		assertNotNull(replenishService, "Can't find replenish service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//ScriptEngineFactory
		TestActivator.context.registerService(ScriptEngineFactory.class, new FakeScriptEngineFactory(), null);
		cacheKey = FakeScriptEngineFactory.class.getName();
		ScriptEngine scriptEngine = Core.getScriptEngine(cacheKey);
		assertNotNull(scriptEngine, "Can't find script engine service");
		cacheName = "ScriptEngineFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		scriptEngine = Core.getScriptEngine(cacheKey);
		assertNotNull(scriptEngine, "Can't find script engine service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IPaymentExporterFactory
		TestActivator.context.registerService(IPaymentExporterFactory.class, new DefaultPaymentExporterFactory(), null);
		cacheKey = GenericPaymentExport.class.getName();
		PaymentExport paymentExportService = Core.getPaymentExporter(cacheKey);
		assertNotNull(paymentExportService, "Can't find payment exporter service");
		cacheName = "IPaymentExporterFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		paymentExportService = Core.getPaymentExporter(cacheKey);
		assertNotNull(paymentExportService, "Can't find payment exporter service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IProductPricing
		assertNotNull(Core.getProductPricing(), "Can't find product pricing service");
		//second call to check service reference cache is working
		assertNotNull(Core.getProductPricing(), "Can't find product pricing service");
		
		//IDepreciationMethodFactory
		TestActivator.context.registerService(IDepreciationMethodFactory.class, new FakeDepreciationMethodFactory(), null);
		cacheKey = FakeDepreciationMethodFactory.class.getName();
		DepreciationFactoryLookupDTO dto = new DepreciationFactoryLookupDTO();
		dto.depreciationType = cacheKey;
		IDepreciationMethod depreciationMethod = Core.getDepreciationMethod(dto);
		assertNotNull(depreciationMethod, "Can't find depreciation method service");
		cacheName = "IDepreciationMethodFactory";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		depreciationMethod = Core.getDepreciationMethod(dto);
		assertNotNull(depreciationMethod, "Can't find depreciation method service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IMessageService
		assertNotNull(Core.getMessageService(), "Can't find message service");
		//second call to check service reference cache is working
		assertNotNull(Core.getMessageService(), "Can't find message service");
		
		//IClusterService
		assertNotNull(Core.getClusterService(), "Can't find cluster service");
		//second call to check service reference cache is working
		assertNotNull(Core.getClusterService(), "Can't find cluster service");
		
		//ICacheService
		assertNotNull(Core.getCacheService(), "Can't find cache service");
		//second call to check service reference cache is working
		assertNotNull(Core.getCacheService(), "Can't find cache service");
		
		//IDictionaryService
		assertNotNull(Core.getDictionaryService(), "Can't find dictionary service");
		//second call to check service reference cache is working
		assertNotNull(Core.getDictionaryService(), "Can't find dictionary service");
		
		//ILookupFactory
		int ad_window_id=143; //sales order window
		int ad_tab_id=187; //sales order line
		int ad_field_id=1127; //product
		GridFieldVO gridField = null;
		Lookup lookup = null;
		GridWindowVO gridWindow = GridWindowVO.create(1, ad_window_id);
		Optional<GridTabVO> optional = gridWindow.Tabs.stream().filter(e -> e.AD_Tab_ID == ad_tab_id).findFirst();
		if (optional.isPresent()) {
			GridTabVO gridTabVO = optional.get();
			Optional<GridFieldVO> optional1 = gridTabVO.getFields().stream().filter(e -> e.AD_Field_ID == ad_field_id).findFirst();
			if (optional1.isPresent()) {
				gridField = optional1.get();				
			}
		}		
		assertNotNull(gridField, "Can't find grid field");
		lookup = LookupFactoryHelper.getLookup(gridField);
		assertNotNull(lookup, "Can't find lookup service");
		cacheName = "ILookupFactory";
		cacheKey = null;
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		lookup = LookupFactoryHelper.getLookup(gridField);
		assertNotNull(lookup, "Can't find lookup service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		hit = cache.getHit();
		assertTrue(LookupFactoryHelper.isLookup(gridField), "Lookup should be true for " + gridField.toString());
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IDocFactory
		int C_AcctSchema_ID = MClientInfo.get().getC_AcctSchema1_ID();
		cacheKey = C_AcctSchema_ID + "|" + MInvoice.Table_ID;
		cacheName = "IDocFactory";
		MInvoice invoice = new MInvoice(Env.getCtx(), 0, getTrxName());
		invoice.setBPartner(MBPartner.get(Env.getCtx(), 117));  // C&W
		invoice.setC_DocTypeTarget_ID(MDocType.DOCBASETYPE_ARInvoice);
		invoice.setC_DocType_ID(invoice.getC_DocTypeTarget_ID()); // required to avoid runDocumentActionWorkflow exception
		invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
		invoice.setC_PaymentTerm_ID(105);  // Immediate
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		invoice.setDateInvoiced(today);
		invoice.setDateAcct(today);
		invoice.setDocStatus(DocAction.STATUS_Drafted);
		invoice.setDocAction(DocAction.ACTION_Complete);
		invoice.saveEx();
		MInvoiceLine line1 = new MInvoiceLine(invoice);
		line1.setLine(10);
		line1.setC_Charge_ID(100);  // Bank Charge
		line1.setQty(new BigDecimal("1"));
		line1.setPrice(Env.ONEHUNDRED);
		line1.saveEx();
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
		invoice.load(getTrxName());
		assertFalse(info.isError(), info.getSummary());
		assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
		if (!invoice.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), invoice.getAD_Client_ID(), MInvoice.Table_ID, invoice.get_ID(), true, getTrxName());
			assertNull(error, "Error posting invoice: " + error);
		}
		MAcctSchema as = MAcctSchema.get(C_AcctSchema_ID);
		Doc doc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
		assertNotNull(doc, "Failed load acct doc for invoice");
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		doc = DocManager.getDocument(as, MInvoice.Table_ID, invoice.get_ID(), getTrxName());
		assertNotNull(doc, "Failed load acct doc for invoice");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IDatabase
		AdempiereDatabase db = Database.getDatabase(Database.DB_POSTGRESQL);
		assertNotNull(db, "Failed to load db service for " + Database.DB_POSTGRESQL);
		cacheKey = Database.DB_POSTGRESQL;
		cacheName = "IDatabase";
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		db = Database.getDatabase(Database.DB_POSTGRESQL);
		assertNotNull(db, "Failed to load db service for " + Database.DB_POSTGRESQL);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IArchiveStore
		ServiceQuery dbServiceQuery = new ServiceQuery();
		dbServiceQuery.put("method", "DB");
		IArchiveStore archiveStoreService = MStorageProvider.getArchiveStoreService(dbServiceQuery);
		assertNotNull(archiveStoreService, "Can't find archive store service");
		cacheName = "IArchiveStore";
		cache = findByNameAndKey(cacheName, dbServiceQuery);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		archiveStoreService = MStorageProvider.getArchiveStoreService(dbServiceQuery);
		assertNotNull(archiveStoreService, "Can't find archive store service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		ServiceQuery fileSystemServiceQuery = new ServiceQuery();
		fileSystemServiceQuery.put("method", "FileSystem");
		archiveStoreService = MStorageProvider.getArchiveStoreService(fileSystemServiceQuery);
		assertNotNull(archiveStoreService, "Can't find archive store service");
		hit = cache.getHit();
		archiveStoreService = MStorageProvider.getArchiveStoreService(fileSystemServiceQuery);
		assertNotNull(archiveStoreService, "Can't find archive store service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		assertTrue(cache.size() == 2, "Size for " + cacheName + " != 2");
		
		//IAttachmentStore
		IAttachmentStore attachmentStoreService = MStorageProvider.getAttachmentStoreService(dbServiceQuery);
		assertNotNull(attachmentStoreService, "Can't find attachment store service");
		cacheName = "IAttachmentStore";
		cache = findByNameAndKey(cacheName, dbServiceQuery);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		attachmentStoreService = MStorageProvider.getAttachmentStoreService(dbServiceQuery);
		assertNotNull(attachmentStoreService, "Can't find attachment store service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		attachmentStoreService = MStorageProvider.getAttachmentStoreService(fileSystemServiceQuery);
		assertNotNull(attachmentStoreService, "Can't find attachment store service");
		hit = cache.getHit();
		attachmentStoreService = MStorageProvider.getAttachmentStoreService(fileSystemServiceQuery);
		assertNotNull(attachmentStoreService, "Can't find attachment store service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		assertTrue(cache.size() == 2, "Size for " + cacheName + " != 2");
		
		//IImageStore
		IImageStore imagetStoreService = MStorageProvider.getImageStoreService(dbServiceQuery);
		assertNotNull(imagetStoreService, "Can't find image store service");
		cacheName = "IImageStore";
		cache = findByNameAndKey(cacheName, dbServiceQuery);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		imagetStoreService = MStorageProvider.getImageStoreService(dbServiceQuery);
		assertNotNull(imagetStoreService, "Can't find image store service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		imagetStoreService = MStorageProvider.getImageStoreService(fileSystemServiceQuery);
		assertNotNull(imagetStoreService, "Can't find image store service");
		hit = cache.getHit();
		imagetStoreService = MStorageProvider.getImageStoreService(fileSystemServiceQuery);
		assertNotNull(imagetStoreService, "Can't find image store service");
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		assertTrue(cache.size() == 2, "Size for " + cacheName + " != 2");
		
		//IModelFactory
		cacheName = "IModelFactory";
		cacheKey = MInvoice.Table_Name;
		Class<?> modelClass = MTable.getClass(cacheKey);
		assertNotNull(modelClass, "Can't find model class for " + cacheKey);
		cache = findByNameAndKey(cacheName, cacheKey);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		modelClass = MTable.getClass(cacheKey);
		assertNotNull(modelClass, "Can't find model class for " + cacheKey);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");
		
		//IDisplayTypeFactory
		TestActivator.context.registerService(IDisplayTypeFactory.class, new FakeDisplayTypeFactory(), null);
		cacheName = "IDisplayTypeFactory";
		boolean isLOB = DisplayType.isLOB(FakeDisplayTypeFactory.DISPLAY_TYPE);
		assertFalse(isLOB);
		boolean isText = DisplayType.isText(FakeDisplayTypeFactory.DISPLAY_TYPE);
		assertTrue(isText);
		cache = findByNameAndKey(cacheName, FakeDisplayTypeFactory.DISPLAY_TYPE);
		assertNotNull(cache, "Can't find cache for " + cacheName);
		hit = cache.getHit();
		isText = DisplayType.isText(FakeDisplayTypeFactory.DISPLAY_TYPE);
		assertTrue(isText);
		assertTrue(cache.getHit() > hit, "Hit for " + cacheName + " doesn't increase as expected");		
	}
	
	private CCache<?, ?> findByTableNameAndKey(String tableName, Object key) {
		CacheInterface[] cis = CacheMgt.get().getInstancesAsArray();
		for(CacheInterface ci : cis) {
			if (ci instanceof CCache<?, ?>) {				
				@SuppressWarnings("rawtypes")
				CCache ccache = (CCache) ci;
				if (ccache.getName().equals(ccache.getTableName()) && ccache.getTableName().equals(tableName)) {
					if (ccache.containsKey(key)) {
						return ccache;
					}
				}
			}
		}
		return null;
	}
	
	private CCache<?, ?> findByNameAndKey(String name, Object key) {
		CacheInterface[] cis = CacheMgt.get().getInstancesAsArray();
		for(CacheInterface ci : cis) {
			if (ci instanceof CCache<?, ?>) {				
				@SuppressWarnings("rawtypes")
				CCache ccache = (CCache) ci;
				if (ccache.getName().equals(name)) {
					if (key != null) {
						if (ccache.containsKey(key)) {
							return ccache;
						}
					} else {
						return ccache;
					}
				}
			}
		}
		return null;
	}
		
	@Test
	public void testPrintFormatCacheReset() {
		MPrintFormat cache = MPrintFormat.get(ORDER_HEADER_PRINT_FORMAT_ID);
		String description = cache.getDescription();
		MPrintFormat cache1 = MPrintFormat.get(SHIPMENT_HEADER_PRINT_FORMAT_ID);
		MPrintFormat update = new MPrintFormat(Env.getCtx(), cache.get_ID(), null);
		try {			
			update.setDescription(update.getAD_PrintFormat_UU());
			update.saveEx();
			
			//wait for async cache reset
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}
			
			cache = MPrintFormat.get(ORDER_HEADER_PRINT_FORMAT_ID);
			assertEquals(update.getDescription(), cache.getDescription(), "Expected cache reset doesn't happens");
			
			//shipment header shouldn't reload since only order header have been updated
			cache = MPrintFormat.get(SHIPMENT_HEADER_PRINT_FORMAT_ID);
			assertTrue(cache == cache1, "Unexpected cache reset for print format record that's not being updated");
		} finally {
			update.load((String)null);
			update.setDescription(description);
			update.saveEx();
		}
	}
	
	private static class MTestCache extends CCache<Integer, MTest> {
		private static final long serialVersionUID = 1L;
		private int resetCount = 0;
		
		public MTestCache(String name, int capacity) {
			super(name, capacity);
		}
				
		@Override
		public int reset() {
			resetCount++;
			return super.reset();
		}

		@Override
		public int reset(int recordId) {
			resetCount++;
			return super.reset(recordId);
		}

		@Override
		public void newRecord(int record_ID) {
			resetCount++;
			super.newRecord(record_ID);
		}
		
		public int getResetCount() {
			return resetCount;
		}
		
		public void clearResetCount() {
			resetCount = 0;
		}
	};
	
	@Test
	public void testSuspendCacheReset() {
		MTest test1 = new MTest(Env.getCtx(), 0, getTrxName());
		MTest test2 = new MTest(Env.getCtx(), 0, getTrxName());
		MTest test3 = new MTest(Env.getCtx(), 0, getTrxName());
		try {
			MTestCache cache = new MTestCache(MTest.Table_Name, 10);
			
			//test insert and cache reset
			test1.setName("test1");
			test1.saveEx();
			test2.setName("test2");
			test2.saveEx();
			test3.setName("test3");
			test3.saveEx();
			
			cache.put(test1.get_ID(), test1);
			cache.put(test2.get_ID(), test2);
			cache.put(test3.get_ID(), test3);
			
			cache.clearResetCount();			
			commit();
			getTrx().start();
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}			
			assertTrue(cache.getResetCount() > 0, "Cache reset count is zero");
			
			//test update and cache reset
			
			test1.setName("test1.1");
			test1.saveEx();
			test2.setName("test2.1");
			test2.saveEx();
			test3.setName("test3.1");
			test3.saveEx();
			
			cache.put(test1.get_ID(), test1);
			cache.put(test2.get_ID(), test2);
			cache.put(test3.get_ID(), test3);
			
			cache.clearResetCount();			
			commit();
			getTrx().start();
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}			
			assertTrue(cache.getResetCount() > 0, "Cache reset count is zero");
			
			//test update and cache reset after suspend reset call
			
			CacheMgt.get().suspendTableCacheReset(MTest.Table_Name);
			
			test1.setName("test1.2");
			test1.saveEx();
			test2.setName("test2.2");
			test2.saveEx();
			test3.setName("test3.2");
			test3.saveEx();
			
			cache.put(test1.get_ID(), test1);
			cache.put(test2.get_ID(), test2);
			cache.put(test3.get_ID(), test3);
			
			cache.clearResetCount();			
			commit();
			getTrx().start();
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}
			assertTrue(cache.getResetCount() == 0, "Cache reset count is not zero with suspendTableCacheReset active");
			
			//test delete and cache reset after suspend reset call
			
			cache.put(test1.get_ID(), test1);
			cache.put(test2.get_ID(), test2);
			cache.put(test3.get_ID(), test3);
						
			test1.deleteEx(true);
			test1 = null;
			test2.deleteEx(true);
			test2 = null;
			test3.deleteEx(true);
			test3 = null;
					
			cache.clearResetCount();			
			commit();
			getTrx().start();
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}
			assertTrue(cache.getResetCount() == 0, "Cache reset count is not zero with suspendTableCacheReset active");
			
			//test update and cache reset again after resume reset call
			
			CacheMgt.get().resumeTableCacheReset(MTest.Table_Name);
			
			test1 = new MTest(Env.getCtx(), 0, getTrxName());
			test2 = new MTest(Env.getCtx(), 0, getTrxName());
			test3 = new MTest(Env.getCtx(), 0, getTrxName());
			
			test1.setName("test1");
			test1.saveEx();
			test2.setName("test2");
			test2.saveEx();
			test3.setName("test3");
			test3.saveEx();
			
			cache.put(test1.get_ID(), test1);
			cache.put(test2.get_ID(), test2);
			cache.put(test3.get_ID(), test3);
			
			cache.clearResetCount();			
			commit();
			getTrx().start();
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}			
			assertTrue(cache.getResetCount() > 0, "Cache reset count is zero");
			
		} finally {
			if (test1 != null && test1.get_ID() > 0)
				test1.deleteEx(true);
			if (test2 != null && test2.get_ID() > 0)
				test2.deleteEx(true);
			if (test3 != null && test3.get_ID() > 0)
				test3.deleteEx(true);
			
			commit();
		}
	}
	
	@Test
	public void testExpire() {
		ImmutableIntPOCache<Integer,MProduct> cache	= new ImmutableIntPOCache<Integer,MProduct>(MProduct.Table_Name, 40, 1);	//1 minutes
		cache.put(DictionaryIDs.M_Product.AZALEA_BUSH.id, new MProduct(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, null));
		cache.put(DictionaryIDs.M_Product.P_CHAIR.id, new MProduct(Env.getCtx(), DictionaryIDs.M_Product.P_CHAIR.id, null));
		
		for(int i = 0; i < 2; i++) {
			assertNotNull(cache.get(DictionaryIDs.M_Product.P_CHAIR.id), "Unexpected expire of cache item after " + i + " access");
			try {
				Thread.sleep(35*1000); //35 seconds
			} catch (InterruptedException e) {}
		}
		
		assertNotNull(cache.get(DictionaryIDs.M_Product.P_CHAIR.id), "Cache item expire despite being access recently");
		assertNull(cache.get(DictionaryIDs.M_Product.AZALEA_BUSH.id), "Cache item not expire despite not being access for more than 1 minutes");
		
		CacheMgt.get().unregister(cache);
	}

	@Test
	public void testNullKey() {
		CCache<String, String> testCache = new CCache<String, String>(null, "Test_Cache", 10, 60, false);
		assertThatNoException().isThrownBy(() -> testCache.get(null));
		assertThatNoException().isThrownBy(() -> testCache.containsKey(null));
		assertThatNoException().isThrownBy(() -> testCache.containsValue(null));
		assertFalse(testCache.containsValue(null));
		testCache.put("TestNull", null);
		assertFalse(testCache.containsValue(null)); // still false because null is an unknown value
		
		CacheMgt.get().unregister(testCache);
	}

	@Test
	public void testTrlCacheReset() {
		// test cache reset
		String locale = "es_CO";
		MProduct p = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, null);
		String esName = p.get_Translation("Name", locale);
		Query query = new Query(Env.getCtx(), MProduct.Table_Name+"_Trl", "M_Product_ID=? AND AD_Language=?", null);
		PO po = query.setParameters(p.get_ID(), locale).firstOnly();
		assertEquals(esName, po.get_Value("Name"), "Expected translation not found");
		try {
			po.set_ValueOfColumn("Name", esName+"1");
			po.saveEx();
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}
			assertEquals(esName+"1", p.get_Translation("Name", locale), "Translation not refresh in cache");
		} finally {
			po.set_ValueOfColumn("Name", esName);
			po.saveEx();
		}
		
		//test translation reset for uuid key table
		MTestUU uu = new MTestUU(Env.getCtx(), "8858ecc2-cf1d-405f-987f-793536037e76", null);
		esName = uu.get_Translation("Name", locale);
		query = new Query(Env.getCtx(), MTestUU.Table_Name+"_Trl", "TestUU_UU=? AND AD_Language=?", null);
		po = query.setParameters(uu.get_UUID(), locale).firstOnly();
		assertEquals(esName, po.get_Value("Name"), "Expected translation not found");
		try {
			po.set_ValueOfColumn("Name", esName+"1");
			po.saveEx();
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}
			assertEquals(esName+"1", uu.get_Translation("Name", locale), "Translation not refresh in cache");
		} finally {
			po.set_ValueOfColumn("Name", esName);
			po.saveEx();
		}
	}
	
	/**
	 * Test cases for constructor
	 * @throws Exception
	 */
	@Test
	public void testConstructor() throws Exception {
		String tableName = "TestTable";
	    String name = "TestCache";
	    int initialCapacity = 10;
	    int expireMinutes = 5;
	    boolean distributed = true;
	    int maxSize = 100;

	    // Create cache with distributed = true
	    CCache<String, String> cache = new CCache<String, String>(tableName, name, initialCapacity, expireMinutes, distributed, maxSize);

	    // Accessible fields
	    assertEquals(name, cache.getName());
	    assertEquals(tableName, cache.getTableName());
	    assertEquals(expireMinutes, cache.getExpireMinutes());
	    assertEquals(distributed, cache.isDistributed());
	    assertEquals(maxSize, cache.getMaxSize());

	    // Protected fields: use reflection
	    Field fCache = CCache.class.getDeclaredField("cache");
	    fCache.setAccessible(true);
	    assertNotNull(fCache.get(cache), "cache should be initialized");

	    Field fNullList = CCache.class.getDeclaredField("nullList");
	    fNullList.setAccessible(true);
	    assertNotNull(fNullList.get(cache), "nullList should always be initialized");

	    // Non-distributed = false
	    CCache<String, String> cache2 = new CCache<String, String>(tableName, name, initialCapacity, expireMinutes, false, maxSize);
	    assertFalse(cache2.isDistributed());
	    fNullList.setAccessible(true);
	    assertNotNull(fNullList.get(cache2), "nullList should be initialized even if not distributed");

	    // maxSize fallback when getCacheMaxSize(name) < 0
	    CCache<String, String> cache3 = new CCache<String, String>(tableName, name, initialCapacity, expireMinutes, false, 50);
	    assertEquals(50, cache3.getMaxSize());
	    
	    CacheMgt.get().unregister(cache);
	    CacheMgt.get().unregister(cache2);
	    CacheMgt.get().unregister(cache3);
	}
	
	/**
	 * Test cases for CCache.containsValue(Object)
	 */
	@Test
	public void testContainsValue() {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestCache", 10, 0, false, 100);

	    // Case 1: null value
	    assertFalse(cache.containsValue(null), "Null value must return false");

	    // Case 2: non-null value, cache empty
	    assertFalse(cache.containsValue("V1"), "Value not in cache must return false");

	    // Case 3: non-null value exists in cache
	    cache.put("K1", "V1");
	    assertTrue(cache.containsValue("V1"), "Existing value must return true");

	    // Case 4: different value not present
	    assertFalse(cache.containsValue("V2"), "Different value must return false");
	    
	    CacheMgt.get().unregister(cache);
	}
	
	/**
	 * Test cases for CCache.entrySet()
	 */
	@Test
	public void testEntrySet() {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestCacheEntrySet", 10, 0, false, 100);

	    // Case 1: empty cache
	    Set<Map.Entry<String, String>> emptySet = cache.entrySet();
	    assertNotNull(emptySet, "entrySet must not return null");
	    assertTrue(emptySet.isEmpty(), "entrySet must be empty for empty cache");

	    // Case 2: cache with entries
	    cache.put("K1", "V1");
	    cache.put("K2", "V2");
	    Set<Map.Entry<String, String>> entrySet = cache.entrySet();
	    assertEquals(2, entrySet.size(), "entrySet size must match cache size");

	    // Case 3: verify actual content
	    Map<String, String> mapView = new HashMap<>();
	    for (Map.Entry<String, String> entry : entrySet) {
	        mapView.put(entry.getKey(), entry.getValue());
	    }
	    assertEquals("V1", mapView.get("K1"));
	    assertEquals("V2", mapView.get("K2"));
	    
	    CacheMgt.get().unregister(cache);
	}

	/**
	 * Test cases for CCache.isExpire()
	 * @throws Exception
	 */
	@Test
	public void testIsExpire() throws Exception {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestCacheExpire", 10, 0, false, 100);

	    Field expireField = CCache.class.getDeclaredField("m_expire");
	    expireField.setAccessible(true);

	    Field timeExpField = CCache.class.getDeclaredField("m_timeExp");
	    timeExpField.setAccessible(true);

	    long now = System.currentTimeMillis();

	    // Case 1: m_expire <= 0  → false
	    expireField.setInt(cache, 0);
	    timeExpField.setLong(cache, now - 1000);
	    assertFalse(cache.isExpire(), "Should not expire when m_expire <= 0");

	    // Case 2: m_expire > 0, m_timeExp <= 0 → false
	    expireField.setInt(cache, 10);
	    timeExpField.setLong(cache, 0);
	    assertFalse(cache.isExpire(), "Should not expire when m_timeExp <= 0");

	    // Case 3: m_expire > 0, m_timeExp > now → false
	    expireField.setInt(cache, 10);
	    timeExpField.setLong(cache, now + 60_000);
	    assertFalse(cache.isExpire(), "Should not expire when expiration time is in the future");

	    // Case 4: m_expire > 0, m_timeExp < now → true
	    expireField.setInt(cache, 10);
	    timeExpField.setLong(cache, now - 1);
	    assertTrue(cache.isExpire(), "Should expire when m_timeExp is in the past");
	    
	    CacheMgt.get().unregister(cache);
	}
	
	/**
	 * Test cases for CCache.isReset()
	 * @throws Exception
	 */
	@Test
	public void testIsReset() throws Exception {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestCacheReset", 10, 0, false, 100);

	    Field justResetField = CCache.class.getDeclaredField("m_justReset");
	    justResetField.setAccessible(true);

	    // Case 1: m_justReset = false
	    justResetField.setBoolean(cache, false);
	    assertFalse(cache.isReset(), "Should return false when m_justReset is false");

	    // Case 2: m_justReset = true
	    justResetField.setBoolean(cache, true);
	    assertTrue(cache.isReset(), "Should return true when m_justReset is true");
	    
	    CacheMgt.get().unregister(cache);
	}

	/**
	 * Test cases for CCache.putAll(Map)
	 * @throws Exception
	 */
	@Test
	public void testPutAll() throws Exception {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestCachePutAll", 10, 0, false, 100);

	    // Access protected/internal fields
	    Field justResetField = CCache.class.getDeclaredField("m_justReset");
	    justResetField.setAccessible(true);

	    // Simulate cache was just reset
	    justResetField.setBoolean(cache, true);

	    // Pre-existing entry
	    cache.put("A", "1");

	    // Map to putAll
	    Map<String, String> values = new HashMap<>();
	    values.put("B", "2");
	    values.put("C", "3");
	    cache.putAll(values);

	    // 1. m_justReset must be cleared
	    assertFalse(cache.isReset(), "putAll() must reset m_justReset to false");

	    // 2. Existing entries remain
	    assertEquals("1", cache.get("A"));

	    // 3. New entries are added
	    assertEquals("2", cache.get("B"));
	    assertEquals("3", cache.get("C"));

	    // 4. Size check (implicit cache.putAll delegation)
	    assertEquals(3, cache.size());
	    
	    CacheMgt.get().unregister(cache);
	}

	/**
	 * Test cases for CCache.remove(Object)
	 * @throws Exception
	 */
	@Test
	public void testRemove() throws Exception {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestCacheRemove", 10, 0, false, 100);

	    // Access protected nullList field
	    Field nullListField = CCache.class.getDeclaredField("nullList");
	    nullListField.setAccessible(true);

	    // Add entries to cache
	    cache.put("A", "1");
	    cache.put("B", "2");

	    // Add "C" to nullList
	    @SuppressWarnings("unchecked")
	    Set<String> nullList = (Set<String>) nullListField.get(cache);
	    nullList.add("C");

	    // 1. Remove key in nullList → returns null, removes from nullList
	    assertTrue(nullList.contains("C"));
	    assertNull(cache.remove("C"));
	    assertFalse(nullList.contains("C"));

	    // 2. Remove key in cache → returns value, removes from cache
	    assertEquals("1", cache.remove("A"));
	    assertNull(cache.get("A"));

	    // 3. Remove non-existing key → returns null
	    assertNull(cache.remove("Z"));

	    // 4. Remove key that was in nullList before → already removed, now should delegate to cache
	    assertNull(cache.remove("C"));
	    
	    CacheMgt.get().unregister(cache);
	}
	
	/**
	 * Test cases for CCache.reset(int)
	 * @throws Exception
	 */
	@Test
	public void testResetByRecordId() throws Exception {
	    CCache<Integer, String> cache = new CCache<>("TestTable", "TestReset", 10, 0, false, 100);

	    // Access protected nullList field
	    Field nullListField = CCache.class.getDeclaredField("nullList");
	    nullListField.setAccessible(true);
	    @SuppressWarnings("unchecked")
	    Set<Integer> nullList = (Set<Integer>) nullListField.get(cache);

	    // Add entries to cache and nullList
	    cache.put(1, "one");
	    cache.put(2, "two");
	    nullList.add(3);
	    nullList.add(4);

	    // Scenario 1: recordId <= 0 → delegates to reset()
	    cache.put(100, "hundred"); // ensure cache is not empty
	    assertEquals(5, cache.reset(0)); // expect all entries cleared, see note below

	    // Restore entries
	    cache.put(1, "one");
	    cache.put(2, "two");
	    nullList.add(3);
	    nullList.add(4);

	    // Scenario 2: recordId in nullList → returns 1, removed
	    assertTrue(nullList.contains(3));
	    assertEquals(1, cache.reset(3));
	    assertFalse(nullList.contains(3));

	    // Scenario 3: recordId in cache → returns 1, removed
	    assertTrue(cache.containsValue("one"));
	    assertEquals(1, cache.reset(1));
	    assertFalse(cache.containsValue("one"));

	    // Scenario 4: recordId not in cache or nullList → returns 0
	    assertEquals(0, cache.reset(999));

	    // Scenario 5: cache empty, nullList empty → returns 0
	    cache.reset(2); // remove 2 from cache
	    cache.reset(4); // remove 4 from nullList
	    assertTrue(cache.isEmpty());
	    assertTrue(nullList.isEmpty());
	    assertEquals(0, cache.reset(1));

	    // Scenario 6: firstKey not an Integer → delegates to reset()
	    CCache<String, String> stringCache = new CCache<>("TestTable", "TestResetString", 10, 0, false, 100);
	    stringCache.put("A", "alpha");
	    // reset(int) with String-keyed cache delegates to full reset()
	    assertEquals(1, stringCache.reset(1)); // delegates to reset(), clears all entries (only 1 present)
	    
	    CacheMgt.get().unregister(cache);
	    CacheMgt.get().unregister(stringCache);
	}
	
	/**
	 * Test cases for CCache.resetByStringKey(String)
	 * @throws Exception
	 */
	@Test
	public void testResetByStringKey() throws Exception {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestResetStringKey", 10, 0, false, 100);

	    // Access protected fields
	    Field nullListField = CCache.class.getDeclaredField("nullList");
	    nullListField.setAccessible(true);
	    @SuppressWarnings("unchecked")
	    Set<String> nullList = (Set<String>) nullListField.get(cache);

	    // Fill cache and nullList
	    cache.put("A", "alpha");
	    cache.put("B", "beta");
	    nullList.add("C");
	    nullList.add("D");

	    // Scenario 1: empty key → delegates to reset()
	    cache.put("Z", "zeta");
	    assertEquals(5, cache.resetByStringKey("")); // resets all (delegates)
	    cache.put("A", "alpha"); cache.put("B", "beta"); nullList.add("C"); nullList.add("D");

	    // Scenario 2: key in nullList → returns 1, removed
	    assertTrue(nullList.contains("C"));
	    assertEquals(1, cache.resetByStringKey("C"));
	    assertFalse(nullList.contains("C"));

	    // Scenario 3: key in cache → returns 1, removed
	    assertTrue(cache.containsValue("alpha"));
	    assertEquals(1, cache.resetByStringKey("A"));
	    assertFalse(cache.containsValue("alpha"));

	    // Scenario 4: key not in cache or nullList → returns 0
	    assertEquals(0, cache.resetByStringKey("NonExist"));

	    // Scenario 5: cache empty, nullList empty → returns 0
	    cache.resetByStringKey("B"); // remove B from cache
	    cache.resetByStringKey("D"); // remove D from nullList
	    assertTrue(cache.isEmpty());
	    assertTrue(nullList.isEmpty());
	    assertEquals(0, cache.resetByStringKey("AnyKey"));

	    // Scenario 6: firstKey not a String → delegates to reset()
	    CCache<Integer, String> intCache = new CCache<>("TestTable", "TestResetInt", 10, 0, false, 100);
	    intCache.put(1, "one");
	    intCache.put(2, "two");
	    assertEquals(2, intCache.resetByStringKey("one")); // delegates to reset(), clears all 2 entries
	    
	    CacheMgt.get().unregister(cache);
	    CacheMgt.get().unregister(intCache);
	}

	/**
	 * Test cases for CCache.setUsed()
	 * @throws Exception
	 */
	@Test
	public void testSetUsed() throws Exception {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestSetUsed", 10, 0, false, 100);

	    // Access protected field
	    Field justResetField = CCache.class.getDeclaredField("m_justReset");
	    justResetField.setAccessible(true);

	    // Set it to true initially
	    justResetField.setBoolean(cache, true);
	    assertTrue(cache.isReset());

	    // Call setUsed() → should set m_justReset to false
	    cache.setUsed();
	    assertFalse(cache.isReset());
	    
	    CacheMgt.get().unregister(cache);
	}
	
	/**
	 * Test cases for CCache.sizeNoExpire()
	 * @throws Exception
	 */
	@Test
	public void testSizeNoExpire() throws Exception {
	    CCache<String, String> cache = new CCache<>("TestTable", "TestSizeNoExpire", 10, 0, false, 100);
	    
	    // Initially empty → size should be 0
	    assertEquals(0, cache.sizeNoExpire());

	    // Add entries to cache via public API
	    cache.put("k1", "v1");
	    cache.put("k2", "v2");
	    assertEquals(2, cache.sizeNoExpire());

	    // For nullList, reflection is still needed to test that aspect
	    Field nullListField = CCache.class.getDeclaredField("nullList");
	    nullListField.setAccessible(true);
	    @SuppressWarnings("unchecked")
		Set<String> nullList = (Set<String>) nullListField.get(cache);
	    nullList.add("k3");
	    assertEquals(3, cache.sizeNoExpire());
	    
	    CacheMgt.get().unregister(cache);
	}

	/**
	 * Test cases for CCache.toString()
	 */
	@Test
	public void testToString() {
	    CCache<Integer, String> cache = new CCache<>("TestTable", "TestCache", 10, 60, false, 100);

	    // Use putAll to populate cache (m_justReset is handled inside)
	    Map<Integer, String> data = Map.of(1, "One", 2, "Two");
	    cache.putAll(data);

	    // Access cache to generate some hit/miss statistics
	    cache.get(1); // generates a hit
	    cache.get(999); // generates a miss

	    String str = cache.toString();
	    assertNotNull(str, "toString should not return null");
	    assertTrue(str.contains("TestCache"), "Name should appear in string");
	    assertTrue(str.contains("Exp=60"), "Expire minutes should appear in string");
	    assertTrue(str.contains("#2"), "Cache size should appear in string");
	    assertTrue(str.contains("Hit="), "Hit counter should appear");
	    assertTrue(str.contains("Miss="), "Miss counter should appear");
	    
	    CacheMgt.get().unregister(cache);
	}

}
