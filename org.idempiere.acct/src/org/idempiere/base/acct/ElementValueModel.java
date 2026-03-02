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

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.adempiere.base.acct.model.IElementValueModel;
import org.adempiere.base.acct.model.IImportElementValueModel;
import org.compiere.model.I_C_ElementValue;
import org.compiere.model.PO;
import org.idempiere.acct.model.MElementValue;

/**
 * Wrapper for {@link MElementValue} to provide {@link IElementValueModel} access.
 * 
 * @author etantg
 */
public class ElementValueModel implements IElementValueModel {
	
	private final MElementValue elementValue;
	
	public ElementValueModel(MElementValue elementValue) {
        if (elementValue == null)
            throw new IllegalArgumentException("MElementValue cannot be null");
        this.elementValue = elementValue;
    }
	
	public MElementValue getModel() {
		return elementValue;
	}
	
	@Override
	public I_C_ElementValue getElementValue() {
		return elementValue;
	}

	@Override
	public PO getPO() {
		return elementValue;
	}
	
	@Override
	public boolean isBalanceSheet() {
		return elementValue.isBalanceSheet();
	}

	@Override
	public void set(IImportElementValueModel imp) {
		if (imp instanceof ImportElementValueModel) {
			elementValue.set(((ImportElementValueModel) imp).getModel());
			return;
		}
		throw new IllegalArgumentException("Unsupported IImportElementValueModel implementation");
	}
	
	public static IElementValueModel wrap(MElementValue elementValue) {
        if (elementValue == null)
            return null;
        if (elementValue instanceof IElementValueModel)
            return (IElementValueModel) elementValue;
        return new ElementValueModel(elementValue);
    }
	
	public static List<IElementValueModel> wrapList(List<MElementValue> list) {
	    return list == null
	    		? new ArrayList<>()
	            : list.stream()
	            	.map(ElementValueModel::wrap)
	            	.collect(Collectors.toList());
	}
	
}
