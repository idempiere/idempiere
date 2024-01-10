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
 **********************************************************************/
package org.idempiere.fa.util;

import java.text.SimpleDateFormat;
import java.util.Properties;

import org.compiere.model.MClient;
import org.compiere.util.DisplayType;
import org.compiere.util.Language;

/**
 * Provide static utility methods
 * @author Teo Sarca, www.arhipac.ro
 *
 */
public final class Util
{
	private Util()
	{
		// nothing
	}
	
	/**
	 * Get date format for client
	 * @param ctx
	 * @return DateFormat for current AD_Client's language 
	 */
	public static SimpleDateFormat getClientDateFormat(Properties ctx)
	{
		String lang = MClient.get(ctx).getAD_Language();
		return DisplayType.getDateFormat(Language.getLanguage(lang));
	}
	
	/**
	 * Check if strings are equal.<br/>
	 * We consider 2 strings equal if they both are null or they both are equal.
	 * @param s1
	 * @param s2
	 * @return true if string are equal
	 */
	public static boolean equals(String s1, String s2)
	{
		return (s1 == null && s2 == null)
			|| (s1 != null && s2 != null && s1.equals(s2));
	}
}
