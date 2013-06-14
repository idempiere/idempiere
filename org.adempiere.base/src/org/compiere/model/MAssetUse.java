package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.MRefList;
import org.compiere.util.DB;
/** Generated Model for A_Asset_Use
 ** @version $Id: X_A_Asset.java,v 1.88 2004/08/27 21:26:37 jjanke Exp $ */
public class MAssetUse extends X_A_Asset_Use
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1247516669047870893L;

	public MAssetUse (Properties ctx, int A_Asset_Use_ID, String trxName)
	{
		super (ctx, A_Asset_Use_ID, trxName);
		if (A_Asset_Use_ID == 0)
		{
			// empty block
		}
	}	//	MAssetUse

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 */
	public MAssetUse (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MAssetUse

/**
 * 	After Save
 *	@param newRecord new
 *	@return true
 */
protected boolean afterSave (boolean newRecord,boolean success)
{
	log.info ("afterSave");
	if (!success)
		return success;
	int		p_A_Asset_ID = 0;
	int		total_unitsused = 0;	
	p_A_Asset_ID = getA_Asset_ID();
	
	
	String sql = "SELECT SUM(USEUNITS) FROM A_Asset_use WHERE A_Asset_ID=? and usedate <= SYSDATE";
	total_unitsused = DB.getSQLValueEx(null, sql, getA_Asset_ID());
	
	MAsset asset = MAsset.get(getCtx(), p_A_Asset_ID, null);
	asset.setUseUnits(total_unitsused);
	asset.setProcessing(false);	
	asset.saveEx();
	
	
	MAssetChange change = new MAssetChange (getCtx(), 0,null);
		
	change.setA_Asset_ID(p_A_Asset_ID);            
	change.setChangeType("USE");
	change.setTextDetails(MRefList.getListDescription (getCtx(),"A_Update_Type" , "USE"));
	change.setUseUnits(getUseUnits());
	change.saveEx();
	
	return success;
	 
	
}	//	afterSave



}
