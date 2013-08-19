package org.compiere.model;

import java.util.Properties;

import org.adempiere.util.ShippingUtil;
import org.compiere.util.Env;

/**
 * User: cruiz - idalica
 * Date: Apr 16, 2008
 * <p/>
 * Packages - Callouts
 */
public class CalloutPackage extends CalloutEngine
{
    public String afterShipper(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value, Object oldValue)
    {
        if (isCalloutActive())
            return "";

        int inout_id = Env.getContextAsInt(ctx, windowNo, "M_InOut_ID");
        if (inout_id > 0) 
        {
        	String shipperAccount = null;
        	String dutiesShipperAccount = null;
        	MInOut inout = new MInOut(ctx, inout_id, null);

        	if (MInOut.FREIGHTCHARGES_Prepaid.equals(inout.getFreightCharges()) || MInOut.FREIGHTCHARGES_PrepaidAndBill.equals(inout.getFreightCharges())) 
        	{
        		// 2. For charging to Velocity
        		// ** If M_InOut.FreightCharges In ( D_PP, E_PPB)  -- prepaid or prepaid and bill
        		// --  then set M_Package.ShipperAccount = C_BP_ShippingAcct.ShipperAccount
        		// Where C_BP_ShippingAcct.C_BPartner_ID = M_Shipper.C_BPartner_ID  AND M_Package.AD_Org_ID= C_BP_ShippingAcct.AD_Org_ID
                int shipper_id = Env.getContextAsInt(ctx, windowNo, "M_Shipper_ID");
                if (shipper_id > 0) 
                {
                    int org_id = Env.getContextAsInt(ctx, windowNo, "AD_Org_ID");
                    shipperAccount = ShippingUtil.getSenderShipperAccount(shipper_id, org_id);
                    dutiesShipperAccount = ShippingUtil.getSenderDutiesShipperAccount(shipper_id, org_id);
                }
        	} 
        	else 
        	{
        		// 1.  For charging the customers account
        		// ** If M_InOut.FreightCharges  Not In ( D_PP, E_PPB)  -- prepaid or prepaid and bill
        		// -- then set M_Package.ShipperAccount = M_InOut.ShipAcctNo
        		shipperAccount = inout.getShipperAccount();
        	}

        	if (shipperAccount != null)
        		mTab.setValue(MPackage.COLUMNNAME_ShipperAccount, shipperAccount);
        	if (dutiesShipperAccount != null)
        		mTab.setValue(MPackage.COLUMNNAME_DutiesShipperAccount, dutiesShipperAccount);
        }

        return "";
    }

    public String afterShipperSetDefaults(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value, Object oldValue)
    {
        if (isCalloutActive())
            return "";

        // value is M_Shipper_ID
        if (value != null && ((Integer)value).intValue() > 0) 
        {
        	int shipper_id = ((Integer)value).intValue();

/*        	if(value != oldValue)
        	{
	        	if (Ini.isClient())
				{
	        		try
	                {
	                    Class cl = Class.forName("org.compiere.apps.ADialog");
	                    Class paramTypes[] = {int.class, Container.class, String.class, String.class};
	                    Object params[] = {windowNo, Env.getWindow(windowNo), "Update Shipment Method", "Are you sure you want to apply this Shipment Method to the Shipment?"};
	                    Method method = cl.getDeclaredMethod("ask", paramTypes);
	                    Boolean ok = (Boolean) method.invoke(null, params);
	                    
	                    if(!ok)
		                {
		                    // don't update the shipper of shipment record but continue with default values setting
		                    //return "";
		                }
		                else
		                {
		                    int inout_id = Env.getContextAsInt(ctx, windowNo, "M_InOut_ID");
		                    String sql = "update M_InOut set M_Shipper_ID=? where M_InOut_ID=?";
		                    DB.executeUpdate(sql, new Object[] { shipper_id, inout_id }, false, null);
		                }
	                }
	                catch (Exception ex)
	                {
	                	throw new AdempiereException(ex);
	                }
				}
				else
				{
					try
					{
						ClassLoader loader = Thread.currentThread().getContextClassLoader();
						if (loader == null)
							loader = this.getClass().getClassLoader();
		    	    	Class<?> clazz = loader.loadClass("org.adempiere.webui.window.FDialog");
		    	    	Class<?> clazz1 = loader.loadClass("org.zkoss.zk.ui.Component");
		    		      
		    	    	Method m = clazz.getMethod("ask", Integer.TYPE, clazz1, String.class, String.class);
		    	    	Boolean returnCode = (Boolean)m.invoke(null, 0, null, "Update Shipment Method",
                                "Are you sure you want to apply this Shipment Method to the Shipment?");
		    		    
		    	    	if(!returnCode)
		                {
		                    // don't update the shipper of shipment record but continue with default values setting
		                    //return "";		    	    		
		                }
		    	    	else
		    	    	{
		    	    		int inout_id = Env.getContextAsInt(ctx, windowNo, "M_InOut_ID");
		                    String sql = "update M_InOut set M_Shipper_ID=? where M_InOut_ID=?";
		                    DB.executeUpdate(sql, new Object[] { shipper_id, inout_id }, false, null);
		    	    	}
					} 
					catch (Exception e)
					{
						throw new AdempiereException(e);
					}
				}
            }
*/        
        	String whereClause = "M_Shipper_ID = " + shipper_id + " AND IsDefault='Y' AND IsActive='Y'";
    		int[] ids = MShipperLabels.getAllIDs(MShipperLabels.Table_Name, whereClause, null);
    		if (ids.length > 0)
    			mTab.setValue(MPackage.COLUMNNAME_M_ShipperLabels_ID, ids[0]);

    		ids = MShipperPackaging.getAllIDs(MShipperPackaging.Table_Name, whereClause, null);
    		if (ids.length > 0)
    			mTab.setValue(MPackage.COLUMNNAME_M_ShipperPackaging_ID, ids[0]);

    		ids = MShipperPickupTypes.getAllIDs(MShipperPickupTypes.Table_Name, whereClause, null);
    		if (ids.length > 0)
    			mTab.setValue(MPackage.COLUMNNAME_M_ShipperPickupTypes_ID, ids[0]);

            // Get the business partner location for shipper account
            // First try to get c_bpartner_location_id from C_BP_ShippingAcct
            int c_bpartner_id = Env.getContextAsInt(ctx, windowNo, "C_BPartner_ID");
            int ad_org_id = Env.getContextAsInt(ctx, windowNo, "AD_Org_ID");
            int inout_id = Env.getContextAsInt(ctx, windowNo, "M_InOut_ID");
            int accountLocationId = ShippingUtil.findRecipientAccountLocationId(shipper_id, c_bpartner_id, ad_org_id, inout_id, 0);
            // Assign it if found
            if (accountLocationId > 0)
                mTab.setValue(MPackage.COLUMNNAME_C_BPartner_Location_ID, accountLocationId);

            if (shipper_id > 0)
            {
            	MShipper shipper = new MShipper(ctx, shipper_id, null);

            	mTab.setValue(MPackage.COLUMNNAME_TrackingInfo, shipper.getTrackingURL());
            	mTab.setValue(MPackage.COLUMNNAME_IsResidential, shipper.isResidential());
            	mTab.setValue(MPackage.COLUMNNAME_IsSaturdayDelivery, shipper.isSaturdayDelivery());
            }
        }

        return "";
    }
    
}