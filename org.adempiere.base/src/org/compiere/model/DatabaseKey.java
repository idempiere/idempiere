package org.compiere.model;

public class DatabaseKey
{
	private String keyName;
	private String keyTable;
	private String[] keyColumns;
	
	public DatabaseKey(String keyName, String keyTable, String[] keyColumns)
	{
		this.keyName = keyName;
		this.keyTable = keyTable;
		this.keyColumns = keyColumns;
	}

	public String getKeyName() {
		return keyName;
	}

	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}

	public String getKeyTable() {
		return keyTable;
	}

	public void setKeyTable(String keyTable) {
		this.keyTable = keyTable;
	}

	public String[] getKeyColumns() {
		return keyColumns;
	}

	public void setKeyColumns(String[] keyColumns) {
		this.keyColumns = keyColumns;
	}
}
