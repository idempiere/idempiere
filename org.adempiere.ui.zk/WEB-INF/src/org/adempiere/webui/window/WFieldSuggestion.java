/**
 * 
 */
package org.adempiere.webui.window;

import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MField;
import org.compiere.model.MFieldSuggestion;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Label;
import org.zkoss.zul.South;
import org.zkoss.zul.Textbox;

/**
 * @author hengsin
 *
 */
public class WFieldSuggestion extends Window implements EventListener<Event> {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 6696533431007741092L;
	
	private ConfirmPanel confirmPanel;

	private MField field;

	private Textbox nameTextbox;

	private Textbox descriptionTextbox;

	private Textbox helpTextbox;

	/**
	 * default constructor
	 */
	public WFieldSuggestion(int AD_Field_ID) {
		field = new MField(Env.getCtx(), AD_Field_ID, null);
		layout();
	}

	private void layout() {
		Borderlayout borderlayout = new Borderlayout();
		appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("1");
		
		Center center = new Center();
		center.setVflex("1");
		center.setHflex("1");
		borderlayout.appendChild(center);
		Grid grid = GridFactory.newGridLayout();
		grid.setVflex(true);
		grid.setHflex("true");
		center.appendChild(grid);
		Columns columns = new Columns();
		grid.appendChild(columns);
		Column column = new Column();
		column.setWidth("25%");
		column.setAlign("right");
		columns.appendChild(column);
		column = new Column();
		column.setWidth("75%");
		column.setAlign("left");
		columns.appendChild(column);
		
		Rows rows = grid.newRows();
		Row row = rows.newRow();
		row.appendCellChild(new Label(Msg.getElement(Env.getCtx(), "AD_Field_ID")));
		row.appendCellChild(new Label(field.get_Translation("Name")));
		
		row = rows.newRow();
		row.appendCellChild(new Label(Msg.getElement(Env.getCtx(), "Name")));
		nameTextbox = new Textbox(field.get_Translation("Name"));
		nameTextbox.setMaxlength(60);
		nameTextbox.setHflex("1");
		row.appendCellChild(nameTextbox);
		
		row = rows.newRow();
		row.appendCellChild(new Label(Msg.getElement(Env.getCtx(), "Description")));
		descriptionTextbox = new Textbox(field.get_Translation("Description"));
		descriptionTextbox.setRows(4);
		descriptionTextbox.setMaxlength(255);
		descriptionTextbox.setHflex("1");
		descriptionTextbox.setMultiline(true);
		row.appendCellChild(descriptionTextbox);
		
		row = rows.newRow();
		row.appendCellChild(new Label(Msg.getElement(Env.getCtx(), "Help")));
		helpTextbox = new Textbox(field.get_Translation("Help"));
		helpTextbox.setRows(8);
		helpTextbox.setMultiline(true);
		helpTextbox.setMaxlength(2000);
		helpTextbox.setHflex("1");
		row.appendCellChild(helpTextbox);
		
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);
		
		this.setSclass("popup-dialog");
		this.setClosable(true);
		this.setBorder("normal");
		ZKUpdateUtil.setWindowWidthX(this, 550);
		ZKUpdateUtil.setWindowHeightX(this, 350);
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		this.setSizable(true);
		this.setMaximizable(true);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			onSave();
		} else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL)) {
			onCancel();
		}		
	}

	private void onCancel() {
		this.detach();
	}

	private void onSave() {
		MFieldSuggestion suggestion = new MFieldSuggestion(Env.getCtx(), 0, null);
		suggestion.setClientOrg(0, 0);
		suggestion.setAD_Field_ID(field.getAD_Field_ID());
		suggestion.setAD_Language(Env.getAD_Language(Env.getCtx()));
		suggestion.setAD_Org_ID(0);
		suggestion.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
		suggestion.set_ValueOfColumn("AD_UserClient_ID",Env.getAD_Client_ID(Env.getCtx()));
		suggestion.setDescription(descriptionTextbox.getText());
		suggestion.setHelp(helpTextbox.getText());
		suggestion.setName(nameTextbox.getText());
		suggestion.setIsApproved(false);
		suggestion.setIsUpdateBaseLanguage(false);
		suggestion.setProcessed(false);
		try {
			PO.setCrossTenantSafe();
			suggestion.saveEx();
		}finally {
			PO.clearCrossTenantSafe();
		}
		Dialog.info(0, Msg.getMsg(Env.getCtx(),"Your suggestions have been submitted for review"));
		this.detach();
	}
}
