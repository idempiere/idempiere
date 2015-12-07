/******************************************************************************
 * Copyright (C) 2015 iDempiere                                               *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.idempiere.util;

import java.util.Iterator;
import java.util.regex.Pattern;

/**
 * This class help for parse order configuration
 * example problem in IDEMPIERE-2296. some people wish priority of "default value" is higher than "user value preference"
 * some other wish reverse.
 * it's better for define 1 is representative for "default value" and 2 is representative for "user value preference"
 * in configuration just set 12 or 21 for order configuration.
 * 
 * this class will help by provide method same in Iterable, it's also provider validate for duplicate value as 221 or 211
 * @author hieplq
 *
 */
public class ParseSeq implements Iterable<Character> {
	
	public static String MSG_NOT_NULL = "configuration must is a not null or non empty string";
	public static String MSG_ONLY_NUNBER = "your value must contain only number character";
	public static String MSG_CONTAIN_DUP = "your value must contain non duplicate character";
	/**
	 * init a Order configuration by parse configuration value, 
	 * configuration can contain duplicate value or contain only number
	 * when detect wrong configuration value, a {@link IllegalArgumentException} will throw
	 * 
	 * @param orderConfiguration configuration value as "5ry76t"
	 * @param allowDupCharacter if false configuration value as "1245648" is wrong value by "4" is duplicate
	 * @param onlyNumber configuration value contain only number
	 */
	private ParseSeq (String orderConfiguration, boolean allowDupCharacter, boolean onlyNumber){
		parseValue(orderConfiguration, allowDupCharacter, onlyNumber);
		this.orderConfiguration = orderConfiguration;
	}
	
	private String orderConfiguration;

	/**
	 * pattern matching a string only number character
	 */
	private Pattern regCheckOnlyNumber = Pattern.compile("\\d+");
	/**
	 * pattern find duplicate character in string
	 */
	private Pattern regCheckDupChar = Pattern.compile("(\\w).*\\1");
	
	/**
	 * validate input string
	 * @param orderConfiguration
	 * @param allowDupCharacter
	 * @param onlyNumber
	 */
	protected void parseValue (String orderConfiguration, boolean allowDupCharacter, boolean onlyNumber){
		if (orderConfiguration == null || orderConfiguration.length() == 0)
			throw new IllegalArgumentException(MSG_NOT_NULL);
		
		if (onlyNumber && !regCheckOnlyNumber.matcher(orderConfiguration).matches()){
			throw new IllegalArgumentException(MSG_ONLY_NUNBER);
		}
		
		if (!allowDupCharacter && regCheckDupChar.matcher(orderConfiguration).find()){
			throw new IllegalArgumentException(MSG_CONTAIN_DUP);
		}
	}

	@Override
	public Iterator<Character> iterator() {
		return new IteratorOrderUtil (orderConfiguration);
		
	}
	
	/**
	 * constructor maybe become complicate by add more validate (don't allow space, don't allow special,...)
	 * use get for simple when init this object, don't need add try catch block when use
	 * @param orderConfiguration
	 * @return null when input string isn't suitable
	 */
	public static ParseSeq getNumberOrder (String orderConfiguration){
		ParseSeq numberOrder = null;
		try{
			numberOrder = new ParseSeq(orderConfiguration, false, true);
		}catch (IllegalArgumentException ex){
			return null;
		}
		
		return numberOrder;
	}
	
	/**
	 * support class for iterator throw start to end of order
	 * @author hieplq
	 *
	 */
	public static class IteratorOrderUtil implements Iterator<Character>{
		private String orderConfiguration;
		int currentIndex = -1;
		public IteratorOrderUtil (String orderConfiguration){
			this.orderConfiguration = orderConfiguration;
		}
		
		@Override
		public boolean hasNext() {
			return currentIndex < orderConfiguration.length() - 1;
		}

		@Override
		public Character next() {
			currentIndex++;
			return  orderConfiguration.charAt(currentIndex);
		}

		/**
		 * don't support this function
		 */
		@Override
		public void remove() {
			throw new UnsupportedOperationException("Don't support this action");
		}
		
	}
	
	/**
	 * run test for utility
	 * @param args
	 */
	public static void main(String[] args) {
		ParseSeq test = null;
		try{
			test = new ParseSeq ("e345", true, true);
			System.out.printf("Test for check only number case has non number:%s", false);
			System.out.println();
		}catch (IllegalArgumentException ex){
			System.out.printf("Test for check only number case has non number:%1$s", MSG_ONLY_NUNBER.equals(ex.getMessage()));
			System.out.println();
		}
		
		try{
			test = new ParseSeq ("345", true, true);
			System.out.printf("Test for check only number case normal:%1$s", true);
			System.out.println();
		}catch (IllegalArgumentException ex){
			System.out.printf("Test for check only number case normal:%1$s", false);
			System.out.println();
		}
		
		try{
			test = new ParseSeq ("3545", true, true);
			System.out.printf("Test for check dup character case allow:%1$s", true);
			System.out.println();
		}catch (IllegalArgumentException ex){
			System.out.printf("Test for check dup character case allow:%1$s", false);
			System.out.println();
		}
		
		try{
			test = new ParseSeq ("3afa5", true, false);
			System.out.printf("Test for check dup character case allow:%1$s", true);
			System.out.println();
		}catch (IllegalArgumentException ex){
			System.out.printf("Test for check dup character case allow:%1$s", false);
			System.out.println();
		}
		
		try{
			test = new ParseSeq ("3545", false, false);
			System.out.printf("Test for check dup character case disallow:%1$s", false);
			System.out.println();
		}catch (IllegalArgumentException ex){
			System.out.printf("Test for check dup character case disallow:%1$s", MSG_CONTAIN_DUP.equals(ex.getMessage()));
			System.out.println();
		}
		
		try{
			test = new ParseSeq ("3afa5", false, false);
			System.out.printf("Test for check dup character case disallow:%1$s", false);
			System.out.println();
		}catch (IllegalArgumentException ex){
			System.out.printf("Test for check dup character case disallow:%1$s", MSG_CONTAIN_DUP.equals(ex.getMessage()));
			System.out.println();
		}
		
		try{
			test = new ParseSeq ("3sfa5", false, false);
			System.out.printf("Test for check dup character case disallow:%1$s", true);
			System.out.println();
		}catch (IllegalArgumentException ex){
			System.out.printf("Test for check dup character case disallow:%1$s", false);
			System.out.println();
		}
		
		test = ParseSeq.getNumberOrder("4567289");
		System.out.printf("travel configuration:%1$s", "4567289");
		System.out.println();
		
		for (Character ch : test){
			System.out.print(ch);
		}
			
	}

	@Override
	public String toString() {
		return "OrderConfiguration=" + orderConfiguration;
	}

}
