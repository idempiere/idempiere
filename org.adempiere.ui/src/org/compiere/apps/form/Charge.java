/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.compiere.apps.form;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCharge;
import org.compiere.model.MElementValue;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 *  Create Charge from Accounts
 *
 *  @author Jorg Janke
 *  @version $Id: Charge.java,v 1.3 2006/07/30 00:51:28 jjanke Exp $
 */
public class Charge
{	
	/**	Window No			*/
	protected int         m_WindowNo = 0;
	/** Account Element     */
	protected int         m_C_Element_ID = 0;
	/** AccountSchema       */
	private int         m_C_AcctSchema_ID = 0;
	/** Default Charge Tax Category */
	private int         m_C_TaxCategory_ID = 0;
	private int         m_AD_Client_ID = 0;
	private int         m_AD_Org_ID = 0;
	private MAcctSchema  m_acctSchema = null;
	/**	Logger			*/
	protected static final CLogger log = CLogger.getCLogger(Charge.class);

	/** optional trx name */
	private String m_trxName;
	
	/**
	 * default constructor
	 */
	public Charge() 
	{
		findChargeElementID();
    	findTaxCategoryID();
	}
	
	/**
	 * set optional trx name
	 * @param trxName
	 */
	public void setTrxName(String trxName)
	{
		m_trxName = trxName;
	}
	
	/**
	 *  @return list of account element(Boolean[Select],KeyNamePair[C_ElementValue_ID,Value],Name,Boolean[IsExpense]) records
	 */
	public Vector<Vector<Object>> getData()
	{
		//  Table
		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		String sql = "SELECT C_ElementValue_ID,Value, Name, AccountType "
			+ "FROM C_ElementValue "
			+ "WHERE AccountType IN ('R','E')"
			+ " AND IsSummary='N'"
			+ " AND C_Element_ID=? "
			+ "ORDER BY 2";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, m_trxName);
			pstmt.setInt(1, m_C_Element_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>(4);
				line.add(Boolean.FALSE);       //  0-Selection
				KeyNamePair pp = new KeyNamePair(rs.getInt(1), rs.getString(2));
				line.add(pp);                       //  1-Value
				line.add(rs.getString(3));          //  2-Name
				boolean isExpenseType = rs.getString(4).equals("E");
				line.add(Boolean.valueOf(isExpenseType));   //  3-Expense
				data.add(line);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return data;
	}
	
	/**
     * Finds C_Element_ID of primary accounting schema
     *
     */
    protected void findChargeElementID()
    {
    	m_C_AcctSchema_ID = Env.getContextAsInt(Env.getCtx(), Env.C_ACCTSCHEMA_ID);
        //  get Element
        String sql = "SELECT C_Element_ID "
            + "FROM C_AcctSchema_Element "
            + "WHERE ElementType='AC' AND C_AcctSchema_ID=?";
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try
        {
            pstmt = DB.prepareStatement(sql, m_trxName);
            pstmt.setInt(1, m_C_AcctSchema_ID);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
            	m_C_Element_ID = rs.getInt(1);
            }
        }
        catch (SQLException exception)
        {
            log.log(Level.SEVERE, sql, exception);
        }
        finally
        {
        	DB.close(rs, pstmt);
            rs = null;
            pstmt = null;
        }
    }
	
    /**
     * 
     * @return column names
     */
	public Vector<String> getColumnNames()
	{
		//  Header Info
		Vector<String> columnNames = new Vector<String>(4);
		columnNames.add(Msg.getMsg(Env.getCtx(), "Select"));
		columnNames.add(Msg.translate(Env.getCtx(), "Value"));
		columnNames.add(Msg.translate(Env.getCtx(), "Name"));
		columnNames.add(Msg.getMsg(Env.getCtx(), "Expense"));
		
		return columnNames;
	}
	
	/**
	 * set class type of columns
	 * @param dataTable
	 */
	public void setColumnClass(IMiniTable dataTable)
	{
		dataTable.setColumnClass(0, Boolean.class, false);      //  0-Selection
		dataTable.setColumnClass(1, String.class, true);        //  1-Value
		dataTable.setColumnClass(2, String.class, true);        //  2-Name
		dataTable.setColumnClass(3, Boolean.class, true);       //  3-Expense
		//  Table UI
		dataTable.autoSize();
	}
	
	/**
     * Finds default tax category for the client.
     */
	protected void findTaxCategoryID()
	{
		//  Other Defaults
		m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		m_AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());

		//  TaxCategory
		String sql = "SELECT C_TaxCategory_ID FROM C_TaxCategory "
			+ "WHERE IsDefault='Y' AND AD_Client_ID=?";
		m_C_TaxCategory_ID = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, m_trxName);
			pstmt.setInt(1, m_AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				m_C_TaxCategory_ID = rs.getInt(1);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
	}   //  dynInit
	
	/**************************************************************************
	 *  Create ElementValue for primary AcctSchema
	 *  @param value value
	 *  @param name name
	 *  @param isExpenseType is expense
	 *  @return C_ElementValue_ID or 0 if create fail
	 */
	public int createElementValue (String value, String name, boolean isExpenseType)
	{
		if (log.isLoggable(Level.CONFIG)) log.config(name);
		//
		MElementValue ev = new MElementValue(Env.getCtx(), value, name, null,
			isExpenseType ? MElementValue.ACCOUNTTYPE_Expense : MElementValue.ACCOUNTTYPE_Revenue, 
				MElementValue.ACCOUNTSIGN_Natural,
				false, false, m_trxName);
		ev.setAD_Org_ID(m_AD_Org_ID);
		ev.setC_Element_ID(m_C_Element_ID);
		try {
			ev.saveEx();
		} catch (Exception e) {
			log.log(Level.WARNING, "C_ElementValue_ID not created", e);
			return 0;
		}
		return ev.getC_ElementValue_ID();
	}   //  createElementValue

	/**
     *  Create Charge and account entries for primary Account Schema.
     *
     *  @param name             charge name
     *  @param elementValueId   element value identifier
     *  @return charge identifier, or 0 if create fail
     */
    public int createCharge(String name, int elementValueId)
    {
        MCharge charge;
        MAccount account;

        refreshAccountSchema();
        if (!isAccountSchemaValid())
        {
            return 0;
        }
        
        //  Target Account
        account = getAccount(elementValueId);
        if (account == null)
        {
            return 0;
        }
        
        if (log.isLoggable(Level.CONFIG)) log.config(name + " - ");
        // Charge
        charge = new MCharge(Env.getCtx(), 0, m_trxName);
        // IDEMPIERE-1099 - Key must be included in name to avoid name crashes in account schema.
        charge.setName(account.getAccount().getValue() + " " + name);
        charge.setC_TaxCategory_ID(m_C_TaxCategory_ID);
        try 
        {
        	charge.saveEx();
        } 
        catch (Exception e)
        {
            log.log(Level.SEVERE, name + " not created", e);
            return 0;
        }

        updateAccount(charge, account);

        return charge.getC_Charge_ID();
    }   //  createCharge
    
    /**
     * Updates the charge account details.
     * @param charge    the charge
     * @param account   the account
     */
    private void updateAccount(MCharge charge, MAccount account)
    {
        StringBuffer sql = createUpdateAccountSql(charge, account);
        //
        int noAffectedRows = DB.executeUpdate(sql.toString(), m_trxName);
        if (noAffectedRows != 1)
        {
            log.log(Level.SEVERE, "Update #" + noAffectedRows + "\n" + sql.toString());
        }

        return;
    }


    /**
     * Queries whether the current account scheme is valid.
     * @return false if the current account is <code>null</code> or
     *         its identifier is 0 (zero).
     */
    private boolean isAccountSchemaValid()
    {
        if (m_acctSchema  == null)
        {
            return false;
        }
        else if (m_acctSchema.getC_AcctSchema_ID() == 0)
        {
            return false;
        }

        return true;
    }


    /**
     * Creates the SQL statement for updating the account and charge.
     *
     * @param charge    charge
     * @param account      account
     * @return the SQL DML statement for updating the specified account and charge.
     */
    private StringBuffer createUpdateAccountSql(MCharge charge, MAccount account)
    {
        StringBuffer sql = new StringBuffer("UPDATE C_Charge_Acct ");
        sql.append("SET CH_Expense_Acct=").append(account.getC_ValidCombination_ID());
        sql.append(" WHERE C_Charge_ID=").append(charge.getC_Charge_ID());
        sql.append(" AND C_AcctSchema_ID=").append(m_C_AcctSchema_ID);

        return sql;
    }


    /**
     * Refreshes the current account schema.
     *
     */
    private void refreshAccountSchema()
    {
        //  Get AcctSchama
        if (m_acctSchema == null)
        {
            m_acctSchema = new MAcctSchema(Env.getCtx(), m_C_AcctSchema_ID, m_trxName);
        }

        return;
    }


    /**
     * Gets the account for the specified charge and element value.
     * The account is created if it doesn't already exist.
     * @param elementValueId    identifier for the element value
     * @return the account
     */
    private MAccount getAccount(int elementValueId)
    {
    	Properties ctx = Env.getCtx();
        MAccount defaultAccount = MAccount.getDefault(m_acctSchema, true); //  optional null
        MAccount account = MAccount.get(ctx,
            Env.getAD_Client_ID(ctx),
            Env.getAD_Org_ID(ctx),
            m_acctSchema.getC_AcctSchema_ID(),
            elementValueId,
            defaultAccount.getC_SubAcct_ID(),
            defaultAccount.getM_Product_ID(),
            defaultAccount.getC_BPartner_ID(),
            defaultAccount.getAD_OrgTrx_ID(),
            defaultAccount.getC_LocFrom_ID(),
            defaultAccount.getC_LocTo_ID(),
            defaultAccount.getC_SalesRegion_ID(),
            defaultAccount.getC_Project_ID(),
            defaultAccount.getC_Campaign_ID(),
            defaultAccount.getC_Activity_ID(),
            defaultAccount.getUser1_ID(),
            defaultAccount.getUser2_ID(),
            defaultAccount.getUserElement1_ID(),
            defaultAccount.getUserElement2_ID(),
            m_trxName);

        return account;
    }

	protected StringBuffer listCreated;
	protected StringBuffer listRejected;

	/**
	 * create charge from selected account elements
	 * @param dataTable
	 */
    public void createAccount(IMiniTable dataTable)
	{
		log.config("");
		//
		listCreated = new StringBuffer();
		listRejected = new StringBuffer();
		//
		int rows = dataTable.getRowCount();
		for (int i = 0; i < rows; i++)
		{
			if (((Boolean)dataTable.getValueAt(i, 0)).booleanValue())
			{
				KeyNamePair pp = (KeyNamePair)dataTable.getValueAt(i, 1);
				int C_ElementValue_ID = pp.getKey();
				String name = (String)dataTable.getValueAt(i, 2);
				//
				int C_Charge_ID = createCharge(name, C_ElementValue_ID);
				if (C_Charge_ID == 0)
				{
					if (listRejected.length() > 0)
						listRejected.append(", ");
					listRejected.append(name);
				}
				else
				{
					if (listCreated.length() > 0)
						listCreated.append(", ");
					listCreated.append(name);
				}
				//  reset selection
				dataTable.setValueAt(Boolean.FALSE, i, 0);
			}
		}
	}   //  createAccount
    
    /**
     * 
     * @return comma separated list of account element names (where charge create success)
     */
    public String getCreatedAccountNames() {
    	return listCreated != null ? listCreated.toString() : "";
    }
    
    /**
     * 
     * @return comma separated list of account element names (where charge create fail)
     */
    public String getRejectedAccountNames() {
    	return listRejected != null ? listRejected.toString() : "";
    }

    /** Enumeration of column names and indices. */
    public enum EColumn
    {
        /** Select column to record whether the account is selected. */
        SELECT(0, "Select"),
        /** Value column to hold the account key. */
        VALUE(1, "Value"),
        /** Name column to hold the account name. */
        NAME(2, "Name"),
        /** Expense column to indicate whether or not the account is an expense account. */
        EXPENSE(3, "Expense");

        /** The column's index. */
		private final int m_index;
        /** The column's name. */
        private final String m_title;

        /**
         * Constructor.
         *
         * @param index index of the column
         * @param title name of the column
         */
        EColumn(int index, String title)
        {
            m_index = index;
            m_title = title;
        }

        /**
         * Gets the name of the column.
         *
         * @return the column's name
         */
        public String title()
        {
            return m_title;
        }

        /**
         * 
         * @return column index (start from 0)
         */
        public int index() 
        {
        	return m_index;
        }
    }
}   //  Charge
