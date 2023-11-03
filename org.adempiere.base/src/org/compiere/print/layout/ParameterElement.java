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
package org.compiere.print.layout;

import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MQuery;
import org.compiere.print.MPrintTableFormat;
import org.compiere.util.Msg;

/**
 *	Parameter Table
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ParameterElement.java,v 1.2 2006/07/30 00:53:02 jjanke Exp $
 */
public class ParameterElement extends GridElement
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4702399095192668527L;

	
	public ParameterElement(int lines,int cols)
	{
		super (lines, cols);
	}
	
	
	public static ParameterElement getParameterElement(MQuery query, Properties ctx, MPrintTableFormat tFormat,int m_maxWidth) {

		String title = Msg.getMsg(ctx, "Parameter") + ":";
		if (query.getReportProcessQuery() != null)
			query = query.getReportProcessQuery();
		int maxWidth = m_maxWidth; 
		
        BufferedImage img = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
        Graphics g = img.getGraphics();
        g.setFont(tFormat.getFunct_Font());
        FontMetrics fontMetrics = g.getFontMetrics();
        
        maxWidth-=fontMetrics.stringWidth(title);
        int charWidth = fontMetrics.stringWidth("W"); 
	    int maxChars = maxWidth / charWidth;
        
       
	    List<String> lines = new ArrayList<>();
        
		for (int r = 0; r < query.getRestrictionCount(); r++)
		{
			String valueParameter = query.getInfoName(r)+" "+query.getInfoOperator(r)+" "+query.getInfoDisplay(r);
			lines.addAll(createLine(valueParameter,maxChars));
			
		}
		ParameterElement parameter = new ParameterElement(lines.size(),2);
		parameter.setData (0, 0,title , tFormat.getPageHeader_Font(), tFormat.getPageHeaderFG_Color());
		for(int i = 0;i<lines.size();i++) {
			parameter.setData(i,1,lines.get(i), tFormat.getParameter_Font(), tFormat.getParameter_Color());
		}
		
		return parameter;
	}
	
	private static List<String> createLine(String value,int maxChars)
	{
		List<String> lines = new ArrayList<>();
		int index = 0;
		while(index < value.length()) {
			lines.add(value.substring(index,Math.min(index+maxChars,value.length())));
			index+=maxChars;
		}
		
		return lines;
		
	}
}	//	ParameterElement

