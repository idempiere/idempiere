package org.compiere.process;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.logging.Level;

import org.compiere.model.MColumn;
import org.compiere.model.MIndexColumn;
import org.compiere.model.MTable;
import org.compiere.model.MTableIndex;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

public class CreateTableIndex extends SvrProcess {

	/** Table 			*/
	private int 		p_AD_Table_ID = 0;
	
	private int			countTable = 0;
	private int			countIndex = 0;
	private int			countError = 0;
	
	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Table_ID"))
				p_AD_Table_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception 
	{
		if (log.isLoggable(Level.INFO)) log.info("AD_Table_ID=" + p_AD_Table_ID);
				
		Trx trx = Trx.get(get_TrxName(), true);
		DatabaseMetaData md = trx.getConnection().getMetaData();
		
		if (p_AD_Table_ID > 0)
		{
			MTable table = new MTable(getCtx(), p_AD_Table_ID, get_TrxName());
			if (table != null)
				processDatabaseTable(md, table);
		}
		else
			processDatabase(md);
		
		trx.close();
		
		return Msg.getMsg(getCtx(), "CreateTableIndexProcessResult", new Object[] {countTable, countIndex, countError});
	}
	
	private void processDatabase(DatabaseMetaData md) throws Exception 
	{
		String tableName = null;		
		String catalog = DB.getDatabase().getCatalog();
		String schema = DB.getDatabase().getSchema();		
		String[] types = {"TABLE"};
		
		ResultSet rs = md.getTables(catalog, schema, tableName, types);
		while (rs.next())
		{
			String dbTableName = rs.getString("TABLE_NAME");			
			if (dbTableName == null)
				continue;
			MTable table = MTable.get(getCtx(), dbTableName);
			if (table != null)	// exists in AD_Table
				processDatabaseTable(md, table);
		}

		rs.close();
	}
	
	private void processDatabaseTable(DatabaseMetaData md, MTable table) throws Exception 
	{
		Hashtable<String, DatabaseTableIndex> htIndexes = new Hashtable<String, DatabaseTableIndex>();
		String catalog = DB.getDatabase().getCatalog();
		String schema = DB.getDatabase().getSchema();
		
		String tableName = table.getTableName();		
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();
		
		addLog(Msg.getMsg(getCtx(), "CreateTableIndexProcessTable") + tableName);
		addLog(table.getAD_Table_ID(), null, null, table.toString(), table.get_Table_ID(), table.getAD_Table_ID());
		++countTable;
		
		ResultSet rs = md.getIndexInfo(catalog, schema, tableName, false, true);
		while (rs.next())
		{
			String dbIndexName = rs.getString("INDEX_NAME");			
			if (dbIndexName == null)
				continue;

			String key = dbIndexName.toLowerCase();
			DatabaseTableIndex dbTableIndex = htIndexes.get(key);
			if (dbTableIndex == null)
				dbTableIndex = new DatabaseTableIndex(dbIndexName, new String[30], true, null);
						
			String columnName = rs.getString("COLUMN_NAME");
			int pos = (rs.getShort("ORDINAL_POSITION"));				
			if (pos > 0)
				dbTableIndex.columns[pos-1] = columnName;
			dbTableIndex.isNonUnique = rs.getBoolean("NON_UNIQUE");
			dbTableIndex.ascOrDesc = rs.getString("ASC_OR_DESC");
			
			htIndexes.put(key, dbTableIndex);
		}

		rs.close();
		
		if (!htIndexes.isEmpty())
			processTableIndex(md, table, htIndexes);
		htIndexes = null;
	}
	
	private void processTableIndex(DatabaseMetaData md, MTable table, Hashtable<String, DatabaseTableIndex> htIndexes) throws Exception 
	{
		String catalog = DB.getDatabase().getCatalog();
		String schema = DB.getDatabase().getSchema();
		
		String tableName = table.getTableName();		
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();
		
		ResultSet rs = md.getPrimaryKeys(catalog, schema, tableName);
		while (rs.next())
		{
			String primaryKeyName = rs.getString("PK_NAME");
			String key = primaryKeyName.toLowerCase();
			DatabaseTableIndex dbTableIndex = htIndexes.get(key);
			if (dbTableIndex != null)
				htIndexes.remove(key);
		}
		rs.close();
		
		if (htIndexes.isEmpty())
			return;
		
		ArrayList<MTableIndex> tableIndexesToValidate = new ArrayList<MTableIndex>();
		
		MTableIndex[] tableIndexes = MTableIndex.get(table);
		for (MTableIndex tableIndex : tableIndexes)
		{
			String key = tableIndex.getName().toLowerCase();
			DatabaseTableIndex dbTableIndex = htIndexes.get(key);
			tableIndexesToValidate.add(tableIndex);
			if (dbTableIndex != null)
				htIndexes.remove(key);
		}
		
		String getColumnIDSql = "SELECT AD_Column_ID FROM AD_Column WHERE AD_Table_ID = ? AND LOWER(ColumnName) = ?";
		Enumeration<DatabaseTableIndex> en = htIndexes.elements();
		while (en.hasMoreElements())
		{			
			DatabaseTableIndex dbTableIndex = en.nextElement();
			addLog(Msg.getMsg(getCtx(), "CreateTableIndexCreateTableIndex") + dbTableIndex.indexName);

			Trx trx = Trx.get(Trx.createTrxName("CreateTableIndex"), true);
			try {
				MTableIndex tableIndex = new MTableIndex(getCtx(), 0, get_TrxName());
				tableIndex.setAD_Table_ID(table.getAD_Table_ID());
				tableIndex.setName(dbTableIndex.indexName);
				tableIndex.setIsUnique(!dbTableIndex.isNonUnique);
				tableIndex.saveEx();
				addLog(tableIndex.getAD_TableIndex_ID(), null, null, tableIndex.toString(), tableIndex.get_Table_ID(), tableIndex.getAD_TableIndex_ID());
				
				for (int i = 0; i < 30; i++)
				{
					String dbIndexColumn = dbTableIndex.columns[i];
					if (dbIndexColumn == null)
						break;
					int AD_Column_ID = DB.getSQLValue(null, getColumnIDSql, table.getAD_Table_ID(), dbIndexColumn.toLowerCase());
					String columnName = dbIndexColumn;
					
					if (AD_Column_ID > 0)
						columnName = MColumn.getColumnName(getCtx(), AD_Column_ID);
						
					MIndexColumn indexColumn = new MIndexColumn(getCtx(), 0, get_TrxName());
					indexColumn.setAD_TableIndex_ID(tableIndex.getAD_TableIndex_ID());
					if (AD_Column_ID > 0)
						indexColumn.setAD_Column_ID(AD_Column_ID);
					else
						indexColumn.setColumnSQL(columnName);
					String ascOrDesc = dbTableIndex.ascOrDesc;
					if (ascOrDesc != null && ascOrDesc.equals("D"))
						indexColumn.setColumnSQL(columnName + " DESC");
					indexColumn.setSeqNo(i + 1);
					indexColumn.saveEx();
					addLog(indexColumn.getAD_IndexColumn_ID(), null, null, indexColumn.toString(), indexColumn.get_Table_ID(), indexColumn.getAD_IndexColumn_ID());
				}
				
				if (trx != null)
					trx.commit();
				++countIndex;
			} catch (Exception e) {
				addLog(Msg.getMsg(getCtx(), "Error") + e.getLocalizedMessage());
				if (trx != null)
					trx.rollback();
				++countError;
			} finally {
				if (trx != null)
					trx.close();
			}
		}
		
		for (MTableIndex tableIndex : tableIndexesToValidate)
		{
			addLog(Msg.getMsg(getCtx(), "CreateTableIndexValidateTableIndex") + tableIndex.getName());
			addLog(tableIndex.getAD_TableIndex_ID(), null, null, tableIndex.toString(), tableIndex.get_Table_ID(), tableIndex.getAD_TableIndex_ID());
			Trx trx = Trx.get(Trx.createTrxName("ValidateTableIndex"), true);
			try {
				String result = TableIndexValidate.validateTableIndex(getCtx(), tableIndex, trx.getTrxName(), getProcessInfo());
				addLog(result);
				if (trx != null)
					trx.commit();
				++countIndex;
			} catch (Exception e) {
				addLog(Msg.getMsg(getCtx(), "Error") + e.getLocalizedMessage());
				if (trx != null)
					trx.rollback();
				++countError;
			} finally {
				if (trx != null)
					trx.close();
			}
		}
	}
	
	private class DatabaseTableIndex
	{
		private String indexName;
		private String[] columns;
		private boolean isNonUnique;
		private String ascOrDesc;
		
		private DatabaseTableIndex(String indexName, String[] columns, boolean isNonUnique, String ascOrDesc)
		{
			this.indexName = indexName;
			this.columns = columns;
			this.isNonUnique = isNonUnique;
			this.ascOrDesc = ascOrDesc;
		}
	}
}
