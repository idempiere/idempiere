package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.adempiere.exceptions.DBException;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

public class MChartDatasource extends X_AD_ChartDatasource {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5108909995064477463L;

	public MChartDatasource(Properties ctx, int AD_ChartDatasource_ID,
			String trxName) {
		super(ctx, AD_ChartDatasource_ID, trxName);
	}

	public MChartDatasource(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}


	/**
	 * Convert date formatted as yyyy-MM to yyyy-QQ
	 * @param month
	 * @return
	 */
	private String convertToQuarter(String month) {
		if ( month.length() != 7 )
			return month;
		
		String mm = month.substring(5,7);
		int mon = Integer.parseInt(mm);
		return month.substring(0,5)+"Q" + ((mon/3) + 1);
		
	}

	public MQuery getZoomQuery(MChart parent, String value, String category2) {
		MQuery query = new MQuery(getAD_Table_ID());
		
		String category;
		
		if ( !parent.isTimeSeries() )
			category = getCategoryColumn();
		else 
		{
			String unit = "D";
			if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Week))
				unit = "W";
			else if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Month))
				unit = "MM";
			else if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Quarter))
					unit = "Q";
			else if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Year))
						unit = "Y";
			
			category = " TRUNC(" + getDateColumn() + ", '" + unit + "') ";
		}
		
		String where = getWhereClause();
		if ( !Util.isEmpty(where))
		{
			where = Env.parseContext(Env.getCtx(), parent.getWindowNo(), where, true);
		}
		
		String series = DB.TO_STRING(getName());
		if (getSeriesColumn() != null)
			series = getSeriesColumn();
		
		String sql = "SELECT " + getKeyColumn() + "," + category + "," + series
		+ " FROM " + getFromClause();
		
		if ( !Util.isEmpty(where))
		{
			sql += " WHERE " + where;
		}
		

		sql += " GROUP BY " + series + ", " + category + "," + getKeyColumn()
		+ " ORDER BY " + series + ", " + category + "," + getKeyColumn();
		
		StringBuffer includedIds = new StringBuffer();
		//	Execute
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				int id = rs.getInt(1);
				String key = rs.getString(2);
				if ( parent.isTimeSeries() )
		    	 {
		    		 Date date = rs.getDate(2);
		    		 String unit = "yyyy-MM-dd";
		    		 if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Week))
		 				unit = "yyyy-w";
		 			else if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Month))
		 				unit = "yyyy-MMM";
		 			else if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Quarter))
		 					unit = "yyyy-MM";
		 			else if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Year))
		 						unit = "yyyy";
		    		 SimpleDateFormat format = new SimpleDateFormat(unit);
		    		 key = format.format(date);
		    		 if ( parent.getTimeUnit().equals(MChart.TIMEUNIT_Quarter) )
		    			 key = convertToQuarter(format.format(date));
		    	 }

				if ( value.equals(key) )
				{
					if (includedIds.length() > 0)
						includedIds.append(",");
					includedIds.append(id);
				}
			}
		}
		catch (SQLException e)
		{
		     throw new DBException(e, sql);
		}
		finally
		{
		     DB.close(rs, pstmt);
		     rs = null; pstmt = null;
		}

		if (includedIds.length() == 0)
			return MQuery.getNoRecordQuery(query.getTableName(), false);


		return query;
	}

}
