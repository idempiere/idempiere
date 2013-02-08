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
