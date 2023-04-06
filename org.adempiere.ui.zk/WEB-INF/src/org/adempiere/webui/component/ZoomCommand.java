/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.component;

import java.util.Map;

import org.adempiere.webui.event.ZoomEvent;
import org.compiere.model.MQuery;
import org.compiere.model.MWindow;
import org.compiere.util.Env;
import org.zkoss.json.JSONArray;
import org.zkoss.lang.Objects;
import org.zkoss.zk.au.AuRequest;
import org.zkoss.zk.au.AuService;
import org.zkoss.zk.mesg.MZk;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.Events;

/**
 * {@link Desktop} listener for onZoom {@link AuRequest}.<br/>
 * Create {@link ZoomEvent} from {@link AuRequest} and post to the component that send the {@link AuRequest}.
 * @author hengsin
 *
 */
public class ZoomCommand implements AuService {

	public ZoomCommand() {
	}

	@Override
	public boolean service(AuRequest request, boolean everError) {
		if (!ZoomEvent.EVENT_NAME.equals(request.getCommand()))
			return false;

		Map<?, ?> map = request.getData();
		JSONArray data = (JSONArray) map.get("data");
		
		final Component comp = request.getComponent();
		if (comp == null)
			throw new UiException(MZk.ILLEGAL_REQUEST_COMPONENT_REQUIRED, this);
		
		if (data == null || data.size() < 2)
			throw new UiException(MZk.ILLEGAL_REQUEST_WRONG_DATA, new Object[] {
					Objects.toString(data), this });
		
		String columnName = (String) data.get(0);
		String tableName = MQuery.getZoomTableName(columnName);
		Object code = null; 
		int windowID = 0;
		if (columnName.endsWith("_ID"))
		{
			try {
				code = Integer.parseInt((String) data.get(1));
			} catch (Exception e) {
				code = data.get(1);
			}
		}
		else
		{
			code = data.get(1);
		}

		if (   data.size() > 3 && data.get(3) != null
			&& data.get(2) != null && data.get(2).toString().equalsIgnoreCase("AD_Window_UU"))
		{
			String windowUU = (String) data.get(3);
			MWindow window = MWindow.get(Env.getCtx(), windowUU);
			if (window != null)
				windowID = window.getAD_Window_ID();
		}
		//
		MQuery query = new MQuery(tableName);
		query.addRestriction(columnName, MQuery.EQUAL, code);
		query.setRecordCount(1);
		query.setZoomTableName(tableName);
		query.setZoomColumnName(columnName);
		query.setZoomValue(code);
		query.setZoomWindowID(windowID);

		Events.postEvent(new ZoomEvent(comp, query));

		return true;
	}

}
