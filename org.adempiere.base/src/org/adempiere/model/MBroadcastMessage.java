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
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 
 * @author Vivek
 * @author Deepak Pansheriya
 *
 */
public class MBroadcastMessage extends X_AD_BroadcastMessage
{

    /**
     * 
     */
    private static final long serialVersionUID = -6390563897422379468L;
    static private CCache<Integer,MBroadcastMessage> s_cache = new CCache<Integer,MBroadcastMessage>("AD_BroadcastMessage", 30, 60);

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

	public static MBroadcastMessage get (Properties ctx, int AD_BroadcastMessage_ID)
	{
		Integer key = new Integer(AD_BroadcastMessage_ID);
		MBroadcastMessage retValue = (MBroadcastMessage)s_cache.get(key);
		if (retValue == null)
		{
			retValue = new MBroadcastMessage (ctx, AD_BroadcastMessage_ID, null);
			
			s_cache.put(key, retValue);
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
		
    	if(getBroadcastType()!=null && getBroadcastType().equals("I") && getTarget()!=null){
			if (getTarget().equals("R") ) {
				String SQL = "select count(*) from ad_user_roles where ad_role_id = ? and ad_User_ID=?";
				int roleSubs = DB.getSQLValue(null, SQL, getAD_Role_ID(),Env.getAD_User_ID(ctx));
				if(roleSubs>0)
					return true;
			} else if (getTarget().equals("U") && getAD_User_ID() == Env.getAD_User_ID(ctx)) {
				return true;
			} else if (getTarget().equals("C") && getAD_Client_ID() == Env.getAD_Client_ID(ctx)) {
				return true;
			}else if (getTarget().equals("E")){
				return true;
			}
		}
    	else {
    		
			int AD_User_ID = Env.getAD_User_ID(ctx);
			String sql = "SELECT AD_User_ID from AD_Note WHERE AD_BroadcastMessage_ID = ?  AND AD_User_ID = ? ";
			int result = DB.getSQLValue(null, sql,getAD_Broadcastmessage_ID(),AD_User_ID);
			if (result <= 0) {
				return false;
			}
			else{
				return true;
			}
		}
    	return false;
    }
    
}
