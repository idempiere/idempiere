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

import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.util.DB;

/**
 * 	Validate Info Window SQL
 *	
 *  @author Jorg Janke
 *  @version $Id: InfoWindowValidate.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class InfoWindowValidate extends SvrProcess
{
	/**	Info Window			*/
	private int p_AD_InfoWindow_ID = 0;
	
	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		p_AD_InfoWindow_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt ()
		throws Exception
	{
		MInfoWindow infoWindow = new MInfoWindow(getCtx(), p_AD_InfoWindow_ID, (String)null);
		infoWindow.setIsValid(false);
		infoWindow.saveEx();
		
		StringBuilder builder = new StringBuilder("SELECT ");
		if (infoWindow.isDistinct())
			builder.append("DISTINCT ");
		
		MInfoColumn[] infoColumns = infoWindow.getInfoColumns();
		if (infoColumns.length == 0) 
			throw new Exception("NoColumns");
		
		for (int columnIndex = 0; columnIndex < infoColumns.length; columnIndex++) {
			if (columnIndex > 0)
            {
                builder.append(", ");
            }
			builder.append(infoColumns[columnIndex].getSelectClause());
		}
		
		builder.append( " FROM ").append(infoWindow.getFromClause());
		if (infoWindow.getWhereClause() != null && infoWindow.getWhereClause().trim().length() > 0) {
			builder.append(" WHERE ").append(infoWindow.getWhereClause());
		}
		
		if (infoWindow.getOtherClause() != null && infoWindow.getOtherClause().trim().length() > 0) {
			builder.append(" ").append(infoWindow.getOtherClause());
		}
		
		if (infoWindow.getOrderByClause() != null && infoWindow.getOrderByClause().trim().length() > 0) {
			builder.append(" ORDER BY ").append(infoWindow.getOrderByClause());
		}
		
		while(builder.indexOf("@") >= 0) {
			int start = builder.indexOf("@");
			int end = builder.indexOf("@", start+1);
			if (start >=0 && end > start) {
				builder.replace(start, end+1, "0");
			} else {
				break;
			}
		}
		
		PreparedStatement pstmt = null;
		try {
			pstmt = DB.prepareStatement(builder.toString(), get_TrxName());
			pstmt.executeQuery();
		} finally {
			DB.close(pstmt);
		}
		
		infoWindow.setIsValid(true);
		infoWindow.saveEx();
		
		return "Ok";
	}	//	doIt
	
}	//	InfoWindowValidate
