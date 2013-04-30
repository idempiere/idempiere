/******************************************************************************
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
package org.idempiere.adinterface;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.model.MRole;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.ValueNamePair;
import org.idempiere.adInterface.x10.LookupValue;
import org.idempiere.adInterface.x10.LookupValues;

/*
 * ADEMPIERE/COMPIERE
 * 
 * zamiana:
 *   GridField na GridField
 *   GridField
 */
public class ADLookup {
	
	protected static CLogger	log = CLogger.getCLogger(ADLookup.class);	
	
	/**
	 * @param lvs
	 * @param lookup
	 * @param isMandatory
	 * @param isReadOnly
	 * @param isShortList
	 */
	public static void fillLookupValues( LookupValues lvs, Lookup lookup, boolean isMandatory, boolean isReadOnly, boolean isShortList) // IDEMPIERE 90
    {		
    	    	
		if(lookup.getSize() == 0)
			lookup.refresh();
		Object[] list = lookup.getData(isMandatory, true, !isReadOnly, false, isShortList).toArray();	 // IDEMPIERE 90									
		
		for (int i=0; i<list.length; i++)
		{
			boolean isNumber = list[0] instanceof KeyNamePair;
			
			LookupValue lv = lvs.addNewLv();
			
			if (isNumber)
			{
				KeyNamePair p = (KeyNamePair)list[i];												
				lv.setKey( Integer.toString(p.getKey()) );
				lv.setVal( p.getName() );
				
			} else
			{
				ValueNamePair p = (ValueNamePair)list[i];
				lv.setKey( p.getValue() );
				lv.setVal( p.getName() );
			}									
		}    	
    }
	
	/**
	 * 	Generate Access SQL for Search.
	 * 	The SQL returns the ID of the value entered
	 * 	Also sets m_tableName and m_keyColumnName
	 *	@param text uppercase text for LIKE comparison
	 *	@return sql or ""
	 *  Example
	 *	SELECT C_Payment_ID FROM C_Payment WHERE UPPER(DocumentNo) LIKE x OR ...
	 */
	public static String getDirectAccessSQL (Lookup lookup, String text)
	{
		String m_columnName = lookup.getColumnName();

		String m_tableName = null;
		String m_keyColumnName = null;
		StringBuffer sql = new StringBuffer();
		if (m_columnName.indexOf(".") > 0) {
			m_tableName = m_columnName.substring(0, m_columnName.indexOf("."));
			m_keyColumnName = m_columnName.substring(m_columnName.indexOf(".")+1);
		} else {
			m_tableName = m_columnName.substring(0, m_columnName.length()-3);
			m_keyColumnName = m_columnName;
		}

		if (isUUID(text))
		{
			sql.append("SELECT ").append(m_keyColumnName).append(" FROM ").append(m_tableName)
			   .append(" WHERE ").append(m_tableName).append("_UU=").append(DB.TO_STRING(text.toLowerCase()));
		}
		else if (m_columnName.equals("M_Product_ID"))
		{
			sql.append("SELECT M_Product_ID FROM M_Product WHERE (UPPER(Value) LIKE ")
				.append(DB.TO_STRING(text))
				.append(" OR UPPER(Name) LIKE ").append(DB.TO_STRING(text))
				.append(" OR UPC LIKE ").append(DB.TO_STRING(text)).append(")");
		}
		else if (m_columnName.equals("C_BPartner_ID"))
		{
			sql.append("SELECT C_BPartner_ID FROM C_BPartner WHERE (UPPER(Value) LIKE ")
				.append(DB.TO_STRING(text))
				.append(" OR UPPER(Name) LIKE ").append(DB.TO_STRING(text)).append(")");
		}
		else if (m_columnName.equals("C_Order_ID"))
		{
			sql.append("SELECT C_Order_ID FROM C_Order WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("C_Invoice_ID"))
		{
			sql.append("SELECT C_Invoice_ID FROM C_Invoice WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("M_InOut_ID"))
		{
			sql.append("SELECT M_InOut_ID FROM M_InOut WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("C_Payment_ID"))
		{
			sql.append("SELECT C_Payment_ID FROM C_Payment WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("GL_JournalBatch_ID"))
		{
			sql.append("SELECT GL_JournalBatch_ID FROM GL_JournalBatch WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("SalesRep_ID"))
		{
			sql.append("SELECT AD_User_ID FROM AD_User WHERE UPPER(Name) LIKE ")
				.append(DB.TO_STRING(text));

			m_tableName = "AD_User";
			m_keyColumnName = "AD_User_ID";
		}

		//	Predefined

		if (sql.length() > 0)
		{
			String wc = getWhereClause(lookup);

			if (wc != null && wc.length() > 0)
				sql.append(" AND ").append(wc);

			sql.append(" AND IsActive='Y'");
			//	***

			if (log.isLoggable(Level.FINEST))
				log.finest(m_columnName + " (predefined) " + sql.toString());

			return MRole.getDefault().addAccessSQL(sql.toString(),
				m_tableName, MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		}

		//	Check if it is a Table Reference

		if (lookup != null && lookup instanceof MLookup)
		{
			int AD_Reference_ID = ((MLookup)lookup).getAD_Reference_Value_ID();

			if (AD_Reference_ID != 0)
			{
				boolean isValueDisplayed = false;
				String query = "SELECT kc.ColumnName, dc.ColumnName, t.TableName, rt.IsValueDisplayed "
					+ "FROM AD_Ref_Table rt"
					+ " INNER JOIN AD_Column kc ON (rt.AD_Key=kc.AD_Column_ID)"
					+ " INNER JOIN AD_Column dc ON (rt.AD_Display=dc.AD_Column_ID)"
					+ " INNER JOIN AD_Table t ON (rt.AD_Table_ID=t.AD_Table_ID) "
					+ "WHERE rt.AD_Reference_ID=?";

				String displayColumnName = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try
				{
					pstmt = DB.prepareStatement(query, null);
					pstmt.setInt(1, AD_Reference_ID);
					rs = pstmt.executeQuery();

					if (rs.next())
					{
						m_keyColumnName = rs.getString(1);
						displayColumnName = rs.getString(2);
						m_tableName = rs.getString(3);
						String t = rs.getString(4);
						isValueDisplayed = "Y".equalsIgnoreCase(t);
					}
				}
				catch (Exception e)
				{
					log.log(Level.SEVERE, query, e);
				}
				finally
				{
					DB.close(rs, pstmt);
				}


				if (displayColumnName != null)
				{
					sql = new StringBuffer();
					sql.append("SELECT ").append(m_keyColumnName)
						.append(" FROM ").append(m_tableName)
						.append(" WHERE (UPPER(").append(displayColumnName)
						.append(") LIKE ").append(DB.TO_STRING(text));
					if (isValueDisplayed)
					{
						sql.append(" OR UPPER(").append("Value")
						   .append(") LIKE ").append(DB.TO_STRING(text));
					}
					sql.append(")");
					sql.append(" AND IsActive='Y'");

					String wc = getWhereClause(lookup);

					if (wc != null && wc.length() > 0)
						sql.append(" AND ").append(wc);

					//	***

					if (log.isLoggable(Level.FINEST))
						log.finest(m_columnName + " (Table) " + sql.toString());

					return MRole.getDefault().addAccessSQL(sql.toString(),
								m_tableName, MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
				}
			} // Table Reference
		} // MLookup

		/** Check Well Known Columns of Table - assumes TableDir	**/

		String query = "SELECT t.TableName, c.ColumnName "
			+ "FROM AD_Column c "
			+ " INNER JOIN AD_Table t ON (c.AD_Table_ID=t.AD_Table_ID AND t.IsView='N') "
			+ "WHERE (c.ColumnName IN ('DocumentNo', 'Value', 'Name') OR c.IsIdentifier='Y')"
			+ " AND c.AD_Reference_ID IN (10,14)"
			+ " AND EXISTS (SELECT * FROM AD_Column cc WHERE cc.AD_Table_ID=t.AD_Table_ID"
				+ " AND cc.IsKey='Y' AND cc.ColumnName=?)";

		sql = new StringBuffer();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(query, null);
			pstmt.setString(1, m_keyColumnName);
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				if (sql.length() != 0)
					sql.append(" OR ");

				m_tableName = rs.getString(1);
				sql.append("UPPER(").append(rs.getString(2)).append(") LIKE ").append(DB.TO_STRING(text));
			}
		}
		catch (SQLException ex)
		{
			log.log(Level.SEVERE, query, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		if (sql.length() == 0)
		{
			log.log(Level.SEVERE, m_columnName + " (TableDir) - no standard/identifier columns");
			return "";
		}
		//
		StringBuffer retValue = new StringBuffer ("SELECT ")
			.append(m_columnName).append(" FROM ").append(m_tableName)
			.append(" WHERE ").append(sql)
			.append(" AND IsActive='Y'");

		String wc = getWhereClause(lookup);

		if (wc != null && wc.length() > 0)
			retValue.append(" AND ").append(wc);
		//	***
		if (log.isLoggable(Level.FINEST))
			log.finest(m_columnName + " (TableDir) " + sql.toString());
		return MRole.getDefault().addAccessSQL(retValue.toString(),
					m_tableName, MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
	}
	
	private static String getWhereClause(Lookup lookup)
	{
		String whereClause = "";

		if (lookup == null)
			return "";

		if (lookup.getZoomQuery() != null)
			whereClause = lookup.getZoomQuery().getWhereClause();

		String validation = lookup.getValidation();

		if (validation == null)
			validation = "";

		if (whereClause.length() == 0)
			whereClause = validation;
		else if (validation.length() > 0)
			whereClause += " AND " + validation;

		if (whereClause.indexOf('@') != -1)
		{
			String validated = Env.parseContext(Env.getCtx(), lookup.getWindowNo(), whereClause, false);

			if (validated.length() == 0)
				log.severe(lookup.getColumnName() + " - Cannot Parse=" + whereClause);
			else
			{
				if (log.isLoggable(Level.FINE))
					log.fine(lookup.getColumnName() + " - Parsed: " + validated);
				return validated;
			}
		}
		return whereClause;
	}	//	getWhereClause

	private final static String UUID_REGEX="[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}";
	
	/**
	 * @param value
	 * @return true if value is a uuid identifier
	 */
	public static boolean isUUID(String value)
	{
		return value == null ? false : value.matches(UUID_REGEX);
	}
}
