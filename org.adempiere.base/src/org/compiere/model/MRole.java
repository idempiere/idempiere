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

import static org.compiere.model.SystemIDs.USER_SUPERUSER;
import static org.compiere.model.SystemIDs.USER_SYSTEM;

import java.io.Serializable;
import java.lang.reflect.Array;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.process.UUIDGenerator;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trace;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.compiere.wf.MWorkflowAccess;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.POCopyCache;

/**
 *	Role Model.<br/>
 *	Includes AD_User runtime info for Personal Access.<br/>
 *	The class is final, so that you cannot overwrite the security rules.
 *	
 *  @author Jorg Janke
 *  @author Karsten Thiemann FR [ 1782412 ]
 *  @author Carlos Ruiz - globalqss - FR [ 1846929 ] - implement ASP
 *  @contributor KittiU - FR [ 3062553 ] - Duplicated action in DocAction list for Multiple Role Users
 *  @version $Id: MRole.java,v 1.5 2006/08/09 16:38:47 jjanke Exp $
 */
public final class MRole extends X_AD_Role implements ImmutablePOSupport
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8473945674135719367L;

	/**
	 * 	Get role for current session/context
	 *	@return role
	 */
	public static MRole getDefault ()
	{
		return getDefault (Env.getCtx(), false);
	}	//	getDefault

	/**
	 * 	Get role for current session/context
	 * 	@param ctx context
	 * 	@param reload if true forces reload
	 *	@return role
	 *	@see org.compiere.util.Login#loadPreferences(KeyNamePair, KeyNamePair, java.sql.Timestamp, String)
	 */
	public static MRole getDefault (Properties ctx, boolean reload)
	{
		if (MSysConfig.getBooleanValue(MSysConfig.MROLE_GETDEFAULT_RETURNS_NULL_WHEN_NO_CONTEXT, true)) {
			if (Util.isEmpty(Env.getContext(ctx, Env.AD_ROLE_ID)) || Util.isEmpty(Env.getContext(ctx, Env.AD_USER_ID)))
				return null;
		}
		
		int AD_Role_ID = Env.getContextAsInt(ctx, Env.AD_ROLE_ID);
		int AD_User_ID = Env.getContextAsInt(ctx, Env.AD_USER_ID);

		MRole defaultRole = getDefaultRole(ctx, AD_Role_ID, AD_User_ID); 
		if (reload || defaultRole == null)
		{
			defaultRole = get (ctx, AD_Role_ID, AD_User_ID, reload);
			setDefaultRole(defaultRole);
		}
		else if (defaultRole.getAD_Role_ID() != AD_Role_ID
			|| defaultRole.getAD_User_ID() != AD_User_ID)
		{
			defaultRole = get (ctx, AD_Role_ID, AD_User_ID, reload);
			setDefaultRole(defaultRole);
		}
		return defaultRole;
	}	//	getDefault
	
	/**
	 * Get role records readable by current effective role
	 * @return role records (AD_Role_ID, Name), order by Name
	 */
	public static KeyNamePair[] getRoleKeyNamePairs() {
		String sql = MRole.getDefault().addAccessSQL(
				"SELECT AD_Role_ID, Name FROM AD_Role WHERE AD_Client_ID=? AND IsActive='Y' ORDER BY 2", 
				"AD_Role", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		return DB.getKeyNamePairsEx(sql, false, Env.getAD_Client_ID(Env.getCtx()));
	}
	
	/**
	 * Set role for current session/context
	 * @param defaultRole
	 */
	private static void setDefaultRole(MRole defaultRole) {
		Env.getCtx().remove(ROLE_KEY);
		Env.getCtx().put(ROLE_KEY, defaultRole);
	}

	/**
	 * Get role for current session/context
	 * @return MRole
	 */
	private static MRole getDefaultRole() {
		return getDefaultRole(Env.getCtx(), Env.getAD_Role_ID(Env.getCtx()), Env.getAD_User_ID(Env.getCtx()));
	}

	/**
	 * Get role for current session/context
	 * @param ctx
	 * @param AD_Role_ID
	 * @param AD_User_ID
	 * @return MRole
	 */
	private static MRole getDefaultRole(Properties ctx, int AD_Role_ID, int AD_User_ID) {
		MRole role = (MRole) ctx.get(ROLE_KEY);
		String key = AD_Role_ID + "_" + AD_User_ID;
		if (! s_roles.containsKey(key)) {
			ctx.remove(ROLE_KEY);
			role = null;
		}
		return role;
	}

	/**
	 * 	Get Role for User from cache
	 * 	@param ctx context
	 * 	@param AD_Role_ID role
	 * 	@param AD_User_ID user
	 * 	@param reload if true forces load
	 *	@return role
	 */
	public synchronized static MRole get (Properties ctx, int AD_Role_ID, int AD_User_ID, boolean reload)
	{
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("AD_Role_ID=" + AD_Role_ID + ", AD_User_ID=" + AD_User_ID + ", reload=" + reload);
		String key = AD_Role_ID + "_" + AD_User_ID;
		MRole role = (MRole)s_roles.get (key, e -> new MRole(ctx, e));
		if (role == null || reload)
		{
			role = new MRole (ctx, AD_Role_ID, null);			
			if (AD_Role_ID == SystemIDs.ROLE_SYSTEM)
			{
				String trxName = null;
				role.load(trxName);			//	special Handling
			}
			role.setAD_User_ID(AD_User_ID);
			role.loadAccess(reload);
			s_roles.put (key, role, e -> new MRole(Env.getCtx(), e));
			if (s_log.isLoggable(Level.INFO)) s_log.info(role.toString());
		}
		return role;
	}	//	get

	/**
	 * 	Get Role (cached).
	 * 	Did not set user - so no access loaded.
	 * 	@param ctx context
	 * 	@param AD_Role_ID role
	 *	@return role
	 */
	public static MRole get (Properties ctx, int AD_Role_ID)
	{
		return get(ctx, AD_Role_ID, Env.getAD_User_ID(ctx), false); // metas-2009_0021_AP1_G94 - we need to use this method because we need to load/reload all accesses
	}	//	get
	
	/**
	 * 	Get Roles Of Client
	 *	@param ctx context
	 *	@return roles of client
	 */
	public static MRole[] getOfClient (Properties ctx)
	{
		return getOfClient(ctx, (String)null);
	}
	
	/**
	 * 	Get Roles Of Client
	 *	@param ctx context
	 *  @param trxName
	 *	@return roles of client
	 */
	public static MRole[] getOfClient (Properties ctx, String trxName)
	{
		String sql = "SELECT * FROM AD_Role WHERE AD_Client_ID=?";
		ArrayList<MRole> list = new ArrayList<MRole> ();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, Env.getAD_Client_ID(ctx));
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MRole(ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		MRole[] retValue = new MRole[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getOfClient
	
	/**
	 * 	Get Roles via where clause
	 *	@param ctx context
	 *	@param whereClause SQL where clause
	 *	@return roles matching where clause
	 */
	public static MRole[] getOf (Properties ctx, String whereClause)
	{
		String sql = "SELECT * FROM AD_Role";
		if (whereClause != null && whereClause.length() > 0)
			sql += " WHERE " + whereClause;
		ArrayList<MRole> list = new ArrayList<MRole> ();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MRole(ctx, rs, null));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		MRole[] retValue = new MRole[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getOf
		
	/** Role/User Cache			*/
	private static POCopyCache<String,MRole> s_roles = new POCopyCache<String,MRole>(Table_Name, 5);
	/** Log						*/ 
	private static CLogger			s_log = CLogger.getCLogger(MRole.class);
	
	/**	Access SQL Read Write		*/
	public static final boolean		SQL_RW = true;
	/**	Access SQL Read Only		*/
	public static final boolean		SQL_RO = false;
	/**	Access SQL Fully Qualified	*/
	public static final boolean		SQL_FULLYQUALIFIED = true;
	/**	Access SQL Not Fully Qualified	*/
	public static final boolean		SQL_NOTQUALIFIED = false;

	/**	The AD_User_ID of the SuperUser				*/
	public static final int			SUPERUSER_USER_ID = USER_SUPERUSER;
	/**	The AD_User_ID of the System Administrator	*/
	public static final int			SYSTEM_USER_ID = USER_SYSTEM;
	
	private static final String ROLE_KEY = "org.compiere.model.DefaultRole";
		
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Role_UU  UUID key
     * @param trxName Transaction
     */
    public MRole(Properties ctx, String AD_Role_UU, String trxName) {
        super(ctx, AD_Role_UU, trxName);
		if (Util.isEmpty(AD_Role_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor.
	 *  <pre>
	 *  NOTE - This method must not be used when the role is being requested to manage permissions,
	 *         in such case is necessary to use one of the get methods setting AD_User_ID.
	 *  </pre>
	 *	@param ctx context
	 *	@param AD_Role_ID id
	 *	@param trxName transaction
	 */
	public MRole (Properties ctx, int AD_Role_ID, String trxName)
	{
		super (ctx, AD_Role_ID, trxName);
		//	ID=0 == System Administrator
		if (AD_Role_ID == SystemIDs.ROLE_SYSTEM)
			setInitialDefaults();
	}	//	MRole

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsCanExport (true);
		setIsCanReport (true);
		setIsManual (false);
		setIsPersonalAccess (false);
		setIsPersonalLock (false);
		setIsShowAcct (false);
		setIsAccessAllOrgs(false);
		setUserLevel (USERLEVEL_Organization);
		setPreferenceType(PREFERENCETYPE_Organization);
		setIsChangeLog(false);
		setOverwritePriceLimit(false);
		setIsUseUserOrgAccess(false);
		setMaxQueryRecords(0);
		setConfirmQueryRecords(0);
	}

	/**
	 * 	Load Constructor.
	 *  <pre>
	 *  NOTE - This method must not be used when the role is being requested to manage permissions,
	 *         in such case is necessary to use one of the get methods setting AD_User_ID.
	 *  </pre>
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MRole(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRole

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MRole(MRole copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MRole(Properties ctx, MRole copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRole(Properties ctx, MRole copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_AD_User_ID = copy.m_AD_User_ID;
		this.m_orgAccess = copy.m_orgAccess != null ? Arrays.copyOf(copy.m_orgAccess, copy.m_orgAccess.length) : null;
		this.m_tableAccess = copy.m_tableAccess != null ? Arrays.copyOf(copy.m_tableAccess, copy.m_tableAccess.length): null;
		this.m_columnAccess = copy.m_columnAccess != null ? Arrays.copyOf(copy.m_columnAccess, copy.m_columnAccess.length) : null;
		this.m_recordAccess = copy.m_recordAccess != null ? Arrays.copyOf(copy.m_recordAccess, copy.m_recordAccess.length) : null;
		this.m_recordDependentAccess = copy.m_recordDependentAccess != null ? Arrays.copyOf(copy.m_recordDependentAccess, copy.m_recordDependentAccess.length) : null;
		this.m_windowAccess = copy.m_windowAccess != null ? new HashMap<Integer, Boolean>(copy.m_windowAccess) : null;
		this.m_processAccess = copy.m_processAccess != null ? new HashMap<Integer, Boolean>(copy.m_processAccess) : null;
		this.m_taskAccess = copy.m_taskAccess != null ? new HashMap<Integer, Boolean>(copy.m_taskAccess) : null;
		this.m_workflowAccess = copy.m_workflowAccess != null ? new HashMap<Integer, Boolean>(copy.m_workflowAccess) : null;
		this.m_formAccess = copy.m_formAccess != null ? new HashMap<Integer, Boolean>(copy.m_formAccess) : null;
		this.m_infoAccess = copy.m_infoAccess != null ? new HashMap<Integer, Boolean>(copy.m_infoAccess) : null;
		this.m_includedRoles = copy.m_includedRoles != null ? new ArrayList<MRole>(copy.m_includedRoles) : null;
		this.m_parent = copy.m_parent != null ? new MRole(ctx, copy.m_parent, trxName) : null;
		this.m_includedSeqNo = copy.m_includedSeqNo;
		this.m_canAccess_Info_Product = copy.m_canAccess_Info_Product;
	}

	/**
	 * 	Get Confirm Query Records
	 *	@return value of ConfirmQueryRecords or 500 if value of ConfirmQueryRecords is 0.
	 */
	public int getConfirmQueryRecords ()
	{
		int no = super.getConfirmQueryRecords ();
		if (no == 0)
			return 500;
		return no;
	}	//	getConfirmQueryRecords
	
	/**
	 *	@param noRecords records
	 *	@return true if query required
	 *  @deprecated replace by {@link GridTab#isQueryRequire(int)}
	 */
	@Deprecated
	public boolean isQueryRequire (int noRecords)
	{
		if (noRecords < 2)
			return false;
		int max = getMaxQueryRecords();
		if (max > 0 && noRecords > max)
			return true;
		int qu = getConfirmQueryRecords();
		return (noRecords > qu);
	}	//	isQueryRequire

	/**
	 * 	Over max Query
	 *	@param noRecords records
	 *	@return true if over max query
	 *  @deprecated replace by {@link GridTab#isQueryMax(int)}
	 */
	@Deprecated
	public boolean isQueryMax (int noRecords)
	{
		int max = getMaxQueryRecords();
		return max > 0 && noRecords > max;
	}	//	isQueryMax

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		if (getAD_Client_ID() == 0)
			setUserLevel(USERLEVEL_System);
		else if (getUserLevel().equals(USERLEVEL_System))
		{
			log.saveError("AccessTableNoUpdate", Msg.getElement(getCtx(), "UserLevel"));
			return false;
		}
		return true;
	}	//	beforeSave
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (newRecord && success)
		{
			// Assign Role to SuperUser
			MUserRoles su = new MUserRoles(getCtx(), SUPERUSER_USER_ID, getAD_Role_ID(), get_TrxName());
			su.saveEx();
			// Assign Role to Created By user
			if (getCreatedBy() != SUPERUSER_USER_ID && MSysConfig.getBooleanValue(MSysConfig.AUTO_ASSIGN_ROLE_TO_CREATOR_USER, false, getAD_Client_ID()))
			{
				MUserRoles ur = new MUserRoles(getCtx(), getCreatedBy(), getAD_Role_ID(), get_TrxName());
				ur.saveEx();
			}
			updateAccessRecords();
		}
		//
		else if (is_ValueChanged("UserLevel"))
			updateAccessRecords();

		return success;
	}	//	afterSave
	
	@Override
	protected boolean afterDelete (boolean success)
	{
		if(success) {
			deleteAccessRecords();
		}
		return success;
	} 	//	afterDelete

	/**
	 * 	Delete existing access records and create new access records
	 *	@return info
	 */
	public String updateAccessRecords ()
	{
		return updateAccessRecords(true);
	}
	
	
	/**
	 * 	Create Access Records
	 *	@param reset true to delete existing access records
	 *	@return info
	 */
	public String updateAccessRecords (boolean reset)
	{
		if (isManual())
			return "-";
		
		int userID = Env.getAD_User_ID(getCtx());
		
		String roleClientOrgUser = getAD_Role_ID() + ","
			+ getAD_Client_ID() + "," + getAD_Org_ID() + ",'Y', getDate()," 
			+ userID + ", getDate()," + userID 
			+ ",'Y' ";	//	IsReadWrite
		
		String sqlWindow = "INSERT INTO AD_Window_Access "
			+ "(AD_Window_ID, AD_Role_ID,"
			+ " AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadWrite) "
			+ "SELECT DISTINCT w.AD_Window_ID, " + roleClientOrgUser
			+ "FROM AD_Window w"
			+ " INNER JOIN AD_Tab t ON (w.AD_Window_ID=t.AD_Window_ID)"
			+ " INNER JOIN AD_Table tt ON (t.AD_Table_ID=tt.AD_Table_ID) "
			+ " LEFT JOIN AD_Window_Access wa ON "
			+ "(wa.AD_Role_ID=" + getAD_Role_ID()
			+ " AND w.AD_Window_ID = wa.AD_Window_ID) "
			+ "WHERE w.IsActive = 'Y' AND wa.AD_Window_ID IS NULL AND t.SeqNo=(SELECT MIN(SeqNo) FROM AD_Tab xt "	// only check first tab
				+ "WHERE xt.AD_Window_ID=w.AD_Window_ID) "
			+ "AND tt.AccessLevel IN ";
		
		String sqlProcess = "INSERT INTO AD_Process_Access "
			+ "(AD_Process_ID, AD_Role_ID,"
			+ " AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy, IsReadWrite) "
			+ "SELECT DISTINCT p.AD_Process_ID, " + roleClientOrgUser
			+ "FROM AD_Process p LEFT JOIN AD_Process_Access pa ON "
			+ "(pa.AD_Role_ID=" + getAD_Role_ID()
			+ " AND p.AD_Process_ID = pa.AD_Process_ID) "
			+ "WHERE p.IsActive = 'Y' AND pa.AD_Process_ID IS NULL AND AccessLevel IN ";

		String sqlForm = "INSERT INTO AD_Form_Access "
			+ "(AD_Form_ID, AD_Role_ID," 
			+ " AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadWrite) "
			+ "SELECT f.AD_Form_ID, " + roleClientOrgUser
			+ "FROM AD_Form f LEFT JOIN AD_Form_Access fa ON "
			+ "(fa.AD_Role_ID=" + getAD_Role_ID()
			+ " AND f.AD_Form_ID = fa.AD_Form_ID) "
			+ "WHERE f.IsActive = 'Y' AND fa.AD_Form_ID IS NULL AND AccessLevel IN ";

		String sqlWorkflow = "INSERT INTO AD_WorkFlow_Access "
			+ "(AD_WorkFlow_ID, AD_Role_ID,"
			+ " AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadWrite) "
			+ "SELECT w.AD_WorkFlow_ID, " + roleClientOrgUser
			+ "FROM AD_WorkFlow w LEFT JOIN AD_WorkFlow_Access wa ON "
			+ "(wa.AD_Role_ID=" + getAD_Role_ID()
			+ " AND w.AD_WorkFlow_ID = wa.AD_WorkFlow_ID) "
			+ "WHERE w.IsActive = 'Y' AND w.AD_Client_ID IN (0," + getAD_Client_ID() + ") AND wa.AD_WorkFlow_ID IS NULL AND AccessLevel IN ";

		String sqlDocAction = "INSERT INTO AD_Document_Action_Access "
			+ "(AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"
			+ "C_DocType_ID , AD_Ref_List_ID, AD_Role_ID) " 
			+ "(SELECT "
			+ getAD_Client_ID() + ",0,'Y', getDate()," 
			+ userID + ", getDate()," + userID
			+ ", doctype.C_DocType_ID, action.AD_Ref_List_ID, rol.AD_Role_ID " 
			+ "FROM AD_Client client " 
			+ "INNER JOIN C_DocType doctype ON (doctype.AD_Client_ID=client.AD_Client_ID) "
			+ "INNER JOIN AD_Ref_List action ON (action.AD_Reference_ID=135) "
			+ "INNER JOIN AD_Role rol ON (rol.AD_Client_ID=client.AD_Client_ID "
			+ "AND rol.AD_Role_ID=" + getAD_Role_ID() 
			+ ") LEFT JOIN AD_Document_Action_Access da ON "
			+ "(da.AD_Role_ID=" + getAD_Role_ID()
			+ " AND da.C_DocType_ID=doctype.C_DocType_ID AND da.AD_Ref_List_ID=action.AD_Ref_List_ID) "
			+ "WHERE doctype.IsActive = 'Y' AND  (da.C_DocType_ID IS NULL AND da.AD_Ref_List_ID IS NULL)) ";

		String sqlInfo = "INSERT INTO AD_InfoWindow_Access "
				+ "(AD_InfoWindow_ID, AD_Role_ID,"
				+ " AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy) "
				+ "SELECT i.AD_InfoWindow_ID," + getAD_Role_ID() + ","
				+ getAD_Client_ID() + "," + getAD_Org_ID() + ",'Y',getDate()," 
				+ userID + ", getDate()," + userID
				+ " FROM AD_InfoWindow i LEFT JOIN AD_InfoWindow_Access ia ON "
				+ "(ia.AD_Role_ID=" + getAD_Role_ID()
				+ " AND i.AD_InfoWindow_ID = ia.AD_InfoWindow_ID) "
				+ " INNER JOIN AD_Table tt ON (i.AD_Table_ID=tt.AD_Table_ID) "
				+ "WHERE i.IsActive = 'Y' AND i.AD_Client_ID IN (0," + getAD_Client_ID() + ") AND ia.AD_InfoWindow_ID IS NULL"
				+ " AND tt.AccessLevel IN ";

		/**
		 *	Fill AD_xx_Access
		 *	---------------------------------------------------------------------------
		 *	SCO# Levels			S__ 100		4	System info
		 *						SCO	111		7	System shared info
		 *						SC_ 110		6	System/Client info
		 *						_CO	011		3	Client shared info
		 *						_C_	011		2	Client
		 *						__O	001		1	Organization info
		 *	Roles:
		 *		S		4,7,6
		 *		_CO		7,6,3,2,1
		 *		__O		3,1,7
		 */
		String roleAccessLevel = null;
		String roleAccessLevelWin = null;
		if (USERLEVEL_System.equals(getUserLevel()))
			roleAccessLevel = "('4','7','6')";
		else if (USERLEVEL_Client.equals(getUserLevel()))
			roleAccessLevel = "('7','6','3','2')";
		else if (USERLEVEL_ClientPlusOrganization.equals(getUserLevel()))
			roleAccessLevel = "('7','6','3','2','1')";
		else //	if (USERLEVEL_Organization.equals(getUserLevel()))
		{
			roleAccessLevel = "('3','1','7')";
			roleAccessLevelWin = roleAccessLevel
				+ " AND w.Name NOT LIKE '%(all)%'";
		}
		if (roleAccessLevelWin == null)
			roleAccessLevelWin = roleAccessLevel;
		
		if (reset)
			deleteAccessRecords();

		int win = DB.executeUpdateEx(sqlWindow + roleAccessLevelWin, get_TrxName());
		int proc = DB.executeUpdateEx(sqlProcess + roleAccessLevel, get_TrxName());
		int form = DB.executeUpdateEx(sqlForm + roleAccessLevel, get_TrxName());
		int wf = DB.executeUpdateEx(sqlWorkflow + roleAccessLevel, get_TrxName());
		int docact = DB.executeUpdateEx(sqlDocAction, get_TrxName());
		int info = DB.executeUpdateEx(sqlInfo + roleAccessLevel, get_TrxName());

		if (DB.isGenerateUUIDSupported()) {
			DB.executeUpdateEx("UPDATE AD_Window_Access SET AD_Window_Access_UU=generate_uuid() WHERE AD_Window_Access_UU IS NULL", get_TrxName());
			DB.executeUpdateEx("UPDATE AD_Process_Access SET AD_Process_Access_UU=generate_uuid() WHERE AD_Process_Access_UU IS NULL", get_TrxName());
			DB.executeUpdateEx("UPDATE AD_Form_Access SET AD_Form_Access_UU=generate_uuid() WHERE AD_Form_Access_UU IS NULL", get_TrxName());
			DB.executeUpdateEx("UPDATE AD_Workflow_Access SET AD_Workflow_Access_UU=generate_uuid() WHERE AD_Workflow_Access_UU IS NULL", get_TrxName());
			DB.executeUpdateEx("UPDATE AD_Document_Action_Access SET AD_Document_Action_Access_UU=generate_uuid() WHERE AD_Document_Action_Access_UU IS NULL", get_TrxName());
			DB.executeUpdateEx("UPDATE AD_InfoWindow_Access SET AD_InfoWindow_Access_UU=generate_uuid() WHERE AD_InfoWindow_Access_UU IS NULL", get_TrxName());
		} else {
			UUIDGenerator.updateUUID(MColumn.get(getCtx(), MWindowAccess.Table_Name,         PO.getUUIDColumnName(MWindowAccess.Table_Name)),         get_TrxName());
			UUIDGenerator.updateUUID(MColumn.get(getCtx(), MProcessAccess.Table_Name,        PO.getUUIDColumnName(MProcessAccess.Table_Name)),        get_TrxName());
			UUIDGenerator.updateUUID(MColumn.get(getCtx(), MFormAccess.Table_Name,           PO.getUUIDColumnName(MFormAccess.Table_Name)),           get_TrxName());
			UUIDGenerator.updateUUID(MColumn.get(getCtx(), MWorkflowAccess.Table_Name,       PO.getUUIDColumnName(MWorkflowAccess.Table_Name)),       get_TrxName());
			UUIDGenerator.updateUUID(MColumn.get(getCtx(), MDocumentActionAccess.Table_Name, PO.getUUIDColumnName(MDocumentActionAccess.Table_Name)), get_TrxName());
			UUIDGenerator.updateUUID(MColumn.get(getCtx(), MInfoWindowAccess.Table_Name,     PO.getUUIDColumnName(MInfoWindowAccess.Table_Name)),     get_TrxName());
		}

		loadAccess(true);
		return Msg.parseTranslation(getCtx(), "@AD_Window_ID@ #" + win 
			+ " -  @AD_Process_ID@ #" + proc
			+ " -  @AD_Form_ID@ #" + form
			+ " -  @AD_Workflow_ID@ #" + wf
			+ " -  @DocAction@ #" + docact
			+ " -  @AD_InfoWindow_ID@ #" + info);
		
	}	//	createAccessRecords

	/**
	 * Delete Access Records of a role.
	 */
	private void deleteAccessRecords() {
		String whereDel = " WHERE AD_Role_ID=" + getAD_Role_ID();
		//
		int winDel = DB.executeUpdateEx("DELETE FROM AD_Window_Access" + whereDel, get_TrxName());
		int procDel = DB.executeUpdateEx("DELETE FROM AD_Process_Access" + whereDel, get_TrxName());
		int formDel = DB.executeUpdateEx("DELETE FROM AD_Form_Access" + whereDel, get_TrxName());
		int wfDel = DB.executeUpdateEx("DELETE FROM AD_WorkFlow_Access" + whereDel, get_TrxName());
		int docactDel = DB.executeUpdateEx("DELETE FROM AD_Document_Action_Access" + whereDel, get_TrxName());
		int infoDel = DB.executeUpdateEx("DELETE FROM AD_InfoWindow_Access" + whereDel, get_TrxName());

		if (log.isLoggable(Level.FINE)) log.fine("AD_Window_Access=" + winDel
			+ ", AD_Process_Access=" + procDel
			+ ", AD_Form_Access=" + formDel
			+ ", AD_Workflow_Access=" + wfDel
			+ ", AD_Document_Action_Access=" + docactDel
			+ ", AD_InfoWindow_Access=" + infoDel);
	}
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MRole[");
		sb.append(getAD_Role_ID()).append(",").append(getName())
			.append(",UserLevel=").append(getUserLevel())
			.append(",").append(getClientWhere(false))
			.append(",").append(getOrgWhere(false))
			.append("]");
		return sb.toString();
	}	//	toString

	/**
	 * 	Extended String Representation
	 *	@param ctx Properties
	 *	@return extended info
	 */
	public String toStringX (Properties ctx)
	{
		StringBuilder sb = new StringBuilder();
		sb.append(Msg.translate(ctx, "AD_Role_ID")).append("=").append(getName())
			.append(" - ").append(Msg.translate(ctx, "IsCanExport")).append("=").append(Msg.translate(ctx,String.valueOf(isCanExport())))
			.append(" - ").append(Msg.translate(ctx, "IsCanReport")).append("=").append(Msg.translate(ctx,String.valueOf(isCanReport()))) 
			.append(Env.NL).append(Env.NL);
		//
		for (int i = 0; i < m_orgAccess.length; i++)
			sb.append(m_orgAccess[i].toString()).append(Env.NL);
		sb.append(Env.NL);
		//
		loadTableAccess(false);
		for (int i = 0; i < m_tableAccess.length; i++)
			sb.append(m_tableAccess[i].toStringX(ctx)).append(Env.NL);
		if (m_tableAccess.length > 0)
			sb.append(Env.NL);
		//
		loadColumnAccess(false);
		for (int i = 0; i < m_columnAccess.length; i++)
			sb.append(m_columnAccess[i].toStringX(ctx)).append(Env.NL);
		if (m_columnAccess.length > 0)
			sb.append(Env.NL);
		//
		loadRecordAccess(false);
		for (int i = 0; i < m_recordAccess.length; i++)
			sb.append(m_recordAccess[i].toStringX(ctx)).append(Env.NL);
		return sb.toString();
	}	//	toStringX

	/*************************************************************************
	 * 	Access Management
	 ************************************************************************/

	/** User 								*/
	private int						m_AD_User_ID = -1;	

	/**	Positive List of Organizational Access		*/	
	private OrgAccess[]				m_orgAccess = null;
	/** List of Table Access						*/
	private MTableAccess[]			m_tableAccess = null;
	/** List of Column Access				*/
	private MColumnAccess[]			m_columnAccess = null;
	/** List of Record Access				*/
	private MRecordAccess[]			m_recordAccess = null;
	/** List of Dependent Record Access		*/
	private MRecordAccess[]			m_recordDependentAccess = null;

	/**	Window Access			*/
	private HashMap<Integer,Boolean>	m_windowAccess = null;
	/**	Process Access			*/
	private HashMap<Integer,Boolean>	m_processAccess = null;
	/**	Task Access				*/
	private HashMap<Integer,Boolean>	m_taskAccess = null;
	/**	Workflow Access			*/
	private HashMap<Integer,Boolean>	m_workflowAccess = null;
	/**	Form Access				*/
	private HashMap<Integer,Boolean>	m_formAccess = null;
	/**	Info Windows			*/
	private HashMap<Integer, Boolean> m_infoAccess;

	/**
	 * 	Set Logged in user
	 *	@param AD_User_ID logged in user id
	 */
	public void setAD_User_ID(int AD_User_ID)
	{
		m_AD_User_ID = AD_User_ID;
	}	//	setAD_User_ID

	/**
	 * 	Get Logged in user
	 *	@return AD_User_ID 
	 */
	public int getAD_User_ID()
	{
		return m_AD_User_ID;
	}	//	getAD_User_ID
	
	/**
	 * 	Load Access Info
	 * 	@param reload re-load from DB
	 */
	public void loadAccess (boolean reload)
	{
		loadOrgAccess(reload);
		loadTableAccess(reload);
		loadColumnAccess(reload);
		loadRecordAccess(reload);
		if (reload)
		{
			m_windowAccess = null;
			m_processAccess = null;
			m_taskAccess = null;
			m_workflowAccess = null;
			m_formAccess = null;
		}
		loadIncludedRoles(reload); // Load/Reload included roles - metas-2009_0021_AP1_G94
	}	//	loadAccess

	/**
	 * 	Load Organization Access
	 *	@param reload reload from DB
	 */
	private void loadOrgAccess (boolean reload)
	{
		if (!(reload || m_orgAccess == null))
			return;
		//
		ArrayList<OrgAccess> list = new ArrayList<OrgAccess>();

		if (isUseUserOrgAccess())
			loadOrgAccessUser(list);
		else
			loadOrgAccessRole(list);
		
		m_orgAccess = new OrgAccess[list.size()];
		list.toArray(m_orgAccess); 
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_orgAccess.length + (reload ? " - reload" : "")); 
		if (Ini.isClient())
		{
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < m_orgAccess.length; i++)
			{
				if (i > 0)
					sb.append(",");
				sb.append(m_orgAccess[i].AD_Org_ID);
			}
			Env.setContext(Env.getCtx(), "#User_Org", sb.toString());
		}
	}	//	loadOrgAccess

	/**
	 * 	Load Organization User Access (AD_User_OrgAccess)
	 *	@param list list to load access record to
	 */
	private void loadOrgAccessUser(ArrayList<OrgAccess> list)
	{
		if (getAD_User_ID() == -1) {
			log.info("Trying to load Org Access from User but user has not been set");
		}
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM AD_User_OrgAccess "
			+ "WHERE AD_User_ID=? AND IsActive='Y' AND AD_Client_ID = ?";
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getAD_User_ID());
			pstmt.setInt(2, getAD_Client_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MUserOrgAccess oa = new MUserOrgAccess(getCtx(), rs, get_TrxName()); 
				loadOrgAccessAdd (list, new OrgAccess(oa.getAD_Client_ID(), oa.getAD_Org_ID(), oa.isReadOnly()));
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
	}	//	loadOrgAccessRole

	/**
	 * 	Load Organization Role Access (AD_Role_OrgAccess)
	 *	@param list list to load access record to
	 */
	private void loadOrgAccessRole(ArrayList<OrgAccess> list)
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM AD_Role_OrgAccess "
			+ "WHERE AD_Role_ID=? AND IsActive='Y' AND AD_Client_ID = ?";
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getAD_Role_ID());
			pstmt.setInt(2, getAD_Client_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MRoleOrgAccess oa = new MRoleOrgAccess(getCtx(), rs, get_TrxName()); 
				loadOrgAccessAdd (list, new OrgAccess(oa.getAD_Client_ID(), oa.getAD_Org_ID(), oa.isReadOnly()));
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
	}	//	loadOrgAccessRole
	
	/**
	 * 	Add OrgAccess to OrgAccess list.<br/>
	 *  If OrgAccess belongs to a summary organization, perform the same addition for child organization as well.
	 *	@param list list to add OrgAccess to
	 *	@param oa OrgAccess record
	 *	@see org.compiere.util.Login
	 */
	private void loadOrgAccessAdd (ArrayList<OrgAccess> list, OrgAccess oa)
	{
		if (list.contains(oa))
			return;
		list.add(oa);
		//	Do we look for trees?
		if (getAD_Tree_Org_ID() == 0)
			return;
		MOrg org = MOrg.get(oa.AD_Org_ID);
		if (!org.isSummary())
			return;
		//	Summary Org - Get Dependents
		MTree_Base tree = MTree_Base.get(getCtx(), getAD_Tree_Org_ID(), get_TrxName());
		String sql =  "SELECT AD_Client_ID, AD_Org_ID FROM AD_Org "
			+ "WHERE IsActive='Y' AND AD_Org_ID IN (SELECT Node_ID FROM "
			+ tree.getNodeTableName()
			+ " WHERE AD_Tree_ID=? AND Parent_ID=? AND IsActive='Y')";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, tree.getAD_Tree_ID());
			pstmt.setInt(2, org.getAD_Org_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				int AD_Client_ID = rs.getInt(1);
				int AD_Org_ID = rs.getInt(2);
				loadOrgAccessAdd (list, new OrgAccess(AD_Client_ID, AD_Org_ID, oa.readOnly));
			}
		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}	//	loadOrgAccessAdd
	
	/**
	 * 	Load Table Access (AD_Table_Access)
	 *	@param reload true to reload from DB
	 */
	private void loadTableAccess(boolean reload)
	{
		if (m_tableAccess != null && !reload)
			return;
		ArrayList<MTableAccess> list = new ArrayList<MTableAccess>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM AD_Table_Access "
			+ "WHERE AD_Role_ID=? AND IsActive='Y'";
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getAD_Role_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MTableAccess(getCtx(), rs, get_TrxName())); 
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		m_tableAccess = new MTableAccess[list.size()];
		list.toArray(m_tableAccess); 
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_tableAccess.length); 
	}	//	loadTableAccess

	/**
	 * Check if tableName is a view
	 * @param tableName
	 * @return true if tableName is a view
	 */
	private boolean isView(String tableName)
	{
		MTable table = MTable.get(getCtx(), tableName);
		if (table == null)
			return false;
		return table.isView();
	}

	/**
	 * @param tableName
	 * @return Id column for tableName or null
	 */
	private String getIdColumnName(String tableName)
	{
		StringBuilder colkey = new StringBuilder(tableName).append("_ID");
		MTable table = MTable.get(getCtx(), tableName);
		if (table == null)
			return null;
		if (table.getColumnIndex(colkey.toString()) >= 0)
			return colkey.toString();
		return null;
	}
	
	/**
	 * 	Load Column Access (AD_Column_Access)
	 *	@param reload true to reload from DB
	 */
	private void loadColumnAccess(boolean reload)
	{
		if (m_columnAccess != null && !reload)
			return;
		ArrayList<MColumnAccess> list = new ArrayList<MColumnAccess>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM AD_Column_Access "
			+ "WHERE AD_Role_ID=? AND IsActive='Y'";
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getAD_Role_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MColumnAccess(getCtx(), rs, get_TrxName())); 
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		m_columnAccess = new MColumnAccess[list.size()];
		list.toArray(m_columnAccess); 
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_columnAccess.length); 
	}	//	loadColumnAccess
	
	/**
	 * 	Load Record Access (AD_Record_Access)
	 *	@param reload true to reload from DB
	 */
	private void loadRecordAccess(boolean reload)
	{
		if (!(reload || m_recordAccess == null || m_recordDependentAccess == null))
			return;
		ArrayList<MRecordAccess> list = new ArrayList<MRecordAccess>();
		ArrayList<MRecordAccess> dependent = new ArrayList<MRecordAccess>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM AD_Record_Access "
			+ "WHERE AD_Role_ID=? AND IsActive='Y' ORDER BY AD_Table_ID";
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getAD_Role_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MRecordAccess ra = new MRecordAccess(getCtx(), rs, get_TrxName());
				list.add(ra);
				if (ra.isDependentEntities())
					dependent.add(ra);
			} 
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		m_recordAccess = new MRecordAccess[list.size()];
		list.toArray(m_recordAccess);
		m_recordDependentAccess = new MRecordAccess[dependent.size()];
		dependent.toArray(m_recordDependentAccess);
		if (log.isLoggable(Level.FINE)) log.fine("#" + m_recordAccess.length + " - Dependent #" + m_recordDependentAccess.length); 
	}	//	loadRecordAccess

	/**
	 * 	Get Where Clause for client filter
	 * 	@param rw read write
	 * 	@return "AD_Client_ID=0" or "AD_Client_ID IN(0,1,...)"
	 */
	public String getClientWhere (boolean rw)
	{
		//	All Orgs - use Client of Role
		if (isAccessAllOrgs())
		{
			if (rw || getAD_Client_ID() == 0)
				return "AD_Client_ID=" + getAD_Client_ID();
			return "AD_Client_ID IN (0," + getAD_Client_ID() + ")";
		}

		//	Get Client from Org List
		loadOrgAccess (false);
		//	Unique Strings
		HashSet<String> set = new HashSet<String>();
		if (!rw)
			set.add("0");
		//	Positive List
		for (int i = 0; i < m_orgAccess.length; i++)
			set.add(String.valueOf(m_orgAccess[i].AD_Client_ID));
		//
		StringBuilder sb = new StringBuilder();
		Iterator<String> it = set.iterator();
		boolean oneOnly = true;
		while (it.hasNext())
		{
			if (sb.length() > 0)
			{
				sb.append(",");
				oneOnly = false;
			}
			sb.append(it.next());
		}
		if (oneOnly)
		{
			if (sb.length() > 0)
				return "AD_Client_ID=" + sb.toString();
			else
			{
				log.log(Level.SEVERE, "No Access Org records");
				return "AD_Client_ID=-1";	//	No Access Record
			}
		}
		return "AD_Client_ID IN(" + sb.toString() + ")";
	}	//	getClientWhereValue
	
	/**
	 * 	Access to Client
	 *	@param AD_Client_ID client
	 *	@param rw read write access
	 *	@return true if can access
	 */
	public boolean isClientAccess(int AD_Client_ID, boolean rw)
	{
		if (AD_Client_ID == 0 && !rw)	//	can always read System
			return true;
		//
		// Check Access All Orgs:
		if (isAccessAllOrgs()) {
			// User has access to given AD_Client_ID if the role is defined on that AD_Client_ID
			return getAD_Client_ID() == AD_Client_ID;
		}
		//
		loadOrgAccess(false);
		//	Positive List
		for (int i = 0; i < m_orgAccess.length; i++)
		{
			if (m_orgAccess[i].AD_Client_ID == AD_Client_ID)
			{
				if (!rw)
					return true;
				if (!m_orgAccess[i].readOnly)	//	rw
					return true;
			}
		}
		return false;
	}	//	isClientAccess
	
	/**
	 * 	Get Where Clause for organization filter 
	 * 	@param rw read write
	 * 	@return "AD_Org_ID=0" or "AD_Org_ID IN(0,1,...)" or null (if access all org)
	 */
	public String getOrgWhere (boolean rw)
	{
		if (isAccessAllOrgs())
			return null;
		loadOrgAccess(false);
		//	Unique Strings
		HashSet<String> set = new HashSet<String>();
		if (!rw)
			set.add("0");
		//	Positive List
		for (int i = 0; i < m_orgAccess.length; i++)
		{
			if (!rw)
				set.add(String.valueOf(m_orgAccess[i].AD_Org_ID));
			else if (!m_orgAccess[i].readOnly)	//	rw
				set.add(String.valueOf(m_orgAccess[i].AD_Org_ID));
		}
		//
		StringBuilder sb = new StringBuilder();
		Iterator<String> it = set.iterator();
		final int MAX_ORACLE_ELEMENTS_IN_ORACLE = 1000;
		int idx = 0;
		while (it.hasNext())
		{
			idx++;
			if (sb.length() > 0)
			{
				if (DB.isOracle() && (idx-1) % MAX_ORACLE_ELEMENTS_IN_ORACLE == 0) { // prevent ORA-01795
					sb.append(") OR AD_Org_ID IN (");
				} else {
					sb.append(",");
				}
			}
			sb.append(it.next());
		}
		if (sb.indexOf(",") < 0) // only one org
		{
			if (sb.length() > 0)
				return "AD_Org_ID=" + sb.toString();
			else
			{
				log.log(Level.SEVERE, "No Access Org records");
				return "AD_Org_ID=-1";	//	No Access Record
			}
		}		
		return "(AD_Org_ID IN (" + sb.toString() + "))";
	}	//	getOrgWhere
	
	/**
	 * 	Access to Org
	 *	@param AD_Org_ID org
	 *	@param rw read write access
	 *	@return true if access
	 */
	public boolean isOrgAccess(int AD_Org_ID, boolean rw)
	{
		if (isAccessAllOrgs())
			return true;
		if (AD_Org_ID == 0 && !rw)		//	can always read common org
			return true;
		loadOrgAccess(false);
		
		//	Positive List
		for (int i = 0; i < m_orgAccess.length; i++)
		{
			if (m_orgAccess[i].AD_Org_ID == AD_Org_ID)
			{
				if (!rw)
					return true;
				if (!m_orgAccess[i].readOnly)	//	rw
					return true;
				return false;
			}
		}
		return false;
	}	//	isOrgAccess

	/**
	 * 	Can Report on table
	 *	@param AD_Table_ID table
	 *	@return true if can report
	 */
	public boolean isCanReport (int AD_Table_ID)
	{
		if (!isCanReport())						//	Role Level block
		{
			if (log.isLoggable(Level.FINE)) log.fine ("Role denied (" + MRole.getDefaultRole().getAD_Role_ID() + ") tableID=" + AD_Table_ID);
			return false;
		}
		if (!isTableAccess(AD_Table_ID, true))	//	No R/O Access to Table
			return false;
		
		//default to negative list, can report on all tables
		boolean canReport = true;
		for (int i = 0; i < m_tableAccess.length; i++)
		{
			if (!X_AD_Table_Access.ACCESSTYPERULE_Reporting.equals(m_tableAccess[i].getAccessTypeRule()))
				continue;
			if (m_tableAccess[i].isExclude())		//	Exclude
			{
				if (m_tableAccess[i].getAD_Table_ID() == AD_Table_ID)
				{
					if (log.isLoggable(Level.FINE)) log.fine("Exclude " + AD_Table_ID);
					return false;
				}
			}
			else									//	Include
			{
				//positive list, can report ONLY on included tables
				canReport = false;
				if (m_tableAccess[i].getAD_Table_ID() == AD_Table_ID)
				{
					if (log.isLoggable(Level.FINE)) log.fine("Include " + AD_Table_ID);
					return true;
				}
			}
		}	//	for all Table Access
		if (log.isLoggable(Level.FINE)) log.fine(AD_Table_ID + " - " + canReport);
		return canReport;
	}	//	isCanReport
	
	/**
	 * 	Can Export Table
	 *	@param AD_Table_ID
	 *	@return true if can export
	 */
	public boolean isCanExport (int AD_Table_ID)
	{
		if (!isCanExport())						//	Role Level block
		{
			if (log.isLoggable(Level.FINE)) log.fine ("Role denied (" + MRole.getDefaultRole().getAD_Role_ID() + ") tableID=" + AD_Table_ID);
			return false;
		}
		if (!isTableAccess(AD_Table_ID, true))	//	No R/O Access to Table
			return false;
		if (!isCanReport (AD_Table_ID))			//	We cannot Export if we cannot report
			return false;
		
		//default to negative list, can report on all tables
		boolean canExport = true;
		for (int i = 0; i < m_tableAccess.length; i++)
		{
			if (!X_AD_Table_Access.ACCESSTYPERULE_Exporting.equals(m_tableAccess[i].getAccessTypeRule()))
				continue;
			if (m_tableAccess[i].isExclude())		//	Exclude
			{
				if (m_tableAccess[i].getAD_Table_ID() == AD_Table_ID)
				{
					if (log.isLoggable(Level.FINE)) log.fine("Exclude " + AD_Table_ID);
					return false;
				}
			}
			else									//	Include
			{
				//positive list, can export ONLY on included tables
				canExport = false;
				if (m_tableAccess[i].getAD_Table_ID() == AD_Table_ID)
				{
					if (log.isLoggable(Level.FINE)) log.fine("Include " + AD_Table_ID);
					return true;
				}
			}
		}	//	for all Table Access
		if (log.isLoggable(Level.FINE)) log.fine(AD_Table_ID + " - " + canExport);
		return canExport;
	}	//	isCanExport

	/**
	 * 	Access to Table
	 *	@param AD_Table_ID table
	 *	@param ro check read only access otherwise read write access level
	 *	@return true if has RO/RW access to table
	 */
	public boolean isTableAccess (int AD_Table_ID, boolean ro)
	{
		if (!isTableAccessLevel (AD_Table_ID, ro))	//	Role Based Access
			return false;
		loadTableAccess(false);
		
		//default to negative list, can access on all tables
		boolean hasAccess = true;	//	assuming exclusive rule
		for (int i = 0; i < m_tableAccess.length; i++)
		{
			if (!X_AD_Table_Access.ACCESSTYPERULE_Accessing.equals(m_tableAccess[i].getAccessTypeRule()))
				continue;
			if (m_tableAccess[i].isExclude())		//	Exclude
			//	If you Exclude Access to a table and select Read Only, 
			//	you can only read data (otherwise no access).
			{
				if (m_tableAccess[i].getAD_Table_ID() == AD_Table_ID)
				{
					if (ro)
						hasAccess = m_tableAccess[i].isReadOnly();
					else
						hasAccess = false;
					if (log.isLoggable(Level.FINE)) log.fine("Exclude AD_Table_ID=" + AD_Table_ID 
						+ " (ro="  + ro + ",TableAccessRO=" + m_tableAccess[i].isReadOnly() + ") = " + hasAccess);
					return hasAccess;
				}
			}
			else								//	Include
			//	If you Include Access to a table and select Read Only, 
			//	you can only read data (otherwise full access).
			{
				//positive list, can access ONLY on included tables
				hasAccess = false;
				if (m_tableAccess[i].getAD_Table_ID() == AD_Table_ID)
				{
					if (!ro)	//	rw only if not r/o
						hasAccess = !m_tableAccess[i].isReadOnly();
					else
						hasAccess = true;
					if (log.isLoggable(Level.FINE)) log.fine("Include AD_Table_ID=" + AD_Table_ID 
						+ " (ro="  + ro + ",TableAccessRO=" + m_tableAccess[i].isReadOnly() + ") = " + hasAccess);
					return hasAccess;
				}
			}
		}	//	for all Table Access
		if (!hasAccess)
			if (log.isLoggable(Level.FINE)) log.fine("AD_Table_ID=" + AD_Table_ID 
				+ "(ro="  + ro + ") = " + hasAccess);
		return hasAccess;
	}	//	isTableAccess

	/**
	 * 	Access to Table based on User Level and Table Access Level
	 *	@param AD_Table_ID table
	 *	@param ro check read only access otherwise read write access level
	 *	@return true if has RO/RW access to table
	 */
	public boolean isTableAccessLevel (int AD_Table_ID, boolean ro)
	{
		if (ro)				//	role can always read
			return true;
		//	AccessLevel
		//		1 = Org - 2 = Client - 4 = System
		//		3 = Org+Client - 6 = Client+System - 7 = All
		MTable table = MTable.get(AD_Table_ID);
		if (table == null) {
			log.warning("No Table Found with AD_Table_ID=" + AD_Table_ID);
			return false;
		}
		String tableAccessLevel = table.getAccessLevel();
		if (tableAccessLevel == null)
		{
			if (log.isLoggable(Level.FINE)) log.fine("NO - No AccessLevel - AD_Table_ID=" + AD_Table_ID);
			return false;
		}
		//	Access to all User Levels
		if (tableAccessLevel.equals(X_AD_Table.ACCESSLEVEL_All))
			return true;
		//	User Level = SCO
		String userLevel = getUserLevel();
		//	
		if (userLevel.charAt(0) == 'S'
			&& (tableAccessLevel.equals(X_AD_Table.ACCESSLEVEL_SystemOnly) 
				|| tableAccessLevel.equals(X_AD_Table.ACCESSLEVEL_SystemPlusClient)))
			return true;
		if (userLevel.charAt(1) == 'C'
			&& (tableAccessLevel.equals(X_AD_Table.ACCESSLEVEL_ClientOnly) 
				|| tableAccessLevel.equals(X_AD_Table.ACCESSLEVEL_SystemPlusClient)))
			return true;
		if (userLevel.charAt(2) == 'O'
			&& (tableAccessLevel.equals(X_AD_Table.ACCESSLEVEL_Organization) 
				|| tableAccessLevel.equals(X_AD_Table.ACCESSLEVEL_ClientPlusOrganization)))
			return true;
		if (log.isLoggable(Level.FINE)) log.fine("NO - AD_Table_ID=" + AD_Table_ID 
			+ ", UserLevel=" + userLevel + ", AccessLevel=" + tableAccessLevel);
		return false;
	}	//	isTableAccessLevel

	/**
	 * 	Access to Column
	 *	@param AD_Table_ID table
	 *	@param AD_Column_ID column
	 *	@param ro true for read only, false for read write
	 *	@return true if can access
	 */
	public boolean isColumnAccess (int AD_Table_ID, int AD_Column_ID, boolean ro)
	{
		return isColumnAccess(AD_Table_ID, AD_Column_ID, ro, null);
	}

	/**
	 * 	Access to Column
	 *	@param AD_Table_ID table
	 *	@param AD_Column_ID column
	 *	@param ro true for read only, false for read write
	 *  @param trxName
	 *	@return true if can access
	 */
	public boolean isColumnAccess (int AD_Table_ID, int AD_Column_ID, boolean ro, String trxName)
	{
		if (!isTableAccess(AD_Table_ID, ro))		//	No Access to Table		
			return false;
		loadColumnAccess(false);

		MColumn column = MColumn.get(Env.getCtx(), AD_Column_ID, trxName);
		if (column.getAD_Reference_ID() == DisplayType.Button) {
			if (column.getAD_Process_ID() > 0)
			{
				// Verify access to process for buttons
				Boolean access = MRole.getDefault().getProcessAccess(column.getAD_Process_ID());
				if (access == null)
					return false;
			}
			else if (column.getAD_InfoWindow_ID() > 0)
			{
				// Verify access to info window for buttons
				Boolean access = MRole.getDefault().getInfoAccess(column.getAD_InfoWindow_ID());
				if (access == null)
					return false;
			}
		}

		boolean retValue = true;		//	assuming exclusive
		for (int i = 0; i < m_columnAccess.length; i++)
		{
			if (m_columnAccess[i].isExclude())		//	Exclude
			//	If you Exclude Access to a column and select Read Only, 
			//	you can only read data (otherwise no access).
			{
				if (m_columnAccess[i].getAD_Table_ID() == AD_Table_ID 
					&& m_columnAccess[i].getAD_Column_ID() == AD_Column_ID)
				{
					if (ro)		//	just R/O Access requested
						retValue = m_columnAccess[i].isReadOnly();
					else
						retValue = false;
					if (!retValue)
						if (log.isLoggable(Level.FINE)) log.fine("Exclude AD_Table_ID=" + AD_Table_ID + ", AD_Column_ID=" + AD_Column_ID 
							+ " (ro="  + ro + ",ColumnAccessRO=" + m_columnAccess[i].isReadOnly() + ") = " + retValue);
					return retValue;
				}
			}
			else								//	Include
			//	If you Include Access to a column and select Read Only, 
			//	you can only read data (otherwise full access).
			{
				if (m_columnAccess[i].getAD_Table_ID() == AD_Table_ID)
				{
					retValue = false;
					if (m_columnAccess[i].getAD_Column_ID() == AD_Column_ID)
					{
						if (!ro)	//	rw only if not r/o
							retValue = !m_columnAccess[i].isReadOnly();
						else
							retValue = true;
						if (!retValue)
							if (log.isLoggable(Level.FINE)) log.fine("Include AD_Table_ID=" + AD_Table_ID + ", AD_Column_ID=" + AD_Column_ID 
								+ " (ro="  + ro + ",ColumnAccessRO=" + m_columnAccess[i].isReadOnly() + ") = " + retValue);
						return retValue;
					}
				}	//	same table
			}	//	include
		}	//	for all Table Access
		if (!retValue)
			if (log.isLoggable(Level.FINE)) log.fine("AD_Table_ID=" + AD_Table_ID + ", AD_Column_ID=" + AD_Column_ID 
				+ " (ro="  + ro + ") = " + retValue);
		return retValue;
	}	//	isColumnAccess

	/**
	 *	Access to Record (AD_Record_Access)
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param ro true for read only, false for read write
	 *	@return true if can access
	 */
	public boolean isRecordAccess (int AD_Table_ID, int Record_ID, boolean ro)
	{
		loadRecordAccess(false);
		boolean negativeList = true;
		for (int i = 0; i < m_recordAccess.length; i++)
		{
			MRecordAccess ra = m_recordAccess[i];
			if (ra.getAD_Table_ID() != AD_Table_ID)
				continue;
				
			if (ra.isExclude())		//	Exclude
			//	If you Exclude Access to a column and select Read Only, 
			//	you can only read data (otherwise no access).
			{
				if (ra.getRecord_ID() == Record_ID)
				{
					if (ro)
						return ra.isReadOnly();
					else
						return false;
				}
			}
			else								//	Include
			//	If you Include Access to a column and select Read Only, 
			//	you can only read data (otherwise full access).
			{
				negativeList = false;	//	has to be defined
				if (ra.getRecord_ID() == Record_ID)
				{
					if (!ro)
						return !ra.isReadOnly();
					else	//	ro
						return true;
				}
			}
		}	//	for all Table Access
		return negativeList;
	}	//	isRecordAccess

	/**
	 * 	Get Window Access (AD_Window_Access).<br/>
	 *  Check ASP record as well if client is using ASP access control.
	 *	@param AD_Window_ID window
	 *	@return null if can't access, TRUE if r/w and FALSE if r/o
	 */
	public synchronized Boolean getWindowAccess (int AD_Window_ID)
	{
		if (m_windowAccess == null)
		{
			m_windowAccess = new HashMap<Integer,Boolean>(100);
			// first get the window access from the included and substitute roles
			mergeIncludedAccess("m_windowAccess"); // Load included accesses - metas-2009_0021_AP1_G94
			// and now get the window access directly from this role
			MClient client = MClient.get(Env.getCtx());
			String ASPFilter = "";
			if (client.isUseASP())
				ASPFilter =
					  "   AND (   AD_Window_ID IN ( "
					// Just ASP subscribed windows for client "
					+ "              SELECT w.AD_Window_ID "
					+ "                FROM ASP_Window w, ASP_Level l, ASP_ClientLevel cl "
					+ "               WHERE w.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND cl.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND w.IsActive = 'Y' "
					+ "                 AND l.IsActive = 'Y' "
					+ "                 AND cl.IsActive = 'Y' "
					+ "                 AND w.ASP_Status = 'S') " // Show
					+ "        OR AD_Window_ID IN ( "
					// + show ASP exceptions for client
					+ "              SELECT AD_Window_ID "
					+ "                FROM ASP_ClientException ce "
					+ "               WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND ce.IsActive = 'Y' "
					+ "                 AND ce.AD_Window_ID IS NOT NULL "
					+ "                 AND ce.AD_Tab_ID IS NULL "
					+ "                 AND ce.AD_Field_ID IS NULL "
					+ "                 AND ce.ASP_Status = 'S') " // Show
					+ "       ) "
					+ "   AND AD_Window_ID NOT IN ( "
					// minus hide ASP exceptions for client
					+ "          SELECT AD_Window_ID "
					+ "            FROM ASP_ClientException ce "
					+ "           WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "             AND ce.IsActive = 'Y' "
					+ "             AND ce.AD_Window_ID IS NOT NULL "
					+ "             AND ce.AD_Tab_ID IS NULL "
					+ "             AND ce.AD_Field_ID IS NULL "
					+ "             AND ce.ASP_Status = 'H')"; // Hide
			String sql = "SELECT AD_Window_ID, IsReadWrite, IsActive FROM AD_Window_Access WHERE AD_Role_ID=?" + ASPFilter;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			HashMap<Integer,Boolean> directAccess = new HashMap<Integer,Boolean>(100);
			try
			{
				pstmt = DB.prepareStatement(sql, get_TrxName());
				pstmt.setInt(1, getAD_Role_ID());
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer winId = Integer.valueOf(rs.getInt(1));
					if ("N".equals(rs.getString(3))) {
						// inactive window on direct access
						if (m_windowAccess.containsKey(winId)) {
							m_windowAccess.remove(winId);
						}
					} else {
						directAccess.put(winId, Boolean.valueOf("Y".equals(rs.getString(2))));
					}
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
			}
			//
			setAccessMap("m_windowAccess", mergeAccess(getAccessMap("m_windowAccess"), directAccess, true));
			if (log.isLoggable(Level.FINE)) log.fine("#" + m_windowAccess.size());
		}	//	reload
		Boolean retValue = m_windowAccess.get(AD_Window_ID);
		// User Preference window is excluded - otherwise the user would not be able to reset the read-only session preference
		if (retValue != null && AD_Window_ID != SystemIDs.WINDOW_USER_PREFERENCE && Env.isReadOnlySession())
			retValue = Boolean.FALSE;
		if (log.isLoggable(Level.FINE)) log.fine("getWindowAccess - AD_Window_ID=" + AD_Window_ID + " - " + retValue);
		return retValue;
	}	//	getWindowAccess

	/**
	 * 	Get Process Access (AD_Process_Access).
	 *  Check ASP record as well if client is using ASP access control.
	 *	@param AD_Process_ID process
	 *	@return null if can't access, TRUE if r/w and FALSE if r/o
	 */
	public synchronized Boolean getProcessAccess (int AD_Process_ID)
	{
		if (m_processAccess == null)
		{
			m_processAccess = new HashMap<Integer,Boolean>(50);
			// first get the process access from the included and substitute roles
			mergeIncludedAccess("m_processAccess"); // Load included accesses - metas-2009_0021_AP1_G94
			// and now get the process access directly from this role
			MClient client = MClient.get(Env.getCtx());
			String ASPFilter = "";
			if (client.isUseASP())
				ASPFilter =
					  "   AND (   AD_Process_ID IN ( "
					// Just ASP subscribed processes for client "
					+ "              SELECT p.AD_Process_ID "
					+ "                FROM ASP_Process p, ASP_Level l, ASP_ClientLevel cl "
					+ "               WHERE p.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND cl.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND p.IsActive = 'Y' "
					+ "                 AND l.IsActive = 'Y' "
					+ "                 AND cl.IsActive = 'Y' "
					+ "                 AND p.ASP_Status = 'S') " // Show
					+ "        OR AD_Process_ID IN ( "
					// + show ASP exceptions for client
					+ "              SELECT AD_Process_ID "
					+ "                FROM ASP_ClientException ce "
					+ "               WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND ce.IsActive = 'Y' "
					+ "                 AND ce.AD_Process_ID IS NOT NULL "
					+ "                 AND ce.AD_Process_Para_ID IS NULL "
					+ "                 AND ce.ASP_Status = 'S') " // Show
					+ "       ) "
					+ "   AND AD_Process_ID NOT IN ( "
					// minus hide ASP exceptions for client
					+ "          SELECT AD_Process_ID "
					+ "            FROM ASP_ClientException ce "
					+ "           WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "             AND ce.IsActive = 'Y' "
					+ "             AND ce.AD_Process_ID IS NOT NULL "
					+ "             AND ce.AD_Process_Para_ID IS NULL "
					+ "             AND ce.ASP_Status = 'H')"; // Hide
			String noReportsFilter = "";
			if (! MRole.getDefault().isCanReport())
				noReportsFilter = " AND AD_Process_ID NOT IN (SELECT p.AD_Process_ID FROM AD_Process p WHERE IsReport='Y')";
			String sql = "SELECT AD_Process_ID, IsReadWrite, IsActive FROM AD_Process_Access WHERE AD_Role_ID=?" + ASPFilter + noReportsFilter;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			HashMap<Integer,Boolean> directAccess = new HashMap<Integer,Boolean>(100);
			try
			{
				pstmt = DB.prepareStatement(sql, get_TrxName());
				pstmt.setInt(1, getAD_Role_ID());
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer procId = Integer.valueOf(rs.getInt(1));
					if ("N".equals(rs.getString(3))) {
						// inactive process on direct access
						if (m_processAccess.containsKey(procId)) {
							m_processAccess.remove(procId);
						}
					} else {
						directAccess.put(procId, Boolean.valueOf("Y".equals(rs.getString(2))));
					}
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
			}
			setAccessMap("m_processAccess", mergeAccess(getAccessMap("m_processAccess"), directAccess, true));
		}	//	reload
		Boolean retValue = m_processAccess.get(AD_Process_ID);
		if (retValue != null && retValue.booleanValue()) {
			MProcess process = MProcess.get(getCtx(), AD_Process_ID);
			if (! isAccessLevelCompatible(process.getAccessLevel())) {
				log.warning("Role " + getName() + " has assigned access incompatible process " + process.getName());
				m_processAccess.remove(AD_Process_ID);
				retValue = null;
			}
		}
		if (retValue != null && Env.isReadOnlySession())
			retValue = Boolean.FALSE;
		return retValue;
	}	//	getProcessAccess

	/**
	 * 	Get Task Access (AD_Task_Access). <br/>
	 *  Check ASP record as well if client is using ASP access control.
	 *	@param AD_Task_ID task
	 *	@return null if can't access, TRUE if r/w and FALSE if r/o
	 */
	public synchronized Boolean getTaskAccess (int AD_Task_ID)
	{
		if (m_taskAccess == null)
		{
			m_taskAccess = new HashMap<Integer,Boolean>(10);
			// first get the task access from the included and substitute roles
			mergeIncludedAccess("m_taskAccess"); // Load included accesses - metas-2009_0021_AP1_G94
			// and now get the task access directly from this role
			MClient client = MClient.get(Env.getCtx());
			String ASPFilter = "";
			if (client.isUseASP())
				ASPFilter =
					  "   AND (   AD_Task_ID IN ( "
					// Just ASP subscribed tasks for client "
					+ "              SELECT t.AD_Task_ID "
					+ "                FROM ASP_Task t, ASP_Level l, ASP_ClientLevel cl "
					+ "               WHERE t.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND cl.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND t.IsActive = 'Y' "
					+ "                 AND l.IsActive = 'Y' "
					+ "                 AND cl.IsActive = 'Y' "
					+ "                 AND t.ASP_Status = 'S') " // Show
					+ "        OR AD_Task_ID IN ( "
					// + show ASP exceptions for client
					+ "              SELECT AD_Task_ID "
					+ "                FROM ASP_ClientException ce "
					+ "               WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND ce.IsActive = 'Y' "
					+ "                 AND ce.AD_Task_ID IS NOT NULL "
					+ "                 AND ce.ASP_Status = 'S') " // Show
					+ "       ) "
					+ "   AND AD_Task_ID NOT IN ( "
					// minus hide ASP exceptions for client
					+ "          SELECT AD_Task_ID "
					+ "            FROM ASP_ClientException ce "
					+ "           WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "             AND ce.IsActive = 'Y' "
					+ "             AND ce.AD_Task_ID IS NOT NULL "
					+ "             AND ce.ASP_Status = 'H')"; // Hide
			String sql = "SELECT AD_Task_ID, IsReadWrite, IsActive FROM AD_Task_Access WHERE AD_Role_ID=?" + ASPFilter;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			HashMap<Integer,Boolean> directAccess = new HashMap<Integer,Boolean>(100);
			try
			{
				pstmt = DB.prepareStatement(sql, get_TrxName());
				pstmt.setInt(1, getAD_Role_ID());
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer taskId = Integer.valueOf(rs.getInt(1));
					if ("N".equals(rs.getString(3))) {
						// inactive task on direct access
						if (m_taskAccess.containsKey(taskId)) {
							m_taskAccess.remove(taskId);
						}
					} else {
						directAccess.put(taskId, Boolean.valueOf("Y".equals(rs.getString(2))));
					}
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
			}
			setAccessMap("m_taskAccess", mergeAccess(getAccessMap("m_taskAccess"), directAccess, true));
		}	//	reload
		Boolean retValue = m_taskAccess.get(AD_Task_ID);
		if (retValue != null && retValue.booleanValue()) {
			MTask task = new MTask(getCtx(), AD_Task_ID, get_TrxName());
			if (! isAccessLevelCompatible(task.getAccessLevel())) {
				log.warning("Role " + getName() + " has assigned access incompatible task " + task.getName());
				m_taskAccess.remove(AD_Task_ID);
				retValue = null;
			}
		}
		if (retValue != null && Env.isReadOnlySession())
			retValue = Boolean.FALSE;
		return retValue;
	}	//	getTaskAccess

	/**
	 * 	Get Form Access (AD_Form_Access).<br/>
	 *  Check ASP record as well if client is using ASP access control.
	 *	@param AD_Form_ID form
	 *	@return null if can't access, TRUE if r/w and FALSE if r/o
	 */
	public synchronized Boolean getFormAccess (int AD_Form_ID)
	{
		if (m_formAccess == null)
		{
			m_formAccess = new HashMap<Integer,Boolean>(20);
			// first get the form access from the included and substitute roles
			mergeIncludedAccess("m_formAccess"); // Load included accesses - metas-2009_0021_AP1_G94
			// and now get the form access directly from this role
			MClient client = MClient.get(Env.getCtx());
			String ASPFilter = "";
			if (client.isUseASP())
				ASPFilter =
					  "   AND (   AD_Form_ID IN ( "
					// Just ASP subscribed forms for client "
					+ "              SELECT f.AD_Form_ID "
					+ "                FROM ASP_Form f, ASP_Level l, ASP_ClientLevel cl "
					+ "               WHERE f.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND cl.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND f.IsActive = 'Y' "
					+ "                 AND l.IsActive = 'Y' "
					+ "                 AND cl.IsActive = 'Y' "
					+ "                 AND f.ASP_Status = 'S') " // Show
					+ "        OR AD_Form_ID IN ( "
					// + show ASP exceptions for client
					+ "              SELECT AD_Form_ID "
					+ "                FROM ASP_ClientException ce "
					+ "               WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND ce.IsActive = 'Y' "
					+ "                 AND ce.AD_Form_ID IS NOT NULL "
					+ "                 AND ce.ASP_Status = 'S') " // Show
					+ "       ) "
					+ "   AND AD_Form_ID NOT IN ( "
					// minus hide ASP exceptions for client
					+ "          SELECT AD_Form_ID "
					+ "            FROM ASP_ClientException ce "
					+ "           WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "             AND ce.IsActive = 'Y' "
					+ "             AND ce.AD_Form_ID IS NOT NULL "
					+ "             AND ce.ASP_Status = 'H')"; // Hide
			String sql = "SELECT AD_Form_ID, IsReadWrite, IsActive FROM AD_Form_Access WHERE AD_Role_ID=?" + ASPFilter;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			HashMap<Integer,Boolean> directAccess = new HashMap<Integer,Boolean>(100);
			try
			{
				pstmt = DB.prepareStatement(sql, get_TrxName());
				pstmt.setInt(1, getAD_Role_ID());
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer formId = Integer.valueOf(rs.getInt(1));
					if ("N".equals(rs.getString(3))) {
						// inactive form on direct access
						if (m_formAccess.containsKey(formId)) {
							m_formAccess.remove(formId);
						}
					} else {
						if ( ! (formId == SystemIDs.FORM_ARCHIVEVIEWER && !MRole.getDefault().isCanReport()) )
							directAccess.put(formId, Boolean.valueOf("Y".equals(rs.getString(2))));
					}
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
			}
			setAccessMap("m_formAccess", mergeAccess(getAccessMap("m_formAccess"), directAccess, true));
		}	//	reload
		Boolean retValue = m_formAccess.get(AD_Form_ID);
		if (retValue != null && retValue.booleanValue()) {
			MForm form = new MForm(getCtx(), AD_Form_ID, get_TrxName());
			if (! isAccessLevelCompatible(form.getAccessLevel())) {
				log.warning("Role " + getName() + " has assigned access incompatible form " + form.getName());
				m_formAccess.remove(AD_Form_ID);
				retValue = null;
			}
		}
		if (retValue != null && Env.isReadOnlySession())
			retValue = Boolean.FALSE;
		return retValue;
	}	//	getFormAccess

	/**
	 * 	Get Workflow Access (AD_Workflow_Access).<br/>
	 *  Check ASP record as well if client is using ASP access control.
	 *	@param AD_Workflow_ID workflow
	 *	@return null if can't access, TRUE if r/w and FALSE if r/o
	 */
	public synchronized Boolean getWorkflowAccess (int AD_Workflow_ID)
	{
		if (m_workflowAccess == null)
		{
			m_workflowAccess = new HashMap<Integer,Boolean>(20);
			// first get the workflow access from the included and substitute roles
			mergeIncludedAccess("m_workflowAccess"); // Load included accesses - metas-2009_0021_AP1_G94
			// and now get the workflow access directly from this role
			MClient client = MClient.get(Env.getCtx());
			String ASPFilter = "";
			if (client.isUseASP())
				ASPFilter =
					  "   AND (   AD_Workflow_ID IN ( "
					// Just ASP subscribed workflows for client "
					+ "              SELECT w.AD_Workflow_ID "
					+ "                FROM ASP_Workflow w, ASP_Level l, ASP_ClientLevel cl "
					+ "               WHERE w.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND cl.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND w.IsActive = 'Y' "
					+ "                 AND l.IsActive = 'Y' "
					+ "                 AND cl.IsActive = 'Y' "
					+ "                 AND w.ASP_Status = 'S') " // Show
					+ "        OR AD_Workflow_ID IN ( "
					// + show ASP exceptions for client
					+ "              SELECT AD_Workflow_ID "
					+ "                FROM ASP_ClientException ce "
					+ "               WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "                 AND ce.IsActive = 'Y' "
					+ "                 AND ce.AD_Workflow_ID IS NOT NULL "
					+ "                 AND ce.ASP_Status = 'S') " // Show
					+ "       ) "
					+ "   AND AD_Workflow_ID NOT IN ( "
					// minus hide ASP exceptions for client
					+ "          SELECT AD_Workflow_ID "
					+ "            FROM ASP_ClientException ce "
					+ "           WHERE ce.AD_Client_ID = " + client.getAD_Client_ID()
					+ "             AND ce.IsActive = 'Y' "
					+ "             AND ce.AD_Workflow_ID IS NOT NULL "
					+ "             AND ce.ASP_Status = 'H')"; // Hide
			String sql = "SELECT AD_Workflow_ID, IsReadWrite, IsActive FROM AD_Workflow_Access WHERE AD_Role_ID=?" + ASPFilter;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			HashMap<Integer,Boolean> directAccess = new HashMap<Integer,Boolean>(100);
			try
			{
				pstmt = DB.prepareStatement(sql, get_TrxName());
				pstmt.setInt(1, getAD_Role_ID());
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer formId = Integer.valueOf(rs.getInt(1));
					if ("N".equals(rs.getString(3))) {
						// inactive workflow on direct access
						if (m_workflowAccess.containsKey(formId)) {
							m_workflowAccess.remove(formId);
						}
					} else {
						directAccess.put(formId, Boolean.valueOf("Y".equals(rs.getString(2))));
					}
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
			}
			setAccessMap("m_workflowAccess", mergeAccess(getAccessMap("m_workflowAccess"), directAccess, true));
		}	//	reload
		Boolean retValue = m_workflowAccess.get(AD_Workflow_ID);
		if (retValue != null && retValue.booleanValue()) {
			MWorkflow workflow = MWorkflow.get(getCtx(), AD_Workflow_ID);
			if (! isAccessLevelCompatible(workflow.getAccessLevel())) {
				log.warning("Role " + getName() + " has assigned access incompatible workflow " + workflow.getName());
				m_workflowAccess.remove(AD_Workflow_ID);
				retValue = null;
			}
		}
		if (retValue != null && Env.isReadOnlySession())
			retValue = Boolean.FALSE;
		return retValue;
	}	//	getWorkflowAccess
	
	/**
	 *	Appends access where clause to SQL statement for Tables
	 *
	 *	@param SQL			existing SQL statement
	 *	@param TableNameIn	Table Name or list of table names AAA, BBB or AAA a, BBB b
	 *	@param fullyQualified	fullyQualified column name
	 *	@param rw			if false, includes records belongs to System client (AD_Client_ID=0).
	 *	@return	updated SQL statement
	 */
	public String addAccessSQL (String SQL, String TableNameIn, 
		boolean fullyQualified, boolean rw)
	{
		StringBuilder retSQL = new StringBuilder();

		//	Cut off last ORDER BY clause
		String orderBy = "";
		int posOrder = SQL.lastIndexOf(" ORDER BY ");
		if (posOrder != -1)
		{
			orderBy = SQL.substring(posOrder);
			retSQL.append(SQL.substring(0, posOrder));
		}
		else
			retSQL.append(SQL);

		//	Parse SQL
		AccessSqlParser asp = new AccessSqlParser(retSQL.toString());
		AccessSqlParser.TableInfo[] ti = asp.getTableInfo(asp.getMainSqlIndex()); 

		//  Do we have to add WHERE or AND
		if (asp.getMainSql().indexOf(" WHERE ") == -1)
			retSQL.append(" WHERE ");
		else
			retSQL.append(" AND ");

		//	Use First Table
		String tableName = "";
		if (ti.length > 0)
		{
			tableName = ti[0].getSynonym();
			if (tableName.length() == 0)
				tableName = ti[0].getTableName();
		}
		if (TableNameIn != null && !tableName.equals(TableNameIn))
		{
			String msg = "TableName not correctly parsed - TableNameIn=" 
				+ TableNameIn + " - " + asp;
			if (ti.length > 0)
				msg += " - #1 " + ti[0]; 
			msg += "\n = " + SQL;
			log.log(Level.SEVERE, msg);
			Trace.printStack();
			tableName = TableNameIn;
		}

		if (! tableName.equals(X_AD_PInstance_Log.Table_Name)) { // globalqss, bug 1662433 
			//	Client Access
			if (fullyQualified)
				retSQL.append(tableName).append(".");
			retSQL.append(getClientWhere(rw));

			//	Org Access
			if (!isAccessAllOrgs())
			{
				retSQL.append(" AND ");
				String orgWhere = getOrgWhere(rw);
				if (fullyQualified)
					orgWhere = orgWhere.replace("AD_Org_ID", tableName + ".AD_Org_ID");
				retSQL.append(orgWhere);
			}
		} else {
			retSQL.append("1=1");
		}
		
		//	** Data Access	**
		for (int i = 0; i < ti.length; i++)
		{
			String TableName = ti[i].getTableName();
			
			//[ 1644310 ] Rev. 1292 hangs on start
			if (TableName.toUpperCase().endsWith("_TRL")) continue;
			if (isView(TableName)) continue;
			
			int AD_Table_ID = getAD_Table_ID (TableName);
			//	Data Table Access
			if (AD_Table_ID != 0 && !isTableAccess(AD_Table_ID, !rw))
			{
				retSQL.append(" AND 1=3");	//	prevent access at all
				if (log.isLoggable(Level.FINE)) log.fine("No access to AD_Table_ID=" + AD_Table_ID 
					+ " - " + TableName + " - " + retSQL);
				break;	//	no need to check further 
			}
			
			//	Data Column Access
	
	
		
			//	Data Record Access
			String keyColumnName = "";
			if (fullyQualified)
			{
				keyColumnName = ti[i].getSynonym();	//	table synonym
				if (keyColumnName.length() == 0)
					keyColumnName = TableName;
				keyColumnName += ".";
			}

			if (getIdColumnName(TableName) == null) continue;
			keyColumnName += getIdColumnName(TableName); 
	
			//log.fine("addAccessSQL - " + TableName + "(" + AD_Table_ID + ") " + keyColumnName);
			String recordWhere = getRecordWhere (AD_Table_ID, keyColumnName, rw, TableName, ti[i].getSynonym());
			if (recordWhere.length() > 0)
			{
				retSQL.append(" AND ").append(recordWhere);
				if (log.isLoggable(Level.FINEST)) log.finest("Record access - " + recordWhere);
			}
		}	//	for all table info
		
		//	Dependent Records (only for main SQL)
		String mainSql = asp.getMainSql();
		loadRecordAccess(false);
		int AD_Table_ID = 0;
		String whereColumnName = null;
		ArrayList<Integer> includes = new ArrayList<Integer>();
		ArrayList<Integer> excludes = new ArrayList<Integer>();
		for (int i = 0; i < m_recordDependentAccess.length; i++)
		{
			String columnName = m_recordDependentAccess[i].getKeyColumnName
				(asp.getTableInfo(asp.getMainSqlIndex()) );
			if (columnName == null)
				continue;	//	no key column
			
			if (mainSql.toUpperCase().startsWith("SELECT COUNT(*) FROM ")) {
				// globalqss - Carlos Ruiz - [ 1965744 ] Dependent entities access problem
				// this is the count select, it doesn't have the column but needs to be filtered
				 MTable table = MTable.get(getCtx(), tableName);
				 if (table == null)
					 continue;
				 MColumn column = table.getColumn(columnName);
				 if (column == null || column.isVirtualColumn() || !column.isActive())
					 continue;
			} else {
				int posColumn = mainSql.indexOf(columnName);
				if (posColumn == -1)
					continue;
				//	we found the column name - make sure it's a column name
				char charCheck = mainSql.charAt(posColumn-1);	//	before
				if (!(charCheck == ',' || charCheck == '.' || charCheck == ' ' || charCheck == '('))
					continue;
				charCheck = mainSql.charAt(posColumn+columnName.length());	//	after
				if (!(charCheck == ',' || charCheck == ' ' || charCheck == ')'))
					continue;
			}
			
			if (AD_Table_ID != 0 && AD_Table_ID != m_recordDependentAccess[i].getAD_Table_ID())
				retSQL.append(getDependentAccess(whereColumnName, includes, excludes));
			
			AD_Table_ID = m_recordDependentAccess[i].getAD_Table_ID();
			//	*** we found the column in the main query
			if (m_recordDependentAccess[i].isExclude())
			{
				excludes.add(m_recordDependentAccess[i].getRecord_ID());
				if (log.isLoggable(Level.FINE)) log.fine("Exclude " + columnName + " - " + m_recordDependentAccess[i]);
			}
			else if (!rw || !m_recordDependentAccess[i].isReadOnly())
			{
				includes.add(m_recordDependentAccess[i].getRecord_ID());
				if (log.isLoggable(Level.FINE)) log.fine("Include " + columnName + " - " + m_recordDependentAccess[i]);
			}
			whereColumnName = getDependentRecordWhereColumn (mainSql, columnName);
		}	//	for all dependent records
		retSQL.append(getDependentAccess(whereColumnName, includes, excludes));
		//
		retSQL.append(orderBy);
		if (log.isLoggable(Level.FINEST)) log.finest(retSQL.toString());
		return retSQL.toString();
	}	//	addAccessSQL

	/**
	 * 	Get Dependent Access 
	 *	@param whereColumnName column name for includes and excludes id
	 *	@param includes record ids to include
	 *	@param excludes record ids to exclude
	 *	@return where clause starting with AND or ""
	 */
	private String getDependentAccess(String whereColumnName,
		ArrayList<Integer> includes, ArrayList<Integer> excludes)
	{
		if (includes.size() == 0 && excludes.size() == 0)
			return "";
		if (includes.size() != 0 && excludes.size() != 0)
			log.warning("Mixing Include and Exclude rules - Will not return values");
		
		StringBuilder where = new StringBuilder(" AND ");
		if (includes.size() == 1)
			where.append(whereColumnName).append("=").append(includes.get(0));
		else if (includes.size() > 1)
		{
			where.append(whereColumnName).append(" IN (");
			for (int ii = 0; ii < includes.size(); ii++)
			{
				if (ii > 0)
					where.append(",");
				where.append(includes.get(ii));
			}
			where.append(")");
		}
		else if (excludes.size() == 1)
		{
			where.append("(" + whereColumnName + " IS NULL OR ");
			where.append(whereColumnName).append("<>").append(excludes.get(0)).append(")");
		}
		else if (excludes.size() > 1)
		{
			where.append("(" + whereColumnName + " IS NULL OR ");
			where.append(whereColumnName).append(" NOT IN (");
			for (int ii = 0; ii < excludes.size(); ii++)
			{
				if (ii > 0)
					where.append(",");
				where.append(excludes.get(ii));
			}
			where.append("))");
		}
		if (log.isLoggable(Level.FINEST)) log.finest(where.toString());
		return where.toString();
	}	//	getDependentAccess	
	
	/**
	 * 	Get column name for dependent record where clause 
	 *	@param mainSql sql to examine
	 *	@param columnName 
	 *	@return original or updated column name (e.g "x.columnName")
	 */
	private String getDependentRecordWhereColumn (String mainSql, String columnName)
	{
		String retValue = columnName;	//	if nothing else found
		int index = mainSql.indexOf(columnName);
		if (index == -1)
			return retValue;
		//	see if there are table synonym
		int offset = index - 1;
		char c = mainSql.charAt(offset);
		if (c == '.')
		{
			StringBuilder sb = new StringBuilder();
			while (c != ' ' && c != ',' && c != '(')	//	delimiter
			{
				sb.insert(0, c);
				c = mainSql.charAt(--offset);
			}
			sb.append(columnName);
			return sb.toString();
		}
		return retValue;
	}	//	getDependentRecordWhereColumn

	/**
	 * Check update access.
	 * Access error info (AccessTableNoUpdate) is saved in the log
	 * 
	 * @param AD_Client_ID context to derive client/org/user level
	 * @param AD_Org_ID number of the current window to retrieve context
	 * @param AD_Table_ID table
	 * @param Record_ID record id
	 * @param createError true to capture error into server log
	 * @return true if can update
	 * see org.compiere.model.MTable#dataSave(boolean)
	 **/
	public boolean canUpdate (int AD_Client_ID, int AD_Org_ID, 
		int AD_Table_ID, int Record_ID, boolean createError)
	{
		String userLevel = getUserLevel();	//	Format 'SCO'

		if (userLevel.indexOf('S') != -1)	//	System can change anything
			return true;

		boolean	retValue = true;
		String whatMissing = "";

		//	System == Client=0 & Org=0
		if (AD_Client_ID == 0 && AD_Org_ID == 0
			&& userLevel.charAt(0) != 'S')
		{
			retValue = false;
			whatMissing += "S";
		}

		//	Client == Client!=0 & Org=0
		else if (AD_Client_ID != 0 && AD_Org_ID == 0
			&& userLevel.charAt(1) != 'C')
		{
			if (userLevel.charAt(2) == 'O' && isOrgAccess(AD_Org_ID, true))
				;	//	Client+Org with access to *
			else
			{
				retValue = false;
				whatMissing += "C";
			}
		}

		//	Organization == Client!=0 & Org!=0
		else if (AD_Client_ID != 0 && AD_Org_ID != 0
			&& userLevel.charAt(2) != 'O')
		{
			retValue = false;
			whatMissing += "O";
		}

		// Client Access: Verify if the role has access to the given client - teo_sarca, BF [ 1982398 ]
		if (retValue) {
			retValue = isClientAccess(AD_Client_ID, true); // r/w access
			whatMissing += "C";
		}
		
		// Org Access: Verify if the role has access to the given organization - teo_sarca, patch [ 1628050 ]
		if (retValue) {
			retValue = isOrgAccess(AD_Org_ID, true); // r/w access
			whatMissing="W";
		}
		
		//	Data Access
		if (retValue)
			retValue = isTableAccess(AD_Table_ID, false);
		
		if (retValue && Record_ID != 0)
			retValue = isRecordAccess(AD_Table_ID, Record_ID, false);
		
		if (!retValue && createError)
		{
			log.saveWarning("AccessTableNoUpdate",
				"AD_Client_ID=" + AD_Client_ID 
				+ ", AD_Org_ID=" + AD_Org_ID + ", UserLevel=" + userLevel
				+ " => missing=" + whatMissing);
			log.warning (toString());
		}
		return retValue;
	}	//	canUpdate

	/**
	 *	VIEW - Can I view record in Table with given TableLevel.
	 *  <pre>
	 *	TableLevel		S__ 100		4	System info
	 *			        SCO 111		7	System shared info
	 *			        SC_ 110		6	System/Client info
	 *			        _CO 011		3	Client shared info
	 *			        _C_ 011		2	Client shared info
	 *			        __O 001		1	Organization info
	 *  </pre>
	 * 
	 * 	@param ctx	context
	 *	@param TableLevel table access level
	 *	@return	true if can view<br/>
	 *  Access error info (AccessTableNoUpdate, AccessTableNoView) is saved in the log
	 *  @see org.compiere.model.GridTabVO#loadTabDetails(GridTabVO, ResultSet)
	 */
	public boolean canView(Properties ctx, String TableLevel)
	{
		String userLevel = getUserLevel();	//	Format 'SCO'

		boolean retValue = true;

		//	7 - All
		if (X_AD_Table.ACCESSLEVEL_All.equals(TableLevel))
			retValue = true;
			 
		//	4 - System data requires S
		else if (X_AD_Table.ACCESSLEVEL_SystemOnly.equals(TableLevel) 
			&& userLevel.charAt(0) != 'S')
			retValue = false;

		//	2 - Client data requires C
		else if (X_AD_Table.ACCESSLEVEL_ClientOnly.equals(TableLevel) 
			&& userLevel.charAt(1) != 'C')
			retValue = false;

		//	1 - Organization data requires O
		else if (X_AD_Table.ACCESSLEVEL_Organization.equals(TableLevel) 
			&& userLevel.charAt(2) != 'O')
			retValue = false;

		//	3 - Client Shared requires C or O
		else if (X_AD_Table.ACCESSLEVEL_ClientPlusOrganization.equals(TableLevel)
			&& (!(userLevel.charAt(1) == 'C' || userLevel.charAt(2) == 'O')) )
				retValue = false;

		//	6 - System/Client requires S or C
		else if (X_AD_Table.ACCESSLEVEL_SystemPlusClient.equals(TableLevel)
			&& (!(userLevel.charAt(0) == 'S' || userLevel.charAt(1) == 'C')) )
			retValue = false;

		if (retValue)
			return retValue;

		log.saveWarning("AccessTableNoView",
			"Required=" + TableLevel + "("
			+ getTableLevelString(Env.getAD_Language(ctx), TableLevel)
			+ ") != UserLevel=" + userLevel);
		if (log.isLoggable(Level.INFO)) log.info (toString());
		return retValue;
	}	//	canView

	/**
	 *	Returns translated display text of TableLevel
	 *  @param AD_Language language
	 *  @param TableLevel table access level
	 *  @return translated display text of TableLevel
	 */
	private String getTableLevelString (String AD_Language, String TableLevel)
	{
		String level = TableLevel + "??";
		if (TableLevel.equals("1"))
			level = "AccessOrg";
		else if (TableLevel.equals("2"))
			level = "AccessClient";
		else if (TableLevel.equals("3"))
			level = "AccessClientOrg";
		else if (TableLevel.equals("4"))
			level = "AccessSystem";
		else if (TableLevel.equals("6"))
			level = "AccessSystemClient";
		else if (TableLevel.equals("7"))
			level = "AccessShared";

		return Msg.getMsg(AD_Language, level);
	}	//	getTableLevelString

	/**
	 * 	Get Table ID from table name
	 *	@param tableName table name
	 *	@return AD_Table_ID or 0
	 */
	private int getAD_Table_ID (String tableName)
	{
		MTable table = MTable.get(getCtx(), tableName);
		if (table == null)
			return 0;
		return table.getAD_Table_ID();
	}	//	getAD_Table_ID

	/**
	 * 	Get Where clause for Record Access
	 *	@param AD_Table_ID table
	 *	@param keyColumnName (fully qualified) key column name
	 *	@param rw true if read write
	 *  @param tableName 
	 *  @param alias 
	 *	@return where clause or ""
	 */
	private String getRecordWhere (int AD_Table_ID, String keyColumnName, boolean rw, String tableName, String alias)
	{
		loadRecordAccess(false);
		//
		StringBuilder sbInclude = new StringBuilder();
		StringBuilder sbExclude = new StringBuilder();
		//	Role Access
		for (int i = 0; i < m_recordAccess.length; i++)
		{
			if (m_recordAccess[i].getAD_Table_ID() == AD_Table_ID)
			{
				//	NOT IN (x)
				if (m_recordAccess[i].isExclude())
				{
					if (sbExclude.length() == 0){
						sbExclude.append("(").append(keyColumnName).append(" IS NULL OR ");
						sbExclude.append(keyColumnName).append(" NOT IN (");
					}
					else
						sbExclude.append(",");
					sbExclude.append(m_recordAccess[i].getRecord_ID());
				}
				//	IN (x)
				else if (!rw || !m_recordAccess[i].isReadOnly())	//	include
				{
					if (sbInclude.length() == 0)
						sbInclude.append(keyColumnName)
							.append(" IN (");
					else
						sbInclude.append(",");
					sbInclude.append(m_recordAccess[i].getRecord_ID());
				}
			}
		}	//	for all Table Access
		
		StringBuilder sb = new StringBuilder();
		if (sbExclude.length() > 0)
			sb.append(sbExclude).append("))");
		if (sbInclude.length() > 0)
		{
			if (sb.length() > 0)
				sb.append(" AND ");
			sb.append(sbInclude).append(")");
		}	
		
		//	Don't ignore Privacy Access
		if (!isPersonalAccess())
		{
			String lockedIDs = MPrivateAccess.getLockedRecordWhere(AD_Table_ID, m_AD_User_ID);
			if (lockedIDs != null)
			{
				if (sb.length() > 0)
					sb.append(" AND ");
				sb.append(" (" + keyColumnName + " IS NULL OR ");
				sb.append(keyColumnName).append(lockedIDs).append(") ");
			}
		}

		for (MTableValRule tvr : MTableValRule.get(p_ctx, AD_Table_ID, Env.getAD_Client_ID(p_ctx), Env.getAD_Role_ID(p_ctx), Env.getAD_User_ID(p_ctx))) {
			if (sb.length() > 0)
				sb.append(" AND ");
			String wherevr = Env.parseContext(p_ctx, 0, tvr.getCode(), false);
			if (! Util.isEmpty(alias) && ! alias.equals(tableName))
				wherevr = wherevr.replaceAll("\\b" + tableName + "\\b", alias);
			sb.append(" (").append(wherevr).append(") ");
		}

		//
		return sb.toString();
	}	//	getRecordWhere

	/**
	 * 	Show (Value) Preference Menu
	 *	@return true if preference type is not None
	 */
	public boolean isShowPreference()
	{
		return !X_AD_Role.PREFERENCETYPE_None.equals(getPreferenceType());
	}	//	isShowPreference
	
	/**
	 * 	Organization Access value object class
	 */
	class OrgAccess implements Serializable
	{
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = -4880665261978385315L;

		/**
		 * 	Org Access constructor
		 *	@param ad_Client_ID client
		 *	@param ad_Org_ID org
		 *	@param readonly r/o
		 */
		public OrgAccess (int ad_Client_ID, int ad_Org_ID, boolean readonly)
		{
			this.AD_Client_ID = ad_Client_ID;
			this.AD_Org_ID = ad_Org_ID;
			this.readOnly = readonly;
		}
		
		/** Client				*/
		public int AD_Client_ID = 0;
		/** Organization		*/
		public int AD_Org_ID = 0;
		/** Read Only			*/
		public boolean readOnly = true;
				
		/**
		 * 	Equals
		 *	@param obj object to compare
		 *	@return true if equals
		 */
		@Override
		public boolean equals (Object obj)
		{
			if (obj != null && obj instanceof OrgAccess)
			{
				OrgAccess comp = (OrgAccess)obj;
				return comp.AD_Client_ID == AD_Client_ID 
					&& comp.AD_Org_ID == AD_Org_ID;
			}
			return false;
		}	//	equals
				
		/**
		 * 	Hash Code
		 *	@return hash Code
		 */
		@Override
		public int hashCode ()
		{
			return (AD_Client_ID*7) + AD_Org_ID;
		}	//	hashCode
		
		/**
		 * 	Extended String Representation
		 *	@return extended info
		 */
		@Override
		public String toString ()
		{
			String clientName = "System";
			if (AD_Client_ID != 0)
				clientName = MClient.get(getCtx(), AD_Client_ID).getName();
			String orgName = "*";
			if (AD_Org_ID != 0)
				orgName = MOrg.get(AD_Org_ID).getName();
			StringBuilder sb = new StringBuilder();
			sb.append(Msg.translate(getCtx(), "AD_Client_ID")).append("=")
				.append(clientName).append(" - ")
				.append(Msg.translate(getCtx(), "AD_Org_ID")).append("=")
				.append(orgName);
			if (readOnly)
				sb.append(" r/o");
			return sb.toString();
		}	//	toString

	}	//	OrgAccess
	
	/**
	 * Checks the access rights of the given role/client for the given document actions.
	 * @param clientId AD_Client_ID
	 * @param docTypeId C_DocType_ID
	 * @param options array of document actions
	 * @param maxIndex define the range of elements to examine in options (>= 0 and &lt; maxIndex)
	 * @return number of valid actions in the String[] options argument
	 */
	public int checkActionAccess(int clientId, int docTypeId, String[] options,
			int maxIndex) {
		if (maxIndex <= 0)
			return maxIndex;
		//
		final ArrayList<String> validOptions = new ArrayList<String>();
		final List<Object> optionParams = new ArrayList<Object>();
		//
		final StringBuilder sql_values = new StringBuilder();
		for (int i = 0; i < maxIndex; i++) {
			if (sql_values.length() > 0)
				sql_values.append(",");
			sql_values.append("?");
			optionParams.add(options[i]);
		}
		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<MRole> roles = getIncludedRoles(true);
		roles.add(this); // add current role to the list of included roles
		String sql = null;
		try {
			for (MRole role : roles) {
				int idxpar = 1;
				if (role.getAD_Client_ID() == 0 && role.isMasterRole()) {
					// master role on system - check options based on docbasetype and docsubtypeso
					MDocType doc = new MDocType(getCtx(), docTypeId, get_TrxName());

					sql = "SELECT DISTINCT rl.Value, a.IsActive"
							+ " FROM AD_Document_Action_Access a"
							+ " INNER JOIN AD_Ref_List rl ON (rl.AD_Reference_ID=135 and rl.AD_Ref_List_ID=a.AD_Ref_List_ID)"
							+ " INNER JOIN AD_Role ro ON (a.AD_Role_ID=ro.AD_Role_ID)"
							+ " INNER JOIN C_Doctype ty ON (a.C_Doctype_ID=ty.C_Doctype_ID)"
							+ " WHERE ro.AD_Role_ID=?"
							+ " AND ty.DocBaseType=?"
							+ (MDocType.DOCBASETYPE_SalesOrder.equals(doc.getDocBaseType()) ? " AND ty.DocSubTypeSO=?" : "")
							+ (MDocType.DOCBASETYPE_PurchaseOrder.equals(doc.getDocBaseType()) && doc.getDocSubTypeSO() != null ? " AND ty.DocSubTypeSO=?" : "")
							+ (MDocType.DOCBASETYPE_MaterialPhysicalInventory.equals(doc.getDocBaseType()) ? " AND ty.DocSubTypeInv=?" : "")
							+ " AND rl.Value IN ("
							+ sql_values
							+ ")";

					pstmt = DB.prepareStatement(sql, get_TrxName());
					pstmt.setInt(idxpar++, role.getAD_Role_ID());
					pstmt.setString(idxpar++, doc.getDocBaseType());
					if (MDocType.DOCBASETYPE_SalesOrder.equals(doc.getDocBaseType()))
						pstmt.setString(idxpar++, doc.getDocSubTypeSO());
					else if (MDocType.DOCBASETYPE_PurchaseOrder.equals(doc.getDocBaseType()) && doc.getDocSubTypeSO() != null)
						pstmt.setString(idxpar++, doc.getDocSubTypeSO());
					else if (MDocType.DOCBASETYPE_MaterialPhysicalInventory.equals(doc.getDocBaseType()))
						pstmt.setString(idxpar++, doc.getDocSubTypeInv());
				} else {
					// master role on tenant - check options based on doctypeid
				    sql = "SELECT DISTINCT rl.Value, a.IsActive"
				    		+ " FROM AD_Document_Action_Access a"
							+ " INNER JOIN AD_Ref_List rl ON (rl.AD_Reference_ID=135 and rl.AD_Ref_List_ID=a.AD_Ref_List_ID)"
							+ " WHERE a.AD_Client_ID=? AND a.C_DocType_ID=?" // #1,2
							+ " AND a.AD_Role_ID=?"
							+ " AND rl.Value IN ("
							+ sql_values
							+ ")";
					pstmt = DB.prepareStatement(sql, get_TrxName());
					pstmt.setInt(idxpar++, clientId);
					pstmt.setInt(idxpar++, docTypeId);
					pstmt.setInt(idxpar++, role.getAD_Role_ID());
				}
				for (Object param : optionParams)
					pstmt.setObject(idxpar++, param);

				rs = pstmt.executeQuery();
				while (rs.next()) {
					String op = rs.getString(1);
					String active=rs.getString(2);
					if ("N".equals(active)) {
						if (validOptions.contains(op)) {
							validOptions.remove(op);
						}
					} else {
						if (!validOptions.contains(op)) {
							validOptions.add(op);
						}
					} 
				}

				DB.close(rs, pstmt);
			}

			validOptions.toArray(options);
		} catch (SQLException e) {
			log.log(Level.SEVERE, sql, e);
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		int newMaxIndex = validOptions.size();
		return newMaxIndex;
	}

	/** List of included roles. Do not access directly */
	private List<MRole> m_includedRoles = null;
	
	/**
	 * Add role to the included role list ({@link #m_includedRoles}). 
	 * @param role
	 * @param seqNo
	 */
	private void includeRole(MRole role, int seqNo)
	{
		if (this.getAD_Role_ID() == role.getAD_Role_ID())
		{
			return;
		}
		if (this.m_includedRoles == null)
		{
			m_includedRoles = new ArrayList<MRole>();
		}
		for (MRole r : this.m_includedRoles)
		{
			if (r.getAD_Role_ID() == role.getAD_Role_ID())
			{
				return;
			}
		}
		
		if (s_log.isLoggable(Level.INFO)) s_log.info("Include "+role);
		
		if(role.isActive()){
			this.m_includedRoles.add(role);
			role.setParentRole(this);
			role.m_includedSeqNo = seqNo;
		}
		
	}

	/**
	 * @param recursive
	 * @return unmodifiable list of included roles
	 */
	public List<MRole> getIncludedRoles(boolean recursive)
	{
		if (!recursive)
		{
			List<MRole> list = this.m_includedRoles;
			if (list == null)
				list = new ArrayList<MRole>();
			return Collections.unmodifiableList(list);
		}
		else
		{
			List<MRole> list = new ArrayList<MRole>();
			if (m_includedRoles != null)
			{
				for (MRole role : m_includedRoles)
				{
					list.add(role);
					list.addAll(role.getIncludedRoles(true));
				}
			}
			return list;
		}
	}
	
	/**
	 * Load all included roles (direct inclusion or from user substitution)
	 * @param reload
	 */
	private void loadIncludedRoles(boolean reload)
	{
		loadChildRoles(reload);
		loadSubstitutedRoles(reload);
		//
		if (this.m_parent == null)
		{
			mergeAccesses(reload);
		}
	}
	
	/**
	 * Merge access record from this role and immediate included roles.
	 * @param reload
	 */
	private void mergeAccesses(boolean reload)
	{
		OrgAccess[] orgAccess = new OrgAccess[]{};
		MTableAccess[] tableAccess = new MTableAccess[]{};
		MColumnAccess[] columnAccess = new MColumnAccess[]{};
		MRecordAccess[] recordAccess = new MRecordAccess[]{};
		MRecordAccess[] recordDependentAccess = new MRecordAccess[]{};
		//
		MRole last_role = null;
		for (MRole role : getIncludedRoles(false))
		{
			boolean override = false;
			//
			// If roles have same SeqNo, then, the second role will override permissions from first role
			if (last_role != null && last_role.m_includedSeqNo >= 0
					&& role.m_includedSeqNo >= 0
					&& last_role.m_includedSeqNo == role.m_includedSeqNo)
			{
				override = true;
			}
			//
			role.loadAccess(reload);
			role.mergeAccesses(reload);
			orgAccess = mergeAccess(orgAccess, role.m_orgAccess, override);
			tableAccess = mergeAccess(tableAccess, role.m_tableAccess, override);
			columnAccess = mergeAccess(columnAccess, role.m_columnAccess, override);
			recordAccess = mergeAccess(recordAccess, role.m_recordAccess, override);
			recordDependentAccess = mergeAccess(recordDependentAccess, role.m_recordDependentAccess, override);
			//
			last_role = role;
		}
		//
		// Merge permissions inside this role
		this.m_orgAccess = mergeAccess(this.m_orgAccess, orgAccess, false);
		this.m_tableAccess = mergeAccess(this.m_tableAccess, tableAccess, false);
		this.m_columnAccess = mergeAccess(this.m_columnAccess, columnAccess, false);
		this.m_recordAccess = mergeAccess(this.m_recordAccess, recordAccess, false);
		this.m_recordDependentAccess = mergeAccess(this.m_recordDependentAccess, recordDependentAccess, false);
	}
	
	/**
	 * Load Child Roles
	 * @param reload
	 */
	private void loadChildRoles(boolean reload)
	{
		m_includedRoles = null; // reset included roles
		final int AD_User_ID = getAD_User_ID();
		if (AD_User_ID < 0)
		{
			log.info("Trying to load Child Roles but user has not been set");
			return ;
		}
		//
		final String whereClause = X_AD_Role_Included.COLUMNNAME_AD_Role_ID+"=?";
		List<X_AD_Role_Included> list = new Query(getCtx(), X_AD_Role_Included.Table_Name, whereClause, get_TrxName())
		.setParameters(new Object[]{getAD_Role_ID()})
		.setOnlyActiveRecords(true)
		.setOrderBy(
				X_AD_Role_Included.COLUMNNAME_SeqNo
				+","+X_AD_Role_Included.COLUMNNAME_Included_Role_ID)
				.list();
		for (X_AD_Role_Included includedRole : list)
		{
			MRole role = MRole.get(getCtx(), includedRole.getIncluded_Role_ID());
			includeRole(role, includedRole.getSeqNo());
		}
	}

	/**
	 * Load substituted roles
	 * @param reload
	 */
	private void loadSubstitutedRoles(boolean reload)
	{
		if (this.m_parent != null || isMasterRole())
		{
			// load only if this is logged role (no parent or master roles) 
			return;
		}
		//
		final int AD_User_ID = getAD_User_ID();
		if (AD_User_ID < 0)
		{
			log.info("Trying to load Substituted Roles but user has not been set");
			//throw new IllegalStateException("AD_User_ID is not set");
			return;
		}
		//
		final String whereClause = "EXISTS ("
		+" SELECT 1 FROM AD_User_Roles ur"
		+" INNER JOIN AD_User_Substitute us ON (us.AD_User_ID=ur.AD_User_ID)"
		+" WHERE ur.AD_Role_ID=AD_Role.AD_Role_ID AND ur.IsActive='Y' AND us.IsActive='Y'"
		+" AND (us.ValidFrom IS NULL OR us.ValidFrom <= getDate())"
		+" AND (us.ValidTo IS NULL OR us.ValidTo >= getDate())"
		+" AND us.Substitute_ID=?)";

		List<MRole> list = new Query(getCtx(), Table_Name, whereClause, get_TrxName())
		.setParameters(new Object[]{AD_User_ID})
		.setClient_ID()
		.setOrderBy(COLUMNNAME_AD_Role_ID)
		.list();
		for (MRole role : list)
		{
			includeRole(role, -1);
		}
	}
	
	/** Parent Role */
	private MRole m_parent = null;
	
	/**
	 * Set parent role. This method is called when this role is included in a parent role.
	 * @param parent
	 */
	private void setParentRole(MRole parent)
	{
		this.setAD_User_ID(parent.getAD_User_ID());
		this.m_parent = parent;
	}
	
	private int m_includedSeqNo = -1;
	
	/**
	 * Merge permissions access 
	 * @param <T>
	 * @param array1
	 * @param array2
	 * @return array of merged values
	 */
	@SuppressWarnings("unchecked")
	private static final <T> T[] mergeAccess(T[] array1, T[] array2, boolean override)
	{
		if (array1 == null)
		{
			s_log.info("array1 null !!!");
		}
		List<T> list = new ArrayList<T>();
		for (T po : array1)
		{
			list.add(po);
		}
		for (T o2 : array2)
		{
			boolean found = false;
			for (int i = 0; i < array1.length; i++)
			{
				final T o1 = array1[i];
				if (o1 instanceof OrgAccess)
				{
					final OrgAccess oa1 = (OrgAccess)o1;
					final OrgAccess oa2 = (OrgAccess)o2;
					found = oa1.equals(oa2);
					if (found && override)
					{
						// stronger permissions first
						if (!oa2.readOnly)
							oa1.readOnly = false;
					}
				}
				else if (o1 instanceof MTableAccess)
				{
					final MTableAccess ta1 = (MTableAccess)o1;
					final MTableAccess ta2 = (MTableAccess)o2;
					found = ta1.getAD_Table_ID() == ta2.getAD_Table_ID();
					if (found && override)
					{
						// stronger permissions first
						if (!ta2.isExclude())
							ta1.setIsExclude(false);
					}
				}
				else if (o1 instanceof MColumnAccess)
				{
					final MColumnAccess ca1 = (MColumnAccess)o1;
					final MColumnAccess ca2 = (MColumnAccess)o2;
					found = ca1.getAD_Column_ID() == ca2.getAD_Column_ID();
					if (found && override)
					{
						// stronger permissions first
						if (!ca2.isReadOnly())
							ca1.setIsReadOnly(false);
						if (!ca2.isExclude())
							ca1.setIsExclude(false);
					}
				}
				else if (o1 instanceof MRecordAccess)
				{
					final MRecordAccess ra1 = (MRecordAccess)o1;
					final MRecordAccess ra2 = (MRecordAccess)o2;
					found = ra1.getAD_Table_ID() == ra2.getAD_Table_ID()
							&& ra1.getRecord_ID() == ra2.getRecord_ID();
					if (found && override)
					{
						// stronger permissions first
						if(!ra2.isReadOnly())
							ra1.setIsReadOnly(false);
						if (!ra2.isDependentEntities())
							ra1.setIsDependentEntities(false);
						if (!ra2.isExclude())
							ra1.setIsExclude(false);
					}
				}
				else
				{
					throw new AdempiereException("Not supported objects - "+o1+", "+o2);
				}
				//
				if (found)
				{
					break;
				}
			} // end for array1
			if (!found)
			{
				//s_log.info("add "+o2);
				list.add(o2);
			}
		}
		T[] arr = (T[]) Array.newInstance(array1.getClass().getComponentType(), list.size());
		return list.toArray(arr);
	}
	
	/**
	 * Merge access records
	 * @param map1
	 * @param map2
	 * @param override
	 * @return merged access records
	 */
	private static final HashMap<Integer,Boolean> mergeAccess(
			HashMap<Integer,Boolean> map1, HashMap<Integer,Boolean> map2,
			boolean override)
	{
		final HashMap<Integer,Boolean> map = new HashMap<Integer, Boolean>();
		if (map1 != null)
		{
			map.putAll(map1);
		}
		//
		for (final Entry<Integer, Boolean> e : map2.entrySet())
		{
			final Integer key = e.getKey();
			final Boolean b2 = e.getValue();
			if (b2 == null)
			{
				continue;
			}
			final Boolean b1 = map.get(key);
			if (b1 == null)
			{
				map.put(key, b2);
			}
			else
			{
				if (override)
				{
					map.put(key, b2);
				}
			}
		}
		//
		return map;
	}
	
	/**
	 * Merge access record of this role and immediate included roles
	 * @param varname name for the type of access (for e.g m_formAccess, m_windowAccess, etc)
	 */
	private void mergeIncludedAccess(String varname)
	{
		HashMap<Integer,Boolean> includedAccess = new HashMap<Integer, Boolean>();
		MRole last_role = null;
		for (MRole role : getIncludedRoles(false))
		{
			boolean override = false;
			//
			// If roles have same SeqNo, then, the second role will override permissions from first role
			if (last_role != null && last_role.m_includedSeqNo >= 0
					&& role.m_includedSeqNo >= 0
					&& last_role.m_includedSeqNo == role.m_includedSeqNo)
			{
				override = true;
			}
			includedAccess = mergeAccess(includedAccess, role.getAccessMap(varname), override);
			last_role = role;
		}
		setAccessMap(varname, mergeAccess(getAccessMap(varname), includedAccess, false));
	}
	
	/**
	 * @param varname name for the type of access (for e.g m_formAccess, m_windowAccess, etc)
	 * @return access map for varname type
	 */
	private HashMap<Integer, Boolean> getAccessMap(String varname)
	{
		if ("m_windowAccess".equals(varname))
		{
			getWindowAccess(-1);
			return m_windowAccess;
		}
		else if ("m_processAccess".equals(varname))
		{
			getProcessAccess(-1);
			return m_processAccess;
		}
		else if ("m_taskAccess".equals(varname))
		{
			getTaskAccess(-1);
			return m_taskAccess;
		}
		else if ("m_workflowAccess".equals(varname))
		{
			getWorkflowAccess(-1);
			return m_workflowAccess;
		}
		else if ("m_formAccess".equals(varname))
		{
			getFormAccess(-1);
			return m_formAccess;
		}
		else if ("m_infoAccess".equals(varname))
		{
			getInfoAccess(-1);
			return m_infoAccess;
		}
		else
		{
			throw new IllegalArgumentException("varname not supported - "+varname);
		}
	}
	
	/**
	 * Set access map for varname type
	 * @param varname name for the type of access (for e.g m_formAccess, m_windowAccess, etc)
	 * @param map access map
	 */
	private void setAccessMap(String varname, HashMap<Integer, Boolean> map)
	{
		if ("m_windowAccess".equals(varname))
		{
			m_windowAccess = map;
		}
		else if ("m_processAccess".equals(varname))
		{
			m_processAccess = map;
		}
		else if ("m_taskAccess".equals(varname))
		{
			m_taskAccess = map;
		}
		else if ("m_workflowAccess".equals(varname))
		{
			m_workflowAccess = map;
		}
		else if ("m_formAccess".equals(varname))
		{
			m_formAccess = map;
		}
		else if ("m_infoAccess".equals(varname))
		{
			m_infoAccess = map;
		}
		else
		{
			throw new IllegalArgumentException("varname not supported - "+varname);
		}
	}
	
	/**
	 * Get Where Clause filter for this role and included roles.<br/>
	 * It will look something like myalias.AD_Role_ID IN (?, ?, ?).
	 * @param roleColumnSQL role column name or role column SQL (e.g. myalias.AD_Role_ID) 
	 * @param params a list where the method will put SQL parameters.<br/>
	 * 		  If null, this method will generate a not parameterized query 
	 * @return SQL where clause
	 */
	public String getIncludedRolesWhereClause(String roleColumnSQL, List<Object> params)
	{
		StringBuilder whereClause = new StringBuilder();
		if (params != null)
		{
			whereClause.append("?");
			params.add(getAD_Role_ID());
		}
		else
		{
			whereClause.append(getAD_Role_ID());
		}
		//
		for (MRole role : getIncludedRoles(true))
		{
			if (params != null)
			{
				whereClause.append(",?");
				params.add(role.getAD_Role_ID());
			}
			else
			{
				whereClause.append(",").append(role.getAD_Role_ID());
			}
		}
		//
		whereClause.insert(0, roleColumnSQL+" IN (").append(")");
		return whereClause.toString();
	}

	/**
	 * Get info window access (AD_InfoWindow_Access)
	 * @param AD_InfoWindow_ID
	 * @return null if can't access, TRUE if r/w and FALSE if r/o
	 */
	public synchronized Boolean getInfoAccess(int AD_InfoWindow_ID) {
		if (m_infoAccess == null)
		{
			m_infoAccess = new HashMap<Integer,Boolean>(20);
			// first get the info access from the included and substitute roles
			mergeIncludedAccess("m_infoAccess"); 
			// and now get the info access directly from this role			
			String ASPFilter = "";

			String sql = "SELECT AD_InfoWindow_ID, IsActive FROM AD_InfoWindow_Access WHERE AD_Role_ID=?" + ASPFilter;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			HashMap<Integer,Boolean> directAccess = new HashMap<Integer,Boolean>(100);
			try
			{
				pstmt = DB.prepareStatement(sql, get_TrxName());
				pstmt.setInt(1, getAD_Role_ID());
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Integer infoId = Integer.valueOf(rs.getInt(1));
					if ("N".equals(rs.getString(2))) {
						// inactive info on direct access
						if (m_infoAccess.containsKey(infoId)) {
							m_infoAccess.remove(infoId);
						}
					} else {
						directAccess.put(infoId, Boolean.TRUE);
					}
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, sql, e);
			}
			finally
			{
				DB.close(rs, pstmt);
			}
			setAccessMap("m_infoAccess", mergeAccess(getAccessMap("m_infoAccess"), directAccess, true));
		}	//	reload
		Boolean retValue = m_infoAccess.get(AD_InfoWindow_ID);

		return retValue;
	}

	private Boolean m_canAccess_Info_Product = null;

	/**
	 * @return true if can access info window for product
	 */
	public boolean canAccess_Info_Product() {
		if (m_canAccess_Info_Product == null) {
			String sql = ""
					+ "SELECT COUNT(*) "
					+ "FROM   AD_InfoWindow iw "
					+ "       JOIN AD_InfoWindow_Access iwa "
					+ "         ON ( iwa.AD_InfoWindow_ID = iw.AD_InfoWindow_ID ) "
					+ "WHERE  AD_Table_ID = ? "
					+ "       AND iw.IsActive = 'Y' "
					+ "       AND iwa.IsActive = 'Y' "
					+ "       AND (iwa.AD_Role_ID = ? OR iwa.AD_Role_ID IN"
					+ "       		(SELECT ri.Included_Role_ID FROM AD_Role_Included ri WHERE ri.IsActive='Y' AND ri.AD_Role_ID=?))";
			int cnt = DB.getSQLValueEx(get_TrxName(), sql, I_M_Product.Table_ID, getAD_Role_ID(), getAD_Role_ID());
			m_canAccess_Info_Product = Boolean.valueOf(cnt > 0);

			// Verify if is excluded in the specific role (it can be allowed in included role and inactive in specific role)
			if (m_canAccess_Info_Product) {
				String sqlInactive = ""
						+ "SELECT COUNT(*) "
						+ "FROM   AD_InfoWindow iw "
						+ "       JOIN AD_InfoWindow_Access iwa "
						+ "         ON ( iwa.AD_InfoWindow_ID = iw.AD_InfoWindow_ID ) "
						+ "WHERE  AD_Table_ID = ? "
						+ "       AND iw.IsActive = 'Y' "
						+ "       AND iwa.IsActive = 'N' "
						+ "       AND iwa.AD_Role_ID = ?";
				int cntInactive = DB.getSQLValueEx(get_TrxName(), sqlInactive, I_M_Product.Table_ID, getAD_Role_ID());
				if (cntInactive > 0)
					m_canAccess_Info_Product = Boolean.FALSE;
			}
		}
		return m_canAccess_Info_Product.booleanValue();
	}

	/**
	 * 	Get where clause for a role types list
	 * 	@param roleType - comma separated list of role types, NULL can be used
	 * 	@param tableName - if column needs to be qualified
	 *	@return whereClause, return null if roleType is null or empty
	 */
	public static String getWhereRoleType(String roleType, String tableName) {
		if (Util.isEmpty(roleType, true)) {
			return null;
		}
		boolean includeNull = false;
		String types[] = roleType.split(",");
		StringBuilder whereClause = new StringBuilder("(");
		boolean start = true;
		for (String type : types) {
			if ("null".equalsIgnoreCase(type)) {
				includeNull = true;
			} else {
				if (start) {
					if (! Util.isEmpty(tableName)) {
						whereClause.append(tableName).append(".");
					}
					whereClause.append(COLUMNNAME_RoleType).append(" IN (");
					start = false;
				} else {
					whereClause.append(",");
				}
				whereClause.append(DB.TO_STRING(type));
			}
		}
		if (! start) {
			whereClause.append(")");
		}
		if (includeNull) {
			if (! start) {
				whereClause.append(" OR ");
			}
			if (! Util.isEmpty(tableName)) {
				whereClause.append(tableName).append(".");
			}
			whereClause.append(COLUMNNAME_RoleType).append(" IS NULL");
		}
		whereClause.append(")");
		return whereClause.toString();
	}

	/**
	 * Verify compatibility of AD_Role.UserLevel vs Access Level
	 * @param accessLevel the access level of the dictionary object
	 * @return true if access level and user level are compatible
	 */
	private boolean isAccessLevelCompatible(String accessLevel) {
		boolean access = false;
		switch (getUserLevel()) {
		case USERLEVEL_System:
			switch (accessLevel) {
			case MProcess.ACCESSLEVEL_SystemOnly:
			case MProcess.ACCESSLEVEL_SystemPlusClient:
			case MProcess.ACCESSLEVEL_All:
				access = true;
			}
			break;
		case USERLEVEL_Client:
			switch (accessLevel) {
			case MProcess.ACCESSLEVEL_ClientOnly:
			case MProcess.ACCESSLEVEL_ClientPlusOrganization:
			case MProcess.ACCESSLEVEL_SystemPlusClient:
			case MProcess.ACCESSLEVEL_All:
				access = true;
			}
			break;
		case USERLEVEL_Organization:
			switch (accessLevel) {
			case MProcess.ACCESSLEVEL_Organization:
			case MProcess.ACCESSLEVEL_ClientPlusOrganization:
			case MProcess.ACCESSLEVEL_All:
				access = true;
			}
			break;
		case USERLEVEL_ClientPlusOrganization:
			switch (accessLevel) {
			case MProcess.ACCESSLEVEL_Organization:
			case MProcess.ACCESSLEVEL_ClientOnly:
			case MProcess.ACCESSLEVEL_ClientPlusOrganization:
			case MProcess.ACCESSLEVEL_SystemPlusClient:
			case MProcess.ACCESSLEVEL_All:
				access = true;
			}
			break;
		}
		return access;
	}
	
	/**
	 * Does the table is excluded for current role (this method doesn't check the access level of the table, use isTableAccessLevel for that purpose)
	 * @param tableID AD_Table_ID
	 * @return true if table access is excluded for this role
	 */
	public boolean isTableAccessExcluded(int tableID)
	{
		loadTableAccess(false);

		for (int i = 0; i < m_tableAccess.length; i++) {
			if (   m_tableAccess[i].isExclude()
					&& m_tableAccess[i].getAD_Table_ID() == tableID
					&& ! m_tableAccess[i].isReadOnly()
					&& MTableAccess.ACCESSTYPERULE_Accessing.equals(m_tableAccess[i].getAccessTypeRule())
					)
				return true;
		}

		return false;
	}	//	isTableAccessExcluded

	@Override
	public MRole markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * Check record access through {@link #addAccessSQL(String, String, boolean, boolean)} using<br/>
	 * either record id or record uuid
	 * @param table
	 * @param recordId ignore if uuid is use
	 * @param uuid null to use recordId
	 * @param rw true for writable, false for readonly
	 * @return true if role has access to record
	 */
	public boolean checkAccessSQL(MTable table, int recordId, String uuid, boolean rw) {
		StringBuilder sql = new StringBuilder("SELECT 1 FROM ")
				.append(table.getTableName())
				.append(" WHERE ")
				.append(table.getTableName())
				.append(".");
		if (!Util.isEmpty(uuid, true) ) {
			sql.append(PO.getUUIDColumnName(table.getTableName()))
				.append("=?");
			return DB.getSQLValueEx(null, addAccessSQL(sql.toString(), table.getTableName(), true, rw), uuid) == 1;
		} else {
			sql.append(table.getKeyColumns()[0])
				.append("=?");
			return DB.getSQLValueEx(null, addAccessSQL(sql.toString(), table.getTableName(), true, rw), recordId) == 1;
		}
	}

	/** Get Predefined Context Variables from this role and included roles
	 * @return Predefined context variables to inject when opening a menu entry or a window
	 */
	public String getPredefinedContextVariables() {
		StringBuilder predefinedContextVariables = new StringBuilder();
		for (MRole role : getIncludedRoles(false)) {
			if (role.get_Value(COLUMNNAME_PredefinedContextVariables) != null) {
				if (predefinedContextVariables.length() > 0)
					predefinedContextVariables.append("\n");
				predefinedContextVariables.append(role.get_Value(COLUMNNAME_PredefinedContextVariables).toString());
			}
		}
		if (get_Value(COLUMNNAME_PredefinedContextVariables) != null) {
			if (predefinedContextVariables.length() > 0)
				predefinedContextVariables.append("\n");
			predefinedContextVariables.append(get_Value(COLUMNNAME_PredefinedContextVariables).toString());
		}
		return predefinedContextVariables.toString();
	}

}	//	MRole
