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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.MInfoProcess;
import org.adempiere.model.MInfoRelated;
import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Info Window Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MInfoWindow.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MInfoWindow extends X_AD_InfoWindow implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6793583766286122866L;

	/**	Cache						*/
	private static ImmutablePOCache<String,MInfoWindow> s_cache = new ImmutablePOCache<String,MInfoWindow>(Table_Name, 20);
	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_InfoWindow_ID id
	 *	@param trxName transaction
	 */
	public MInfoWindow (Properties ctx, int AD_InfoWindow_ID, String trxName)
	{
		super (ctx, AD_InfoWindow_ID, trxName);
	}	//	MInfoWindow

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MInfoWindow (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MInfoWindow

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MInfoWindow(MInfoWindow copy)
	{
		this(copy, (String) null);
	}
	
	/**
	 * Copy constructor
	 * @param copy
	 */
	public MInfoWindow(MInfoWindow copy, String trxName)
	{
		this(Env.getCtx(), 0, trxName);
		copyPO(copy);
		this.m_validateEachColumn = copy.m_validateEachColumn;
		this.m_infocolumns = copy.m_infocolumns != null ? Arrays.stream(copy.m_infocolumns).map(MInfoColumn::new).toArray(MInfoColumn[]::new) : null;
		this.m_infoProcess = copy.m_infoProcess != null ? Arrays.stream(copy.m_infoProcess).map(MInfoProcess::new).toArray(MInfoProcess[]::new) : null;
		this.m_infoRelated = copy.m_infoRelated != null ? Arrays.stream(copy.m_infoRelated).map(MInfoRelated::new).toArray(MInfoRelated[]::new) : null;
	}
	
	public static MInfoWindow get(String tableName, String trxName) {
		Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), MInfoWindow.Table_ID), MInfoWindow.COLUMNNAME_AD_Table_ID+"=? AND IsValid='Y' ", null);
		MTable table = MTable.get(Env.getCtx(), tableName);
		if (table != null) {
			List<MInfoWindow> iws = query.setParameters(table.getAD_Table_ID())
					.setOrderBy("AD_Client_ID Desc, AD_Org_ID Desc, IsDefault Desc, AD_InfoWindow_ID Desc")
					.setOnlyActiveRecords(true)
					.setApplyAccessFilter(true)
					.list();
			// verify role has access and return the first with access / IDEMPIERE-893
			for (MInfoWindow iw : iws) {
				Boolean access = MRole.getDefault().getInfoAccess(iw.getAD_InfoWindow_ID());
				if (access != null && access.booleanValue())
					return iw;
			}
		}
		return null;
	}

	/**
	 * author xolali
	 * @param AD_InfoWindow_ID
	 * @return {@link MInfoWindow}
	 */
	public static MInfoWindow getInfoWindow(int AD_InfoWindow_ID) {
		if (AD_InfoWindow_ID > 0) {
			String key = String.valueOf(AD_InfoWindow_ID) + "|" + Env.getAD_Role_ID(Env.getCtx());
			MInfoWindow infoWin =  s_cache.get(key);
			if (infoWin != null)
				return infoWin;
			
			infoWin =  (MInfoWindow)new Query(Env.getCtx(), Table_Name, "AD_InfoWindow_ID=?", null)
				.setParameters(AD_InfoWindow_ID)
				.first();

			if (infoWin != null) {
				s_cache.put(key, infoWin);
				return infoWin;
			}
		}

		return null;
	}

	private MInfoRelated[] m_infoRelated;

	/**
	 * IDEMPIERE-1334
	 * cache list process button info
	 */
	private MInfoProcess[]  m_infoProcess;

	/**
	 * author xolali
	 * @param requery
	 * @return
	 */
	public MInfoRelated[] getInfoRelated(boolean requery) {
		if ((this.m_infoRelated != null) && (!requery)) {
			set_TrxName(this.m_infoRelated, get_TrxName());
			return this.m_infoRelated;
		}

		List<MInfoRelated> list = new Query(getCtx(), MInfoRelated.Table_Name, "AD_InfoWindow_ID=?", get_TrxName())
			.setParameters(getAD_InfoWindow_ID())
			.setOnlyActiveRecords(true)
			.setOrderBy("SeqNo")
			.list();

		m_infoRelated =  list.toArray(new MInfoRelated[list.size()]);

		return m_infoRelated;
	}

	/**
	 * IDEMPIERE-1334
	 * Get list {@link MInfoProcess} of this infoWindow
	 * @param requery true get from db, false try get from cache
	 * @return empty array when not exists Info Process
	 */
	public MInfoProcess [] getInfoProcess(boolean requery) {
		// try from cache
		if ((this.m_infoProcess != null) && (!requery)) {
			set_TrxName(this.m_infoProcess, get_TrxName());
			return this.m_infoProcess;
		}
		
		// get list info process from db, order by seqNo
		List<MInfoProcess> list = new Query(getCtx(), MInfoProcess.Table_Name, "AD_InfoWindow_ID=?", get_TrxName())
			.setParameters(getAD_InfoWindow_ID())
			.setOnlyActiveRecords(true)
			.setOrderBy("SeqNo")
			.list();

		checkProcessRight(list);
		m_infoProcess =  list.toArray(new MInfoProcess[list.size()]);

		return m_infoProcess;
	}
	

    /**
     * if user haven't right to run a process, set infoProcess to null 
     * @param lsInfoProcess
     */
	protected void checkProcessRight (List<MInfoProcess> lsInfoProcess) {
		Iterator<MInfoProcess> iterator = lsInfoProcess.iterator();
		while (iterator.hasNext()){
			MInfoProcess testInfoProcess = iterator.next();
			Boolean access = MRole.getDefault().getProcessAccess(testInfoProcess.getAD_Process_ID());
			if (access == null || !access.booleanValue()) {
				iterator.remove();
			}
		}
		
	}

	/**
	 * @param infoWindowID
	 * @param trxName 
	 * return MInfoWindow if the current role can access to the specified info window ; otherwise return null 
	 * */
	public static MInfoWindow get(int infoWindowID, String trxName) {
		MInfoWindow iw = getInfoWindow(infoWindowID);

		if (iw != null) {
			Boolean access = MRole.getDefault().getInfoAccess(iw.getAD_InfoWindow_ID());
			if (access != null && access.booleanValue()) {
				if (!Util.isEmpty(trxName, true))
					iw = new MInfoWindow(iw, trxName);
				return iw;
			}
		}

		return null;
	}

	public synchronized MInfoColumn[] getInfoColumns(TableInfo[] tableInfos) {
		getInfoColumns();
		List<MInfoColumn> list = new ArrayList<MInfoColumn>();
		for(MInfoColumn ic : m_infocolumns) {
			if (ic.isColumnAccess(tableInfos))
				list.add(ic);
		}
		return list.toArray(new MInfoColumn[0]);
	}
	
	public synchronized MInfoColumn[] getInfoColumns() {
		if (m_infocolumns == null) {
			Query query = new Query(getCtx(), MTable.get(getCtx(), I_AD_InfoColumn.Table_ID), I_AD_InfoColumn.COLUMNNAME_AD_InfoWindow_ID+"=?", get_TrxName());
			List<MInfoColumn> list = query.setParameters(getAD_InfoWindow_ID())
					.setOnlyActiveRecords(true)
					.setOrderBy("SeqNo, AD_InfoColumn_ID")
					.list();
			m_infocolumns = list.toArray(new MInfoColumn[0]);
		}
		
		if (get_TrxName() != null)
			set_TrxName(m_infocolumns, get_TrxName());
		return m_infocolumns;
	}

	/**
	 * author xolali
	 */
	private MInfoColumn[] m_infocolumns = null;

	public synchronized MInfoColumn[] getInfoColumns(boolean requery, boolean checkDisplay) {
		if (m_infocolumns == null || requery) {
			m_infocolumns = null;
			getInfoColumns();
		}
			
		if (checkDisplay) {
			List<MInfoColumn> list = new ArrayList<MInfoColumn>();
			for(MInfoColumn ic : m_infocolumns) {
				if (ic.isDisplayed())
					list.add(ic);
			}
			return list.toArray(new MInfoColumn[list.size()]);
		} else {
			return m_infocolumns;
		}
	}

	/**
	 * author xolali
	 * @return
	 */
	public String getSql(){

		String fromsql = getFromClause();
		String oclause = getOtherClause();
		if (oclause == null)
			oclause=" ";

		//boolean success = true;
		MInfoColumn[] mColumns = getInfoColumns(true,true);
		StringBuilder sql = new StringBuilder("SELECT ");
		int size = mColumns.length;//get_ColumnCount();
		for (int i = 0; i < size; i++)
		{
			if (i != 0) // can also use if i>0
				sql.append(",");
			sql.append(mColumns[i].getSelectClause());	//	Normal and Virtual Column
		}
		sql.append(" FROM ").append(fromsql)
		.append(oclause);

		log.info("Generated SQL -- getSql: "+ sql.toString());

		return sql.toString();
	}

	public boolean validateSql(){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = getSql();
		try
		{
			String countSql = Msg.parseTranslation(Env.getCtx(), sql.toString());	//	Variables
			countSql = MRole.getDefault().addAccessSQL(countSql, MTable.getTableName(Env.getCtx(), getAD_Table_ID()),// getTableName(), 
					MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);

			pstmt = DB.prepareStatement(countSql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				break;
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			// show error to user and return: TODO
			return false;
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return true;
	}  // validate sql

	@Override
	protected boolean beforeSave(boolean newRecord) {
		AccessSqlParser parser = new AccessSqlParser("SELECT * FROM " + getFromClause());
		TableInfo[] tableInfos = parser.getTableInfo(0);
		if (tableInfos == null || tableInfos.length == 0) {
			log.saveError("ParseFromClauseError", "Failed to parse from clause");
			return false;
		}
		
		//only one default per table
		if (newRecord || is_ValueChanged("IsDefault")) {
			if (isDefault()) {				
				if (newRecord) {
					Query query = new Query(getCtx(), MTable.get(getCtx(), Table_ID), 
							"AD_Table_ID=? AND IsDefault='Y' AND AD_Client_ID=?", get_TrxName());
					List<MInfoWindow> list = query.setParameters(getAD_Table_ID(),getAD_Client_ID()).list();
					for(MInfoWindow iw : list) {
						iw.setIsDefault(false);
						iw.saveEx();
					}
				} else {
					Query query = new Query(getCtx(), MTable.get(getCtx(), Table_ID), 
							"AD_InfoWindow_ID<>? AND AD_Table_ID=? AND IsDefault='Y' AND AD_Client_ID=?", get_TrxName());
					List<MInfoWindow> list = query.setParameters(getAD_InfoWindow_ID(), getAD_Table_ID(), getAD_Client_ID()).list();
					for(MInfoWindow iw : list) {
						iw.setIsDefault(false);
						iw.saveEx();
					}
				}
			}
		}
		
		// evaluate need valid
		boolean isNeedValid = is_new() || is_ValueChanged (I_AD_InfoWindow.COLUMNNAME_AD_Table_ID) || is_ValueChanged (I_AD_InfoWindow.COLUMNNAME_WhereClause) ||
								is_ValueChanged (I_AD_InfoWindow.COLUMNNAME_FromClause) || is_ValueChanged (I_AD_InfoWindow.COLUMNNAME_OrderByClause) ||
								is_ValueChanged (I_AD_InfoWindow.COLUMNNAME_OtherClause) || is_ValueChanged (I_AD_InfoWindow.COLUMNNAME_IsDistinct);
		
		// valid config 
		if (isNeedValid){
			validate();
		}
		
		return true;
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (!success)
			return success;
		if (newRecord)	//	Add to all automatic roles
		{
			MRole[] roles = MRole.getOf(getCtx(), "IsManual='N'");
			for (int i = 0; i < roles.length; i++)
			{
				MInfoWindowAccess wa = new MInfoWindowAccess(this, roles[i].getAD_Role_ID());
				wa.saveEx();
			}
		}
		//	Menu
		else if (is_ValueChanged("IsActive") || is_ValueChanged("Name") 
			|| is_ValueChanged("Description"))
		{
			MMenu[] menues = MMenu.get(getCtx(), "AD_InfoWindow_ID=" + getAD_InfoWindow_ID(), get_TrxName());
			for (int i = 0; i < menues.length; i++)
			{
				menues[i].setName(getName());
				menues[i].setDescription(getDescription());
				menues[i].setIsActive(isActive());
				menues[i].saveEx();
			}
			//
		}
		return super.afterSave(newRecord, success);
	}
	
	
	public void validate ()
	{		
		// default, before complete check is invalid
		this.setIsValid(false);		
		
		// add DISTINCT clause
		StringBuilder builder = new StringBuilder("SELECT ");
		if (this.isDistinct())
			builder.append("DISTINCT ");
		
		MInfoColumn[] infoColumns = this.getInfoColumns();
		// none column make this invalid
		if (infoColumns.length == 0){
			return;
		}
		
		// build select clause
		for (int columnIndex = 0; columnIndex < infoColumns.length; columnIndex++) {
			if (columnIndex > 0)
            {
                builder.append(", ");
            }
			builder.append(infoColumns[columnIndex].getSelectClause());
		}
		
		// build from clause
		builder.append( " FROM ").append(this.getFromClause());
		
		// build where clause add (1=2) because not need get result, decrease load 
		if (this.getWhereClause() != null && this.getWhereClause().trim().length() > 0) {
			builder.append(" WHERE (1=2) AND (").append(this.getWhereClause()).append(")");
		} else {
			builder.append(" WHERE 1=2");
		}
		
		// build other (having) clause
		if (this.getOtherClause() != null && this.getOtherClause().trim().length() > 0) {
			builder.append(" ").append(this.getOtherClause());
		}
		
		// build order (having) clause
		if (this.getOrderByClause() != null && this.getOrderByClause().trim().length() > 0) {
			builder.append(" ORDER BY ").append(this.getOrderByClause());
		}
		
		// replace env value by dummy value
		while(builder.indexOf("@") >= 0) {
			int start = builder.indexOf("@");
			int end = builder.indexOf("@", start+1);
			if (start >=0 && end > start) {
				builder.replace(start, end+1, "0");
			} else {
				break;
			}
		}
		
		// try run sql
		PreparedStatement pstmt = null;
		try {
			pstmt = DB.prepareStatement(builder.toString(), get_TrxName());
			pstmt.executeQuery();
		}catch (Exception ex){
			log.log(Level.WARNING, ex.getMessage());
			throw new AdempiereException(ex);
		} finally {
			DB.close(pstmt);
		}
		
		// valid state
		this.setIsValid(true);		
	}

	/**
	 * IDEMPIERE-4167
	 **/
	private boolean m_validateEachColumn = true;

	public void setIsValidateEachColumn (boolean validateEachColumn) {
		m_validateEachColumn= validateEachColumn;
	}

	boolean isValidateEachColumn() {
		return m_validateEachColumn;
	}

	@Override
	public MInfoWindow markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_infocolumns != null && m_infocolumns.length > 0)
			Arrays.stream(m_infocolumns).forEach(e -> e.markImmutable());
		if (m_infoProcess != null && m_infoProcess.length > 0)
			Arrays.stream(m_infoProcess).forEach(e -> e.markImmutable());
		if (m_infoRelated != null && m_infoRelated.length > 0)
			Arrays.stream(m_infoRelated).forEach(e -> e.markImmutable());
		
		return this;
	}

	@Override
	public I_AD_Table getAD_Table() throws RuntimeException {
		return MTable.get(Env.getCtx(), getAD_Table_ID(), get_TrxName());
	}
	
	/**
	 * 
	 * @return array of {@link TableInfo}
	 */
	public TableInfo[] getTableInfos() {
		AccessSqlParser sqlParser = new AccessSqlParser("SELECT * FROM " + getFromClause());
		return sqlParser.getTableInfo(0);
	}
}	//	MInfoWindow
