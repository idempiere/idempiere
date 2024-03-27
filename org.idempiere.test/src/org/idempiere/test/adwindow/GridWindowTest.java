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
 **********************************************************************/
package org.idempiere.test.adwindow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.Optional;

import org.adempiere.webui.apps.AEnv;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridWindowVO;
import org.compiere.model.I_AD_Window;
import org.compiere.model.MField;
import org.compiere.model.MSession;
import org.compiere.model.MTab;
import org.compiere.model.MUserDefField;
import org.compiere.model.MUserDefTab;
import org.compiere.model.MUserDefWin;
import org.compiere.model.SystemIDs;
import org.compiere.util.CCache;
import org.compiere.util.CacheInterface;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;
import org.junit.jupiter.api.parallel.Isolated;

@Isolated
@Execution(ExecutionMode.SAME_THREAD)
public class GridWindowTest extends AbstractTestCase {

	public GridWindowTest() {
	}

	@Test
	public void testGridWindowCache() {
		int testRecordIdFieldId = 207570; //advanced field
		String gridWindowVOCacheName = I_AD_Window.Table_Name+"|GridWindowVO";
		String gridTabVOsCacheName = "GridTabVOs Cache";
		
		//init static cache
		GridWindowVO.get(SystemIDs.WINDOW_TEST, 0);
		
		//find cache via name
		CCache<?, ?> gridTabVOsCache = null;
		CCache<?, ?> gridWindowVOCache = null;
		CacheInterface[] cacheInstances = CacheMgt.get().getInstancesAsArray();
		for(CacheInterface cacheInstance : cacheInstances) {
			if (cacheInstance instanceof CCache<?, ?> ccache) {
				if (ccache.getName().equals(gridTabVOsCacheName)) {
					gridTabVOsCache = ccache;
				} else if (ccache.getName().equals(gridWindowVOCacheName)) {
					gridWindowVOCache = ccache;
				}
			}			
		}
		
		assertNotNull(gridWindowVOCache, "Can't find cache for GridWindowVO");
		assertNotNull(gridTabVOsCache, "Can't find cache for GridTabVOs");
		gridWindowVOCache.reset();
		gridTabVOsCache.reset();
		
		long gridWindowVOCacheHit = gridWindowVOCache.getHit();
		long gridTabVOsCacheHit = gridTabVOsCache.getHit();
		
		//init cache
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);
		GridWindowVO.get(SystemIDs.WINDOW_TEST, 0);
		
		//test GridWindowVO.create call with advanced role				
		GridWindowVO windowVO = GridWindowVO.create(Env.getCtx(), 1, SystemIDs.WINDOW_TEST);
		ArrayList<GridFieldVO> fields = windowVO.Tabs.get(0).getFields();		
		Optional<GridFieldVO> optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertTrue(optional.isPresent(), "Not Found, Record ID field of Test Window");
		
		assertTrue(gridWindowVOCache.getHit() > gridWindowVOCacheHit, "GridWindowVO cache hit doesn't increase as expected");
		assertTrue(gridTabVOsCache.getHit() > gridTabVOsCacheHit, "GridTabVOs cache hit doesn't increase as expected");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
		
		//test GridWindowVO.create call with not advanced role
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN_NOT_ADVANCED.id);		
		windowVO = GridWindowVO.create(Env.getCtx(), 1, SystemIDs.WINDOW_TEST);
		fields = windowVO.Tabs.get(0).getFields();
		optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertFalse(optional.isPresent(), "Record ID field of Test Window found for not advanced role");
		
		assertTrue(gridWindowVOCache.getHit() > gridWindowVOCacheHit, "GridWindowVO cache hit doesn't increase as expected");
		//gridTabVOs cache for advanced role will not get hit for GridWindowVO.create call with not-advanced role
		assertTrue(gridTabVOsCache.getHit() == gridTabVOsCacheHit, "Unexpected increase of GridTabVOs cache hit");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
		
		//test GridWindowVO.get call with advanced role
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);		
		windowVO = GridWindowVO.get(SystemIDs.WINDOW_TEST, 1);
		fields = windowVO.Tabs.get(0).getFields();
		optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertTrue(optional.isPresent(), "Not Found, Record ID field of Test Window");
		
		assertTrue(gridWindowVOCache.getHit() > gridWindowVOCacheHit, "GridWindowVO cache hit doesn't increase as expected");
		assertTrue(gridTabVOsCache.getHit() > gridTabVOsCacheHit, "GridTabVOs cache hit doesn't increase as expected");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
		
		//test GridWindowVO.get call with not advanced role
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN_NOT_ADVANCED.id);		
		windowVO = GridWindowVO.get(SystemIDs.WINDOW_TEST, 1);
		fields = windowVO.Tabs.get(0).getFields();
		optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertFalse(optional.isPresent(), "Record ID field of Test Window found for not advanced role");
		
		assertTrue(gridWindowVOCache.getHit() > gridWindowVOCacheHit, "GridWindowVO cache hit doesn't increase as expected");
		assertTrue(gridTabVOsCache.getHit() > gridTabVOsCacheHit, "GridTabVOs cache hit doesn't increase as expected");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
		
		//test session cache with advanced role
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);
		Env.setContext(Env.getCtx(), Env.AD_SESSION_ID, System.currentTimeMillis()+"");
		windowVO = AEnv.getMWindowVO(1, SystemIDs.WINDOW_TEST, 0);
		fields = windowVO.Tabs.get(0).getFields();
		optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertTrue(optional.isPresent(), "Not Found, Record ID field of Test Window");
		
		assertTrue(gridWindowVOCache.getHit() > gridWindowVOCacheHit, "GridWindowVO cache hit doesn't increase as expected");
		assertTrue(gridTabVOsCache.getHit() > gridTabVOsCacheHit, "GridTabVOs cache hit doesn't increase as expected");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
				
		//repeat with session cache
		windowVO = AEnv.getMWindowVO(1, SystemIDs.WINDOW_TEST, 0);
		fields = windowVO.Tabs.get(0).getFields();
		optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertTrue(optional.isPresent(), "Not Found, Record ID field of Test Window");
		
		//both cache should not get any hit since AEnv.getMWindowVO will get from session cache (AEnv.windowCache) instead
		assertTrue(gridWindowVOCache.getHit() == gridWindowVOCacheHit, "Unexpected increase of GridWindowVO cache hit");
		assertTrue(gridTabVOsCache.getHit() == gridTabVOsCacheHit, "Unexpected increase of GridTabVOs cache hit");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
		
		//test session call with not advanced role
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN_NOT_ADVANCED.id);
		Env.setContext(Env.getCtx(), Env.AD_SESSION_ID, System.currentTimeMillis()+"");
		windowVO = AEnv.getMWindowVO(1, SystemIDs.WINDOW_TEST, 0);
		fields = windowVO.Tabs.get(0).getFields();
		optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertFalse(optional.isPresent(), "Record ID field of Test Window found for not advanced role");
		
		assertTrue(gridWindowVOCache.getHit() > gridWindowVOCacheHit, "GridWindowVO cache hit doesn't increase as expected");
		assertTrue(gridTabVOsCache.getHit() > gridTabVOsCacheHit, "GridTabVOs cache hit doesn't increase as expected");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
		
		//repeat with session cache
		windowVO = AEnv.getMWindowVO(1, SystemIDs.WINDOW_TEST, 0);
		fields = windowVO.Tabs.get(0).getFields();
		optional = fields.stream().filter(e -> e.AD_Field_ID == testRecordIdFieldId).findFirst();
		assertFalse(optional.isPresent(), "Record ID field of Test Window found for not advanced role");
		
		//both cache should not get any hit since AEnv.getMWindowVO will get from session cache (AEnv.windowCache) instead
		assertTrue(gridWindowVOCache.getHit() == gridWindowVOCacheHit, "Unexpected increase of GridWindowVO cache hit");
		assertTrue(gridTabVOsCache.getHit() == gridTabVOsCacheHit, "Unexpected increase of GridTabVOs cache hit");		
		gridWindowVOCacheHit = gridWindowVOCache.getHit();
		gridTabVOsCacheHit = gridTabVOsCache.getHit();
	}
	
	@Test	
	public void testUserDefWin() {
		int testTabId = 152;
		int testDateField = 425;
		MUserDefWin win = new MUserDefWin(Env.getCtx(), 0, null);
		win.setAD_Window_ID(SystemIDs.WINDOW_TEST);
		win.setAD_Role_ID(DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);
		win.saveEx();
		
		MUserDefTab tab = new MUserDefTab(Env.getCtx(), 0, null);
		tab.setAD_UserDef_Win_ID(win.get_ID());
		tab.setAD_Tab_ID(testTabId);
		String tabName = MTab.get(testTabId).getName();
		String customTabName = tabName+"|"+win.get_ID();
		tab.setName(customTabName);
		tab.saveEx();
		
		MUserDefField field = new MUserDefField(Env.getCtx(), 0, null);
		field.setAD_UserDef_Tab_ID(tab.get_ID());
		String fieldName = MField.get(testDateField).getName();
		String customFieldName = fieldName+"|"+tab.get_ID();
		field.setAD_Field_ID(testDateField);
		field.setName(customFieldName);
		field.saveEx();
		
		try {
			//test with GARDEN_WORLD_ADMIN role
			MSession.create(Env.getCtx());
			Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id);		
			GridWindowVO windowVO = GridWindowVO.create(Env.getCtx(), 1, SystemIDs.WINDOW_TEST);
			assertNotNull(windowVO.Tabs, "Failed to retrieve GridTabVOs");
			assertEquals(1, windowVO.Tabs.size(), "Failed to retrieve GridTabVOs");
			assertEquals(customTabName, windowVO.Tabs.get(0).Name, "Not getting name from MUserDefTab");
			Optional<GridFieldVO> optional = windowVO.Tabs.get(0).getFields().stream().filter(e -> e.AD_Field_ID == testDateField).findFirst();
			assertTrue(optional.isPresent(), "Failed to find Date field of Test window");
			assertEquals(customFieldName, optional.get().Header, "Not getting custom header from MUserDefField");

			windowVO = GridWindowVO.get(SystemIDs.WINDOW_TEST, 1);
			assertNotNull(windowVO.Tabs, "Failed to retrieve GridTabVOs");
			assertEquals(1, windowVO.Tabs.size(), "Failed to retrieve GridTabVOs");
			assertEquals(customTabName, windowVO.Tabs.get(0).Name, "Not getting name from MUserDefTab");
			optional = windowVO.Tabs.get(0).getFields().stream().filter(e -> e.AD_Field_ID == testDateField).findFirst();
			assertTrue(optional.isPresent(), "Failed to find Date field of Test window");
			assertEquals(customFieldName, optional.get().Header, "Not getting custom header from MUserDefField");
			
			windowVO = AEnv.getMWindowVO(1, SystemIDs.WINDOW_TEST, 0);
			assertNotNull(windowVO.Tabs, "Failed to retrieve GridTabVOs");
			assertEquals(1, windowVO.Tabs.size(), "Failed to retrieve GridTabVOs");
			assertEquals(customTabName, windowVO.Tabs.get(0).Name, "Not getting name from MUserDefTab");
			optional = windowVO.Tabs.get(0).getFields().stream().filter(e -> e.AD_Field_ID == testDateField).findFirst();
			assertTrue(optional.isPresent(), "Failed to find Date field of Test window");
			assertEquals(customFieldName, optional.get().Header, "Not getting custom header from MUserDefField");
			
			//test with GARDEN_WORLD_ADMIN_NOT_ADVANCED role
			MSession.create(Env.getCtx());
			Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN_NOT_ADVANCED.id);
			windowVO = GridWindowVO.create(Env.getCtx(), 1, SystemIDs.WINDOW_TEST);
			assertNotNull(windowVO.Tabs, "Failed to retrieve GridTabVOs");
			assertEquals(1, windowVO.Tabs.size(), "Failed to retrieve GridTabVOs");
			assertEquals(tabName, windowVO.Tabs.get(0).Name, "Not getting original name from AD_Tab");
			optional = windowVO.Tabs.get(0).getFields().stream().filter(e -> e.AD_Field_ID == testDateField).findFirst();
			assertTrue(optional.isPresent(), "Failed to find Date field of Test window");
			assertEquals(fieldName, optional.get().Header, "Not getting original header from AD_Field");

			windowVO = GridWindowVO.get(SystemIDs.WINDOW_TEST, 1);
			assertNotNull(windowVO.Tabs, "Failed to retrieve GridTabVOs");
			assertEquals(1, windowVO.Tabs.size(), "Failed to retrieve GridTabVOs");
			assertEquals(tabName, windowVO.Tabs.get(0).Name, "Not getting original name from AD_Tab");
			optional = windowVO.Tabs.get(0).getFields().stream().filter(e -> e.AD_Field_ID == testDateField).findFirst();
			assertTrue(optional.isPresent(), "Failed to find Date field of Test window");
			assertEquals(fieldName, optional.get().Header, "Not getting original header from AD_Field");
			
			windowVO = AEnv.getMWindowVO(1, SystemIDs.WINDOW_TEST, 0);
			assertNotNull(windowVO.Tabs, "Failed to retrieve GridTabVOs");
			assertEquals(1, windowVO.Tabs.size(), "Failed to retrieve GridTabVOs");
			assertEquals(tabName, windowVO.Tabs.get(0).Name, "Not getting original name from AD_Tab");
			optional = windowVO.Tabs.get(0).getFields().stream().filter(e -> e.AD_Field_ID == testDateField).findFirst();
			assertTrue(optional.isPresent(), "Failed to find Date field of Test window");
			assertEquals(fieldName, optional.get().Header, "Not getting original header from AD_Field");
		} finally {
			field.deleteEx(true);
			tab.deleteEx(true);
			win.deleteEx(true);			
		}
	}
}
