/******************************************************************************
 * Project: Trek Global ERP                                                   *                       
 * Copyright (C) 2009-2018 Trek Global Corporation                            *
 *                                                                            *
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
package org.idempiere.print;

import java.awt.Color;
import java.awt.Font;
import java.awt.Point;
import java.awt.Rectangle;
import java.text.SimpleDateFormat;

import org.compiere.model.MClientInfo;
import org.compiere.model.MQuery;
import org.compiere.model.MSysConfig;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.MPrintTableFormat;
import org.compiere.print.layout.HeaderFooter;
import org.compiere.print.layout.ImageElement;
import org.compiere.print.layout.PrintElement;
import org.compiere.print.layout.StringElement;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * 
 * @author hengsin
 *
 */
public class StandardHeaderFooter implements IPrintHeaderFooter {

	/**************************************************************************
	 *	Create Standard Header/Footer
	 *  <pre>{@code
	 *  title           C        Page x of x
	 *  Copyright      who         date&time
	 *  }</pre>
	 */
	@Override
	public void createHeaderFooter(MPrintFormat m_format, HeaderFooter m_headerFooter, Rectangle m_header, Rectangle m_footer, MQuery m_query)
	{
		MClientInfo ci = MClientInfo.get(Env.getCtx());
		PrintElement element = null;
		if (ci.getLogoReport_ID() > 0) {
			element = new ImageElement(ci.getLogoReport_ID(), false);
		} else {
			element = new ImageElement(org.compiere.Adempiere.getHeaderLogo());
		}
		element.layout(48, 15, false, MPrintFormatItem.FIELDALIGNMENTTYPE_LeadingLeft);
		element.setLocation(m_header.getLocation());
		m_headerFooter.addElement(element);
		//
		MPrintTableFormat tf = m_format.getTableFormat();
		Font font = tf.getPageHeader_Font();
		Color color = tf.getPageHeaderFG_Color();
		//
		element = new StringElement("@*ReportName@", font, color, null, true);
		element.layout (m_header.width, 0, true, MPrintFormatItem.FIELDALIGNMENTTYPE_Center);
		element.setLocation(m_header.getLocation());
		m_headerFooter.addElement(element);
		//
		//
		element = new StringElement("@Page@ @*Page@ @of@ @*PageCount@", font, color, null, true);
		element.layout (m_header.width, 0, true, MPrintFormatItem.FIELDALIGNMENTTYPE_TrailingRight);
		element.setLocation(m_header.getLocation());
		m_headerFooter.addElement(element);
		
		//	Footer
		font = tf.getPageFooter_Font();
		color = tf.getPageFooterFG_Color();
		//
		element = new StringElement(Env.getStandardReportFooterTrademarkText(), font, color, null, true);
		element.layout (m_footer.width, 0, true, MPrintFormatItem.FIELDALIGNMENTTYPE_LeadingLeft);
		Point ft = m_footer.getLocation();
		ft.y += m_footer.height - element.getHeight() - 2;	//	2pt above min
		element.setLocation(ft);
		m_headerFooter.addElement(element);
		//
		String s = MSysConfig.getValue(MSysConfig.ZK_FOOTER_SERVER_MSG, "", Env.getAD_Client_ID(Env.getCtx()));
		if (Util.isEmpty(s, true))
			s = "@*Header@";
		element = new StringElement(s, font, color, null, true);
		element.layout (m_footer.width, 0, true, MPrintFormatItem.FIELDALIGNMENTTYPE_Center);
		element.setLocation(ft);
		m_headerFooter.addElement(element);
		//
		String timestamp = "";
		s = MSysConfig.getValue(MSysConfig.ZK_FOOTER_SERVER_DATETIME_FORMAT, Env.getAD_Client_ID(Env.getCtx()));
		if (!Util.isEmpty(s, true))
			timestamp = new SimpleDateFormat(s).format(System.currentTimeMillis());
		else
			timestamp = "@*CurrentDateTime@";
		element = new StringElement(timestamp, font, color, null, true);
		element.layout (m_footer.width, 0, true, MPrintFormatItem.FIELDALIGNMENTTYPE_TrailingRight);
		element.setLocation(ft);
		m_headerFooter.addElement(element);
	}

	@Override
	public int getHeaderHeight() {
		return 18;
	}

	@Override
	public int getFooterHeight() {
		return 18;
	}
}
