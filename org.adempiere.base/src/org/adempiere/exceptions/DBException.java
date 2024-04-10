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
package org.adempiere.exceptions;

import java.sql.SQLException;

import org.compiere.model.MColumn;
import org.compiere.model.MMessage;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.CLogMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * This RuntimeException is used to pass SQLException up the chain of calling
 * methods to determine what to do where needed.
 *
 * @author Vincent Harcq
 * @version $Id: DBException.java,v 1.2 2006/07/30 00:54:35 jjanke Exp $
 *
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * @author Armen Rizal, GOODWILL CONSULTING
 * 		FR [2789943] Better DBException handling for PostgreSQL
 * 		https://sourceforge.net/p/adempiere/feature-requests/719/
 */
public class DBException extends AdempiereException
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1961265420169932726L;

	public static final String DATABASE_OPERATION_TIMEOUT_MSG = "DatabaseOperationTimeout";
	public static final String DELETE_ERROR_DEPENDENT_MSG = "DeleteErrorDependent";
	public static final String DELETE_ERROR_DEPENDENT_MSG_WITH_INFO = "DeleteErrorDependentInfo";
	public static final String SAVE_ERROR_NOT_UNIQUE_MSG = "SaveErrorNotUnique";
	private String m_sql = null;

	/**
	 * Create a new DBException based on a SQLException
	 * @param e Specify the Exception cause
	 */
	public DBException(Exception e)
	{
		super(e);
		if (CLogMgt.isLevelFinest())
		{
			e.printStackTrace();
		}
	}

	/**
	 * Create a new DBException based on a SQLException and SQL Query
	 * @param e exception
	 * @param sql sql query
	 */
	public DBException(SQLException e, String sql)
	{
		this(e);
		m_sql = sql;
	}

	/**
	 * Create a new DBException
	 * @param msg Message
	 */
	public DBException(String msg)
	{
		super(msg);
	}

	/**
	 * Create a new DBException
	 * @param msg Message
	 * @param e Exception
	 */
	public DBException(String msg, Exception e)
	{
		super(msg, e);
	}
	
	/**
	 * @return SQL Query or null
	 */
	public String getSQL()
	{
		return m_sql;
	}

	/**
	 * @return Wrapped SQLException or null
	 */
	public SQLException getSQLException() {
		Throwable cause = getCause();
		if (cause instanceof SQLException)
			return (SQLException)cause;
		return null;
	}

	/**
	 * @see java.sql.SQLException#getErrorCode()
	 */
    public int getErrorCode() {
    	SQLException e = getSQLException();
    	return (e != null ? e.getErrorCode() : -1);
    }

    /**
     * @see java.sql.SQLException#getNextException()
     */
    public SQLException getNextException() {
    	SQLException e = getSQLException();
    	return (e != null ? e.getNextException() : null);
    }

    /**
     * @see java.sql.SQLException#getSQLState()
     */
    public String getSQLState() {
    	SQLException e = getSQLException();
    	return (e != null ? e.getSQLState() : null);
    }

    /**
     * @param e
     * @param errorCode
     * @return true if e is SQL exception and errorCode is the error code of SQL exception e.
     */
    private static final boolean isErrorCode(Exception e, int errorCode) {
    	if (e == null) {
    		return false;
    	}
    	else if (e instanceof SQLException) {
    		return ((SQLException)e).getErrorCode() == errorCode
    			|| e.getMessage().contains("ORA-"+String.format("%05d", errorCode)+":");
    	}
    	else if (e instanceof DBException) {
    		SQLException sqlEx = ((DBException)e).getSQLException();
    		if (sqlEx != null)
    			return sqlEx.getErrorCode() == errorCode;
    		else
    			return false;
    	}
    	return false;
    }

    /**
     * @param e
     * @param SQLState
     * @return true if e is SQL exception and SQLState is the SQL state of SQL exception e
     */
    private static final boolean isSQLState(Exception e, String SQLState) {
    	if (e == null) {
    		return false;
    	}
    	else if (e instanceof SQLException) {
    		return ((SQLException)e).getSQLState().equals(SQLState);
    	}
    	else if (e instanceof DBException) {
    		SQLException sqlEx = ((DBException)e).getSQLException();
    		if (sqlEx != null)
    			return sqlEx.getSQLState().equals(SQLState);
    		else
    			return false;
    	}
    	return false;
    }

    /**
     * Check if Unique Constraint Exception (aka ORA-00001)
     * @param e exception
     * @return true if e is unique constraint exception
     */
    public static boolean isUniqueContraintError(Exception e) {
    	if (DB.isPostgreSQL())
    		return isSQLState(e, "23505");
    	//
    	return isErrorCode(e, 1);
    }

    /**
     * Check if "child record found" exception (aka ORA-02292)
     * @param e exception
     * @return true if e is child record found exception (typically for delete)
     */
    public static boolean isChildRecordFoundError(Exception e) {
    	if (DB.isPostgreSQL())
    		return isSQLState(e, "23503");
    	return isErrorCode(e, 2292);
    }

    /**
     * Check if "invalid identifier" exception (aka ORA-00904)
     * @param e exception
     * @return true if e is invalid identifier exception
     */
    public static boolean isInvalidIdentifierError(Exception e) {
    	if (DB.isPostgreSQL())
    		return isSQLState(e, "42P01");
    	return isErrorCode(e, 904);
    }

    /**
     * Check if "invalid username/password" exception (aka ORA-01017).<br/>
     * Only implemented for Oracle.
     * @param e exception
     * @return true if e is invalid user/password exception
     */
    public static boolean isInvalidUserPassError(Exception e) {
    	return isErrorCode(e, 1017);
    }

    /**
     * Check if "time out" exception (aka ORA-01013)
     * @param e
     * @return true if e is time out exception
     */
    public static boolean isTimeout(Exception e) {
    	SQLException se = null;
    	if (e instanceof SQLException) {
    		se = (SQLException) e;
    	} else if (e.getCause() != null && e.getCause() instanceof SQLException) {
    		se = (SQLException) e.getCause();
    	}
    	
    	if (se != null) {
    		return DB.getDatabase().isQueryTimeout(se);
    	} else {
    		return false;
    	}
    }

    /**
     * Check if value too large for column exception (aka ORA-12899)
     * @param e exception
     * @return true if e is value too large for column exception
     */
    public static boolean isValueTooLarge(Exception e) {
    	if (DB.isPostgreSQL())
    		return isSQLState(e, "22001");
    	//
    	return isErrorCode(e, 12899);
    }

    /**
     * @param e
     * @return default AD message for exception or null
     */
    public static String getDefaultDBExceptionMessage(Exception e) {
    	if (isUniqueContraintError(e)) {
    		return SAVE_ERROR_NOT_UNIQUE_MSG;
    	} else if (isChildRecordFoundError(e)) {
			// get constraint name from error message
			String constraint = DB.getDatabase().getForeignKeyConstraint(e);
			if (!Util.isEmpty(constraint)) {
				// find the column with the constraint
				MColumn fColumn = new Query(Env.getCtx(), MColumn.Table_Name, " UPPER(FKConstraintName) = UPPER(?) ", null)
								.setParameters(constraint)
								.first();
				if (fColumn != null) {
					// get the dedicated message
					int msgID = fColumn.getFKConstraintMsg_ID();
					if (msgID > 0) {
						MMessage msgObj = MMessage.get(Env.getCtx(), msgID);
						return msgObj.getValue();
					} else {
						MTable fTable = MTable.get(fColumn.getAD_Table_ID());
						String msg = Msg.getMsg(Env.getCtx(), DELETE_ERROR_DEPENDENT_MSG_WITH_INFO,
								new Object[] {fTable.get_Translation(MTable.COLUMNNAME_Name), fColumn.get_Translation(MColumn.COLUMNNAME_Name)});
						return msg;
					}
				}
			}
    		return DELETE_ERROR_DEPENDENT_MSG;
    	} else if (isTimeout(e)) {
    		return DATABASE_OPERATION_TIMEOUT_MSG;
    	} else {
    		return null;
    	}
    }

}	//	DBException
