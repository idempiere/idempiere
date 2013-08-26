/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.pipo2;

import java.util.Properties;
import java.util.UUID;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_UUID_Map;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
public class POFinder {

	/**
	 * 
	 */
	private POFinder() {
	}

	/**
	 * @param ctx
	 * @param tableName
	 * @param uuid
	 * @param trxName
	 * @return target uuid
	 */
	public static String getTargetUUID(Properties ctx, String tableName, String uuid, String trxName) {
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		if (AD_Client_ID==0)
			return uuid;
		MTable table = MTable.get(ctx, tableName);
		String sql = "SELECT Target_UUID FROM AD_Package_UUID_Map WHERE AD_Client_ID=? AND AD_Table_ID=? AND Source_UUID=?";
		String uid = DB.getSQLValueString(trxName, sql, AD_Client_ID, table.getAD_Table_ID(), uuid);
		return Util.isEmpty(uid) ? uuid : uid;
	}

	/**
	 * @param ctx
	 * @param tableName
	 * @param uuid
	 * @param targetUUID
	 */
	public static void updateUUIDMap(PIPOContext ctx, String tableName, String uuid, String targetUUID) {
		X_AD_Package_UUID_Map map = new X_AD_Package_UUID_Map(ctx.ctx, 0, ctx.trx.getTrxName());
		MTable table = MTable.get(ctx.ctx, tableName);
		map.setAD_Table_ID(table.getAD_Table_ID());
		map.setSource_UUID(uuid);
		map.setTarget_UUID(targetUUID);
		map.saveEx();
	}
	
	/**
     * Find po by uuid or id
     * @param <T>
     * @param ctx
     * @param element
     * @return T
     */
    public static <T extends PO> T findPO(PIPOContext ctx, Element element) {
    	T po = null;
    	String tableName = element.getElementValue();
    	String uuidColumn = PO.getUUIDColumnName(tableName);
    	String idColumn = tableName + "_ID";
    	if (element.properties.containsKey(uuidColumn)) {
    		String uuid = element.properties.get(uuidColumn).contents.toString();
    		if (uuid != null && uuid.trim().length() == 36) {
    			uuid = uuid.trim();
    			String targetUUID = Env.getAD_Client_ID(ctx.ctx) > 0 ? getTargetUUID(ctx.ctx, tableName, uuid, ctx.trx.getTrxName()) : uuid; 
    			Query query = new Query(ctx.ctx, tableName, uuidColumn+"=?", getTrxName(ctx));
    			po = query.setParameters(targetUUID).firstOnly();
    			if (po != null && po.getAD_Client_ID() > 0) {
    				if (po.getAD_Client_ID() > 0 && po.getAD_Client_ID() != Env.getAD_Client_ID(ctx.ctx)) {
    					targetUUID = UUID.randomUUID().toString();
    					updateUUIDMap(ctx, tableName, uuid, targetUUID);
    					return null;
    				}
    			}
    		}
    	} 
    	
    	if (po == null && element.properties.containsKey(idColumn)) {
    		String id = element.properties.get(idColumn).contents.toString();
    		if (id != null && id.trim().length() > 0) {
    			Query query = new Query(ctx.ctx, tableName, idColumn+"=?", getTrxName(ctx));
    			po = query.setParameters(Integer.valueOf(id.trim())).firstOnly();
    			if (po != null && po.getAD_Client_ID() > 0) {
    				if (po.getAD_Client_ID() != Env.getAD_Client_ID(ctx.ctx)) {
    					throw new IllegalStateException("2Pack cannot update/access record that belongs to another client. TableName="+po.get_TableName()
    						+", Record_ID="+po.get_ID() + ", AD_Client_ID="+po.getAD_Client_ID()+" Context AD_Client_ID="+Env.getAD_Client_ID(ctx.ctx));
    				}
    			}
    		}
    	}
    	return po;
    }
    
    /**
     * Get current transaction name
     * @param ctx
     * @return transaction name
     */
    private static String getTrxName(PIPOContext ctx) {
    	return ctx.trx != null ? ctx.trx.getTrxName() : null;
    }
}
