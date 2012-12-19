/**
 * 
 */
package fitlibrary.zk;

import java.util.List;

import org.idempiere.ui.zk.selenium.Widget;
import org.idempiere.ui.zk.selenium.Zk;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import fitlibrary.annotation.SimpleAction;
import fitlibrary.spider.AbstractSpiderFixture;
import fitlibrary.spider.Finder;
import fitlibrary.spider.SpiderFixture;

/**
 * @author hengsin
 * 
 */
public class ZkFixture extends SpiderFixture {

	private Finder _finder;

	/**
	 * 
	 */
	public ZkFixture() {
		super();
		_finder = getFinder();
		setElementFinder(new ZkFinder());
	}

	// --------- CHECKBOX ---------
	@Override
	public boolean checkbox(String locator) {
		locator = locator + " ~ input";
		return super.checkbox(locator);
	}

	@Override
	public boolean withSelect(String locator, final boolean select) {
		locator = locator + " ~ input";

		return super.withSelect(locator, select);
	}

	// --------- ComboBox ---------
	public String comboboxSelectedValue(String locator) {
		Widget widget = new Widget(locator);
		return widget.$n(webDriver, "real").getAttribute("Value");
	}

	@SimpleAction(wiki = "|''<i>combobox</i>''|xpath, id or other locator|''<i>select item</i>''|label of item|", tooltip = "Changes the selected item in the given comboBox.")
	public boolean comboboxSelectItem(String locator, String label) {
		Widget widget = new Widget(locator);
		widget.execute(webDriver, "setValue('"+label+"')");
		widget.execute(webDriver, "fireOnChange()");		
		WebElement element = widget.$n(webDriver, "real");
		element.click();
		waitResponse();
		return label.equals(element.getAttribute("value"));
	}

	@SimpleAction(wiki = "|''<i>combobox</i>''|xpath, id or other locator|''<i>select item at</i>''|index|", tooltip = "Changes the selected item to the nth one, in the given comboBox.")
	public boolean comboboxSelectItemAt(String locator, int index) {
		Widget widget = new Widget(locator);
		widget.execute(webDriver, "open()");
		List<WebElement> list = webDriver.findElements(Zk.jq(locator + " @Comboitem"));
		if (list != null && index < list.size()) {
			WebElement element = list.get(index);
			element.click();
			Widget item = new Widget("#"+element.getAttribute("id"));
			String label = (String) item.eval(webDriver, "getLabel()");
			return label.equals(comboboxSelectedValue(locator));
		}
		return false;
	}

	// ---- Tabbox ----
	@SimpleAction(wiki = "|''<i>tabbox</i>''|xpath, id or other locator|''<i>select tab at</i>''|index|", tooltip = "Changes the selected tab to the nth one, in the given tabbox.")
	public void tabboxSelectTabAt(String locator, int index) {
		Widget widget = new Widget(locator);
		WebElement element = (WebElement) widget.eval(webDriver, "getTabs().getChildAt("+index+").$n('cnt');");
		element.click();
	}
	
	@SimpleAction(wiki = "|''<i>tabbox</i>''|xpath, id or other locator|''<i>select tab</i>''|label|", tooltip = "Changes the selected tab in the given tabbox.")
	public void tabboxSelectTab(String locator, String label) {
		Widget widget = new Widget(locator + " @tab[label=\""+label+"\"]");
		widget.$n(webDriver, "cnt").click();
	}
	
	@SimpleAction(wiki = "|''<i>selected tab</i>''|xpath, id or other locator|", tooltip = "Get the label of the selected tab in the given tabbox.")
	public String selectedTab(String locator) {
		Widget widget = new Widget(locator);
		return (String) widget.eval(webDriver, "getSelectedTab().getLabel()");
	}
	
	//--- Search (lookup) --
	@SimpleAction(wiki = "|''<i>lookup</i>''|xpath, id or other locator|''<i>search</i>''|value|", tooltip = "Search lookup with value.")
	public void lookupSearch(String locator, String value) {
		Widget widget = new Widget(locator + " @textbox");
		WebElement element = widget.findElement(webDriver);
		element.click();
		widget.execute(webDriver, "setValue('"+value+"')");
		widget.execute(webDriver, "fireOnChange()");
	}
	
	// ---- window ( tab ) ---
	@SimpleAction(wiki = "|''<i>open window</i>''|menu label|", tooltip = "Open window with label.")
	public void openWindow(String label) {
		comboboxSelectItem("$treeSearchCombo", label);
	}
	
	@SimpleAction(wiki = "|''<i>window</i>''|xpath, id or other locator|''<i>click process button</i>''|button id|", tooltip = "Click a window's process button.")
	public void windowClickProcessButton(String windowLocator, String btnId) {
		click(windowLocator + " $windowToolbar $BtnProcess");		
		waitResponse();
		click("@window[instanceName=\"processButtonPopup\"] $" + btnId);
	}

	@SimpleAction(wiki = "|''<i>window</i>''|xpath, id or other locator|''<i>click toolbar</i>''|value|", tooltip = "Click a window's toolbar button")
	public void windowClickToolbar(String windowLocator, String toolbarButtonId) {
		click(windowLocator + " $windowToolbar $" + toolbarButtonId);
	}

	@SimpleAction(wiki = "|''<i>window</i>''|xpath, id or other locator|''<i>click detail toolbar</i>''|value|", tooltip = "Click the detailpane's toolbar button")
	public void windowClickDetailToolbar(String windowLocator, String toolbarButtonId) {
		click(windowLocator + " $detailPane $" + toolbarButtonId + ":visible");
	}

	@SimpleAction(wiki = "|''<i>window message</i>''|xpath, id or other locator|", tooltip = "Current status message display for a window")
	public String windowMessage(String windowLocator) {
		return webDriver.findElement(Zk.jq(windowLocator +" $messages @label")).getText();
	}

	@SimpleAction(wiki = "|''<i>window</i>''|xpath, id or other locator|''<i>next record</i>''|value|", tooltip = "Navigate to next record.")
	public void windowNextRecord(String windowLocator) {
		click(windowLocator+" $breadCrumb $Next");
	}
	
	@SimpleAction(wiki = "|''<i>window</i>''|xpath, id or other locator|''<i>previous record</i>''|value|", tooltip = "Navigate to previous record.")
	public void windowPreviousRecord(String windowLocator) {
		click(windowLocator+" $breadCrumb $Previous");
	}
	
	// -------- Wait Ajax Response -----
	@SimpleAction(wiki = "|''<i>wait response</i>''|", tooltip = "Wait for ajax response with default timeout value.")
	public void waitResponse() {
		waitResponseWithTimeout(5000);
	}
	
	@SimpleAction(wiki = "|''<i>wait response with timeout</i>''|timeout|", tooltip = "Wait for ajax response with set timeout value.")
	public void waitResponseWithTimeout(int timeout) {
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
	
	protected String getEval(String script) {
		return String.valueOf(executeJavaScript("return ("+ script+");"));
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
	
	class ZkFinder implements Finder {

		@Override
		public WebElement findElement(String locator) {
			if (locator.startsWith("$") || locator.startsWith("@")) {
				return findElement(Zk.jq(locator));
			}
			return _finder.findElement(locator);
		}

		@Override
		public WebElement findElement(By by) {
			return _finder.findElement(by);
		}

		@Override
		public List<WebElement> findElements(String locator) {
			if (locator.startsWith("$") || locator.startsWith("@")) {
				return webDriver.findElements(Zk.jq(locator));
			}
			return _finder.findElements(locator);
		}

		@Override
		public WebElement findOption(String locator, String option,
				AbstractSpiderFixture abstractSpiderFixture) {
			return _finder.findOption(locator, option, abstractSpiderFixture);
		}

	}
}
