package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MTest;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class JsonFieldTest extends AbstractTestCase {

	/**
	 * 
	 */
	public JsonFieldTest() {
	}
	
	@Test
	public void testSavingJSONValue() {
		MTest testPO = new MTest(Env.getCtx(), getClass().getName(), 1, getTrxName());
		boolean updated;
		testPO.setJsonData("Testing if JSON allows to save regular strings");
		updated = testPO.save();
		assertFalse(updated);
		
		String validJsonString = "{ \"name\": \"iDempiere\", \"id\": 100 }";
		testPO.setJsonData(validJsonString);
		updated = testPO.save();
		assertTrue(updated);
		
		String validJsonArray= "[ {\"type\": \"mobile\", \"phone\": \"001001\"} , {\"type\": \"fix\", \"phone\": \"002002\"} ]";
		testPO.setJsonData(validJsonArray);
		updated = testPO.save();
		assertTrue(updated);
		
		testPO.setJsonData(null);
		updated = testPO.save();
		assertTrue(updated);
		
		//Test inserting/updating with Values
		Env.getCtx().setProperty(Ini.P_LOGMIGRATIONSCRIPT, "Y");
		testPO.setJsonData(validJsonString);
		updated = testPO.save();
		assertTrue(updated);
		
		testPO.setJsonData(validJsonArray);
		updated = testPO.save();
		assertTrue(updated);
		
		Env.getCtx().setProperty(Ini.P_LOGMIGRATIONSCRIPT, "");

		rollback();
	}
}
