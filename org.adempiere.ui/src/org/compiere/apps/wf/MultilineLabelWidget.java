/***********************************************************************
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
 **********************************************************************/
package org.compiere.apps.wf;

import java.awt.Graphics2D;
import java.awt.Insets;
import java.awt.Rectangle;
import java.awt.font.LineBreakMeasurer;
import java.awt.font.TextAttribute;
import java.awt.font.TextLayout;
import java.text.AttributedCharacterIterator;
import java.text.AttributedString;

import org.netbeans.api.visual.widget.LabelWidget;
import org.netbeans.api.visual.widget.Scene;

/**
 * Multiple lines text box
 */
public class MultilineLabelWidget extends LabelWidget {
	private boolean justify;

	public MultilineLabelWidget(Scene scene, String label) {
		super(scene);
		this.setLabel(label);
		this.setJustified(true);
	}

	@Override
	protected void paintWidget() {
		paintOrGetSize(this.getGraphics());
	}

	private void paintOrGetSize(Graphics2D gr) {
		float width = (float) (this.getBounds() != null ? this.getBounds()
				.getWidth() : this.getPreferredSize().getWidth());
		Insets insets = this.getBorder().getInsets();
		float rwidth = width - (insets.left + insets.right);// + margin.left +
															// margin.right;
		Rectangle rec = this.calculateClientArea();
		gr.setFont(getFont());

		float x = 0.0F;// + margin.left;
		float y = (float) rec.getY();// + margin.top;

		if (rwidth > 0 && this.getLabel() != null
				&& this.getLabel().length() > 0) {
			AttributedString as = new AttributedString(this.getLabel());
			as.addAttribute(TextAttribute.FONT, getFont());
			AttributedCharacterIterator aci = as.getIterator();
			LineBreakMeasurer lbm = new LineBreakMeasurer(aci, gr
					.getFontRenderContext());

			while (lbm.getPosition() < aci.getEndIndex()) {
				TextLayout textLayout = lbm.nextLayout(rwidth);
				if (gr != null && isJustified()
						&& textLayout.getVisibleAdvance() > 0.80 * rwidth) {
					textLayout = textLayout.getJustifiedLayout(rwidth);
				}
				if (gr != null) {
					textLayout.draw(gr, x, y + textLayout.getAscent());
				}
				y += textLayout.getDescent() + textLayout.getLeading()
						+ textLayout.getAscent();

			}
		}
	}

	/**
	 * Is text layout fully justified
	 * @return true if text layout is fully justified
	 */
	public boolean isJustified() {
		return justify;
	}

	/**
	 * Set whether text layout is fully justified
	 * @param justify
	 */
	public void setJustified(boolean justify) {
		boolean old = this.justify;
		this.justify = justify;
		if (old != this.justify) {
			repaint();
		}
	}
}