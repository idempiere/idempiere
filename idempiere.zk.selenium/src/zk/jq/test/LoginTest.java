package zk.jq.test;

import java.util.concurrent.TimeUnit;

import org.idempiere.ui.zk.selenium.Zk;
import org.junit.*;
import static org.junit.Assert.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;

/**
 * Web Driver + zk jq selector, doesn't required AdempiereIdGenerator
 * @author hengsin
 *
 */
public class LoginTest {
	private WebDriver driver;
	private String baseUrl;
	private StringBuffer verificationErrors = new StringBuffer();
	@Before
	public void setUp() throws Exception {
		driver = new FirefoxDriver();
		baseUrl = "http://127.0.0.1:8080/";
		driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
	}

	@Test
	public void testLogin() throws Exception {
		// open | /webui/ | 
		driver.get(baseUrl + "/webui/");
		// enter user name
		driver.findElement(Zk.jq("$loginPanel $txtUserId")).clear();
		driver.findElement(Zk.jq("$loginPanel $txtUserId")).sendKeys("SuperUser");
		
		// enter password
		driver.findElement(Zk.jq("$loginPanel $txtPassword")).clear();
		driver.findElement(Zk.jq("$loginPanel $txtPassword")).sendKeys("System");
		
		// check select role 
		driver.findElement(Zk.jq("$loginPanel $chkSelectRole ~ input")).click();
		// click ok button
		driver.findElement(Zk.jq("$loginPanel $Ok")).click();
		// wait for role panel 
		for (int second = 0;; second++) {
			if (second >= 60) fail("timeout");
			try { if (isElementPresent(Zk.jq("$rolePanel $lstClient"))) break; } catch (Exception e) {}
			Thread.sleep(1000);
		}

		// select GardenWorld client 
		driver.findElement(Zk.jq("$rolePanel $lstClient ~ .z-combobox-btn")).click();
		driver.findElement(Zk.jq("$rolePanel $lstClient $GardenWorld")).click();
		
		// select GardenWorld admin role
		driver.findElement(Zk.jq("$rolePanel $lstRole ~ .z-combobox-btn")).click();
		//note the 4 \\\\ needed to escape the space character. ugly but it works
		driver.findElement(Zk.jq("$rolePanel $lstRole $GardenWorld\\\\ Admin")).click();
		
		// select HQ organization 
		driver.findElement(Zk.jq("$rolePanel $lstOrganisation ~ .z-combobox-btn")).click();
		driver.findElement(Zk.jq("$rolePanel $lstOrganisation $HQ")).click();
		
		// click ok button 
		driver.findElement(Zk.jq("$rolePanel $Ok")).click();
		
		// wait for home page 
		for (int second = 0;; second++) {
			if (second >= 60) fail("timeout");
			try { if (isElementPresent(Zk.jq("$loginUserAndRole"))) break; } catch (Exception e) {}
			Thread.sleep(1000);
		}
		
		// assert login user and role
		assertEquals("SuperUser@GardenWorld.HQ/GardenWorld Admin", driver.findElement(Zk.jq("$loginUserAndRole")).getText());
	}

	@After
	public void tearDown() throws Exception {
		driver.quit();
		String verificationErrorString = verificationErrors.toString();
		if (!"".equals(verificationErrorString)) {
			fail(verificationErrorString);
		}
	}

	private boolean isElementPresent(By by) {
		try {
			driver.findElement(by);
			return true;
		} catch (NoSuchElementException e) {
			return false;
		}
	}
}
