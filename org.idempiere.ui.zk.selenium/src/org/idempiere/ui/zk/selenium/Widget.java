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
		return (WebElement) executor.executeScript("return zk('"+locator+"').$().$n();");
	}
	
	public WebElement $n(WebDriver driver, String subName) {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		return (WebElement) executor.executeScript("return zk('"+locator+"').$().$n('"+subName+"');");
	}

	public void execute(WebDriver driver, String command) {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		executor.executeScript("zk('"+locator+"').$()."+command+";");
	}

	public Object eval(WebDriver driver, String command) {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		return executor.executeScript("return zk('"+locator+"').$()."+command+";");
	}
}
