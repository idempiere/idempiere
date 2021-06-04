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

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Multi-factor Authentication Registration
 */
public class MMFARegistration extends X_MFA_Registration {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2032862057961778934L;

	/**
	 * Read/Create empty MFA Registration
	 *
	 * @param ctx              context
	 * @param MFA_Registration_ID ID
	 * @param trxName          transaction
	 */
	public MMFARegistration(Properties ctx, int MFA_Registration_ID, String trxName) {
		super(ctx, MFA_Registration_ID, trxName);
	} // MMFARegistration

	/**
	 * Read MFA Registration from current row in ResultSet
	 *
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MMFARegistration(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MMFARegistration

	/**
	 * Validate if a method is already registered for this user
	 * @param method
	 * @param prm 
	 * @return
	 */
	public static boolean alreadyExistsValid(MMFAMethod method, String prm) {
		List<Object> params = new ArrayList<Object>();
		params.add(Env.getAD_User_ID(method.getCtx()));
		params.add(method.getMFA_Method_ID());
		params.add(Env.getAD_Client_ID(method.getCtx()));
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*)"
				+ " FROM MFA_Registration"
				+ " WHERE AD_User_ID=?"
				+ "  AND MFA_Method_ID=?"
				+ "  AND IsValid='Y'"
				+ "  AND AD_Client_ID=?"
				+ "  AND IsActive='Y'");
		if (prm != null) {
			sql.append(" AND ParameterValue=?");
			params.add(prm);
		}
		int cnt = DB.getSQLValueEx(method.get_TrxName(), sql.toString(), params);
		return cnt != 0;
	}

	public static void invalidatePreviousPending(MMFAMethod method, String prm, MMFARegistration reg) {
		List<Object> params = new ArrayList<Object>();
		params.add(Env.getAD_User_ID(method.getCtx()));
		params.add(method.getMFA_Method_ID());
		params.add(Env.getAD_Client_ID(method.getCtx()));
		params.add(reg.getMFA_Registration_ID());
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE MFA_Registration"
				+ " SET IsActive='N'"
				+ " WHERE AD_User_ID=?"
				+ "  AND MFA_Method_ID=?"
				+ "  AND AD_Client_ID=?"
				+ "  AND IsValid='N'"
				+ "  AND IsActive='Y'"
				+ "  AND MFA_Registration_ID!=?");
		if (prm != null) {
			sql.append(" AND ParameterValue=?");
			params.add(prm);
		}
		DB.executeUpdateEx(sql.toString(), params.toArray(), method.get_TrxName());
	}

	/**
	 * Set record as preferred, and set all the others from this user as not preferred
	 */
	@Override
	public void setIsUserMFAPreferred(boolean IsUserMFAPreferred) {
		super.setIsUserMFAPreferred(IsUserMFAPreferred);
		if (IsUserMFAPreferred) {
			int userId = getAD_User_ID();
			int clientId = getAD_Client_ID();
			int regId = getMFA_Registration_ID();
			final String sql = ""
					+ "UPDATE MFA_Registration"
					+ " SET IsUserMFAPreferred='N'"
					+ " WHERE AD_User_ID=?"
					+ "  AND AD_Client_ID=?"
					+ "  AND IsUserMFAPreferred='Y'"
					+ "  AND MFA_Registration_ID!=?";
			DB.executeUpdateEx(sql, new Object[] {userId, clientId, regId}, get_TrxName());
		}
	}

	/**
	 * Get the valid registrations from this user
	 * @return
	 */
	public static List<MMFARegistration> getValidRegistrationsFromUser() {
		final String where = "IsValid ='Y' AND AD_User_ID=? AND AD_Client_ID IN (0,?)";
		List<MMFARegistration> ret = new Query(Env.getCtx(), Table_Name, where, null)
				.setParameters(Env.getAD_User_ID(Env.getCtx()), Env.getAD_Client_ID(Env.getCtx()))
				.setOnlyActiveRecords(true)
				.setOrderBy("IsUserMFAPreferred DESC, Name")
				.list();
		return ret;
	}

	/**
	 * If the user has valid registration mechanisms
	 * @return
	 */
	public static boolean userHasValidRegistration() {
		final String sql = ""
				+ "SELECT COUNT(*)"
				+ " FROM MFA_Registration"
				+ " WHERE IsActive='Y'"
				+ " AND IsValid ='Y'"
				+ " AND AD_User_ID=?"
				+ " AND AD_Client_ID IN (0,?)";
		int cnt = DB.getSQLValueEx(null, sql, Env.getAD_User_ID(Env.getCtx()), Env.getAD_Client_ID(Env.getCtx()));
		return cnt > 0;
	}

	/**
	 * Generate a validation code using the registered method
	 * @param reg
	 * @return
	 */
	public String generateValidationCode(MMFARegistration reg) {
		MMFAMethod method = new MMFAMethod(getCtx(), getMFA_Method_ID(), get_TrxName());
		IMFAMechanism mechanism = method.getMFAMechanism();
		String msg = mechanism.generateValidationCode(reg);
		return msg;
	}

	/**
	 * Validate the code using the registered method
	 * @param reg
	 * @param code
	 * @param setPreferred
	 * @return
	 */
	public String validateCode(MMFARegistration reg, String code, boolean setPreferred) {
		MMFAMethod method = new MMFAMethod(getCtx(), getMFA_Method_ID(), get_TrxName());
		IMFAMechanism mechanism = method.getMFAMechanism();
		String msg = mechanism.validateCode(reg, code, setPreferred);
		return msg;
	}

	/**
	 * 	Set User/Contact.
     * @param AD_User_ID
     * User within the system - Internal or Business Partner Contact
     * Overridden to allow saving System record (zero ID)
	 */
	@Override
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID == 0) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, AD_User_ID);
		else 
			super.setAD_User_ID(AD_User_ID);
	} //setAD_User_ID

} // MMFARegistration
