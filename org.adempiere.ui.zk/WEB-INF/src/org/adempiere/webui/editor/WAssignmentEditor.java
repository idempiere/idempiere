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
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.InfoSchedule;
import org.adempiere.webui.window.WAssignmentDialog;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.MProduct;
import org.compiere.model.MResourceAssignment;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

public class WAssignmentEditor extends WEditor implements ContextMenuListener {
	
	private static final String RETRIEVE_RESOURCE_ASSIGNMENT_SQL = "SELECT r.Name,ra.AssignDateFrom,ra.Qty,uom.UOMSymbol "
			+ "FROM S_ResourceAssignment ra, S_Resource r, S_ResourceType rt, C_UOM uom "
			+ "WHERE ra.S_ResourceAssignment_ID=?"
			+ " AND ra.S_Resource_ID=r.S_Resource_ID"
			+ " AND r.S_ResourceType_ID=rt.S_ResourceType_ID"
			+ " and rt.C_UOM_ID=uom.C_UOM_ID";

	private final static CLogger log = CLogger.getCLogger(WAssignmentEditor.class);
	
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
		
	private boolean m_readWrite;
	private Object m_value;
	
	private DateFormat			m_dateFormat = DisplayType.getDateFormat(DisplayType.DateTime);
	private NumberFormat		m_qtyFormat = DisplayType.getNumberFormat(DisplayType.Quantity);
	
	/**
	 * 
	 * @param gridField
	 */
	public WAssignmentEditor(GridField gridField) {
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WAssignmentEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new EditorBox(), gridField, tableEditor, editorConfiguration);
		
		initComponents();
	}
	
	private void initComponents() {
		getComponent().getTextbox().setReadonly(true);
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-Assignment");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/Assignment16.png"));
		
		popupMenu = new WEditorPopupMenu(true, false, false);
		popupMenu.addMenuListener(this);
		addChangeLogMenu(popupMenu);
		if (gridField != null)
			getComponent().getTextbox().setPlaceholder(gridField.getPlaceholder());
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

		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		try
		{
			pstmt = DB.prepareStatement(RETRIEVE_RESOURCE_ASSIGNMENT_SQL, null);
			pstmt.setInt(1, S_ResourceAssignment_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				StringBuilder sb = new StringBuilder(rs.getString(1));
				sb.append(" ").append(m_dateFormat.format(rs.getTimestamp(2)))
					.append(" ").append(m_qtyFormat.format(rs.getBigDecimal(3)))
					.append(" ").append(rs.getString(4).trim());
				getComponent().setText(sb.toString());
			}
			else
				getComponent().setText("<" + S_ResourceAssignment_ID + ">");
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		finally
		{
			DB.close(rs, pstmt);
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
					// assign the org of the document if any
					Object org = gridField.getGridTab().getValue("AD_Org_ID");
					if (org != null && org instanceof Integer)
						ma.setAD_Org_ID((Integer) org);
					// assign the resource of the document if any
					Object prd = gridField.getGridTab().getValue("M_Product_ID");
					if (prd != null && prd instanceof Integer) {
						MProduct prod = MProduct.get(Env.getCtx(), (Integer) prd);
						if (prod != null && prod.getS_Resource_ID() > 0)
							ma.setS_Resource_ID(prod.getS_Resource_ID());
					}
				}
			}
	
			//	Start VAssignment Dialog
			if (S_ResourceAssignment_ID != 0)
			{
				final WAssignmentDialog vad = new WAssignmentDialog (ma, true, true);
				vad.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						if (!vad.isCancelled()) {
							MResourceAssignment ma = vad.getMResourceAssignment();
							processNewValue(oldValue, ma);	
						}
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
				AEnv.showWindow(is);
				is.focus();
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
			setValue(Integer.valueOf(ma.getS_ResourceAssignment_ID()));
			ValueChangeEvent vce = new ValueChangeEvent(WAssignmentEditor.this, gridField.getColumnName(), oldValue, getValue());
			fireValueChange(vce);
		}
	}

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}	
}
