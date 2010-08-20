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

	public boolean isJustified() {
		return justify;
	}

	public void setJustified(boolean justify) {
		boolean old = this.justify;
		this.justify = justify;
		if (old != this.justify) {
			repaint();
		}
	}
}