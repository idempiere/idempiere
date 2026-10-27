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
package org.compiere.process;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.model.MInfoWindow;
import org.compiere.model.MUserDefInfo;
import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 * 	Validate Info Window SQL
 *	
 *  @author Jorg Janke
 *  @version $Id: InfoWindowValidate.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
@org.adempiere.base.annotation.Process
public class InfoWindowValidate extends SvrProcess
{
	/**	Info Window			*/
	private int p_AD_InfoWindow_ID = 0;
	private int p_AD_UserDefInfo_ID = 0;
	
	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		if (getProcessInfo().getTable_ID() == MInfoWindow.Table_ID)
			p_AD_InfoWindow_ID = getRecord_ID();
		else if (getProcessInfo().getTable_ID() == MUserDefInfo.Table_ID) {
			p_AD_UserDefInfo_ID = getRecord_ID();
			p_AD_InfoWindow_ID = new MUserDefInfo(getCtx(), p_AD_UserDefInfo_ID, get_TrxName()).getAD_InfoWindow_ID();
		}
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt ()
			throws Exception
	{
		if (p_AD_UserDefInfo_ID == 0) {
			MInfoWindow infoWindow = new MInfoWindow(getCtx(), p_AD_InfoWindow_ID, (String)null);
			infoWindow.validate();
			infoWindow.saveEx();
			return infoWindow.isValid() ? "@OK@" : "@NotValid@";
		}
		else {

			MInfoWindow iw = new MInfoWindow(getCtx(), p_AD_InfoWindow_ID, get_TrxName());
			MUserDefInfo udi = new MUserDefInfo(getCtx(), p_AD_UserDefInfo_ID, get_TrxName());

			String sql = MInfoWindow.getSqlForValidation(getCtx(), iw, udi);

			if (Util.isEmpty(sql))
				return "@NotValid@";

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = DB.prepareStatement(sql, get_TrxName());
				rs = pstmt.executeQuery();
			}
			catch (Exception ex) {
				log.log(Level.WARNING, ex.getMessage());
				return "@Error@ @NotValid@: "+ ex;
			}
			finally {
				DB.close(rs, pstmt);
			}
			return "@OK@";
		}

	}	//	doIt

}	//	InfoWindowValidate
