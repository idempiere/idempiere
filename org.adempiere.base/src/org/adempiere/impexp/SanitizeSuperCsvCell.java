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
 * Contributors:                                                       *
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.adempiere.impexp;

import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.supercsv.cellprocessor.CellProcessorAdaptor;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.util.CsvContext;

/**
 * CellProcessor to sanitize CSV values and prevent CSV Injection attacks.
 * Prefixes cells starting with dangerous characters (=, +, -, @) with a space.
 */
public class SanitizeSuperCsvCell extends CellProcessorAdaptor {

	public SanitizeSuperCsvCell() {
		super();
	}

	public SanitizeSuperCsvCell(CellProcessor next) {
		super(next);
	}

	@Override
	public <T> T execute(Object value, CsvContext context) {
		if (   value instanceof String
			&& MSysConfig.getBooleanValue(MSysConfig.CSV_EXPORT_SANITIZATION, true, Env.getAD_Client_ID(Env.getCtx())))
			return next.execute(Util.sanitizeCsvValue(value.toString()), context);
		return next.execute(value, context);
	}

}
