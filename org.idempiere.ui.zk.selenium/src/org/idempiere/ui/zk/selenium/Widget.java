package org.idempiere.ui.zk.selenium;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.SearchContext;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.internal.WrapsDriver;

public class Widget extends By {

	private String locator;

	public Widget(String locator) {
		this.locator = locator;
	}
	
	public Widget(WebElement element) {
		String id = element.getAttribute("id");
		locator = "#"+id;
	}

	@Override
	public List<WebElement> findElements(SearchContext context) {
		List<WebElement> list = new ArrayList<WebElement>();
		if (context instanceof WebDriver)
			list.add(findElement((WebDriver) context));
		else {
			WrapsDriver wrapsDriver = (WrapsDriver) context;			
			list.add(findElement(wrapsDriver.getWrappedDriver()));
		}
		return list;
	}

	private WebElement findElement(WebDriver driver) {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		StringBuilder builder = getWidgetLocatorScript(locator);
		builder.insert(0, "return ").append(".$n();");
		return (WebElement) executor.executeScript(builder.toString());
	}
	
	public WebElement $n(WebDriver driver, String subName) {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		StringBuilder builder = getWidgetLocatorScript(locator);
		builder.insert(0, "return ")
			.append(".$n('").append(subName).append("');");
		return (WebElement) executor.executeScript(builder.toString());
	}

	public void execute(WebDriver driver, String command) {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		StringBuilder builder = getWidgetLocatorScript(locator);
		builder.append(".").append(command).append(";");
		executor.executeScript(builder.toString());
	}

	public Object eval(WebDriver driver, String command) {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		StringBuilder builder = getWidgetLocatorScript(locator);
		builder.insert(0, "return ");
		builder.append(".").append(command).append(";");
		return executor.executeScript(builder.toString());
	}
	
	public static StringBuilder getWidgetLocatorScript(String locator) {
		locator = locator.replace("'", "\\'");
		StringBuilder builder = new StringBuilder("zk('");
		builder.append(locator).append("').$()");
		return builder;
	}
}
