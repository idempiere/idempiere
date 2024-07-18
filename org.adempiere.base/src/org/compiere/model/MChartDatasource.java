/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
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

/**
 * Extended model class for AD_ChartDatasource
 */
public class MChartDatasource extends X_AD_ChartDatasource {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 5108909995064477463L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_ChartDatasource_UU  UUID key
     * @param trxName Transaction
     */
    public MChartDatasource(Properties ctx, String AD_ChartDatasource_UU, String trxName) {
        super(ctx, AD_ChartDatasource_UU, trxName);
    }

    /**
     * @param ctx
     * @param AD_ChartDatasource_ID
     * @param trxName
     */
	public MChartDatasource(Properties ctx, int AD_ChartDatasource_ID, String trxName) {
		super(ctx, AD_ChartDatasource_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MChartDatasource(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Convert date formatted as yyyy-MM to yyyy-QQ
	 * @param month date string in the format of yyyy-MM (for e.g 2023-02)
	 * @return converted date string in the format of yyyy-QQ (for e.g 2023-Q1)
	 */
	private String convertToQuarter(String month) {
		if ( month.length() != 7 )
			return month;
		
		String mm = month.substring(5,7);
		int mon = Integer.parseInt(mm);
		return month.substring(0,5)+"Q" + ((mon/3) + 1);
		
	}

	/**
	 * Get zoom query for key value
	 * @param parent
	 * @param value key value
	 * @param category2 ignore
	 * @return query model
	 */
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
		
		StringBuilder includedIds = new StringBuilder();
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
