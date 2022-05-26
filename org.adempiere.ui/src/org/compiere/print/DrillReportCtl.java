package org.compiere.print;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessDrillRule;
import org.compiere.model.MProcessDrillRulePara;
import org.compiere.model.MQuery;
import org.compiere.model.MReportView;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.M_Element;
import org.compiere.model.PrintInfo;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 * Drill Report Controller
 * @author Igor Pojzl, Cloudempiere
 *
 */
public class DrillReportCtl {

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(DrillReportCtl.class);

	Properties m_ctx;

	int m_WindowNo = 0;
	private String m_TableName;
	private String m_ColumnName;
	private Object m_Value;

	private MQuery m_Query;

	private Integer m_AD_Table_ID;

	private String m_DisplayValue;

	/** Drill Tables Map */
	private KeyNamePair[] drillTables;

	/** Drill Table PrintFormats */
	private HashMap<Integer, KeyNamePair[]> drillTablePrintFormatMap = new HashMap<>();

	/** Drill Process Map */
	private KeyNamePair[] drillProcessList;

	/** Drill Process Rule Map */
	private HashMap<Integer, KeyNamePair[]> drillProcesRules;

	/** Drill Process Rule PrintFormats */
	private HashMap<Integer, KeyNamePair[]> drillProcessRulesPrintFormatMap = new HashMap<>();

	public DrillReportCtl(Properties ctx, String TableName, MQuery query, String ColumnName, Object Value, String displayValue, int WindowNo) {
		this.m_ctx = ctx;
		this.m_TableName = TableName;
		this.m_ColumnName = ColumnName;
		this.m_Value = Value;
		this.m_WindowNo = WindowNo;
		this.m_DisplayValue = displayValue;

		m_Query = query;

		this.initMaps();
	}


//	public DrillReportCtl(Properties ctx, String TableName, MQuery query, int WindowNo) {
//		this.m_ctx = ctx;
//		this.m_TableName = TableName;
//		this.m_WindowNo = WindowNo;
//
//		this.m_Query = query;
//
//		this.initMaps();
//
//	}

	/**
	 * Get Drill Table KeyNamePairs
	 */
	public KeyNamePair[] getDrillTables() {
		return this.drillTables;
	}

	/**
	 * Return Array of PrintFormat KeynamePairs
	 * @param AD_Table_ID
	 * @return KeyNamePair Array or Null if not found
	 */
	public KeyNamePair[] getDrillTablePrintFormat(int AD_Table_ID) {
		return this.drillTablePrintFormatMap.get(AD_Table_ID);
	}

	/**
	 * Return Array of Drill Process Rules
	 * @return
	 */
	public HashMap<Integer, KeyNamePair[]> getDrillProcesRules() {
		return drillProcesRules;
	}

	/**
	 *
	 * @param AD_Process_DrillRule_ID
	 * @return
	 */
	public KeyNamePair[] getDrillProcessRulesPrintFormatMap(int AD_Process_DrillRule_ID) {
		return drillProcessRulesPrintFormatMap.get(AD_Process_DrillRule_ID);
	}


	public String getDisplayValue() {
		return m_DisplayValue;
	}


	public Object getValue() {
		return m_Value;
	}


	/**
	 * Init All Data Maps for Window
	 */
	private void initMaps() {
		// Init Table Name
		this.m_AD_Table_ID = MTable.getTable_ID(m_TableName);


		// Get Drill Table Map
		initDrillTableMap();

		// Init Drill Print Format Map
		initDrillTablePrintFormatMap();

		// Init Drill Process Rule Maps
		initProcessDrillRuleMap();

		// Init Drill Process Rule Print Formats
		initDrillProcessRulePrintFormatMap();
	}

	/**
	 * Initialize Drill Process Rules Map
	 */
	private void initProcessDrillRuleMap() {
		HashMap<Integer, String> drillProcessMap = new HashMap<>();
		HashMap<Integer, ArrayList<KeyNamePair>> drillProcessRuleMap = new HashMap<>();
		M_Element element = M_Element.get(m_ctx, m_ColumnName);
		if(element != null) {
			MProcessDrillRule[] processDrillRules = MProcessDrillRule.getByElement_ID(m_ctx, element.getAD_Element_ID(), null);
			for( MProcessDrillRule drillProcesRule: processDrillRules) {
				MProcess process = MProcess.get(drillProcesRule.getAD_Process_ID());
				if(process == null)
					continue;

				drillProcessMap.put(drillProcesRule.getAD_Process_ID(), process.get_Translation(MProcess.COLUMNNAME_Name));

				ArrayList<KeyNamePair> drillProcessRuleList = drillProcessRuleMap.get(drillProcesRule.getAD_Process_ID());
				if(drillProcessRuleList == null) {
					drillProcessRuleList = new ArrayList<>();
					drillProcessRuleMap.put(drillProcesRule.getAD_Process_ID(), drillProcessRuleList);
				}
				drillProcessRuleList.add(new KeyNamePair(drillProcesRule.getAD_Process_DrillRule_ID(), drillProcesRule.getName()));
			}
		}

		ArrayList<KeyNamePair> drillProcessList = new ArrayList<>();
		for(Entry<Integer, String> drillProcessEntry :drillProcessMap.entrySet()) {
			drillProcessList.add(new KeyNamePair(drillProcessEntry.getKey(), drillProcessEntry.getValue()));
		}
		this.drillProcessList = drillProcessList.toArray(new KeyNamePair[drillProcessList.size()]);

		HashMap<Integer, KeyNamePair[]> drillProcessRuleMapOut = new HashMap<>();
		for(Entry<Integer, ArrayList<KeyNamePair>> drillProcessRuleEntry :drillProcessRuleMap.entrySet()) {
			drillProcessRuleMapOut.put(drillProcessRuleEntry.getKey(), drillProcessRuleEntry.getValue().toArray(new KeyNamePair[drillProcessRuleEntry.getValue().size()]));
		}

		this.drillProcesRules = drillProcessRuleMapOut;
	}

	/**
	 * Initialize Drill Table Map
	 */
	private void initDrillTableMap() {

		ArrayList<KeyNamePair> drillTableList = new ArrayList<>();
		String sql = "SELECT t.AD_Table_ID, t.TableName, t.Name, NULLIF(e.PO_PrintName,e.PrintName) " //et.PrintName
				+ "FROM AD_Column c "
				+ " INNER JOIN AD_Column used ON (c.ColumnName=used.ColumnName)"
				+ " INNER JOIN AD_Table t ON (used.AD_Table_ID=t.AD_Table_ID AND t.AD_Table_ID <> c.AD_Table_ID AND t.IsShowInDrillOptions='Y')"	//AND t.IsView='N'
				+ " INNER JOIN AD_Column cKey ON (t.AD_Table_ID=cKey.AD_Table_ID AND cKey.IsKey='Y')"
				+ " INNER JOIN AD_Element e ON (cKey.ColumnName=e.ColumnName) "
				+ "WHERE c.AD_Table_ID=? AND c.IsKey='Y' "
				+ "ORDER BY 3 ";
			boolean trl = !Env.isBaseLanguage(Env.getCtx(), "AD_Element");
			if (trl)
				sql = "SELECT t.AD_Table_ID, t.TableName, t.Name, NULLIF(et.PO_PrintName,et.PrintName) " //et.PrintName
					+ "FROM AD_Column c"
					+ " INNER JOIN AD_Column used ON (c.ColumnName=used.ColumnName)"
					+ " INNER JOIN AD_Table t ON (used.AD_Table_ID=t.AD_Table_ID AND t.AD_Table_ID <> c.AD_Table_ID AND t.IsShowInDrillOptions='Y')"	//AND t.IsView='N'
					+ " INNER JOIN AD_Column cKey ON (t.AD_Table_ID=cKey.AD_Table_ID AND cKey.IsKey='Y')"
					+ " INNER JOIN AD_Element e ON (cKey.ColumnName=e.ColumnName)"
					+ " INNER JOIN AD_Element_Trl et ON (e.AD_Element_ID=et.AD_Element_ID) "
					+ "WHERE c.AD_Table_ID=? AND c.IsKey='Y'"
					+ " AND et.AD_Language=? "
					+ "ORDER BY 3 ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_AD_Table_ID);
			if (trl)
				pstmt.setString(2, Env.getAD_Language(Env.getCtx()));
			rs = pstmt.executeQuery();
			while (rs.next())
			{

				int ad_Table_ID = rs.getInt(1);
				String name = rs.getString(3);
				String poName = rs.getString(4);
				if (poName != null)
					name += "/" + poName;
				drillTableList.add(new KeyNamePair(ad_Table_ID, name));
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		this.drillTables = drillTableList.toArray(new KeyNamePair[drillTableList.size()]);
	}

	/**
	 * Initialize Print Formats for Table Name
	 */
	private void initDrillTablePrintFormatMap() {

		int AD_Window_ID = Env.getContextAsInt(Env.getCtx(), this.m_WindowNo, "_WinInfo_AD_Window_ID", true);
		if (AD_Window_ID == 0)
			AD_Window_ID = Env.getZoomWindowID(m_Query);


		for( KeyNamePair drillTable : drillTables ) {
			//
			List<KeyNamePair> m_list = MPrintFormat.getAccessiblePrintFormats(drillTable.getKey(), AD_Window_ID, null, true);

			this.drillTablePrintFormatMap.put(drillTable.getKey(), m_list.toArray(new KeyNamePair[m_list.size()]));
		}
	}

	/**
	 * Initialize Print Formats for Table Name
	 */
	private void initDrillProcessRulePrintFormatMap() {

		int AD_Window_ID = Env.getContextAsInt(Env.getCtx(), this.m_WindowNo, "_WinInfo_AD_Window_ID", true);
		if (AD_Window_ID == 0)
			AD_Window_ID = Env.getZoomWindowID(m_Query);

		for( KeyNamePair[] drilProcessRuleList : drillProcesRules.values() ) {
			for( KeyNamePair drillProcessRule : drilProcessRuleList ) {
				//
				MProcessDrillRule processDrillRule = MProcessDrillRule.get(m_ctx, drillProcessRule.getKey());

				KeyNamePair[] m_list = null;

				if(processDrillRule.getAD_PrintFormat_ID() > 0) {
					// Print Format
					MPrintFormat pf = MPrintFormat.get(processDrillRule.getAD_PrintFormat_ID());
					if(pf != null) {
						m_list = new KeyNamePair[] {
//								new KeyNamePair(-1, Msg.getMsg(Env.getCtx(), pf.getAD_Client_ID() == 0 ? "PredefinedReports" : "ClientReports" )),
								new KeyNamePair(pf.getAD_PrintFormat_ID(), drillProcessRule.getName())};
					}
				} else if(processDrillRule.getAD_ReportView_ID() > 0) {
					// Report View
					MReportView reportView = MReportView.get(processDrillRule.getAD_ReportView_ID());
					m_list = getPrintFormats(reportView.getAD_Table_ID(), reportView.getAD_ReportView_ID());//MPrintFormat.getAccessiblePrintFormats(reportView.getAD_Table_ID(), AD_Window_ID, null, false);
				} else {
					MProcess process = MProcess.get(processDrillRule.getAD_Process_ID());
					if(process == null || process.getAD_ReportView_ID() <= 0)
						continue;
					MReportView reportView = MReportView.get(process.getAD_ReportView_ID());
					m_list = getPrintFormats(reportView.getAD_Table_ID(), reportView.getAD_ReportView_ID()); //MPrintFormat.getAccessiblePrintFormats(reportView.getAD_Table_ID(), AD_Window_ID, null, false);
				}

				this.drillProcessRulesPrintFormatMap.put(drillProcessRule.getKey(), m_list);
			}
		}
	}


	private KeyNamePair[] getPrintFormats(int table_ID, int reportView_ID) {
		ArrayList<KeyNamePair> printFormatList = new ArrayList<>();

		//	fill Report Options
		String sql = MRole.getDefault().addAccessSQL(
			"SELECT * "
				+ "FROM AD_PrintFormat "
				+ "WHERE AD_Table_ID=? "
				//Added Lines by Armen
				+ "AND IsActive='Y' "
				//End of Added Lines
				+ (reportView_ID > 0 ? "AND AD_ReportView_ID=? " : "")
				+ "ORDER BY AD_Client_ID, Name",
			"AD_PrintFormat", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean system = true;
		boolean client = true;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			int idx = 1;
			pstmt.setInt(idx++, table_ID);
			if (reportView_ID > 0)
				pstmt.setInt(idx++, reportView_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MPrintFormat printFormat = new MPrintFormat (Env.getCtx(), rs, null);
//				if(system && printFormat.getAD_Client_ID()==0){
//					printFormatList.add(new KeyNamePair(-1, Msg.getMsg(Env.getCtx(), "PredefinedReports")));
//					system = false;
//				}
//
//				if(client && printFormat.getAD_Client_ID()>0){
//					printFormatList.add(new KeyNamePair(-1, Msg.getMsg(Env.getCtx(), "ClientReports")));
//					client = false;
//				}

				KeyNamePair pp = new KeyNamePair(printFormat.get_ID(), printFormat.get_Translation(MPrintFormat.COLUMNNAME_Name, Env.getAD_Language(Env.getCtx()), true));
				printFormatList.add(pp);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return printFormatList.toArray(new  KeyNamePair[printFormatList.size()]);
	}

	/**
	 * 	Launch Report
	 * 	@param pf print format
	 */
	public void launchTableDrillReport (int ad_PrintFormat_ID)
	{
		MPrintFormat pf = MPrintFormat.get(ad_PrintFormat_ID);
		int Record_ID = 0;
		if (m_Query.getRestrictionCount() == 1) {
			if (m_Query.getColumnName(0).equals(m_Query.getTableName()+"_ID")) {
				Object vrec = m_Query.getCode(0);
				if (vrec instanceof Integer) {
					Record_ID = ((Integer)m_Query.getCode(0)).intValue();
				} else {
					try {
						Record_ID = Integer.parseInt(m_Query.getCode(0).toString());
					} catch (NumberFormatException e) {
						log.info(e.getMessage());
					}
				}
			}
		}
		PrintInfo info = new PrintInfo(
			pf.getName(),
			pf.getAD_Table_ID(),
			Record_ID);
		info.setDescription(m_Query.getInfo());

		if(pf != null && pf.getJasperProcess_ID() > 0)
		{
			// It's a report using the JasperReports engine
			ProcessInfo pi = new ProcessInfo ("", pf.getJasperProcess_ID(), pf.getAD_Table_ID(), Record_ID);

			//	Execute Process
//			WProcessCtl.process(m_WindowNo, pi, null);
		}
		else
		{
			// It's a default report using the standard printing engine
			ReportEngine re = new ReportEngine (Env.getCtx(), pf, m_Query, info);
			re.setWindowNo(m_WindowNo);
			ReportCtl.preview(re);
		}
	}	//	launchReport


	/**
	 * 	Launch Report Process
	 * 	@param pf print format
	 * @throws Exception
	 */
	public ProcessInfo getDrillProcessProcessInfo (int AD_Process_DrillRule_ID, int ad_PrintFormat_ID) throws Exception
	{
		MProcessDrillRule drillRule = MProcessDrillRule.get(m_ctx, AD_Process_DrillRule_ID);
		MProcess process = new MProcess(m_ctx, drillRule.getAD_Process_ID(), null);

		return prepareProcessInfo(process, drillRule, ad_PrintFormat_ID);

		// It's a default report using the standard printing engine
//		ReportEngine re = new ReportEngine (Env.getCtx(), pf, m_Query, info);
//		re.setWindowNo(m_WindowNo);
//		ReportCtl.preview(re);

	}	//	launchReport

	/**
	 * 	Run Process or Report
	 *	@param process process
	 *	@return summary
	 *	@throws Exception
	 */
	protected ProcessInfo prepareProcessInfo(MProcess process,MProcessDrillRule processDrillRule, int ad_PrintFormat_ID) throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info(process.toString());

		boolean isReport = (process.isReport() || process.getAD_ReportView_ID() > 0 || process.getJasperReport() != null || process.getAD_PrintFormat_ID() > 0);

		//	Process (see also MWFActivity.performWork
		int AD_Table_ID = processDrillRule.getAD_Table_ID();
		int Record_ID = 0; //drillRule.getRecord_ID();
		//
		MPInstance pInstance = new MPInstance(process, Record_ID);
		fillParameter(pInstance, processDrillRule);
		//
		ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID(), AD_Table_ID, Record_ID);
		pi.setAD_User_ID(Env.getAD_User_ID(m_ctx));
		pi.setAD_Client_ID(processDrillRule.getAD_Client_ID());
		pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());
		pi.setAD_Process_UU(process.getAD_Process_UU());
		pi.setIsBatch(true);
		pi.setPrintPreview(true);
//		pi.setReportType(drillRule.getReportOutputType());
		int AD_PrintFormat_ID = ad_PrintFormat_ID > 0 ? ad_PrintFormat_ID : processDrillRule.getAD_PrintFormat_ID();
		if (AD_PrintFormat_ID > 0)
		{
			MPrintFormat format = new MPrintFormat(Env.getCtx(), AD_PrintFormat_ID, null);
			pi.setSerializableObject(format);
		}

		Trx m_trx = null;
		pi.setTransactionName(m_trx != null ? m_trx.getTrxName() : null);
		if (!Util.isEmpty(process.getJasperReport()))
		{
			pi.setExport(true);
			if ("HTML".equals(pi.getReportType()))
				pi.setExportFileExtension("html");
			else if ("CSV".equals(pi.getReportType()))
				pi.setExportFileExtension("csv");
			else if ("XLS".equals(pi.getReportType()))
				pi.setExportFileExtension("xls");
			else if ("XLSX".equals(pi.getReportType()))
				pi.setExportFileExtension("xlsx");
			else
				pi.setExportFileExtension("pdf");
		}


		return pi;
	}	//	runProcess


	/**
	 * 	Fill Parameter
	 *	@param pInstance process instance
	 */
	protected void fillParameter(MPInstance pInstance, MProcessDrillRule processDrillRule)
	{
		boolean isKeyParameterSet= false;
		MProcessDrillRulePara[] sParams = processDrillRule.getParameters (false);
		MPInstancePara[] iParams = pInstance.getParameters();
		for (int pi = 0; pi < iParams.length; pi++)
		{
			MPInstancePara iPara = iParams[pi];

			if(iPara.getParameterName().equals(m_ColumnName))
			{
				iPara.setP_Number(Integer.valueOf((String) m_Value));
				iPara.setInfo(!Util.isEmpty(m_DisplayValue) ? m_DisplayValue : (String) m_Value);
				iPara.save();
				isKeyParameterSet = true;
				continue;
			}
			for (int np = 0; np < sParams.length; np++)
			{
				MProcessDrillRulePara sPara = sParams[np];
				if (iPara.getParameterName().equals(sPara.getColumnName()))
				{
					String paraDesc = sPara.getDescription();
					if (paraDesc != null && paraDesc.trim().length() > 0)
						iPara.setInfo(sPara.getDescription());
					String variable = sPara.getParameterDefault();
					String toVariable = sPara.getParameterToDefault();
					if (log.isLoggable(Level.FINE)) log.fine(sPara.getColumnName() + " = " + variable);
					//	Value - Constant/Variable
					Object value = parseVariable(sPara, variable);
					Object toValue = toVariable != null ? parseVariable(sPara, toVariable) : null;

					//	No Value
					if (value == null && toValue == null)
					{
						if (log.isLoggable(Level.FINE)) log.fine(sPara.getColumnName() + " - empty");
						break;
					}

					//	Convert to Type
					try
					{
						if (DisplayType.isNumeric(sPara.getDisplayType())
							|| DisplayType.isID(sPara.getDisplayType()))
						{
							DecimalFormat decimalFormat = DisplayType.getNumberFormat(sPara.getDisplayType());
							BigDecimal bd = toBigDecimal(value);
							iPara.setP_Number(bd);
							if (toValue != null)
							{
								bd = toBigDecimal(toValue);
								iPara.setP_Number_To(bd);
							}
							if (Util.isEmpty(paraDesc))
							{
								String info = decimalFormat.format(iPara.getP_Number());
								if (iPara.getP_Number_To() != null)
									info = info + " - " + decimalFormat.format(iPara.getP_Number_To());
								iPara.setInfo(info);
							}
							if (log.isLoggable(Level.FINE)) log.fine(sPara.getColumnName()
								+ " = " + variable + " (=" + bd + "=)");
						}
						else if (DisplayType.isDate(sPara.getDisplayType()))
						{
							SimpleDateFormat dateFormat = DisplayType.getDateFormat(sPara.getDisplayType());
							Timestamp ts = toTimestamp(value);
							iPara.setP_Date(ts);
							if (toValue != null) {
								ts = toTimestamp(toValue);
								iPara.setP_Date_To(ts);
							}
							if (Util.isEmpty(paraDesc))
							{
								String info = dateFormat.format(iPara.getP_Date());
								if (iPara.getP_Date_To() != null)
								{
									info = info + " - " + dateFormat.format(iPara.getP_Date_To());
								}
								iPara.setInfo(info);
							}
							if (log.isLoggable(Level.FINE)) log.fine(sPara.getColumnName()
								+ " = " + variable + " (=" + ts + "=)");
						}
						else
						{
							iPara.setP_String(value.toString());
							if (toValue != null)
							{
								iPara.setP_String_To(toValue.toString());
							}
							if (Util.isEmpty(paraDesc))
							{
								String info = iPara.getP_String();
								if (iPara.getP_String_To() != null)
								{
									info = info + " - " + iPara.getP_String_To();
								}
								iPara.setInfo(info);
							}
							if (log.isLoggable(Level.FINE)) log.fine(sPara.getColumnName()
								+ " = " + variable
								+ " (=" + value + "=) " + value.getClass().getName());
						}
						if (!iPara.save())
							log.warning("Not Saved - " + sPara.getColumnName());
					}
					catch (Exception e)
					{
						log.warning(sPara.getColumnName()
							+ " = " + variable + " (" + value
							+ ") " + value.getClass().getName()
							+ " - " + e.getLocalizedMessage());
					}
					break;
				}	//	parameter match
			}	//	scheduler parameter loop
		}	//	instance parameter loop

		if(!isKeyParameterSet) {
			throw new AdempiereException(Msg.parseTranslation(m_ctx, "@NoDrillKeyParameterSet@"));
		}
	}	//	fillParameter

	private Timestamp toTimestamp(Object value) {
		Timestamp ts = null;
		if (value instanceof Timestamp)
			ts = (Timestamp)value;
		else
			ts = Timestamp.valueOf(value.toString());
		return ts;
	}

	private BigDecimal toBigDecimal(Object value) {
		BigDecimal bd = null;
		if (value instanceof BigDecimal)
			bd = (BigDecimal)value;
		else if (value instanceof Integer)
			bd = new BigDecimal (((Integer)value).intValue());
		else
			bd = new BigDecimal (value.toString());
		return bd;
	}

	private Object parseVariable(MProcessDrillRulePara sPara, String variable) {
		Object value = variable;
		if (variable == null
			|| (variable != null && variable.length() == 0))
			value = null;
		else if (variable.startsWith("@SQL=")) {
			String	defStr = "";
			String sql = variable.substring(5);	//	w/o tag
			//sql = Env.parseContext(m_vo.ctx, m_vo.WindowNo, sql, false, true);	//	replace variables
			//hengsin, capture unparseable error to avoid subsequent sql exception
			sql = Env.parseContext(m_ctx, 0, sql, false, false);	//	replace variables
			if (sql.equals(""))
				log.log(Level.WARNING, "(" + sPara.getColumnName() + ") - Default SQL variable parse failed: " + variable);
			else {
				PreparedStatement stmt = null;
				ResultSet rs = null;
				try {
					stmt = DB.prepareStatement(sql, null);
					rs = stmt.executeQuery();
					if (rs.next())
						defStr = rs.getString(1);
					else {
						if (log.isLoggable(Level.INFO))
							log.log(Level.INFO, "(" + sPara.getColumnName() + ") - no Result: " + sql);
					}
				}
				catch (SQLException e) {
					log.log(Level.WARNING, "(" + sPara.getColumnName() + ") " + sql, e);
				}
				finally{
					DB.close(rs, stmt);
					rs = null;
					stmt = null;
				}
			}
			if (!Util.isEmpty(defStr))
				value = defStr;
		}	//	SQL Statement
		else if (  variable.indexOf('@') != -1
				&& variable.indexOf('@') != variable.lastIndexOf('@'))	//	we have a variable / BF [1926032]
		{
			//	Strip
			int index = variable.indexOf('@');
			String columnName = variable.substring(index+1);
			index = columnName.indexOf('@');
			if (index == -1)
			{
				log.warning(sPara.getColumnName()
					+ " - cannot evaluate=" + variable);
				return null;
			}
			String tail=index < (columnName.length()-1) ? columnName.substring(index+1) : null;
			columnName = columnName.substring(0, index);
			//	try Env
			String env = Env.getContext(m_ctx, columnName);
			if (env == null || env.length() == 0)
				env = Env.getContext(m_ctx, columnName);
			if (env.length() == 0)
			{
				log.warning(sPara.getColumnName()
					+ " - not in environment =" + columnName
					+ "(" + variable + ")");

				if(DisplayType.isDate(sPara.getDisplayType())) {
					return Env.getContext(m_ctx, "#Date");
				}
				return null;
			}
			else
				value = env;



			if (tail != null && columnName.equals("#Date"))
			{
				tail = tail.trim();
				if (tail.startsWith("-") || tail.startsWith("+"))
				{
					boolean negate = tail.startsWith("-");
					int type = Calendar.DATE;
					tail = tail.substring(1);
					if (tail.endsWith("d"))
					{
						tail = tail.substring(0, tail.length()-1);
					}
					else if (tail.endsWith("m"))
					{
						type = Calendar.MONTH;
						tail = tail.substring(0, tail.length()-1);
					}
					else if (tail.endsWith("y"))
					{
						type = Calendar.YEAR;
						tail = tail.substring(0, tail.length()-1);
					}

					int toApply = 0;
					try
					{
						toApply = Integer.parseInt(tail);
					} catch(Exception e){}
					if (toApply > 0)
					{
						if (negate) toApply = toApply * -1;
						Timestamp ts = toTimestamp(value);
						Calendar cal = Calendar.getInstance();
						cal.setTimeInMillis(ts.getTime());
						cal.add(type, toApply);
						value = new Timestamp(cal.getTimeInMillis());
					}
				}

			}
		}	//	@variable@
		return value;
	}

	public String getTableName() {
		return m_TableName;
	}


	public KeyNamePair[] getDrillProcessList() {
		return drillProcessList;
	}


	public HashMap<Integer, KeyNamePair[]> getDrillTablePrintFormatMap() {
		return drillTablePrintFormatMap;
	}


	public HashMap<Integer, KeyNamePair[]> getDrillProcessRulesPrintFormatMap() {
		return drillProcessRulesPrintFormatMap;
	}

}
