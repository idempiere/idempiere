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
 *                                                                     *
 **********************************************************************/
package org.idempiere.acct.info;

import org.adempiere.base.acct.info.IElementInfo;
import org.compiere.model.I_C_Element;
import org.compiere.model.PO;
import org.idempiere.acct.model.MElement;

/**
 * Wrapper for {@link MElement} to provide {@link IElementInfo} access.
 * 
 * @author etantg
 */
public class ElementInfo implements IElementInfo {
	
	private final MElement element;
	
	public ElementInfo(MElement element) {
        if (element == null)
            throw new IllegalArgumentException("MElement cannot be null");
        this.element = element;
    }
	
	public MElement getModel() {
		return element;
	}
	
	@Override
	public I_C_Element getRecord() {
		return element;
	}

	@Override
	public PO getPO() {
		return element;
	}
	
	public static IElementInfo wrap(MElement element) {
        if (element == null)
            return null;
        if (element instanceof IElementInfo)
            return (IElementInfo) element;
        return new ElementInfo(element);
    }
	
}
