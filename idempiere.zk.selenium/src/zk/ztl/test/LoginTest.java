/* LoginTest.java

	Purpose:
		
	Description:
		
	History:
		Dec, 6, 2012 17:09:52 PM

Copyright (C) 2012 Potix Corporation. All Rights Reserved.

This program is distributed under Apache License Version 2.0 in the hope that
it will be useful, but WITHOUT ANY WARRANTY.
*/
package zk.ztl.test;
import org.junit.Test;
import org.zkoss.ztl.Element;
import org.zkoss.ztl.JQuery;
import org.zkoss.ztl.Tags;
import org.zkoss.ztl.Widget;
import org.zkoss.ztl.ZK;
import org.zkoss.ztl.ZKClientTestCase;
import org.zkoss.ztl.util.*;

import org.openqa.selenium.*;
import com.thoughtworks.selenium.Selenium;
import com.thoughtworks.selenium.SeleniumException;

@Tags(tags = "login")
public class LoginTest extends ZKClientTestCase {
	
	public LoginTest() {
		target = "";
		browsers = getBrowsers("firefox");
		_timeout = 20000;
		caseID = getClass().getSimpleName();
	}
	
	@Test(expected = AssertionError.class)
	public void testlogin() {
		for (Selenium browser : browsers) {
			try {
				start(browser);
				windowFocus();
				windowMaximize();
				String zscript = "";
				Widget engine = new Widget(new StringBuffer("zk.Desktop._dt"));
				
				// remove all of unnecessary children
				if (target.endsWith("/service.zul"))
					removeChildren(engine.firstChild());
					
				/** start **/
			/** client code **/
				
				type(jq("$loginPanel $txtUserId"), "SuperUser");
				type(jq("$loginPanel $txtPassword"), "System");
				click(widget(jq("$loginPanel $chkSelectRole")).$n("real"));
				click(jq("$loginPanel $Ok"));
				waitResponse();
				click(jq("$rolePanel $lstClient ~ .z-combobox-btn"));
				click(jq("$rolePanel $lstClient $GardenWorld"));
				click(jq("$rolePanel $lstRole ~ .z-combobox-btn"));
				click(jq("$rolePanel $lstRole $GardenWorld\\\\ Admin"));
				waitResponse();
				click(jq("$rolePanel $lstOrganisation ~ .z-combobox-btn"));
				click(jq("$rolePanel $lstOrganisation $HQ"));
				click(jq("$rolePanel $Ok"));
				waitResponse();
				verifyEquals("SuperUser@GardenWorld.HQ/GardenWorld Admin", jq("$loginUserAndRole").text());
				
				/** end **/
			} catch (SeleniumException e) {
				ZKSelenium zbrowser = ((ZKSelenium) browser);
				ConfigHelper.getInstance().clearCache(zbrowser);
				zbrowser.shutdown();
				throw e;
			} finally {
				stop();	
			}
		}
	}
}



