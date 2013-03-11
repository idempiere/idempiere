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

/**
 * @author Jan Thielemann - jan.thielemann@evenos.de
 * @author evenos Consulting GmbH - www.evenos.org
 */
public interface ILookupFactory {
	
	/**
	 * 
	 * @param gridFieldVO
	 * @return lookup instance
	 */
	public Lookup getLookup (GridFieldVO gridFieldVO);

	/**
	 * 
	 * @param gridFieldVO
	 * @return true if the field's displaytype uses lookup
	 */
	public boolean isLookup(GridFieldVO gridFieldVO);
}
