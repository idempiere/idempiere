package org.compiere.apps.wf;

import java.awt.Point;

import org.netbeans.api.visual.action.MoveStrategy;
import org.netbeans.api.visual.widget.Widget;

public class WFNodeMoveStrategy implements MoveStrategy {

	public Point locationSuggested(Widget widget, Point originalLocation, Point suggestedLocation) {
		return new Point (suggestedLocation.x - suggestedLocation.x % WFGraphLayout.COLUMN_WIDTH ,
				suggestedLocation.y - suggestedLocation.y % WFGraphLayout.ROW_HEIGHT);
	}

}
