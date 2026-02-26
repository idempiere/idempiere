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

import org.adempiere.base.acct.AcctModelService;
import org.adempiere.base.acct.model.IAcctSchemaGLModel;
import org.adempiere.base.acct.service.IAcctSchemaGLModelService;
import org.idempiere.acct.model.MAcctSchemaGL;
import org.idempiere.base.acct.AcctSchemaGLModel;

/**
 * Implementation of {@link IAcctSchemaGLModelService}.
 * 
 * @author etantg
 */
@AcctModelService(IAcctSchemaGLModelService.class)
public class AcctSchemaGLModelService implements IAcctSchemaGLModelService {

	@Override
	public IAcctSchemaGLModel get(Properties ctx, int C_AcctSchema_ID) {
		MAcctSchemaGL schemaGL = MAcctSchemaGL.get(ctx, C_AcctSchema_ID);
		return AcctSchemaGLModel.wrap(schemaGL);
	}

	@Override
	public IAcctSchemaGLModel create(Properties ctx, int C_AcctSchema_ID, String trxName) {
		MAcctSchemaGL schemaGL = new MAcctSchemaGL(ctx, C_AcctSchema_ID, trxName);
		return AcctSchemaGLModel.wrap(schemaGL);
	}

}
