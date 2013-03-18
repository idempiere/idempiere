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
package org.adempiere.process;

import java.sql.*;
import java.util.logging.*;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.*;

/**
 *	Fill 1099 Extract
 *  @author Carlos Ruiz
 *  @version $Id: Fill1099Extract.java
 */
public class Fill1099Extract extends SvrProcess
{
	private Timestamp	p_Cut_Date = null;
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("Cut_Date"))
				p_Cut_Date = (Timestamp)para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		if (p_Cut_Date == null)
			p_Cut_Date = new Timestamp (System.currentTimeMillis());
	}	//	prepare

	/**
	 * 	DoIt
	 *	@return Message
	 *	@throws Exception
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("CUT_DATE=" + p_Cut_Date);
		int AD_PInstance_ID = getAD_PInstance_ID();
		//
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO T_1099EXTRACT ");
		sql.append("(ad_pinstance_id, ad_client_id, ad_org_id, isactive, created, ");
		sql.append("createdby, updated, updatedby, c_bpartner_id, value, name, taxid, ");
		sql.append("c_location_id, cut_year, cut_date, amtbucket01, amtbucket02, ");
		sql.append("amtbucket03, amtbucket04, amtbucket05, amtbucket06, amtbucket07, ");
		sql.append("amtbucket08, amtbucket09, amtbucket10, amtbucket11, amtbucket12, ");
		sql.append("amtbucket13, amtbucket14, amtbucket15, amtbucket16) ");
		sql.append("SELECT ?, bp.ad_client_id, bp.ad_org_id, bp.isactive, bp.created, bp.createdby, ");
		sql.append("bp.updated, bp.updatedby, bp.c_bpartner_id, bp.value, bp.name, bp.taxid, ");
		/*Yvonne: should be the Invoice Address	 
		sql.append("(SELECT MIN (c_location_id) ");
		sql.append("FROM C_BPARTNER_LOCATION bpl ");
		sql.append("WHERE bpl.c_bpartner_id = bp.c_bpartner_id) c_location_id, );"
		*/				 
		sql.append("bpl.c_location_id, ");
		if (DB.isPostgreSQL())
			sql.append("date_part('year', ?::timestamp), trunc(?::timestamp),");
		else
			sql.append("EXTRACT(year from ?), TRUNC (?), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 1), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 2), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 3), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 4), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 5), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 6), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 7), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 8), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 9), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 10), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 11), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 12), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 13), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 14), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 15), ");
		sql.append("get1099bucket (bp.c_bpartner_id, ?, 16) ");
		sql.append("FROM c_bpartner bp, c_bpartner_location bpl ");	//Yvonne: added  C_BPARTNER_LOCATION bpl
		sql.append("WHERE bp.c_bpartner_id = bpl.c_bpartner_id ");	//Yvonne: added
		sql.append("AND bp.isactive = 'Y' ");
		sql.append("AND bp.ad_client_id = ? ");
		sql.append("AND bp.isvendor = 'Y' ");
		sql.append("AND bp.is1099vendor = 'Y' ");
		sql.append("AND bpl.c_bpartner_location_id IN ( ");
		sql.append(" SELECT i.c_bpartner_location_id ");
		sql.append(" FROM c_invoice i, c_invoiceline il ");
		sql.append(" WHERE i.c_invoice_id = il.c_invoice_id ");
		sql.append(" AND i.issotrx = 'N' ");
		sql.append(" AND i.docstatus IN ('CO', 'CL') ");
		sql.append(" AND i.ad_client_id = ? ");
		sql.append(" AND i.ispaid = 'Y' "); 	//Yvonne 16/02/2009: only those which have been paid
		sql.append(" AND il.c_1099box_id IS NOT NULL ");
		sql.append(" AND i.dateacct BETWEEN ");
		if (DB.isPostgreSQL())
			sql.append("date_trunc('year', ?::timestamp) ");
		else
			sql.append("TRUNC (?, 'YEAR') ");
		sql.append("AND ?) ");
		if (log.isLoggable(Level.FINEST)) log.finest(sql.toString());
		
		PreparedStatement pstmt = null;
		//
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			pstmt.setInt(1, AD_PInstance_ID);
			pstmt.setTimestamp(2, p_Cut_Date);
			pstmt.setTimestamp(3, p_Cut_Date);
			pstmt.setTimestamp(4, p_Cut_Date);
			pstmt.setTimestamp(5, p_Cut_Date);
			pstmt.setTimestamp(6, p_Cut_Date);
			pstmt.setTimestamp(7, p_Cut_Date);
			pstmt.setTimestamp(8, p_Cut_Date);
			pstmt.setTimestamp(9, p_Cut_Date);
			pstmt.setTimestamp(10, p_Cut_Date);
			pstmt.setTimestamp(11, p_Cut_Date);
			pstmt.setTimestamp(12, p_Cut_Date);
			pstmt.setTimestamp(13, p_Cut_Date);
			pstmt.setTimestamp(14, p_Cut_Date);
			pstmt.setTimestamp(15, p_Cut_Date);
			pstmt.setTimestamp(16, p_Cut_Date);
			pstmt.setTimestamp(17, p_Cut_Date);
			pstmt.setTimestamp(18, p_Cut_Date);
			pstmt.setTimestamp(19, p_Cut_Date);
			pstmt.setInt(20, getAD_Client_ID());
			pstmt.setInt(21, getAD_Client_ID());
			pstmt.setTimestamp(22, p_Cut_Date);
			pstmt.setTimestamp(23, p_Cut_Date);
			
			int rows = pstmt.executeUpdate();
			if (log.isLoggable(Level.INFO)) log.info("inserted rows=" + rows);
		}
		finally
		{
			DB.close(pstmt);
			pstmt = null;
		}
		//
		return "";
	}	//	doIt

}	//	Fill1099Extract