/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.webui.window;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.apache.commons.codec.binary.Base64;
import org.compiere.model.MImage;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.MimeType;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.image.AImage;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.UploadEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;

/**
 *  Base on the original Swing Image Dialog.
 *  @author   Jorg Janke
 *  
 *  Zk Port
 *  @author Low Heng Sin 
 *  
 */
public class WImageDialog extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5048907034691374834L;

	/**
	 *  Constructor
	 *  @param mImage
	 */
	public WImageDialog (MImage mImage)
	{
		super ();
		this.setTitle(Msg.translate(Env.getCtx(), "AD_Image_ID"));
		log.info("MImage=" + mImage);
		m_mImage = mImage;
		try
		{
			init();
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}
		//  load data
		if (m_mImage == null)
			m_mImage = new MImage (Env.getCtx(), 0, null);
		else
		{
			if (m_mImage.getData()!=null)
			{
				try {
					AImage aImage = new AImage(m_mImage.getName(), m_mImage.getData());
					
					image.setContent(aImage);
					image.setClientAttribute("sandbox", "");
					image.setVisible(true);
					image.invalidate();
				} catch (Exception e) {
					log.log(Level.WARNING, "load image", e);
				}
			}
		}
		
		fileNameTextbox.setValue(m_mImage.getName());
		AEnv.showCenterScreen(this);
	}   //  WImageDialog

	/**  Image Model            */
	private MImage      m_mImage = null;
	/**	Logger					*/
	private static final CLogger log = CLogger.getCLogger(WImageDialog.class);

	/** */
	private Borderlayout mainLayout = new Borderlayout();
	private Panel parameterPanel = new Panel();
	private Button fileButton = new Button();
	private Button captureButton = new Button();
	private Iframe image = new Iframe();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true,false,true,false,false,false);
	private boolean cancel = false;
	private Textbox fileNameTextbox = new Textbox();
 
	private Div captureDiv;
	private String defaultNameForCaptureImage = "CapturedImage";
	private Button cancelCaptureButton;

	private static List<String> autoPreviewList;

	static {
		autoPreviewList = new ArrayList<String>();
		autoPreviewList.add("image/jpeg");
		autoPreviewList.add("image/png");
		autoPreviewList.add("image/gif");
		autoPreviewList.add("image/tiff");
		autoPreviewList.add("image/bmp");
		autoPreviewList.add("image/x-icon");
	}

	/**
	 *  Static Init
	 *  @throws Exception
	 */
	void init() throws Exception
	{
		this.setSclass("popup-dialog image-dialog");
		this.setBorder("normal");
		if (!ThemeManager.isUseCSSForWindowSize()) 
		{
			ZKUpdateUtil.setWindowWidthX(this, 640);
			ZKUpdateUtil.setWindowHeightX(this, 540);
		}
		else
		{
			addCallback(AFTER_PAGE_ATTACHED, t-> {
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
			});
		}
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		this.setSizable(true);
		this.setStyle("position: relative;");
		
		captureDiv = new Div();
		this.appendChild(captureDiv);
		captureDiv.setStyle("position: absolute;");
		if (ClientInfo.maxHeight(539))
			ZKUpdateUtil.setHeight(captureDiv, (ClientInfo.get().desktopHeight-60)+ "px");
		else
			ZKUpdateUtil.setHeight(captureDiv, "480px");
		if (ClientInfo.maxWidth(639))
			ZKUpdateUtil.setWidth(captureDiv, ClientInfo.get().desktopWidth + "px");
		else
			ZKUpdateUtil.setWidth(captureDiv, "640px");
		captureDiv.setVisible(false);
		captureDiv.addEventListener("onCaptureImage", this);
	    cancelCaptureButton = new Button(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Cancel")));
		LayoutUtils.addSclass("txt-btn", cancelCaptureButton);
		cancelCaptureButton.setStyle("position: absolute; bottom: 5px; right: 3px;");
		this.appendChild(cancelCaptureButton);
		cancelCaptureButton.addEventListener(Events.ON_CLICK, this);
		cancelCaptureButton.setVisible(false);
		
		mainLayout.setParent(this);
		ZKUpdateUtil.setHflex(mainLayout, "1");
		ZKUpdateUtil.setVflex(mainLayout, "1");
		
		fileButton.setLabel("Upload");
		LayoutUtils.addSclass("txt-btn", fileButton);
		captureButton.setLabel("Capture");
		LayoutUtils.addSclass("txt-btn", captureButton);
		
		North north = new North();
		north.setParent(mainLayout);
		north.appendChild(parameterPanel);
		
		Hbox hbox = new Hbox();
		hbox.setAlign("center");
		hbox.setPack("start");
		hbox.appendChild(fileButton);
		hbox.appendChild(new Space());
		hbox.appendChild(captureButton);
		hbox.appendChild(new Space());
		hbox.appendChild(fileNameTextbox);
		
		parameterPanel.setStyle("padding: 5px");
		parameterPanel.appendChild(hbox);
		Separator separator = new Separator();
		separator.setOrient("horizontal");
		separator.setBar(true);
		parameterPanel.appendChild(separator);
		
		Center center = new Center();
		center.setSclass("dialog-content");
		ZKUpdateUtil.setHflex(image, "true");
		ZKUpdateUtil.setVflex(image, "true");
		center.setParent(mainLayout);
		image.setSclass("image-fit-contain");
		center.appendChild(image);
		
		South south = new South();
		south.setSclass("dialog-footer");
		south.setParent(mainLayout);
		south.appendChild(confirmPanel);

		//
		fileButton.setUpload(AdempiereWebUI.getUploadSetting());
		fileButton.addEventListener(Events.ON_UPLOAD, this);
		captureButton.addEventListener(Events.ON_CLICK, this);
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		
		addEventListener(Events.ON_UPLOAD, this);
		addEventListener("onSave", this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}   //  init

	public void onEvent(Event e) throws Exception {
		if (e instanceof UploadEvent) 
		{
			UploadEvent ue = (UploadEvent) e;
			processUploadMedia(ue.getMedia());
		}
		else if (e.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			Clients.showBusy(this, Msg.getMsg(Env.getCtx(), "Processing"));
			Events.echoEvent("onSave", this, null);			
		}
		else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
		{
			onCancel();
		}
		else if (e.getTarget().getId().equals(ConfirmPanel.A_RESET))
		{
			AImage img = null;
			image.setContent(img);
			image.setClientAttribute("sandbox", "");
			image.setVisible(true);
			image.invalidate();
			fileNameTextbox.setValue(null);
		}
		else if (e.getTarget() == captureButton)
		{
			captureDiv.setVisible(true);
			cancelCaptureButton.setVisible(true);
			cancelCaptureButton.setEnabled(true);
			mainLayout.setVisible(false);
			String script = "(function(){let wgt = zk.Widget.$('#"+captureDiv.getUuid()+"');";
			script = script + "let cancelBtn=zk.Widget.$('#"+cancelCaptureButton.getUuid()+"');";
			script = script + "jq(wgt).photobooth(); ";
			script = script + "jq(wgt).bind( 'image', function( event, dataUrl ){ cancelBtn.setVisible(false);zAu.send(new zk.Event(wgt, 'onCaptureImage', dataUrl, {toServer:true})); });";
			script = script + "})()";
			Clients.evalJavaScript(script);
		}
		else if (e.getName().equals("onCaptureImage"))
		{
			captureDiv.setVisible(false);
			cancelCaptureButton.setVisible(false);
			mainLayout.setVisible(true);
			String dataUrl = (String) e.getData();
			if (!Util.isEmpty(dataUrl))
			{
				String encodingPrefix = "base64,";
				int contentStartIndex = dataUrl.indexOf(encodingPrefix) + encodingPrefix.length();
				byte[] imageData = Base64.decodeBase64(dataUrl.substring(contentStartIndex).getBytes());
				AImage img = new AImage(defaultNameForCaptureImage, imageData);
				image.setContent(img);
				image.setClientAttribute("sandbox", "");
				image.setVisible(true);
				image.invalidate();
				
				if (m_mImage == null)
					m_mImage = new MImage (Env.getCtx(), 0, null);
				m_mImage.setName(defaultNameForCaptureImage);
				m_mImage.setBinaryData(imageData);
				fileNameTextbox.setValue(defaultNameForCaptureImage);
			}
			String script = "(function(){let wgt = zk.Widget.$('#"+captureDiv.getUuid()+"');";
			script = script + "jq(wgt).data( 'photobooth').destroy();})() ";
			Clients.evalJavaScript(script);
		}
		else if (e.getTarget() == cancelCaptureButton) 
		{
			captureDiv.setVisible(false);
			cancelCaptureButton.setVisible(false);
			mainLayout.setVisible(true);
			String script = "(function(){let wgt = zk.Widget.$('#"+captureDiv.getUuid()+"');";
			script = script + "jq(wgt).data( 'photobooth').destroy();})() ";
			Clients.evalJavaScript(script);
		}
		else if (e.getName().equals("onSave"))
		{
			try {
				onSave();
			} finally {
				Clients.clearBusy(this);
			}
		}
	}

	private void onCancel() {
		cancel = true;
		detach();
	}

	private void onSave() {
		if (image.getContent() != null)
		{
			if (!Util.isEmpty(fileNameTextbox.getValue()))
				m_mImage.setName(fileNameTextbox.getValue());
			m_mImage.saveEx();
		}
		else if (m_mImage != null && m_mImage.getAD_Image_ID() > 0)
		{
			m_mImage.setBinaryData(null);
			m_mImage.setName("-");
			m_mImage.saveEx();
		}
		detach();
	}
	
	/**
	 * @return true if dialog cancel by user
	 */
	public boolean isCancel() {
		return cancel;
	}

	private void processUploadMedia(Media imageFile) {
		if (imageFile == null)
			return;

		String fileName = imageFile.getName();
		String mimeType = MimeType.getMimeType(fileName);
		if (! autoPreviewList.contains(mimeType))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "UploadImageTypeNotAllowed"));

		//  See if we can load & display it
		try
		{
			InputStream is = imageFile.getStreamData();
			AImage aImage = new AImage(fileName, is);

			if (autoPreviewList.contains(mimeType)) {
				image.setContent(aImage);
				image.setClientAttribute("sandbox", "");
				image.setVisible(true);
				image.invalidate();
			} else {
				image.setSrc(null);
				image.setVisible(false);
			}
			
			is.close();
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, "load image", e);
			return;
		}

		//  OK
		fileNameTextbox.setValue(imageFile.getName());
		mainLayout.invalidate();

		//  Save info
		if (m_mImage == null)
			m_mImage = new MImage (Env.getCtx(), 0, null);
		m_mImage.setName(fileName);
		m_mImage.setImageURL(fileName);
		if (image.getContent() != null)
			m_mImage.setBinaryData(image.getContent().getByteData());
		else
			m_mImage.setBinaryData(null);
	}

	/**
	 * 	Get Image ID
	 *	@return ID or 0
	 */
	public int getAD_Image_ID()
	{
		if (m_mImage != null)
			return m_mImage.getAD_Image_ID();
		return 0;
	}	//	getAD_Image_ID	

	/**
	 * @return the defaultNameForCaptureImage
	 */
	public String getDefaultNameForCaptureImage() {
		return defaultNameForCaptureImage;
	}

	/**
	 * @param defaultNameForCaptureImage the defaultNameForCaptureImage to set
	 */
	public void setDefaultNameForCaptureImage(String defaultNameForCaptureImage) {
		this.defaultNameForCaptureImage = defaultNameForCaptureImage;
	}

	@Override
	public void focus() {
		super.focus();
		if (fileButton != null)
			fileButton.focus();
	}	
	
	
}   //  WImageDialog
