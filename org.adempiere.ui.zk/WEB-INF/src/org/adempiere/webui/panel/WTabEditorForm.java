/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

package org.adempiere.webui.panel;

import org.adempiere.webui.apps.form.WTabEditor;

@org.idempiere.ui.zk.annotation.Form
public class WTabEditorForm extends ADForm
{
	/**
	 *
	 */
	private static final long serialVersionUID = -2533099650671242190L;

	private WTabEditor te;

	public WTabEditorForm(WTabEditor wTabEditor) {
		te = wTabEditor;
	}

	@Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}

	@Override
	public boolean setVisible(boolean visible) {
		 boolean ok = super.setVisible(visible);
		 if (visible && getProcessInfo() != null)
			 te.initForm();
		 return ok;
	}

	@Override
	protected void initForm() {
	}

}
