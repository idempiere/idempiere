/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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
package org.compiere.model;

import static org.compiere.model.SystemIDs.REFERENCE_PAYMENTRULE;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.NamePair;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;

/**
 * Payment rules lookup
 * @author Elaine
 */
public class MPaymentLookup extends Lookup implements Serializable {
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 2876345457828980720L;

	/**	Context					*/
	private Properties 		m_ctx;
	/** IsSOTrx					*/
	private boolean			m_isSOTrx = false;
	/** Validation Code			*/
	private String			m_validationCode;
	
	/**
	 * @param ctx
	 * @param windowNo
	 * @param validationCode
	 */
	public MPaymentLookup(Properties ctx, int windowNo, String validationCode) {
		super(DisplayType.TableDir, windowNo);
		m_ctx = ctx;
		m_isSOTrx = "Y".equals(Env.getContext(Env.getCtx(), windowNo, "IsSOTrx"));
		m_validationCode = validationCode; 
	}

	@Override
	public String getDisplay(Object key) {
		if (key == null)
			return null;
		
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			if(value.getValue().equals(key.toString()))
				return value.getName();
		}
		
		StringBuilder msgreturn = new StringBuilder("<").append(key.toString()).append(">");
		return msgreturn.toString();
	}

	@Override
	public NamePair get(Object key) {
		if (key == null)
			return null;
		
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			if(value.getValue().equals(key.toString()))
				return value;
		}
		
		return null;
	}

	@Override
	public boolean containsKey(Object key) {
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			if(value.getValue().equals(key.toString()))
				return true;
		}
		return false;
	}

	/**
	 * Same as {@link #containsKey(Object)} in this lookup implementation.
	 */
	@Override
	public boolean containsKeyNoDirect (Object key)
	{
		return containsKey(key);
	}

	@Override
	public String getColumnName() {
		return "PaymentRule";
	}
	
	/**
	 * Get active payment rules
	 * @return array of ValueNamePair(Value, Name)
	 */
	private ValueNamePair[] getData()
	{
		String ad_language = Env.getAD_Language(m_ctx);
		boolean isBaseLanguage = Env.isBaseLanguage(ad_language, "AD_Ref_List");
		StringBuilder sb = new StringBuilder();
		if (isBaseLanguage)
			sb.append("SELECT r.Value, r.Name FROM AD_Ref_List r WHERE r.AD_Reference_ID=? AND r.IsActive='Y'");
		else
		{
			sb.append("SELECT r.Value, t.Name FROM AD_Ref_List_Trl t");
			sb.append(" INNER JOIN AD_Ref_List r ON (r.AD_Ref_List_ID=t.AD_Ref_List_ID)");
			sb.append(" WHERE r.AD_Reference_ID=? AND t.AD_Language=? AND r.IsActive='Y'");
		}

		String wc = getWhereClause();
		if (wc != null && wc.length() > 0)
		{
			wc = wc.replace("AD_Ref_List", "r");
			wc = wc.replace("AD_Ref_List_Trl", "t");
			sb.append(" AND ").append(wc);
		}
		
		if (isBaseLanguage)
			sb.append(" ORDER BY r.Name");
		else
			sb.append(" ORDER BY t.Name");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<ValueNamePair> list = new ArrayList<ValueNamePair>();
		try
		{
			pstmt = DB.prepareStatement(sb.toString(), null);
			pstmt.setInt(1, REFERENCE_PAYMENTRULE);
			if (!isBaseLanguage)
				pstmt.setString(2, ad_language);
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new ValueNamePair(rs.getString(1), rs.getString(2)));
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sb.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		ValueNamePair[] retValue = new ValueNamePair[list.size()];
		list.toArray(retValue);
		return retValue;
	}
	
	@Override
	public String getValidation()
	{
		if (Util.isEmpty(m_validationCode, true))
			return "";
		return m_validationCode.trim();
	}
	
	/**
	 * Parse validation code
	 * @return where clause (parsed validation code)
	 */
	private String getWhereClause()
	{
		String whereClause = "";
		String validation = getValidation();
		if (validation == null)
			validation = "";
		if (whereClause.length() == 0)
			whereClause = validation;
		else if (validation.length() > 0)
			whereClause += " AND " + validation;
		if (whereClause.indexOf('@') != -1)
		{
			String validated = Env.parseContext(Env.getCtx(), getWindowNo(), whereClause, false);
			if (validated.length() == 0)
				log.severe(getColumnName() + " - Cannot Parse=" + whereClause);
			else
			{
				if (log.isLoggable(Level.FINE)) log.fine(getColumnName() + " - Parsed: " + validated);
				return validated;
			}
		}
		return whereClause;
	}
	
	@Override
	public ArrayList<Object> getData(boolean mandatory, boolean onlyValidated,
			boolean onlyActive, boolean temporary, boolean shortlist) { // IDEMPIERE 90
		ArrayList<Object> list = new ArrayList<Object>();
		
		ValueNamePair[] values = getData();
		for (ValueNamePair value : values)
		{
			String PaymentRule = value.getValue();
			if (MInvoice.PAYMENTRULE_DirectDebit.equals(PaymentRule) //	SO
				&& !m_isSOTrx)
				continue;
			else if (MInvoice.PAYMENTRULE_DirectDeposit.equals(PaymentRule)	//	PO 
				&& m_isSOTrx)
				continue;
			list.add(value);
		}
		
		return list;
	}

	@Override
	public int refresh() {
		fillComboBox(isMandatory(), true, true, false, false); // IDEMPIERE 90
		return super.getSize();
	}
}
