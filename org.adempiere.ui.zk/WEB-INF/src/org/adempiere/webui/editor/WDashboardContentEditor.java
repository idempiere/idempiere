/**
 * 
 */
package org.adempiere.webui.editor;

import java.util.logging.Level;

import org.adempiere.webui.dashboard.DashboardRunnable;
import org.adempiere.webui.desktop.DashboardController;
import org.compiere.model.GridField;
import org.compiere.model.MDashboardContent;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Div;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;

/**
 * @author hengsin
 *
 */
public class WDashboardContentEditor extends WEditor {

	private static final String ON_RENDER_CONTENT = "onRenderContent";
	private DashboardController dashboardController;
	private MDashboardContent content;
	private String fieldStyle;

	private final static CLogger logger  = CLogger.getCLogger(WDashboardContentEditor.class);
	
	/**
	 * 
	 * @param gridField
	 * @param windowNo
	 */
	public WDashboardContentEditor(GridField gridField, int windowNo) {
		this(gridField, windowNo, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param windowNo
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WDashboardContentEditor(GridField gridField, int windowNo, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new Panel(), gridField, tableEditor, editorConfiguration);
		dashboardController = new DashboardController();
		content = new MDashboardContent(Env.getCtx(), gridField.getPA_DashboardContent_ID(), null);
		Panelchildren pc = new Panelchildren();
		getComponent().appendChild(pc);		
		
		if (content.get_ID() > 0) {
			Caption caption = new Caption(content.get_Translation(MDashboardContent.COLUMNNAME_Name));
			getComponent().appendChild(caption);
		}
    	getComponent().addEventListener(ON_RENDER_CONTENT, this);
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.event.EventListener#onEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(ON_RENDER_CONTENT)) {
			try {
				render();
			} catch (Exception e) {
				logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}		
		}
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setReadWrite(boolean)
	 */
	@Override
	public void setReadWrite(boolean readWrite) {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isReadWrite()
	 */
	@Override
	public boolean isReadWrite() {
		return false;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setValue(java.lang.Object)
	 */
	@Override
	public void setValue(Object value) {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getValue()
	 */
	@Override
	public Object getValue() {
		return null;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getDisplay()
	 */
	@Override
	public String getDisplay() {
		return null;
	}

	@Override
	public void dynamicDisplay() {
		super.dynamicDisplay();
		Events.postEvent(ON_RENDER_CONTENT, getComponent(), null);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getComponent()
	 */
	@Override
	public Panel getComponent() {
		return (Panel) super.getComponent();
	}

	private void render() throws Exception {
		Panel panel = getComponent();
		panel.setSclass("dashboard-field-panel");
		Panelchildren pc = panel.getPanelchildren();
		pc.getChildren().clear();
		Div div = new Div();		
		if (!Util.isEmpty(fieldStyle))
			div.setStyle(fieldStyle);
		
		DashboardRunnable dashboardRunnable = new DashboardRunnable(panel.getDesktop());
		dashboardController.render(div, content, dashboardRunnable);
		if (!dashboardRunnable.isEmpty())
			dashboardRunnable.refreshDashboard(false);
		
		pc.appendChild(div);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setFieldStyle(java.lang.String)
	 */
	@Override
	protected void setFieldStyle(String style) {
		fieldStyle = style;
	}
	
}
