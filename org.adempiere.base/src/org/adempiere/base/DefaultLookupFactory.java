/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import org.compiere.model.GridFieldVO;
import org.compiere.model.Lookup;
import org.compiere.model.MAccountLookup;
import org.compiere.model.MLocationLookup;
import org.compiere.model.MLocatorLookup;
import org.compiere.model.MLookup;
import org.compiere.model.MPAttributeLookup;
import org.compiere.model.MPaymentLookup;
import org.compiere.util.DisplayType;

import static org.compiere.util.DisplayType.*; 

/**
 * @author Jan Thielemann - jan.thielemann@evenos.de
 * @author hengsin
 *
 */
public class DefaultLookupFactory implements ILookupFactory{

	@Override
	public Lookup getLookup(GridFieldVO gridFieldVO) {
		Lookup lookup = null;
		if (gridFieldVO.displayType == Location)   //  not cached
		{
			lookup = new MLocationLookup (gridFieldVO.ctx, gridFieldVO.WindowNo);
		}
		else if (gridFieldVO.displayType == DisplayType.Locator)
		{
			lookup = new MLocatorLookup (gridFieldVO.ctx, gridFieldVO.WindowNo);
		}
		else if (gridFieldVO.displayType == Account)    //  not cached
		{
			lookup = new MAccountLookup (gridFieldVO.ctx, gridFieldVO.WindowNo);
		}
		else if (gridFieldVO.displayType == PAttribute)    //  not cached
		{
			lookup = new MPAttributeLookup (gridFieldVO.ctx, gridFieldVO.WindowNo);
		}
		else if (gridFieldVO.displayType == Payment)
		{
			lookup = new MPaymentLookup (gridFieldVO.ctx, gridFieldVO.WindowNo, gridFieldVO.AD_Column_ID);
		}
		else if (DisplayType.isLookup(gridFieldVO.displayType) && gridFieldVO.lookupInfo != null)
		{
			lookup = new MLookup (gridFieldVO.lookupInfo, gridFieldVO.TabNo);
		}
		return lookup;
	}

	@Override
	public boolean isLookup(GridFieldVO gridFieldVO) {
		if (gridFieldVO.displayType == Location
			|| gridFieldVO.displayType == Locator
			|| gridFieldVO.displayType == Account
			|| gridFieldVO.displayType == PAttribute
			|| gridFieldVO.displayType == Payment
			|| DisplayType.isLookup(gridFieldVO.displayType))
			return true;
				
		return false;
	}

}
