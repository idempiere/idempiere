package org.adempiere.webui.apps.wf;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Label;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;

public class WFPopupItem extends Menuitem {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8409752634782368108L;

	public static final int WFPOPUPITEM_DELETENODE = -1;
	public static final int WFPOPUPITEM_PROPERTIES = -2;
	public static final int WFPOPUPITEM_ZOOM = -3;

	private int m_AD_Workflow_ID;

	private static final CLogger log = CLogger.getCLogger(WFPopupItem.class);

	/**
	 * 	Add Line Item
	 *	@param title title
	 *	@param node node
	 *	@param AD_WF_NodeTo_ID line to
	 */
	public WFPopupItem (String title, MWFNode node, int AD_WF_NodeTo_ID)
	{
		super (title);
		m_node = node;
		m_AD_WF_NodeTo_ID = AD_WF_NodeTo_ID;
		m_AD_Workflow_ID = node.getAD_Workflow_ID();
	}	//	WFPopupItem

	/**
	 * 	Delete Line Item
	 *	@param title title
	 *	@param line line to be deleted
	 */
	public WFPopupItem (String title, MWFNodeNext line)
	{
		super (title);
		m_line = line;
		m_AD_Workflow_ID = line.getAD_WF_Node().getAD_Workflow_ID();
	}	//	WFPopupItem

	/** The Node			*/
	private MWFNode		m_node;
	/** The Line			*/
	private MWFNodeNext m_line;
	/** The Next Node ID	*/
	private int			m_AD_WF_NodeTo_ID;

	/**
	 * 	Execute
	 */
	public void execute(final WFEditor wfp)
	{
		//	Add Line
		if (m_node != null && m_AD_WF_NodeTo_ID > 0)
		{
			int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
			MWFNodeNext newLine = new MWFNodeNext(m_node, m_AD_WF_NodeTo_ID);
			newLine.setClientOrg(AD_Client_ID, 0);
			newLine.saveEx();
			log.info("Add Line to " + m_node + " -> " + newLine);
			wfp.reload(m_AD_Workflow_ID, true);
		}
		//	Edit Properties
		else if (m_node != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_PROPERTIES)
		{
			editNode(wfp);
		}
		//	Zoom to Node
		else if (m_node != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_ZOOM)
		{
			int AD_Window_ID = MTable.get(Env.getCtx(), MWFNode.Table_ID).getAD_Window_ID();
			if (AD_Window_ID > 0) {
				MQuery query = new MQuery();
				query.setZoomColumnName("AD_WF_Node_ID");
        		//remove _ID to get table name
				query.setZoomTableName("AD_WF_Node");
				query.setZoomValue(m_node.getAD_WF_Node_ID());
				query.addRestriction("AD_WF_Node_ID", MQuery.EQUAL, m_node.getAD_WF_Node_ID());
				query.setRecordCount(1);    //  guess
				AEnv.zoom(AD_Window_ID, query);
			}
		}
		//	Delete Node
		else if (m_node != null && m_AD_WF_NodeTo_ID == WFPOPUPITEM_DELETENODE)
		{
			log.info("Delete Node: " + m_node);
			m_node.delete(false);
			wfp.reload(m_AD_Workflow_ID, true);
		}
		//	Delete Line
		else if (m_line != null)
		{
			log.info("Delete Line: " + m_line);
			m_line.delete(false);
			wfp.reload(m_AD_Workflow_ID, true);
		}
		else
			log.warning("No Action??");
	}	//	execute
	
	private void editNode(final WFEditor wfp) {
		String title = Msg.getMsg(Env.getCtx(), "Properties");
		final Window w = new Window();
		w.setTitle(title);
		Vbox vbox = new Vbox();
		w.appendChild(vbox);
		vbox.appendChild(new Separator());
		// Name
		String labelName = Msg.getElement(Env.getCtx(), MWFNode.COLUMNNAME_Name);
		Hbox hboxName = new Hbox();
		hboxName.appendChild(new Label(labelName));
		hboxName.appendChild(new Space());
		final Textbox textName = new Textbox(m_node.getName());
		hboxName.appendChild(textName);
		vbox.appendChild(hboxName);
		// Description
		String labelDescription = Msg.getElement(Env.getCtx(), MWFNode.COLUMNNAME_Description);
		Hbox hboxDescription = new Hbox();
		hboxDescription.appendChild(new Label(labelDescription));
		hboxDescription.appendChild(new Space());
		final Textbox textDescription = new Textbox(m_node.getDescription());
		hboxDescription.appendChild(textDescription);
		vbox.appendChild(hboxDescription);
		//
		vbox.appendChild(new Separator());
		final ConfirmPanel panel = new ConfirmPanel(true, false, false, false, false, false, false);
		vbox.appendChild(panel);
		panel.addActionListener(Events.ON_CLICK, new EventListener<Event>() {

			public void onEvent(Event event) throws Exception {
				if (event.getTarget() == panel.getButton(ConfirmPanel.A_CANCEL)) {
					textName.setText("");
				}
				w.onClose();
			}
		});
		
		w.setWidth("250px");
		w.setBorder("normal");
		w.setPage(this.getPage());
		w.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				String name = textName.getText();
				if (name != null && name.length() > 0)
				{
					m_node.setName(name);
					m_node.setDescription(textDescription.getText());
					m_node.saveEx();
					wfp.reload(m_AD_Workflow_ID, false);
				}				
			}
		});
		w.doHighlighted();				
	}
	
}
