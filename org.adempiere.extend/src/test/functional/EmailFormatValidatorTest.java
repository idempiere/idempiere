/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package test.functional;

import static org.junit.Assert.assertEquals;

import java.util.Arrays;
import java.util.Collection;

import org.compiere.util.EMail;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

/*
 * Unit test sample from http://examples.javacodegeeks.com/core-java/util/regex/matcher/validate-email-address-with-java-regular-expression-example/
 */

@RunWith(Parameterized.class)
public class EmailFormatValidatorTest {

	private String arg;
	private Boolean expectedValidation;

	public EmailFormatValidatorTest(String str, Boolean expectedValidation) {
		this.arg = str;
		this.expectedValidation = expectedValidation;
	}

	@BeforeClass
	public static void initialize() {
	}

	@Parameters
	public static Collection<Object[]> data() {
		Object[][] data = new Object[][] {
				{ "javacodegeeks@gmail.com.2j",true },
				{ "java@java@oracle.com", false },         // you cannot have @ twice in the address
				{ "java!!!@example.com", true },
				{ "mysite@.com", false },                  // tld cannot start with a dot
				{ "javacodegees.com", false },             // must contain a @ character and a tld
				{ ".javacodegees.com@at.com", true },
				{ "javacodegees..javacom@at.com", true },
				{ "javacodegeeks@gmail.com",true },                         
				{ "nikos+mylist@gmail.com", true },
				{ "abc.efg-900@gmail-list.com", true },
				{ "abc123@example.com.gr", true },
				{ "username+detail@example.com", true },
				{ "user@example.museum", true },
				{ "myemail+sketchysite@gmail.com", true },
				{ "micky.o'finnagan@wherever.com", true },
				{ "exampleemail@testing.info", true },
				{ "marcelo.calbucci%mandic@fapesp.com.br", true },
				{ "customer/department=shipping@example.com", true },
				{ "$A12345@example.com", true },
				{ "!def!xyz%abc@example.com", true },
				{ "_somename@example.com", true },
				{ "nuñez@globalqss.com", false },
				{ "name@tld", true },
				{ "john@server.department.company.com", true }
				};

		return Arrays.asList(data);
	}

	@Test
	public void test() {
		Boolean res = EMail.validate(this.arg);
		String validv = (res) ? "valid" : "invalid";
		System.out.println("EMail "+arg+ " is " + validv);
		assertEquals("Result", this.expectedValidation, res);
	}

}