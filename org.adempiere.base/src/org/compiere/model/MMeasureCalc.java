/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Performance Measure Calculation
 *	
 *  @author Jorg Janke
 *  @version $Id: MMeasureCalc.java,v 1.4 2006/09/25 00:59:41 jjanke Exp $
 */
public class MMeasureCalc extends X_PA_MeasureCalc implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3143013490477454559L;

	/**
	 * 	Get MMeasureCalc from Cache (immutable)
	 *	@param PA_MeasureCalc_ID id
	 *	@return MMeasureCalc
	 */
	public static MMeasureCalc get (int PA_MeasureCalc_ID)
	{
		return get(Env.getCtx(), PA_MeasureCalc_ID);
	}
	
	/**
	 * 	Get MMeasureCalc from Cache (immutable)
	 *  @param ctx context
	 *	@param PA_MeasureCalc_ID id
	 *	@return MMeasureCalc
	 */
	public static MMeasureCalc get (Properties ctx, int PA_MeasureCalc_ID)
	{
		Integer key = Integer.valueOf(PA_MeasureCalc_ID);
		MMeasureCalc retValue = s_cache.get (ctx, key, e -> new MMeasureCalc(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MMeasureCalc (ctx, PA_MeasureCalc_ID, (String)null);
		if (retValue.get_ID() == PA_MeasureCalc_ID)
		{
			s_cache.put (key, retValue, e -> new MMeasureCalc(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer, MMeasureCalc> s_cache 
		= new ImmutableIntPOCache<Integer, MMeasureCalc> (Table_Name, 10);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param PA_MeasureCalc_ID id
	 *	@param trxName trx
	 */
	public MMeasureCalc (Properties ctx, int PA_MeasureCalc_ID, String trxName)
	{
		super (ctx, PA_MeasureCalc_ID, trxName);
	}	//	MMeasureCalc

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MMeasureCalc (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MMeasureCalc
	
	/**
	 * 
	 * @param copy
	 */
	public MMeasureCalc(MMeasureCalc copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MMeasureCalc(Properties ctx, MMeasureCalc copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MMeasureCalc(Properties ctx, MMeasureCalc copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Get Sql to return single value for the Performance Indicator
	 *	@param restrictions array of goal restrictions
	 *	@param MeasureScope scope of this value  
	 *	@param MeasureDataType data type
	 *	@param reportDate optional report date
	 *	@param role role
	 *	@return sql for performance indicator
	 */
	public String getSqlPI (MGoalRestriction[] restrictions, 
		String MeasureScope, String MeasureDataType, Timestamp reportDate, MRole role)
	{
		StringBuilder sb = new StringBuilder(getSelectClause())
			.append(" ")
			.append(getWhereClause());
		//	Date Restriction
		if (getDateColumn() != null 
			&& MMeasure.MEASUREDATATYPE_QtyAmountInTime.equals(MeasureDataType)
			&& !MGoal.MEASUREDISPLAY_Total.equals(MeasureScope))
		{
			if (reportDate == null)
				reportDate = new Timestamp(System.currentTimeMillis());
			@SuppressWarnings("unused")
			String dateString = DB.TO_DATE(reportDate);
			// http://download-west.oracle.com/docs/cd/B14117_01/server.101/b10759/functions207.htm#i1002084
			String trunc = "DD";
			if (MGoal.MEASUREDISPLAY_Year.equals(MeasureScope))
				trunc = "Y";
			else if (MGoal.MEASUREDISPLAY_Quarter.equals(MeasureScope))
				trunc = "Q";
			else if (MGoal.MEASUREDISPLAY_Month.equals(MeasureScope))
				trunc = "MM";
			else if (MGoal.MEASUREDISPLAY_Week.equals(MeasureScope))
				trunc = "D";
		//	else if (MGoal.MEASUREDISPLAY_Day.equals(MeasureDisplay))
		//		;
			sb.append(" AND TRUNC(")
				.append(getDateColumn()).append(",'").append(trunc).append("')=TRUNC(")
				.append(DB.TO_DATE(reportDate)).append(",'").append(trunc).append("')");
		}	//	date
		String sql = addRestrictions(sb.toString(), restrictions, role);
		if (sql.indexOf("@") >= 0)
			sql = Env.parseContext(getCtx(), 0, sql.toString(), false, false);
		
		log.fine(sql);
		return sql;
	}	//	getSql
	
	/**
	 * 	Get Sql to value for the bar chart
	 *	@param restrictions array of goal restrictions
	 *	@param MeasureDisplay scope of this value  
	 *	@param startDate optional report start date
	 *	@param role role
	 *	@return sql for Bar Chart
	 */
	public String getSqlBarChart (MGoalRestriction[] restrictions, 
		String MeasureDisplay, Timestamp startDate, MRole role)
	{
		StringBuilder sb = new StringBuilder();
		String dateCol = null;
		String groupBy = null;
		if (getDateColumn() != null 
			&& !MGoal.MEASUREDISPLAY_Total.equals(MeasureDisplay))
		{
			String trunc = "D";
			if (MGoal.MEASUREDISPLAY_Year.equals(MeasureDisplay))
				trunc = "Y";
			else if (MGoal.MEASUREDISPLAY_Quarter.equals(MeasureDisplay))
				trunc = "Q";
			else if (MGoal.MEASUREDISPLAY_Month.equals(MeasureDisplay))
				trunc = "MM";
			else if (MGoal.MEASUREDISPLAY_Week.equals(MeasureDisplay))
				trunc = "W";
		//	else if (MGoal.MEASUREDISPLAY_Day.equals(MeasureDisplay))
		//		;
			dateCol = "TRUNC(" + getDateColumn() + ",'" + trunc + "') ";
			groupBy = dateCol; 
		}
		else
			dateCol = "MAX(" + getDateColumn() + ") ";
		//
		String selectFrom = getSelectClause();
		int index = selectFrom.indexOf("FROM ");
		if (index == -1)
			index = selectFrom.toUpperCase().indexOf("FROM ");
		if (index == -1)
			throw new IllegalArgumentException("Cannot find FROM in sql - " + selectFrom);
		sb.append(selectFrom.substring(0, index))
			.append(",").append(dateCol)
			.append(selectFrom.substring(index));
		
		//	** WHERE
		sb.append(" ")
			.append(getWhereClause());
		//	Date Restriction
		if (getDateColumn() != null
			&& startDate != null
			&& !MGoal.MEASUREDISPLAY_Total.equals(MeasureDisplay))
		{
			String dateString = DB.TO_DATE(startDate);
			sb.append(" AND ").append(getDateColumn())
				.append(">=").append(dateString);
		}	//	date
		String sql = addRestrictions(sb.toString(), restrictions, role);
		if (groupBy != null)
			sql += " GROUP BY " + groupBy
					+ " ORDER BY " + groupBy; // teo_sarca, [ 1665129 ] Bar Graph is not ordered
		if (sql.indexOf("@") >= 0)
			sql = Env.parseContext(getCtx(), 0, sql, false, false);
		//
		log.fine(sql);
		return sql;
	}	//	getSqlBarChart
	
	/**
	 * 	Get Zoom Query
	 * 	@param restrictions restrictions
	 * 	@param MeasureDisplay display
	 * 	@param date date
	 * 	@param role role
	 *	@return query
	 */
	public MQuery getQuery(MGoalRestriction[] restrictions, 
		String MeasureDisplay, Timestamp date, MRole role)
	{
		MQuery query = new MQuery(getAD_Table_ID());
		//
		StringBuilder sql = new StringBuilder("SELECT ").append(getKeyColumn()).append(" ");
		String from = getSelectClause();
		int index = from.indexOf("FROM ");
		if (index == -1)
			throw new IllegalArgumentException("Cannot find FROM " + from);
		sql.append(from.substring(index)).append(" ")
			.append(getWhereClause());
		//	Date Range
		if (getDateColumn() != null 
			&& !MGoal.MEASUREDISPLAY_Total.equals(MeasureDisplay))
		{
			String trunc = "D";
			if (MGoal.MEASUREDISPLAY_Year.equals(MeasureDisplay))
				trunc = "Y";
			else if (MGoal.MEASUREDISPLAY_Quarter.equals(MeasureDisplay))
				trunc = "Q";
			else if (MGoal.MEASUREDISPLAY_Month.equals(MeasureDisplay))
				trunc = "MM";
			else if (MGoal.MEASUREDISPLAY_Week.equals(MeasureDisplay))
				trunc = "W";
		//	else if (MGoal.MEASUREDISPLAY_Day.equals(MeasureDisplay))
		//		trunc = "D";
			sql.append(" AND TRUNC(").append(getDateColumn()).append(",'").append(trunc)
				.append("')=TRUNC(").append(DB.TO_DATE(date)).append(",'").append(trunc).append("')");
		}
		String finalSQL = addRestrictions(sql.toString(), restrictions, role);
		if (finalSQL.indexOf("@") >= 0)
			finalSQL = Env.parseContext(getCtx(), 0, finalSQL, false, false);
		//	Execute
		StringBuilder where = new StringBuilder();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (finalSQL, null);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				int id = rs.getInt(1);
				if (where.length() > 0)
					where.append(",");
				where.append(id);
			}
		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, finalSQL, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		if (where.length() == 0)
			return MQuery.getNoRecordQuery(query.getTableName(), false);
		//
		StringBuilder whereClause = new StringBuilder (getKeyColumn())
			.append(" IN (").append(where).append(")");
		query.addRestriction(whereClause.toString());
		query.setRecordCount(1);
		return query;
	}	//	getQuery
	
	/**
	 * 	Add Restrictions
	 *	@param sql existing sql
	 *	@param restrictions restrictions
	 *	@param role role
	 *	@return updated sql
	 */
	private String addRestrictions(String sql, 
		MGoalRestriction[] restrictions, MRole role)
	{
		return addRestrictions(sql, false, restrictions, role,
			getTableName(), getOrgColumn(), getBPartnerColumn(), getProductColumn());
	}	//	addRestrictions


	/**
	 * 	Add Restrictions to SQL
	 *	@param sql orig sql
	 *	@param queryOnly incomplete sql for query restriction
	 *	@param restrictions restrictions
	 *	@param role role
	 *	@param tableName table name
	 *	@param orgColumn org column
	 *	@param bpColumn bpartner column
	 *	@param pColumn product column
	 *	@return updated sql
	 */
	public static String addRestrictions(String sql, boolean queryOnly,
		MGoalRestriction[] restrictions, MRole role, 
		String tableName, String orgColumn, String bpColumn, String pColumn)
	{
		StringBuilder sb = new StringBuilder(sql);
		//	Org Restrictions
		if (orgColumn != null)
		{
			ArrayList<Integer> list = new ArrayList<Integer>();
			for (int i = 0; i < restrictions.length; i++)
			{
				if (MGoalRestriction.GOALRESTRICTIONTYPE_Organization.equals(restrictions[i].getGoalRestrictionType()))
					list.add(restrictions[i].getOrg_ID());
				//	Hierarchy comes here
			}
			if (list.size() == 1)
				sb.append(" AND ").append(orgColumn)
					.append("=").append(list.get(0));
			else if (list.size() > 1)
			{
				sb.append(" AND ").append(orgColumn).append(" IN (");
				for (int i = 0; i < list.size(); i++)
				{
					if (i > 0)
						sb.append(",");
					sb.append(list.get(i));
				}
				sb.append(")");
			}
		}	//	org
		
		//	BPartner Restrictions
		if (bpColumn != null)
		{
			ArrayList<Integer> listBP = new ArrayList<Integer>();
			ArrayList<Integer> listBPG = new ArrayList<Integer>();
			for (int i = 0; i < restrictions.length; i++)
			{
				if (MGoalRestriction.GOALRESTRICTIONTYPE_BusinessPartner.equals(restrictions[i].getGoalRestrictionType()))
					listBP.add(restrictions[i].getC_BPartner_ID());
				//	Hierarchy comes here
				if (MGoalRestriction.GOALRESTRICTIONTYPE_BusPartnerGroup.equals(restrictions[i].getGoalRestrictionType()))
					listBPG.add(restrictions[i].getC_BP_Group_ID());
			}
			//	BP
			if (listBP.size() == 1)
				sb.append(" AND ").append(bpColumn)
					.append("=").append(listBP.get(0));
			else if (listBP.size() > 1)
			{
				sb.append(" AND ").append(bpColumn).append(" IN (");
				for (int i = 0; i < listBP.size(); i++)
				{
					if (i > 0)
						sb.append(",");
					sb.append(listBP.get(i));
				}
				sb.append(")");
			}
			//	BPG
			if (bpColumn.indexOf('.') == -1)
				bpColumn = tableName + "." + bpColumn;
			if (listBPG.size() == 1)
				sb.append(" AND EXISTS (SELECT * FROM C_BPartner bpx WHERE ")
					.append(bpColumn)
					.append("=bpx.C_BPartner_ID AND bpx.C_BP_GROUP_ID=")
					.append(listBPG.get(0)).append(")"); 
			else if (listBPG.size() > 1)
			{
				sb.append(" AND EXISTS (SELECT * FROM C_BPartner bpx WHERE ")
					.append(bpColumn)
					.append("=bpx.C_BPartner_ID AND bpx.C_BP_GROUP_ID IN (");
				for (int i = 0; i < listBPG.size(); i++)
				{
					if (i > 0)
						sb.append(",");
					sb.append(listBPG.get(i));
				}
				sb.append("))");
			}
		}	//	bp
		
		//	Product Restrictions
		if (pColumn != null)
		{
			ArrayList<Integer> listP = new ArrayList<Integer>();
			ArrayList<Integer> listPC = new ArrayList<Integer>();
			for (int i = 0; i < restrictions.length; i++)
			{
				if (MGoalRestriction.GOALRESTRICTIONTYPE_Product.equals(restrictions[i].getGoalRestrictionType()))
					listP.add(restrictions[i].getM_Product_ID());
				//	Hierarchy comes here
				if (MGoalRestriction.GOALRESTRICTIONTYPE_ProductCategory.equals(restrictions[i].getGoalRestrictionType()))
					listPC.add(restrictions[i].getM_Product_Category_ID());
			}
			//	Product
			if (listP.size() == 1)
				sb.append(" AND ").append(pColumn)
					.append("=").append(listP.get(0));
			else if (listP.size() > 1)
			{
				sb.append(" AND ").append(pColumn).append(" IN (");
				for (int i = 0; i < listP.size(); i++)
				{
					if (i > 0)
						sb.append(",");
					sb.append(listP.get(i));
				}
				sb.append(")");
			}
			//	Category
			if (pColumn.indexOf('.') == -1)
				pColumn = tableName + "." + pColumn;
			if (listPC.size() == 1)
				sb.append(" AND EXISTS (SELECT * FROM M_Product px WHERE ")
					.append(pColumn)
					.append("=px.M_Product_ID AND px.M_Product_Category_ID=")
					.append(listPC.get(0)).append(")"); 
			else if (listPC.size() > 1)
			{
				sb.append(" AND EXISTS (SELECT * FROM M_Product px WHERE ")
				.append(pColumn)
				.append("=px.M_Product_ID AND px.M_Product_Category_ID IN (");
				for (int i = 0; i < listPC.size(); i++)
				{
					if (i > 0)
						sb.append(",");
					sb.append(listPC.get(i));
				}
				sb.append("))");
			}
		}	//	product
		String finalSQL = sb.toString();
		if (queryOnly)
			return finalSQL;
		if (role == null)
			role = MRole.getDefault();
		String retValue = role.addAccessSQL(finalSQL, tableName, true, false);
		return retValue;
	}	//	addRestrictions

	/**
	 * 	Get Table Name
	 *	@return Table Name
	 */
	public String getTableName()
	{
		return MTable.getTableName (Env.getCtx(), getAD_Table_ID());
	}	//	getTavleName
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MMeasureCalc[");
		sb.append (get_ID()).append ("-").append (getName()).append ("]");
		return sb.toString ();
	}	//	toString
	
	@Override
	public MMeasureCalc markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MMeasureCalc
