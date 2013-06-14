/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.apps;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import javax.activation.DataSource;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.component.AttachmentItem;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.FeedbackManager;
import org.adempiere.webui.window.FDialog;
import org.apache.commons.io.IOUtils;
import org.compiere.model.MAttachment;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRequest;
import org.compiere.model.MRole;
import org.compiere.util.ByteArrayDataSource;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.UploadEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.South;

/**
 * 
 * @author hengsin
 *
 */
public class FeedbackRequestWindow extends Window implements EventListener<Event> {
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8586980192148533197L;

	private static CLogger log = CLogger.getCLogger(FeedbackRequestWindow.class);
	
	protected WTableDirEditor requestTypeField, priorityField, salesRepField;
	protected Textbox txtSummary;
	protected ConfirmPanel confirmPanel;
	
	protected List<DataSource> attachments = new ArrayList<DataSource>();
	protected Div attachmentBox;
	
	public FeedbackRequestWindow() {
		
		super();
		
		setTitle(Msg.getMsg(Env.getCtx(), "RequestNew"));
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		setWidth("400px");
		this.setSclass("popup-dialog");
		this.setBorder("normal");
		this.setShadow(true);
		this.setClosable(true);
		
		boolean readOnly = !MRole.getDefault().canUpdate(
				Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()), 
				MRequest.Table_ID, 0, false);
		
		if (readOnly)
		{
			throw new RuntimeException(Msg.getMsg(Env.getCtx(), "AccessTableNoUpdate"));
		}
		
		Label lblRequestType = new Label("Request Type");
		Label lblPriority = new Label("Priority");
		Label lblSummary = new Label("Summary");
		Label lblSalesRep = new Label("Sales Representative");
		
		int columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_R_RequestType_ID);
		MLookup lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.TableDir);
		requestTypeField = new WTableDirEditor("R_RequestType_ID", true, false, true, lookup);
		requestTypeField.setValue(Env.getContext(Env.getCtx(), "P232|R_RequestType_ID"));
		if(requestTypeField.getValue() == null || requestTypeField.getValue().equals(""))
			if(requestTypeField.getComponent().getItemCount() > 1)
				requestTypeField.setValue(requestTypeField.getComponent().getItemAtIndex(1).getValue());
				
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_Priority);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.List);
		priorityField = new WTableDirEditor("Priority", true, false, true, lookup);
		priorityField.setValue(Env.getContext(Env.getCtx(), "P232|Priority"));
		if(priorityField.getValue() == null || priorityField.getValue().equals(""))
			if(priorityField.getComponent().getItemCount() > 1)
				priorityField.setValue(priorityField.getComponent().getItemAtIndex(1).getValue());
		
		columnID = MColumn.getColumn_ID(MRequest.Table_Name, MRequest.COLUMNNAME_SalesRep_ID);
		lookup = MLookupFactory.get(Env.getCtx(), 0, 0, columnID, DisplayType.TableDir);
		salesRepField = new WTableDirEditor("SalesRep_ID", true, false, true, lookup);
		salesRepField.setValue(Env.getContextAsInt(Env.getCtx(), "SalesRep_ID"));
		if(salesRepField.getValue() == null || salesRepField.getValue().equals("0"))
			if(salesRepField.getComponent().getItemCount() > 1)
				salesRepField.setValue(salesRepField.getComponent().getItemAtIndex(1).getValue());
		
		txtSummary = new Textbox();
		txtSummary.setRows(10);
		txtSummary.setWidth("95%");
		
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);
		
		
		Grid grid = GridFactory.newGridLayout();
		grid.setVflex("min");
		
		Rows rows = new Rows();
		grid.appendChild(rows);
		
		Row row = rows.newRow();
		row.setStyle("padding: 4px 4px 0px 6px");
		row.appendChild(lblRequestType);
		
		row = rows.newRow();
		row.setStyle("padding: 0px 4px 4px 6px");
		row.appendChild(requestTypeField.getComponent());
		
		
		row = rows.newRow();
		row.setStyle("padding: 4px 4px 0px 6px");
		row.appendChild(lblPriority);
		
		row = rows.newRow();
		row.setStyle("padding: 0px 4px 4px 6px");
		row.appendChild(priorityField.getComponent());
		
		row = rows.newRow();
		row.setStyle("padding: 4px 4px 0px 6px");
		row.appendChild(lblSummary);
		
		row = rows.newRow();
		row.setStyle("padding: 0px 4px 4px 6px");
		row.appendChild(txtSummary);
		
		row = rows.newRow();
		row.setStyle("padding: 4px 4px 0px 6px");
		row.appendChild(lblSalesRep);
		
		row = rows.newRow();
		row.setStyle("padding: 0px 4px 4px 6px");
		row.appendChild(salesRepField.getComponent());
		
		row = rows.newRow();
		row.setStyle("padding: 4px 4px 0px 6px");
		row.appendChild(new Label(Msg.getMsg(Env.getCtx(), "Attachment")));
		
		attachmentBox = new Div();
		attachmentBox.setHflex("1");
		attachmentBox.setVflex("1");
		row = rows.newRow();
		row.setStyle("padding: 0px 4px 4px 6px");
		row.appendChild(attachmentBox);
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("min");
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		
		centerPane.appendChild(grid);
		grid.setVflex("1");
		grid.setHflex("1");

		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);
		
		Button btn = new Button();
		btn.setImage(ThemeManager.getThemeResource("images/Attachment24.png"));
		btn.setUpload(AdempiereWebUI.getUploadSetting());
		btn.addEventListener(Events.ON_UPLOAD, this);
		btn.setTooltiptext(Msg.getMsg(Env.getCtx(), "Attachment"));
		confirmPanel.addComponentsLeft(btn);
		confirmPanel.getButton(ConfirmPanel.A_OK).setWidgetListener("onClick", "zAu.cmd0.showBusy(null)");
		
		addAttachment(FeedbackManager.getLogAttachment(false), false);
	}
	
	public void onEvent(Event e) throws Exception {
		if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			Clients.clearBusy();
			// Check Mandatory fields
			if (requestTypeField.getValue() == null || requestTypeField.getValue().equals("0"))
				throw new WrongValueException(requestTypeField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			if (priorityField.getValue() == null || priorityField.getValue().equals(""))
				throw new WrongValueException(priorityField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			if (txtSummary.getText() == null || txtSummary.getText().equals(""))
				throw new WrongValueException(txtSummary, Msg.translate(Env.getCtx(), "FillMandatory"));
			if (salesRepField.getValue() == null || salesRepField.getValue().equals("0"))
				throw new WrongValueException(salesRepField.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
			
			saveRequest();
			
			this.detach();
		}
		else if (e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
		{
			this.detach();
		}
		else if (e instanceof UploadEvent)
		{
			UploadEvent ue = (UploadEvent) e;
			Media media = ue.getMedia();
			if (media != null) 
			{
				byte[] data = getMediaData(media);
				ByteArrayDataSource dataSource = new ByteArrayDataSource(data, media.getContentType());
				dataSource.setName(media.getName());
				addAttachment(dataSource, true);			    
			}
		}
	}

	protected void saveRequest() throws IOException {
		Trx trx = Trx.get(Trx.createTrxName("SaveNewRequest"), true);
		try {
			trx.start();
			MRequest request = createMRequest(trx);
			
			boolean success = request.save();
			if (success)
			{
				MAttachment attachment = null;
				for(DataSource ds : attachments)
				{
					if (attachment == null)
					{
						attachment = new MAttachment(Env.getCtx(), 0, request.get_TrxName());
						attachment.setAD_Table_ID(request.get_Table_ID());
						attachment.setRecord_ID(request.get_ID());
					}
					
					attachment.addEntry(ds.getName(), IOUtils.toByteArray(ds.getInputStream()));
				}
				if (attachment != null)
					success = attachment.save();
				
				if (success)
					success = trx.commit();
				
			}
			
			if (success)
			{
				FDialog.info(0, null, Msg.getMsg(Env.getCtx(), "Saved"));
			}
			else
			{
				trx.rollback();
				FDialog.error(0, this, Msg.getMsg(Env.getCtx(), "SaveError"));
			}
		} finally {
			trx.close();
		}
	}

	protected MRequest createMRequest(Trx trx) {
		MRequest request = new MRequest(Env.getCtx(), 0, trx.getTrxName());
		request.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
		request.setR_RequestType_ID((Integer) requestTypeField.getValue());
		request.setPriority((String) priorityField.getValue());
		request.setSummary(txtSummary.getText());
		request.setSalesRep_ID((Integer) salesRepField.getValue());
		return request;
	}

	public void addAttachment(DataSource dataSource, boolean removable) {
		attachments.add(dataSource);
		AttachmentItem item = new AttachmentItem(dataSource, attachments, removable);
		attachmentBox.appendChild(item);
		getFirstChild().invalidate();
	}
	
	private byte[] getMediaData(Media media) {
		byte[] bytes = null;
		
		try {			
			if (media.inMemory()) {
				bytes = media.isBinary() ? media.getByteData() : media.getStringData().getBytes(getCharset(media.getContentType()));
			} else {
				
				InputStream is = media.getStreamData();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte[] buf = new byte[ 1000 ];
				int byteread = 0;
				 
				while (( byteread=is.read(buf) )!=-1)
					baos.write(buf,0,byteread);
				
				bytes = baos.toByteArray();
			}
		} catch (IOException e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			throw new IllegalStateException(e.getLocalizedMessage());
		}

		return bytes;
	}
	
	private String getCharset(String contentType) {
		if (contentType != null) {
			int j = contentType.indexOf("charset=");
			if (j >= 0) {
				String cs = contentType.substring(j + 8).trim();
				if (cs.length() > 0) return cs;
			}
		}
		return "UTF-8";
	}	
}
