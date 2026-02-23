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

import org.adempiere.base.acct.info.IImportElementValueInfo;
import org.compiere.model.I_I_ElementValue;
import org.compiere.model.PO;
import org.idempiere.acct.model.X_I_ElementValue;

/**
 * Wrapper for {@link X_I_ElementValue} to provide {@link IImportElementValueInfo} access.
 * 
 * @author etantg
 */
public class ImportElementValueInfo implements IImportElementValueInfo {
	
	private final X_I_ElementValue elementValue;
	
	public ImportElementValueInfo(X_I_ElementValue elementValue) {
        if (elementValue == null)
            throw new IllegalArgumentException("X_I_ElementValue cannot be null");
        this.elementValue = elementValue;
    }
	
	public X_I_ElementValue getModel() {
		return elementValue;
	}

	@Override
	public I_I_ElementValue getRecord() {
		return elementValue;
	}

	@Override
	public PO getPO() {
		return elementValue;
	}
	
	public static IImportElementValueInfo wrap(X_I_ElementValue elementValue) {
        if (elementValue == null)
            return null;
        if (elementValue instanceof IImportElementValueInfo)
            return (IImportElementValueInfo) elementValue;
        return new ImportElementValueInfo(elementValue);
    }
	
}
