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
 * - Diego Ruiz - BX Service                                           *
 **********************************************************************/
package org.idempiere.test.model;

import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.base.DefaultTaxLookup;
import org.adempiere.base.ITaxLookup;
import org.osgi.service.component.annotations.Component;

// test case copied from bxservice/de.bxservice.europeantaxprovider plugin
@Component(immediate = true, service = {ITaxLookup.class})
public class MTaxTest_TaxLookup extends DefaultTaxLookup {

	@Override
	public int get(Properties ctx, int C_TaxCategory_ID, boolean IsSOTrx, Timestamp shipDate, int shipFromC_Location_ID,
			int shipToC_Location_ID, int dropshipToC_Location_ID, Timestamp billDate, int billFromC_Location_ID, int billToC_Location_ID,
			String trxName) {
		if (IsSOTrx) {
			billToC_Location_ID = shipToC_Location_ID; 
		} else {
			if (dropshipToC_Location_ID > 0 && dropshipToC_Location_ID != shipToC_Location_ID)
				billToC_Location_ID = dropshipToC_Location_ID;
			billFromC_Location_ID = shipFromC_Location_ID;
		}

		return super.get(ctx, C_TaxCategory_ID, IsSOTrx, shipDate, shipFromC_Location_ID, shipToC_Location_ID, billDate, billFromC_Location_ID, billToC_Location_ID, trxName);
	}

}
