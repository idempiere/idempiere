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

import org.adempiere.base.acct.info.IGLCategoryInfo;
import org.compiere.model.I_GL_Category;
import org.compiere.model.PO;
import org.idempiere.acct.model.MGLCategory;

/**
 * Wrapper for {@link MGLCategory} to provide {@link IGLCategoryInfo} access.
 * 
 * @author etantg
 */
public class GLCategoryInfo implements IGLCategoryInfo {
	
	private final MGLCategory category;
	
	public GLCategoryInfo(MGLCategory category) {
        if (category == null)
            throw new IllegalArgumentException("MGLCategory cannot be null");
        this.category = category;
    }
	
	public MGLCategory getModel() {
		return category;
	}

	@Override
	public I_GL_Category getRecord() {
		return category;
	}

	@Override
	public PO getPO() {
		return category;
	}

	public static IGLCategoryInfo wrap(MGLCategory category) {
        if (category == null)
            return null;
        if (category instanceof IGLCategoryInfo)
            return (IGLCategoryInfo) category;
        return new GLCategoryInfo(category);
    }
}
