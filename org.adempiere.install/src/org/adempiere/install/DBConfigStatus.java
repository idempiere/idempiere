/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.install;

/**
 *
 * @author hengsin
 *
 */
public class DBConfigStatus {

	public final static String DATABASE_SERVER = "DATABASE_SERVER";
	public final static String DATABASE_SYSTEM_PASSWORD = "DATABASE_SYSTEM_PASSWORD";
	public final static String DATABASE_USER = "DATABASE_USER";
	public final static String DATABASE_SQL_TEST = "DATABASE_SQL_TEST";

	private String statusType;
	private String resourseString;
	private boolean pass;
	private boolean critical;
	private String errorMessage;

	/**
	 * @param statusType
	 * @param resourseString
	 * @param pass
	 * @param critical
	 * @param errorMessage
	 */
	public DBConfigStatus(String statusType, String resourseString, boolean pass,
			boolean critical, String errorMessage) {
		super();
		this.statusType = statusType;
		this.resourseString = resourseString;
		this.pass = pass;
		this.critical = critical;
		this.errorMessage = errorMessage;
	}

	/**
	 * @return the statusType
	 */
	public String getStatusType() {
		return statusType;
	}

	/**
	 * @param statusType the statusType to set
	 */
	public void setStatusType(String statusType) {
		this.statusType = statusType;
	}

	/**
	 * @return the resourseString
	 */
	public String getResourseString() {
		return resourseString;
	}

	/**
	 * @param resourseString the resourseString to set
	 */
	public void setResourseString(String resourseString) {
		this.resourseString = resourseString;
	}

	/**
	 * @return the pass
	 */
	public boolean isPass() {
		return pass;
	}

	/**
	 * @param pass the pass to set
	 */
	public void setPass(boolean pass) {
		this.pass = pass;
	}

	/**
	 * @return the critical
	 */
	public boolean isCritical() {
		return critical;
	}

	/**
	 * @param critical the critical to set
	 */
	public void setCritical(boolean critical) {
		this.critical = critical;
	}

	/**
	 * @return the errorMessage
	 */
	public String getErrorMessage() {
		return errorMessage;
	}

	/**
	 * @param errorMessage the errorMessage to set
	 */
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}


}
