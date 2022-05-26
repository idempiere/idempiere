package org.adempiere.webui.apps;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DrillEvent.DrillData;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MProcessDrillRule;
import org.compiere.print.DrillReportCtl;
import org.compiere.print.MPrintFormat;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zhtml.A;
import org.zkoss.zhtml.H3;
import org.zkoss.zhtml.H4;
import org.zkoss.zhtml.I;
import org.zkoss.zhtml.P;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Text;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlNativeComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;

/**
 *
 * @author Igor Pojzl, Cloudempiere
 *
 */
public class WDrillReport extends Window implements EventListener<Event>  {

	/**
	 *
	 */
	private static final long serialVersionUID = 5143424676962140799L;

	private static final String DRILL_REPORT_PRINTFORMAT_ID_NAME = "AD_PrintFormat_ID";

	private static final String DRILL_PROCESS_RULE_ID_NAME = "AD_Process_DrillRule_ID";

	DrillReportCtl drillReportCtl;
	private String winpref;
	private Component parent;

	private int windowNo = 0;

	public WDrillReport(DrillData data, Component parent, int WindowNo) {
		super();
		this.parent = parent;
		this.windowNo = WindowNo;
		drillReportCtl = new DrillReportCtl(Env.getCtx(), data.getQuery().getTableName(), data.getQuery(), data.getColumnName(), data.getValue(), data.getDisplayValue(), WindowNo);

		this.setTitle(Msg.getMsg(Env.getCtx(), "DrillAssistant"));
		this.setClosable(true);
		ZKUpdateUtil.setWidth(this, "60%");
		ZKUpdateUtil.setHeight(this, "70%");
		this.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
		this.setSclass("help-window");

		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "1");

		Center centerPane = new Center();
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);

		Div div = new Div();
		centerPane.appendChild(div);
		div.setStyle("width: 100%; height: 100%; overflow: auto;");
		Table table = new Table();
		table.setStyle("width: 100%;");
		div.appendChild(table);


//		WebDoc doc = WebDoc.create(true);
		table.setWidgetAttribute("cellspacing", "0");
		table.setWidgetAttribute("cellpadding", "0");
		table.setWidgetAttribute("border", "0");
//		doc.getBody().addElement(table);

		Tr tr = new Tr();
		table.appendChild(tr);

		Td td = new Td();
		tr.appendChild(td);
		td.appendChild(getHeader());

		tr = new Tr();
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
		td.appendChild(getContent());

//		html.setContent(doc.toString());

//		this.addEventListener(DrillEvent.ON_DRILL_REPORT, new EventListener<Event>() {
//
//			public void onEvent(Event event) throws Exception {
//				if (event instanceof DrillEvent) {
//					Clients.clearBusy();
//					DrillEvent de = (DrillEvent) event;
//				}
//
//			}
//		});

	}

	private Table getHeader()
	{
		Table table = new Table();
		table.setWidgetAttribute("cellspacing", "0");
		table.setWidgetAttribute("cellpadding", "0");
		table.setWidgetAttribute("border", "0");
		table.setStyle("width: 100%;");
		table.setWidgetAttribute("class","help-window-header");

		Tr tr = new Tr();
		table.appendChild(tr);

		Td td = new Td();
		td.setWidgetAttribute("class","help-window-title");
		tr.appendChild(td);
		// generate a unique win prefix id for this help window
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("ddHHmmss");
		String dt = sdf.format(cal.getTime());
		winpref = "Win"+dt;
		A a = new A();
		a.setWidgetAttribute("name", winpref);
		td.appendChild(a);
		StringBuilder title = new StringBuilder(Msg.getMsg(Env.getCtx(), "DrillColumn")).append(": ").append(drillReportCtl.getTableName())
				.append(" - ").append(!Util.isEmpty(drillReportCtl.getDisplayValue()) ? drillReportCtl.getDisplayValue() : drillReportCtl.getValue());
		H3 h3 = new H3();
		h3.appendChild(new Text(title.toString()));
		td.appendChild(h3);


		tr = new Tr();
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
//		td.appendChild(WebDoc.NBSP);

//		if (gridWindow.getDescription().length() != 0)
//		{
//			tr = new tr();
//			table.addElement(tr);
//
//			td = new td();
//			td.setClass("help-window-description");
//			tr.addElement(td);
//			td.addElement(new p().addElement(gridWindow.getDescription()));
//
//			tr = new tr();
//			table.addElement(tr);
//
//			td = new td();
//			tr.addElement(td);
//			td.addElement(WebDoc.NBSP);
//		}

//		if (gridWindow.getHelp().length() != 0)
//		{
//			tr = new tr();
//			table.addElement(tr);
//
//			td = new td();
//			td.setClass("help-window-help");
//			tr.addElement(td);
//			td.addElement(new p().addElement(gridWindow.getHelp()));
//
//			tr = new tr();
//			table.addElement(tr);
//
//			td = new td();
//			tr.addElement(td);
//			td.addElement(WebDoc.NBSP);
//		}

		tr = new Tr();
		table.appendChild(tr);

		td = new Td();
		tr.setWidgetAttribute("class","help-window-tabs");
		tr.appendChild(td);

		tr = new Tr();
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
//		td.appendChild(WebDoc.NBSP);

		return table;
	}

	private Tabbox getContent()
	{

		Tabbox tabbox = new Tabbox();
		Tabs tabs = new Tabs();
		tabbox.appendChild(tabs);
		Tabpanels tabpanels = new Tabpanels();
		tabbox.appendChild(tabpanels);

		Tab tab = new Tab(Msg.translate(Env.getCtx(), "AD_Process_DrillRule_ID"));
		tabs.appendChild(tab);
		tab = new Tab(Msg.translate(Env.getCtx(), "AD_Table_ID"));
		tabs.appendChild(tab);
//		tab = new Tab(Msg.translate(Env.getCtx(), "Favorites"));
//		tabs.appendChild(tab);

		Tabpanel tabPanel = new Tabpanel();
		tabPanel.appendChild(getTabContent(1, drillReportCtl.getDrillProcessList(), drillReportCtl.getDrillProcesRules(), true));
		tabpanels.appendChild(tabPanel);

		tabPanel = new Tabpanel();
		tabPanel.appendChild(getTabContent(2, drillReportCtl.getDrillTables(), drillReportCtl.getDrillTablePrintFormatMap(), false));
		tabpanels.appendChild(tabPanel);

//		Table table = new Table();
//		table.setWidgetAttribute("cellspacing", "0");
//		table.setWidgetAttribute("cellpadding", "0");
//		table.setWidgetAttribute("border", "0");
//		table.setStyle("width: 100%;");
//		table.setWidgetAttribute("class","help-window-content");
//
//		Tr tr = new Tr();
////		tr.setVAlign("top");
//		table.appendChild(tr);
//
//		Td td = new Td();
////		td.setWidth("80%");
//		tr.appendChild(td);
//		td.appendChild(getTabContent(1, drillReportCtl.getDrillTables(), drillReportCtl.getDrillTablePrintFormatMap()));
//		tabPanel.appendChild(table);

		return tabbox;
	}

	private Table getLeftContent()
	{
		Table table = new Table();
		table.setWidgetAttribute("cellspacing", "0");
		table.setWidgetAttribute("cellpadding", "0");
		table.setWidgetAttribute("border", "0");
		table.setStyle("width: 100%;");
		table.setWidgetAttribute("class","help-window-content-l");

//		int size = gridWindow.getTabCount();
//		for (int i = 0; i < size; i++)
//		{
//			tr tr = new tr();
//			table.addElement(tr);
//
//			td td = new td();
//			tr.addElement(td);
//
//			GridTab tab = gridWindow.getTab(i);
//			td.addElement(new a("#"+winpref+"Rep"+i).addElement(tab.getName()));
//		}

		return table;
	}

	private Table getTabContent(int tabIndex, KeyNamePair[] drillTables, HashMap<Integer, KeyNamePair[]> drillPrintFormatMap, boolean isDrillProcessRule)
	{
		Table table = new Table();
		table.setWidgetAttribute("cellspacing", "0");
		table.setWidgetAttribute("cellpadding", "0");
		table.setWidgetAttribute("border", "0");
		table.setStyle("width: 100%;");
		table.setWidgetAttribute("class","help-window-content-r");

		// tab
		Tr tr = new Tr();
		table.appendChild(tr);

		Td td = new Td();
		tr.appendChild(td);
		A a = new A();
		a.setWidgetAttribute("name",winpref+"Tables");
		td.appendChild(a);
//		H4 h4 = new H4();
//		h4.appendChild(new Text(Msg.getMsg(Env.getCtx(), "Tables")));
//		td.appendChild(h4);
		td.appendChild(getTablesBox(tabIndex, drillTables));

		int size = drillTables.length;
		for (int i = 0; i < size; i++)
		{
			KeyNamePair drillTable = drillTables[i];

			// tab
			tr = new Tr();
			table.appendChild(tr);

			td = new Td();
			tr.appendChild(td);
			td.appendChild(getDrillTableBox(drillTable, i, tabIndex, drillPrintFormatMap, isDrillProcessRule));

			// fields
//			tr = new Tr();
//			table.appendChild(tr);
//
//			td = new Td();
//			tr.appendChild(td);
//			td.appendChild(getPrintFormatsBox(drillPrintFormats, i, tabIndex));

		}

		return table;
	}


//	private Table getRightContent()
//	{
//		Table table = new Table();
//		table.setWidgetAttribute("cellspacing", "0");
//		table.setWidgetAttribute("cellpadding", "0");
//		table.setWidgetAttribute("border", "0");
//		table.setStyle("width: 100%;");
//		table.setWidgetAttribute("class","help-window-content-r");
//
//		int size = drillReportCtl.getDrillTables().length;
//		for (int i = 0; i < size; i++)
//		{
//			KeyNamePair drillTable = drillReportCtl.getDrillTables()[i];
//
//			// tab
//			Tr tr = new Tr();
//			table.appendChild(tr);
//
//			Td td = new Td();
//			tr.appendChild(td);
//			td.appendChild(getDrillTableBox(drillTable, i, 1));
//
//			// fields
//			tr = new Tr();
//			table.appendChild(tr);
//
//			td = new Td();
//			tr.appendChild(td);
//			KeyNamePair[] drillPrintFormats = drillReportCtl.getDrillTablePrintFormat(drillTable.getKey());
//			td.appendChild(getPrintFormatsBox(drillPrintFormats, i, 1));
//
//			for (int j = 0; j < drillPrintFormats.length; j++)
//			{
//				KeyNamePair drillPrintFormat = drillPrintFormats[j];
////				if (!field.isDisplayed(false)) {
////					continue;
////				}
//
//				String hdr = drillPrintFormat.getName();
//				if (hdr != null && hdr.length() > 0)
//				{
//					// field
//					tr = new Tr();
//					table.appendChild(tr);
//
//					td = new Td();
//					tr.appendChild(td);
//					td.appendChild(getPrintFormatBox(drillPrintFormat, i, j, 1));
//				}
//			}
//		}
//
//		// Drill Rules
//		size = drillReportCtl.getDrillProcesRules().length;
//		for (int i = 0; i < size; i++)
//		{
//			KeyNamePair drillProcessRule = drillReportCtl.getDrillProcesRules()[i];
//
//			// tab
//			Tr tr = new Tr();
//			table.appendChild(tr);
//
//			Td td = new Td();
//			tr.appendChild(td);
//			td.appendChild(getDrillTableBox(drillProcessRule, i, 2));
//
//			// fields
//			tr = new Tr();
//			table.appendChild(tr);
//
//			td = new Td();
//			tr.appendChild(td);
//			KeyNamePair[] drillProcessPrintFormats = drillReportCtl.getDrillProcessRulesPrintFormatMap(drillProcessRule.getKey());
//			td.appendChild(getPrintFormatsBox(drillProcessPrintFormats, i, 2));
//
//			for (int j = 0; j < drillProcessPrintFormats.length; j++)
//			{
//				KeyNamePair drillPrintFormat = drillProcessPrintFormats[j];
////				if (!field.isDisplayed(false)) {
////					continue;
////				}
//
//				String hdr = drillPrintFormat.getName();
//				if (hdr != null && hdr.length() > 0)
//				{
//					// field
//					tr = new Tr();
//					table.appendChild(tr);
//
//					td = new Td();
//					tr.appendChild(td);
//					td.appendChild(getPrintFormatBox(drillPrintFormat, i, j, 2, drillProcessRule));
//				}
//			}
//		}
//
//		return table;
//	}

	private Table getDrillTableBox(KeyNamePair drillTable, int tabIndex, int groupIndex, HashMap<Integer, KeyNamePair[]> drillPrintFormatMap, boolean isDrillProcessRule)
	{
		Table table = new Table();
		table.setWidgetAttribute("cellspacing", "0");
		table.setWidgetAttribute("cellpadding", "0");
		table.setWidgetAttribute("border", "0");
		table.setStyle("width: 100%; margin-top: 25px;");
		table.setWidgetAttribute("class","drill-window-tab");

		Tr tr = new Tr();
		tr.setWidgetAttribute("class", "help-window-tab-header");
		table.appendChild(tr);

		Td td = new Td();
		td.setWidgetAttribute("class","help-window-tab-name");

		td.setColspan(4);
		tr.appendChild(td);
		A a = new A();
		a.setWidgetAttribute("name",winpref+"Rep" + tabIndex+"-"+groupIndex);
		td.appendChild(a);
		Div header = new Div();
		header.setStyle("padding: 10px 0px 10px 0px");
		HtmlNativeComponent h3 = new HtmlNativeComponent("h3", drillTable.getName(), "");
		header.appendChild(h3);
		td.appendChild(header);

		a = new A();
		a.setWidgetAttribute("title", "Up one level");
		a.setHref("#"+winpref);
		a.appendChild(new Text(".."));
		header.appendChild(a);

		KeyNamePair[] drillPrintFormats = drillPrintFormatMap.get(drillTable.getKey());
		for (int j = 0; j < drillPrintFormats.length; j++)
		{
			KeyNamePair drillPrintFormat = drillPrintFormats[j];

			KeyNamePair[] printFormats = isDrillProcessRule ? drillReportCtl.getDrillProcessRulesPrintFormatMap(drillPrintFormat.getKey()) : new KeyNamePair[] {drillPrintFormat} ;

			for(KeyNamePair printFormat: printFormats) {
				String hdr = printFormat.getName();
				if (hdr != null && hdr.length() > 0)
				{
					// field
					if (printFormat.getKey() <= 0) {
						table.appendChild(getPrintFormatHeader(printFormat, isDrillProcessRule? drillPrintFormat : null));

					} else {
						table.appendChild(getPrintFormatBox(printFormat, tabIndex, j, tabIndex, isDrillProcessRule? drillPrintFormat : null, printFormats.length == 1));
					}
				}
			}
		}

		return table;
	}



	private Table getTablesBox(int tabIndex, KeyNamePair[] drillTables)
	{
		Table table = new Table();
		table.setWidgetAttribute("cellspacing", "0");
		table.setWidgetAttribute("cellpadding", "0");
		table.setWidgetAttribute("border", "0");
		table.setStyle("width: 100%;");
		table.setWidgetAttribute("class","help-window-fields");

		Tr tr = new Tr();
		table.appendChild(tr);

		Td td = new Td();
		tr.appendChild(td);
//		td.appendChild(WebDoc.NBSP);

		tr = new Tr();
		tr.setWidgetAttribute("class","help-window-Formats-link");
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
		P p = new P();
		td.appendChild(p);

//		if (!tab.isLoadComplete())
//			gridWindow.initTab(tabIndex);
		for (int j = 0; j < drillTables.length; j++)
		{
			KeyNamePair printFormat = drillTables[j];
			String hdr = printFormat.getName();
			if (hdr != null && hdr.length() > 0)
			{
				if (j > 0)
					p.appendChild(new Text(" "));
				A a = new A();
				a.setHref("#"+winpref+"Rep" + j+"-" + tabIndex);
				a.appendChild(new Text(hdr));
				p.appendChild(a);
				if((j+1) < drillTables.length)
					p.appendChild(new Text(" , "));
			}
		}

		tr = new Tr();
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
//		td.appendChild(WebDoc.NBSP);

		return table;
	}

	private Table getPrintFormatsBox(KeyNamePair[] drillPrintFormats, int tabIndex, int groupIndex)
	{
		Table table = new Table();
		table.setWidgetAttribute("cellspacing", "0");
		table.setWidgetAttribute("cellpadding", "0");
		table.setWidgetAttribute("border", "0");
		table.setStyle("width: 100%;");
		table.setWidgetAttribute("class","help-window-fields");

		Tr tr = new Tr();
		table.appendChild(tr);

		Td td = new Td();
		tr.appendChild(td);
		A a = new A();
		a.setWidgetAttribute("name",winpref+"Formats"+tabIndex+"-"+groupIndex);
		td.appendChild(a);
		H4 h4 = new H4();
		h4.appendChild(new Text(Msg.getMsg(Env.getCtx(), "Formats")));
		td.appendChild(h4);

		tr = new Tr();
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
//		td.appendChild(WebDoc.NBSP);

		tr = new Tr();
		tr.setWidgetAttribute("class","help-window-Formats-link");
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
		P p = new P();
		td.appendChild(p);

//		if (!tab.isLoadComplete())
//			gridWindow.initTab(tabIndex);
		for (int j = 0; j < drillPrintFormats.length; j++)
		{
			KeyNamePair printFormat = drillPrintFormats[j];
			String hdr = printFormat.getName();
			if (hdr != null && hdr.length() > 0)
			{
//				if (j > 0)
//					p.appendChild(WebDoc.NBSP);
				a = new A();
				a.setHref("#"+winpref+"Format" + tabIndex + "-" + j +"-"+groupIndex);
				a.appendChild(new Text(hdr));
				p.appendChild(a);
				p.appendChild(new Text("  "));
			}
		}

		tr = new Tr();
		table.appendChild(tr);

		td = new Td();
		tr.appendChild(td);
//		td.appendChild(WebDoc.NBSP);

		return table;
	}

	private Tr getPrintFormatHeader(KeyNamePair drillPrintFormat, KeyNamePair drillProcessRule) {
		Tr tr = new Tr();
		tr.setWidgetAttribute("class", "drill-window-field-header");

		Td td = new Td();
		td.setStyle("width: 100%; border-bottom: 1px solid gray;");
		td.setColspan(3);
		tr.appendChild(td);
		H4 h4 = new H4();
		h4.appendChild(new Text(drillProcessRule != null ? drillProcessRule.getName(): drillPrintFormat.getName()));

		td.appendChild(h4);
//		if(drillProcessRule != null) {
//			I italic = new I();
//			italic.appendChild(new Text(" ["+ drillPrintFormat.getName() + "]"));
//			td.appendChild(italic);
//		}
		return tr;
	}

	private Tr getPrintFormatBox(KeyNamePair drillPrintFormat, int tabIndex, int fieldIndex, int groupIndex)
	{
		return getPrintFormatBox(drillPrintFormat, tabIndex, fieldIndex, groupIndex, null, false);
	}

	private Tr getPrintFormatBox(KeyNamePair drillPrintFormat, int reportIndex, int formatIndex, int groupIndex, KeyNamePair drillTable, boolean isSinglePrintFormat)
	{

		Tr tr = new Tr();
		tr.setWidgetAttribute("class", "drill-window-field-name");

		Td td = new Td();
		td.setStyle("width: 30%");
		tr.appendChild(td);
		A a = new A();
		a.setWidgetAttribute("name",winpref+"Format" + reportIndex + "-" + formatIndex + "-" + groupIndex);
		td.appendChild(a);
		H4 h4 = new H4();
		h4.appendChild(new Text(drillPrintFormat.getName()));


		td.appendChild(h4);
		a = new A();
		a.setHref("#"+winpref+"Rep"+reportIndex+"-"+groupIndex);
		a.setWidgetAttribute("title", "Up one level");
		a.appendChild(new Text(".."));
		td.appendChild(a);



		td = new Td();
		td.setStyle("width: 10%");
		tr.appendChild(td);

		a = new A();
		a.setWidgetAttribute("title", "Run Report");
		a.setHref("#");
		a.appendChild(new Text("[" + Msg.getMsg(Env.getCtx(), "Run") + "]"));
		a.addEventListener(Events.ON_CLICK, this);
		a.setAttribute(DRILL_REPORT_PRINTFORMAT_ID_NAME, drillPrintFormat.getKey());

		if(drillTable != null)
			a.setAttribute(DRILL_PROCESS_RULE_ID_NAME, drillTable.getKey());

		td.appendChild(a);

//		Button button = new Button();
//		if (ThemeManager.isUseFontIconForImage())
//			button.setIconSclass("z-icon-Report");
//		else
//			button.setImage(ThemeManager.getThemeResource("images/mReport.png"));
//		button.setSclass("img-btn");
//		button.addEventListener(Events.ON_CLICK, this);
//		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "RunReport")));
//		button.setAttribute(DRILL_REPORT_PRINTFORMAT_ID_NAME, drillPrintFormat.getKey());
//
//		if(drillTable != null)
//			button.setAttribute(DRILL_PROCESS_RULE_ID_NAME, drillTable.getKey());

//		td = new Td();
//		td.appendChild(button);
//		tr.appendChild(td);

//		tr = new Tr();
//		table.appendChild(tr);

//		td = new Td();
//		tr.appendChild(td);
//		td.appendChild(WebDoc.NBSP);

//		tr = new Tr();
//		tr.setWidgetAttribute("class","help-window-field-description");
//		table.appendChild(tr);


		String description = "";

		if(drillTable != null && isSinglePrintFormat) {
			MProcessDrillRule dr = MProcessDrillRule.get(Env.getCtx(), drillTable.getKey());
			if(dr != null) {
				if (!Util.isEmpty(dr.getDescription()))
					description = dr.getDescription();
			}
		}

		if(Util.isEmpty(description)) {
			MPrintFormat pf = MPrintFormat.get(drillPrintFormat.getKey());
			if(pf != null) {
				if (!Util.isEmpty(pf.getDescription()))
					description = pf.getDescription();
			}
		}


		td = new Td();
		td.setStyle("width: 60");
		tr.appendChild(td);
		td.appendChild(new Text(description));

		return tr;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getAttribute(DRILL_REPORT_PRINTFORMAT_ID_NAME) != null) {
			if(event.getTarget().getAttribute(DRILL_PROCESS_RULE_ID_NAME) != null) {
				ProcessInfo pi = drillReportCtl.getDrillProcessProcessInfo((int) event.getTarget().getAttribute(DRILL_PROCESS_RULE_ID_NAME), (int) event.getTarget().getAttribute(DRILL_REPORT_PRINTFORMAT_ID_NAME));
				WProcessCtl process = new WProcessCtl(null, windowNo, pi, null);
				process.run();
				this.onClose();
			} else {
				drillReportCtl.launchTableDrillReport((int) event.getTarget().getAttribute(DRILL_REPORT_PRINTFORMAT_ID_NAME));
				this.onClose();
			}

			return;
		}
		//super.onEvent(event);
	}

}
