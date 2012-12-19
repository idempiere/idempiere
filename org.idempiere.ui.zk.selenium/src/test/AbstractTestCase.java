package test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import java.util.concurrent.TimeUnit;

import org.idempiere.ui.zk.selenium.Widget;
import org.idempiere.ui.zk.selenium.Zk;
import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
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
	
	protected void comboboxSelectItem(String locator, String label) {
		Widget widget = new Widget(locator);
		widget.execute(driver, "setValue('"+label+"')");
		widget.execute(driver, "fireOnChange()");		
		WebElement element = widget.$n(driver, "real");
		element.click();
	}

	protected void comboboxSelectItem(WebElement select, String label) {
		Widget widget = new Widget(select);
		widget.execute(driver, "setValue('"+label+"')");
		widget.execute(driver, "fireOnChange()");		
		WebElement element = widget.$n(driver, "real");
		element.click();
	}
	
	protected void search(String locator, String label) {
		Widget widget = new Widget(locator + " @textbox");
		WebElement element = widget.findElement(driver);
		element.click();
		widget.execute(driver, "setValue('"+label+"')");
		widget.execute(driver, "fireOnChange()");				
	}
	
	protected void selectCheckbox(String locator, boolean select) {
		final WebElement element = driver.findElement(Zk.jq("$"+locator+" ~ input"));
		if (element.isSelected()) {
			if (!select) {
				element.click();
			}
		} else {
			if (select) {
				element.click();
			}
		}
	}
	
	protected void clickButton(String locator) {
		driver.findElement(Zk.jq(locator)).click();
	}
	
	protected void selectTab(String locator, int index) {
		Widget widget = new Widget(locator);
		WebElement element = (WebElement) widget.eval(driver, "getTabs().getChildAt("+index+").$n('cnt');");
		element.click();
	}
	
	protected void selectTab(String locator, String label) {
		Widget widget = new Widget(locator + " @tab[label=\""+label+"\"]");
		widget.$n(driver, "cnt").click();
	}
	
	protected String selectedTab(String locator) {
		Widget widget = new Widget(locator);
		return (String) widget.eval(driver, "getSelectedTab().getLabel()");
	}
	
	/**
	 * Waits for Ajax response with default timeout value.
	 */
	protected void waitResponse() {
		waitResponse(5000);
	}
	
	/**
	 * Waits for Ajax response according to the timeout attribute.
	 * @param timeout
	 * 
	 */
	protected void waitResponse(int timeout) {
		long s = System.currentTimeMillis();
		int i = 0;
		int ms = 500;
		
		String script = "!!zAu.processing() || !!jq.timers.length";
		while (i < 2) { // make sure the command is triggered.
			while(Boolean.valueOf(getEval(script))) {
				if (System.currentTimeMillis() - s > timeout) {
					break;
				}
				i = 0;//reset
				sleep(ms);
			}
			i++;
			sleep(ms);
		}
	}
	
	public String getEval(String script) {
		return String.valueOf(((JavascriptExecutor) driver).executeScript("return ("+ script+");"));
	}
	
	/**
     * Causes the currently executing thread to sleep for the specified number
     * of milliseconds, subject to the precision and accuracy of system timers
     * and schedulers. The thread does not lose ownership of any monitors.
     * @param millis the length of time to sleep in milliseconds.
     */
	protected void sleep(long millis) {
		try {
			Thread.sleep(millis);
		} catch (InterruptedException e) {
		}
	}
	
	protected void login() throws Exception {
		driver.get(baseUrl);	
		
		waitResponse();

		// enter user name
		type("$loginPanel $txtUserId", "GardenAdmin");

		// enter password
		type("$loginPanel $txtPassword", "GardenAdmin");
		
		//select language
		comboboxSelectItem("$loginPanel $lstLanguage", "English");

		// check select role
		selectCheckbox("$loginPanel $chkSelectRole", true);		
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
			sleep(1000);
		}
		return driver.findElement(loginUserQuery);
	}

	protected void selectRole(String client, String role, String org) throws InterruptedException {
		// wait for role panel
		WebElement lstClient = waitForElement("$rolePanel $lstClient");
		
		// select client
		if (lstClient != null && lstClient.isDisplayed()) {
			comboboxSelectItem(lstClient, client);
		}

		// select role
		comboboxSelectItem("$rolePanel $lstRole", role);

		// select organization
		comboboxSelectItem("$rolePanel $lstOrganisation", org);

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

	protected void openWindow(String label) {
		comboboxSelectItem("$treeSearchCombo", label);
	}

	protected void clickProcessButton(String windowId, String btnId) {
		clickButton("$"+windowId + " $windowToolbar $BtnProcess");		
		waitResponse();
		clickButton("@window[instanceName=\"processButtonPopup\"] $" + btnId);
	}
	
	protected void clickToolbarButton(String windowId, String toolBarButtonId) {
		clickButton("$" + windowId + " $windowToolbar $" + toolBarButtonId);
	}
	
	protected void clickDetailToolbarButton(String windowId, String toolBarButtonId) {
		clickButton("$" + windowId + " $detailPane $" + toolBarButtonId + ":visible");
	}
	
	protected WebElement getWindowMessageLabel(String windowId) {
		return driver.findElement(Zk.jq("$"+windowId +" $messages @label"));
	}
	
	protected void nextRecord(String windowId) {
		clickButton("$"+windowId+" $breadCrumb $Next");
	}
	
	protected void previousRecord(String windowId) {
		clickButton("$"+windowId+" $breadCrumb $Previous");
	}
	
	@After
	public void tearDown() throws Exception {
		//driver.quit();
		String verificationErrorString = verificationErrors.toString();
		if (!"".equals(verificationErrorString)) {
			fail(verificationErrorString);
		}
	}
	
	protected  String escape(String role) {
		return role.replace(" ", "\\\\ ");
	}
}
