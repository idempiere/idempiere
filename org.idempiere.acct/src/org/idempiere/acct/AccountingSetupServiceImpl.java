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
 *                                                                     *
 * Contributors:                                                       *
 * - Diego Ruiz - TrekGlobal           								   *
 **********************************************************************/
package org.idempiere.acct;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.I_C_AcctSchema;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MElement;
import org.compiere.model.MElementValue;
import org.compiere.model.MGLCategory;
import org.compiere.model.MTable;
import org.compiere.model.NaturalAccountMap;
import org.compiere.model.PO;
import org.compiere.model.X_C_AcctSchema_Default;
import org.compiere.model.X_C_AcctSchema_GL;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.osgi.service.component.annotations.Component;

@Component(service = IAccountingSetupService.class, immediate = true)
public class AccountingSetupServiceImpl implements IAccountingSetupService {

	private static final CLogger log = CLogger.getCLogger(AccountingSetupServiceImpl.class);
	
	private String m_lang;
    private int AD_Client_ID = 0;
    private int AD_Org_ID = 0;
    private StringBuilder setupInfo = new StringBuilder();
    private String trxName;
	private NaturalAccountMap<String,MElementValue> m_nap = null;
	
	private Properties ctx;
	private MClient client;
	private MAcctSchema acctSchema;
	
	private String stdColumns;
	private String stdValues;

	@Override
	public boolean linkDimensionToAcctSchema(int C_AcctSchema_ID, String elementType, int dimensionID, String trxName) {
		// Map element type to column name
		String columnName = MAcctSchemaElement.getColumnName(elementType);
		if (columnName == null) {
			log.severe("Unknown element type: " + elementType);
			return false;
		}

		StringBuilder sql = new StringBuilder("UPDATE C_AcctSchema_Element SET ");
		sql.append(columnName).append("=").append(dimensionID);
		sql.append(" WHERE C_AcctSchema_ID=").append(C_AcctSchema_ID);
		sql.append(" AND ElementType='").append(elementType).append("'");

		int no = DB.executeUpdateEx(sql.toString(), trxName);
		if (no != 1) {
			log.severe("Failed to link " + elementType + " to AcctSchema");
			return false;
		}

		return true;
	}

	@Override
	public AccountingSetupResult createAccountingInfrastructure(Properties ctx, MClient client, int AD_Org_ID,
			KeyNamePair currency, boolean hasProduct, boolean hasBPartner, boolean hasProject, boolean hasMCampaign,
			boolean hasSRegion, boolean hasActivity, File accountingFile,  boolean inactivateDefaults, 
			int C_Calendar_ID, String stdColumns, String stdValues, String trxName) {
		this.ctx = ctx;
		setupInfo = new StringBuilder();
		this.AD_Client_ID = client.getAD_Client_ID();
		this.AD_Org_ID = AD_Org_ID;
		m_lang = Env.getAD_Language(ctx);
		this.trxName = trxName;
		this.client = client;
		this.stdValues = stdValues; 
		this.stdColumns = stdColumns; 

		try {

			// 1. Create core accounting infrastructure
			if (!createAccountingInfrastructure(currency, accountingFile, inactivateDefaults)) {
				return new AccountingSetupResult(false, 0, "Failed to create accounting infraestructure " + setupInfo.toString(), null);
			}
			
			// 2. Create accounting schema structure
			if (!createAcctSchemaStructure(hasProduct, hasBPartner, hasProject, 
					hasMCampaign, hasSRegion, hasActivity)) {
				return new AccountingSetupResult(false, 0, "Failed to create accounting schema structure " + setupInfo.toString(), null);
			}
			
			// 3. Create default accounting records
			if (!createDefaultAccountingRecords()) {
				return new AccountingSetupResult(false, 0, "Failed to create default accounting records " + setupInfo.toString(), null);
			}
			
			// 4. Create GL categories (master data)
			Map<String, Integer> glCategories = createGLCategories();
			if (glCategories == null) {
				return new AccountingSetupResult(false, 0, "Failed to create GL Categories" + setupInfo.toString(), null);
			}
			
			// 5. Update client info
			if (!updateClientInfo(C_Calendar_ID)) {
				return new AccountingSetupResult(false, 0, "Failed to update client info " + setupInfo.toString(), null);
			}

			return new AccountingSetupResult(true, acctSchema.getC_AcctSchema_ID(), setupInfo.toString(), glCategories);
		} catch (Exception e) {
			 log.log(Level.SEVERE, "Accounting infrastructure creation failed", e);
	            return new AccountingSetupResult(false, 0, "Exception: " + e.getMessage(), null);
		}
	}
	
	/**
	 * Create core accounting infrastructure:
	 * - Account Element
	 * - Chart of Accounts
	 * - Accounting Schema
	 * 
	 * @param currency currency
	 * @param accountingFile chart of accounts file
	 * @param inactivateDefaults inactivate defaults
	 * @return true if created
	 */
	private boolean createAccountingInfrastructure(KeyNamePair currency, 
	                                              File accountingFile, 
	                                              boolean inactivateDefaults)
	{
	    // Create Account Element
	    int C_Element_ID = createAccountElement();
	    if (C_Element_ID == 0) {
	        return false;
	    }
	    
	    // Create Chart of Accounts
	    if (!createChartOfAccounts(accountingFile, C_Element_ID, inactivateDefaults)) {
	        return false;
	    }
	    
	    // Create Accounting Schema
	    if (!createAcctSchema(currency)) {
	        return false;
	    }
	    
	    return true;
	}

	/**
	 * Create account element for chart of accounts
	 * @return C_Element_ID or 0 if failed
	 */
	private int createAccountElement()
	{
	    String name = client.getName() + " " + Msg.translate(m_lang, "Account_ID");
	    MElement element = new MElement(client, name, 
	        MElement.ELEMENTTYPE_Account, client.getSetup_AD_Tree_Account_ID());
	    
	    if (!element.save()) {
	        String err = "Acct Element NOT inserted";
	        log.log(Level.SEVERE, err);
	        setupInfo.append(err);
	        return 0;
	    }
	    
	    setupInfo.append(Msg.translate(m_lang, "C_Element_ID"))
	         .append("=").append(name).append("\n");
	    
	    return element.getC_Element_ID();
	}
	
	/**
	 * Create chart of accounts from file
	 * @param accountingFile CoA file
	 * @param C_Element_ID element ID
	 * @param inactivateDefaults inactivate defaults
	 * @return true if created
	 */
	private boolean createChartOfAccounts(File accountingFile, 
	                                     int C_Element_ID, 
	                                     boolean inactivateDefaults)
	{
	    m_nap = new NaturalAccountMap<String, MElementValue>(ctx, trxName);
	    
	    // Parse CoA file
	    String errMsg = m_nap.parseFile(accountingFile);
	    if (errMsg.length() != 0) {
	        log.log(Level.SEVERE, errMsg);
	        setupInfo.append(errMsg);
	        return false;
	    }
	    
	    // Save accounts
	    if (!m_nap.saveAccounts(AD_Client_ID, AD_Org_ID, 
	                           C_Element_ID, !inactivateDefaults)) {
	        String err = "Acct Element Values NOT inserted";
	        log.log(Level.SEVERE, err);
	        setupInfo.append(err);
	        return false;
	    }
	    
	    setupInfo.append(Msg.translate(m_lang, "C_ElementValue_ID"))
	         .append(" # ").append(m_nap.size()).append("\n");
	    
	    // Set tree structure (summary account as parent)
	    int summary_ID = m_nap.getC_ElementValue_ID("SUMMARY");
	    if (log.isLoggable(Level.FINE)) log.fine("summary_ID=" + summary_ID);
	    
	    if (summary_ID > 0) {
	        DB.executeUpdateEx(
	            "UPDATE AD_TreeNode SET Parent_ID=? WHERE AD_Tree_ID=? AND Node_ID!=?",
	            new Object[] {summary_ID, client.getSetup_AD_Tree_Account_ID(), summary_ID},
	            trxName);
	    }
	    
	    return true;
	}
	
	/**
	 * Create accounting schema
	 * @param currency currency
	 * @return true if created
	 */
	private boolean createAcctSchema(KeyNamePair currency)
	{
	    acctSchema = new MAcctSchema(client, currency);
	    
	    if (!acctSchema.save()) {
	        String err = "AcctSchema NOT inserted";
	        log.log(Level.SEVERE, err);
	        setupInfo.append(err);
	        return false;
	    }
	    
	    setupInfo.append(Msg.translate(m_lang, "C_AcctSchema_ID"))
	         .append("=").append(acctSchema.getName()).append("\n");
	    
	    return true;
	}
	
	/**
	 * Create accounting schema structure (elements/dimensions)
	 * @param hasProduct has product segment
	 * @param hasBPartner has bp segment
	 * @param hasProject has project segment
	 * @param hasMCampaign has campaign segment
	 * @param hasSRegion has sales region segment
	 * @param hasActivity has activity segment
	 * @return true if created
	 */
	private boolean createAcctSchemaStructure(boolean hasProduct, 
	                                         boolean hasBPartner, 
	                                         boolean hasProject,
	                                         boolean hasMCampaign, 
	                                         boolean hasSRegion,
	                                         boolean hasActivity)
	{
	    String sql = null;
	    if (Env.isBaseLanguage(m_lang, "AD_Reference")) { //	Get ElementTypes & Name
	        sql = "SELECT Value, Name FROM AD_Ref_List WHERE AD_Reference_ID=181";
	    } else {
	        sql = "SELECT l.Value, t.Name FROM AD_Ref_List l, AD_Ref_List_Trl t "
	            + "WHERE l.AD_Reference_ID=181 AND l.AD_Ref_List_ID=t.AD_Ref_List_ID"
	            + " AND t.AD_Language=" + DB.TO_STRING(m_lang);
	    }
	    
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    try {
	        int AD_Client_ID = client.getAD_Client_ID();
	        stmt = DB.prepareStatement(sql, trxName);
	        rs = stmt.executeQuery();
	        
	        while (rs.next()) {
	            String elementType = rs.getString(1);
	            String name = rs.getString(2);
	            
	            // Determine if this element should be created
	            AcctSchemaElementConfig config = getElementConfig(
	                elementType, name, hasProduct, hasBPartner, 
	                hasProject, hasMCampaign, hasSRegion, hasActivity);
	            
	            if (config != null) {
	                if (!createAcctSchemaElement(config, AD_Client_ID)) {
	                    return false;
	                }
	            }
	        }
	        
	        return true;
	        
	    } catch (SQLException e) {
	        log.log(Level.SEVERE, "Elements", e);
	        setupInfo.append(e.getMessage());
	        return false;
	    } finally {
	        DB.close(rs, stmt);
	    }
	}
	
	/**
	 * Get configuration for accounting schema element
	 * @param elementType element type code
	 * @param name element name
	 * @param hasProduct has product
	 * @param hasBPartner has bpartner
	 * @param hasProject has project
	 * @param hasMCampaign has campaign
	 * @param hasSRegion has sales region
	 * @param hasActivity has activity
	 * @return config or null if not needed
	 */
	private AcctSchemaElementConfig getElementConfig(String elementType, String name,
	                                                 boolean hasProduct, boolean hasBPartner,
	                                                 boolean hasProject, boolean hasMCampaign,
	                                                 boolean hasSRegion, boolean hasActivity)
	{
	    AcctSchemaElementConfig config = null;
	    
	    if ("OO".equals(elementType)) {
	        // Organization - always mandatory
	        config = new AcctSchemaElementConfig(elementType, name, true, true, 10);
	    }
	    else if ("AC".equals(elementType)) {
	        // Account - always mandatory
	        config = new AcctSchemaElementConfig(elementType, name, true, false, 20);
	    }
	    else if ("PR".equals(elementType) && hasProduct) {
	        config = new AcctSchemaElementConfig(elementType, name, false, false, 30);
	    }
	    else if ("BP".equals(elementType) && hasBPartner) {
	        config = new AcctSchemaElementConfig(elementType, name, false, false, 40);
	    }
	    else if ("PJ".equals(elementType) && hasProject) {
	        config = new AcctSchemaElementConfig(elementType, name, false, false, 50);
	    }
	    else if ("MC".equals(elementType) && hasMCampaign) {
	        config = new AcctSchemaElementConfig(elementType, name, false, false, 60);
	    }
	    else if ("SR".equals(elementType) && hasSRegion) {
	        config = new AcctSchemaElementConfig(elementType, name, false, false, 70);
	    }
	    else if ("AY".equals(elementType) && hasActivity) {
	        config = new AcctSchemaElementConfig(elementType, name, false, false, 80);
	    }
	    
	    return config;
	}
	
	/**
	 * Create single accounting schema element
	 * @param config element configuration
	 * @param AD_Client_ID client
	 * @return true if created
	 */
	private boolean createAcctSchemaElement(AcctSchemaElementConfig config, int AD_Client_ID)
	{
	    int C_AcctSchema_Element_ID = getNextID(AD_Client_ID, "C_AcctSchema_Element");
	    
	    StringBuilder sql = new StringBuilder("INSERT INTO C_AcctSchema_Element(");
	    sql.append(stdColumns).append(",C_AcctSchema_Element_ID,C_AcctSchema_ID,")
	       .append("ElementType,Name,SeqNo,IsMandatory,IsBalanced,C_AcctSchema_Element_UU) VALUES (");
	    sql.append(stdValues).append(",").append(C_AcctSchema_Element_ID)
	       .append(",").append(acctSchema.getC_AcctSchema_ID()).append(",")
	       .append("'").append(config.elementType).append("','").append(config.name).append("',")
	       .append(config.seqNo).append(",'")
	       .append(config.isMandatory ? "Y" : "N").append("','")
	       .append(config.isBalanced ? "Y" : "N").append("',")
	       .append(DB.TO_STRING(Util.generateUUIDv7().toString())).append(")");
	    
	    int no = DB.executeUpdateEx(sql.toString(), trxName);
	    if (no != 1) {
	        log.log(Level.SEVERE, "AcctSchema Element NOT created: " + config.name);
	        return false;
	    }
	    
	    setupInfo.append(Msg.translate(m_lang, "C_AcctSchema_Element_ID"))
	         .append("=").append(config.name).append("\n");
	    
	    // Set defaults for mandatory elements
	    if ("OO".equals(config.elementType)) {
	        return setDefaultOrg(C_AcctSchema_Element_ID);
	    }
	    else if ("AC".equals(config.elementType)) {
	        return setDefaultAccount(C_AcctSchema_Element_ID);
	    }
	    
	    return true;
	}

	/**
	 * Set default organization for OO element
	 * @param C_AcctSchema_Element_ID element ID
	 * @return true if updated
	 */
	private boolean setDefaultOrg(int C_AcctSchema_Element_ID)
	{
	    StringBuilder sql = new StringBuilder("UPDATE C_AcctSchema_Element SET Org_ID=");
	    sql.append(AD_Org_ID)
	       .append(" WHERE C_AcctSchema_Element_ID=").append(C_AcctSchema_Element_ID);
	    
	    int no = DB.executeUpdateEx(sql.toString(), trxName);
	    if (no != 1) {
	        log.log(Level.SEVERE, "Default Org in AcctSchemaElement NOT updated");
	        return false;
	    }
	    return true;
	}

	/**
	 * Set default account for AC element
	 * @param C_AcctSchema_Element_ID element ID
	 * @return true if updated
	 */
	private boolean setDefaultAccount(int C_AcctSchema_Element_ID)
	{
	    int C_ElementValue_ID = m_nap.getC_ElementValue_ID("DEFAULT_ACCT");
	    if (log.isLoggable(Level.FINE)) log.fine("C_ElementValue_ID=" + C_ElementValue_ID);
	    
	    // Also need C_Element_ID - get from created element
	    String sql = "SELECT C_Element_ID FROM C_Element WHERE AD_Client_ID=? " +
	                "AND ElementType='AC' AND IsActive='Y'";
	    int C_Element_ID = DB.getSQLValueEx(trxName, sql, AD_Client_ID);
	    
	    StringBuilder updateSql = new StringBuilder("UPDATE C_AcctSchema_Element SET ");
	    updateSql.append("C_ElementValue_ID=").append(C_ElementValue_ID)
	            .append(", C_Element_ID=").append(C_Element_ID)
	            .append(" WHERE C_AcctSchema_Element_ID=").append(C_AcctSchema_Element_ID);
	    
	    int no = DB.executeUpdateEx(updateSql.toString(), trxName);
	    if (no != 1) {
	        log.log(Level.SEVERE, "Default Account in AcctSchemaElement NOT updated");
	        return false;
	    }
	    return true;
	}
	
	/**
	 * Create default accounting records (GL, Default accounts)
	 * @return true if created
	 */
	private boolean createDefaultAccountingRecords()
	{
	    try {
	        createAccountingRecord(X_C_AcctSchema_GL.Table_Name);
	        createAccountingRecord(X_C_AcctSchema_Default.Table_Name);
	        return true;
	    } catch (Exception e) {
	        String err = e.getLocalizedMessage();
	        log.log(Level.SEVERE, err);
	        setupInfo.append(err);
	        return false;
	    }
	}

	
	/**
	 * Create new record for accounting table (M_Product_Acct, M_Product_Category_Acct, etc)
	 * @param tableName
	 * @throws Exception
	 */
	private void createAccountingRecord(String tableName) throws Exception
	{
		MTable table = MTable.get(ctx, tableName);
		PO acct = table.getPO(0, trxName);
		
		MColumn[] cols = table.getColumns(false);
		for (MColumn c : cols) {
			if (!c.isActive())
				continue;
			String columnName = c.getColumnName();
			if (c.isStandardColumn()) {
			}
			else if (DisplayType.Account == c.getAD_Reference_ID()) {
				acct.set_Value(columnName, getAcct(columnName));
				if (log.isLoggable(Level.INFO)) log.info("Account: " + columnName);
			}
			else if (DisplayType.YesNo == c.getAD_Reference_ID()) {
				acct.set_Value(columnName, Boolean.TRUE);
				if (log.isLoggable(Level.INFO)) log.info("YesNo: " + c.getColumnName());
			}
		}
		acct.set_ValueNoCheck("AD_Client_ID", Integer.valueOf(AD_Client_ID)); // setAD_Client_ID is not accessible out of core 
		acct.set_Value(I_C_AcctSchema.COLUMNNAME_C_AcctSchema_ID, acctSchema.getC_AcctSchema_ID());
		//
		if (!acct.save()) {
			throw new AdempiereUserError(CLogger.retrieveErrorString(table.getName() + " not created"));
		}
	}
	
	/**
	 * Create new valid combination for predefine account column
	 * @param key column name
	 * @return C_ValidCombination_ID
	 * @throws AdempiereUserError 
	 */
	private Integer getAcct (String key) throws AdempiereUserError
	{
		if (log.isLoggable(Level.FINE)) log.fine(key);
		//  Element
		int C_ElementValue_ID = m_nap.getC_ElementValue_ID(key.toUpperCase());
		if (C_ElementValue_ID == 0)
		{
			throw new AdempiereUserError("Account not defined: " + key);
		}

		MAccount vc = MAccount.getDefault(acctSchema, true);	//	optional null
		vc.setAD_Org_ID(0);		//	will be overwritten
		vc.setAccount_ID(C_ElementValue_ID);
		if (!vc.save())
		{
			throw new AdempiereUserError("Not Saved - Key=" + key + ", C_ElementValue_ID=" + C_ElementValue_ID);
		}
		int C_ValidCombination_ID = vc.getC_ValidCombination_ID();
		if (C_ValidCombination_ID == 0)
		{
			throw new AdempiereUserError("No account - Key=" + key + ", C_ElementValue_ID=" + C_ElementValue_ID);
		}
		return C_ValidCombination_ID;
	}   //  getAcct
	
	/**
	 * Create GL categories for different document types
	 * @return map of category name to ID, or null if failed
	 */
	private Map<String, Integer> createGLCategories()
	{
	    Map<String, Integer> categories = new HashMap<>();
	    
	    // Standard category (default)
	    int id = createGLCategory("Standard", MGLCategory.CATEGORYTYPE_Manual, true);
	    if (id == 0) 
	    	return null;
	    
	    categories.put("Standard", id);
	    
	    // Document categories
	    categories.put("GL_None", createGLCategory("None", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_GL", createGLCategory("Manual", 
	        MGLCategory.CATEGORYTYPE_Manual, false));
	    categories.put("GL_ARI", createGLCategory("AR Invoice", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_ARR", createGLCategory("AR Receipt", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_MM", createGLCategory("Material Management", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_API", createGLCategory("AP Invoice", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_APP", createGLCategory("AP Payment", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_CASH", createGLCategory("Cash/Payments", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_Manufacturing", createGLCategory("Manufacturing", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_Distribution", createGLCategory("Distribution", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    categories.put("GL_Payroll", createGLCategory("Payroll", 
	        MGLCategory.CATEGORYTYPE_Document, false));
	    
	    return categories;
	}
	
	/**
	 *  Create GL Category
	 *  @param name name
	 *  @param categoryType category type MGLCategory.CATEGORYTYPE_*
	 *  @param isDefault is default flag
	 *  @return GL_Category_ID
	 */
	private int createGLCategory (String name, String categoryType, boolean isDefault)
	{
		MGLCategory cat = new MGLCategory (ctx, 0, trxName);
		cat.setAD_Org_ID(0);
		cat.setName(name);
		cat.setCategoryType(categoryType);
		cat.setIsDefault(isDefault);
		if (!cat.save())
		{
			log.log(Level.SEVERE, "GL Category NOT created - " + name);
			return 0;
		}
		//
		return cat.getGL_Category_ID();
	}   //  createGLCategory
	
	/**
	 * Update client with accounting configuration
	 * @return true if updated
	 */
	private boolean updateClientInfo(int C_Calendar_ID)
	{
	    StringBuilder sql = new StringBuilder("UPDATE AD_ClientInfo SET ");
	    sql.append("C_AcctSchema1_ID=").append(acctSchema.getC_AcctSchema_ID())
	       .append(", C_Calendar_ID=").append(C_Calendar_ID)
	       .append(" WHERE AD_Client_ID=").append(AD_Client_ID);
	    
	    int no = DB.executeUpdateEx(sql.toString(), trxName);
	    if (no != 1) {
	        String err = "ClientInfo not updated";
	        log.log(Level.SEVERE, err);
	        setupInfo.append(err);
	        return false;
	    }
	    
	    return true;
	}
	
	/**
	 * 	Get Next ID
	 * 	@param AD_Client_ID client
	 * 	@param TableName table name
	 * 	@return id
	 */
	private int getNextID (int AD_Client_ID, String TableName)
	{
		//	TODO: Exception 
		return DB.getNextID (AD_Client_ID, TableName, trxName);
	}	//	getNextID
	
	/**
	 * Inner class to hold AcctSchema Element configuration
	 */
	private static class AcctSchemaElementConfig {
	    String elementType;
	    String name;
	    boolean isMandatory;
	    boolean isBalanced;
	    int seqNo;
	    
	    AcctSchemaElementConfig(String elementType, String name, 
	                           boolean isMandatory, boolean isBalanced, int seqNo) {
	        this.elementType = elementType;
	        this.name = name;
	        this.isMandatory = isMandatory;
	        this.isBalanced = isBalanced;
	        this.seqNo = seqNo;
	    }
	}
}
