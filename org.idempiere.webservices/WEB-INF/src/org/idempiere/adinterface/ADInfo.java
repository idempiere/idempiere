package org.idempiere.adinterface;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.idempiere.adInterface.x10.DataRow;

public interface ADInfo {
  public void setParameters( PreparedStatement pstmt, boolean forCount) throws SQLException;
  //public String getSQLWhere();
  public String getSQL();
  public String getSQLCount();
  
  public DataRow getColumns();
  
}
