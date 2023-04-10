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
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MQuery;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Vbox;

/**
* Based on InfoInOut written by Jorg Janke
*
* @author 	Niraj Sohun
* 			Aug 03, 2007
*
* Zk Port
* @author Elaine
* @version	InfoInOut.java Adempiere Swing UI 3.4.1
*/

@Deprecated // replaced with InfoInOutWindow IDEMPIERE-325
public class InfoInOutPanel extends InfoPanel implements ValueChangeListener, EventListener<Event>
{
	/**
	 *
	 */
	private static final long serialVersionUID = -3927370377224858985L;

	private Textbox fDocumentNo = new Textbox();

	private WEditor fBPartner_ID;

	private Textbox fDescription = new Textbox();
	private Textbox fPOReference = new Textbox();

	private Datebox fDateFrom = new Datebox();
	private Datebox fDateTo = new Datebox();

	private Checkbox fIsSOTrx = new Checkbox();

	private Label lDocumentNo = new Label(Msg.translate(Env.getCtx(), "DocumentNo"));
	private Label lDescription = new Label(Msg.translate(Env.getCtx(), "Description"));
	private Label lPOReference = new Label(Msg.translate(Env.getCtx(), "POReference"));

	private Label lDateFrom = new Label(Msg.translate(Env.getCtx(), "MovementDate"));
	private Label lDateTo = new Label("-");

	private Vbox southBody;

	private Borderlayout layout;

	/**  Array of Column Info    */
	private static final ColumnInfo[] s_invoiceLayout = {
		new ColumnInfo(" ", "i.M_InOut_ID", IDColumn.class),
		new ColumnInfo(Msg.translate(Env.getCtx(), "C_BPartner_ID"), "(SELECT Name FROM C_BPartner bp WHERE bp.C_BPartner_ID=i.C_BPartner_ID)", String.class),
		new ColumnInfo(Msg.translate(Env.getCtx(), "MovementDate"), "i.MovementDate", Timestamp.class),
		new ColumnInfo(Msg.translate(Env.getCtx(), "DocumentNo"), "i.DocumentNo", String.class),
		new ColumnInfo(Msg.translate(Env.getCtx(), "Description"), "i.Description", String.class),
		new ColumnInfo(Msg.translate(Env.getCtx(), "POReference"), "i.POReference", String.class),
		new ColumnInfo(Msg.translate(Env.getCtx(), "IsSOTrx"), "i.IsSOTrx", Boolean.class)
	};

	/**
	 *  Detail Protected Constructor
	 *
	 *  @param WindowNo window no
	 *  @param value query value
	 *  @param multiSelection multiple selections
	 *  @param whereClause where clause
	 */
	public InfoInOutPanel(	int WindowNo, String value,
								boolean multiSelection, String whereClause)
	{
		this(WindowNo, value, multiSelection, whereClause, true);
	}

	/**
	 *  Detail Protected Constructor
	 *
	 *  @param WindowNo window no
	 *  @param value query value
	 *  @param multiSelection multiple selections
	 *  @param whereClause where clause
	 */
	public InfoInOutPanel(	int WindowNo, String value,
								boolean multiSelection, String whereClause, boolean lookup)
	{
		super (WindowNo, "i", "M_InOut_ID", multiSelection, whereClause, lookup);
		log.info( "InfoInOut");
		setTitle(Msg.getMsg(Env.getCtx(), "InfoInOut"));

		try
		{
			statInit();
			p_loadedOK = initInfo ();
		}
		catch (Exception e)
		{
			return;
		}

		int no = contentPanel.getRowCount();
		setStatusLine(Integer.toString(no) + " " + Msg.getMsg(Env.getCtx(), "SearchRows_EnterQuery"), false);
		setStatusDB(Integer.toString(no));

		if (value != null && value.length() > 0)
		{
			fDocumentNo.setValue(value);
			executeQuery();
		}
	} // InfoInOutPanel

	/**
	 *	Static Setup - add fields to parameterPanel
	 *  @throws Exception if Lookups cannot be initialized
	 */

	private void statInit() throws Exception
	{
		ZKUpdateUtil.setHflex(fDocumentNo, "1");
		ZKUpdateUtil.setHflex(fDescription, "1");
		ZKUpdateUtil.setHflex(fPOReference, "1");
		ZKUpdateUtil.setWidth(fDateFrom, "165px");
		ZKUpdateUtil.setWidth(fDateTo, "165px");

		fDocumentNo.addEventListener(Events.ON_CHANGE, this);
		fDescription.addEventListener(Events.ON_CHANGE, this);
		fPOReference.addEventListener(Events.ON_CHANGE, this);
		
		fDocumentNo.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "documentNo");
		fDescription.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "description");
		fPOReference.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "poreference");
		fDateFrom.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "dateFrom");
		fDateTo.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "dateTo");

		fIsSOTrx.setLabel(Msg.translate(Env.getCtx(), "IsSOTrx"));
		fIsSOTrx.setChecked(!"N".equals(Env.getContext(Env.getCtx(), p_WindowNo, "IsSOTrx")));
		fIsSOTrx.addEventListener(Events.ON_CHECK, this);

		fBPartner_ID = new WSearchEditor(
				MLookupFactory.get (Env.getCtx(), p_WindowNo, 0, 3499, DisplayType.Search),
				Msg.translate(Env.getCtx(), "BPartner"), "", false, false, true);
		fBPartner_ID.addValueChangeListener(this);

		Grid grid = GridFactory.newGridLayout();

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lDocumentNo.rightAlign());
		row.appendChild(fDocumentNo);
		row.appendChild(fBPartner_ID.getLabel().rightAlign());
		row.appendChild(fBPartner_ID.getComponent());
		row.appendChild(fIsSOTrx);

		row = new Row();
		row.appendCellChild(lDescription.rightAlign(), 1);
		row.appendCellChild(fDescription, 1);
		row.appendCellChild(lDateFrom.rightAlign(), 1);
		Hbox hbox = new Hbox();
		hbox.appendChild(fDateFrom);
		hbox.appendChild(lDateTo);
		hbox.appendChild(fDateTo);
		row.appendCellChild(hbox, 2);
		rows.appendChild(row);

		row = new Row();
		row.appendCellChild(lPOReference.rightAlign(), 1);
		row.appendCellChild(fPOReference, 1);
		row.appendCellChild(new Label(), 3);
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
	 *	General Init
	 *	@return true, if success
	 */

	private boolean initInfo ()
	{
		//  Set Defaults
		String bp = Env.getContext(Env.getCtx(), p_WindowNo, "C_BPartner_ID");

		if (bp != null && bp.length() != 0)
			fBPartner_ID.setValue(Integer.valueOf(bp));

		// Prepare table

		StringBuilder where = new StringBuilder("i.IsActive='Y'");

		if (p_whereClause.length() > 0)
			where.append(" AND ").append(Util.replace(p_whereClause, "M_InOut.", "i."));

		prepareTable(s_invoiceLayout, " M_InOut i", where.toString(), "2,3,4");

		return true;
	} // initInfo

	/*************************************************************************/

	/**
	 *	Construct SQL Where Clause and define parameters.
	 *  (setParameters needs to set parameters)
	 *  Includes first AND
	 * 	@return where clause
	 */

	protected String getSQLWhere()
	{
		StringBuilder sql = new StringBuilder();

		if (fDocumentNo.getText().length() > 0)
			sql.append(" AND UPPER(i.DocumentNo) LIKE ?");

		if (fDescription.getText().length() > 0)
			sql.append(" AND UPPER(i.Description) LIKE ?");

		if (fPOReference.getText().length() > 0)
			sql.append(" AND UPPER(i.POReference) LIKE ?");

		if (!"".equals(fBPartner_ID.getDisplay()))
			sql.append(" AND i.C_BPartner_ID=?");

		if (fDateFrom.getValue() != null || fDateTo.getValue() != null)
		{
			Date f = fDateFrom.getValue();
			Timestamp from = null;
			if (f != null)
				from = new Timestamp(f.getTime());

			Date t = fDateTo.getValue();
			Timestamp to = null;
			if (t != null)
				to = new Timestamp(t.getTime());

			if (from == null && to != null)
				sql.append(" AND TRUNC(i.MovementDate) <= ?");
			else if (from != null && to == null)
				sql.append(" AND TRUNC(i.MovementDate) >= ?");
			else if (from != null && to != null)
				sql.append(" AND TRUNC(i.MovementDate) BETWEEN ? AND ?");
		}
		sql.append(" AND i.IsSOTrx=?");

		return sql.toString();
	} // getSQLWhere

	/**
	 *  Set Parameters for Query.
	 *  (as defined in getSQLWhere)
	 *  @param pstmt statement
	 *  @param forCount for counting records
	 *  @throws SQLException
	 */

	protected void setParameters(PreparedStatement pstmt, boolean forCount) throws SQLException
	{
		int index = 1;

		if (fDocumentNo.getText().length() > 0)
			pstmt.setString(index++, getSQLText(fDocumentNo));

		if (fDescription.getText().length() > 0)
			pstmt.setString(index++, getSQLText(fDescription));

		if (fPOReference.getText().length() > 0)
			pstmt.setString(index++, getSQLText(fPOReference));

		if (!"".equals(fBPartner_ID.getDisplay()))
		{
			Integer bp = (Integer)fBPartner_ID.getValue();
			pstmt.setInt(index++, bp.intValue());
			if (log.isLoggable(Level.FINE)) log.fine("BPartner=" + bp);
		}

		if (fDateFrom.getValue() != null || fDateTo.getValue() != null)
		{
			Date f = fDateFrom.getValue();
			Timestamp from = null;
			if (f != null)
				from = new Timestamp(f.getTime());

			Date t = fDateTo.getValue();
			Timestamp to = null;
			if (t != null)
				to = new Timestamp(t.getTime());

			if (log.isLoggable(Level.FINE)) log.fine("Date From=" + from + ", To=" + to);

			if (from == null && to != null)
				pstmt.setTimestamp(index++, to);
			else if (from != null && to == null)
				pstmt.setTimestamp(index++, from);
			else if (from != null && to != null)
			{
				pstmt.setTimestamp(index++, from);
				pstmt.setTimestamp(index++, to);
			}
		}
		pstmt.setString(index++, fIsSOTrx .isChecked() ? "Y" : "N");
	} // setParameters

	/**
	 *  Get SQL WHERE parameter
	 *  @param f field
	 *  @return sql part
	 */

	private String getSQLText (Textbox f)
	{
		String s = f.getText().toUpperCase();

		if (!s.endsWith("%"))
			s += "%";

		if (log.isLoggable(Level.FINE)) log.fine( "String=" + s);
		return s;
	} // getSQLText

	// Elaine 2008/12/16
	/**
	 *	Zoom
	 */
	public void zoom()
	{
		log.info( "InfoInOut.zoom");
		Integer M_InOut_ID = getSelectedRowKey();
		if (M_InOut_ID == null)
			return;
		MQuery query = new MQuery("M_InOut");
		query.addRestriction("M_InOut_ID", MQuery.EQUAL, M_InOut_ID);
		query.setRecordCount(1);
		int AD_WindowNo = getAD_Window_ID("M_InOut", fIsSOTrx.isSelected());
		AEnv.zoom (AD_WindowNo, query);
	}	//	zoom
	//

	/**
	 *	Has Zoom
	 *  @return true
	 */

	protected boolean hasZoom()
	{
		return true;
	}	//	hasZoom

	public void valueChange(ValueChangeEvent evt)
	{
		if (fBPartner_ID.equals(evt.getSource()))
		{
	    	fBPartner_ID.setValue(evt.getNewValue());
		}
	}

	public void tableChanged(WTableModelEvent event)
	{

	}

	@Override
	protected void insertPagingComponent() {
		southBody.insertBefore(paging, southBody.getFirstChild());
		layout.invalidate();
	}
}