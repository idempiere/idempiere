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
package org.compiere.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;

/**
 * Arhipac Runtime exception
 * @author Teo_Sarca, SC ARHIPAC SERVICE SRL
 *
 */
public class ArhRuntimeException
	extends AdempiereException
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -100343773302909791L;
	/**	Additional attributes */
	private HashMap<String,Object> m_info = new HashMap<String,Object>();
	
	/**
	 * Default Constructor (logger error will be used as message)
	 */
	public ArhRuntimeException() {
		super();
	}
	
	/**
	 * Constructor
	 * @param message error message or "" if you don't need a message
	 */
	public ArhRuntimeException(String message) {
		super(message);
	}
	
	/**
	 * Constructor
	 * @param ctx
	 * @param message
	 */
	public ArhRuntimeException(Properties ctx, String message) {
		this(message);
	}

	/**
	 * @param cause
	 */
	public ArhRuntimeException(Throwable cause) {
		super(cause);
	}

	/**
	 * @param message
	 * @param cause
	 */
	public ArhRuntimeException(String message, Throwable cause) {
		super(message, cause);
	}

	/* (non-Javadoc)
	 * @see java.lang.Throwable#getLocalizedMessage()
	 */
	@Override
	public String getLocalizedMessage() {
		StringBuilder sb = new StringBuilder();
		Properties ctx = Env.getCtx();
		// Message
		String msg = getMessage();
		if (msg != null && msg.length() > 0) {
			sb.append(Msg.parseTranslation(ctx, msg));
		}
		else {
			msg = null;
		}
		// Additional info:
		if (m_info.size() > 0) {
			Iterator<String> it = m_info.keySet().iterator();
			int cnt = 0;
			while(it.hasNext()) {
				String name = it.next();
				Object value = m_info.get(name);
				if (cnt == 0) {
					if (msg != null)
						sb.append(" (");
				}
				else {
					sb.append(", ");
				}
				sb.append(Msg.parseTranslation(ctx, name));
				String svalue = getStringValue(value);
				if (value != null && svalue.length() > 0)
					sb.append(" ").append(svalue);
				cnt++;
			}
			if (cnt > 0 && msg != null) {
				sb.append(")");
			}
		}
		//
		return sb.toString();
	}
	
	/**
	 *	Save error
	 */
	public void saveError(CLogger log) {
		log.saveError("Error", getLocalizedMessage());
	}

	/**
	 * Add additional info for exception
	 * @param name
	 * @param value
	 * @return
	 */
	public ArhRuntimeException addInfo(String name, boolean value) {
		return addInfo(name, Boolean.valueOf(value));
	}
	
	/**
	 * Add additional info for exception
	 * @param name
	 * @return
	 */
	public ArhRuntimeException addInfo(String name) {
		return addInfo(name, "");
	}
	
	/**
	 * Add additional info for exception
	 * @param name
	 * @param value
	 * @return
	 */
	public ArhRuntimeException addInfo(String name, Object value) {
		if (name == null)
			return this;
		m_info.put(name, value);
		return this;
	}
	
	/**
	 * Add field info for exception
	 * @param fieldName
	 * @param value
	 * @return
	 */
	public ArhRuntimeException addField(String fieldName, Object value) {
		addInfo("@" + fieldName + "@ =", value);
		return this;
	}
	
	/**
	 * Has additional info
	 * @return true if exception has additional info
	 */
	public boolean hasInfo() {
		return !m_info.isEmpty();
	}
	
	/**
	 * Translated string representation of the provided value
	 * @param value
	 * @return
	 */
	private String getStringValue(Object value) {
		String svalue = null;
		if (value == null) {
			svalue = "-";
		}
		else if (value instanceof Boolean) {
			svalue = Msg.getMsg(Env.getCtx(), ((Boolean)value).booleanValue() ? "Yes" : "No");
		}
		else if (value instanceof Timestamp) {
			SimpleDateFormat df = DisplayType.getDateFormat();
			svalue = df.format((Timestamp)value);
		}
		else {
			svalue = value.toString();
		}
		return svalue;
	}

	/* (non-Javadoc)
	 * @see java.lang.Throwable#toString()
	 */
	@Override
	public String toString() {
		return getLocalizedMessage();
	}
	
	
}
