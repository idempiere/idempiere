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
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;

/**
 * 	iDempiere interface for enryption, decryption.<br/>
 * 	To enable your own class, you need to set the property ADEMPIERE_SECURE 
 * 	when starting the client or server.<br/>
 *  The setting for the default class would be:<br/>
 *  -DADEMPIERE_SECURE=org.compiere.util.Secure
 *	
 *  @author Jorg Janke
 *  @version $Id: SecureInterface.java,v 1.2 2006/07/30 00:52:23 jjanke Exp $
 */
public interface SecureInterface
{
	/** Class Name implementing SecureInterface	*/
	public static final String	ADEMPIERE_SECURE = "ADEMPIERE_SECURE";
	/** Default Class Name implementing SecureInterface	*/
	public static final String	ADEMPIERE_SECURE_DEFAULT = "org.compiere.util.Secure";
	
	/** Clear Text Indicator xyz	*/
	public static final String		CLEARVALUE_START = "xyz";
	/** Clear Text Indicator		*/
	public static final String		CLEARVALUE_END = "";
	/** Encrypted Text Indiactor ~	*/
	public static final String		ENCRYPTEDVALUE_START = "~";
	/** Encrypted Text Indiactor ~	*/
	public static final String		ENCRYPTEDVALUE_END = "~";
	
	/**
	 *	Encryption.
	 *  @param value clear value
	 *  @param AD_Client_ID
	 *  @return encrypted String
	 */
	public String encrypt (String value,int AD_Client_ID);

	/**
	 *	Decryption.
	 *  @param value encrypted value
	 *  @return decrypted String
	 */
	public String decrypt (String value,int AD_Client_ID);

	/**
	 *	Encryption.
	 *  @param value clear value
	 *  @param AD_Client_ID
	 *  @return encrypted integer value
	 */
	public Integer encrypt (Integer value,int AD_Client_ID);

	/**
	 *	Decryption.
	 *  @param value encrypted value
	 *  @param AD_Client_ID
	 *  @return decrypted integer value
	 */
	public Integer decrypt (Integer value,int AD_Client_ID);
	
	/**
	 *	Encryption.
	 *  @param value clear value
	 *  @param AD_Client_ID
	 *  @return encrypted BigDecimal value
	 */
	public BigDecimal encrypt (BigDecimal value,int AD_Client_ID);

	/**
	 *	Decryption.
	 *  @param value encrypted value
	 *  @param AD_Client_ID
	 *  @return decrypted BigDecimal value
	 */
	public BigDecimal decrypt (BigDecimal value,int AD_Client_ID);

	/**
	 *	Encryption.
	 *  @param value clear value
	 *  @param AD_Client_ID
	 *  @return encrypted Timestamp value
	 */
	public Timestamp encrypt (Timestamp value,int AD_Client_ID);

	/**
	 *	Decryption.
	 *  @param value encrypted value
	 *  @param AD_Client_ID
	 *  @return decrypted Timestamp value
	 */
	public Timestamp decrypt (Timestamp value,int AD_Client_ID);
		
	/**
	 *  Digest string value.<br/>
	 *  JavaScript version see - http://pajhome.org.uk/crypt/md5/index.html
	 *
	 *  @param value message
	 *  @return HexString of digested message (length = 32 characters)
	 */
	public String getDigest (String value);

	/**
	 * 	Checks, if value is a valid digest
	 *  @param value digest string
	 *  @return true if valid digest
	 */
	public boolean isDigest (String value);
	
	/**
	 *  Convert String and salt to SHA-512 hash with iterations<br/>
	 *  https://www.owasp.org/index.php/Hashing_Java
	 *
	 *  @param value message
	 *  @return HexString of message (length = 128 characters)
	 *  @throws NoSuchAlgorithmException 
	 *  @throws UnsupportedEncodingException 
	 */
	public String getSHA512Hash (int iterations, String value, byte[] salt) throws NoSuchAlgorithmException, UnsupportedEncodingException;
	
}	//	SecureInterface
