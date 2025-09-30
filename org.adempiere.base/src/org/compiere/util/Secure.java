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
import java.nio.charset.StandardCharsets;
import java.security.AlgorithmParameters;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.sql.Timestamp;
import java.util.HexFormat;
import java.util.logging.Level;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;

import org.adempiere.base.Core;
import org.adempiere.base.IKeyStore;

/**
 * Default implementation of {@link SecureInterface} for encryption and decryption.
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
	/**
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

	/**
	 *  Convert Byte Array to Hex String
	 *  @param bytes bytes
	 *  @return HexString
	 */
	public static String convertToHexString (byte[] bytes)
	{
		return HexFormat.of().formatHex(bytes);
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
		try
		{
			return HexFormat.of().parseHex(hexString);
		}
		catch (Exception e)
		{
			if (log.isLoggable(Level.FINEST)) log.finest(hexString + " - " + e.getLocalizedMessage());
		}
		return null;
	}   //  convertToHexString

	/**
	 * 	iDempiere Security
	 */
	public Secure()
	{
		createKeyStore();
	}	//	Secure
	
	/** Message Digest				*/
	private MessageDigest	m_md = null;
	
	private MessageDigest	m_sha256 = null;

	private IKeyStore m_keyStore = null;
	/**	Logger						*/
	private static CLogger	log	= CLogger.getCLogger (Secure.class.getName());

	/**
	 * 	Create Key Store if not yet done
	 */
	private synchronized void createKeyStore()
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
			createKeyStore();

		// Encrypt
		try {
			Cipher cipher = getCipherInstance();

			cipher.init(Cipher.ENCRYPT_MODE, m_keyStore.getKey(AD_Client_ID));
			byte[] encBytes = cipher.doFinal(clearText.getBytes("UTF8"));

			String encString = convertToHexString(encBytes);
			// globalqss - [ 1577737 ] Security Breach - show database password
			// log.log (Level.ALL, value + " => " + encString);
			return encString;
		} catch (Exception ex) {
			log.log(Level.SEVERE, "Problem encrypting string", ex);
		}

		// Fallback
		return CLEARVALUE_START + value + CLEARVALUE_END;
	}	//	encrypt

	/**
	 * Get Cipher Instance
	 * @return cipher
	 * @throws NoSuchAlgorithmException
	 * @throws NoSuchPaddingException
	 * @throws NoSuchProviderException
	 */
	protected Cipher getCipherInstance() throws NoSuchAlgorithmException, NoSuchPaddingException, NoSuchProviderException {
		String provider = getCipherProvider();
		Cipher cipher = Util.isEmpty(provider, true) 
							? Cipher.getInstance(m_keyStore.getAlgorithm())
							: Cipher.getInstance(m_keyStore.getAlgorithm(), provider);
		return cipher;
	}

	/**
	 * Get Cipher Provider 
	 * @return cipher provider or null if default provider should be used
	 */
	protected String getCipherProvider() {
		return m_keyStore.getProvider();
	}
	
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
			createKeyStore();

		//	Encrypt
		if (value != null && value.length() > 0)
		{
			try
			{
				Cipher cipher = getCipherInstance();
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
				log.log(Level.SEVERE, "Failed decrypting", ex);
			}
		}
		return null;
	}	//	decrypt

	/**
	 *	Not implemented, just return value as it is
	 *  @param value clear value
	 *  @param ad_client_id
	 *  @return integer value
	 */
	public Integer encrypt (Integer value,int ad_client_id)
	{
		return value;
	}	//	encrypt

	/**
	 *	Not implemented, just return value as it is
	 *  @param value encrypted value
	 *  @return integer value
	 */
	public Integer decrypt (Integer value,int ad_client_id)
	{
		return value;
	}	//	decrypt
	
	/**
	 *	Not implemented, just return value as it is
	 *  @param value clear value
	 *  @param ad_client_id
	 *  @return BigDecimal value
	 */
	public BigDecimal encrypt (BigDecimal value,int ad_client_id)
	{
		return value;
	}	//	encrypt

	/**
	 *	Not implemented, just return value as it is
	 *  @param value encrypted value
	 *  @return Big decimal value
	 */
	public BigDecimal decrypt (BigDecimal value,int ad_client_id)
	{
		return value;
	}	//	decrypt

	/**
	 *	Not implemented, just return value as it is
	 *  @param value clear value
	 *  @param ad_client_id
	 *  @return Timestamp value
	 */
	public Timestamp encrypt (Timestamp value,int ad_client_id)
	{
		return value;
	}	//	encrypt

	/**
	 *	Not implemented, just return value as it is 	
	 *  @param value encrypted value
	 *  @return Timestamp value
	 */
	public Timestamp decrypt (Timestamp value,int ad_client_id)
	{
		return value;
	}	//	decrypt
		
	/**
	 *  Perform MD5 Digest of value
	 *  JavaScript version see - http://pajhome.org.uk/crypt/md5/index.html
	 *
	 *  @param value text to digest
	 *  @return HexString of digested message (length = 32 characters)
	 */
	public String getDigest (String value)
	{
		if (m_md == null)
		{
			try
			{
				m_md = MessageDigest.getInstance("MD5");
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

	
	@Override
	public String getSHA256Digest(String value) {
		if (m_sha256 == null)
		{
			try
			{
				m_sha256 = MessageDigest.getInstance("SHA-256");
			}
			catch (NoSuchAlgorithmException nsae)
			{
				nsae.printStackTrace();
			}
		}
        //	Convert String to array of bytes
		byte[] input = value.getBytes(StandardCharsets.UTF_8);
		byte[] output = null;
		//	Reset MessageDigest object
		if (m_sha256 != null) {
			m_sha256.reset();		
			//	feed this array of bytes to the MessageDigest object
			m_sha256.update(input);
			//	 Get the resulting bytes after the encryption process
			output = m_sha256.digest();
			m_sha256.reset();
			//
		}
		return convertToHexString(output);
	}

	@Override
	public boolean isSHA256Digest(String value) {
		if (value == null || value.length() != 64)
			return false;
		//	needs to be a hex string, so try to convert it
		return (convertHexString(value) != null);
	}

	/**
	 *  Convert String and salt to SHA-512 hash with iterations
	 *  https://www.owasp.org/index.php/Hashing_Java
	 *
	 *  @param value message
	 *  @return HexString of message (length = 128 characters)
	 *  @throws NoSuchAlgorithmException 
	 *  @throws UnsupportedEncodingException 
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
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("Secure[");
		sb.append(m_keyStore.getAlgorithm())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * @return keystore
	 */
	public IKeyStore getKeyStore(){
		IKeyStore keyStore = Core.getKeyStore();
		if(keyStore==null)
			keyStore = new DefaultKeyStore();
		
		return keyStore;
	}
}   //  Secure
