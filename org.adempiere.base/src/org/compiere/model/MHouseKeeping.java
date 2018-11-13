/**********************************************************************
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
* - TrekGlobal                                                        *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Msg;

public class MHouseKeeping extends X_AD_HouseKeeping {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6481567026614278994L;

	public MHouseKeeping(Properties ctx, int AD_HouseKeeping_ID, String trxName) {
		super(ctx, AD_HouseKeeping_ID, trxName);
	}

	public MHouseKeeping(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (getAD_Table_ID() > 0) {
			setTableName(null);
		} else if (getTableName() != null) {
			setIsExportXMLBackup(false);
			setBackupFolder(null);
		} else {
			log.saveError("SaveError", Msg.parseTranslation(getCtx(), "@FillMandatory@ @AD_Table_ID@ @TableName@"));
			return false;
		}
		return true;
	}

}
