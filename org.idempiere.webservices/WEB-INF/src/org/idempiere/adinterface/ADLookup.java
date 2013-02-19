/******************************************************************************
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
package org.idempiere.adinterface;

import org.compiere.model.Lookup;
import org.compiere.util.CLogger;
import org.compiere.util.KeyNamePair;
import org.compiere.util.ValueNamePair;
import org.idempiere.adInterface.x10.LookupValue;
import org.idempiere.adInterface.x10.LookupValues;

/*
 * ADEMPIERE/COMPIERE
 * 
 * zamiana:
 *   GridField na GridField
 *   GridField
 */
public class ADLookup {
	
	protected static CLogger	log = CLogger.getCLogger(ADLookup.class);	
	
	/**
	 * @param lvs
	 * @param lookup
	 * @param isMandatory
	 * @param isReadOnly
	 * @param isShortList
	 */
	public static void fillLookupValues( LookupValues lvs, Lookup lookup, boolean isMandatory, boolean isReadOnly, boolean isShortList) // IDEMPIERE 90
    {		
    	    	
		if(lookup.getSize() == 0)
			lookup.refresh();
		Object[] list = lookup.getData(isMandatory, true, !isReadOnly, false, isShortList).toArray();	 // IDEMPIERE 90									
		
		for (int i=0; i<list.length; i++)
		{
			boolean isNumber = list[0] instanceof KeyNamePair;
			
			LookupValue lv = lvs.addNewLv();
			
			if (isNumber)
			{
				KeyNamePair p = (KeyNamePair)list[i];												
				lv.setKey( Integer.toString(p.getKey()) );
				lv.setVal( p.getName() );
				
			} else
			{
				ValueNamePair p = (ValueNamePair)list[i];
				lv.setKey( p.getValue() );
				lv.setVal( p.getName() );
			}									
		}    	
    }
		
}
