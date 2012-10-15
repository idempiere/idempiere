package org.adempiere.util;

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

public class PaymentUtil {

	private static final CLogger logger = CLogger.getCLogger(PaymentUtil.class);

	public static MBPBankAccount[] getBankAccounts(MBPartner bpartner,
			String creditCardNo) {
		ArrayList<MBPBankAccount> list = new ArrayList<MBPBankAccount>();
		String sql = "SELECT * FROM C_BP_BankAccount WHERE C_BPartner_ID=? AND CREDITCARDNUMBER=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, bpartner.get_TrxName());
			pstmt.setInt(1, bpartner.getC_BPartner_ID());
			pstmt.setString(2, creditCardNo);
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

	public static String encrpytCreditCard(String value) {
		if (value == null)
			return "";
		else

		if (value.length() <= 4)
			return value;

		Integer valueLength = value.length();

		StringBuffer encryptedCC = new StringBuffer();

		for (int i = 0; i < (valueLength - 4); i++) {
			encryptedCC.append("*");
		}

		encryptedCC.append(value.substring(valueLength - 4, valueLength));

		return encryptedCC.toString();
	}

	public static String encrpytCvv(String creditCardVV) {
		if (creditCardVV == null)
			return "";
		else {
			Integer valueLength = creditCardVV.length();

			StringBuffer encryptedCC = new StringBuffer();

			for (int i = 0; i < valueLength; i++) {
				encryptedCC.append("0");
			}
			return encryptedCC.toString();
		}
	}

	public static boolean isNumeric(String str) {
		if (str != null && str.length() > 0) {
			NumberFormat formatter = NumberFormat.getInstance();
			ParsePosition pos = new ParsePosition(0);

			formatter.parse(str, pos);
			return str.length() == pos.getIndex();
		}
		return true;
	}
}
