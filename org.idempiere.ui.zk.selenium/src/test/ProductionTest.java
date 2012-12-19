package test;

import org.idempiere.ui.zk.selenium.Zk;
import org.junit.Test;

import static org.junit.Assert.*;
import org.openqa.selenium.WebElement;

/**
 * Test case for http://jira.idempiere.com/browse/IDEMPIERE-520
 * @author hengsin
 *
 */
public class ProductionTest extends AbstractTestCase {

	@Test
	public void testIDempiere520() throws Exception {
		login();
		
		String windowId = "Production__Single_Product__1";
		
		openWindow("Production (Single Product)");
		
		waitResponse();
		
		//check detail is shown for new record
		WebElement element = driver.findElement(Zk.jq("$"+windowId+" $detailPane @tabbox"));
		
		assertTrue(element != null && element.isDisplayed());
		
		search("$"+windowId+" $Production $M_Product_ID", "PatioSet");
		waitResponse();
		
		type("$"+windowId+" $Production $ProductionQty @decimalbox", "1");
		
		
		clickToolbarButton(windowId, "BtnSave");
		waitResponse();

		//verify save successfull
		element = getWindowMessageLabel(windowId);
		assertTrue("Record saved".equals(element.getText()));
		
		clickDetailToolbarButton(windowId, "BtnNew");
		
		//verify +*1/1 for is shown for new record
		waitResponse();
		element = driver.findElement(Zk.jq("$"+windowId+" $recordInfo"));
		assertEquals("+*1/1", element.getText());
		
		//test for npe
		clickToolbarButton(windowId, "BtnParentRecord");		
		waitResponse();
		
		//create production lines
		clickProcessButton(windowId, "CreateFrom");
		waitResponse();
		clickButton("$"+windowId+" @window[title=\"Create Production\"] $Ok");
		waitResponse();
		
		clickDetailToolbarButton(windowId, "BtnEdit");
		waitResponse();
		
		//verify qc tab visible for first record
		element = driver.findElement(Zk.jq("$"+windowId+" $detailPane @tab"));
		assertTrue(element != null && element.isDisplayed());
		
		nextRecord(windowId);
		waitResponse();
		
		//verify qc tab is invisible for first record
		element = driver.findElement(Zk.jq("$"+windowId+" $detailPane @tab"));
		assertTrue(element == null || !element.isDisplayed());
	}	
}
