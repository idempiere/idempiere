package org.idempiere.ui.zk.selenium;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.SearchContext;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.internal.WrapsDriver;

/**
 * utility class to find elements using zk jq selector
 * @author hengsin
 *
 */
public class Zk {

	private Zk() {
	}

	public static By jq(String selector) {
		return new ByJqSelector(selector);
	}
	
	public static class ByJqSelector extends By {
		private String selector;

		private ByJqSelector(String selector) {
			this.selector = selector;
		}

		@Override
		public List<WebElement> findElements(SearchContext context) {
			JavascriptExecutor executor = null;
			String selector = this.selector;
			if (context instanceof WebDriver) {
				executor = (JavascriptExecutor) context;
			} else {
				WebElement element = (WebElement) context;
				String id = element.getAttribute("id");
				selector = "#"+id+" "+selector;
				executor = (JavascriptExecutor) ((WrapsDriver)element).getWrappedDriver();
			}
			@SuppressWarnings("unchecked")
			List<WebElement> list = (List<WebElement>) executor.executeScript("return jq('" + selector + "').get();");
			return list;
		}
	}
}
