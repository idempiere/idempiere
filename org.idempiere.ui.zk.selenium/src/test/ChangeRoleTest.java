package test;

import org.idempiere.ui.zk.selenium.Zk;
import org.junit.Test;
import org.openqa.selenium.WebElement;

import static org.junit.Assert.*;

public class ChangeRoleTest extends AbstractTestCase {

	@Test
	public void testLogin() throws Exception {
		login();	
		
		waitResponse();
		
		driver.findElement(Zk.jq("$changeRole")).click();
		
		waitResponse();
		
		// wait for home page
		selectRole("GardenWorld", "GardenWorld User", "HQ");

		WebElement element = waitForElement("$loginUserAndRole");
		
		// assert login user and role
		assertEquals("GardenAdmin@GardenWorld.HQ/GardenWorld User", element.getText());
	}
	
}
