/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
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
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MQuery;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Vbox;

/**
 * Search Invoice and return selection
 * Based on InfoInvoice by Jorg Janke
 * @author Sendy Yagambrum
 * @date July 30, 2007
 *
 * Zk Port
 * @author Elaine
 * @version	InfoInvoice.java Adempiere Swing UI 3.4.1
 **/

@Deprecated // replaced with InfoInvoiceWindow IDEMPIERE-325
public class InfoInvoicePanel extends InfoPanel implements ValueChangeListener
{
    /**
	 *
	 */
	private static final long serialVersionUID = 5632526399922930978L;

	/**
     * Detail protected constructor
     * @param WindowNo window no
     * @param value query value
     * @param multiSelection multiple selection
     * @param whereClause where clause
    *
     */
    public InfoInvoicePanel(int WindowNo, String value,
            boolean multiSelection, String whereClause)
    {
    	this(WindowNo, value, multiSelection, whereClause, true);
    }

	/**
     * Detail protected constructor
     * @param WindowNo window no
     * @param value query value
     * @param multiSelection multiple selection
     * @param whereClause where clause
    *
     */
    public InfoInvoicePanel(int WindowNo, String value,
            boolean multiSelection, String whereClause, boolean lookup)
    {
        super ( WindowNo, "i", "C_Invoice_ID", multiSelection, whereClause, lookup);

        setTitle(Msg.getMsg(Env.getCtx(), "InfoInvoice"));
        //
        initComponents();
        init();

       p_loadedOK = initInfo ();
       int no = contentPanel.getRowCount();
       setStatusLine(Integer.toString(no) + " " + Msg.getMsg(Env.getCtx(), "SearchRows_EnterQuery"), false);
       setStatusDB(Integer.toString(no));
       if (value != null && value.length() > 0)
       {
           String values[] = value.split("_");
           txtDocumentNo.setText(values[0]);
           executeQuery();
           renderItems();
       }
    }

    private Label lblDocumentNo;
    private Label lblDescription;
    private Label lblDateInvoiced;
    private Label lblGrandTotal;

    private Textbox txtDocumentNo;
    private Textbox txtDescription;

    private Datebox dateFrom;
    private Datebox dateTo;

    private NumberBox amountFrom;
    private NumberBox amountTo;

    private WSearchEditor editorBPartner;
    private WSearchEditor editorOrder;

    private Checkbox isSoTrx;
    private Checkbox isPaid;
	private Borderlayout layout;
	private Vbox southBody;

    /**  Array of Column Info    */
    private static final ColumnInfo[] s_invoiceLayout = {
        new ColumnInfo(" ", "i.C_Invoice_ID", IDColumn.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "C_BPartner_ID"), "(SELECT Name FROM C_BPartner bp WHERE bp.C_BPartner_ID=i.C_BPartner_ID)", String.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "DateInvoiced"), "i.DateInvoiced", Timestamp.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "DueDate"), "i.DueDate", Timestamp.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "DocumentNo"), "i.DocumentNo", String.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "C_Currency_ID"), "(SELECT ISO_Code FROM C_Currency c WHERE c.C_Currency_ID=i.C_Currency_ID)", String.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "GrandTotal"), "i.GrandTotal",  BigDecimal.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "ConvertedAmount"), "currencyBase(i.GrandTotal, i.C_Currency_ID, i.DateAcct, i.AD_Client_ID, i.AD_Org_ID)", BigDecimal.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "OpenAmt"), "invoiceOpen(C_Invoice_ID,C_InvoicePaySchedule_ID)", BigDecimal.class, true, true, null),
        new ColumnInfo(Msg.translate(Env.getCtx(), "IsPaid"), "i.IsPaid", Boolean.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "IsSOTrx"), "i.IsSOTrx", Boolean.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "Description"), "i.Description", String.class),
        new ColumnInfo(Msg.translate(Env.getCtx(), "POReference"), "i.POReference", String.class),
        new ColumnInfo("", "''", KeyNamePair.class, "i.C_InvoicePaySchedule_ID")
    };

    private static int INDEX_PAYSCHEDULE = s_invoiceLayout.length - 1;  //  last item

    private void initComponents()
    {
        lblDocumentNo = new Label(Util.cleanAmp(Msg.translate(Env.getCtx(), "DocumentNo")));
        lblDescription = new Label(Msg.translate(Env.getCtx(), "Description"));
        lblDateInvoiced = new Label(Msg.translate(Env.getCtx(), "DateInvoiced"));
        lblGrandTotal = new Label(Msg.translate(Env.getCtx(), "GrandTotal"));

        txtDocumentNo = new Textbox();
        txtDescription = new Textbox();
        
        txtDocumentNo.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "documentNo");
        txtDescription.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "description");

        dateFrom = new Datebox();
        dateTo= new Datebox();
        
        dateFrom.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "dateFrom");
        dateTo.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "dateTo");

        amountFrom = new NumberBox(false);
        amountTo = new NumberBox(false);
        
        amountFrom.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "amountFrom");
        amountTo.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "amountTo");

        isPaid = new Checkbox();
        isPaid.setLabel(Msg.translate(Env.getCtx(), "IsPaid"));
        isPaid.setChecked(false);
        isSoTrx = new Checkbox();
        isSoTrx.setLabel(Msg.translate(Env.getCtx(), "IsSOTrx"));
        isSoTrx.setChecked(!"N".equals(Env.getContext(Env.getCtx(), p_WindowNo, "IsSOTrx")));
        MLookup lookupBP = MLookupFactory.get(Env.getCtx(), p_WindowNo,
                0, 3499, DisplayType.Search);
        editorBPartner = new WSearchEditor(lookupBP, Msg.translate(
                Env.getCtx(), "C_BPartner_ID"), "", false, false, true);
        editorBPartner.addValueChangeListener(this);
        ZKUpdateUtil.setHflex(editorBPartner.getComponent(), "1");
        editorBPartner.getComponent().setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "bpartnerLookup");

        MLookup lookupOrder = MLookupFactory.get(Env.getCtx(), p_WindowNo,
                0, 4247, DisplayType.Search);
        editorOrder = new WSearchEditor(lookupOrder, Msg.translate(
                Env.getCtx(), "C_Order_ID"), "", false, false, true);
        editorOrder.addValueChangeListener(this);
        ZKUpdateUtil.setHflex(editorOrder.getComponent(), "1");
        editorOrder.getComponent().setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "orderLookup");
    }

    private void init()
    {
    	ZKUpdateUtil.setHflex(txtDocumentNo, "1");
    	ZKUpdateUtil.setHflex(txtDescription, "1");
    	ZKUpdateUtil.setWidth(dateFrom, "165px");
    	ZKUpdateUtil.setWidth(dateTo, "165px");
		ZKUpdateUtil.setWidth(amountFrom.getDecimalbox(), "155px");
		ZKUpdateUtil.setWidth(amountTo.getDecimalbox(), "155px");

        Grid grid = GridFactory.newGridLayout();

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblDocumentNo.rightAlign());
		row.appendChild(txtDocumentNo);
		row.appendChild(editorBPartner.getLabel().rightAlign());
		row.appendChild(editorBPartner.getComponent());
		row.appendChild(isSoTrx);
		row.appendChild(isPaid);

		row = new Row();
		row.appendCellChild(lblDescription.rightAlign(), 1);
		row.appendCellChild(txtDescription, 1);
		row.appendCellChild(lblDateInvoiced.rightAlign(), 1);
		Hbox hbox = new Hbox();
		hbox.appendChild(dateFrom);
		hbox.appendChild(new Label("-"));
		hbox.appendChild(dateTo);
		row.appendCellChild(hbox, 3);
		rows.appendChild(row);

		row = new Row();
		row.appendCellChild(editorOrder.getLabel().rightAlign(), 1);
		row.appendCellChild(editorOrder.getComponent(), 1);
		row.appendCellChild(lblGrandTotal.rightAlign(), 1);
		hbox = new Hbox();
		hbox.appendChild(amountFrom);
		hbox.appendChild(new Label("-"));
		hbox.appendChild(amountTo);
		row.appendCellChild(hbox, 3);
		rows.appendChild(row);

		layout = new Borderlayout();
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
        if (!isLookup())
        {
        	layout.setStyle("position: absolute");
        }
        this.appendChild(layout);

        North north = new North();
        layout.appendChild(north);
		north.appendChild(grid);

        Center center = new Center();
		layout.appendChild(center);
		Div div = new Div();
		div.appendChild(contentPanel);
		if (isLookup())
			ZKUpdateUtil.setWidth(contentPanel, "99%");
        else
        	contentPanel.setStyle("width: 99%; margin: 0px auto;");
        ZKUpdateUtil.setVflex(contentPanel, true);
		div.setStyle("width :100%; height: 100%");
		center.appendChild(div);
		ZKUpdateUtil.setVflex(div, "1");
		ZKUpdateUtil.setHflex(div, "1");

		South south = new South();
		layout.appendChild(south);
		southBody = new Vbox();
		ZKUpdateUtil.setWidth(southBody, "100%");
		south.appendChild(southBody);
		southBody.appendChild(new Separator());
		southBody.appendChild(confirmPanel);		
		southBody.appendChild(statusBar);
    }

    /**
     *  General Init
     *  @return true, if success
     */
    private boolean initInfo ()
    {
        //  Set Defaults
        String bp = Env.getContext(Env.getCtx(), p_WindowNo, "C_BPartner_ID");
        if (bp != null && bp.length() != 0)
            editorBPartner.setValue(Integer.valueOf(bp));

        //  prepare table
        StringBuilder where = new StringBuilder("i.IsActive='Y'");
        if (p_whereClause.length() > 0)
            where.append(" AND ").append(Util.replace(p_whereClause, "C_Invoice.", "i."));
        prepareTable(s_invoiceLayout,
            " C_Invoice_v i",   //  corrected for CM
            where.toString(),
        	"2,3,4,5");
        //
        return true;

    }   //  initInfo
    @Override
    public String getSQLWhere()
    {
        StringBuilder sql = new StringBuilder();
        if (txtDocumentNo.getText().length() > 0)
            sql.append(" AND UPPER(i.DocumentNo) LIKE ?");
        if (txtDescription.getText().length() > 0)
            sql.append(" AND UPPER(i.Description) LIKE ?");
        //
        if (editorBPartner.getValue() != null)
            sql.append(" AND i.C_BPartner_ID=?");
        //
        if (editorOrder.getValue() != null)
            sql.append(" AND i.C_Order_ID=?");
        Date fromDate = null;
        Date toDate = null;
        try
        {
            fromDate = dateFrom.getValue();
        }
        catch (WrongValueException e)
        {

        }
        try
        {
            toDate = dateTo.getValue();
        }
        catch (WrongValueException e)
        {

        }
        if (fromDate == null && toDate != null)
        {
            sql.append(" AND TRUNC(i.DateInvoiced) <= ?");
        }
        else if (fromDate != null && toDate == null)
        {
            sql.append(" AND TRUNC(i.DateInvoiced) >= ?");
        }
        else if (fromDate != null && toDate != null)
        {
                sql.append(" AND TRUNC(i.DateInvoiced) BETWEEN ? AND ?");
        }
        //
        Double fromAmount = null;
        Double toAmount = null;
        if (!Util.isEmpty(amountFrom.getText()))
        {
            try
            {
                fromAmount = Double.parseDouble(amountFrom.getText());
            }
            catch (NumberFormatException e)
            {

            }
        }
        if (!Util.isEmpty(amountTo.getText()))
        {
            try
            {
                toAmount = Double.parseDouble(amountTo.getText());
            }
            catch (NumberFormatException e)
            {

            }
        }
        if (fromAmount == null && toAmount != null)
        {
            sql.append(" AND i.GrandTotal <= ?");
        }
        else if (fromAmount != null && toAmount == null)
        {
            sql.append(" AND i.GrandTotal >= ?");
        }
        else if (fromAmount != null && toAmount != null)
        {
              sql.append(" AND i.GrandTotal BETWEEN ? AND ?");
        }
        sql.append(" AND i.IsPaid=? AND i.IsSOTrx=?");

        if (log.isLoggable(Level.FINER)) log.finer(sql.toString());
        return sql.toString();
    }

    @Override
    protected void setParameters(PreparedStatement pstmt, boolean forCount) throws SQLException
    {
        int index = 1;
        if (txtDocumentNo.getText().length() > 0)
            pstmt.setString(index++, getSQLText(txtDocumentNo));
        if (txtDescription.getText().length() > 0)
            pstmt.setString(index++, getSQLText(txtDescription));

        //
        if (editorBPartner.getValue() != null)
        {
            Integer bp = (Integer)editorBPartner.getValue();
            pstmt.setInt(index++, bp.intValue());
            if (log.isLoggable(Level.FINE)) log.fine("BPartner=" + bp);
        }
        //
        if (editorOrder.getValue() != null)
        {
            Integer order = (Integer)editorOrder.getValue();
            pstmt.setInt(index++, order.intValue());
            if (log.isLoggable(Level.FINE)) log.fine("Order=" + order);
        }
        Date fromD = null;
        Date toD = null;
        Timestamp from = null;
        Timestamp to = null;
        try
        {
            if (dateFrom.getValue() != null)
            {
                fromD = dateFrom.getValue();
                from = new Timestamp(fromD.getTime());
            }
        }
        catch (WrongValueException e)
        {

        }
        try
        {
            if (dateTo.getValue() != null)
            {
                toD = dateTo.getValue();
                to = new Timestamp(toD.getTime());
            }
        }
        catch (WrongValueException e)
        {

        }

        if (log.isLoggable(Level.FINE)) log.fine("Date From=" + from + ", To=" + to);
        if (from == null && to != null)
        {
            pstmt.setTimestamp(index++, to);
        }
        else if (from != null && to == null)
        {
            pstmt.setTimestamp(index++, from);
        }
        else if (from != null && to != null)
        {
            pstmt.setTimestamp(index++, from);
            pstmt.setTimestamp(index++, to);
        }

    //
        BigDecimal fromBD = null;
        BigDecimal toBD = null;
        Double fromAmt = null;
        Double toAmt = null;

        if (!Util.isEmpty(amountFrom.getText()))
        {
            try
            {
                fromAmt = Double.parseDouble(amountFrom.getText());
                fromBD = BigDecimal.valueOf(fromAmt);
            }
            catch (Exception e)
            {

            }
        }

        if (!Util.isEmpty(amountTo.getText()))
        {
            try
            {
                toAmt = Double.parseDouble(amountTo.getText());
                toBD = BigDecimal.valueOf(toAmt);
            }
            catch (Exception e)
            {

            }
        }

        if (fromBD == null && toBD != null)
        {
            pstmt.setBigDecimal(index++, toBD);
        }
        else if (fromBD != null && toBD == null)
        {
            pstmt.setBigDecimal(index++, fromBD);
        }
        else if (fromBD != null && toBD != null)
        {
              pstmt.setBigDecimal(index++, fromBD);
              pstmt.setBigDecimal(index++, toBD);
        }
        pstmt.setString(index++,isPaid.isChecked() ? "Y" : "N");
        pstmt.setString(index++,isSoTrx.isChecked() ? "Y" : "N");

    }

    /**
     *  Get SQL WHERE parameter
     *  @param f field
     *  @return sql
     */
    private String getSQLText (Textbox f)
    {
        String s = f.getText().toUpperCase();
        if (!s.endsWith("%"))
            s += "%";
        if (log.isLoggable(Level.FINE)) log.fine("String=" + s);
        return s;
    }   //  getSQLText

    // Elaine 2008/12/16
	/**
	 *	Zoom
	 */
	public void zoom()
	{
		log.info( "InfoInvoice.zoom");
		Integer C_Invoice_ID = getSelectedRowKey();
		if (C_Invoice_ID == null)
			return;
		MQuery query = new MQuery("C_Invoice");
		query.addRestriction("C_Invoice_ID", MQuery.EQUAL, C_Invoice_ID);
		query.setRecordCount(1);
		int AD_WindowNo = getAD_Window_ID("C_Invoice", isSoTrx.isSelected());
		AEnv.zoom (AD_WindowNo, query);
	}	//	zoom

	/**
	 *	Has Zoom
	 *  @return true
	 */
	protected boolean hasZoom()
	{
		return true;
	}	//	hasZoom
	//

    public void tableChanged(WTableModelEvent event)
    {

    }
    public void valueChange(ValueChangeEvent evt)
    {
        if (editorBPartner.equals(evt.getSource()))
        {
            editorBPartner.setValue(evt.getNewValue());
        }
        if (editorOrder.equals(evt.getSource()))
        {
            editorOrder.setValue(evt.getNewValue());
        }
    }

	@Override
	protected void saveSelectionDetail()
	{
		//  publish for Callout to read
		Integer ID = getSelectedRowKey();
		Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_Invoice_ID", ID == null ? "0" : ID.toString());
		//
		int C_InvoicePaySchedule_ID = 0;
		int row = contentPanel.getSelectedRow();
		if (row >= 0)
		{
			Object value = contentPanel.getValueAt(row, INDEX_PAYSCHEDULE);
			if (value != null && value instanceof KeyNamePair)
				C_InvoicePaySchedule_ID = ((KeyNamePair)value).getKey();
		}
		if (C_InvoicePaySchedule_ID <= 0)	//	not selected
			Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_InvoicePaySchedule_ID", "0");
		else
			Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_InvoicePaySchedule_ID", String.valueOf(C_InvoicePaySchedule_ID));
	}

	@Override
	protected void insertPagingComponent()
	{
		southBody.insertBefore(paging, southBody.getFirstChild());
		layout.invalidate();
	}
}
