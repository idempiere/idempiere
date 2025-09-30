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

import java.awt.Graphics2D;
import java.awt.font.LineBreakMeasurer;
import java.awt.font.TextLayout;
import java.awt.geom.Point2D;
import java.text.AttributedCharacterIterator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
	 * generated serial id
	 */
	private static final long serialVersionUID = 4702399095192668527L;

	/**
	 * 	Parameter Element.
	 *  <p>
	 *  Parameter fromValue - toValue
	 *  
	 * 	@param query query
	 *  @param ctx context
	 *  @param tFormat Table Format
	 */
	public ParameterElement(MQuery query, Properties ctx, MPrintTableFormat tFormat)
	{
		super (query.getReportProcessQuery() != null ? query.getReportProcessQuery().getRestrictionCount() : query.getRestrictionCount(), 4);
		setData (0, 0, Msg.getMsg(ctx, "Parameter") + ":", tFormat.getPageHeader_Font(), tFormat.getPageHeaderFG_Color());
		if (query.getReportProcessQuery() != null)
			query = query.getReportProcessQuery();
		for (int r = 0; r < query.getRestrictionCount(); r++)
		{
			setData (r, 1, query.getInfoName(r), tFormat.getParameter_Font(), tFormat.getParameter_Color());
			setData (r, 2, query.getInfoOperator(r), tFormat.getParameter_Font(), tFormat.getParameter_Color());
			setData (r, 3, query.getInfoDisplayAll(r), tFormat.getParameter_Font(), tFormat.getParameter_Color());
		}
	}	//	ParameterElement

	/** Row:List<TextLayout> for parameter value text column */
	private Map<Integer, List<TextLayout>> valueTextLayoutMap = new HashMap<Integer, List<TextLayout>>();
	
	/**
	 * Fit parameter text to page width
	 * @param pageWidth
	 */
	public void fitToPage(int pageWidth) {
		//label + parameter name + operator
		int offsetWidth = m_colWidth[0] + m_colGap + m_colWidth[1] + m_colGap + m_colWidth[2];		
		int maxWidth = pageWidth - offsetWidth;
		for (int row = 0; row < m_rows; row++) {
			int height = 0;
			AttributedCharacterIterator iter = m_iterator[row][3];
			if (iter == null)
				continue;
			LineBreakMeasurer measurer = new LineBreakMeasurer(iter, m_frc);
			while (measurer.getPosition() < iter.getEndIndex()) {
				TextLayout layout = measurer.nextLayout(maxWidth);
				List<TextLayout> layouts = valueTextLayoutMap.get(row);
				if (layouts == null) {
					layouts = new ArrayList<TextLayout>();
					valueTextLayoutMap.put(row, layouts);					
				}
				height = height + ((int)(layout.getAscent() + layout.getDescent() + layout.getLeading())+1);
				layouts.add(layout);
			}
			if (m_rowHeight[row] < height)
				m_rowHeight[row] = height;
		}
		calculateSize();
	}
	
	/**
	 * 	Paint it
	 * 	@param g2D Graphics
	 *  @param pageNo page number for multi page support (0 = header/footer) - ignored
	 *  @param pageStart top left Location of page
	 *  @param ctx print context
	 *  @param isView true if online view (IDs are links)
	 */
	@Override
	public void paint(Graphics2D g2D, int pageNo, Point2D pageStart, Properties ctx, boolean isView)
	{
		//fall back to GridElement paint if fitToPage(int pageWidth) is not call
		if (valueTextLayoutMap.isEmpty()) 
		{
			super.paint(g2D, pageNo, pageStart, ctx, isView);
			return;
		}
		
		Point2D.Double location = getAbsoluteLocation(pageStart);
		float y = (float)location.y;
		//
		for (int row = 0; row < m_rows; row++)
		{
			float x = (float)location.x;
			for (int col = 0; col < m_cols; col++)
			{
				//use valueTextLayoutMap for parameter value text column
				if (col == 3 && valueTextLayoutMap.get(row) != null)
				{
					List<TextLayout> layouts = valueTextLayoutMap.get(row);
					float curY = y;
					for(TextLayout layout : layouts)
					{
						curY = curY + layout.getAscent();
						layout.draw(g2D, x, curY);
						curY += m_rowGap;
					}
				}
				else
				{
					if (m_textLayout[row][col] != null)
					{
						float yy = y + m_textLayout[row][col].getAscent();
						m_textLayout[row][col].draw(g2D, x, yy);
					}
					x += m_colWidth[col];
					if (m_colWidth[col] > 0)
						x += m_colGap;
				}
			}
			y += m_rowHeight[row];
			if (m_rowHeight[row] > 0)
				y += m_rowGap;
		}
	}	//	paint
}	//	ParameterElement

