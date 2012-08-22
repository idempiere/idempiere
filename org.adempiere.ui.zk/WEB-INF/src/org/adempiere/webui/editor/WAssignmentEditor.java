package org.adempiere.webui.editor;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.window.InfoSchedule;
import org.adempiere.webui.window.WAssignmentDialog;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.MResourceAssignment;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

public class WAssignmentEditor extends WEditor implements ContextMenuListener {
	
	private final static CLogger log = CLogger.getCLogger(WAssignmentEditor.class);
	
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
		
	private boolean m_readWrite;
	private Object m_value;
	private PreparedStatement m_pstmt;
	
	private DateFormat			m_dateFormat = DisplayType.getDateFormat(DisplayType.DateTime);
	private NumberFormat		m_qtyFormat = DisplayType.getNumberFormat(DisplayType.Quantity);
	
	public WAssignmentEditor(GridField gridField) {
		super(new EditorBox(), gridField);
		
		initComponents();
	}
	
	private void initComponents() {
		getComponent().getTextbox().setReadonly(true);
		getComponent().setButtonImage("images/Assignment10.png");
		
		popupMenu = new WEditorPopupMenu(true, false, false);
		popupMenu.addMenuListener(this);
		addChangeLogMenu(popupMenu);
	}

	

	@Override
	public String[] getEvents() {
		return LISTENER_EVENTS;
	}

	@Override
	public EditorBox getComponent() {
		return (EditorBox) component;
	}

	@Override
	public String getDisplay() {
		return getComponent().getText();
	}

	@Override
	public Object getValue() {
		return m_value;
	}

	@Override
	public boolean isReadWrite() {	
		return m_readWrite;
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		m_readWrite = readWrite;
		getComponent().setEnabled(readWrite);
		getComponent().getTextbox().setReadonly(true);
	}

	@Override
	public void setValue(Object value) {
		if (value == m_value)
			return;
		m_value = value;
		int S_ResourceAssignment_ID = 0;
		if (m_value != null && m_value instanceof Integer)
			S_ResourceAssignment_ID = ((Integer)m_value).intValue();
		//	Set Empty
		if (S_ResourceAssignment_ID == 0)
		{
			getComponent().setText("");
			return;
		}

		//	Statement
		if (m_pstmt == null)
			m_pstmt = DB.prepareStatement("SELECT r.Name,ra.AssignDateFrom,ra.Qty,uom.UOMSymbol "
				+ "FROM S_ResourceAssignment ra, S_Resource r, S_ResourceType rt, C_UOM uom "
				+ "WHERE ra.S_ResourceAssignment_ID=?"
				+ " AND ra.S_Resource_ID=r.S_Resource_ID"
				+ " AND r.S_ResourceType_ID=rt.S_ResourceType_ID"
				+ " and rt.C_UOM_ID=uom.C_UOM_ID", null);
		//
		try
		{
			m_pstmt.setInt(1, S_ResourceAssignment_ID);
			ResultSet rs = m_pstmt.executeQuery();
			if (rs.next())
			{
				StringBuffer sb = new StringBuffer(rs.getString(1));
				sb.append(" ").append(m_dateFormat.format(rs.getTimestamp(2)))
					.append(" ").append(m_qtyFormat.format(rs.getBigDecimal(3)))
					.append(" ").append(rs.getString(4).trim());
				getComponent().setText(sb.toString());
			}
			else
				getComponent().setText("<" + S_ResourceAssignment_ID + ">");
			rs.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}

	}
		
	public void onEvent(Event event) throws Exception {
		//
		if (Events.ON_CLICK.equalsIgnoreCase(event.getName()))
		{
			final Integer oldValue = (Integer)getValue();
			int S_ResourceAssignment_ID = oldValue == null ? 0 : oldValue.intValue();
			MResourceAssignment ma = new MResourceAssignment(Env.getCtx(), S_ResourceAssignment_ID, null);
			if (S_ResourceAssignment_ID == 0) {
				if (gridField != null && gridField.getGridTab() != null) {
					// assign the resource of the document if any
					Object org = gridField.getGridTab().getValue("AD_Org_ID");
					if (org != null && org instanceof Integer)
						ma.setAD_Org_ID((Integer) org);
				}
			}
	
			//	Start VAssignment Dialog
			if (S_ResourceAssignment_ID != 0)
			{
				final WAssignmentDialog vad = new WAssignmentDialog (ma, true, true);
				vad.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						MResourceAssignment ma = vad.getMResourceAssignment();
						processNewValue(oldValue, ma);	
					}
				});
				vad.setTitle(null);
				LayoutUtils.openPopupWindow(this.getComponent().getTextbox(), vad);
			}
			//	Start InfoSchedule directly
			else
			{
				final InfoSchedule is = new InfoSchedule(ma, true, new Callback<MResourceAssignment>() {
					@Override
					public void onCallback(MResourceAssignment ma) {
						processNewValue(oldValue, ma);						
					}
				});			
			}			
		}
	}

	@Override
	public void onMenu(ContextMenuEvent evt) {
		if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		} else if (WEditorPopupMenu.ZOOM_EVENT.equals(evt.getContextEvent()))
		{
			actionZoom();
		}
		
	}

	private void actionZoom() {
		AEnv.zoom(gridField.getGridTab().getAD_Table_ID(), (Integer)getValue());
	}

	private void processNewValue(final Integer oldValue, MResourceAssignment ma) {
		// Set Value
		if (ma != null && ma.getS_ResourceAssignment_ID() != 0)
		{
			setValue(new Integer(ma.getS_ResourceAssignment_ID()));
			ValueChangeEvent vce = new ValueChangeEvent(WAssignmentEditor.this, gridField.getColumnName(), oldValue, getValue());
			fireValueChange(vce);
		}
	}

}
