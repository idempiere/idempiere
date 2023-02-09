/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.webui.adwindow;

import org.zkoss.zul.A;

/**
 * Link component for {@link BreadCrumb}
 * @author hengsin
 */
public class BreadCrumbLink extends A {
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 170361731431877695L;
	
	/** id for path (tab index) **/
	private String pathId;

	/**
	 * @return path id
	 */
	public String getPathId() {
		return pathId;
	}

	/**
	 * @param pathId
	 */
	public void setPathId(String pathId) {
		this.pathId = pathId;
	}

}
