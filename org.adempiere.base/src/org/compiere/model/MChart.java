package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;



public class MChart extends X_AD_Chart {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8851465915516536910L;
	
	private int windowNo=0;

	public MChart(Properties ctx, int AD_Chart_ID, String trxName) {
		super(ctx, AD_Chart_ID, trxName);
	}

	public MChart(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	public List<MChartDatasource> getDatasources() {
		
		return new Query(getCtx(), MChartDatasource.Table_Name, MChart.COLUMNNAME_AD_Chart_ID + "=?", null)
		.setParameters(getAD_Chart_ID()).setOnlyActiveRecords(true).list();
	}
	
	public void setWindowNo(int windowNo) {
		this.windowNo = windowNo;		
	}
	
	public int getWindowNo() {
		return windowNo;
	}
}
