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
package org.idempiere.acct.service;

import java.util.Properties;

import org.adempiere.base.acct.AcctInfoService;
import org.adempiere.base.acct.info.IGLCategoryInfo;
import org.adempiere.base.acct.service.IGLCategoryInfoService;
import org.idempiere.acct.info.GLCategoryInfo;
import org.idempiere.acct.model.MGLCategory;

/**
 * Implementation of {@link IGLCategoryInfoService}.
 * 
 * @author etantg
 */
@AcctInfoService(IGLCategoryInfoService.class)
public class GLCategoryInfoService implements IGLCategoryInfoService {
	
	@Override
	public IGLCategoryInfo get(Properties ctx, int GL_Category_ID) {
		MGLCategory category = MGLCategory.get(ctx, GL_Category_ID);
		return GLCategoryInfo.wrap(category);
	}

	@Override
	public IGLCategoryInfo getDefaultSystem(Properties ctx) {
		MGLCategory category = MGLCategory.getDefaultSystem(ctx);
		return GLCategoryInfo.wrap(category);
	}
	
	@Override
	public IGLCategoryInfo create(Properties ctx, int GL_Category_ID, String trxName) {
		MGLCategory category = new MGLCategory(ctx, GL_Category_ID, trxName);
		return GLCategoryInfo.wrap(category);
	}

}
