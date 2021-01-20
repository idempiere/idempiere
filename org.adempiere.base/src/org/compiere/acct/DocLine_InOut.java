/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.acct;

import org.compiere.model.MInOutLine;
import org.compiere.model.PO;

public class DocLine_InOut extends DocLine 
{
	public DocLine_InOut(PO po, Doc doc) 
	{
		super(po, doc);
	}
	
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
