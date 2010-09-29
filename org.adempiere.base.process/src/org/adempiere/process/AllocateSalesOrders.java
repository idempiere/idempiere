package org.adempiere.process;

import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrgInfo;
import org.compiere.model.MProduct;
import org.compiere.model.MClientInfo;
import org.compiere.model.MWarehouse;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;

/**
 * This process finds all complete sales orders that has physical items yet to 
 * deliver and tries to allocate items from the items on hand.
 * 
 * @author daniel.tamm
 *
 */
public class AllocateSalesOrders extends SvrProcess {
	
	private int	m_warehouseId;
	
	@Override
	protected void prepare() {
		
		m_warehouseId = 1000000; // TODO: Should be mandatory in the process definition
		
        ProcessInfoParameter[] para = getParameter();
        for (int i = 0; i < para.length; i++) {
            String name = para[i].getParameterName();
            if (para[i].getParameter() == null);
            else if (name.equals("M_Warehouse_ID")) {
            	m_warehouseId = para[i].getParameterAsInt();
            } else {
                log.log(Level.SEVERE, "Unknown Parameter: " + name);
            }
        }
		
	}
	
	
	
	@Override
	protected String doIt() throws Exception {

		Connection conn = DB.getConnectionRO();		
		List<MOrder.StockInfo> products = MOrder.getProductsToAllocate(conn, m_warehouseId);
		conn.close();
		List<MOrderLine> lines;
		MOrderLine line;
		BigDecimal lineAllocate;
		BigDecimal toAllocate;
		BigDecimal onHand;
		BigDecimal allocated;
		BigDecimal qtyAvailable;
		BigDecimal willAllocate;
		MOrder.StockInfo si;
		
		// Make sure we have settings that needs allocation
		MWarehouse warehouse = new MWarehouse(getCtx(), m_warehouseId, get_TrxName());
		MOrgInfo orgInfo = MOrgInfo.get(getCtx(), warehouse.getAD_Org_ID(), get_TrxName());
		if (!orgInfo.getDeliveryPolicy().equals(MClientInfo.DELIVERYPOLICY_StrictOrder)) {
			return "The current delivery policy of the warehouse doesn't use allocation.";
		}
		
		if (products.size()==0) {
			log.info("There are no products to allocate.");
			return "";
		}
		
		/** Iterate through all products to allocate */
		for (Iterator<MOrder.StockInfo> it = products.iterator(); it.hasNext();) {
			
			MProduct product = null;
			si = it.next();
			conn = DB.getConnectionRO();
			// Get all lines to allocate
			lines = MOrder.getOrderLinesToAllocate(conn, si.productId, get_TrxName());
			conn.close();
			
			// Check if there are any lines to allocate
			// and create a log.
			if (lines.size()>0) {
				product = lines.get(0).getProduct();
				line = lines.get(0);
				qtyAvailable = si.qtyAvailable;
				onHand = si.qtyOnHand;
				// TO allocate = Min (qtyOnHand - qtyAllocated, qtyReserved - qtyAllocated)
				toAllocate = si.qtyOnHand.subtract(si.qtyAllocated).min(si.qtyReserved.subtract(si.qtyAllocated));
				if (toAllocate.signum()>0) {
					log.info("Allocating " + product.getValue() + " : " + product.getName() + " Avail: " + qtyAvailable + " On hand: " + onHand + " To alloc: " + toAllocate);
					log.info(lines.size() + " lines to allocate.");
				} else {
					continue;
				}
			} else {
				continue;
			}
			
			allocated = BigDecimal.ZERO;
			
			// When we are here we know what product, qty available and we have the lines
			// that need to be allocated.
			for (Iterator<MOrderLine> it2 = lines.iterator(); it2.hasNext(); ) {
				line = it2.next();

				// Calculate what to allocate (what we want)
				lineAllocate = line.getQtyOrdered().subtract(line.getQtyDelivered()).subtract(line.getQtyAllocated());
				willAllocate = lineAllocate.min(toAllocate);
				if (willAllocate.signum()==1) {
					willAllocate = line.allocateOnHand(willAllocate, get_TrxName());
					allocated = allocated.add(willAllocate);
					toAllocate = toAllocate.subtract(willAllocate);
					log.info("Allocated " + willAllocate + " to order " + line.getC_Order().getDocumentNo() + " " + toAllocate + " left to allocate.");
					if (toAllocate.equals(BigDecimal.ZERO))
						break;
				} else {
					log.info("Skipping allocation of order " + line.getC_Order().getDocumentNo());
					continue;
				}
			}
			
		}
		
		return("");
	}

}
