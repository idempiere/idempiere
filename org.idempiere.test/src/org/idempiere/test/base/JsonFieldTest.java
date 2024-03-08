package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;

import org.compiere.dbPort.Convert;
import org.compiere.model.I_AD_UserPreference;
import org.compiere.model.MTest;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Tests for JSON data type
 * Run Isolated because of migration script file management
 */
@Isolated
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
		
		testPO = new MTest(Env.getCtx(), getClass().getName(), 1, getTrxName());
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
		Env.setContext(Env.getCtx(), I_AD_UserPreference.COLUMNNAME_MigrationScriptComment, "IDEMPIERE-02981 JsonFieldTest");
		testPO.setJsonData(validJsonString);
		updated = testPO.save();
		assertTrue(updated);
		
		testPO.setJsonData(validJsonArray);
		updated = testPO.save();
		assertTrue(updated);
		
		Env.getCtx().setProperty(Ini.P_LOGMIGRATIONSCRIPT, "");

		String fileName = Convert.getGeneratedMigrationScriptFileName();
		String folderPg = Convert.getMigrationScriptFolder("postgresql");
		String folderOr = Convert.getMigrationScriptFolder("oracle");
		Convert.closeLogMigrationScript();
		File file = new File(folderPg + fileName);
		assertTrue(file.exists(), "Not found: " + folderPg + fileName);
		file.delete();
		file = new File(folderOr + fileName);
		assertTrue(file.exists(), "Not found: " + folderOr + fileName);
		file.delete();
	}
}
