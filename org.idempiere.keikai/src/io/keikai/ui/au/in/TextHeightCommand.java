/* CellFetchCommand.java

{{IS_NOTE
	Purpose:
		
	Description:
		
	History:
		January 10, 2008 03:10:40 PM , Created by Dennis.Chen
}}IS_NOTE

Copyright (C) 2007 Potix Corporation. All Rights Reserved.

{{IS_RIGHT
	This program is distributed under Lesser GPL Version 2.1 in the hope that
	it will be useful, but WITHOUT ANY WARRANTY.
}}IS_RIGHT
*/
package io.keikai.ui.au.in;


import java.util.Map;

import io.keikai.api.model.Sheet;
import io.keikai.model.impl.AbstractCellAdv;
import io.keikai.ui.Spreadsheet;
import org.zkoss.lang.Objects;
import org.zkoss.zk.au.AuRequest;
import org.zkoss.zk.mesg.MZk;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.UiException;

/**
 * A Command (client to server) for fetch data back
 * @author Dennis.Chen
 *
 */
public class TextHeightCommand extends AbstractCommand implements Command {
	public final static String Command = "onZSSTextHeight";

	//-- super --//
	public void process(AuRequest request) {
		final Component comp = request.getComponent();
		if (comp == null)
			throw new UiException(MZk.ILLEGAL_REQUEST_COMPONENT_REQUIRED, TextHeightCommand.class.getCanonicalName());

		final Map<?, ?> data = (Map<?, ?>) request.getData();
		if (data == null || data.size() != 4)
			throw new UiException(MZk.ILLEGAL_REQUEST_WRONG_DATA, new Object[] {Objects.toString(data), TextHeightCommand.class.getCanonicalName() });
		
		String sheetId = (String) data.get("sheetId");
		Sheet sheet = ((Spreadsheet) comp).getSelectedSheet();
		if (!getSheetUuid(sheet).equals(sheetId))
			return;
		
		int row = 0;
		Object obj = data.get("row");
		if (obj instanceof Number)
			row = ((Number) obj).intValue();
		
		int col = 0;
		obj = data.get("col");
		if (obj instanceof Number)
			col = ((Number) obj).intValue();
		
		int height = 0;
		obj = data.get("height");
		if (obj instanceof Number)
			height = ((Number) obj).intValue();
		
		((AbstractCellAdv)sheet.getInternalSheet().getCell(row, col)).setTextHeight(height);
	}
}