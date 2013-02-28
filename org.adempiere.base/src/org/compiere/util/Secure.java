/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.util;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.security.AlgorithmParameters;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.crypto.Cipher;

import org.adempiere.base.Core;
import org.adempiere.base.IKeyStore;

/**
 * Security Services.
 * <p>
 * Change log:
 * <ul>
 * <li>2007-01-27 - teo_sarca - [ 1598095 ] class Secure is not working with UTF8
 * </ul>
 *  
 *  @author     Jorg Janke
 *  @version    $Id: Secure.java,v 1.2 2006/07/30 00:52:23 jjanke Exp $
 */
public class Secure implements SecureInterface
{
	/**************************************************************************
	 *	Hash checksum number
	 *  @param key key
	 *  @return checksum number
	 */
	public static int hash (String key)
	{
		long tableSize = 2147483647;	// one less than max int
		long hashValue = 0;

		for (int i = 0; i < key.length(); i++)
			hashValue = (37 * hashValue) + (key.charAt(i) -31);

		hashValue %= tableSize;
		if (hashValue < 0)
			hashValue += tableSize;

		int retValue = (int)hashValue;
		return retValue;
	}	//	hash

	
	/**************************************************************************
	 *  Convert Byte Array to Hex String
	 *  @param bytes bytes
	 *  @return HexString
	 */
	public static String convertToHexString (byte[] bytes)
	{
		//	see also Util.toHex
		int size = bytes.length;
		StringBuilder buffer = new StringBuilder(size*2);
		for(int i=0; i<size; i++)
		{
			// convert byte to an int
			int x = bytes[i];
			// account for int being a signed type and byte being unsigned
			if (x < 0)
				x += 256;
			String tmp = Integer.toHexString(x);
			// pad out "1" to "01" etc.
			if (tmp.length() == 1)
				buffer.append("0");
			buffer.append(tmp);
		}
		return buffer.toString();
	}   //  convertToHexString


	/**
	 *  Convert Hex String to Byte Array
	 *  @param hexString hex string
	 *  @return byte array
	 */
	public static byte[] convertHexString (String hexString)
	{
		if (hexString == null || hexString.length() == 0)
			return null;
		int size = hexString.length()/2;
		byte[] retValue = new byte[size];
		String inString = hexString.toLowerCase();

		try
		{
			for (int i = 0; i < size; i++)
			{
				int index = i*2;
				int ii = Integer.parseInt(inString.substring(index, index+2), 16);
				retValue[i] = (byte)ii;
			}
			return retValue;
		}
		catch (Exception e)
		{
			if (log.isLoggable(Level.FINEST)) log.finest(hexString + " - " + e.getLocalizedMessage());
		}
		return null;
	}   //  convertToHexString


	/**************************************************************************
	 * 	Adempiere Security
	 */
	public Secure()
	{
		initCipher();
	}	//	Secure
	
	/** Message Digest				*/
	private MessageDigest	m_md = null;

	private IKeyStore m_keyStore = null;
	/**	Logger						*/
	private static Logger	log	= Logger.getLogger (Secure.class.getName());

	/**
	 * 	Initialize Cipher & Key
	 */
	private synchronized void initCipher()
	{
		if(m_keyStore==null){
			m_keyStore = getKeyStore();
		}
		
	}	//	initCipher

	
	
	/**
	 *	Encryption.
	 *  @param value clear value
	 *  @param AD_Client_ID
	 *  @return encrypted String
	 */
	public String encrypt (String value,int AD_Client_ID)
 {
		String clearText = value;
		if (clearText == null)
			clearText = "";
		// Init
		if (m_keyStore == null)
			initCipher();

		// Encrypt
		try {
			Cipher cipher = Cipher.getInstance(m_keyStore.getAlgorithm());

			cipher.init(Cipher.ENCRYPT_MODE, m_keyStore.getKey(AD_Client_ID));
			byte[] encBytes = cipher.doFinal(clearText.getBytes("UTF8"));

			String encString = convertToHexString(encBytes);
			// globalqss - [ 1577737 ] Security Breach - show database password
			// log.log (Level.ALL, value + " => " + encString);
			return encString;
		} catch (Exception ex) {
			// log.log(Level.INFO, value, ex);
			log.log(Level.INFO, "Problem encrypting string", ex);
		}

		// Fallback
		return CLEARVALUE_START + value + CLEARVALUE_END;
	}	//	encrypt

	/**
	 *	Decryption.
	 * 	The methods must recognize clear text values
	 *  @param value encrypted value
	 *  @param AD_Client_ID
	 *  @return decrypted String
	 */
	public String decrypt (String value,int AD_Client_ID)
	{
		if (value == null || value.length() == 0)
			return value;
		boolean isEncrypted = value.startsWith(ENCRYPTEDVALUE_START) && value.endsWith(ENCRYPTEDVALUE_END);
		if (isEncrypted)
			value = value.substring(ENCRYPTEDVALUE_START.length(), value.length()-ENCRYPTEDVALUE_END.length());
		//	Needs to be hex String	
		byte[] data = convertHexString(value);
		if (data == null)	//	cannot decrypt
		{
			if (isEncrypted)
			{
				// log.info("Failed: " + value);
				log.info("Failed");
				return null;
			}
			//	assume not encrypted
			return value;
		}
		//	Init
		if (m_keyStore == null)
			initCipher();

		//	Encrypt
		if (value != null && value.length() > 0)
		{
			try
			{
				Cipher cipher = Cipher.getInstance(m_keyStore.getAlgorithm());
				AlgorithmParameters ap = cipher.getParameters();
				cipher.init(Cipher.DECRYPT_MODE, m_keyStore.getKey(AD_Client_ID), ap);
				byte[] out = cipher.doFinal(data);
				String retValue = new String(out, "UTF8");
				// globalqss - [ 1577737 ] Security Breach - show database password
				// log.log (Level.ALL, value + " => " + retValue);
				return retValue;
			}
			catch (Exception ex)
			{
				// log.info("Failed: " + value + " - " + ex.toString());
				if (log.isLoggable(Level.INFO)) log.info("Failed decrypting " + ex.toString());
			}
		}
		return null;
	}	//	decrypt

	/**
	 *	Encryption.
	 * 	The methods must recognize clear text values
	 *  @param value clear value
	 *  @param ad_client_id
	 *  @return encrypted String
	 */
	public Integer encrypt (Integer value,int ad_client_id)
	{
		return value;
	}	//	encrypt

	/**
	 *	Decryption.
	 * 	The methods must recognize clear text values
	 *  @param value encrypted value
	 *  @return decrypted String
	 */
	public Integer decrypt (Integer value,int ad_client_id)
	{
		return value;
	}	//	decrypt
	
	/**
	 *	Encryption.
	 * 	The methods must recognize clear text values
	 *  @param value clear value
	 *  @param ad_client_id
	 *  @return encrypted String
	 */
	public BigDecimal encrypt (BigDecimal value,int ad_client_id)
	{
		return value;
	}	//	encrypt

	/**
	 *	Decryption.
	 * 	The methods must recognize clear text values
	 *  @param value encrypted value
	 *  @return decrypted String
	 */
	public BigDecimal decrypt (BigDecimal value,int ad_client_id)
	{
		return value;
	}	//	decrypt

	/**
	 *	Encryption.
	 * 	The methods must recognize clear text values
	 *  @param value clear value
	 *  @param ad_client_id
	 *  @return encrypted String
	 */
	public Timestamp encrypt (Timestamp value,int ad_client_id)
	{
		return value;
	}	//	encrypt

	/**
	 *	Decryption.
	 * 	The methods must recognize clear text values
	 *  @param value encrypted value
	 *  @return decrypted String
	 */
	public Timestamp decrypt (Timestamp value,int ad_client_id)
	{
		return value;
	}	//	decrypt
	
	
	/**
	 *  Convert String to Digest.
	 *  JavaScript version see - http://pajhome.org.uk/crypt/md5/index.html
	 *
	 *  @param value message
	 *  @return HexString of message (length = 32 characters)
	 */
	public String getDigest (String value)
	{
		if (m_md == null)
		{
			try
			{
				m_md = MessageDigest.getInstance("MD5");
			//	m_md = MessageDigest.getInstance("SHA-1");
			}
			catch (NoSuchAlgorithmException nsae)
			{
				nsae.printStackTrace();
			}
		}
        //	Convert String to array of bytes
		byte[] input = value.getBytes();
		byte[] output = null;
		//	Reset MessageDigest object
		if (m_md != null) {
			m_md.reset();		
			//	feed this array of bytes to the MessageDigest object
			m_md.update(input);
			//	 Get the resulting bytes after the encryption process
			output = m_md.digest();
			m_md.reset();
			//
		}
		return convertToHexString(output);
	}	//	getDigest


	/**
	 * 	Checks, if value is a valid digest
	 *  @param value digest string
	 *  @return true if valid digest
	 */
	public boolean isDigest (String value)
	{
		if (value == null || value.length() != 32)
			return false;
		//	needs to be a hex string, so try to convert it
		return (convertHexString(value) != null);
	}	//	isDigest

	/**
	 *  Convert String and salt to SHA-512 hash with iterations
	 *  https://www.owasp.org/index.php/Hashing_Java
	 *
	 *  @param value message
	 *  @return HexString of message (length = 128 characters)
	 * @throws NoSuchAlgorithmException 
	 * @throws UnsupportedEncodingException 
	 */
	public String getSHA512Hash (int iterations, String value, byte[] salt) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		MessageDigest digest = MessageDigest.getInstance("SHA-512");
		digest.reset();
		digest.update(salt);
		byte[] input = digest.digest(value.getBytes("UTF-8"));
		for (int i = 0; i < iterations; i++) {
			digest.reset();
			input = digest.digest(input);
		}
		digest.reset();
		//
		return convertToHexString(input);
	}	//	getSHA512Hash
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("Secure[");
		sb.append(m_keyStore.getAlgorithm())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 
	 * @return keystore
	 */
	public IKeyStore getKeyStore(){
		IKeyStore keyStore = Core.getKeyStore();
		if(keyStore==null)
			keyStore = new DefaultKeyStore();
		
		return keyStore;
	}
}   //  Secure
