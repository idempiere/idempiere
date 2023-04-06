/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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

import org.adempiere.webui.AdempiereWebUI;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 * Composite component of textbox and file upload button.
 * @author Low Heng Sin
 *
 */
public class FilenameBox extends EditorBox
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3438731624652907300L;

	/**
	 * Default constructor
	 */
	public FilenameBox()
    {
        super();
        btn.setUpload(AdempiereWebUI.getUploadSetting());
    }

	/**
	 * @param fileName
	 */
    public FilenameBox(String fileName)
    {
        super();
        setText(fileName);
        btn.setUpload(AdempiereWebUI.getUploadSetting());
    }

	/**
	 * If evtnm is ON_UPLOAD, add listener to button.<br/>
	 * {@inheritDoc}
	 */
	@Override
	public boolean addEventListener(String evtnm, EventListener<?> listener) {
		if (Events.ON_UPLOAD.equals(evtnm)) {
			return btn.addEventListener(evtnm, listener);
		} else {
			return super.addEventListener(evtnm, listener);
		}
	}
}