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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.model.MInOutLineConfirm;
import org.compiere.model.X_I_InOutLineConfirm;
import org.compiere.util.DB;


/**
 *	Import Confirmations
 *	
 *  @author Jorg Janke
 *  @version $Id: ImportInOutConfirm.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class ImportInOutConfirm extends SvrProcess
{
	/**	Client to be imported to		*/
	private int 			p_AD_Client_ID = 0;
	/**	Delete old Imported			*/
	private boolean			p_DeleteOldImported = false;
	/**	Import						*/
	private int				p_I_InOutLineConfirm_ID = 0;
	
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
			else if (name.equals("AD_Client_ID"))
				p_AD_Client_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DeleteOldImported"))
				p_DeleteOldImported = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_I_InOutLineConfirm_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	doIt
	 *	@return info
	 */
	protected String doIt () throws Exception
	{
		StringBuilder msglog = new StringBuilder("I_InOutLineConfirm_ID=").append(p_I_InOutLineConfirm_ID);
		log.info(msglog.toString());
		StringBuilder sql = null;
		int no = 0;
		StringBuilder clientCheck = new StringBuilder(" AND AD_Client_ID=").append(p_AD_Client_ID);
		
		//	Delete Old Imported
		if (p_DeleteOldImported)
		{
			sql = new StringBuilder ("DELETE I_InOutLineConfirm ")
				  .append("WHERE I_IsImported='Y'").append (clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			log.fine("Delete Old Impored =" + no);
		}

		//	Set IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE I_InOutLineConfirm ")
			.append("SET IsActive = COALESCE (IsActive, 'Y'),")
			.append(" Created = COALESCE (Created, SysDate),")
			.append(" CreatedBy = COALESCE (CreatedBy, 0),")
			.append(" Updated = COALESCE (Updated, SysDate),")
			.append(" UpdatedBy = COALESCE (UpdatedBy, 0),")
			.append(" I_ErrorMsg = ' ',")
			.append(" I_IsImported = 'N' ")
			.append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.info ("Reset=" + no);

		//	Set Client from Name
		sql = new StringBuilder ("UPDATE I_InOutLineConfirm i ")
			.append("SET AD_Client_ID=COALESCE (AD_Client_ID,").append (p_AD_Client_ID).append (") ")
			.append("WHERE (AD_Client_ID IS NULL OR AD_Client_ID=0)")
			.append(" AND I_IsImported<>'Y'");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Client from Value=" + no);

		//	Error Confirmation Line
		sql = new StringBuilder ("UPDATE I_InOutLineConfirm i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Confirmation Line, '")
			.append("WHERE (M_InOutLineConfirm_ID IS NULL OR M_InOutLineConfirm_ID=0")
			.append(" OR NOT EXISTS (SELECT * FROM M_InOutLineConfirm c WHERE i.M_InOutLineConfirm_ID=c.M_InOutLineConfirm_ID))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid InOutLineConfirm=" + no);

		//	Error Confirmation No
		sql = new StringBuilder ("UPDATE I_InOutLineConfirm i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Missing Confirmation No, '")
			.append("WHERE (ConfirmationNo IS NULL OR ConfirmationNo='')")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid ConfirmationNo=" + no);
		
		//	Qty
		sql = new StringBuilder ("UPDATE I_InOutLineConfirm i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Target<>(Confirmed+Difference+Scrapped), ' ")
			.append("WHERE EXISTS (SELECT * FROM M_InOutLineConfirm c ")
				.append("WHERE i.M_InOutLineConfirm_ID=c.M_InOutLineConfirm_ID")
				.append(" AND c.TargetQty<>(i.ConfirmedQty+i.ScrappedQty+i.DifferenceQty))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Qty=" + no);
		
		commitEx();
		
		/*********************************************************************/
		
		PreparedStatement pstmt = null;
		sql = new StringBuilder ("SELECT * FROM I_InOutLineConfirm ")
			.append("WHERE I_IsImported='N'").append (clientCheck)
			.append(" ORDER BY I_InOutLineConfirm_ID");
		no = 0;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
			ResultSet rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				X_I_InOutLineConfirm importLine = new X_I_InOutLineConfirm (getCtx(), rs, get_TrxName());
				MInOutLineConfirm confirmLine = new MInOutLineConfirm (getCtx(), 
					importLine.getM_InOutLineConfirm_ID(), get_TrxName());
				if (confirmLine.get_ID() == 0
					|| confirmLine.get_ID() != importLine.getM_InOutLineConfirm_ID())
				{
					importLine.setI_IsImported(false);
					importLine.setI_ErrorMsg("ID Not Found");
					importLine.saveEx();
				}
				else
				{
					confirmLine.setConfirmationNo(importLine.getConfirmationNo());
					confirmLine.setConfirmedQty(importLine.getConfirmedQty());
					confirmLine.setDifferenceQty(importLine.getDifferenceQty());
					confirmLine.setScrappedQty(importLine.getScrappedQty());
					confirmLine.setDescription(importLine.getDescription());
					if (confirmLine.save())
					{
						//	Import
						importLine.setI_IsImported(true);
						importLine.setProcessed(true);
						if (importLine.save())
							no++;
					}
				}
			}
			rs.close ();
			pstmt.close ();
			pstmt = null;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		try
		{
			if (pstmt != null)
				pstmt.close ();
			pstmt = null;
		}
		catch (Exception e)
		{
			pstmt = null;
		}
		StringBuilder msgreturn = new StringBuilder("@Updated@ #").append(no);
		return msgreturn.toString();
	}	//	doIt

}	//	ImportInOutConfirm
