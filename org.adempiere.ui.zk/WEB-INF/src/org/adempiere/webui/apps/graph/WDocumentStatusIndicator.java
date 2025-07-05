/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Adaxa                                                             *
* - Ashley Ramdass                                                    *
* - Deepak Pansheriya                                                 *
* - Murilo Ht                                                         *
* - Carlos Ruiz                                                       *
**********************************************************************/

package org.adempiere.webui.apps.graph;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Tab.DecorateInfo;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MDocumentStatus;
import org.compiere.model.MForm;
import org.compiere.model.MQuery;
import org.compiere.print.MPrintColor;
import org.compiere.print.MPrintFont;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;

/**
 * 	Document Status ({@link MDocumentStatus}) Indicator
 */
public class WDocumentStatusIndicator extends Panel implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8017313188530461577L;

	/**
	 * 	Constructor
	 *	@param documentStatus
	 */
	public WDocumentStatusIndicator(MDocumentStatus documentStatus)
	{
		this(documentStatus, false);
	}
	
	/**
	 * 	Constructor
	 *	@param documentStatus
	 *  @param lazy
	 */
	public WDocumentStatusIndicator(MDocumentStatus documentStatus, boolean lazy)
	{
		super();

		m_documentStatus = documentStatus;

		init();
		this.setSclass("activities-box");
		
		if (!lazy) 
		{
			refresh();
			updateUI();
		}
	}	//	WDocumentStatusIndicator

	private MDocumentStatus		m_documentStatus = null;
	private int statusCount;
	private Label nameLabel;
	private Label statusLabel;

	/**
	 * 	Get Document Status
	 *	@return Document Status
	 */
	public MDocumentStatus getDocumentStatus()
	{
		return m_documentStatus;
	}	//	getGoal

    /**
	 * 	Init Document Status Display
	 */
	private void init()
	{
		Div div = new Div();
		appendChild(div);
		nameLabel = new Label();
		nameLabel.setText(m_documentStatus.get_Translation(MDocumentStatus.COLUMNNAME_Name) + ": ");
		nameLabel.setTooltiptext(m_documentStatus.get_Translation(MDocumentStatus.COLUMNNAME_Description));
		div.appendChild(nameLabel);
		statusLabel = new Label();		
		div.appendChild(statusLabel);
		decorateNameLabel();
		decorateStatusLabel();

		String numberColorStyle = "";
		int Number_PrintColor_ID = m_documentStatus.getNumber_PrintColor_ID();
		if (Number_PrintColor_ID > 0) {
			MPrintColor printColor = MPrintColor.get(Env.getCtx(), Number_PrintColor_ID);
			String color = ZkCssHelper.createHexColorString(printColor.getColor());
			numberColorStyle = "color:#"+color+";";
		}
		String numberFontStyle = "";
		int Number_PrintFont_ID = m_documentStatus.getNumber_PrintFont_ID();
		if (Number_PrintFont_ID > 0) {
			MPrintFont printFont = MPrintFont.get(Number_PrintFont_ID);
			String family = printFont.getFont().getFamily();
			boolean bold = printFont.getFont().isBold();
			boolean italic = printFont.getFont().isItalic();
			int pointSize = printFont.getFont().getSize();
			numberFontStyle = "font-family:'"+family+"';font-weight:"+(bold ? "bold" : "normal")+";font-style:"+(italic ? "italic" : "normal")+";font-size:"+pointSize+"pt;";
			int margin = pointSize;
			numberFontStyle += "margin-top:"+margin+"pt;"+"margin-bottom:"+margin+"pt;";
		}
		statusLabel.setStyle(numberColorStyle+numberFontStyle);

		this.addEventListener(Events.ON_CLICK, this);
	}

	/**
	 * Set font and color for Name Label
	 */
	public void decorateNameLabel() {
		decorate(nameLabel, m_documentStatus.getName_PrintFont_ID(), m_documentStatus.getName_PrintColor_ID(), m_documentStatus.getName_PrintColorZero_ID());
	}

	/**
	 * Set font and color for Status label (number)
	 */
	public void decorateStatusLabel() {
		decorate(statusLabel, m_documentStatus.getNumber_PrintFont_ID(), m_documentStatus.getNumber_PrintColor_ID(), 0);
	}

	/**
	 * Set font and color for the label
	 * @param label
	 * @param printFontId
	 * @param printColorId
	 * @param printColorZeroId
	 */
	private void decorate(Label label, int printFontId, int printColorId, int printColorZeroId) {
		String colorStyle = "";
		if (printColorZeroId > 0 && statusCount == 0) {
			MPrintColor printColor = MPrintColor.get(Env.getCtx(), printColorZeroId);
			String color = ZkCssHelper.createHexColorString(printColor.getColor());
			colorStyle = "color:#"+color+";";
		} else if (printColorId > 0) {
			MPrintColor printColor = MPrintColor.get(Env.getCtx(), printColorId);
			String color = ZkCssHelper.createHexColorString(printColor.getColor());
			colorStyle = "color:#"+color+";";
		}
		String nameFontStyle = "";
		if (printFontId > 0) {
			MPrintFont printFont = MPrintFont.get(printFontId);
			String family = printFont.getFont().getFamily();
			boolean bold = printFont.getFont().isBold();
			boolean italic = printFont.getFont().isItalic();
			int pointSize = printFont.getFont().getSize();
			nameFontStyle = "font-family:'"+family+"';font-weight:"+(bold ? "bold" : "normal")+";font-style:"+(italic ? "italic" : "normal")+";font-size:"+pointSize+"pt";
		}
		label.setStyle(colorStyle+nameFontStyle);
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		int AD_Window_ID = m_documentStatus.getAD_Window_ID();
		int AD_Form_ID = m_documentStatus.getAD_Form_ID();
		if (AD_Window_ID > 0)
		{
			MQuery query = new MQuery(m_documentStatus.getAD_Table_ID());
			query.addRestriction(MDocumentStatus.getWhereClause(m_documentStatus));
			AEnv.zoom(AD_Window_ID, query);
		}
		else if ( AD_Form_ID > 0 )
		{
			ADForm form = ADForm.openForm(AD_Form_ID);

			form.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
			form.setAttribute(Window.DECORATE_INFO, DecorateInfo.get(MForm.get(AD_Form_ID)));
			SessionManager.getAppDesktop().showWindow(form);
		}
		
	}

	/**
	 * Load {@link #m_documentStatus}
	 */
	public void refresh() {
		MDocumentStatus refresh_documentStatus = MDocumentStatus.get(Env.getCtx(), m_documentStatus.getPA_DocumentStatus_ID());
		if(refresh_documentStatus != null) {
			m_documentStatus = 	refresh_documentStatus;
		}
		statusCount = MDocumentStatus.evaluate(m_documentStatus);		
	}

	/**
	 * Update UI with data loaded in {@link #refresh()}
	 */
	public void updateUI() {
		statusLabel.setText(Integer.toString(statusCount));		
	}

	/**
	 * Return the count for this indicator
	 * @return status count
	 */
	public int getStatusCount() {
		return statusCount;
	}

}
