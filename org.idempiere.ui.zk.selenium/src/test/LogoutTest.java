package test;

import org.idempiere.ui.zk.selenium.Zk;
import org.junit.Test;
import org.openqa.selenium.WebElement;

import static org.junit.Assert.*;

public class LogoutTest extends AbstractTestCase {

	@Test
	public void testLogin() throws Exception {
		login();
		WebElement logout = driver.findElement(Zk.jq("$logout"));
		logout.click();
		
		Thread.sleep(2000);
		WebElement loginWindow = driver.findElement(Zk.jq("$loginPanel"));
		assertTrue(loginWindow != null && loginWindow.isDisplayed());
	}
}
