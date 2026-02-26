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
package org.idempiere.base.acct;

import org.adempiere.base.acct.model.IElementModel;
import org.compiere.model.I_C_Element;
import org.compiere.model.PO;
import org.idempiere.acct.model.MElement;

/**
 * Wrapper for {@link MElement} to provide {@link IElementModel} access.
 * 
 * @author etantg
 */
public class ElementModel implements IElementModel {
	
	private final MElement element;
	
	public ElementModel(MElement element) {
        if (element == null)
            throw new IllegalArgumentException("MElement cannot be null");
        this.element = element;
    }
	
	public MElement getModel() {
		return element;
	}
	
	@Override
	public I_C_Element getElement() {
		return element;
	}

	@Override
	public PO getPO() {
		return element;
	}
	
	public static IElementModel wrap(MElement element) {
        if (element == null)
            return null;
        if (element instanceof IElementModel)
            return (IElementModel) element;
        return new ElementModel(element);
    }
	
}
