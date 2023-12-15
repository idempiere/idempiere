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
package org.adempiere.util;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.NumberFormat;
import java.text.ParsePosition;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.MBPBankAccount;
import org.compiere.model.MBPartner;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Helper methods for payment processor
 * @author Elaine
 */
public class PaymentUtil {

	private static final CLogger logger = CLogger.getCLogger(PaymentUtil.class);

	/**
	 * Get business partner bank account by credit card number and payment processor id.
	 * @param bpartner
	 * @param creditCardNo
	 * @param C_PaymentProcessor_ID
	 * @return list of matching MBPBankAccount records
	 */
	public static MBPBankAccount[] getBankAccounts(MBPartner bpartner, String creditCardNo, int C_PaymentProcessor_ID) {
		ArrayList<MBPBankAccount> list = new ArrayList<MBPBankAccount>();
		String sql = "SELECT * FROM C_BP_BankAccount WHERE C_BPartner_ID=? AND CreditCardNumber=? AND C_PaymentProcessor_ID = ? AND IsActive='Y' ORDER BY Created";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, bpartner.get_TrxName());
			pstmt.setInt(1, bpartner.getC_BPartner_ID());
			pstmt.setString(2, creditCardNo);
			pstmt.setInt(3, C_PaymentProcessor_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MBPBankAccount(bpartner.getCtx(), rs, bpartner
						.get_TrxName()));
		} catch (Exception e) {
			logger.log(Level.SEVERE, sql, e);
		} finally {
			DB.close(rs, pstmt);
		}

		MBPBankAccount[] m_accounts = new MBPBankAccount[list.size()];
		list.toArray(m_accounts);
		return m_accounts;
	}

	/**
	 * Replace the front part of credit card number with 0, keeping the last 4 digit.
	 * @param value credit card number
	 * @return partially mask credit card number 
	 */
	public static String encrpytCreditCard(String value) {
		if (value == null)
			return "";
		else

		if (value.length() <= 4)
			return value;

		Integer valueLength = value.length();

		StringBuilder encryptedCC = new StringBuilder();

		for (int i = 0; i < (valueLength - 4); i++) {
			encryptedCC.append("0");
		}

		encryptedCC.append(value.substring(valueLength - 4, valueLength));

		return encryptedCC.toString();
	}

	/**
	 * Replace credit card cvv with 0
	 * @param creditCardVV
	 * @return string fill with just 0
	 */
	public static String encrpytCvv(String creditCardVV) {
		if (creditCardVV == null)
			return "";
		else {
			Integer valueLength = creditCardVV.length();

			StringBuilder encryptedCC = new StringBuilder();

			for (int i = 0; i < valueLength; i++) {
				encryptedCC.append("0");
			}
			return encryptedCC.toString();
		}
	}

	/**
	 * @param str
	 * @return true if str is a number
	 */
	public static boolean isNumeric(String str) {
		if (str != null && str.length() > 0) {
			NumberFormat formatter = NumberFormat.getInstance();
			ParsePosition pos = new ParsePosition(0);

			formatter.parse(str, pos);
			return str.length() == pos.getIndex();
		}
		return true;
	}
	
	/**
	 * Convert payment amount from dollar to cents (i.e x100)
	 * @param payAmt
	 * @return amount in cents (truncated to int)
	 */
	public static int getPayAmtInCents(BigDecimal payAmt)
	{
		if (payAmt == null)
			return 0;
		
		BigDecimal bd = payAmt.multiply(Env.ONEHUNDRED);
		return bd.intValue();
	}
	
	/**
	 * Build credit card expire string
	 * @param creditCardExpMM Expire month
	 * @param creditCardExpYY Expire year
	 * @param delimiter delimiter character between month and year
	 * @return credit card expire string (for e.g 10/26)
	 */
	public static String getCreditCardExp(int creditCardExpMM, int creditCardExpYY, String delimiter)
	{
		String mm = String.valueOf(creditCardExpMM);
		String yy = String.valueOf(creditCardExpYY);

		StringBuilder retValue = new StringBuilder();
		if (mm.length() == 1)
			retValue.append("0");
		retValue.append(mm);
		//
		if (delimiter != null)
			retValue.append(delimiter);
		//
		if (yy.length() == 1)
			retValue.append("0");
		retValue.append(yy);
		//
		return (retValue.toString());
	}
}
