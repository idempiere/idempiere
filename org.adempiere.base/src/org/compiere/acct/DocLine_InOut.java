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
 * - etantg                         								   *
 **********************************************************************/
package org.compiere.acct;

import org.compiere.model.MInOutLine;
import org.compiere.model.PO;

/**
 * @author etantg
 */
public class DocLine_InOut extends DocLine 
{
	/**
	 * Constructor
	 * @param po line persistent object
	 * @param doc header
	 */
	public DocLine_InOut(PO po, Doc doc) 
	{
		super(po, doc);
	}
	
	@Override
	public int getC_Currency_ID()
	{
		MInOutLine iol = (MInOutLine) getPO();
		if (iol.getC_OrderLine_ID() > 0)
			return iol.getC_OrderLine().getC_Currency_ID();
		else if (iol.getM_RMALine_ID() > 0) {
			if (iol.getM_RMALine().getM_InOutLine_ID() > 0) {
				if (iol.getM_RMALine().getM_InOutLine().getC_OrderLine_ID() > 0)
					return iol.getM_RMALine().getM_InOutLine().getC_OrderLine().getC_Currency_ID();
			}
		}
		return super.getC_Currency_ID();
	}
	
	@Override
	public int getC_ConversionType_ID()
	{
		MInOutLine iol = (MInOutLine) getPO();
		if (iol.getC_OrderLine_ID() > 0)
			return iol.getC_OrderLine().getC_Order().getC_ConversionType_ID();
		else if (iol.getM_RMALine_ID() > 0) {
			if (iol.getM_RMALine().getM_InOutLine_ID() > 0) {
				if (iol.getM_RMALine().getM_InOutLine().getC_OrderLine_ID() > 0)
					return iol.getM_RMALine().getM_InOutLine().getC_OrderLine().getC_Order().getC_ConversionType_ID();
			}
		}
		return super.getC_ConversionType_ID();
	}

}
