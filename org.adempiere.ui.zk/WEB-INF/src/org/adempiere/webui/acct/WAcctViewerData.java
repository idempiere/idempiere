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

/**
 * 2007, Modified by Posterita Ltd.
 */

package org.adempiere.webui.acct;

import static org.compiere.model.SystemIDs.REFERENCE_POSTING_TYPE;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.webui.component.Listbox;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MFactAcct;
import org.compiere.model.MJournal;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRefList;
import org.compiere.model.SystemIDs;
import org.compiere.report.core.RColumn;
import org.compiere.report.core.RModel;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;

/**
 *  State and data access helper for {@link WAcctViewer}
 *
 *  @author Niraj Sohun
 *  		July 27, 2007
 */

public class WAcctViewerData
{
	/** Window              */
	public int WindowNo;
	
	/** Client				*/
	public int AD_Client_ID;
	
	/** All Accounting Schemas for client		*/
	public MAcctSchema[] ASchemas = null;
	
	/** Selected Accounting Schema	*/
	public MAcctSchema ASchema = null;

	//  Selection Info
	
	/** Document Query - query with {@link #AD_Table_ID} and {@link #Record_ID}	*/
	public boolean documentQuery = false;
	
	/** Selected Accounting Schema ID		*/
	public int C_AcctSchema_ID = 0;
	
	/** Selected Posting Type	*/
	public String PostingType = "";
	
	/** Selected Organization ID */
	public int AD_Org_ID = 0;
	
	/** Date From, for DateAcct filter */
	public Timestamp DateFrom = null;
	
	/** Date To, for DateAcct filter */
	public Timestamp DateTo = null;

	//  Document Table Selection Info
	
	/** Selected Table ID for {@link #documentQuery} */
	public int AD_Table_ID;
	
	/** Selected Record ID for {@link #documentQuery} */
	public int Record_ID;

	/** ColumnName:Filter */
	public HashMap<String,String> whereInfo = new HashMap<String,String>();
	
	/** TableName:AD_Table_ID */
	public HashMap<String,Integer> tableInfo = new HashMap<String,Integer>();

	//  Display Info
	
	/** Display Qty	Columns		*/
	protected boolean displayQty = false;
	
	/** Display Source Amount Columns */
	protected boolean displaySourceAmt = false;
	
	/** Display Document info	*/
	protected boolean displayDocumentInfo = false;

	//order by
	protected String sortBy1 = "";
	protected String sortBy2 = "";
	protected String sortBy3 = "";
	protected String sortBy4 = "";

	//group by
	protected boolean group1 = false;
	protected boolean group2 = false;
	protected boolean group3 = false;
	protected boolean group4 = false;

	/** Leading Columns. Number of columns shown before Accounted and Source Amount Columns.	*/
	private int m_leadingColumns = 0;
	
	/** UserElement1 Reference	*/
	private String m_ref1 = null;
	
	/** UserElement2 Reference	*/
	private String m_ref2 = null;
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WAcctViewerData.class);

	/**
	 *  Constructor
	 *	@param ctx context
	 *  @param windowNo window no
	 *  @param ad_Client_ID client
	 * 	@param ad_Table_ID table
	 */
	public WAcctViewerData (Properties ctx, int windowNo, int ad_Client_ID, int ad_Table_ID)
	{
		WindowNo = windowNo;
		AD_Client_ID = ad_Client_ID;
		
		if (AD_Client_ID == 0)
			AD_Client_ID = Env.getContextAsInt(Env.getCtx(), WindowNo, "AD_Client_ID");
		
		if (AD_Client_ID == 0)
			AD_Client_ID = Env.getContextAsInt(Env.getCtx(), "AD_Client_ID");
		
		AD_Table_ID = ad_Table_ID;

		ASchemas = MAcctSchema.getClientAcctSchema(ctx, AD_Client_ID);
		ASchema = ASchemas[0];
	} // AcctViewerData
	
	/**
	 *  Dispose
	 */	
	public void dispose()
	{
		ASchemas = null;
		ASchema = null;

		whereInfo.clear();
		whereInfo = null;

		Env.clearWinContext(WindowNo);
	} // dispose
	
	/**
	 * GL Journal only posts in one Accounting Schema.
	 * If the record is a GL Journal, remove the other accounting schema from {@link #ASchemas}
	 * @param Record_ID
	 */
	protected void validateAcctSchemas(int Record_ID)
	{
		if (Record_ID > 0 && AD_Table_ID == MJournal.Table_ID) {
			MJournal journal = new MJournal(Env.getCtx(), Record_ID, null);
			
			if (journal.getGL_Journal_ID() == Record_ID) {
				ASchemas = new MAcctSchema[1];
				ASchemas[0] = MAcctSchema.get(Env.getCtx(), journal.getC_AcctSchema_ID());
				ASchema = ASchemas[0];
			}
		}
	} // validateAcctSchemas
	
	/**
	 *  Fill Accounting Schema
	 *  @param cb Listbox to be filled
	 */	
	protected void fillAcctSchema (Listbox cb)
	{
		for (int i = 0; i < ASchemas.length; i++)
		{
			KeyNamePair key = new KeyNamePair(ASchemas[i].getC_AcctSchema_ID(), ASchemas[i].getName());
			cb.appendItem(key.getName(), key);
		}
	} // fillAcctSchema
	
	/**
	 *  Fill Posting Type from {@link SystemIDs#REFERENCE_POSTING_TYPE} list.
	 *  @param cb Listbox to be filled
	 */	
	protected void fillPostingType (Listbox cb)
	{
		int AD_Reference_ID = REFERENCE_POSTING_TYPE;
		ValueNamePair[] pt = MRefList.getList(Env.getCtx(), AD_Reference_ID, true);
		
		for (int i = 0; i < pt.length; i++)
		{
			cb.appendItem(pt[i].getName(), pt[i]);
		}
	} // fillPostingType
	
	/**
	 *  Fill Listbox with
	 *      ValueNamePair (TableName, translatedKeyColumnName)
	 *  and {@link #tableInfo} with (TableName, AD_Table_ID)
	 *  and select the entry for AD_Table_ID
	 *
	 *  @param cb Listbox to be filled
	 */	
	protected void fillTable (Listbox cb)
	{
		String sql = "SELECT AD_Table_ID, TableName FROM AD_Table t "
			+ "WHERE EXISTS (SELECT * FROM AD_Column c"
			+ " WHERE t.AD_Table_ID=c.AD_Table_ID AND c.ColumnName='Posted')"
			+ " AND IsView='N'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
		
			while (rs.next())
			{
				int id = rs.getInt(1);
				String tableName = rs.getString(2);
				String name = Msg.translate(Env.getCtx(), tableName+"_ID");

				ValueNamePair pp = new ValueNamePair(tableName, name);
				cb.appendItem(pp.getName(),pp);
				tableInfo.put (tableName, Integer.valueOf(id));				
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
	} // fillTable
	
	/**
	 *  Fill Org
	 *
	 *  @param cb Listbox to be filled
	 */	
	protected void fillOrg (Listbox cb)
	{
		KeyNamePair pp = new KeyNamePair(0, "");
		cb.appendItem(pp.getName(), pp);
		String sql = "SELECT AD_Org_ID, Name FROM AD_Org WHERE AD_Client_ID=? ORDER BY Value";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Client_ID);
			rs = pstmt.executeQuery();
		
			while (rs.next())
			{
				KeyNamePair key = new KeyNamePair(rs.getInt(1), rs.getString(2)); 
				cb.appendItem(key.getName(), key);
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
	} // fillOrg
	
	/**
	 *  Get Info Button Text
	 *
	 *  @param tableName table
	 *  @param columnName column
	 *  @param selectSQL sql
	 *  @return Text on button
	 */
	
	protected String getButtonText (String tableName, String columnName, String selectSQL)
	{
		//  SELECT (<embedded>) FROM tableName avd WHERE avd.<selectSQL>
		
		StringBuilder sql = new StringBuilder ("SELECT (");
		Language language = Env.getLanguage(Env.getCtx());
		
		sql.append(MLookupFactory.getLookup_TableDirEmbed(language, columnName, "avd"))
			.append(") FROM ").append(tableName).append(" avd WHERE avd.").append(selectSQL);
		String retValue = "<" + selectSQL + ">";

		Statement stmt = null;
		ResultSet rs = null;
		try
		{
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql.toString());

			if (rs.next())
				retValue = rs.getString(1);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, stmt);
			rs = null;
			stmt = null;
		}
		return retValue;
	} // getButtonText

	/**
	 *  Create query and execute
	 *  @return {@link RModel} query result
	 */
	
	protected RModel query()
	{
		//  Set Where Clause
	
		StringBuilder whereClause = new StringBuilder();
		
		//  Add Organization
		
		if (C_AcctSchema_ID != 0)
			whereClause.append(RModel.TABLE_ALIAS).append(".C_AcctSchema_ID=").append(C_AcctSchema_ID);

		//	Posting Type Selected

		if (PostingType != null && PostingType.length() > 0)
		{
			if (whereClause.length() > 0)
				whereClause.append(" AND ");
		
			whereClause.append(RModel.TABLE_ALIAS)
				.append(".PostingType='").append(PostingType).append("'");
		}
		
		if (documentQuery)
		{
			if (whereClause.length() > 0)
				whereClause.append(" AND ");

			whereClause.append(RModel.TABLE_ALIAS).append(".AD_Table_ID=").append(AD_Table_ID)
				.append(" AND ").append(RModel.TABLE_ALIAS).append(".Record_ID=").append(Record_ID);
		}
		else
		{
			//  get values (Queries)
			
			Iterator<String> it = whereInfo.values().iterator();
			
			while (it.hasNext())
			{
				String where = it.next();
			
				if (where != null && where.length() > 0)    //  add only if not empty
				{
					if (whereClause.length() > 0)
						whereClause.append(" AND ");
				
					whereClause.append(RModel.TABLE_ALIAS).append(".").append(where);
				}
			}
			
			if (DateFrom != null || DateTo != null)
			{
				if (whereClause.length() > 0)
					whereClause.append(" AND ");
			
				if (DateFrom != null && DateTo != null)
					whereClause.append("TRUNC(").append(RModel.TABLE_ALIAS).append(".DateAcct) BETWEEN ")
						.append(DB.TO_DATE(DateFrom)).append(" AND ").append(DB.TO_DATE(DateTo));
				else if (DateFrom != null)
					whereClause.append("TRUNC(").append(RModel.TABLE_ALIAS).append(".DateAcct) >= ")
						.append(DB.TO_DATE(DateFrom));
				else    //  DateTo != null
					whereClause.append("TRUNC(").append(RModel.TABLE_ALIAS).append(".DateAcct) <= ")
						.append(DB.TO_DATE(DateTo));
			}
			
			//  Add Organization
			
			if (AD_Org_ID != 0)
			{
				if (whereClause.length() > 0)
					whereClause.append(" AND ");
			
				whereClause.append(RModel.TABLE_ALIAS).append(".AD_Org_ID=").append(AD_Org_ID);
			}
		}

		//  Set Order By Clause
		
		StringBuilder orderClause = new StringBuilder();
		
		if (sortBy1.length() > 0)
			orderClause.append(RModel.TABLE_ALIAS).append(".").append(sortBy1);
		
		if (sortBy2.length() > 0)
		{
			if (orderClause.length() > 0)
				orderClause.append(",");
			orderClause.append(RModel.TABLE_ALIAS).append(".").append(sortBy2);
		}
		
		if (sortBy3.length() > 0)
		{
			if (orderClause.length() > 0)
				orderClause.append(",");
			orderClause.append(RModel.TABLE_ALIAS).append(".").append(sortBy3);
		}
		
		if (sortBy4.length() > 0)
		{
			if (orderClause.length() > 0)
				orderClause.append(",");
			orderClause.append(RModel.TABLE_ALIAS).append(".").append(sortBy4);
		}
		
		if (orderClause.length() == 0)
			orderClause.append(RModel.TABLE_ALIAS).append(".Fact_Acct_ID");

		RModel rm = getRModel();

		//  Groups

		if ((group1 || group2 || group3 || group4) && sortBy1.length() > 0)
			rm.setGroup(sortBy1);
		
		if ((group2 || group3 || group4) && sortBy2.length() > 0)
			rm.setGroup(sortBy2);
		
		if ((group3 || group4) && sortBy3.length() > 0)
			rm.setGroup(sortBy3);
		
		if (group4 && sortBy4.length() > 0)
			rm.setGroup(sortBy4);

		//  Totals
		
		rm.setFunction("AmtAcctDr", RModel.FUNCTION_SUM);
		rm.setFunction("AmtAcctCr", RModel.FUNCTION_SUM);

		rm.query (Env.getCtx(), whereClause.toString(), orderClause.toString());

		return rm;
	} // query

	/**
	 *  Create new Report Model (Setup Columns) instance
	 *  @return {@link RModel}
	 */	
	private RModel getRModel()
	{
		Properties ctx = Env.getCtx();
		RModel rm = new RModel("Fact_Acct");
	
		//  Add Key (Lookups)
		
		ArrayList<String> keys = createKeyColumns();
		int max = m_leadingColumns;
		
		if (max == 0)
			max = keys.size();
		
		for (int i = 0; i < max; i++)
		{
			String column = keys.get(i);
		
			if (column != null && column.startsWith("Date"))
				rm.addColumn(new RColumn(ctx, column, DisplayType.Date));
			else if (column != null && column.endsWith("_ID"))
				rm.addColumn(new RColumn(ctx, column, DisplayType.TableDir));
		}
		
		//  Main Info
		
		rm.addColumn(new RColumn(ctx, "AmtAcctDr", DisplayType.Amount));
		rm.addColumn(new RColumn(ctx, "AmtAcctCr", DisplayType.Amount));
		
		if (displaySourceAmt)
		{
			if (!keys.contains("DateTrx"))
				rm.addColumn(new RColumn(ctx, "DateTrx", DisplayType.Date));
			rm.addColumn(new RColumn(ctx, "C_Currency_ID", DisplayType.TableDir));
			rm.addColumn(new RColumn(ctx, "AmtSourceDr", DisplayType.Amount));
			rm.addColumn(new RColumn(ctx, "AmtSourceCr", DisplayType.Amount));
			rm.addColumn(new RColumn(ctx, "Rate", DisplayType.Amount,
				"CASE WHEN (AmtSourceDr + AmtSourceCr) = 0 THEN 0"
				+ " ELSE (AmtAcctDr + AmtAcctCr) / (AmtSourceDr + AmtSourceCr) END"));
		}
		
		//	Remaining Keys
		
		for (int i = max; i < keys.size(); i++)
		{
			String column = keys.get(i);
		
			if (column != null && column.startsWith("Date"))
				rm.addColumn(new RColumn(ctx, column, DisplayType.Date));
			else if (column!=null && column.startsWith("UserElement"))
			{
				if (column.indexOf('1') != -1)
					rm.addColumn(new RColumn(ctx, column, DisplayType.TableDir, null, 0, m_ref1));
				else
					rm.addColumn(new RColumn(ctx, column, DisplayType.TableDir, null, 0, m_ref2));
			}
			else if (column != null && column.endsWith("_ID"))
				rm.addColumn(new RColumn(ctx, column, DisplayType.TableDir));
		}
		
		//	Info
		
		if (!keys.contains("DateAcct"))
			rm.addColumn(new RColumn(ctx, "DateAcct", DisplayType.Date));
		
		if (!keys.contains("C_Period_ID"))
			rm.addColumn(new RColumn(ctx, "C_Period_ID", DisplayType.TableDir));
		
		if (displayQty)
		{
			rm.addColumn(new RColumn(ctx, "C_UOM_ID", DisplayType.TableDir));
			rm.addColumn(new RColumn(ctx, "Qty", DisplayType.Quantity));
		}
		
		rm.addColumn(new RColumn(ctx, "AD_Table_ID", DisplayType.TableDir));
		rm.addColumn(new RColumn(ctx, "Record_ID", DisplayType.ID));
		rm.addColumn(new RColumn(ctx, "Fact_Acct_ID", DisplayType.ID));
		if (displayDocumentInfo)
		{			
			rm.addColumn(new RColumn(ctx, "Description", DisplayType.String));
		}
		
		if (PostingType == null || PostingType.length() == 0)
			rm.addColumn(new RColumn(ctx, "PostingType", DisplayType.List, // teo_sarca, [ 1664208 ]
					RModel.TABLE_ALIAS+".PostingType",
					MFactAcct.POSTINGTYPE_AD_Reference_ID,
					null));
		return rm;
	} // createRModel
	
	/**
	 *  Create the list of key/mandatory columns to display in viewer
	 *  @return List of Key Columns
	 */
	private ArrayList<String> createKeyColumns()
	{
		ArrayList<String> columns = new ArrayList<String>();
		m_leadingColumns = 0;
		
		//  Sorting Fields
		
		columns.add(sortBy1);               //  may add ""
		
		if (!columns.contains(sortBy2))
			columns.add(sortBy2);
		if (!columns.contains(sortBy3))
			columns.add(sortBy3);
		if (!columns.contains(sortBy4))
			columns.add(sortBy4);

		//  Add Account Segments
		
		MAcctSchemaElement[] elements = ASchema.getAcctSchemaElements();
		
		for (int i = 0; i < elements.length; i++)
		{
			if (m_leadingColumns == 0 && columns.contains("AD_Org_ID") && columns.contains("Account_ID"))
				m_leadingColumns = columns.size();

			MAcctSchemaElement ase = elements[i];
			String columnName = ase.getColumnName();
			
			if (columnName.startsWith("UserElement"))
			{
				if (columnName.indexOf('1') != -1)
					m_ref1 = ase.getDisplayColumnName();
				else
					m_ref2 = ase.getDisplayColumnName();
			}
			
			if (!columns.contains(columnName))
				columns.add(columnName);
		}
		
		if (m_leadingColumns == 0 && columns.contains("AD_Org_ID") && columns.contains("Account_ID"))
			m_leadingColumns = columns.size();
		return columns;
	} // createKeyColumns	
}
