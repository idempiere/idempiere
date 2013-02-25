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
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.util.DB;

/**
 *	Import ReportLines from I_ReportLine
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ImportReportLine.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class ImportReportLine extends SvrProcess
{
	/**	Client to be imported to		*/
	private int				m_AD_Client_ID = 0;
	/** Default Report Line Set			*/
	private int				m_PA_ReportLineSet_ID = 0;
	/**	Delete old Imported				*/
	private boolean			m_deleteOldImported = false;

	/** Effective						*/
	private Timestamp		m_DateValue = null;

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
				m_AD_Client_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("PA_ReportLineSet_ID"))
				m_PA_ReportLineSet_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DeleteOldImported"))
				m_deleteOldImported = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		if (m_DateValue == null)
			m_DateValue = new Timestamp (System.currentTimeMillis());
	}	//	prepare


	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws java.lang.Exception
	{
		StringBuilder sql = null;
		int no = 0;
		StringBuilder clientCheck = new StringBuilder(" AND AD_Client_ID=").append(m_AD_Client_ID);

		//	****	Prepare	****

		//	Delete Old Imported
		if (m_deleteOldImported)
		{
			sql = new StringBuilder ("DELETE I_ReportLine ")
				.append("WHERE I_IsImported='Y'").append(clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			log.fine("Delete Old Impored =" + no);
		}

		//	Set Client, Org, IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET AD_Client_ID = COALESCE (AD_Client_ID, ").append(m_AD_Client_ID).append("),")
			.append(" AD_Org_ID = COALESCE (AD_Org_ID, 0),")
			.append(" IsActive = COALESCE (IsActive, 'Y'),")
			.append(" Created = COALESCE (Created, SysDate),")
			.append(" CreatedBy = COALESCE (CreatedBy, 0),")
			.append(" Updated = COALESCE (Updated, SysDate),")
			.append(" UpdatedBy = COALESCE (UpdatedBy, 0),")
			.append(" I_ErrorMsg = ' ',")
			.append(" I_IsImported = 'N' ")
			.append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Reset=" + no);

		//	ReportLineSetName (Default)
		if (m_PA_ReportLineSet_ID != 0)
		{
			sql = new StringBuilder ("UPDATE I_ReportLine i ")
				.append("SET ReportLineSetName=(SELECT Name FROM PA_ReportLineSet r")
				.append(" WHERE PA_ReportLineSet_ID=").append(m_PA_ReportLineSet_ID).append(" AND i.AD_Client_ID=r.AD_Client_ID) ")
				.append("WHERE ReportLineSetName IS NULL AND PA_ReportLineSet_ID IS NULL")
				.append(" AND I_IsImported<>'Y'").append(clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			log.fine("Set ReportLineSetName Default=" + no);
		}
		//	Set PA_ReportLineSet_ID
		sql = new StringBuilder ("UPDATE I_ReportLine i ")
			.append("SET PA_ReportLineSet_ID=(SELECT PA_ReportLineSet_ID FROM PA_ReportLineSet r")
			.append(" WHERE i.ReportLineSetName=r.Name AND i.AD_Client_ID=r.AD_Client_ID) ")
			.append("WHERE PA_ReportLineSet_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set PA_ReportLineSet_ID=" + no);
		//
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid ReportLineSet, ' ")
			.append("WHERE PA_ReportLineSet_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid ReportLineSet=" + no);

		//	Ignore if there is no Report Line Name or ID
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'Ignored=NoLineName, ' ")
			.append("WHERE PA_ReportLine_ID IS NULL AND Name IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid LineName=" + no);

		//	Validate ElementValue
		sql = new StringBuilder ("UPDATE I_ReportLine i ")
			.append("SET C_ElementValue_ID=(SELECT C_ElementValue_ID FROM C_ElementValue e")
			.append(" WHERE i.ElementValue=e.Value AND i.AD_Client_ID=e.AD_Client_ID) ")
			.append("WHERE C_ElementValue_ID IS NULL AND ElementValue IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set C_ElementValue_ID=" + no);
		
		//	Validate C_ElementValue_ID
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid ElementValue, ' ")
			.append("WHERE C_ElementValue_ID IS NULL AND LineType<>'C'") // MReportLine.LINETYPE_Calculation
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid AccountType=" + no);

		//	Set SeqNo
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET SeqNo=I_ReportLine_ID ")
			.append("WHERE SeqNo IS NULL")
			.append(" AND I_IsImported='N'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set SeqNo Default=" + no);

		//	Copy/Sync from first Row of Line
		sql = new StringBuilder ("UPDATE I_ReportLine i ")
			.append("SET (Description, SeqNo, IsSummary, IsPrinted, LineType, CalculationType, AmountType, PAAmountType, PAPeriodType, PostingType)=")
			.append(" (SELECT Description, SeqNo, IsSummary, IsPrinted, LineType, CalculationType, AmountType, PAAmountType, PAPeriodType, PostingType")
			.append(" FROM I_ReportLine ii WHERE i.Name=ii.Name AND i.PA_ReportLineSet_ID=ii.PA_ReportLineSet_ID")
			.append(" AND ii.I_ReportLine_ID=(SELECT MIN(I_ReportLine_ID) FROM I_ReportLine iii")
			.append(" WHERE i.Name=iii.Name AND i.PA_ReportLineSet_ID=iii.PA_ReportLineSet_ID)) ")
			.append("WHERE EXISTS (SELECT *")
			.append(" FROM I_ReportLine ii WHERE i.Name=ii.Name AND i.PA_ReportLineSet_ID=ii.PA_ReportLineSet_ID")
			.append(" AND ii.I_ReportLine_ID=(SELECT MIN(I_ReportLine_ID) FROM I_ReportLine iii")
			.append(" WHERE i.Name=iii.Name AND i.PA_ReportLineSet_ID=iii.PA_ReportLineSet_ID))")
			.append(" AND I_IsImported='N'").append(clientCheck);		//	 not if previous error
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Sync from first Row of Line=" + no);

		//	Validate IsSummary - (N) Y
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET IsSummary='N' ")
			.append("WHERE IsSummary IS NULL OR IsSummary NOT IN ('Y','N')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set IsSummary Default=" + no);

		//	Validate IsPrinted - (Y) N
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET IsPrinted='Y' ")
			.append("WHERE IsPrinted IS NULL OR IsPrinted NOT IN ('Y','N')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set IsPrinted Default=" + no);

		//	Validate Line Type - (S) C
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET LineType='S' ")
			.append("WHERE LineType IS NULL OR LineType NOT IN ('S','C')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set LineType Default=" + no);

		//	Validate Optional Calculation Type - A P R S
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid CalculationType, ' ")
			.append("WHERE CalculationType IS NOT NULL AND CalculationType NOT IN ('A','P','R','S')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid CalculationType=" + no);

		//	Convert Optional Amount Type to PAAmount Type and PAPeriodType
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET PAAmountType = substr(AmountType,1,1), PAPeriodType = substr(AmountType,1,2) ")
			.append("WHERE AmountType IS NOT NULL AND (PAAmountType IS NULL OR PAPeriodType IS NULL) ")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Converted AmountType=" + no);
		
		//		Validate Optional Amount Type -
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid PAAmountType, ' ")
			.append("WHERE PAAmountType IS NOT NULL AND UPPER(AmountType) NOT IN ('B','C','D','Q','S','R')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid AmountType=" + no);
		
		//		Validate Optional Period Type -
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid PAPeriodType, ' ")
			.append("WHERE PAPeriodType IS NOT NULL AND UPPER(AmountType) NOT IN ('P','Y','T','N')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid PeriodType=" + no);

		//	Validate Optional Posting Type - A B E S R
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid CalculationType, ' ")
			.append("WHERE PostingType IS NOT NULL AND PostingType NOT IN ('A','B','E','S','R')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid PostingType=" + no);

		//	Set PA_ReportLine_ID
		sql = new StringBuilder ("UPDATE I_ReportLine i ")
			.append("SET PA_ReportLine_ID=(SELECT MAX(PA_ReportLine_ID) FROM PA_ReportLine r")
			.append(" WHERE i.Name=r.Name AND i.PA_ReportLineSet_ID=r.PA_ReportLineSet_ID) ")
			.append("WHERE PA_ReportLine_ID IS NULL AND PA_ReportLineSet_ID IS NOT NULL")
			.append(" AND I_IsImported='N'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set PA_ReportLine_ID=" + no);

		commitEx();
		
		//	-------------------------------------------------------------------
		int noInsertLine = 0;
		int noUpdateLine = 0;

		//	****	Create Missing ReportLines
		sql = new StringBuilder ("SELECT DISTINCT PA_ReportLineSet_ID, Name ")
			.append("FROM I_ReportLine ")
			.append("WHERE I_IsImported='N' AND PA_ReportLine_ID IS NULL")
			.append(" AND I_IsImported='N'").append(clientCheck);
		PreparedStatement pstmt_insertLine = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//	Insert ReportLine
			StringBuilder dbpst = new StringBuilder("INSERT INTO PA_ReportLine ")
			.append("(PA_ReportLine_ID,PA_ReportLineSet_ID,")
			.append("AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,")
			.append("Name,SeqNo,IsPrinted,IsSummary,LineType)")
			.append("SELECT ?,PA_ReportLineSet_ID,")
			.append("AD_Client_ID,AD_Org_ID,'Y',SysDate,CreatedBy,SysDate,UpdatedBy,")
			.append("Name,SeqNo,IsPrinted,IsSummary,LineType ")
			//jz + "FROM I_ReportLine "
			// + "WHERE PA_ReportLineSet_ID=? AND Name=? AND ROWNUM=1"		//	#2..3
			.append("FROM I_ReportLine ")
			.append("WHERE I_ReportLine_ID=(SELECT MAX(I_ReportLine_ID) ")		
			.append("FROM I_ReportLine ")
			.append("WHERE PA_ReportLineSet_ID=? AND Name=? ")		//	#2..3
			//jz + clientCheck, get_TrxName());
			.append(clientCheck).append(")");
			pstmt_insertLine = DB.prepareStatement(dbpst.toString(), get_TrxName());

			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int PA_ReportLineSet_ID = rs.getInt(1);
				String Name = rs.getString(2);
				//
				try
				{
					int PA_ReportLine_ID = DB.getNextID(m_AD_Client_ID, "PA_ReportLine", get_TrxName());
					if (PA_ReportLine_ID <= 0)
						throw new DBException("No NextID (" + PA_ReportLine_ID + ")");
					pstmt_insertLine.setInt(1, PA_ReportLine_ID);
					pstmt_insertLine.setInt(2, PA_ReportLineSet_ID);
					pstmt_insertLine.setString(3, Name);
					//
					no = pstmt_insertLine.executeUpdate();
					log.finest("Insert ReportLine = " + no + ", PA_ReportLine_ID=" + PA_ReportLine_ID);
					noInsertLine++;
				}
				catch (Exception ex)
				{
					log.finest(ex.toString());
					continue;
				}
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "Create ReportLine", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;pstmt = null;
			DB.close(pstmt_insertLine);
			pstmt_insertLine = null;
		}

		//	Set PA_ReportLine_ID (for newly created)
		sql = new StringBuilder ("UPDATE I_ReportLine i ")
			.append("SET PA_ReportLine_ID=(SELECT MAX(PA_ReportLine_ID) FROM PA_ReportLine r")
			.append(" WHERE i.Name=r.Name AND i.PA_ReportLineSet_ID=r.PA_ReportLineSet_ID) ")
			.append("WHERE PA_ReportLine_ID IS NULL AND PA_ReportLineSet_ID IS NOT NULL")
			.append(" AND I_IsImported='N'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set PA_ReportLine_ID=" + no);

		//	****	Update ReportLine
		sql = new StringBuilder ("UPDATE PA_ReportLine r ")
			.append("SET (Description,SeqNo,IsSummary,IsPrinted,LineType,CalculationType,AmountType,PAAmountType,PAPeriodType,PostingType,Updated,UpdatedBy)=")
			.append(" (SELECT Description,SeqNo,IsSummary,IsPrinted,LineType,CalculationType,AmountType,PAAmountType,PAPeriodType,PostingType,SysDate,UpdatedBy")
			.append(" FROM I_ReportLine i WHERE r.Name=i.Name AND r.PA_ReportLineSet_ID=i.PA_ReportLineSet_ID")
			.append(" AND i.I_ReportLine_ID=(SELECT MIN(I_ReportLine_ID) FROM I_ReportLine iii")
			.append(" WHERE i.Name=iii.Name AND i.PA_ReportLineSet_ID=iii.PA_ReportLineSet_ID)) ")
			.append("WHERE EXISTS (SELECT *")
			.append(" FROM I_ReportLine i WHERE r.Name=i.Name AND r.PA_ReportLineSet_ID=i.PA_ReportLineSet_ID")
			.append(" AND i.I_ReportLine_ID=(SELECT MIN(I_ReportLine_ID) FROM I_ReportLine iii")
			.append(" WHERE i.Name=iii.Name AND i.PA_ReportLineSet_ID=iii.PA_ReportLineSet_ID AND i.I_IsImported='N'))")
			.append(clientCheck);
		noUpdateLine = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Update PA_ReportLine=" + noUpdateLine);


		//	-------------------------------------------------------------------
		int noInsertSource = 0;
		int noUpdateSource = 0;

		//	****	Create ReportSource
		sql = new StringBuilder ("SELECT I_ReportLine_ID, PA_ReportSource_ID ")
			.append("FROM I_ReportLine ")
			.append("WHERE PA_ReportLine_ID IS NOT NULL")
			.append(" AND I_IsImported='N'").append(clientCheck);
		
		PreparedStatement pstmt_insertSource = null; 
		PreparedStatement pstmt_deleteSource = null;
		PreparedStatement pstmt_setImported = null;
		try
		{
			//	Insert ReportSource
			StringBuilder dbpst = new StringBuilder("INSERT INTO PA_ReportSource ")
					.append("(PA_ReportSource_ID,")
					.append("AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,")
					.append("PA_ReportLine_ID,ElementType,C_ElementValue_ID) ")
					.append("SELECT ?,")
					.append("AD_Client_ID,AD_Org_ID,'Y',SysDate,CreatedBy,SysDate,UpdatedBy,")
					.append("PA_ReportLine_ID,'AC',C_ElementValue_ID ")
					.append("FROM I_ReportLine ")
					.append("WHERE I_ReportLine_ID=?")
					.append(" AND I_IsImported='N'")
					.append(clientCheck);
			pstmt_insertSource = DB.prepareStatement(dbpst.toString(), get_TrxName());

			//	Update ReportSource
			//jz 
			/*
			String sqlt="UPDATE PA_ReportSource "
				+ "SET (ElementType,C_ElementValue_ID,Updated,UpdatedBy)="
				+ " (SELECT 'AC',C_ElementValue_ID,SysDate,UpdatedBy"
				+ " FROM I_ReportLine"
				+ " WHERE I_ReportLine_ID=?) "
				+ "WHERE PA_ReportSource_ID=?"
				+ clientCheck;
			PreparedStatement pstmt_updateSource = DB.prepareStatement
				(sqlt, get_TrxName());
				*/

			// Delete ReportSource - afalcone 22/02/2007 - F.R. [ 1642250 ] Import ReportLine / Very Slow Reports
			dbpst = new StringBuilder("DELETE FROM PA_ReportSource ")
					.append("WHERE C_ElementValue_ID IS NULL") 
					.append(" AND PA_ReportSource_ID=?")
					.append(clientCheck);
			pstmt_deleteSource = DB.prepareStatement(dbpst.toString(), get_TrxName());
			//End afalcone 22/02/2007 - F.R. [ 1642250 ] Import ReportLine / Very Slow Reports
			
			//	Set Imported = Y
			pstmt_setImported = DB.prepareStatement
				("UPDATE I_ReportLine SET I_IsImported='Y',"
				+ " PA_ReportSource_ID=?, "
				+ " Updated=SysDate, Processed='Y' WHERE I_ReportLine_ID=?", get_TrxName());

			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int I_ReportLine_ID = rs.getInt(1);
				int PA_ReportSource_ID = rs.getInt(2);
				//
				if (PA_ReportSource_ID == 0)			//	New ReportSource
				{
					try
					{
						PA_ReportSource_ID = DB.getNextID(m_AD_Client_ID, "PA_ReportSource", get_TrxName());
						if (PA_ReportSource_ID <= 0)
							throw new DBException("No NextID (" + PA_ReportSource_ID + ")");
						pstmt_insertSource.setInt(1, PA_ReportSource_ID);
						pstmt_insertSource.setInt(2, I_ReportLine_ID);
						//
						no = pstmt_insertSource.executeUpdate();
						log.finest("Insert ReportSource = " + no + ", I_ReportLine_ID=" + I_ReportLine_ID + ", PA_ReportSource_ID=" + PA_ReportSource_ID);
						noInsertSource++;
					}
					catch (Exception ex)
					{
						log.finest("Insert ReportSource - " + ex.toString());
						sql = new StringBuilder ("UPDATE I_ReportLine i ")
							.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||").append(DB.TO_STRING("Insert ElementSource: " + ex.toString()))
							.append("WHERE I_ReportLine_ID=").append(I_ReportLine_ID);
						DB.executeUpdate(sql.toString(), get_TrxName());
						continue;
					}
				}
				else								//	update Report Source
				{
					//jz
					StringBuilder sqlt= new StringBuilder("UPDATE PA_ReportSource ")
						.append("SET (ElementType,C_ElementValue_ID,Updated,UpdatedBy)=")
						.append(" (SELECT CAST('AC' AS CHAR(2)),C_ElementValue_ID,SysDate,UpdatedBy")  //jz
						.append(" FROM I_ReportLine")
						.append(" WHERE I_ReportLine_ID=").append(I_ReportLine_ID).append(") ")
						.append("WHERE PA_ReportSource_ID=").append(PA_ReportSource_ID).append(" ")
						.append(clientCheck);
					PreparedStatement pstmt_updateSource = DB.prepareStatement
						(sqlt.toString(), get_TrxName());
					//pstmt_updateSource.setInt(1, I_ReportLine_ID);
					//pstmt_updateSource.setInt(2, PA_ReportSource_ID);
					try
					{
						no = pstmt_updateSource.executeUpdate();
						//no = DB.executeUpdate(sqlt, get_TrxName());
						log.finest("Update ReportSource = " + no + ", I_ReportLine_ID=" + I_ReportLine_ID + ", PA_ReportSource_ID=" + PA_ReportSource_ID);
						noUpdateSource++;
					}
					catch (SQLException ex)
					{
						log.finest( "Update ReportSource - " + ex.toString());
						sql = new StringBuilder ("UPDATE I_ReportLine i ")
							.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||").append(DB.TO_STRING("Update ElementSource: " + ex.toString()))
							.append("WHERE I_ReportLine_ID=").append(I_ReportLine_ID);
						DB.executeUpdate(sql.toString(), get_TrxName());
						continue;
					}
					finally
					{
						DB.close(pstmt_updateSource);
						pstmt_updateSource = null;
					}
				}	//	update source

				//	Set Imported to Y
				pstmt_setImported.setInt(1, PA_ReportSource_ID);
				pstmt_setImported.setInt(2, I_ReportLine_ID);
				no = pstmt_setImported.executeUpdate();
				if (no != 1)
					log.log(Level.SEVERE, "Set Imported=" + no);
				//
				
				// afalcone 22/02/2007 - F.R. [ 1642250 ] Import ReportLine / Very Slow Reports
				// Delete report sources with null account
				pstmt_deleteSource.setInt(1, PA_ReportSource_ID);
				no = pstmt_deleteSource.executeUpdate();
				log.finest("Delete ReportSource with Null Account= " + no + ", I_ReportLine_ID=" + I_ReportLine_ID + ", PA_ReportSource_ID=" + PA_ReportSource_ID);
				// End afalcone 22/02/2007 - F.R. [ 1642250 ] Import ReportLine / Very Slow Reports

				commitEx();
			}
		}
		catch (SQLException e)
		{
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;pstmt = null;
			DB.close(pstmt_insertSource);
			pstmt_insertSource = null;
			DB.close(pstmt_setImported);
			pstmt_setImported = null;
		}

		//	Set Error to indicator to not imported
		sql = new StringBuilder ("UPDATE I_ReportLine ")
			.append("SET I_IsImported='N', Updated=SysDate ")
			.append("WHERE I_IsImported<>'Y'").append(clientCheck);
		
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0, null, new BigDecimal (no), "@Errors@");
		addLog (0, null, new BigDecimal (noInsertLine), "@PA_ReportLine_ID@: @Inserted@");
		addLog (0, null, new BigDecimal (noUpdateLine), "@PA_ReportLine_ID@: @Updated@");
		addLog (0, null, new BigDecimal (noInsertSource), "@PA_ReportSource_ID@: @Inserted@");
		addLog (0, null, new BigDecimal (noUpdateSource), "@PA_ReportSource_ID@: @Updated@");

		return "";
	}	//	doIt

}	//	ImportReportLine
