package org.idempiere.ui.zk.selenium;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.SearchContext;
import org.openqa.selenium.WebElement;

/**
 * utility class to find elements using zk jq selector
 * @author hengsin
 *
 */
public class Zk extends By {

	private String selector;

	private Zk(String selector) {
		this.selector = selector;
	}

	@Override
	public List<WebElement> findElements(SearchContext context) {
		List<WebElement> list = (List<WebElement>) ((JavascriptExecutor)context).executeScript("return jq('" + selector + "').get();");
		return list;
	}

	public static Zk jq(String selector) {
		return new Zk(selector);
	}
}
