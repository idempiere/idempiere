package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Util;

public class MPackageMPS extends X_M_PackageMPS
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2426722699419960060L;

    /**
    * UUID based Constructor
    * @param ctx  Context
    * @param M_PackageMPS_UU  UUID key
    * @param trxName Transaction
    */
    public MPackageMPS(Properties ctx, String M_PackageMPS_UU, String trxName) {
        super(ctx, M_PackageMPS_UU, trxName);
		if (Util.isEmpty(M_PackageMPS_UU))
			setInitialDefaults(ctx);
    }

	public MPackageMPS(Properties ctx, int M_PackageMPS_ID, String trxName)
	{
		super(ctx, M_PackageMPS_ID, trxName);
		if (M_PackageMPS_ID == 0)
			setInitialDefaults(ctx);
	}
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults(Properties ctx) {
		MClientInfo clientInfo = MClientInfo.get(ctx, getAD_Client_ID());
		setC_UOM_Weight_ID(clientInfo.getC_UOM_Weight_ID());
		setC_UOM_Length_ID(clientInfo.getC_UOM_Length_ID());
	}

	public MPackageMPS(Properties ctx, ResultSet rs, String trxName) 
	{
		super(ctx, rs, trxName);
	}
	
	protected boolean beforeSave(boolean newRecord)
	{
		if (getSeqNo() == 0)
		{
			String sql = "SELECT COALESCE(MAX(SeqNo),0)+10 FROM M_PackageMPS WHERE M_Package_ID=?";
			int ii = DB.getSQLValue (get_TrxName(), sql, getM_Package_ID());
			setSeqNo(ii);
		}
		
		if (getWeight() == null || getWeight().compareTo(BigDecimal.ZERO) == 0)
		{
			String sql = "SELECT SUM(LineWeight) FROM X_PackageLineWeight plw WHERE plw.M_PackageMPS_ID=?";
			BigDecimal weight = DB.getSQLValueBD(get_TrxName(), sql, getM_PackageMPS_ID());
			if (weight == null)
				weight = BigDecimal.ZERO;
			setWeight(weight);
		}
		
		return true;
	}

	protected boolean beforeDelete()
	{
		String sql = "DELETE FROM M_PackageLine WHERE M_PackageMPS_ID = ?";
		DB.executeUpdate(sql, getM_PackageMPS_ID(), get_TrxName());
		return true;
	}
}
