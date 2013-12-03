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

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MElementValue;
import org.compiere.model.X_I_ElementValue;
import org.compiere.util.DB;

/**
 *	Import Accounts from I_ElementValue
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ImportAccount.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class ImportAccount extends SvrProcess
{
	/**	Client to be imported to		*/
	private int				m_AD_Client_ID = 0;
	/** Default Element					*/
	private int				m_C_Element_ID = 0;
	/**	Update Default Accounts			*/
	private boolean			m_updateDefaultAccounts = false;
	/** Create New Combination			*/
	private boolean			m_createNewCombination = true;

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
			else if (name.equals("C_Element_ID"))
				m_C_Element_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("UpdateDefaultAccounts"))
				m_updateDefaultAccounts = "Y".equals(para[i].getParameter());
			else if (name.equals("CreateNewCombination"))
				m_createNewCombination = "Y".equals(para[i].getParameter());
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
			sql = new StringBuilder ("DELETE I_ElementValue ")
				.append("WHERE I_IsImported='Y'").append(clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Delete Old Impored =" + no);
		}

		//	Set Client, Org, IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET AD_Client_ID = COALESCE (AD_Client_ID, ").append(m_AD_Client_ID).append("),")
			.append(" AD_Org_ID = COALESCE (AD_Org_ID, 0),")
			.append(" IsActive = COALESCE (IsActive, 'Y'),")
			.append(" Created = COALESCE (Created, SysDate),")
			.append(" CreatedBy = COALESCE (CreatedBy, 0),")
			.append(" Updated = COALESCE (Updated, SysDate),")
			.append(" UpdatedBy = COALESCE (UpdatedBy, 0),")
			.append(" I_ErrorMsg = ' ',")
			.append(" Processed = 'N', ")
			.append(" Processing = 'Y', ")
			.append(" I_IsImported = 'N' ")
			.append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Reset=" + no);

		//	****	Prepare	****

		//	Set Element
		if (m_C_Element_ID != 0)
		{
			sql = new StringBuilder ("UPDATE I_ElementValue ")
				.append("SET ElementName=(SELECT Name FROM C_Element WHERE C_Element_ID=").append(m_C_Element_ID).append(") ")
				.append("WHERE ElementName IS NULL AND C_Element_ID IS NULL")
				.append(" AND I_IsImported<>'Y'").append(clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Set Element Default=" + no);
		}
		//
		sql = new StringBuilder ("UPDATE I_ElementValue i ")
			.append("SET C_Element_ID = (SELECT C_Element_ID FROM C_Element e")
			.append(" WHERE i.ElementName=e.Name AND i.AD_Client_ID=e.AD_Client_ID)")
			.append("WHERE C_Element_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set Element=" + no);
		//
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Element, ' ")
			.append("WHERE C_Element_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid Element=" + no);

		//	No Name, Value
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No Name, ' ")
			.append("WHERE (Value IS NULL OR Name IS NULL)")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid Name=" + no);

		
		//	Set Column
		sql = new StringBuilder ("UPDATE I_ElementValue i ")
			.append("SET AD_Column_ID = (SELECT AD_Column_ID FROM AD_Column c")
			.append(" WHERE UPPER(i.Default_Account)=UPPER(c.ColumnName)")
			.append(" AND c.AD_Table_ID IN (315,266) AND AD_Reference_ID=25) ")
			.append("WHERE Default_Account IS NOT NULL AND AD_Column_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set Column=" + no);
		//
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Column, ' ")
			.append("WHERE AD_Column_ID IS NULL AND Default_Account IS NOT NULL")
			.append(" AND UPPER(Default_Account)<>'DEFAULT_ACCT'")		//	ignore default account
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid Column=" + no);

		//	Set Post* Defaults (ignore errors)
		String[] yColumns = new String[] {"PostActual", "PostBudget", "PostStatistical", "PostEncumbrance"};
		for (int i = 0; i < yColumns.length; i++)
		{
			sql = new StringBuilder ("UPDATE I_ElementValue SET ")
				.append(yColumns[i]).append("='Y' WHERE ")
				.append(yColumns[i]).append(" IS NULL OR ")
				.append(yColumns[i]).append(" NOT IN ('Y','N')")
				.append(" AND I_IsImported<>'Y'").append(clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			StringBuilder msglog = new StringBuilder("Set ").append(yColumns[i]).append(" Default=").append(no);
			if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
		}
		//	Summary
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET IsSummary='N' ")
			.append("WHERE IsSummary IS NULL OR IsSummary NOT IN ('Y','N')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set IsSummary Default=" + no);

		//	Doc Controlled
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET IsDocControlled = CASE WHEN AD_Column_ID IS NOT NULL THEN 'Y' ELSE 'N' END ")
			.append("WHERE IsDocControlled IS NULL OR IsDocControlled NOT IN ('Y','N')")
			.append(" AND I_IsImported='N'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set IsDocumentControlled Default=" + no);

		//	Check Account Type A (E) L M O R
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET AccountType='E' ")
			.append("WHERE AccountType IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set AccountType Default=" + no);
		//
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid AccountType, ' ")
			.append("WHERE AccountType NOT IN ('A','E','L','M','O','R')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid AccountType=" + no);

		//	Check Account Sign (N) C B
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET AccountSign='N' ")
			.append("WHERE AccountSign IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set AccountSign Default=" + no);
		//
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid AccountSign, ' ")
			.append("WHERE AccountSign NOT IN ('N','C','D')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid AccountSign=" + no);

		//	No Value
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=No Key, ' ")
			.append("WHERE (Value IS NULL OR Value='')")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Invalid Key=" + no);

		//	****	Update ElementValue from existing
		sql = new StringBuilder ("UPDATE I_ElementValue i ")
			.append("SET C_ElementValue_ID=(SELECT C_ElementValue_ID FROM C_ElementValue ev")
			.append(" INNER JOIN C_Element e ON (ev.C_Element_ID=e.C_Element_ID)")
			.append(" WHERE i.C_Element_ID=e.C_Element_ID AND i.AD_Client_ID=e.AD_Client_ID")
			.append(" AND i.Value=ev.Value) ")
			.append("WHERE C_ElementValue_ID IS NULL")
			.append(" AND I_IsImported='N'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Found ElementValue=" + no);

		commitEx();

		//	-------------------------------------------------------------------
		int noInsert = 0;
		int noUpdate = 0;

		//	Go through Records
		sql = new StringBuilder ("SELECT * ")
			.append("FROM I_ElementValue ")
			.append("WHERE I_IsImported='N'").append(clientCheck)
			.append(" ORDER BY I_ElementValue_ID");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				X_I_ElementValue impEV = new X_I_ElementValue(getCtx(), rs, get_TrxName());
				int C_ElementValue_ID = impEV.getC_ElementValue_ID();
				int I_ElementValue_ID = impEV.getI_ElementValue_ID();

				//	****	Create/Update ElementValue
				if (C_ElementValue_ID == 0)		//	New
				{
					MElementValue ev = new MElementValue(impEV);
					if (ev.save())
					{
						noInsert++;
						impEV.setC_ElementValue_ID(ev.getC_ElementValue_ID());
						impEV.setI_IsImported(true);
						impEV.saveEx();
					}
					else
					{
						sql = new StringBuilder ("UPDATE I_ElementValue i ")
							.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||").append(DB.TO_STRING("Insert ElementValue "))
							.append("WHERE I_ElementValue_ID=").append(I_ElementValue_ID);
						DB.executeUpdate(sql.toString(), get_TrxName());
					}
				}
				else							//	Update existing
				{
					MElementValue ev = new MElementValue (getCtx(), C_ElementValue_ID, get_TrxName());
					if (ev.get_ID() != C_ElementValue_ID)
					{
						
					}
					ev.set(impEV);
					if (ev.save())
					{
						noUpdate++;
						impEV.setI_IsImported(true);
						impEV.saveEx();
					}
					else
					{
						sql = new StringBuilder ("UPDATE I_ElementValue i ")
							.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||").append(DB.TO_STRING("Update ElementValue"))
							.append("WHERE I_ElementValue_ID=").append(I_ElementValue_ID);
						DB.executeUpdate(sql.toString(), get_TrxName());
					}
				}
			}	//	for all I_Product
		}
		catch (SQLException e)
		{
			throw new Exception ("create", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		//	Set Error to indicator to not imported
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_IsImported='N', Updated=SysDate ")
			.append("WHERE I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0, null, new BigDecimal (no), "@Errors@");
		addLog (0, null, new BigDecimal (noInsert), "@C_ElementValue_ID@: @Inserted@");
		addLog (0, null, new BigDecimal (noUpdate), "@C_ElementValue_ID@: @Updated@");

		commitEx();

		//	*****	Set Parent
		sql = new StringBuilder ("UPDATE I_ElementValue i ")
			.append("SET ParentElementValue_ID=(SELECT C_ElementValue_ID")
			.append(" FROM C_ElementValue ev WHERE i.C_Element_ID=ev.C_Element_ID")
			.append(" AND i.ParentValue=ev.Value AND i.AD_Client_ID=ev.AD_Client_ID) ")
			.append("WHERE ParentElementValue_ID IS NULL")
			.append(" AND I_IsImported='Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Found Parent ElementValue=" + no);
		//
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET I_ErrorMsg=I_ErrorMsg||'Info=ParentNotFound, ' ")
			.append("WHERE ParentElementValue_ID IS NULL AND ParentValue IS NOT NULL")
			.append(" AND I_IsImported='Y' AND Processed='N'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config("Not Found Parent ElementValue=" + no);
		//
		sql = new StringBuilder ("SELECT COALESCE(i.ParentElementValue_ID, 0), i.I_ElementValue_ID,")
			.append(" e.AD_Tree_ID, i.C_ElementValue_ID, i.Value||'-'||i.Name AS Info ")
			.append("FROM I_ElementValue i")
			.append(" INNER JOIN C_Element e ON (i.C_Element_ID=e.C_Element_ID) ")
			.append("WHERE i.C_ElementValue_ID IS NOT NULL AND e.AD_Tree_ID IS NOT NULL")
			.append(" AND i.I_IsImported='Y' AND Processed='N' AND i.AD_Client_ID=").append(m_AD_Client_ID);
		int noParentUpdate = 0;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
			//
			String updateSQL = "UPDATE AD_TreeNode SET Parent_ID=?, SeqNo=? "
				+ "WHERE AD_Tree_ID=? AND Node_ID=?";
			//begin e-evolution vpj-cd 15 nov 2005 PostgreSQL
			//PreparedStatement updateStmt = DB.prepareStatement(updateSQL, get_TrxName());
			PreparedStatement updateStmt = DB.prepareStatement(updateSQL, ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_UPDATABLE, get_TrxName());
			//end	
			//
			while (rs.next())
			{
				updateStmt.setInt(1, rs.getInt(1));		//	Parent
				updateStmt.setInt(2, rs.getInt(2));		//	SeqNo (assume sequenec in import is the same)
				updateStmt.setInt(3, rs.getInt(3));		//	Tree
				updateStmt.setInt(4, rs.getInt(4));		//	Node
				try
				{
					no = updateStmt.executeUpdate();
					noParentUpdate += no;
				}
				catch (SQLException ex)
				{
					log.log(Level.SEVERE, "(ParentUpdate)", ex);
					no = 0;
				}
				if (no == 0)
					if (log.isLoggable(Level.INFO)) log.info("Parent not found for " + rs.getString(5));
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "(ParentUpdateLoop) " + sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		addLog (0, null, new BigDecimal (noParentUpdate), "@ParentElementValue_ID@: @Updated@");

		commitEx();
		
		//	Reset Processing Flag
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET Processing='-'")
			.append("WHERE I_IsImported='Y' AND Processed='N' AND Processing='Y'")
			.append(" AND C_ElementValue_ID IS NOT NULL")
			.append(clientCheck);
		if (m_updateDefaultAccounts)
			sql.append(" AND AD_Column_ID IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Reset Processing Flag=" + no);

		if (m_updateDefaultAccounts)
			updateDefaults(clientCheck.toString());

		//	Update Description
		sql = new StringBuilder("SELECT * FROM C_ValidCombination vc ")
			.append("WHERE EXISTS (SELECT * FROM I_ElementValue i ")
				.append("WHERE vc.Account_ID=i.C_ElementValue_ID)");
		
		//	Done
		sql = new StringBuilder ("UPDATE I_ElementValue ")
			.append("SET Processing='N', Processed='Y'")
			.append("WHERE I_IsImported='Y'")
			.append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Processed=" + no);

		return "";
	}	//	doIt

	
	/**************************************************************************
	 * 	Update Default Accounts
	 * 	@param clientCheck client where cluase
	 */
	private void updateDefaults (String clientCheck)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("CreateNewCombination=" + m_createNewCombination);

		//	****	Update Defaults
		StringBuilder sql = new StringBuilder ("SELECT C_AcctSchema_ID FROM C_AcctSchema_Element ")
			.append("WHERE C_Element_ID=?").append(clientCheck);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			pstmt.setInt(1, m_C_Element_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
				updateDefaultAccounts (rs.getInt(1));
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		//	Default Account		DEFAULT_ACCT
		sql = new StringBuilder ("UPDATE C_AcctSchema_Element e ")
			.append("SET C_ElementValue_ID=(SELECT C_ElementValue_ID FROM I_ElementValue i")
			.append(" WHERE e.C_Element_ID=i.C_Element_ID AND i.C_ElementValue_ID IS NOT NULL")
			.append(" AND UPPER(i.Default_Account)='DEFAULT_ACCT') ")
			.append("WHERE EXISTS (SELECT * FROM I_ElementValue i")
			.append(" WHERE e.C_Element_ID=i.C_Element_ID AND i.C_ElementValue_ID IS NOT NULL")
			.append(" AND UPPER(i.Default_Account)='DEFAULT_ACCT' ")
			.append("	AND i.I_IsImported='Y' AND i.Processing='-')")
			.append(clientCheck);
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0, null, new BigDecimal (no), "@C_AcctSchema_Element_ID@: @Updated@");
	}	//	updateDefaults

	/**
	 * 	Update Default Accounts.
	 *	_Default.xxxx = C_ValidCombination_ID  =>  Account_ID=C_ElementValue_ID
	 * 	@param C_AcctSchema_ID Accounting Schema
	 */
	private void updateDefaultAccounts (int C_AcctSchema_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_AcctSchema_ID=" + C_AcctSchema_ID);

		MAcctSchema as = new MAcctSchema (getCtx(), C_AcctSchema_ID, get_TrxName());
		if (as.getAcctSchemaElement("AC").getC_Element_ID() != m_C_Element_ID)
		{
			StringBuilder msglog = new StringBuilder("C_Element_ID=").append(m_C_Element_ID).append(" not in AcctSchema=").append(as);
			log.log(Level.SEVERE, msglog.toString());
			return;
		}

		int[] counts = new int[] {0, 0, 0};

		StringBuilder sql = new StringBuilder("SELECT i.C_ElementValue_ID, t.TableName, c.ColumnName, i.I_ElementValue_ID ")
			.append("FROM I_ElementValue i")
			.append(" INNER JOIN AD_Column c ON (i.AD_Column_ID=c.AD_Column_ID)")
			.append(" INNER JOIN AD_Table t ON (c.AD_Table_ID=t.AD_Table_ID) ")
			.append("WHERE i.I_IsImported='Y' AND i.Processing='Y'")
			.append(" AND i.C_ElementValue_ID IS NOT NULL AND C_Element_ID=?");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			pstmt.setInt(1, m_C_Element_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int C_ElementValue_ID = rs.getInt(1);
				String TableName = rs.getString(2);
				String ColumnName = rs.getString(3);
				int I_ElementValue_ID = rs.getInt(4);
				//	Update it
				int u = updateDefaultAccount(TableName, ColumnName, C_AcctSchema_ID, C_ElementValue_ID);
				counts[u]++;
				if (u != UPDATE_ERROR)
				{
					sql = new StringBuilder("UPDATE I_ElementValue SET Processing='N' ")
						.append("WHERE I_ElementValue_ID=").append(I_ElementValue_ID);
					int no = DB.executeUpdate(sql.toString(), get_TrxName());
					if (no != 1)
						log.log(Level.SEVERE, "Updated=" + no);
				}
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		addLog (0, null, new BigDecimal (counts[UPDATE_ERROR]), as.toString() + ": @Errors@");
		addLog (0, null, new BigDecimal (counts[UPDATE_YES]), as.toString() + ": @Updated@");
		addLog (0, null, new BigDecimal (counts[UPDATE_SAME]), as.toString() + ": OK");

	}	//	createDefaultAccounts


	private static final int	UPDATE_ERROR = 0;
	private static final int	UPDATE_YES = 1;
	private static final int	UPDATE_SAME = 2;

	/**
	 * 	Update Default Account.
	 *  This is the sql to delete unused accounts - with the import still in the table(!):
		DELETE C_ElementValue e
		WHERE NOT EXISTS (SELECT * FROM Fact_Acct f WHERE f.Account_ID=e.C_ElementValue_ID)
		 AND NOT EXISTS (SELECT * FROM C_ValidCombination vc WHERE vc.Account_ID=e.C_ElementValue_ID)
		 AND NOT EXISTS (SELECT * FROM I_ElementValue i WHERE i.C_ElementValue_ID=e.C_ElementValue_ID);
	 * 	@param TableName Table Name
	 * 	@param ColumnName Column Name
	 * 	@param C_AcctSchema_ID Account Schema
	 * 	@param C_ElementValue_ID new Account
	 * 	@return UPDATE_* status
	 */
	private int updateDefaultAccount (String TableName, String ColumnName, int C_AcctSchema_ID, int C_ElementValue_ID)
	{
		StringBuilder msglog = new StringBuilder(TableName).append(".").append(ColumnName).append(" - ").append(C_ElementValue_ID);
		if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
		int retValue = UPDATE_ERROR;
		StringBuilder sql = new StringBuilder ("SELECT x.")
			.append(ColumnName).append(",Account_ID FROM ")
			.append(TableName).append(" x INNER JOIN C_ValidCombination vc ON (x.")
			.append(ColumnName).append("=vc.C_ValidCombination_ID) ")
			.append("WHERE x.C_AcctSchema_ID=").append(C_AcctSchema_ID);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				int C_ValidCombination_ID = rs.getInt(1);
				int Account_ID = rs.getInt(2);
				//	The current account value is the same
				if (Account_ID == C_ElementValue_ID)
				{
					retValue = UPDATE_SAME;
					log.fine("Account_ID same as new value");
				}
				//	We need to update the Account Value
				else
				{
					if (m_createNewCombination)
					{
						MAccount acct = MAccount.get(getCtx(), C_ValidCombination_ID);
						acct.setAccount_ID(C_ElementValue_ID);
						if (acct.save())
						{
							retValue = UPDATE_YES;
							int newC_ValidCombination_ID = acct.getC_ValidCombination_ID();
							if (C_ValidCombination_ID != newC_ValidCombination_ID)
							{
								sql = new StringBuilder ("UPDATE ").append(TableName)
									.append(" SET ").append(ColumnName).append("=").append(newC_ValidCombination_ID)
									.append(" WHERE C_AcctSchema_ID=").append(C_AcctSchema_ID);
								int no = DB.executeUpdate(sql.toString(), get_TrxName());
								msglog = new StringBuilder("New #").append(no).append(" - ")
										.append(TableName).append(".").append(ColumnName).append(" - ").append(C_ElementValue_ID)
										.append(" -- ").append(C_ValidCombination_ID).append(" -> ").append(newC_ValidCombination_ID);
								if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
								if (no == 1)
									retValue = UPDATE_YES;
							}
						}
						else
							log.log(Level.SEVERE, "Account not saved - " + acct);
					}
					else	//	Replace Combination
					{
						//	Only Acct Combination directly
						sql = new StringBuilder ("UPDATE C_ValidCombination SET Account_ID=")
							.append(C_ElementValue_ID).append(" WHERE C_ValidCombination_ID=").append(C_ValidCombination_ID);
						int no = DB.executeUpdate(sql.toString(), get_TrxName());
						msglog = new StringBuilder("Replace #").append(no).append(" - ")
								.append("C_ValidCombination_ID=").append(C_ValidCombination_ID).append(", New Account_ID=").append(C_ElementValue_ID);
						if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
						if (no == 1)
						{
							retValue = UPDATE_YES;
							//	Where Acct was used
							sql = new StringBuilder ("UPDATE C_ValidCombination SET Account_ID=")
								.append(C_ElementValue_ID).append(" WHERE Account_ID=").append(Account_ID);
							no = DB.executeUpdate(sql.toString(), get_TrxName());
							msglog = new StringBuilder("ImportAccount.updateDefaultAccount - Replace VC #").append(no).append(" - ")
									.append("Account_ID=").append(Account_ID).append(", New Account_ID=").append(C_ElementValue_ID);
							if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
							sql = new StringBuilder ("UPDATE Fact_Acct SET Account_ID=")
								.append(C_ElementValue_ID).append(" WHERE Account_ID=").append(Account_ID);
							no = DB.executeUpdate(sql.toString(), get_TrxName());
							msglog = new StringBuilder("ImportAccount.updateDefaultAccount - Replace Fact #").append(no).append(" - ")
									.append("Account_ID=").append(Account_ID).append(", New Account_ID=").append(C_ElementValue_ID);
							if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
						}
					}	//	replace combination
				}	//	need to update
			}	//	for all default accounts
			else
				log.log(Level.SEVERE, "Account not found " + sql);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return retValue;
	}	//	updateDefaultAccount

}
