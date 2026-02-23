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

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.adempiere.base.acct.info.IElementValueInfo;
import org.adempiere.base.acct.info.IImportElementValueInfo;
import org.compiere.model.I_C_ElementValue;
import org.compiere.model.PO;
import org.idempiere.acct.model.MElementValue;

/**
 * Wrapper for {@link MElementValue} to provide {@link IElementValueInfo} access.
 * 
 * @author etantg
 */
public class ElementValueInfo implements IElementValueInfo {
	
	private final MElementValue elementValue;
	
	public ElementValueInfo(MElementValue elementValue) {
        if (elementValue == null)
            throw new IllegalArgumentException("MElementValue cannot be null");
        this.elementValue = elementValue;
    }
	
	public MElementValue getModel() {
		return elementValue;
	}
	
	@Override
	public I_C_ElementValue getRecord() {
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
	public void set(IImportElementValueInfo imp) {
		if (imp instanceof ImportElementValueInfo) {
			elementValue.set(((ImportElementValueInfo) imp).getModel());
			return;
		}
		throw new IllegalArgumentException("Unsupported IImportElementValueInfo implementation");
	}
	
	public static IElementValueInfo wrap(MElementValue elementValue) {
        if (elementValue == null)
            return null;
        if (elementValue instanceof IElementValueInfo)
            return (IElementValueInfo) elementValue;
        return new ElementValueInfo(elementValue);
    }
	
	public static List<IElementValueInfo> wrapList(List<MElementValue> list) {
	    return list == null
	    		? new ArrayList<>()
	            : list.stream()
	            	.map(ElementValueInfo::wrap)
	            	.collect(Collectors.toList());
	}
	
}
