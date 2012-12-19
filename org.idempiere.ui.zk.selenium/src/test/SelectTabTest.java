package test;

import static org.junit.Assert.*;

import org.idempiere.ui.zk.selenium.Zk;
import org.junit.*;
import org.openqa.selenium.WebElement;

/**
 * Web Driver + zk jq selector, doesn't required AdempiereIdGenerator
 * @author hengsin
 *
 */
public class SelectTabTest extends AbstractTestCase {
	@Test
	public void testSelectTab() throws Exception {
		login();			
		waitResponse();
		openWindow("Product");
		waitResponse();
		clickButton("$findWindow_1 $simpleSearch $btnOk");
		waitResponse();
		selectTab("$Product_1 $detailPane @tabbox", 2);
		assertFalse("Business Partner".equals(selectedTab("$Product_1 $detailPane @tabbox")));
		waitResponse();
		selectTab("$Product_1 $detailPane @tabbox", "Business Partner");
		assertEquals("Business Partner", selectedTab("$Product_1 $detailPane @tabbox"));
		
		WebElement element = driver.findElement(Zk.jq("$Product_1 $Product @textbox[instanceName=\"M_Product0Name\"]"));
		assertNotNull(element);
	}
}
