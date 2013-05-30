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
package org.compiere.report;

import static org.compiere.model.SystemIDs.TABLE_T_REPORT;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.I_C_ValidCombination;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MReportCube;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.TimeUtil;

/**
 *  Financial Report Engine
 *
 *  @author Jorg Janke
 *	@author Armen Rizal, Goodwill Consulting
 *			<li>FR [2857076] User Element 1 and 2 completion - https://sourceforge.net/tracker/?func=detail&aid=2857076&group_id=176962&atid=879335
 *
 *  @version $Id: FinReport.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class FinReport extends SvrProcess
{
	/**	Period Parameter				*/
	private int					p_C_Period_ID = 0;
	/**	Org Parameter					*/
	private int					p_Org_ID = 0;
	/**	BPartner Parameter				*/
	private int					p_C_BPartner_ID = 0;
	/**	Product Parameter				*/
	private int					p_M_Product_ID = 0;
	/**	Project Parameter				*/
	private int					p_C_Project_ID = 0;
	/**	Activity Parameter				*/
	private int					p_C_Activity_ID = 0;
	/**	SalesRegion Parameter			*/
	private int					p_C_SalesRegion_ID = 0;
	/**	Campaign Parameter				*/
	private int					p_C_Campaign_ID = 0;
	/** User 1 Parameter				*/
	private int					p_User1_ID = 0;
	/** User 2 Parameter				*/
	private int					p_User2_ID = 0;
	/** User Element 1 Parameter		*/
	private int					p_UserElement1_ID = 0;
	/** User Element 2 Parameter		*/
	private int					p_UserElement2_ID = 0;
	/** Details before Lines			*/
	private boolean				p_DetailsSourceFirst = false;
	/** Hierarchy						*/
	private int					p_PA_Hierarchy_ID = 0;
	/** Optional report cube			*/
	private int 				p_PA_ReportCube_ID = 0;

	/**	Start Time						*/
	private long 				m_start = System.currentTimeMillis();

	/**	Report Definition				*/
	private MReport				m_report = null;
	/**	Periods in Calendar				*/
	private FinReportPeriod[]	m_periods = null;
	/**	Index of m_C_Period_ID in m_periods		**/
	private int					m_reportPeriod = -1;
	/**	Parameter Where Clause			*/
	private StringBuffer		m_parameterWhere = new StringBuffer();
	/**	The Report Columns				*/
	private MReportColumn[] 	m_columns;
	/** The Report Lines				*/
	private MReportLine[] 		m_lines;


	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		StringBuffer sb = new StringBuffer ("Record_ID=")
			.append(getRecord_ID());
		//	Parameter
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("C_Period_ID"))
				p_C_Period_ID = para[i].getParameterAsInt();
			else if (name.equals("PA_Hierarchy_ID"))
				p_PA_Hierarchy_ID = para[i].getParameterAsInt();
			else if (name.equals("Org_ID"))
				p_Org_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("M_Product_ID"))
				p_M_Product_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_Project_ID"))
				p_C_Project_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_Activity_ID"))
				p_C_Activity_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_SalesRegion_ID"))
				p_C_SalesRegion_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_Campaign_ID"))
				p_C_Campaign_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("User1_ID"))
				p_User1_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("User2_ID"))
				p_User2_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("UserElement1_ID"))
				p_UserElement1_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("UserElement2_ID"))
				p_UserElement2_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DetailsSourceFirst"))
				p_DetailsSourceFirst = "Y".equals(para[i].getParameter());
			else if (name.equals("PA_ReportCube_ID"))
				p_PA_ReportCube_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		//	Optional Org
		if (p_Org_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_Organization, p_Org_ID));
		//	Optional BPartner
		if (p_C_BPartner_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_BPartner, p_C_BPartner_ID));
		//	Optional Product
		if (p_M_Product_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_Product, p_M_Product_ID));
		//	Optional Project
		if (p_C_Project_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_Project, p_C_Project_ID));
		//	Optional Activity
		if (p_C_Activity_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_Activity, p_C_Activity_ID));
		//	Optional Campaign
		if (p_C_Campaign_ID != 0)
			m_parameterWhere.append(" AND C_Campaign_ID=").append(p_C_Campaign_ID);
		//	m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
		//		MAcctSchemaElement.ELEMENTTYPE_Campaign, p_C_Campaign_ID));
		//	Optional Sales Region
		if (p_C_SalesRegion_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_SalesRegion, p_C_SalesRegion_ID));
		//	Optional User1_ID
		if (p_User1_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_UserList1, p_User1_ID));
		//  Optional User2_ID
		if (p_User2_ID != 0)
			m_parameterWhere.append(" AND ").append(MReportTree.getWhereClause(getCtx(), 
				p_PA_Hierarchy_ID, MAcctSchemaElement.ELEMENTTYPE_UserList2, p_User2_ID));
		//	Optional UserElement1_ID
		if (p_UserElement1_ID != 0)
			m_parameterWhere.append(" AND UserElement1_ID=").append(p_UserElement1_ID);
		//  Optional UserElement2_ID
		if (p_UserElement2_ID != 0)
			m_parameterWhere.append(" AND UserElement2_ID=").append(p_UserElement2_ID);	

		//	Load Report Definition
		m_report = new MReport (getCtx(), getRecord_ID(), null);
		sb.append(" - ").append(m_report);
		//
		setPeriods();
		sb.append(" - C_Period_ID=").append(p_C_Period_ID)
			.append(" - ").append(m_parameterWhere);
		//
		
		if ( p_PA_ReportCube_ID > 0)
			m_parameterWhere.append(" AND PA_ReportCube_ID=").append(p_PA_ReportCube_ID);
		
		if (log.isLoggable(Level.INFO)) log.info(sb.toString());
	//	m_report.list();
	}	//	prepare

	/**
	 * 	Set Periods
	 */
	private void setPeriods()
	{
		if (log.isLoggable(Level.INFO)) log.info("C_Calendar_ID=" + m_report.getC_Calendar_ID());
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		ArrayList<FinReportPeriod> list = new ArrayList<FinReportPeriod>();

		String sql = "SELECT p.C_Period_ID, p.Name, p.StartDate, p.EndDate, MIN(p1.StartDate) "
			+ "FROM C_Period p "
			+ " INNER JOIN C_Year y ON (p.C_Year_ID=y.C_Year_ID),"
			+ " C_Period p1 "
			+ "WHERE y.C_Calendar_ID=?"
			// globalqss - cruiz - Bug [ 1577712 ] Financial Period Bug
			+ " AND p.IsActive='Y'"
			+ " AND p.PeriodType='S' "
			+ " AND p1.C_Year_ID=y.C_Year_ID AND p1.PeriodType='S' "
			+ "GROUP BY p.C_Period_ID, p.Name, p.StartDate, p.EndDate "
			+ "ORDER BY p.StartDate";

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_report.getC_Calendar_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				FinReportPeriod frp = new FinReportPeriod (rs.getInt(1), rs.getString(2),
					rs.getTimestamp(3), rs.getTimestamp(4), rs.getTimestamp(5));
				list.add(frp);
				if (p_C_Period_ID == 0 && frp.inPeriod(today))
					p_C_Period_ID = frp.getC_Period_ID();
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//	convert to Array
		m_periods = new FinReportPeriod[list.size()];
		list.toArray(m_periods);
		//	today after latest period
		if (p_C_Period_ID == 0)
		{
			m_reportPeriod = m_periods.length - 1;
			p_C_Period_ID = m_periods[m_reportPeriod].getC_Period_ID ();
		}
	}	//	setPeriods

	
	/**************************************************************************
	 *  Perform process.
	 *  @return Message to be translated
	 *  @throws Exception
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("AD_PInstance_ID=" + getAD_PInstance_ID());
		
		if ( p_PA_ReportCube_ID > 0 )
		{
			MReportCube cube = new MReportCube(getCtx(), p_PA_ReportCube_ID, get_TrxName());
			String result = cube.update(false, false);
			if (log.isLoggable(Level.FINE))log.log(Level.FINE, result);
		}
		//	** Create Temporary and empty Report Lines from PA_ReportLine
		//	- AD_PInstance_ID, PA_ReportLine_ID, 0, 0
		int PA_ReportLineSet_ID = m_report.getLineSet().getPA_ReportLineSet_ID();
		StringBuffer sql = new StringBuffer ("INSERT INTO T_Report "
			+ "(AD_PInstance_ID, PA_ReportLine_ID, Record_ID,Fact_Acct_ID, SeqNo,LevelNo, Name,Description) "
			+ "SELECT ").append(getAD_PInstance_ID()).append(", PA_ReportLine_ID, 0,0, SeqNo,0, Name,Description "
			+ "FROM PA_ReportLine "
			+ "WHERE IsActive='Y' AND PA_ReportLineSet_ID=").append(PA_ReportLineSet_ID);

		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Report Lines = " + no);

		//	** Get Data	** Segment Values
		m_columns = m_report.getColumnSet().getColumns();
		if (m_columns.length == 0)
			throw new AdempiereUserError("@No@ @PA_ReportColumn_ID@");
		m_lines = m_report.getLineSet().getLiness();
		if (m_lines.length == 0)
			throw new AdempiereUserError("@No@ @PA_ReportLine_ID@");
		
		//	for all lines
		for (int line = 0; line < m_lines.length; line++)
		{
			//	Line Segment Value (i.e. not calculation)
			if (m_lines[line].isLineTypeSegmentValue())
				insertLine (line);
		}	//	for all lines

		insertLineDetail();
		doCalculations();
		doColumnPercentageOfLineForMultiRange();

		deleteUnprintedLines();
		
		scaleResults();

		//	Create Report
		if (Ini.isClient())
			getProcessInfo().setTransientObject (getPrintFormat());
		else
			getProcessInfo().setSerializableObject(getPrintFormat());

		if (log.isLoggable(Level.FINE)) log.fine((System.currentTimeMillis() - m_start) + " ms");
		return "";
	}	//	doIt

	/**************************************************************************
	 * 	For all columns (in a line) with relative period access
	 * 	@param line line
	 */
	private void insertLine (int line)
	{
		if (log.isLoggable(Level.INFO)) log.info("" + m_lines[line]);

		//	No source lines - Headings
		if (m_lines[line] == null || m_lines[line].getSources().length == 0)
		{
			log.warning ("No Source lines: " + m_lines[line]);
			return;
		}

		StringBuffer update = new StringBuffer();
		//	for all columns
		for (int col = 0; col < m_columns.length; col++)
		{
			//	Ignore calculation columns
			if (m_columns[col].isColumnTypeCalculation())
				continue;
			StringBuilder info = new StringBuilder();
			info.append("Line=").append(line).append(",Col=").append(col);

			//	SELECT SUM()
			StringBuffer select = new StringBuffer ("SELECT ");
			if (m_lines[line].getPAAmountType() != null)				//	line amount type overwrites column
			{
				String sql = m_lines[line].getSelectClause (true);
				select.append (sql);
				info.append(": LineAmtType=").append(m_lines[line].getPAAmountType());
			}
			else if (m_columns[col].getPAAmountType() != null)
			{
				String sql = m_columns[col].getSelectClause (true);
				select.append (sql);
				info.append(": ColumnAmtType=").append(m_columns[col].getPAAmountType());
			}
			else
			{
				log.warning("No Amount Type in line: " + m_lines[line] + " or column: " + m_columns[col]);
				continue;
			}
			
			if (p_PA_ReportCube_ID > 0) 
				select.append(" FROM Fact_Acct_Summary fa WHERE DateAcct ");
			else {
				//	Get Period/Date info
				select.append(" FROM Fact_Acct fa WHERE TRUNC(DateAcct) ");
			}

			BigDecimal relativeOffset = null;	//	current
			if (m_columns[col].isColumnTypeRelativePeriod())
				relativeOffset = m_columns[col].getRelativePeriod();
			FinReportPeriod frp = getPeriod (relativeOffset);
			if (m_lines[line].getPAPeriodType() != null)			//	line amount type overwrites column
			{
				info.append(" - LineDateAcct=");
				if (m_lines[line].isPeriod())
				{
					String sql = frp.getPeriodWhere();
					info.append("Period");
					select.append(sql);
				}
				else if (m_lines[line].isYear())
				{
					String sql = frp.getYearWhere();
					info.append("Year");
					select.append(sql);
				}
				else if (m_lines[line].isTotal())
				{
					String sql = frp.getTotalWhere();
					info.append("Total");
					select.append(sql);
				}
				else if (m_lines[line].isNatural())
				{
						select.append( frp.getNaturalWhere("fa"));
				}
				else
				{
					log.log(Level.SEVERE, "No valid Line PAPeriodType");
					select.append("=0");	// valid sql	
				}
			}
			else if (m_columns[col].getPAPeriodType() != null)
			{
				info.append(" - ColumnDateAcct=");
				if (m_columns[col].isPeriod())
				{
					String sql = frp.getPeriodWhere();
					info.append("Period");
					select.append(sql);
				}
				else if (m_columns[col].isYear())
				{
					String sql = frp.getYearWhere();
					info.append("Year");
					select.append(sql);
				}
				else if (m_columns[col].isTotal())
				{
					String sql = frp.getTotalWhere();
					info.append("Total");
					select.append(sql);
				}
				else if (m_columns[col].isNatural())
				{
					select.append( frp.getNaturalWhere("fa"));
				}
				else
				{
					log.log(Level.SEVERE, "No valid Column PAPeriodType");
					select.append("=0");	// valid sql	
				}
			}

		//	Line Where
		String s = m_lines[line].getWhereClause(p_PA_Hierarchy_ID);	//	(sources, posting type)
		if (s != null && s.length() > 0)
			select.append(" AND ").append(s);

		//	Report Where
		s = m_report.getWhereClause();
		if (s != null && s.length() > 0)
			select.append(" AND ").append(s);

		//	PostingType
		if (!m_lines[line].isPostingType())		//	only if not defined on line
		{
			String PostingType = m_columns[col].getPostingType();
			if (PostingType != null && PostingType.length() > 0)
				select.append(" AND PostingType='").append(PostingType).append("'");
			// globalqss - CarlosRuiz
			if (MReportColumn.POSTINGTYPE_Budget.equals(PostingType)) {
				if (m_columns[col].getGL_Budget_ID() > 0)
					select.append(" AND GL_Budget_ID=" + m_columns[col].getGL_Budget_ID());
			}
			// end globalqss
		}

			if (m_columns[col].isColumnTypeSegmentValue())
				select.append(m_columns[col].getWhereClause(p_PA_Hierarchy_ID));
			
			//	Parameter Where
			select.append(m_parameterWhere);
			if (log.isLoggable(Level.FINEST)) log.finest("Line=" + line + ",Col=" + line + ": " + select);

			//	Update SET portion
			if (update.length() > 0)
				update.append(", ");
			update.append("Col_").append(col)
				.append(" = (").append(select).append(")");
			//
			if (log.isLoggable(Level.FINEST)) log.finest(info.toString());
		}
		//	Update Line Values
		if (update.length() > 0)
		{
			update.insert (0, "UPDATE T_Report SET ");
			update.append(" WHERE AD_PInstance_ID=").append(getAD_PInstance_ID())
				.append(" AND PA_ReportLine_ID=").append(m_lines[line].getPA_ReportLine_ID())
				.append(" AND ABS(LevelNo)<2");		//	0=Line 1=Acct
			int no = DB.executeUpdate(update.toString(), get_TrxName());
			if (no != 1)
				log.log(Level.SEVERE, "#=" + no + " for " + update);
			if (log.isLoggable(Level.FINEST)) log.finest(update.toString());
		}
	}	//	insertLine


	/**************************************************************************
	 *	Line + Column calculation
	 */
	private void doCalculations()
	{
		//	for all lines	***************************************************
		for (int line = 0; line < m_lines.length; line++)
		{
			if (!m_lines[line].isLineTypeCalculation ())
				continue;
			
			if (log.isLoggable(Level.FINE)) log.fine("Line " + line + " = #" + m_lines[line].getOper_1_ID() + " " 
				+ m_lines[line].getCalculationType() + " #" + m_lines[line].getOper_2_ID());

			List<Integer> addList = new ArrayList<Integer>();
			List<Integer> notAddList = new ArrayList<Integer>();
			
			boolean inverse = m_lines[line].isInverseDebitCreditOnly();
			
			if (m_lines[line].isCalculationTypeAdd()
					|| m_lines[line].isCalculationTypeRange())
			{
				for (int col = 0; col < m_columns.length; col++) 
				{
					if (m_columns[col].isColumnTypeCalculation() || !inverse)
					{
						addList.add(col);
					}
					else 
					{
						String amountType = m_columns[col].getPAAmountType();
						if (amountType != null && (amountType.startsWith("C") || amountType.startsWith("D")))
						{
							notAddList.add(col);
						}
						else
						{
							addList.add(col);
						}
					}
				}
			}
			else if (m_lines[line].isCalculationTypeSubtract()) 
			{
				for (int col = 0; col < m_columns.length; col++) 
				{
					if (m_columns[col].isColumnTypeCalculation() || !inverse) 
					{
						notAddList.add(col);
					}
					else
					{
						String amountType = m_columns[col].getPAAmountType();
						if (amountType != null && (amountType.startsWith("C") || amountType.startsWith("D")))
						{
							addList.add(col);
						}
						else
						{
							notAddList.add(col);
						}
					}					
				}
			} 
			else
			{
				//percentage
				for (int col = 0; col < m_columns.length; col++) 
				{
					notAddList.add(col);
				}
			}
			
			//	Adding
			if (addList.size() > 0)
			{
				int oper_1 = m_lines[line].getOper_1_ID();
				int oper_2 = m_lines[line].getOper_2_ID();

				//	Reverse range
				if (oper_1 > oper_2)
				{
					int temp = oper_1;
					oper_1 = oper_2;
					oper_2 = temp;
				}
				StringBuilder sb = new StringBuilder ("UPDATE T_Report SET ");
				if (DB.isPostgreSQL()) {
					for (int col : addList) 
					{
						if (col > 0)
							sb.append(",");
						sb.append ("Col_").append (col)
						  .append("=")
						  .append("r2.c").append (col);
					}
					sb.append(" FROM ( SELECT ");
					for (int col : addList) 
					{
						if (col > 0)
							sb.append(",");
						sb.append ("COALESCE(SUM(r2.Col_").append (col).append("),0) AS c").append(col);
					}
				} else {
					sb.append(" (");
					for (int col : addList) 
					{
						if (col > 0)
							sb.append(",");
						sb.append ("Col_").append (col);
					}
					sb.append(") = (SELECT ");
					for (int col : addList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("COALESCE(SUM(r2.Col_").append (col).append("),0)");
					}
				}
				
				sb.append(" FROM T_Report r2 WHERE r2.AD_PInstance_ID=").append(getAD_PInstance_ID())
					.append(" AND r2.PA_ReportLine_ID IN (");
				if (m_lines[line].isCalculationTypeAdd())
					sb.append(oper_1).append(",").append(oper_2);
				else
					sb.append(getLineIDs (oper_1, oper_2));		//	list of columns to add up
				sb.append(") AND ABS(r2.LevelNo)<1) ");		//	0=Line 1=Acct
				if (DB.isPostgreSQL()) {
					sb.append(" r2 ");
				}
				sb.append("WHERE T_Report.AD_PInstance_ID=").append(getAD_PInstance_ID())
					.append(" AND T_Report.PA_ReportLine_ID=").append(m_lines[line].getPA_ReportLine_ID())
					.append(" AND ABS(T_Report.LevelNo)<1");		//	not trx
				int no = DB.executeUpdate(sb.toString(), get_TrxName());
				if (no != 1)
					log.log(Level.SEVERE, "(+) #=" + no + " for " + m_lines[line] + " - " + sb.toString());
				else
				{
					if (log.isLoggable(Level.FINE)) log.fine("(+) Line=" + line + " - " + m_lines[line]);
					if (log.isLoggable(Level.FINEST)) log.finest ("(+) " + sb.toString ());
				}
			}
			
			//	No Add (subtract, percent)
			if (notAddList.size() > 0)
			{
				int oper_1 = m_lines[line].getOper_1_ID();
				int oper_2 = m_lines[line].getOper_2_ID();

				//	Step 1 - get First Value or 0 in there
				StringBuilder sb = new StringBuilder ("UPDATE T_Report SET ");
				if (DB.isPostgreSQL()) 
				{
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("Col_").append (col)
						  .append("=r2.c").append(col);
					}
					sb.append(" FROM (SELECT ");
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("COALESCE(r2.Col_").append (col).append(",0) AS c").append(col);
					}
				}
				else 
				{
					sb.append(" (");
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("Col_").append (col);
					}
					sb.append(") = (SELECT ");
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("COALESCE(r2.Col_").append (col).append(",0)");
					}
				}
				sb.append(" FROM T_Report r2 WHERE r2.AD_PInstance_ID=").append(getAD_PInstance_ID())
					.append(" AND r2.PA_ReportLine_ID=").append(oper_1)
					.append(" AND r2.Record_ID=0 AND r2.Fact_Acct_ID=0) ");
				if (DB.isPostgreSQL())
				{
					sb.append(" r2 ");
				}
				//
				sb.append("WHERE T_Report.AD_PInstance_ID=").append(getAD_PInstance_ID())
					   .append(" AND T_Report.PA_ReportLine_ID=").append(m_lines[line].getPA_ReportLine_ID())
					.append(" AND ABS(T_Report.LevelNo)<1");			//	0=Line 1=Acct
				int no = DB.executeUpdate(sb.toString(), get_TrxName());
				if (no != 1)
				{
					log.severe ("(x) #=" + no + " for " + m_lines[line] + " - " + sb.toString ());
					continue;
				}

				//	Step 2 - do Calculation with Second Value
				sb = new StringBuilder ("UPDATE T_Report r1 SET ");
				if (DB.isPostgreSQL())
				{
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("Col_").append (col).append("=");
						sb.append ("COALESCE(r1.Col_").append (col).append(",0)");
						// fix bug [ 1563664 ] Errors in values shown in Financial Reports
						// Carlos Ruiz - globalqss
						if (m_lines[line].isCalculationTypeSubtract()) {
							sb.append("-");
							// Solution, for subtraction replace the null with 0, instead of 0.000000001 
							sb.append (" r2.c").append (col);
						} else {
							// Solution, for division don't replace the null, convert 0 to null (avoid ORA-01476)
							sb.append("/ r2.c").append(col);
						}
						// end fix bug [ 1563664 ]
						if (m_lines[line].isCalculationTypePercent())
							sb.append(" *100");
					}
					sb.append(" FROM (SELECT ");
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						
						if (m_lines[line].isCalculationTypeSubtract()) {
							// Solution, for subtraction replace the null with 0, instead of 0.000000001 
							sb.append ("COALESCE(r2.Col_").append (col).append(",0) AS c").append(col);
						} else {
							// Solution, for division don't replace the null, convert 0 to null (avoid ORA-01476)
							sb.append ("CASE WHEN r2.Col_").append (col).append("=0 THEN NULL ELSE r2.Col_").append (col).append(" END AS c").append(col);
						}
					}
				}
				else
				{
					sb.append(" (");
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("Col_").append (col);
					}
					sb.append(") = (SELECT ");
					for (int col : notAddList)
					{
						if (col > 0)
							sb.append(",");
						sb.append ("COALESCE(r1.Col_").append (col).append(",0)");
						// fix bug [ 1563664 ] Errors in values shown in Financial Reports
						// Carlos Ruiz - globalqss
						if (m_lines[line].isCalculationTypeSubtract()) {
							sb.append("-");
							// Solution, for subtraction replace the null with 0, instead of 0.000000001 
							sb.append ("COALESCE(r2.Col_").append (col).append(",0)");
						} else {
							// Solution, for division don't replace the null, convert 0 to null (avoid ORA-01476)
							sb.append("/");
							sb.append ("CASE WHEN r2.Col_").append (col).append("=0 THEN NULL ELSE r2.Col_").append (col).append(" END");
						}
						// end fix bug [ 1563664 ]
						if (m_lines[line].isCalculationTypePercent())
							sb.append(" *100");
					}
				}
				sb.append(" FROM T_Report r2 WHERE r2.AD_PInstance_ID=").append(getAD_PInstance_ID())
					.append(" AND r2.PA_ReportLine_ID=").append(oper_2)
					.append(" AND r2.Record_ID=0 AND r2.Fact_Acct_ID=0) ");
				if (DB.isPostgreSQL())
				{
					sb.append(" r2 ");
				}
				//
				sb.append("WHERE r1.AD_PInstance_ID=").append(getAD_PInstance_ID())
					   .append(" AND r1.PA_ReportLine_ID=").append(m_lines[line].getPA_ReportLine_ID())
					.append(" AND ABS(r1.LevelNo)<1");			//	0=Line 1=Acct
				no = DB.executeUpdate(sb.toString(), get_TrxName());
				if (no != 1)
					log.severe ("(x) #=" + no + " for " + m_lines[line] + " - " + sb.toString ());
				else
				{
					if (log.isLoggable(Level.FINE)) log.fine("(x) Line=" + line + " - " + m_lines[line]);
					if (log.isLoggable(Level.FINEST)) log.finest (sb.toString());
				}
			}
		}	//	for all lines


		//	for all columns		***********************************************
		for (int col = 0; col < m_columns.length; col++)
		{
			//	Only Calculations
			if (!m_columns[col].isColumnTypeCalculation ())
				continue;

			StringBuilder sb = new StringBuilder ("UPDATE T_Report SET ");
			//	Column to set
			sb.append ("Col_").append (col).append("=");
			//	First Operand
			int ii_1 = getColumnIndex(m_columns[col].getOper_1_ID());
			if (ii_1 < 0)
			{
				log.log(Level.SEVERE, "Column Index for Operator 1 not found - " + m_columns[col]);
				continue;
			}
			//	Second Operand
			int ii_2 = getColumnIndex(m_columns[col].getOper_2_ID());
			if (ii_2 < 0)
			{
				log.log(Level.SEVERE, "Column Index for Operator 2 not found - " + m_columns[col]);
				continue;
			}
			if (log.isLoggable(Level.FINE)) log.fine("Column " + col + " = #" + ii_1 + " " 
				+ m_columns[col].getCalculationType() + " #" + ii_2);
			//	Reverse Range
			if (ii_1 > ii_2 && m_columns[col].isCalculationTypeRange())
			{
				if (log.isLoggable(Level.FINE)) log.fine("Swap operands from " + ii_1 + " op " + ii_2);
				int temp = ii_1;
				ii_1 = ii_2;
				ii_2 = temp;
			}

			//	+
			if (m_columns[col].isCalculationTypeAdd())
				sb.append ("COALESCE(Col_").append (ii_1).append(",0)")
					.append("+")
					.append ("COALESCE(Col_").append (ii_2).append(",0)");
			//	-
			else if (m_columns[col].isCalculationTypeSubtract())
				sb.append ("COALESCE(Col_").append (ii_1).append(",0)")
					.append("-")
					.append ("COALESCE(Col_").append (ii_2).append(",0)");
			//	/
			if (m_columns[col].isCalculationTypePercent()) 
			{
				String oper2Line = (String) m_columns[col].get_Value("Oper_2_LineName");
				String oper1col = "Col_" + ii_1;
				String oper2col = "Col_" + ii_2;
				if (oper2Line != null)
				{
					String oper2 = null;
					//multiple range or all column value as percentage of a single calculated line value
					String[] multi = oper2Line.split("[,]");
					if (multi.length > 1)
						continue;
					String colsql = "SELECT a." + oper2col + " FROM T_Report a " +
							" INNER JOIN PA_ReportLine b ON a.PA_ReportLine_ID = b.PA_ReportLine_ID " +
							" WHERE a.AD_PInstance_ID = " + getAD_PInstance_ID() +
							" AND b.Name = ?";
					BigDecimal value2 = DB.getSQLValueBD(get_TrxName(), colsql, oper2Line);
					if (value2 != null && value2.signum() != 0)
						oper2 = value2.toPlainString();

					if (oper2 == null)
					{
						sb.append(" NULL ");
					}
					else
					{
						sb.append("Round(");
						sb.append("COALESCE(").append(oper1col).append(",0)")
						  .append("/")
						  .append(oper2)
						  .append("*100 ");
						sb.append(", 2)");
					}
				}
				else
				{
					sb.append ("CASE WHEN COALESCE(Col_").append(ii_2)
						.append(",0)=0 THEN NULL ELSE ")
						.append("COALESCE(Col_").append (ii_1).append(",0)")
						.append("/")
						.append ("Col_").append (ii_2)
						.append("*100 END");	//	Zero Divide
				}
			}
			//	Range
			else if (m_columns[col].isCalculationTypeRange())
			{
				sb.append ("COALESCE(Col_").append (ii_1).append(",0)");
				for (int ii = ii_1+1; ii <= ii_2; ii++)
					sb.append("+COALESCE(Col_").append (ii).append(",0)");
			}
			//
			sb.append(" WHERE AD_PInstance_ID=").append(getAD_PInstance_ID())
				.append(" AND ABS(LevelNo)<2");			//	0=Line 1=Acct
			int no = DB.executeUpdate(sb.toString(), get_TrxName());
			if (no < 1)
				log.severe ("#=" + no + " for " + m_columns[col] 
					+ " - " + sb.toString());
			else
			{
				if (log.isLoggable(Level.FINE)) log.fine("Col=" + col + " - " + m_columns[col]);
				if (log.isLoggable(Level.FINEST)) log.finest (sb.toString ());
			}
		} 	//	for all columns

	}	//	doCalculations

	/**
	 * percentage calculation for column value against calculated line value for multiple range
	 */
	private void doColumnPercentageOfLineForMultiRange() {
		//	for all columns		***********************************************
		for (int col = 0; col < m_columns.length; col++)
		{
			//	Only Calculations
			if (!m_columns[col].isColumnTypeCalculation ())
				continue;

			if (!m_columns[col].isCalculationTypePercent())
				continue;

			//	First Operand
			int ii_1 = getColumnIndex(m_columns[col].getOper_1_ID());
			if (ii_1 < 0)
			{
				log.log(Level.SEVERE, "Column Index for Operator 1 not found - " + m_columns[col]);
				continue;
			}
			//	Second Operand
			int ii_2 = getColumnIndex(m_columns[col].getOper_2_ID());
			if (ii_2 < 0)
			{
				log.log(Level.SEVERE, "Column Index for Operator 2 not found - " + m_columns[col]);
				continue;
			}
			log.fine("Column " + col + " = #" + ii_1 + " "
				+ m_columns[col].getCalculationType() + " #" + ii_2);
			//	Reverse Range
			if (ii_1 > ii_2 && m_columns[col].isCalculationTypeRange())
			{
				log.fine("Swap operands from " + ii_1 + " op " + ii_2);
				int temp = ii_1;
				ii_1 = ii_2;
				ii_2 = temp;
			}

			String oper2Line = (String) m_columns[col].get_Value("Oper_2_LineName");
			String oper1col = "Col_" + ii_1;
			String oper2col = "Col_" + ii_2;
			if (oper2Line == null)
				continue;

			String oper2 = null;
			String[] multi = oper2Line.split("[,]");
			if (multi.length < 2)
				continue;

			boolean lteq = true; //less than or equal to
			String seqsql = "SELECT b.seqNo FROM T_Report a " +
			" INNER JOIN PA_ReportLine b ON a.PA_ReportLine_ID = b.PA_ReportLine_ID " +
			" WHERE a.AD_PInstance_ID = " + getAD_PInstance_ID() +
			" AND b.Name = ?";
			int seqNo = -1;
			try {
				seqNo = Integer.parseInt(multi[0].trim());
			} catch (Exception e) {}
			if (seqNo == -1)
			{
				seqNo = DB.getSQLValue(get_TrxName(), seqsql, multi[0].trim());
			}
			if (seqNo < 0)
				continue;

			String countsql = "SELECT count(*) FROM T_Report a " +
			" INNER JOIN PA_ReportLine b ON a.PA_ReportLine_ID = b.PA_ReportLine_ID " +
			" WHERE a.AD_PInstance_ID = " + getAD_PInstance_ID() +
			" AND b.seqNo < ? AND a."+oper1col+" IS NOT NULL " +
			" AND a."+oper2col+" IS NOT NULL ";
			int count = DB.getSQLValue(get_TrxName(), countsql, seqNo);
			if (count == 0)
				lteq = false;

			List<Integer> seqlist = new ArrayList<Integer>();
			seqlist.add(seqNo);
			for(int i = 1; i < multi.length; i++)
			{
				seqNo = -1;
				try {
					seqNo = Integer.parseInt(multi[i].trim());
				} catch (Exception e) {}
				if (seqNo == -1)
				{
					seqNo = DB.getSQLValue(get_TrxName(), seqsql, multi[i].trim());
				}
				if (seqNo < 0)
					continue;
				seqlist.add(seqNo);
			}

			for (int i = 0; i < seqlist.size(); i++)
			{
				int currentSeq = seqlist.get(i);
				StringBuffer sb = new StringBuffer ("UPDATE T_Report SET ");
				//	Column to set
				sb.append ("Col_").append (col).append("=");

				String colsql = "SELECT a." + oper2col + " FROM T_Report a " +
						" INNER JOIN PA_ReportLine b ON a.PA_ReportLine_ID = b.PA_ReportLine_ID " +
						" WHERE a.AD_PInstance_ID = " + getAD_PInstance_ID() +
						" AND b.seqNo = ?";
				BigDecimal value2 = DB.getSQLValueBD(get_TrxName(), colsql, currentSeq);
				if (value2 != null && value2.signum() != 0)
					oper2 = value2.toPlainString();

				if (oper2 == null)
				{
					sb.append(" NULL ");
				}
				else
				{
					sb.append("Round(");
					sb.append("COALESCE(").append(oper1col).append(",0)")
					  .append("/")
					  .append(oper2)
					  .append("*100 ");
					sb.append(", 2)");
				}
							//
				sb.append(" WHERE AD_PInstance_ID=").append(getAD_PInstance_ID())
					.append(" AND ABS(LevelNo)<2");			//	0=Line 1=Acct
				if (lteq)
				{
					sb.append(" AND seqNo <= " + currentSeq);
					if (i > 0)
					{
						int prevSeq = seqlist.get(i - 1);
						sb.append(" AND seqNo > " + prevSeq);
					}
				}
				else
				{
					sb.append(" AND seqNo >= " + currentSeq);
					if (i+1 < seqlist.size())
					{
						int nextSeq = seqlist.get(i+1);
						sb.append(" AND seqNo < " + nextSeq);
					}
				}
				int no = DB.executeUpdate(sb.toString(), get_TrxName());
				if (no < 1)
					log.severe ("#=" + no + " for " + m_columns[col]
						+ " - " + sb.toString());
				else
				{
					log.fine("Col=" + col + " - " + m_columns[col]);
					log.finest (sb.toString ());
				}
			}

		}

	}

	/**
	 * 	Get List of PA_ReportLine_ID from .. to
	 * 	@param fromID from ID
	 * 	@param toID to ID
	 * 	@return comma separated list
	 */
	private String getLineIDs (int fromID, int toID)
	{
		if (log.isLoggable(Level.FINEST)) log.finest("From=" + fromID + " To=" + toID);
		int firstPA_ReportLine_ID = 0;
		int lastPA_ReportLine_ID = 0;
		
		// find the first and last ID 
		for (int line = 0; line < m_lines.length; line++)
		{
			int PA_ReportLine_ID = m_lines[line].getPA_ReportLine_ID();
			if (PA_ReportLine_ID == fromID || PA_ReportLine_ID == toID)
			{
				if (firstPA_ReportLine_ID == 0) { 
					firstPA_ReportLine_ID = PA_ReportLine_ID;
				} else {
					lastPA_ReportLine_ID = PA_ReportLine_ID;
					break;
				}
			}
		}

		// add to the list
		StringBuilder sb = new StringBuilder();
		sb.append(firstPA_ReportLine_ID);
		boolean addToList = false;
		for (int line = 0; line < m_lines.length; line++)
		{
			int PA_ReportLine_ID = m_lines[line].getPA_ReportLine_ID();
			if (log.isLoggable(Level.FINEST)) log.finest("Add=" + addToList 
				+ " ID=" + PA_ReportLine_ID + " - " + m_lines[line]);
			if (addToList)
			{
				sb.append (",").append (PA_ReportLine_ID);
				if (PA_ReportLine_ID == lastPA_ReportLine_ID)		//	done
					break;
			}
			else if (PA_ReportLine_ID == firstPA_ReportLine_ID)	//	from already added
				addToList = true;
		}
		return sb.toString();
	}	//	getLineIDs
	
	/**
	 * 	Get Column Index
	 * 	@param PA_ReportColumn_ID PA_ReportColumn_ID
	 * 	@return zero based index or if not found
	 */
	private int getColumnIndex (int PA_ReportColumn_ID)
	{
		for (int i = 0; i < m_columns.length; i++)
		{
			if (m_columns[i].getPA_ReportColumn_ID() == PA_ReportColumn_ID)
				return i;
		}
		return -1;
	}	//	getColumnIndex

	
	/**************************************************************************
	 * 	Get Financial Reporting Period based on reporting Period and offset.
	 * 	@param relativeOffset offset
	 * 	@return reporting period
	 */
	private FinReportPeriod getPeriod (BigDecimal relativeOffset)
	{
		if (relativeOffset == null)
			return getPeriod(0);
		return getPeriod(relativeOffset.intValue());
	}	//	getPeriod

	/**
	 * 	Get Financial Reporting Period based on reporting Period and offset.
	 * 	@param relativeOffset offset
	 * 	@return reporting period
	 */
	private FinReportPeriod getPeriod (int relativeOffset)
	{
		//	find current reporting period C_Period_ID
		if (m_reportPeriod < 0)
		{
			for (int i = 0; i < m_periods.length; i++)
			{
				if (p_C_Period_ID == m_periods[i].getC_Period_ID())
				{
					m_reportPeriod = i;
					break;
				}
			}
		}
		if (m_reportPeriod < 0 || m_reportPeriod >= m_periods.length)
			throw new UnsupportedOperationException ("Period index not found - ReportPeriod="
				+ m_reportPeriod + ", C_Period_ID=" + p_C_Period_ID);

		//	Bounds check
		int index = m_reportPeriod + relativeOffset;
		if (index < 0)
		{
			log.log(Level.SEVERE, "Relative Offset(" + relativeOffset 
				+ ") not valid for selected Period(" + m_reportPeriod + ")");
			index = 0;
		}
		else if (index >= m_periods.length)
		{
			log.log(Level.SEVERE, "Relative Offset(" + relativeOffset 
				+ ") not valid for selected Period(" + m_reportPeriod + ")");
			index = m_periods.length - 1;
		}
		//	Get Period
		return m_periods[index];
	}	//	getPeriod

	
	/**************************************************************************
	 *	Insert Detail Lines if enabled
	 */
	private void insertLineDetail()
	{
		if (!m_report.isListSources())
			return;
		log.info("");

		//	for all source lines
		for (int line = 0; line < m_lines.length; line++)
		{
			//	Line Segment Value (i.e. not calculation)
			if (m_lines[line].isLineTypeSegmentValue ())
				insertLineSource (line);
		}

		//Add the ability to display all child account elements of a summary account even though there is no transaction 
		//for that child account element in the selected period.
		boolean listSourceNoTrx = m_report.isListSourcesXTrx();
		if (!listSourceNoTrx) {
			//	Clean up empty rows
			StringBuilder sql = new StringBuilder("DELETE FROM T_Report WHERE ABS(LevelNo)<>0")
				.append(" AND Col_0 IS NULL AND Col_1 IS NULL AND Col_2 IS NULL AND Col_3 IS NULL AND Col_4 IS NULL AND Col_5 IS NULL AND Col_6 IS NULL AND Col_7 IS NULL AND Col_8 IS NULL AND Col_9 IS NULL")
				.append(" AND Col_10 IS NULL AND Col_11 IS NULL AND Col_12 IS NULL AND Col_13 IS NULL AND Col_14 IS NULL AND Col_15 IS NULL AND Col_16 IS NULL AND Col_17 IS NULL AND Col_18 IS NULL AND Col_19 IS NULL AND Col_20 IS NULL"); 
			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Deleted empty #=" + no);
		}
		//
		
		//	Set SeqNo
		StringBuilder sql = new StringBuilder ("UPDATE T_Report r1 "
			+ "SET SeqNo = (SELECT SeqNo "
				+ "FROM T_Report r2 "
				+ "WHERE r1.AD_PInstance_ID=r2.AD_PInstance_ID AND r1.PA_ReportLine_ID=r2.PA_ReportLine_ID"
				+ " AND r2.Record_ID=0 AND r2.Fact_Acct_ID=0)"
			+ "WHERE SeqNo IS NULL");
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("SeqNo #=" + no);

		if (!m_report.isListTrx())
			return;

		//	Set Name,Description
		String sql_select = "SELECT e.Name, fa.Description "
			+ "FROM Fact_Acct fa"
			+ " INNER JOIN AD_Table t ON (fa.AD_Table_ID=t.AD_Table_ID)"
			+ " INNER JOIN AD_Element e ON (t.TableName||'_ID'=e.ColumnName) "
			+ "WHERE r.Fact_Acct_ID=fa.Fact_Acct_ID";
		//	Translated Version ...
		sql = new StringBuilder ("UPDATE T_Report r SET (Name,Description)=(")
			.append(sql_select).append(") "
			+ "WHERE Fact_Acct_ID <> 0 AND AD_PInstance_ID=")
			.append(getAD_PInstance_ID());
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Trx Name #=" + no + " - " + sql.toString());
	}	//	insertLineDetail

	/**
	 * 	Insert Detail Line per Source.
	 * 	For all columns (in a line) with relative period access
	 * 	- AD_PInstance_ID, PA_ReportLine_ID, variable, 0 - Level 1
	 * 	@param line line
	 */
	private void insertLineSource (int line)
	{
		if (log.isLoggable(Level.INFO)) log.info("Line=" + line + " - " + m_lines[line]);

		//	No source lines
		if (m_lines[line] == null || m_lines[line].getSources().length == 0)
			return;
		String variable = m_lines[line].getSourceColumnName();
		if (variable == null || variable.equals("") )
			return;
		if (log.isLoggable(Level.FINE)) log.fine("Variable=" + variable);

		//	Insert
		StringBuffer insert = new StringBuffer("INSERT INTO T_Report "
			+ "(AD_PInstance_ID, PA_ReportLine_ID, Record_ID,Fact_Acct_ID,LevelNo ");
		for (int col = 0; col < m_columns.length; col++)
			insert.append(",Col_").append(col);
		//	Select
		insert.append(") SELECT ")
			.append(getAD_PInstance_ID()).append(",")
			.append(m_lines[line].getPA_ReportLine_ID()).append(",")
			.append(variable).append(",0,");
		
		boolean listSourceNoTrx = m_report.isListSourcesXTrx() && variable.equalsIgnoreCase(I_C_ValidCombination.COLUMNNAME_Account_ID);
		//SQL to get the Account Element which no transaction		
		StringBuffer unionInsert = listSourceNoTrx ? new StringBuffer() : null;
		if (listSourceNoTrx) {
			unionInsert.append(" UNION SELECT ")
			.append(getAD_PInstance_ID()).append(",")
			.append(m_lines[line].getPA_ReportLine_ID()).append(",")
			.append(variable).append(",0,");
		}
		//
				
		if (p_DetailsSourceFirst) {
			insert.append("-1 ");
			if (listSourceNoTrx)
				unionInsert.append("-1 ");
		} else {
			insert.append("1 ");
			if (listSourceNoTrx)
				unionInsert.append("1 ");
		}

		//	for all columns create select statement
		for (int col = 0; col < m_columns.length; col++)
		{
			insert.append(", ");
			if (listSourceNoTrx)
				unionInsert.append(", Cast(NULL AS NUMBER)");
			//	No calculation
			if (m_columns[col].isColumnTypeCalculation())
			{
				insert.append("Cast(NULL AS NUMBER)");
				continue;
			}

			//	SELECT SUM()
			StringBuffer select = new StringBuffer ("SELECT ");
			if (m_lines[line].getPAAmountType() != null)				//	line amount type overwrites column
				select.append (m_lines[line].getSelectClause (true));
			else if (m_columns[col].getPAAmountType() != null)
				select.append (m_columns[col].getSelectClause (true));
			else
			{
				insert.append("Cast(NULL AS NUMBER)");
				continue;
			}

			if (p_PA_ReportCube_ID > 0) {
				select.append(" FROM Fact_Acct_Summary fb WHERE DateAcct ");
			}  //report cube
			else {
			//	Get Period info
				select.append(" FROM Fact_Acct fb WHERE TRUNC(DateAcct) ");
			}
			FinReportPeriod frp = getPeriod (m_columns[col].getRelativePeriod());
			if (m_lines[line].getPAPeriodType() != null)			//	line amount type overwrites column
			{
				if (m_lines[line].isPeriod())
					select.append(frp.getPeriodWhere());
				else if (m_lines[line].isYear())
					select.append(frp.getYearWhere());
				else if (m_lines[line].isNatural())
					select.append(frp.getNaturalWhere("fb"));
				else
					select.append(frp.getTotalWhere());
			}
			else if (m_columns[col].getPAPeriodType() != null)
			{
				if (m_columns[col].isPeriod())
					select.append(frp.getPeriodWhere());
				else if (m_columns[col].isYear())
					select.append(frp.getYearWhere());
				else if (m_columns[col].isNatural())
					select.append(frp.getNaturalWhere("fb"));
				else
					select.append(frp.getTotalWhere());
			}
			//	Link
			select.append(" AND fb.").append(variable).append("=x.").append(variable);
			//	PostingType
			if (!m_lines[line].isPostingType())		//	only if not defined on line
			{
				String PostingType = m_columns[col].getPostingType();
				if (PostingType != null && PostingType.length() > 0)
					select.append(" AND fb.PostingType='").append(PostingType).append("'");
				// globalqss - CarlosRuiz
				if (MReportColumn.POSTINGTYPE_Budget.equals(PostingType)) {
					if (m_columns[col].getGL_Budget_ID() > 0)
						select.append(" AND GL_Budget_ID=" + m_columns[col].getGL_Budget_ID());
				}
				// end globalqss
			}
			//	Report Where
			String s = m_report.getWhereClause();
			if (s != null && s.length() > 0)
				select.append(" AND ").append(s);
			//	Limited Segment Values
			if (m_columns[col].isColumnTypeSegmentValue())
				select.append(m_columns[col].getWhereClause(p_PA_Hierarchy_ID));
			
			//	Parameter Where
			select.append(m_parameterWhere);
			if (log.isLoggable(Level.FINEST))
				log.finest("Col=" + col + ", Line=" + line + ": " + select);
			//
			insert.append("(").append(select).append(")");
		}
		//	WHERE (sources, posting type)
		StringBuffer where = new StringBuffer(m_lines[line].getWhereClause(p_PA_Hierarchy_ID));
		
		StringBuffer unionWhere = listSourceNoTrx ? new StringBuffer() : null;
		if (listSourceNoTrx && m_lines[line].getSources() != null && m_lines[line].getSources().length > 0){
			//	Only one
			if (m_lines[line].getSources().length == 1 
				&& (m_lines[line].getSources()[0]).getElementType().equalsIgnoreCase(MReportSource.ELEMENTTYPE_Account))
			{
				unionWhere.append(m_lines[line].getSources()[0].getWhereClause(p_PA_Hierarchy_ID));
			}
			else
			{
				//	Multiple
				StringBuffer sb = new StringBuffer ("(");
				for (int i = 0; i < m_lines[line].getSources().length; i++)
				{
					if ((m_lines[line].getSources()[i]).getElementType().equalsIgnoreCase(MReportSource.ELEMENTTYPE_Account)) {
						if (i > 0)
							sb.append (" OR ");
						sb.append (m_lines[line].getSources()[i].getWhereClause(p_PA_Hierarchy_ID));
					}
				}
				sb.append (")");
				unionWhere.append(sb.toString ());
			}
			//	Posting Type
			String PostingType = m_lines[line].getPostingType();
			if (PostingType != null && PostingType.length() > 0)
			{
				if (unionWhere.length() > 0)
					unionWhere.append(" AND ");
				unionWhere.append("PostingType='" + PostingType + "'");
				if (MReportLine.POSTINGTYPE_Budget.equals(PostingType)) {
					if (m_lines[line].getGL_Budget_ID() > 0)
						unionWhere.append(" AND GL_Budget_ID=" + m_lines[line].getGL_Budget_ID());
				}
			}
		}
		//

		String s = m_report.getWhereClause();
		if (s != null && s.length() > 0)
		{
			if (where.length() > 0)
				where.append(" AND ");
			where.append(s);

			if (listSourceNoTrx)
			{
				if (unionWhere.length() > 0)
					unionWhere.append(" AND ");
				unionWhere.append(s);
			}

		}
		if (where.length() > 0)
			where.append(" AND ");
		where.append(variable).append(" IS NOT NULL");

		if (p_PA_ReportCube_ID > 0)
			insert.append(" FROM Fact_Acct_Summary x WHERE ").append(where);
		else
			//	FROM .. WHERE
			insert.append(" FROM Fact_Acct x WHERE ").append(where);	
		//
		insert.append(m_parameterWhere)
			.append(" GROUP BY ").append(variable);

		if (listSourceNoTrx) {
			if (unionWhere.length() > 0)
				unionWhere.append(" AND ");
			unionWhere.append(variable).append(" IS NOT NULL");
			unionWhere.append(" AND Account_ID not in (select Account_ID ");
			if (p_PA_ReportCube_ID > 0)
				unionWhere.append(" from Fact_Acct_Summary x WHERE ").append(where);
			else
				unionWhere.append(" from Fact_Acct x WHERE ").append(where);	
			//
			unionWhere.append(m_parameterWhere).append(")");
	
			unionInsert.append(" FROM (select c_elementvalue.c_elementvalue_id as Account_ID, c_acctschema_element.C_AcctSchema_ID from c_elementvalue inner join c_acctschema_element on (c_elementvalue.c_element_id = c_acctschema_element.c_element_id)) x WHERE ").append(unionWhere);
			unionInsert.append(" GROUP BY ").append(variable);
				
			insert.append(unionInsert);
		}

		int no = DB.executeUpdate(insert.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Source #=" + no + " - " + insert);
		if (no == 0)
			return;

		//	Set Name,Description
		StringBuffer sql = new StringBuffer ("UPDATE T_Report SET (Name,Description)=(")
			.append(m_lines[line].getSourceValueQuery()).append("T_Report.Record_ID) "
			//
			+ "WHERE Record_ID <> 0 AND AD_PInstance_ID=").append(getAD_PInstance_ID())
			.append(" AND PA_ReportLine_ID=").append(m_lines[line].getPA_ReportLine_ID())
			.append(" AND Fact_Acct_ID=0");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Name #=" + no + " - " + sql.toString());

		if (m_report.isListTrx())
			insertLineTrx (line, variable);
	}	//	insertLineSource

	/**
	 * 	Create Trx Line per Source Detail.
	 * 	- AD_PInstance_ID, PA_ReportLine_ID, variable, Fact_Acct_ID - Level 2
	 * 	@param line line
	 * 	@param variable variable, e.g. Account_ID
	 */
	private void insertLineTrx (int line, String variable)
	{
		if (log.isLoggable(Level.INFO)) log.info("Line=" + line + " - Variable=" + variable);

		//	Insert
		StringBuffer insert = new StringBuffer("INSERT INTO T_Report "
			+ "(AD_PInstance_ID, PA_ReportLine_ID, Record_ID,Fact_Acct_ID,LevelNo ");
		for (int col = 0; col < m_columns.length; col++)
			insert.append(",Col_").append(col);
		//	Select
		insert.append(") SELECT ")
			.append(getAD_PInstance_ID()).append(",")
			.append(m_lines[line].getPA_ReportLine_ID()).append(",")
			.append(variable).append(",Fact_Acct_ID, ");
		if (p_DetailsSourceFirst)
			insert.append("-2 ");
		else
			insert.append("2 ");

		//	for all columns create select statement
		for (int col = 0; col < m_columns.length; col++)
		{
			insert.append(", ");
			//	Only relative Period (not calculation or segment value)
			if (!(m_columns[col].isColumnTypeRelativePeriod() 
				&& m_columns[col].getRelativePeriodAsInt() == 0))
			{
				insert.append("NULL");
				continue;
			}
			//	Amount Type ... Qty
			if (m_lines[line].getPAAmountType() != null)				//	line amount type overwrites column
				insert.append (m_lines[line].getSelectClause (false));
			else if (m_columns[col].getPAAmountType() != null)
				insert.append (m_columns[col].getSelectClause (false));
			else
			{
				insert.append("NULL");
				continue;
			}
		}
		//
		insert.append(" FROM Fact_Acct WHERE ")
			.append(m_lines[line].getWhereClause(p_PA_Hierarchy_ID));	//	(sources, posting type)
		//	Report Where
		String s = m_report.getWhereClause();
		if (s != null && s.length() > 0)
			insert.append(" AND ").append(s);
		insert.append(m_parameterWhere); // IDEMPIERE-130
		//	Period restriction
		FinReportPeriod frp = getPeriod (0);
		insert.append(" AND TRUNC(DateAcct) ")
			.append(frp.getPeriodWhere());
		//	PostingType ??
//		if (!m_lines[line].isPostingType())		//	only if not defined on line
//		{
//	      String PostingType = m_columns[col].getPostingType();
//  	    if (PostingType != null && PostingType.length() > 0)
//      	  	insert.append(" AND PostingType='").append(PostingType).append("'");
//			// globalqss - CarlosRuiz
//			if (PostingType.equals(MReportColumn.POSTINGTYPE_Budget)) {
//				if (m_columns[col].getGL_Budget_ID() > 0)
//					select.append(" AND GL_Budget_ID=" + m_columns[col].getGL_Budget_ID());
//			}
//			// end globalqss
//		}

		int no = DB.executeUpdate(insert.toString(), get_TrxName());
		if (log.isLoggable(Level.FINEST)) log.finest("Trx #=" + no + " - " + insert);
		if (no == 0)
			return;
	}	//	insertLineTrx

	
	/**************************************************************************
	 *	Delete Unprinted Lines
	 */
	private void deleteUnprintedLines()
	{
		for (int line = 0; line < m_lines.length; line++)
		{
			//	Not Printed - Delete in T
			if (!m_lines[line].isPrinted())
			{
				String sql = "DELETE FROM T_Report WHERE AD_PInstance_ID=" + getAD_PInstance_ID()
					+ " AND PA_ReportLine_ID=" + m_lines[line].getPA_ReportLine_ID();
				int no = DB.executeUpdate(sql, get_TrxName());
				if (no > 0)
					if (log.isLoggable(Level.FINE)) log.fine(m_lines[line].getName() + " - #" + no);
			}
		}	//	for all lines
	}	//	deleteUnprintedLines


	private void scaleResults() {

		for (int column = 0; column < m_columns.length; column++)
		{
			String factor = m_columns[column].getFactor();
			if ( factor != null )
			{
				int divisor = 1;
				if ( factor.equals("k") )
					divisor = 1000;
				else if (factor.equals("M"))
					divisor = 1000000;
				else
					break;
				
				String sql = "UPDATE T_Report SET Col_" + column 
					+ "=Col_" + column + "/" + divisor
					+  " WHERE AD_PInstance_ID=" + getAD_PInstance_ID();
				int no = DB.executeUpdate(sql, get_TrxName());
				if (no > 0)
					if (log.isLoggable(Level.FINE)) log.fine(m_columns[column].getName() + " - #" + no);
			}
		}
		
	}
	
	/**************************************************************************
	 *	Get/Create PrintFormat
	 * 	@return print format
	 */
	private MPrintFormat getPrintFormat()
	{
		int AD_PrintFormat_ID = m_report.getAD_PrintFormat_ID();
		if (log.isLoggable(Level.INFO)) log.info("AD_PrintFormat_ID=" + AD_PrintFormat_ID);
		MPrintFormat pf = null;
		boolean createNew = AD_PrintFormat_ID == 0;

		//	Create New
		if (createNew)
		{
			int AD_Table_ID = TABLE_T_REPORT;		//	T_Report
			pf = MPrintFormat.createFromTable(Env.getCtx(), AD_Table_ID);
			AD_PrintFormat_ID = pf.getAD_PrintFormat_ID();
			m_report.setAD_PrintFormat_ID(AD_PrintFormat_ID);
			m_report.saveEx();
		}
		else
			pf = MPrintFormat.get (getCtx(), AD_PrintFormat_ID, false);	//	use Cache

		//	Print Format Sync
		if (!m_report.getName().equals(pf.getName())) {
			pf.setName(m_report.getName());
			MPrintFormat.setUniqueName(pf.getAD_Client_ID(), pf, pf.getName());
		}
		if (m_report.getDescription() == null)
		{
			if (pf.getDescription () != null)
				pf.setDescription (null);
		}
		else if (!m_report.getDescription().equals(pf.getDescription()))
			pf.setDescription(m_report.getDescription());
		pf.saveEx();
		if (log.isLoggable(Level.FINE)) log.fine(pf + " - #" + pf.getItemCount());

		//	Print Format Item Sync
		int count = pf.getItemCount();
		for (int i = 0; i < count; i++)
		{
			MPrintFormatItem pfi = pf.getItem(i);
			String ColumnName = pfi.getColumnName();
			//
			if (ColumnName == null)
			{
				log.log(Level.SEVERE, "No ColumnName for #" + i + " - " + pfi);
				if (pfi.isPrinted())
					pfi.setIsPrinted(false);
				if (pfi.isOrderBy())
					pfi.setIsOrderBy(false);
				if (pfi.getSortNo() != 0)
					pfi.setSortNo(0);
			}
			else if (ColumnName.startsWith("Col"))
			{
				int index = Integer.parseInt(ColumnName.substring(4));
				if (index < m_columns.length)
				{
					pfi.setIsPrinted(m_columns[index].isPrinted());
					String s = m_columns[index].getName();
					
					if (m_columns[index].isColumnTypeRelativePeriod())
					{
						BigDecimal relativeOffset = m_columns[index].getRelativePeriod();
						FinReportPeriod frp = getPeriod (relativeOffset);
					
						if ( s.contains("@Period@") )
							s = s.replace("@Period@", frp.getName() );
					}
					
					if (!pfi.getName().equals(s))
					{
						pfi.setName (s);
						pfi.setPrintName (s);
					}
					int seq = 30 + index;
					if (pfi.getSeqNo() != seq)
						pfi.setSeqNo(seq);
					
					s = m_columns[index].getFormatPattern();
					pfi.setFormatPattern(s);
				}
				else	//	not printed
				{
					if (pfi.isPrinted())
						pfi.setIsPrinted(false);
				}
				//	Not Sorted
				if (pfi.isOrderBy())
					pfi.setIsOrderBy(false);
				if (pfi.getSortNo() != 0)
					pfi.setSortNo(0);
			}
			else if (ColumnName.equals("SeqNo"))
			{
				if (pfi.isPrinted())
					pfi.setIsPrinted(false);
				if (!pfi.isOrderBy())
					pfi.setIsOrderBy(true);
				if (pfi.getSortNo() != 10)
					pfi.setSortNo(10);
			}
			else if (ColumnName.equals("LevelNo"))
			{
				if (pfi.isPrinted())
					pfi.setIsPrinted(false);
				if (!pfi.isOrderBy())
					pfi.setIsOrderBy(true);
				if (pfi.getSortNo() != 20)
					pfi.setSortNo(20);
			}
			else if (ColumnName.equals("Name"))
			{
				if (pfi.getSeqNo() != 10)
					pfi.setSeqNo(10);
				if (!pfi.isPrinted())
					pfi.setIsPrinted(true);
				if (!pfi.isOrderBy())
					pfi.setIsOrderBy(true);
				if (pfi.getSortNo() != 30)
					pfi.setSortNo(30);
			}
			else if (ColumnName.equals("Description"))
			{
				if (pfi.getSeqNo() != 20)
					pfi.setSeqNo(20);
				if (!pfi.isPrinted())
					pfi.setIsPrinted(true);
				if (pfi.isOrderBy())
					pfi.setIsOrderBy(false);
				if (pfi.getSortNo() != 0)
					pfi.setSortNo(0);
			}
			else	//	Not Printed, No Sort
			{
				if (pfi.isPrinted())
					pfi.setIsPrinted(false);
				if (pfi.isOrderBy())
					pfi.setIsOrderBy(false);
				if (pfi.getSortNo() != 0)
					pfi.setSortNo(0);
			}
			pfi.saveEx();
			if (log.isLoggable(Level.FINE)) log.fine(pfi.toString());
		}
		//	set translated to original
		pf.setTranslation();
		
		// Reload to pick up changed pfi
		pf = MPrintFormat.get (getCtx(), AD_PrintFormat_ID, true);	//	no cache
		return pf;
	}	//	getPrintFormat

}	//	FinReport
