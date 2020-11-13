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
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MDocumentStatus;
import org.compiere.model.MQuery;
import org.compiere.print.MPrintColor;
import org.compiere.print.MPrintFont;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;

/**
 * 	Document Status Indicator
 */
public class WDocumentStatusIndicator extends Panel implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 794746556509546913L;

	/**
	 * 	Constructor
	 *	@param goal goal model
	 */
	public WDocumentStatusIndicator(MDocumentStatus documentStatus)
	{
		super();

		m_documentStatus = documentStatus;

		init();
		this.setSclass("activities-box");
		
		refresh();
		updateUI();
	}	//	WDocumentStatusIndicator

	private MDocumentStatus		m_documentStatus = null;
	private int statusCount;
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
	 * 	Init Graph Display
	 */
	private void init()
	{
		Div div = new Div();
		appendChild(div);
		Label nameLabel = new Label();
		nameLabel.setText(m_documentStatus.get_Translation(MDocumentStatus.COLUMNNAME_Name) + ": ");
		String nameColorStyle = "";
		int Name_PrintColor_ID = m_documentStatus.getName_PrintColor_ID();
		if (Name_PrintColor_ID > 0) {
			MPrintColor printColor = MPrintColor.get(Env.getCtx(), Name_PrintColor_ID);
			String color = ZkCssHelper.createHexColorString(printColor.getColor());
			nameColorStyle = "color:#"+color+";";
		}
		int AD_PrintFont_ID = m_documentStatus.getName_PrintFont_ID();
		String nameFontStyle = "";
		if (AD_PrintFont_ID > 0) {
			MPrintFont printFont = MPrintFont.get(AD_PrintFont_ID);
			String family = printFont.getFont().getFamily();
			boolean bold = printFont.getFont().isBold();
			boolean italic = printFont.getFont().isItalic();
			int pointSize = printFont.getFont().getSize();
			nameFontStyle = "font-family:'"+family+"';font-weight:"+(bold ? "bold" : "normal")+";font-style:"+(italic ? "italic" : "normal")+";font-size:"+pointSize+"pt";
		}
		nameLabel.setStyle(nameColorStyle+nameFontStyle);
		div.appendChild(nameLabel);

		statusLabel = new Label();		
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
		div.appendChild(statusLabel);

		this.addEventListener(Events.ON_CLICK, this);
	}


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
			SessionManager.getAppDesktop().showWindow(form);
		}
		
	}

	public void refresh() {
		m_documentStatus.load(m_documentStatus.get_TrxName());
		statusCount = MDocumentStatus.evaluate(m_documentStatus);		
	}

	public void updateUI() {
		statusLabel.setText(Integer.toString(statusCount));		
	}

}
