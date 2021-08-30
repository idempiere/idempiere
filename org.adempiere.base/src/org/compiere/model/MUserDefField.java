/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Dirk Niemeyer                                           *
 * Copyright (C) 2012 action 42 GmbH                                          *
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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.expression.logic.LogicEvaluator;


/**
 *	User overrides for field model
 *  @author Dirk Niemeyer, action42 GmbH
 *  @version $Id$
 */
public class MUserDefField extends X_AD_UserDef_Field implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2522038599257589829L;

	/**	Cache of selected MUserDefField entries 					**/
	private static ImmutablePOCache<String,MUserDefField> s_cache = new ImmutablePOCache<String,MUserDefField>(Table_Name, 10);
	
	/**
	 * 	Standard constructor.
	 * 	You must implement this constructor for Adempiere Persistency
	 *	@param ctx context
	 *	@param ID the primary key ID
	 *	@param trxName transaction
	 */
	public MUserDefField (Properties ctx, int ID, String trxName)
	{
		super (ctx, ID, trxName);
	}	//	MyModelExample

	/**
	 * 	Optional Load Constructor.
	 * 	You would use this constructor to load several business objects.
	 *  <code>
	 * 	SELECT * FROM MyModelExample WHERE ...
	 *  </code> 
	 *  @param ctx context
	 *  @param rs result set
	 *	@param trxName transaction
	 */
	public MUserDefField (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MyModelExample

	/**
	 * 
	 * @param copy
	 */
	public MUserDefField(MUserDefField copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MUserDefField(Properties ctx, MUserDefField copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MUserDefField(Properties ctx, MUserDefField copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * Get matching MUserDefField related to current field and user definition for window and tab
	 * @param ctx
	 * @param AD_Field_ID
	 * @param AD_Tab_ID
	 * @param AD_Window_ID
	 * @return
	 */
	public static MUserDefField get (Properties ctx, int AD_Field_ID, int AD_Tab_ID, int AD_Window_ID )
	{
		return get(ctx, AD_Field_ID, AD_Tab_ID, AD_Window_ID, false);
	}

	/**
	 * Get matching MUserDefField related to current field and user definition for window and tab
	 * @param ctx
	 * @param AD_Field_ID
	 * @param AD_Tab_ID
	 * @param AD_Window_ID
	 * @param reload
	 * @return
	 */
	public static MUserDefField get (Properties ctx, int AD_Field_ID, int AD_Tab_ID, int AD_Window_ID , boolean reload)
	{

		MUserDefWin userdefWin = MUserDefWin.getBestMatch(ctx, AD_Window_ID);
		if (userdefWin == null)
			return null;
		MUserDefTab userdefTab = MUserDefTab.getMatch(ctx, AD_Tab_ID, userdefWin.getAD_UserDef_Win_ID());
		if (userdefTab == null)
			return null;
		
		//  Check Cache
		String key = new StringBuilder().append(AD_Field_ID).append("_")
				.append(userdefTab.getAD_UserDef_Tab_ID())
				.toString();
		if (!reload && s_cache.containsKey(key))
			return s_cache.get(ctx, key, e -> new MUserDefField(ctx, e));
		
		MUserDefField retValue = null;

		StringBuilder sql = new StringBuilder("SELECT * "
				+ " FROM AD_UserDef_Field f " 
				+ " WHERE f.AD_Field_ID=? AND f.IsActive='Y' "
				+ " AND f.AD_UserDef_Tab_ID=? ");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//	create statement
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, AD_Field_ID);
			pstmt.setInt(2, userdefTab.getAD_UserDef_Tab_ID());
			// 	get data
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = new MUserDefField(ctx,rs,null);
			}
			s_cache.put(key, retValue, e -> new MUserDefField(Env.getCtx(), e));
		}
		catch (SQLException ex)
		{
			CLogger.get().log(Level.SEVERE, sql.toString(), ex);
			return null;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; 
			pstmt = null;
		}

		return retValue;
	}
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (is_ValueChanged("AD_Reference_ID")) {
			MField field = new MField(getCtx(), getAD_Field_ID(), get_TrxName());
			MColumn column = (MColumn) field.getAD_Column();
			if (column.isEncrypted() || field.isEncrypted() || field.getObscureType() != null) {
				log.saveError("Error", Msg.getMsg(getCtx(), "NotChangeReference"));
				return false;
			}
		}
		if (getAD_Reference_ID() <= 0) {
			setAD_Reference_Value_ID(0);
			setAD_Val_Rule_ID(0);
			setIsToolbarButton(null);
		}
		
		//validate logic expression
		if (newRecord || is_ValueChanged(COLUMNNAME_ReadOnlyLogic)) {
			if (isActive() && !Util.isEmpty(getReadOnlyLogic(), true) && !getReadOnlyLogic().startsWith("@SQL=")) {
				LogicEvaluator.validate(getReadOnlyLogic());
			}
		}
		if (newRecord || is_ValueChanged(COLUMNNAME_DisplayLogic)) {
			if (isActive() && !Util.isEmpty(getDisplayLogic(), true) && !getDisplayLogic().startsWith("@SQL=")) {
				LogicEvaluator.validate(getDisplayLogic());
			}
		}
		if (newRecord || is_ValueChanged(COLUMNNAME_MandatoryLogic)) {
			if (isActive() && !Util.isEmpty(getMandatoryLogic(), true) && !getMandatoryLogic().startsWith("@SQL=")) {
				LogicEvaluator.validate(getMandatoryLogic());
			}
		}
				
		return true;
	}

	@Override
	public PO markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
		
}	//	MUserDefField
