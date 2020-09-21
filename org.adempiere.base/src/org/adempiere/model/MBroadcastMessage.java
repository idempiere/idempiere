/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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
package org.adempiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.X_AD_BroadcastMessage;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 
 * @author Vivek
 * @author Deepak Pansheriya
 *
 */
public class MBroadcastMessage extends X_AD_BroadcastMessage implements ImmutablePOSupport
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -5402131480890468471L;

    static private ImmutableIntPOCache<Integer,MBroadcastMessage> s_cache = new ImmutableIntPOCache<Integer,MBroadcastMessage>("AD_BroadcastMessage", 30, 60);

    public MBroadcastMessage(Properties ctx, int AD_BroadcastMessage_ID,
	    String trxName)
    {
		super(ctx, AD_BroadcastMessage_ID, trxName);
	}
    
    public MBroadcastMessage(Properties ctx, ResultSet rs,
    	    String trxName)
    {
    	super(ctx, rs, trxName);
    }
    
    /**
     * 
     * @param copy
     */
    public MBroadcastMessage(MBroadcastMessage copy)
    {
    	this(Env.getCtx(), copy);
    }
    
    /**
     * 
     * @param ctx
     * @param copy
     */
    public MBroadcastMessage(Properties ctx, MBroadcastMessage copy)
    {
    	this(ctx, copy, (String)null);
    }
    
    /**
     * 
     * @param ctx
     * @param copy
     * @param trxName
     */
    public MBroadcastMessage(Properties ctx, MBroadcastMessage copy, String trxName)
    {
    	this(ctx, 0, trxName);
    	copyPO(copy);
    }
    
    /**
     * Get MBroadcastMessage from cache (immutable)
     * @param AD_BroadcastMessage_ID
     * @return MBroadcastMessage or null
     */
	public static MBroadcastMessage get (int AD_BroadcastMessage_ID)
	{
		return get(Env.getCtx(), AD_BroadcastMessage_ID);
	}
	
    /**
     * Get MBroadcastMessage from cache (immutable)
     * @param ctx
     * @param AD_BroadcastMessage_ID
     * @return MBroadcastMessage or null
     */
	public static MBroadcastMessage get (Properties ctx, int AD_BroadcastMessage_ID)
	{
		Integer key = Integer.valueOf(AD_BroadcastMessage_ID);
		MBroadcastMessage retValue = s_cache.get(ctx, key, e -> new MBroadcastMessage(ctx, e));
		if (retValue == null)
		{
			retValue = new MBroadcastMessage (ctx, AD_BroadcastMessage_ID, (String)null);
			if (retValue.get_ID() == AD_BroadcastMessage_ID)
			{
				s_cache.put(key, retValue, e -> new MBroadcastMessage(Env.getCtx(), e));
				return retValue;
			}
			return null;
		}
		return retValue;
	}	//	get
    
	
	/**
	 * Is broadcast message applicable to current login user
	 * @return
	 */
    public boolean isValidUserforMessage()
    {
    	Properties ctx = Env.getCtx();
		
    	if(getBroadcastType()!=null && getBroadcastType().equals(BROADCASTTYPE_Immediate) && getTarget()!=null){
			if (getTarget().equals(TARGET_Role) ) {
				String sql = "SELECT COUNT(*) FROM AD_User_Roles WHERE AD_Role_ID = ? AND AD_User_ID=? AND IsActive='Y'";
				int roleSubs = DB.getSQLValue(null, sql, getAD_Role_ID(),Env.getAD_User_ID(ctx));
				if(roleSubs>0)
					return true;
			} else if (getTarget().equals(TARGET_User) && getAD_User_ID() == Env.getAD_User_ID(ctx)) {
				return true;
			} else if (getTarget().equals(TARGET_Client) && getAD_Client_ID() == Env.getAD_Client_ID(ctx)) {
				return true;
			}else if (getTarget().equals(TARGET_Everybody)){
				return true;
			}
		}
    	else {
    		
			int AD_User_ID = Env.getAD_User_ID(ctx);
			String sql = "SELECT AD_User_ID from AD_Note WHERE AD_BroadcastMessage_ID = ?  AND AD_User_ID = ? ";
			int result = DB.getSQLValue(null, sql,getAD_BroadcastMessage_ID(),AD_User_ID);
			if (result <= 0) {
				return false;
			}
			else{
				return true;
			}
		}
    	return false;
    }
    
    /**************************************************************************
	 * 	Before Save
	 *	@param newRecord new
	 *	@return save
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (BROADCASTTYPE_Immediate.equals(getBroadcastType())) {
			setBroadcastFrequency(BROADCASTFREQUENCY_JustOnce);
		}
		boolean logack =
			(   BROADCASTFREQUENCY_UntilAcknowledge.equals(getBroadcastFrequency())
			 || BROADCASTFREQUENCY_UntilExpirationOrAcknowledge.equals(getBroadcastFrequency()));
		setLogAcknowledge(logack);
		return true;
	}
    
	@Override
	public MBroadcastMessage markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
}
