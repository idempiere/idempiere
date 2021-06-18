/***********************************************************************
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
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/

package org.compiere.model;

import java.util.Properties;

public interface IMFAMechanism {

	/**
	 * Registration mechanism for the method
	 * Here the registration method executes the actions expected for this method, like sending an email, or an SMS, or nothing
	 * and creates the registration record
	 * @param ctx
	 * @param method
	 * @param prm         optional, for example the email
	 * @param trxName
	 * @return Object[] - first object is the String with the instructions to follow
	 *                    second object is the registration generated
	 *                    third and posterior objects are optional additional information for the method
	 *                    like QRCode image for example, or html img object, or URL, or File
	 */
	Object[] register(Properties ctx, MMFAMethod method, String prm, String trxName);

	/**
	 * Complete/Validate a previous registration
	 * Here it must check for validity of the mechanism, mark the record as valid or throw exception when not
	 * @param ctx
	 * @param reg                The registration object
	 * @param code               The code to be validated
	 * @param name               Optional - a name to assign the registration
	 * @param preferred 
	 * @param trxName
	 * @return msg               A message indicating success, errors throw exception
	 */
	String complete(Properties ctx, MMFARegistration reg, String code, String name, boolean preferred, String trxName);

	/**
	 * Generate a validation code (when needed depending on the method)
	 * @param reg
	 * @return
	 */
	String generateValidationCode(MMFARegistration reg);

	/**
	 * Validate a code
	 * @param reg
	 * @param code
	 * @param setPreferred
	 * @return message on error, null when OK
	 */
	String validateCode(MMFARegistration reg, String code, boolean setPreferred);

}
