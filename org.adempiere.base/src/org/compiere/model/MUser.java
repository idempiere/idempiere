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
package org.compiere.model;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.logging.Level;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Secure;
import org.compiere.util.SecureEngine;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  User Model
 *
 *  @author Jorg Janke
 *  @version $Id: MUser.java,v 1.3 2006/07/30 00:58:18 jjanke Exp $
 * 
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2788430 ] MUser.getOfBPartner add trxName parameter
 * 				https://sourceforge.net/tracker/index.php?func=detail&aid=2788430&group_id=176962&atid=879335
 */
public class MUser extends X_AD_User implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1351277092193923708L;

	/**
	 * Get active Users of BPartner
	 * @param ctx context
	 * @param C_BPartner_ID id
	 * @return array of users
	 * @deprecated Since 3.5.3a. Please use {@link #getOfBPartner(Properties, int, String)}.
	 */
	public static MUser[] getOfBPartner (Properties ctx, int C_BPartner_ID)
	{
		return getOfBPartner(ctx, C_BPartner_ID, null);
	}
	
	/**
	 * Get active Users of BPartner
	 * @param ctx
	 * @param C_BPartner_ID
	 * @param trxName
	 * @return array of users
	 */
	public static MUser[] getOfBPartner (Properties ctx, int C_BPartner_ID, String trxName)
	{
		List<MUser> list = new Query(ctx, I_AD_User.Table_Name, "C_BPartner_ID=?", trxName)
		.setParameters(C_BPartner_ID)
		.setOnlyActiveRecords(true)
		.list();
		
		MUser[] retValue = new MUser[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getOfBPartner

	/**
	 * 	Get Users with Role
	 *	@param role role
	 *	@return array of users
	 */
	public static MUser[] getWithRole (MRole role)
	{
		ArrayList<MUser> list = new ArrayList<MUser>();
		String sql = "SELECT * FROM AD_User u "
			+ "WHERE u.IsActive='Y'"
			+ " AND EXISTS (SELECT * FROM AD_User_Roles ur "
				+ "WHERE ur.AD_User_ID=u.AD_User_ID AND ur.AD_Role_ID=? AND ur.IsActive='Y')";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, role.getAD_Role_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add(new MUser(role.getCtx(), rs, null));
		} 
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		
		MUser[] retValue = new MUser[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getWithRole

	/**
	 * 	Get User (cached) (immutable)
	 * 	Also loads Admninistrator (0)
	 *	@param AD_User_ID id
	 *	@return user
	 */
	public static MUser get (int AD_User_ID)
	{
		return get(Env.getCtx(), AD_User_ID);
	}
	
	/**
	 * 	Get User (cached) (immutable)
	 * 	Also loads Admninistrator (0)
	 *	@param ctx context
	 *	@param AD_User_ID id
	 *	@return user
	 */
	public static MUser get (Properties ctx, int AD_User_ID)
	{
		Integer key = Integer.valueOf(AD_User_ID);
		MUser retValue = s_cache.get(ctx, key, e -> new MUser(ctx, e));
		if (retValue == null)
		{
			retValue = new MUser (ctx, AD_User_ID, (String)null);
			if (AD_User_ID == 0)
			{
				String trxName = null;
				retValue.load(trxName);	//	load System Record
			}
			if (retValue.get_ID() == AD_User_ID)
			{
				s_cache.put(key, retValue, e -> new MUser(Env.getCtx(), e));
				return retValue;
			}
			return null;
		}
		return retValue;
	}	//	get

	/**
	 * 	Get Current User (cached)
	 *	@param ctx context
	 *	@return user
	 */
	public static MUser get (Properties ctx)
	{
		return get(ctx, Env.getAD_User_ID(ctx));
	}	//	get

	/**
	 * Get updateable copy of MUser from cache
	 * @param ctx
	 * @param AD_User_ID
	 * @param trxName
	 * @return MUser
	 */
	public static MUser getCopy(Properties ctx, int AD_User_ID, String trxName)
	{
		MUser user = get(AD_User_ID);
		if (user != null)
			user = new MUser(ctx, user, trxName);
		return user;
	}
	
	/**
	 * 	Get User
	 *	@param ctx context
	 *	@param name name
	 *	@param password password
	 *	@return user or null
	 */
	public static MUser get (Properties ctx, String name, String password)
	{
		if (name == null || name.length() == 0 || password == null || password.length() == 0)
		{
			s_log.warning ("Invalid Name/Password = " + name);
			return null;
		}
		boolean hash_password = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false);
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);

		ArrayList<Integer> clientsValidated = new ArrayList<Integer>();
		MUser retValue = null;
		
		StringBuilder where = new StringBuilder("Password IS NOT NULL AND ");
		if (email_login)
			where.append("EMail=?");
		else
			where.append("COALESCE(LDAPUser,Name)=?");
		where.append(" AND")
				.append(" EXISTS (SELECT * FROM AD_User_Roles ur")
				.append("         INNER JOIN AD_Role r ON (ur.AD_Role_ID=r.AD_Role_ID)")
				.append("         WHERE ur.AD_User_ID=AD_User.AD_User_ID AND ur.IsActive='Y' AND r.IsActive='Y') AND ")
				.append(" EXISTS (SELECT * FROM AD_Client c")
				.append("         WHERE c.AD_Client_ID=AD_User.AD_Client_ID")
				.append("         AND c.IsActive='Y') AND ")
				.append(" AD_User.IsActive='Y'");
		
		List<MUser> users = new Query(ctx, MUser.Table_Name, where.toString(), null)
			.setParameters(name)
			.setOrderBy("AD_Client_ID, AD_User_ID") // prefer first user on System
			.list();
		
		if (users.size() == 0) {
			s_log.saveError("UserPwdError", name, false);
			return null;
		}
		
		for (MUser user : users) {
			if (clientsValidated.contains(user.getAD_Client_ID())) {
				s_log.severe("Two users with password with the same name/email combination on same tenant: " + name);
				return null;
			}
			
			clientsValidated.add(user.getAD_Client_ID());
			boolean valid = false;
			MSystem system = MSystem.get(Env.getCtx());
			if (system == null)
				throw new IllegalStateException("No System Info");
			
			
			if (system.isLDAP() && ! Util.isEmpty(user.getLDAPUser())) {
				valid = system.isLDAP(name, password);
			} else if (hash_password) {
				valid = user.authenticateHash(password);
			} else {
				// password not hashed
				valid = user.getPassword().equals(password);
			}
			
			if (valid){
				retValue=user;
				break;
			}
		}	
	
		 return retValue;
	}	//	get
	
	/**
	 *  Get Name of AD_User
	 *  @param  AD_User_ID   System User
	 *  @return Name of user or ?
	 */
	public static String getNameOfUser (int AD_User_ID)
	{
		MUser user = get(Env.getCtx(), AD_User_ID);
		if (user.getAD_User_ID() != AD_User_ID)
			return "?";
		return user.getName();
	}	//	getNameOfUser

	
	/**
	 * 	User is SalesRep
	 *	@param AD_User_ID user
	 *	@return true if sales rep
	 */
	public static boolean isSalesRep (int AD_User_ID)
	{
		if (AD_User_ID == 0)
			return false;
		String sql = "SELECT MAX(AD_User_ID) FROM AD_User u"
			+ " INNER JOIN C_BPartner bp ON (u.C_BPartner_ID=bp.C_BPartner_ID) "
			+ "WHERE bp.IsSalesRep='Y' AND AD_User_ID=?";
		int no = DB.getSQLValue(null, sql, AD_User_ID);
		return no == AD_User_ID;
	}	//	isSalesRep
	
	/**	Cache					*/
	static private ImmutableIntPOCache<Integer,MUser> s_cache = new ImmutableIntPOCache<Integer,MUser>(Table_Name, 30, 60);
	/**	Static Logger			*/
	private static CLogger	s_log	= CLogger.getCLogger (MUser.class);
	
	
	/**************************************************************************
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param AD_User_ID id
	 * 	@param trxName transaction
	 */
	public MUser (Properties ctx, int AD_User_ID, String trxName)
	{
		super (ctx, AD_User_ID, trxName);	//	0 is also System
		if (AD_User_ID == 0)
		{
			setIsFullBPAccess (true);
			setNotificationType(NOTIFICATIONTYPE_None);
		}		
	}	//	MUser

	/**
	 * 	Parent Constructor
	 *	@param partner partner
	 */
	public MUser (X_C_BPartner partner)
	{
		this (partner.getCtx(), 0, partner.get_TrxName());
		setClientOrg(partner);
		setC_BPartner_ID (partner.getC_BPartner_ID());
		setName(partner.getName());
	}	//	MUser

	/**
	 * 	Load Constructor
	 * 	@param ctx context
	 * 	@param rs current row of result set to be loaded
	 * 	@param trxName transaction
	 */
	public MUser (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MUser

	/**
	 * 
	 * @param copy
	 */
	public MUser(MUser copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MUser(Properties ctx, MUser copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MUser(Properties ctx, MUser copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_roles = copy.m_roles != null ? Arrays.stream(copy.m_roles).map(e ->{return new MRole(ctx, e, trxName);}).toArray(MRole[]::new) : null;
		this.m_rolesAD_Org_ID = copy.m_rolesAD_Org_ID;
		this.m_isAdministrator = copy.m_isAdministrator;
		this.m_bpAccess = copy.m_bpAccess != null ? Arrays.copyOf(copy.m_bpAccess, copy.m_bpAccess.length) : null;
	}

	/**	Roles of User with Org	*/
	private MRole[] 			m_roles = null;
	/**	Roles of User with Org	*/
	private int		 			m_rolesAD_Org_ID = -1;
	/**	AD_Client_ID for m_roles above	*/
	private int					m_rolesAD_Client_ID = -1;
	/** Is Administrator		*/
	private Boolean				m_isAdministrator = null;
	/** User Access Rights				*/
	private MUserBPAccess[]	m_bpAccess = null;
	/** Password Hashed **/
	private boolean being_hashed = false;
	
		
	/**
	 * 	Get Value - 7 bit lower case alpha numerics max length 8
	 *	@return value
	 */
	public String getValue()
	{
		String s = super.getValue();
		if (s != null)
			return s;
		setValue(null);
		return super.getValue();
	}	//	getValue

	/**
	 * 	Set Value - 7 bit lower case alpha numerics max length 8
	 *	@param Value
	 */
	public void setValue(String Value)
	{
		if (Value == null || Value.trim().length () == 0)
			Value = getLDAPUser();
		if (Value == null || Value.length () == 0)
			Value = getName();
		if (Value == null || Value.length () == 0)
			Value = "noname";
		//
		String result = cleanValue(Value);
		if (result.length() > 8)
		{
			String first = getName(Value, true);
			String last = getName(Value, false);
			if (last.length() > 0)
			{
				String temp = last;
				if (first.length() > 0)
					temp = first.substring (0, 1) + last;
				result = cleanValue(temp);
			}
			else
				result = cleanValue(first);
		}
		if (result.length() > 8)
			result = result.substring (0, 8);
		super.setValue(result);
	}	//	setValue
	
	/**
	 * 	Clean Value
	 *	@param value value
	 *	@return lower case cleaned value
	 */
	private String cleanValue (String value)
	{
		char[] chars = value.toCharArray();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < chars.length; i++)
		{
			char ch = chars[i];
			ch = Character.toLowerCase (ch);
			if ((ch >= '0' && ch <= '9')		//	digits
				|| (ch >= 'a' && ch <= 'z'))	//	characters
				sb.append(ch);
		}
		return sb.toString ();
	}	//	cleanValue
	
	/**
	 * Convert Password to SHA-512 hash with salt * 1000 iterations https://www.owasp.org/index.php/Hashing_Java
	 * @param password -- plain text password
	 */
	@Override
	public void setPassword(String password) {		
		if ( password == null )
		{
			super.setPassword(password);
			return;
		}
		boolean hash_password = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false);
		
		if(!hash_password){
			super.setPassword(password);
			return;
		}
		
		if ( being_hashed  )
			return;
		
		being_hashed = true;   // prevents double call from beforeSave
		
		// Uses a secure Random not a simple Random
		SecureRandom random;
		try {
			random = SecureRandom.getInstance("SHA1PRNG");
			// Salt generation 64 bits long
			byte[] bSalt = new byte[8];
			random.nextBytes(bSalt);
			// Digest computation
			String hash;
			hash = SecureEngine.getSHA512Hash(1000,password,bSalt);

	        String sSalt = Secure.convertToHexString(bSalt);
			super.setPassword(hash);
			setSalt(sSalt);
		} catch (NoSuchAlgorithmException e) {
			super.setPassword(password);
		} catch (UnsupportedEncodingException e) {
			super.setPassword(password);
		}
	}
	
	/**
	 * check if hashed password matches
	 */
	public boolean authenticateHash (String password)  {
		return SecureEngine.isMatchHash (getPassword(), getSalt(), password);
	}	
	
	/**
	 * 	Get First Name
	 *	@return first name
	 */
	public String getFirstName()
	{
		return getName (getName(), true);
	}	//	getFirstName
	
	/**
	 * 	Get Last Name
	 *	@return first name
	 */
	public String getLastName()
	{
		return getName (getName(), false);
	}	//	getLastName

	/**
	 * 	Get First/Last Name
	 *	@param name name
	 *	@param getFirst if true first name is returned
	 *	@return first/last name
	 */
	private String getName (String name, boolean getFirst)
	{
		if (name == null || name.length () == 0)
			return "";
		String first = null;
		String last = null;
		//	Janke, Jorg R - Jorg R Janke
		//	double names not handled gracefully nor titles 
		//	nor (former) aristrocratic world de/la/von 
		boolean lastFirst = name.indexOf(',') != -1;
		StringTokenizer st = null;
		if (lastFirst)
			st = new StringTokenizer(name, ",");
		else
			st = new StringTokenizer(name, " ");
		while (st.hasMoreTokens())
		{
			String s = st.nextToken().trim();
			if (lastFirst)
			{
				if (last == null)
					last = s;
				else if (first == null)
					first = s;
			}
			else
			{
				if (first == null)
					first = s;
				else
					last = s;
			}
		}
		if (getFirst)
		{
			if (first == null)
				return "";
			return first.trim();
		}
		if (last == null)
			return "";
		return last.trim();
	}	//	getName
	
	
	/**
	 * 	Add to Description
	 *	@param description description to be added
	 */
	public void addDescription (String description)
	{
		if (description == null || description.length() == 0)
			return;
		String descr = getDescription();
		if (descr == null || descr.length() == 0)
			setDescription (description);
		else
			setDescription (descr + " - " + description);
	}	//	addDescription
	
	
	/**
	 * 	String Representation
	 *	@return Info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MUser[")
			.append(get_ID())
			.append(",Name=").append(getName())
			.append(",EMailUserID=").append(getEMailUser())
			.append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 * 	Is it an Online Access User
	 *	@return true if it has an email and password
	 */
	public boolean isOnline ()
	{
		if (getEMail() == null || getPassword() == null)
			return false;
		return true;
	}	//	isOnline

	/**
	 * 	Set EMail - reset validation
	 *	@param EMail email
	 */
	public void setEMail(String EMail)
	{
		super.setEMail (EMail);
		setEMailVerifyDate (null);
	}	//	setEMail
	
	/**
	 * 	Convert EMail
	 *	@return Valid Internet Address
	 */
	public InternetAddress getInternetAddress ()
	{
		String email = getEMail();
		if (email == null || email.length() == 0)
			return null;
		try
		{
			InternetAddress ia = new InternetAddress (email, true);
			if (ia != null)
				ia.validate();	//	throws AddressException
			return ia;
		}
		catch (AddressException ex)
		{
			log.warning(email + " - " + ex.getLocalizedMessage());
		}
		return null;
	}	//	getInternetAddress

	/**
	 * 	Validate Email (does not work).
	 * 	Check DNS MX record
	 * 	@param ia email
	 *	@return error message or ""
	 */
	private String validateEmail (InternetAddress ia)
	{
		if (ia == null)
			return "NoEmail";
        else 
        	return ia.getAddress();

	}	//	validateEmail
	
	/**
	 * 	Is the email valid
	 * 	@return return true if email is valid (artificial check)
	 */
	public boolean isEMailValid()
	{
		return validateEmail(getInternetAddress()) != null;
	}	//	isEMailValid
	
	/**
	 * 	Could we send an email
	 * 	@return true if EMail Uwer/PW exists
	 */
	public boolean isCanSendEMail()
	{
		String s = getEMailUser();
		if (s == null || s.length() == 0)
			return false;
		// If SMTP authorization is not required, then don't check password - teo_sarca [ 1723309 ]
		if (!MClient.get(getCtx()).isSmtpAuthorization())
			return true;
		s = getEMailUserPW();
		return s != null && s.length() > 0;
	}	//	isCanSendEMail

	/**
	 * 	Get EMail Validation Code
	 *	@return code
	 */
	public String getEMailVerifyCode()
	{
		long code = getAD_User_ID() 
			+ getName().hashCode();
		return "C" + String.valueOf(Math.abs(code)) + "C";
	}	//	getEMailValidationCode
	
	/**
	 * 	Check & Set EMail Validation Code.
	 *	@param code code
	 *	@param info info
	 *	@return true if valid
	 */
	public boolean setEMailVerifyCode (String code, String info)
	{
		boolean ok = code != null 
			&& code.equals(getEMailVerifyCode()); 
		if (ok)
			setEMailVerifyDate(new Timestamp(System.currentTimeMillis()));
		else
			setEMailVerifyDate(null);
		setEMailVerify(info);
		return ok;
	}	//	setEMailValidationCode
	
	/**
	 * 	Is EMail Verified by response
	 *	@return true if verified
	 */
	public boolean isEMailVerified()
	{
		//	UPDATE AD_User SET EMailVerifyDate=SysDate, EMailVerify='Direct' WHERE AD_User_ID=1
		return getEMailVerifyDate() != null
			&& getEMailVerify() != null 
			&& getEMailVerify().length() > 0; 
	}	//	isEMailVerified
	
	/**
	 * 	Get Notification via EMail
	 *	@return true if email
	 */
	public boolean isNotificationEMail()
	{
		String s = getNotificationType();
		return s == null || NOTIFICATIONTYPE_EMail.equals(s)
				|| NOTIFICATIONTYPE_EMailPlusNotice.equals(s);
	}	//	isNotificationEMail
	
	/**
	 * 	Get Notification via Note
	 *	@return true if note
	 */
	public boolean isNotificationNote()
	{
		String s = getNotificationType();
		return s != null && (NOTIFICATIONTYPE_Notice.equals(s)
							|| NOTIFICATIONTYPE_EMailPlusNotice.equals(s));
	}	//	isNotificationNote
	
	
	/**************************************************************************
	 * 	Get User Roles for Org
	 * 	@param AD_Org_ID org
	 *	@return array of roles
	 */
	public MRole[] getRoles (int AD_Org_ID)
	{
		if (m_roles != null && m_rolesAD_Org_ID == AD_Org_ID && m_rolesAD_Client_ID == Env.getAD_Client_ID(Env.getCtx()))
			return m_roles;
		
		ArrayList<MRole> list = new ArrayList<MRole>();
		// 2007-06-08, matthiasO.
		// Extension of sql query so that not only roles with org acces for this user
		// are found but also roles which delegate org access to the user level where
		// this user has access to the org in question
		String sql = "SELECT * FROM AD_Role r " 
			+ "WHERE r.IsActive='Y' AND r.AD_Client_ID IN (0, ?) " 
			+ " AND EXISTS (SELECT * FROM AD_User_Roles ur" 
			+ " WHERE r.AD_Role_ID=ur.AD_Role_ID AND ur.IsActive='Y' AND ur.AD_User_ID=?) "
			+ " AND ( ( r.isaccessallorgs = 'Y' ) OR "
			+ " ("
			+ " r.IsUseUserOrgAccess <> 'Y'"
			+ " AND EXISTS (SELECT * FROM AD_Role_OrgAccess ro"
			+ " WHERE r.AD_Role_ID=ro.AD_Role_ID AND ro.IsActive='Y' AND ro.AD_Org_ID=?)" 
			+ " ) OR "
			+ " ("
			+ " r.IsUseUserOrgAccess = 'Y'"
			+ " AND EXISTS (SELECT * FROM AD_User_OrgAccess uo"
			+ " WHERE uo.AD_User_ID=? AND uo.IsActive='Y' AND uo.AD_Org_ID=?)" 
			+ " )"
			+ " ) "
			+ "ORDER BY AD_Role_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, Env.getAD_Client_ID(Env.getCtx()));
			pstmt.setInt (2, getAD_User_ID());
			pstmt.setInt (3, AD_Org_ID);
			pstmt.setInt (4, getAD_User_ID());
			pstmt.setInt (5, AD_Org_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MRole(Env.getCtx(), rs, get_TrxName()));
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		
		m_rolesAD_Org_ID = AD_Org_ID;
		m_rolesAD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		m_roles = new MRole[list.size()];
		list.toArray (m_roles);
		return m_roles;
	}	//	getRoles
	
	/**
	 * 	Is User an Administrator?
	 *	@return true if Admin
	 */
	public boolean isAdministrator()
	{
		if (m_isAdministrator == null)
		{
			m_isAdministrator = Boolean.FALSE;
			MRole[] roles = getRoles(0);
			for (int i = 0; i < roles.length; i++)
			{
				if (roles[i].getAD_Role_ID() == 0)
				{
					m_isAdministrator = Boolean.TRUE;
					break;
				}
			}
		}
		return m_isAdministrator.booleanValue();
	}	//	isAdministrator

	/**
	 * 	User has access to URL form?
	 *	@return true if user has access
	 */
	public boolean hasURLFormAccess(String url)
	{
		if (Util.isEmpty(url, true)) {
			return false;
		}
		boolean hasAccess = false;
		int formId = new Query(getCtx(), MForm.Table_Name, "ClassName=?", get_TrxName())
				.setOnlyActiveRecords(true)
				.setParameters(url)
				.firstId();
		if (formId > 0) {
			for (MRole role : getRoles(0))
			{
				Boolean formAccess = role.getFormAccess(formId);
				if (formAccess != null && formAccess.booleanValue()) {
					hasAccess = true;
					break;
				}
			}
		}
		return hasAccess;
	}	//	hasURLFormAccess

	/**
	 * 	Has the user Access to BP info and resources
	 *	@param BPAccessType access type
	 *	@param params opt parameter
	 *	@return true if access
	 */
	public boolean hasBPAccess (String BPAccessType, Object[] params)
	{
		if (isFullBPAccess())
			return true;
		getBPAccess(false);
		for (int i = 0; i < m_bpAccess.length; i++)
		{
			if (m_bpAccess[i].getBPAccessType().equals(BPAccessType))
			{
				return true;
			}
		}
		return false;
	}	//	hasBPAccess
	
	/**
	 * 	Get active BP Access records
	 *	@param requery requery
	 *	@return access list
	 */
	public MUserBPAccess[] getBPAccess (boolean requery)
	{
		if (m_bpAccess != null && !requery)
			return m_bpAccess;
		String sql = "SELECT * FROM AD_UserBPAccess WHERE AD_User_ID=? AND IsActive='Y'";
		ArrayList<MUserBPAccess> list = new ArrayList<MUserBPAccess>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, getAD_User_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				list.add (new MUserBPAccess (getCtx(), rs, null));
			}
		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		
		m_bpAccess = new MUserBPAccess[list.size ()];
		list.toArray (m_bpAccess);
		return m_bpAccess;
	}	//	getBPAccess
	
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		//	New Address invalidates verification
		if (!newRecord && is_ValueChanged("EMail"))
			setEMailVerifyDate(null);

		// IDEMPIERE-1409
		if (!Util.isEmpty(getEMail()) && (newRecord || is_ValueChanged("EMail"))) {
			if (! EMail.validate(getEMail())) {
				log.saveError("SaveError", Msg.getMsg(getCtx(), "InvalidEMailFormat") + Msg.getElement(getCtx(), COLUMNNAME_EMail) + " - [" + getEMail() + "]");
				return false;
			}
		}
		
		if (newRecord || super.getValue() == null || is_ValueChanged("Value"))
			setValue(super.getValue());

		if (getPassword() != null && getPassword().length() > 0) {
			boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
			if (email_login) {
				// email is mandatory for users with password
				if (getEMail() == null || getEMail().length() == 0) {
					log.saveError("SaveError", Msg.getMsg(getCtx(), "FillMandatory") + Msg.getElement(getCtx(), COLUMNNAME_EMail) + " - " + toString());
					return false;
				}
				// email with password must be unique on the same tenant
				int cnt = DB.getSQLValue(get_TrxName(),
						"SELECT COUNT(*) FROM AD_User WHERE Password IS NOT NULL AND EMail=? AND AD_Client_ID=? AND AD_User_ID!=?",
						getEMail(), getAD_Client_ID(), getAD_User_ID());
				if (cnt > 0) {
					log.saveError("SaveError", Msg.getMsg(getCtx(), DBException.SAVE_ERROR_NOT_UNIQUE_MSG, true) + Msg.getElement(getCtx(), COLUMNNAME_EMail));
					return false;
				}
			} else {
				// IDEMPIERE-1672 check duplicate name in client
				String nameToValidate = getLDAPUser();
				if (Util.isEmpty(nameToValidate))
					nameToValidate = getName();
				int cnt = DB.getSQLValue(get_TrxName(),
						"SELECT COUNT(*) FROM AD_User WHERE Password IS NOT NULL AND COALESCE(LDAPUser,Name)=? AND AD_Client_ID=? AND AD_User_ID!=?",
						nameToValidate, getAD_Client_ID(), getAD_User_ID());
				if (cnt > 0) {
					log.saveError("SaveError", Msg.getMsg(getCtx(), DBException.SAVE_ERROR_NOT_UNIQUE_MSG, true) + Msg.getElement(getCtx(), COLUMNNAME_Name) + " / " + Msg.getElement(getCtx(), COLUMNNAME_LDAPUser));
					return false;
				}
			}
		}

		boolean hasPassword = ! Util.isEmpty(getPassword());
		if (hasPassword && (newRecord || is_ValueChanged("Password"))) {
			// Validate password policies / IDEMPIERE-221
			if (! (get_ValueOld("Salt") == null && get_Value("Salt") != null)) { // not being hashed
				MPasswordRule pwdrule = MPasswordRule.getRules(getCtx(), get_TrxName());
				if (pwdrule != null){
					List<MPasswordHistory> passwordHistorys = MPasswordHistory.getPasswordHistoryForCheck(pwdrule.getDays_Reuse_Password(), this.getAD_User_ID());
					pwdrule.validate((getLDAPUser() != null ? getLDAPUser() : getName()), getPassword(), passwordHistorys);
				}
				setDatePasswordChanged(new Timestamp(new Date().getTime()));
			}
		}

		boolean hash_password = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false);
		if (   hasPassword
			&& is_ValueChanged("Password")
			&& (!newRecord || (hash_password && getSalt() == null))) {
			// Hash password - IDEMPIERE-347
			if (hash_password)
				setPassword(getPassword());
		}
		
		return true;
	}	//	beforeSave



	/**
	 * 	Is Menu Auto Expand - user preference
	 *  Check if the user has a preference, otherwise use the value from current role
	 *	@return boolean
	 */
	public boolean isMenuAutoExpand() {
		boolean isMenuAutoExpand = false;
		if (getIsMenuAutoExpand() != null)
			isMenuAutoExpand = ISMENUAUTOEXPAND_Yes.equals(getIsMenuAutoExpand());
		else
			isMenuAutoExpand = MRole.getDefault().isMenuAutoExpand();
		return isMenuAutoExpand;
	}

	/**
	 * 	Get User that has roles (already authenticated)
	 *	@param ctx context
	 *	@param name name
	 *	@return user or null
	 */
	public static MUser get(Properties ctx, String name) {
		if (name == null || name.length() == 0)
		{
			s_log.warning ("Invalid Name = " + name);
			return null;
		}
		MUser retValue = null;
		int AD_Client_ID = Env.getAD_Client_ID(ctx);

		StringBuilder sql = new StringBuilder("SELECT DISTINCT u.AD_User_ID ")
			.append("FROM AD_User u")
			.append(" INNER JOIN AD_User_Roles ur ON (u.AD_User_ID=ur.AD_User_ID AND ur.IsActive='Y')")
			.append(" INNER JOIN AD_Role r ON (ur.AD_Role_ID=r.AD_Role_ID AND r.IsActive='Y') ");
		sql.append("WHERE u.Password IS NOT NULL AND ur.AD_Client_ID=? AND ");		//	#1/2
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
		if (email_login)
			sql.append("u.EMail=?");
		else
			sql.append("COALESCE(u.LDAPUser,u.Name)=?");
		sql.append(" AND u.IsActive='Y'").append(" AND EXISTS (SELECT * FROM AD_Client c WHERE u.AD_Client_ID=c.AD_Client_ID AND c.IsActive='Y')");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), null);
			pstmt.setInt(1, AD_Client_ID);
			pstmt.setString (2, name);
			rs = pstmt.executeQuery ();
			if (rs.next())
			{
				retValue = MUser.getCopy(ctx, rs.getInt(1), (String)null);
				if (rs.next())
					s_log.warning ("More then one user with Name/Password = " + name);
			}
			else
				s_log.fine("No record");
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return retValue;
	}
	
	/**
	 * 	Test
	 *	@param args ignored
	 *
	public static void main (String[] args)
	{
		try
		{
			validateEmail(new InternetAddress("jjanke@adempiere.org"));
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
	//	org.compiere.Adempiere.startupClient();
	//	System.out.println ( MUser.get(Env.getCtx(), "SuperUser", "22") );
	}	//	main	/* */

	@Override
	public String getEMailUser() {
		// IDEMPIERE-722
		if (MClient.isSendCredentialsSystem()) {
			MClient sysclient = MClient.get(getCtx(), 0);
			return sysclient.getRequestUser();
		} else if (MClient.isSendCredentialsClient()) {
			MClient client = MClient.get(getCtx());
			return client.getRequestUser();
		} else {
			return super.getEMailUser();
		}
	}

	@Override
	public String getEMailUserPW() {
		// IDEMPIERE-722
		if (MClient.isSendCredentialsSystem()) {
			MClient sysclient = MClient.get(getCtx(), 0);
			return sysclient.getRequestUserPW();
		} else if (MClient.isSendCredentialsClient()) {
			MClient client = MClient.get(getCtx());
			return client.getRequestUserPW();
		} else {
			return super.getEMailUserPW();
		}
	}

	/**
	 * save new pass to history
	 */
	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (getPassword() != null && getPassword().length() > 0 && (newRecord || is_ValueChanged("Password"))) {
			MPasswordRule pwdrule = MPasswordRule.getRules(getCtx(), get_TrxName());
			if (pwdrule != null && pwdrule.getDays_Reuse_Password() > 0) {
				boolean hash_password = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false);
				if (! hash_password) {
					log.severe("Saving password history: it is strongly encouraged to save password history just when using hashed passwords - WARNING! table AD_Password_History is possibly keeping plain passwords");
				}
				MPasswordHistory passwordHistory = new MPasswordHistory(this.getCtx(), 0, this.get_TrxName());
				passwordHistory.setSalt(this.getSalt());
				passwordHistory.setPassword(this.getPassword());
				passwordHistory.setAD_User_ID(this.getAD_User_ID());
				passwordHistory.setDatePasswordChanged(this.getUpdated());
				passwordHistory.saveEx();
			}
		}
		return super.afterSave(newRecord, success);
	}

	@Override
	protected boolean postDelete() {
		if (getAD_Image_ID() > 0) {
			MImage img = new MImage(getCtx(), getAD_Image_ID(), get_TrxName());
			if (!img.delete(true)) {
				log.warning("Associated image could not be deleted for user - AD_Image_ID=" + getAD_Image_ID());
				return false;
			}
		}
		return true;
	}

	@Override
	public MUser markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_roles != null && m_roles.length > 0)
			Arrays.stream(m_roles).forEach(e -> e.markImmutable());
		if (m_bpAccess != null && m_bpAccess.length > 0)
			Arrays.stream(m_bpAccess).forEach(e -> e.markImmutable());
		
		return this;
	}

}	//	MUser
