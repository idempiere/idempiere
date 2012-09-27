package org.compiere.process;

import java.util.HashSet;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;

public class RollUpCosts extends SvrProcess {


	int category = 0;
	int product_id = 0;
	int client_id = 0; 
	int costelement_id = 0;
	private HashSet<Integer> processed;
	
	protected void prepare() 
	{
	
		int chosen_id = 0;
				
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
		//	log.fine("prepare - " + para[i]);
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_Product_Category_ID"))
				category = para[i].getParameterAsInt();
			else if (name.equals("M_Product_ID"))
				chosen_id = para[i].getParameterAsInt();
			else if (name.equals("M_CostElement_ID"))
				costelement_id = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);		
		}
		
	
		product_id = getRecord_ID();
		if (product_id == 0)
		{
			product_id = chosen_id;
		}

		
	}
	
	protected String doIt() throws Exception
	{
		client_id = Env.getAD_Client_ID(getCtx());
		createArray();
		String result = rollUp();
		return result;
	}
	


	protected String rollUp() throws Exception {
		
		
		if (product_id != 0) //only for the product
		{
			rollUpCosts(product_id);
		}
		else if (category != 0) //roll up for all categories
		{
			String sql = "SELECT M_Product_ID FROM M_Product WHERE M_Product_Category_ID = ? AND AD_Client_ID = ? " +
			    " AND M_Product_ID IN (SELECT M_Product_ID FROM M_Product_BOM)";
			int[] prodids = DB.getIDsEx(get_TrxName(), sql, category, client_id);
			for (int prodid : prodids) {
				rollUpCosts(prodid);
			}
		}
		else //do it for all products 
		{
			String sql = "SELECT M_Product_ID FROM M_Product WHERE AD_Client_ID = ? " +
			   " AND M_Product_ID IN (SELECT M_Product_ID FROM M_Product_BOM)";
			int[] prodids = DB.getIDsEx(get_TrxName(), sql, client_id);
			for (int prodid : prodids) {
				rollUpCosts(prodid);
			}
	    }
		
		return "Roll Up Complete";
	}
    
	protected void createArray() throws Exception
	{
		
		processed = new HashSet<Integer>();
		
	}
	
	protected void rollUpCosts(int p_id) throws Exception 
	{
		StringBuilder sql = new StringBuilder("SELECT M_ProductBOM_ID FROM M_Product_BOM WHERE M_Product_ID = ? ") 
		    .append(" AND AD_Client_ID = ").append(client_id);
		int[] prodbomids = DB.getIDsEx(get_TrxName(), sql.toString(), client_id);
		
		for (int prodbomid : prodbomids) {
			if ( !processed.contains(p_id)) {
				rollUpCosts(prodbomid);
			}
		}

		//once the subproducts costs are accurate, calculate the costs for this product
		StringBuilder update = new StringBuilder("UPDATE M_Cost set CurrentCostPrice = COALESCE((select Sum (b.BOMQty * c.currentcostprice)") 
           .append(" FROM M_Product_BOM b INNER JOIN M_Cost c ON (b.M_PRODUCTBOM_ID = c.M_Product_ID) ") 
           .append(" WHERE b.M_Product_ID = ").append(p_id).append(" AND M_CostElement_ID = ").append(costelement_id).append("),0),") 
           .append(" FutureCostPrice = COALESCE((select Sum (b.BOMQty * c.futurecostprice) FROM M_Product_BOM b ") 
           .append(" INNER JOIN M_Cost c ON (b.M_PRODUCTBOM_ID = c.M_Product_ID) ") 
           .append(" WHERE b.M_Product_ID = ").append(p_id).append(" AND M_CostElement_ID = ").append(costelement_id).append("),0)")
           .append(" WHERE M_Product_ID = ").append(p_id).append(" AND AD_Client_ID = ").append(client_id)
           .append(" AND M_CostElement_ID = ").append(costelement_id)
           .append(" AND M_PRODUCT_ID IN (SELECT M_PRODUCT_ID FROM M_PRODUCT_BOM)");
        
		DB.executeUpdate(update.toString(), get_TrxName());

		processed.add(p_id);
		
	}

}
