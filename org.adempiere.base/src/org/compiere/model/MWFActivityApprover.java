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
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

/**
 * Extended model class for AD_WF_ActivityApprover
 */
public class MWFActivityApprover extends X_AD_WF_ActivityApprover {

    private static final long serialVersionUID = -7135169624317070006L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_WF_ActivityApprover_UU  UUID key
     * @param trxName Transaction
     */
    public MWFActivityApprover(Properties ctx, String AD_WF_ActivityApprover_UU, String trxName) {
        super(ctx, AD_WF_ActivityApprover_UU, trxName);
    }

    /**
     * @param ctx
     * @param AD_WF_ActivityApprover_ID
     * @param trxName
     */
    public MWFActivityApprover(Properties ctx, int AD_WF_ActivityApprover_ID, String trxName) {
        super(ctx, AD_WF_ActivityApprover_ID, trxName);
    }

    /**
     * @param ctx
     * @param rs
     * @param trxName
     */
    public MWFActivityApprover(Properties ctx, ResultSet rs, String trxName) {
        super(ctx, rs, trxName);
    }

    /**
     * Get approver records for an workflow activity
     * @param ctx
     * @param ad_WF_Activity_ID
     * @param trxName
     * @return array of MWFActivityApprover records
     */
    public static MWFActivityApprover[] getOfActivity(Properties ctx, int ad_WF_Activity_ID, String trxName) {
        final String whereClause = I_AD_WF_ActivityApprover.COLUMNNAME_AD_WF_Activity_ID+"=?";  
        List<MWFActivityApprover> list = new Query(ctx,I_AD_WF_ActivityApprover.Table_Name,whereClause,trxName)
        .setParameters(ad_WF_Activity_ID)
        .list();
        MWFActivityApprover[] retValue = new MWFActivityApprover[list.size ()];
        list.toArray (retValue);
        return retValue;
    }
}
