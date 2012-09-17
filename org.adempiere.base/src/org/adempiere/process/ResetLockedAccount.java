package org.adempiere.process;

import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;

public class ResetLockedAccount extends SvrProcess {

	private int p_AD_Client_ID = 0;
	private int p_AD_User_ID = 0;

	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (ProcessInfoParameter element : para) 
		{
			String name = element.getParameterName();
			if (element.getParameter() == null
					&& element.getParameter_To() == null)
				;
			else if (name.equals("AD_Client_ID"))
				p_AD_Client_ID = element.getParameterAsInt();
			else if (name.equals("AD_User_ID"))
				p_AD_User_ID = element.getParameterAsInt();
			else
				log.log(Level.INFO, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception 
	{
		if (p_AD_Client_ID == 0)
			p_AD_Client_ID = Env.getAD_Client_ID(getCtx());
		
		if (p_AD_User_ID > 0) 
		{
			MUser user = new MUser(getCtx(), p_AD_User_ID, null);
			
			if (!user.isLocked())
				throw new AdempiereException("User " + user.getName() + " is not locked");

			StringBuffer sql = new StringBuffer ("UPDATE AD_User SET IsLocked = 'N', DateAccountLocked=NULL, FailedLoginCount=0, DateLastLogin=NULL, Updated=SysDate ")
					.append(" WHERE IsLocked='Y' AND AD_Client_ID = ? ")
					.append(" AND DateAccountLocked IS NOT NULL ")
					.append(" AND AD_User_ID = " + user.getAD_User_ID());
			int no = DB.executeUpdate(sql.toString(), new Object[] { p_AD_Client_ID }, false, get_TrxName());
			if (no < 0)
				throw new AdempiereException("Could not unlock user account" + user.toString());

			return "@OK@ - The user '" + user.getName() + "' has been unlocked";
		} 
		else 
		{
			int MAX_ACCOUNT_LOCK_MINUTES = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES, 0);
			int MAX_INACTIVE_PERIOD = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_INACTIVE_PERIOD_DAY, 0);
			
			StringBuffer sql = new StringBuffer("UPDATE AD_User SET IsLocked = 'N', DateAccountLocked=NULL, FailedLoginCount=0, DateLastLogin=NULL, Updated=SysDate ")
					.append(" WHERE IsLocked='Y' AND AD_Client_ID IN (0, ?) ")
					.append(" AND DateAccountLocked IS NOT NULL");
			
			if (DB.isPostgreSQL())
			{
				if (MAX_ACCOUNT_LOCK_MINUTES > 0)
					sql.append( " AND EXTRACT(MINUTE FROM (now()-DateAccountLocked)) * 24 * 60 > ").append(MAX_ACCOUNT_LOCK_MINUTES);
				if (MAX_INACTIVE_PERIOD > 0)
					sql.append(" AND EXTRACT(DAY FROM (now()-DateLastLogin)) * 24 <= ").append(MAX_INACTIVE_PERIOD);
			}
			else
			{
				if (MAX_ACCOUNT_LOCK_MINUTES > 0)
					sql.append(" AND (SysDate-DateAccountLocked) * 24 * 60 > ").append(MAX_ACCOUNT_LOCK_MINUTES);
				if (MAX_INACTIVE_PERIOD > 0)
					sql.append(" AND (SysDate-DateLastLogin) * 24 <= ").append(MAX_INACTIVE_PERIOD);
			}
			
			int no = DB.executeUpdate(sql.toString(), p_AD_Client_ID, get_TrxName());
			if (no < 0)
				throw new AdempiereException("Could not unlock user account");
			return no + " locked account has been reset";
		}
	}
}