package test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.util.concurrent.TimeUnit;

import org.idempiere.ui.zk.selenium.Zk;
import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;

public class AbstractTestCase {

	protected WebDriver driver;
	protected StringBuffer verificationErrors = new StringBuffer();
	private String baseUrl;

	@Before
	public void setUp() throws Exception {
		driver = new FirefoxDriver();
//		driver = new ChromeDriver();
		baseUrl = "http://localhost:8080/webui/";
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		driver.manage().window().maximize();
	}

	protected void type(String locator, String value) {
		WebElement element = driver.findElement(Zk.jq(locator));
		element.clear();
		element.sendKeys(value);
	}
	
	protected void select(String locator, String label) {
		WebElement select = driver.findElement(Zk.jq(locator));
		select(select, label);
	}

	protected void select(WebElement select, String label) {
		select.findElement(Zk.jq(".z-combobox-btn")).click();
		try {
			Thread.sleep(500);
		} catch (InterruptedException e) {}
		select.findElement(Zk.jq("$"+escape(label))).click();
	}
	
	protected void clickCheckbox(String locator) {
		driver.findElement(Zk.jq("$"+locator+" ~ input")).click();
	}
	
	protected void clickButton(String locator) {
		driver.findElement(Zk.jq(locator)).click();
	}
	
	protected void login() throws Exception {
		driver.get(baseUrl);	
		
		Thread.sleep(500);

		// enter user name
		type("$loginPanel $txtUserId", "GardenAdmin");

		// enter password
		type("$loginPanel $txtPassword", "GardenAdmin");
		
		//select language
		select("$loginPanel $lstLanguage", "English");

		// check select role
		clickCheckbox("$loginPanel $chkSelectRole");		
		// click ok button
		clickButton("$loginPanel $Ok");		
		
		selectRole("GardenWorld", "GardenWorld Admin", "HQ");

		// wait for home page
		WebElement loginUserElement = waitForElement("$loginUserAndRole");

		// assert login user and role
		assertEquals("GardenAdmin@GardenWorld.HQ/GardenWorld Admin", loginUserElement.getText());
	}

	protected WebElement waitForElement(String locator) throws InterruptedException {
		By loginUserQuery = Zk.jq(locator);
		for (int second = 0;; second++) {
			if (second >= 60)
				fail("timeout");
			try {
				if (isElementPresent(loginUserQuery))
					break;
			} catch (Exception e) {
			}
			Thread.sleep(1000);
		}
		return driver.findElement(loginUserQuery);
	}

	protected void selectRole(String client, String role, String org) throws InterruptedException {
		// wait for role panel
		WebElement lstClient = waitForElement("$rolePanel $lstClient");
		
		// select client
		if (lstClient != null && lstClient.isDisplayed()) {
			select(lstClient, client);
		}

		// select role
		select("$rolePanel $lstRole", role);

		// select organization
		select("$rolePanel $lstOrganisation", org);

		// click ok button
		clickButton("$rolePanel $Ok");
	}
	
	protected boolean isElementPresent(By by) {
		try {
			driver.findElement(by);
			return true;
		} catch (NoSuchElementException e) {
			return false;
		}
	}
	
	@After
	public void tearDown() throws Exception {
		driver.quit();
		String verificationErrorString = verificationErrors.toString();
		if (!"".equals(verificationErrorString)) {
			fail(verificationErrorString);
		}
	}
	
	protected  String escape(String role) {
		return role.replace(" ", "\\\\ ");
	}
}
