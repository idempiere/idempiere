/**
 * 
 */
package fitlibrary.zk;

import java.util.List;

import org.idempiere.ui.zk.selenium.Widget;
import org.idempiere.ui.zk.selenium.Zk;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
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

	@SimpleAction(wiki = "|''<i>comboBox</i>''|xpath, id or other locator|''<i>select item</i>''|label of item|", tooltip = "Changes the selected item in the given comboBox.")
	public boolean comboboxSelectItem(String locator, String label) {
		Widget widget = new Widget(locator);
		WebElement element = widget.$n(webDriver, "real");
		element.clear();
		element.sendKeys(label);
		element.sendKeys(Keys.ENTER);
		return label.equals(element.getAttribute("value"));
	}

	@SimpleAction(wiki = "|''<i>comboBox</i>''|xpath, id or other locator|''<i>select item at</i>''|index|", tooltip = "Changes the selected item to the nth one, in the given comboBox.")
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
