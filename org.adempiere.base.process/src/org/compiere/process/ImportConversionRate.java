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
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MConversionRate;
import org.compiere.model.X_I_Conversion_Rate;
import org.compiere.util.DB;

/**
 *	Import Currency Conversion Rates 
 *	
 *  @author Jorg Janke
 *  @version $Id: ImportConversionRate.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class ImportConversionRate extends SvrProcess
{
	
	/**	Client to be imported to			*/
	private int				p_AD_Client_ID = 0;
	/**	Organization to be imported to		*/
	private int				p_AD_Org_ID = 0;
	/**	Conversion Type to be imported to	*/
	private int				p_C_ConversionType_ID = 0;
	/**	Default Date					*/
	private Timestamp		p_ValidFrom = null;
	/** Default Reciprocal				*/
	private boolean 		p_CreateReciprocalRate = false;
	/**	Delete old Imported				*/
	private boolean			p_DeleteOldImported = false;

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
			else if (name.equals("AD_Org_ID"))
				p_AD_Org_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_ConversionType_ID"))
				p_C_ConversionType_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("ValidFrom"))
				p_ValidFrom = (Timestamp)para[i].getParameter();
			else if (name.equals("CreateReciprocalRate"))
				p_CreateReciprocalRate = "Y".equals(para[i].getParameter());
			else if (name.equals("DeleteOldImported"))
				p_DeleteOldImported = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare


	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception
	{
		StringBuilder msglog = new StringBuilder("doIt - AD_Client_ID=").append(p_AD_Client_ID)
				.append(",AD_Org_ID=").append(p_AD_Org_ID)
				.append(",C_ConversionType_ID=").append(p_C_ConversionType_ID)
				.append(",ValidFrom=").append(p_ValidFrom)
				.append(",CreateReciprocalRate=").append(p_CreateReciprocalRate);
		log.info(msglog.toString());
		//
		StringBuilder sql = null;
		int no = 0;
		StringBuilder clientCheck = new StringBuilder(" AND AD_Client_ID=").append(p_AD_Client_ID);
		//	****	Prepare	****

		//	Delete Old Imported
		if (p_DeleteOldImported)
		{
			sql = new StringBuilder ("DELETE I_Conversion_Rate ")
				  .append("WHERE I_IsImported='Y'").append (clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Delete Old Impored =" + no);
		}

		//	Set Client, Org, Location, IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE I_Conversion_Rate ")
			  .append("SET AD_Client_ID = COALESCE (AD_Client_ID,").append (p_AD_Client_ID).append ("),")
			  .append(" AD_Org_ID = COALESCE (AD_Org_ID,").append (p_AD_Org_ID).append ("),");
		if (p_C_ConversionType_ID != 0)
			sql.append(" C_ConversionType_ID = COALESCE (C_ConversionType_ID,").append (p_C_ConversionType_ID).append ("),");
		if (p_ValidFrom != null)
			sql.append(" ValidFrom = COALESCE (ValidFrom,").append (DB.TO_DATE(p_ValidFrom)).append ("),");
		else
			sql.append(" ValidFrom = COALESCE (ValidFrom,SysDate),");
		sql.append(" CreateReciprocalRate = COALESCE (CreateReciprocalRate,'").append (p_CreateReciprocalRate ? "Y" : "N").append ("'),")
			.append(" IsActive = COALESCE (IsActive, 'Y'),")
			.append(" Created = COALESCE (Created, SysDate),")
			.append(" CreatedBy = COALESCE (CreatedBy, 0),")
			.append(" Updated = COALESCE (Updated, SysDate),")
			.append(" UpdatedBy = ").append(getAD_User_ID()).append(",")
			.append(" I_ErrorMsg = ' ',")
			.append(" Processed = 'N',"	)
			.append(" I_IsImported = 'N' ")
			.append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.info ("Reset =" + no);

		//	Org
		sql = new StringBuilder ("UPDATE I_Conversion_Rate o ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Org, '")
			.append("WHERE (AD_Org_ID IS NULL")
			.append(" OR EXISTS (SELECT * FROM AD_Org oo WHERE o.AD_Org_ID=oo.AD_Org_ID AND (oo.IsSummary='Y' OR oo.IsActive='N')))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Org =" + no);
			
		//	Conversion Type
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET C_ConversionType_ID = (SELECT C_ConversionType_ID FROM C_ConversionType c")
			.append(" WHERE c.Value=i.ConversionTypeValue AND c.AD_Client_ID IN (0,i.AD_Client_ID) AND c.IsActive='Y') ")
			.append("WHERE C_ConversionType_ID IS NULL AND ConversionTypeValue IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.FINE)) log.fine("Set ConversionType =" + no);
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid ConversionType, ' ")
			.append("WHERE (C_ConversionType_ID IS NULL")
			.append(" OR NOT EXISTS (SELECT * FROM C_ConversionType c ")
				.append("WHERE i.C_ConversionType_ID=c.C_ConversionType_ID AND c.IsActive='Y'")
				.append(" AND c.AD_Client_ID IN (0,i.AD_Client_ID)))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid ConversionType =" + no);
		
		//	Currency
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET C_Currency_ID = (SELECT C_Currency_ID FROM C_Currency c")
			.append("	WHERE c.ISO_Code=i.ISO_Code AND c.AD_Client_ID IN (0,i.AD_Client_ID) AND c.IsActive='Y') ")
			.append("WHERE C_Currency_ID IS NULL AND ISO_Code IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.FINE)) log.fine("Set Currency =" + no);
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Currency, ' ")
			.append("WHERE (C_Currency_ID IS NULL")
			.append(" OR NOT EXISTS (SELECT * FROM C_Currency c ")
				.append("WHERE i.C_Currency_ID=c.C_Currency_ID AND c.IsActive='Y'")
				.append(" AND c.AD_Client_ID IN (0,i.AD_Client_ID)))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Currency =" + no);

		//	Currency To
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET C_Currency_ID_To = (SELECT C_Currency_ID FROM C_Currency c")
			.append("	WHERE c.ISO_Code=i.ISO_Code_To AND c.AD_Client_ID IN (0,i.AD_Client_ID) AND c.IsActive='Y') ")
			.append("WHERE C_Currency_ID_To IS NULL AND ISO_Code_To IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.FINE)) log.fine("Set Currency To =" + no);
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Currency To, ' ")
			.append("WHERE (C_Currency_ID_To IS NULL")
			.append(" OR NOT EXISTS (SELECT * FROM C_Currency c ")
				.append("WHERE i.C_Currency_ID_To=c.C_Currency_ID AND c.IsActive='Y'")
				.append(" AND c.AD_Client_ID IN (0,i.AD_Client_ID)))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Currency To =" + no);
			
		//	Rates
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET MultiplyRate = 1 / DivideRate ")
			.append("WHERE (MultiplyRate IS NULL OR MultiplyRate = 0) AND DivideRate IS NOT NULL AND DivideRate<>0")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.FINE)) log.fine("Set MultiplyRate =" + no);
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET DivideRate = 1 / MultiplyRate ")
			.append("WHERE (DivideRate IS NULL OR DivideRate = 0) AND MultiplyRate IS NOT NULL AND MultiplyRate<>0")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no > 0)
			if (log.isLoggable(Level.FINE)) log.fine("Set DivideRate =" + no);
		sql = new StringBuilder ("UPDATE I_Conversion_Rate i ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Rates, ' ")
			.append("WHERE (MultiplyRate IS NULL OR MultiplyRate = 0 OR DivideRate IS NULL OR DivideRate = 0)")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Rates =" + no);
	//	sql = new StringBuffer ("UPDATE I_Conversion_Rate i "	//	Rate diff > 10%
	//		+ "SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Inconsistent Rates='||(MultiplyRate - (1/DivideRate)) "
	//		+ "WHERE ((MultiplyRate - (1/DivideRate)) > (MultiplyRate * .1))"
	//		+ " AND I_IsImported<>'Y'").append (clientCheck);
	//	no = DB.executeUpdate(sql.toString(), get_TrxName());
	//	if (no != 0)
	//		log.warn ("Inconsistent Rates =" + no);
		
		commitEx();
		/*********************************************************************/

		int noInsert = 0;
		sql = new StringBuilder ("SELECT * FROM I_Conversion_Rate ")
			.append("WHERE I_IsImported='N'").append (clientCheck)
			.append(" ORDER BY C_Currency_ID, C_Currency_ID_To, ValidFrom");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				X_I_Conversion_Rate imp = new X_I_Conversion_Rate (getCtx(), rs, get_TrxName());
				MConversionRate rate = new MConversionRate (imp, 
					imp.getC_ConversionType_ID(), 
					imp.getC_Currency_ID(), imp.getC_Currency_ID_To(),
					imp.getMultiplyRate(), imp.getValidFrom());
				if (imp.getValidTo() != null)
					rate.setValidTo(imp.getValidTo());
				if (rate.save())
				{
					imp.setC_Conversion_Rate_ID(rate.getC_Conversion_Rate_ID());
					imp.setI_IsImported(true);
					imp.setProcessed(true);
					imp.saveEx();
					noInsert++;
					//
					if (imp.isCreateReciprocalRate())
					{
						rate = new MConversionRate (imp, 
							imp.getC_ConversionType_ID(), 
							imp.getC_Currency_ID_To(), imp.getC_Currency_ID(),
							imp.getDivideRate(), imp.getValidFrom());
						if (imp.getValidTo() != null)
							rate.setValidTo(imp.getValidTo());
						if (rate.save())					
							noInsert++;
					}
				}
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		//	Set Error to indicator to not imported
		sql = new StringBuilder ("UPDATE I_Conversion_Rate ")
			.append("SET I_IsImported='N', Updated=SysDate ")
			.append("WHERE I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0, null, new BigDecimal (no), "@Errors@");
		//
		addLog (0, null, new BigDecimal (noInsert), "@C_Conversion_Rate_ID@: @Inserted@");
		return "";
	}	//	doIt

}	//	ImportConversionRate
