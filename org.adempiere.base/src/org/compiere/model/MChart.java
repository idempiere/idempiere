package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;


public class MChart extends X_AD_Chart {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5720760885280644477L;
	
	private int windowNo=0;

    /**
    * UUID based Constructor
    * @param ctx  Context
    * @param AD_Chart_UU  UUID key
    * @param trxName Transaction
    */
    public MChart(Properties ctx, String AD_Chart_UU, String trxName) {
        super(ctx, AD_Chart_UU, trxName);
    }

	public MChart(Properties ctx, int AD_Chart_ID, String trxName) {
		super(ctx, AD_Chart_ID, trxName);
	}

	public MChart(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	public List<MChartDatasource> getDatasources() {

		return new Query(getCtx(), MChartDatasource.Table_Name, "AD_Chart_ID = ? AND AD_Client_ID IN (0, ?)", null)
				.setParameters(getAD_Chart_ID(), Env.getAD_Client_ID(getCtx()))
				.setOnlyActiveRecords(true)
				.list();
	}
	
	public void setWindowNo(int windowNo) {
		this.windowNo = windowNo;		
	}
	
	public int getWindowNo() {
		return windowNo;
	}
}
