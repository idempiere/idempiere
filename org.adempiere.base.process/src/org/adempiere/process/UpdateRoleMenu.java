package org.adempiere.process;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.MRoleMenu;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;

@org.adempiere.base.annotation.Process
public class UpdateRoleMenu extends SvrProcess
{
	private int p_role_id = 0;
	
	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Role_ID"))
			{
				p_role_id = para[i].getParameterAsInt();
			}
			else
			{
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			}
		}

	}
	
	private MRoleMenu addUpdateRole(Properties ctx, int roleId, int menuId, boolean active, String trxName)
	{
		StringBuilder whereClause = new StringBuilder("AD_Role_ID=").append(roleId).append(" AND U_WebMenu_ID=").append(menuId);
		
		int roleMenuIds[] = MRoleMenu.getAllIDs(MRoleMenu.Table_Name, whereClause.toString(), trxName);
		
		
		MRoleMenu roleMenu;
		if ( roleMenuIds.length == 1)
		{
			roleMenu = new MRoleMenu(ctx, roleMenuIds[0],trxName);
		}
		else if ( roleMenuIds.length == 0)
		{
			roleMenu = new MRoleMenu(ctx, 0,trxName);
		}
		else
		{
			throw new IllegalStateException("More than one role menu defined.");
		}
		
		roleMenu.setAD_Role_ID(roleId);
		roleMenu.setU_WebMenu_ID(menuId);
		roleMenu.setIsActive(active);
		
		if (!roleMenu.save())
		{
			throw new IllegalStateException("Could not create/update role menu, RoleMenuId: " + roleMenu.get_ID());
		}
		
		return roleMenu;
	}
	
	@Override
	protected String doIt() throws Exception 
	{
		if (p_role_id == 0)
		{
			throw new Exception("No Role defined or cannot assign menus to System Administrator");
		}
		
		String sqlStmt = "SELECT U_WebMenu_ID, IsActive FROM U_WebMenu";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try
		{
			pstmt = DB.prepareStatement(sqlStmt, get_TrxName());
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				int menuId = rs.getInt(1);
				boolean active = "Y".equals(rs.getString(2));
				addUpdateRole(getCtx(), p_role_id, menuId, active, get_TrxName());
			}
			commitEx();
		}
		catch (Exception ex)
		{
			rollback();
			throw ex;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return "Role updated successfully";
	}
}
