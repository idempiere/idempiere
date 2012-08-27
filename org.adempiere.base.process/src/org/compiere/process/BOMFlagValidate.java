package org.compiere.process;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import org.compiere.model.MProduct;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;


public class BOMFlagValidate extends SvrProcess {

	/** Product Category	*/
	private int		p_M_Product_Category_ID = 0;
	
	
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_Product_Category_ID"))
				p_M_Product_Category_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception {
		
		flagNonBOMs();
		flagBOMs();
		return "@OK@";
	}
	
	private void flagNonBOMs() throws SQLException
	{
		
		//Select Products where there's a BOM, and there are no lines
		String sql = "SELECT Name, M_Product_ID FROM M_Product WHERE IsBOM = 'Y' AND " + 
		"M_Product_ID NOT IN (SELECT M_Product_ID FROM M_Product_BOM ) AND "; 
		if (p_M_Product_Category_ID == 0)
			sql += "AD_Client_ID= ?";
	        
		else
			sql += "M_Product_Category_ID= ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement (sql, get_TrxName());
			if (p_M_Product_Category_ID == 0)
				pstmt.setInt (1, Env.getAD_Client_ID(getCtx()));
			else
				pstmt.setInt(1, p_M_Product_Category_ID);
			rs = pstmt.executeQuery ();

			while (rs.next())
			{
				addLog(0, null, null, rs.getString(1) + " BOM without BOM lines", MProduct.Table_ID, rs.getInt(2));
			}
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		PreparedStatement upstmt = null;
		try {
			String update = "UPDATE M_Product SET IsBOM = 'N' WHERE IsBOM = 'Y' AND M_Product_ID NOT IN " +
					"(SELECT M_Product_ID FROM M_Product_BOM ) AND "; 
			if (p_M_Product_Category_ID == 0)
				update += "AD_Client_ID= ?";
			else
				update += "M_Product_Category_ID= ?";
			upstmt = DB.prepareStatement (update, get_TrxName());
			if (p_M_Product_Category_ID == 0)
				upstmt.setInt (1, Env.getAD_Client_ID(getCtx()));
			else
				upstmt.setInt(1, p_M_Product_Category_ID);
			upstmt.executeUpdate();
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(upstmt);
			upstmt = null;
		}
		
	}
	
	private void flagBOMs() throws Exception
	{
		
		//Select Products where there's a BOM, and there are no lines
		String sql = "SELECT Name, M_Product_ID FROM M_Product WHERE IsBOM = 'N' AND " + 
		"M_Product_ID IN (SELECT M_Product_ID FROM M_Product_BOM ) AND "; 
		if (p_M_Product_Category_ID == 0)
			sql += "AD_Client_ID= ?";
	        
		else
			sql += "M_Product_Category_ID= ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement (sql, get_TrxName());
			if (p_M_Product_Category_ID == 0)
				pstmt.setInt (1, Env.getAD_Client_ID(getCtx()));
			else
				pstmt.setInt(1, p_M_Product_Category_ID);
			rs = pstmt.executeQuery ();

			while (rs.next())
			{
				addLog(0, null, null, rs.getString(1) + " not BOM with BOM lines", MProduct.Table_ID, rs.getInt(2));
			}
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		String update = "UPDATE M_Product SET ISBOM = 'Y' WHERE IsBOM = 'N' AND M_Product_ID IN " +
				"(SELECT M_Product_ID FROM M_Product_BOM ) AND "; 
		if (p_M_Product_Category_ID == 0)
			update += "AD_Client_ID= ?";
		else
			update += "M_Product_Category_ID= ?";
		PreparedStatement upstmt = null;
		try {
			upstmt = DB.prepareStatement (update, get_TrxName());
			if (p_M_Product_Category_ID == 0)
				upstmt.setInt (1, Env.getAD_Client_ID(getCtx()));
			else
				upstmt.setInt(1, p_M_Product_Category_ID);
			upstmt.executeUpdate();
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(upstmt);
			upstmt = null;
		}
		
	}

}
