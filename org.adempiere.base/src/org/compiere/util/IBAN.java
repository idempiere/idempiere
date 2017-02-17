// adapted from http://how-blogz.blogspot.de/2007/08/java-iban-check-digit-validation.html
// soastation.banking.IBAN

package org.compiere.util;

import java.math.BigInteger;

import java.util.ResourceBundle;

public class IBAN {
	
	/**
	 * @param iban
	 * @return normalized IBAN
	 */
	
	public static String normalizeIBAN(String iban)
	{
		if (iban!=null)
		{
			return iban.trim().replace(" ", "") ;
		}
		return null ;
	}
	/**
	 * Determines if the given IBAN is valid based on the check digit. To
	 * validate the checksum: 1. Check that the total IBAN length is correct as
	 * per the country. If not, the IBAN is invalid. 2. Move the four initial
	 * characters to the end of the string. 3. Replace the letters in the string
	 * with digits, expanding the string as necessary, such that A=10, B=11 and
	 * Z=35. 4. Convert the string to an integer and mod-97 the entire number.
	 * If the remainder is 1 you have a valid IBAN number.
	 * 
	 * @param iban
	 * @return boolean indicating if specific IBAN has a valid check digit
	 */
	public static boolean isCheckDigitValid(String iban) {
		try {
			if (null == iban)
				return false;
			int validIBANLength = getValidIBANLength(iban);
			if (validIBANLength < 4)
				return false;
			if (iban.length() != validIBANLength)
				return false;

			BigInteger numericIBAN = getNumericIBAN(iban, false);

			int checkDigit = numericIBAN.mod(new BigInteger("97")).intValue();
			return checkDigit == 1;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * Using the IBAN.properties file gets the valid fixed length value for a
	 * country code. Only uses the first 2 characters of the given string.
	 * 
	 * @param countryCode
	 * @return
	 */
	public static int getValidIBANLength(String countryCode) {
		String code = countryCode.substring(0, 2).toUpperCase();
		String length = ResourceBundle.getBundle(IBAN.class.getCanonicalName()).getString("length." + code);
		if (length == null)
			return -1;
		return Integer.valueOf(length).intValue();
	}

	private static BigInteger getNumericIBAN(String iban, boolean isCheckDigitAtEnd) {
		String endCheckDigitIBAN = iban;
		if (!isCheckDigitAtEnd) {
			// Move first four characters to end of string to put check digit at
			// end
			endCheckDigitIBAN = iban.substring(4) + iban.substring(0, 4);
		}
		StringBuffer numericIBAN = new StringBuffer();
		for (int i = 0; i < endCheckDigitIBAN.length(); i++) {
			if (Character.isDigit(endCheckDigitIBAN.charAt(i))) {
				numericIBAN.append(endCheckDigitIBAN.charAt(i));
			} else {
				numericIBAN.append(10 + getAlphabetPosition(endCheckDigitIBAN.charAt(i)));
			}
		}

		return new BigInteger(numericIBAN.toString());
	}

	private static int getAlphabetPosition(char letter) {
		return Character.valueOf(Character.toUpperCase(letter)).compareTo(Character.valueOf('A'));
	}

}
