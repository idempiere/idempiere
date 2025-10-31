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
import java.security.DrbgParameters;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.IServiceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.compiere.model.SystemProperties;
import org.osgi.framework.Constants;

/**
 *  Secure engine for encryption and decryption
 *	
 *  @author Jorg Janke
 *  @version $Id: SecureEngine.java,v 1.2 2006/07/30 00:52:23 jjanke Exp $
 */
public class SecureEngine
{
	public static final String DEFAULT_SECURE_RANDOM_ALGORITHM = "DRBG";
	/**
	 * 	Initialize SecureEngine with ADEPIERE_SECURE class
	 *	@param ctx ignore
	 */
	public static void init (Properties ctx)
	{
		if (s_engine == null)
		{
			String className = SystemProperties.getAdempiereSecure();
			s_engine = new SecureEngine(className);
		}
	}	//	init
	
	/**
	 * 	Initialize/Test Security
	 *	@param className class name
	 */
	public static void init (String className)
	{
		if (s_engine == null)
			s_engine = new SecureEngine(className);
		else if (className != null && !className.equals(getClassName()))
		{
			String msg = "Requested Security class = " + className
				+ " is not the same as the active class = " + getClassName()
				+ "\nMake sure to set the security class in the start script";
			log.severe(msg);
			System.err.println(msg);
			System.exit(10);
		}
	}	//	init

	/**
	 * 	Get Class Name
	 *	@return class name 
	 */
	public static String getClassName()
	{
		if (s_engine == null)
			return null;
		return s_engine.implementation.getClass().getName();
	}	//	getClassName
	
	/**
	 *  Convert String and salt to SHA-512 hash with iterations<br/>
	 *  https://www.owasp.org/index.php/Hashing_Java
	 *
	 *  @param iterations number of iterations
	 *  @param value message
	 *  @param salt salt
	 *  @return HexString of message (length = 128 characters)
	 *  @throws UnsupportedEncodingException 
	 *  @throws NoSuchAlgorithmException 
	 */
	public static String getSHA512Hash (int iterations, String value, byte[] salt) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		if (s_engine == null)
			init(System.getProperties());
		return s_engine.implementation.getSHA512Hash(iterations, value, salt);
	}	//	getDigest	

	/**
	 * Hash the password with the given salt and algorithm
	 * @param algorithm
	 * @param value
	 * @param salt
	 * @return HexString of hashed password
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchProviderException
	 * @throws InvalidKeySpecException
	 */
	public static String getPasswordHash(String algorithm, String value, byte[] salt) throws NoSuchAlgorithmException, 
		UnsupportedEncodingException, NoSuchProviderException, InvalidKeySpecException
	{
		if (s_engine == null)
			init(System.getProperties());
		return s_engine.implementation.getPasswordHash(value, salt, algorithm);
	}	//	getHash
	
	/**
	 * Check if the given password hash algorithm is supported
	 * @param hashAlgorithm
	 * @return true if supported, false otherwise
	 */
	public static boolean isSupportedPaswordHashAlgorithm(String hashAlgorithm) {
		if (s_engine == null)
			init(System.getProperties());
		return s_engine.implementation.isSupportedPaswordHashAlgorithm(hashAlgorithm);
	}
	
	/**
	 *  Perform MD5 Digest of value.<br/>
	 *  JavaScript version see - http://pajhome.org.uk/crypt/md5/index.html
	 *
	 *  @param value message
	 *  @return HexString of digested message (length = 32 characters)
	 */
	@Deprecated
	public static String getDigest (String value)
	{
		if (s_engine == null)
			init(System.getProperties());
		return s_engine.implementation.getDigest(value);
	}	//	getDigest
	
	/**
	 * Perform SHA-256 Digest of value.
	 * @param value
	 * @return HexString of digested message (length = 64 characters)
	 */
	public static String getSHA256Digest (String value)
	{
		if (s_engine == null)
			init(System.getProperties());
		return s_engine.implementation.getSHA256Digest(value);
	}	//	getSHA256Digest
	
	/**
	 *	Encryption.<br/>
	 * 	The methods must recognize clear text values
	 *  @param value clear value
	 *  @param AD_Client_ID
	 *  @return encrypted String
	 */
	public static String encrypt (String value,int AD_Client_ID)
	{
		if (value == null || value.length() == 0)
			return value;
		if (s_engine == null)
			init(System.getProperties());
		//
		boolean inQuotes = value.startsWith("'") && value.endsWith("'");
		if (inQuotes)
			value = value.substring(1, value.length()-1);
		//
		String retValue = s_engine.implementation.encrypt(value,AD_Client_ID);
		if (inQuotes)
			return "'" + retValue + "'";
		return retValue;
	}	//	encrypt
	
	/**
	 *	Decryption.<br/>
	 * 	The methods must recognize clear text values
	 *  @param value encrypted value
	 *  @param AD_Client_ID
	 *  @return decrypted String
	 */
	public static String decrypt (String value, int AD_Client_ID)
	{
		if (value == null)
			return null;
		if (s_engine == null)
			init(System.getProperties());
		boolean inQuotes = value.startsWith("'") && value.endsWith("'");
		if (inQuotes)
			value = value.substring(1, value.length()-1);
		String retValue = null;
		if (value.startsWith(SecureInterface.CLEARVALUE_START) && value.endsWith(SecureInterface.CLEARVALUE_END))
			retValue = value.substring(SecureInterface.CLEARVALUE_START.length(), value.length()-SecureInterface.CLEARVALUE_END.length());
		else
			retValue = s_engine.implementation.decrypt(value,AD_Client_ID);
		if (inQuotes)
			return "'" + retValue + "'";
		return retValue;
	}	//	decrypt
	
	/**
	 *	Encrypt value (only implemented for String).
	 *  @param value clear value
	 *  @param AD_Client_ID
	 *  @return encrypted String
	 */
	public static Object encrypt (Object value, int AD_Client_ID)
	{
		if (value instanceof String)
			return encrypt((String) value, AD_Client_ID);
		return value;
	}	//	encrypt

	/**
	 *	Decrypt value (only implemented for String)
	 *  @param value encrypted value
	 *  @return decrypted String
	 */
	public static Object decrypt (Object value, int AD_Client_ID)
	{
		if (value instanceof String)
			return decrypt((String) value, AD_Client_ID);
		return value;
	}	//	decrypt
	
	/**
	 * 	SecureEngine constructor
	 * 	@param className class name if null defaults to org.compiere.util.Secure 
	 */
	private SecureEngine (String className)
	{
		String realClass = className;
		if (realClass == null || realClass.length() == 0)
			realClass = SecureInterface.ADEMPIERE_SECURE_DEFAULT;
		
		//try OSGi first
		if (!SecureInterface.ADEMPIERE_SECURE_DEFAULT.equals(realClass)) 
		{
			ServiceQuery serviceQuery = new ServiceQuery();
			serviceQuery.put(Constants.OBJECTCLASS, className);
			IServiceHolder<SecureInterface> holder = Service.locator().locate(SecureInterface.class, serviceQuery);
			if (holder != null) 
			{
				implementation = holder.getService();
			}
		}
		
		Exception cause = null;
		if (implementation == null)
		{			
			//fallback to Class.forName
			try
			{
				Class<?> clazz = Class.forName(realClass);
				implementation = (SecureInterface)clazz.getDeclaredConstructor().newInstance();
			}
			catch (Exception e)
			{
				cause = e;
			}
		}
		
		if (implementation == null)
		{
			String msg = "Could not initialize: " + realClass + " - " + cause.toString()
				+ "\nCheck start script parameter ADEMPIERE_SECURE"; 
			log.severe(msg);
			System.err.println(msg);
			cause.printStackTrace();
			System.exit(10);
		}
		//	See if it works
		String testE = implementation.encrypt(TEST,0);
		String testC = implementation.decrypt(testE,0);
		if (!testC.equals(TEST))
			throw new IllegalStateException(realClass 
				+ ": " + TEST
				+ "->" + testE + "->" + testC);
		if (log.isLoggable(Level.CONFIG)) log.config (realClass + " initialized - " + implementation);
	}	//	SecureEngine

	/**
	 * Use salt in hex form and text hashed compare with plan text.<br/>
	 * If has exception in hash, log to server.
	 * @param hashedText
	 * @param hexSalt
	 * @param planText
	 * @return true if valid
	 */
	@Deprecated
	public static boolean isMatchHash (String hashedText, String hexSalt, String planText) {
		return isMatchHash(Secure.LEGACY_PASSWORD_HASH_ALGORITHM, hashedText, hexSalt, planText);
	}
	
	/**
	 * Use salt in hex form and text hashed compare with plan text.<br/>
	 * If has exception in hash, log to server.
	 * @param algorithm
	 * @param hashedText
	 * @param hexSalt
	 * @param plainText
	 * @return true if valid
	 */
	public static boolean isMatchHash (String algorithm, String hashedText, String hexSalt, String plainText){
		boolean valid=false;

		// always do calculation to prevent timing based attacks
		if ( hashedText == null )
			hashedText = "0000000000000000";
		if ( hexSalt == null )
			hexSalt = "0000000000000000";
		if (algorithm == null )
			algorithm = Secure.LEGACY_PASSWORD_HASH_ALGORITHM;

		try {
			valid= SecureEngine.getPasswordHash(algorithm, plainText, Secure.convertHexString(hexSalt)).equals(hashedText);
		} catch (NoSuchAlgorithmException ignored) {
			log.log(Level.WARNING, "Password hashing not supported by JVM");
		} catch (UnsupportedEncodingException ignored) {
			log.log(Level.WARNING, "Password hashing not supported by JVM");
		} catch (NoSuchProviderException e) {
			log.log(Level.WARNING, "Password hashing not supported by JVM");
		} catch (InvalidKeySpecException e) {
			log.log(Level.WARNING, "Password hashing not supported by JVM");
		}
				
	 	return valid;
	}
	
	/**
	 * Get a SecureRandom instance
	 * @return SecureRandom instance
	 * @throws NoSuchAlgorithmException
	 */
	public static SecureRandom getSecureRandom() throws NoSuchAlgorithmException {
		SecureRandom random = SecureRandom.getInstance(DEFAULT_SECURE_RANDOM_ALGORITHM,
			    DrbgParameters.instantiation(256, // security strength
			    DrbgParameters.Capability.PR_AND_RESEED, // prediction resistance
			    null));
		return random;
	}
	
	/** Test String					*/
	private static final String	TEST = "This is a 0123456789 .,; -= Test!";
	/** Secure Engine 				*/
	private volatile static SecureEngine	s_engine = null;	
	
	/** The real Engine				*/
	private	SecureInterface		implementation = null;
	/**	Logger						*/
	private static CLogger		log	= CLogger.getCLogger (SecureEngine.class.getName());	
			
}	//	SecureEngine
