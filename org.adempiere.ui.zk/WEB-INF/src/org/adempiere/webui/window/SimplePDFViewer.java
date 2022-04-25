/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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
package org.adempiere.webui.window;

import java.io.InputStream;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.ext.render.DynamicMedia;
import org.zkoss.zul.Iframe;
import org.zkoss.zul.impl.Utils;
import org.zkoss.zul.impl.XulElement;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class SimplePDFViewer extends Window {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6417954023873414350L;
	private AMedia media;
	private int mediaVersion = 0;

	public SimplePDFViewer(String title, InputStream pdfInput) {
		Iframe iframe = new Iframe();
		iframe.setId("reportFrame");
		int height = 0;
		if (ClientInfo.maxHeight((ClientInfo.SMALL_HEIGHT + ClientInfo.EXTRA_SMALL_HEIGHT)/2)) {
			height = ClientInfo.get().desktopHeight;
		} else {
			height = Double.valueOf(ClientInfo.get().desktopHeight * 0.85).intValue();			
		}
		ZKUpdateUtil.setHeight(this, height + "px");
		height = height - 30;
		ZKUpdateUtil.setHeight(iframe, height + "px");
		ZKUpdateUtil.setWidth(iframe, "100%");
		media = new AMedia(getTitle(), "pdf", "application/pdf", pdfInput);
		if (ClientInfo.isMobile() || MSysConfig.getBooleanValue(MSysConfig.ZK_USE_PDF_JS_VIEWER, false, Env.getAD_Client_ID(Env.getCtx()))) {
			if (getPage() != null) {
				showMobileViewer(iframe);
			} else {
				addCallback(AFTER_PAGE_ATTACHED, t -> showMobileViewer(iframe));
			}
		} else {
			iframe.setContent(media);
		}
		
		this.setBorder("normal");
		this.appendChild(iframe);
		this.setClosable(true);
		this.setMaximizable(true);
		if (title != null && title.trim().length() > 0)
			this.setTitle(title);
		else
			this.setTitle(Msg.translate(Env.getCtx(), "PDF"));
		
		int width = 0;
		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1)) {
			width = ClientInfo.get().desktopWidth;
		} else {
			width = Double.valueOf(ClientInfo.get().desktopWidth * 0.80).intValue();
		}
		ZKUpdateUtil.setWidth(this, width + "px");
	}

	protected void showMobileViewer(Iframe iframe) {
		mediaVersion++;
		String url = Utils.getDynamicMediaURI(this, mediaVersion, media.getName(), media.getFormat());	
		String pdfJsUrl = "pdf.js/web/viewer.html?file="+url;
		iframe.setSrc(pdfJsUrl);
	}
	
	//-- ComponentCtrl --//
	public Object getExtraCtrl() {
		return new ExtraCtrl();
	}
	/** A utility class to implement {@link #getExtraCtrl}.
	 * It is used only by component developers.
	 */
	protected class ExtraCtrl extends XulElement.ExtraCtrl
	implements DynamicMedia {
		//-- DynamicMedia --//
		public Media getMedia(String pathInfo) {
			return media;
		}
	}
}
