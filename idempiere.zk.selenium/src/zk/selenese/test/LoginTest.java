package zk.selenese.test;

import java.util.concurrent.TimeUnit;
import org.junit.*;
import static org.junit.Assert.*;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;

/**
 * Generated from selenium ide, required AdempiereIdGenerator
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
		// type | id=loginPanel_grdLogin_rowUser_txtUserId | SuperUser
		driver.findElement(By.id("loginPanel_grdLogin_rowUser_txtUserId")).clear();
		driver.findElement(By.id("loginPanel_grdLogin_rowUser_txtUserId")).sendKeys("SuperUser");
		
		// fireEvent | id=loginPanel_grdLogin_rowUser_txtUserId | blur
		// not needed for webdriver
		// type | id=loginPanel_grdLogin_rowPassword_txtPassword | System
		driver.findElement(By.id("loginPanel_grdLogin_rowPassword_txtPassword")).clear();
		driver.findElement(By.id("loginPanel_grdLogin_rowPassword_txtPassword")).sendKeys("System");
		// fireEvent | id=loginPanel_grdLogin_rowPassword_txtPassword | blur
		// not needed for webdriver
		// click | id=loginPanel_grdLogin_rowSelectRole_chkSelectRole-real | 
		driver.findElement(By.id("loginPanel_grdLogin_rowSelectRole_chkSelectRole-real")).click();
		// click | loginPanel_Ok | 10
		driver.findElement(By.id("loginPanel_Ok")).click();
		// waitForElementPresent | id=rolePanel_grdChooseRole_rowclient_lstClient-btn | 
		for (int second = 0;; second++) {
			if (second >= 60) fail("timeout");
			try { if (isElementPresent(By.id("rolePanel_grdChooseRole_rowclient_lstClient-btn"))) break; } catch (Exception e) {}
			Thread.sleep(1000);
		}

		// click | id=rolePanel_grdChooseRole_rowclient_lstClient-btn | 
		driver.findElement(By.id("rolePanel_grdChooseRole_rowclient_lstClient-btn")).click();
		// click | css=#rolePanel_grdChooseRole_rowclient_lstClient_GardenWorld > td.z-comboitem-text | 
		driver.findElement(By.cssSelector("#rolePanel_grdChooseRole_rowclient_lstClient_GardenWorld > td.z-comboitem-text")).click();
		Thread.sleep(1000);
		// click | id=rolePanel_grdChooseRole_rowRole_lstRole-btn | 
		driver.findElement(By.id("rolePanel_grdChooseRole_rowRole_lstRole-btn")).click();
		// click | css=#rolePanel_grdChooseRole_rowRole_lstRole_GardenWorld_Admin > td.z-comboitem-text | 
		driver.findElement(By.cssSelector("#rolePanel_grdChooseRole_rowRole_lstRole_GardenWorld_Admin > td.z-comboitem-text")).click();
		Thread.sleep(1000);
		// click | id=rolePanel_grdChooseRole_rowOrganisation_lstOrganisation-btn | 
		driver.findElement(By.id("rolePanel_grdChooseRole_rowOrganisation_lstOrganisation-btn")).click();
		// click | css=#rolePanel_grdChooseRole_rowOrganisation_lstOrganisation_HQ > td.z-comboitem-text | 
		driver.findElement(By.cssSelector("#rolePanel_grdChooseRole_rowOrganisation_lstOrganisation_HQ > td.z-comboitem-text")).click();
		// click | rolePanel_Ok | 
		driver.findElement(By.id("rolePanel_Ok")).click();
		// waitForElementPresent | loginUserAndRole | 
		for (int second = 0;; second++) {
			if (second >= 60) fail("timeout");
			try { if (isElementPresent(By.id("loginUserAndRole"))) break; } catch (Exception e) {}
			Thread.sleep(1000);
		}
		// assertText | loginUserAndRole | SuperUser@GardenWorld.HQ/GardenWorld Admin
		assertEquals("SuperUser@GardenWorld.HQ/GardenWorld Admin", driver.findElement(By.id("loginUserAndRole")).getText());
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
