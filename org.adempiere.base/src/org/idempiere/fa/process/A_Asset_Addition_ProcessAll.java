package org.idempiere.fa.process;

import org.compiere.model.MAssetAddition;
import org.compiere.model.POResultSet;
import org.compiere.model.Query;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;


/**
 * Process All (not processed) Additions
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
@org.adempiere.base.annotation.Process
public class A_Asset_Addition_ProcessAll extends SvrProcess
{
	
	protected void prepare() {
	}
	
	protected String doIt() throws Exception {
		int cnt_ok = 0, cnt_err = 0;
		//
		String whereClause = "AD_Client_ID=? AND IsActive=?"
								+" AND "+MAssetAddition.COLUMNNAME_Processed+"=?";
		POResultSet<MAssetAddition>	rs = null;
		try {
			rs = new Query(getCtx(), MAssetAddition.Table_Name, whereClause, get_TrxName())
			.setParameters(new Object[]{getAD_Client_ID(), "N", "N"})
			.scroll();
			while (rs.hasNext()) {
				MAssetAddition a = rs.next();
				boolean ret = a.processIt(MAssetAddition.DOCACTION_Complete);
				if (ret)
					cnt_ok++;
				else
					cnt_err++;
			}
		}
		finally {
			DB.close(rs); rs = null;
		}
		//
		return "OK/Error: "+cnt_ok+"/"+cnt_err;
	}
}
