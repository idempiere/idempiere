package org.compiere.util;

import java.math.BigDecimal;
import java.util.Properties;

import org.adempiere.base.Core;
import org.adempiere.util.IReservationTracer;
import org.adempiere.util.IReservationTracerFactory;
import org.compiere.model.MOrderLine;
import org.compiere.model.MStorageReservation;

public class ReservationUtil {
    /**
     * Release or update storage reservation for an order line.
     * 
     * @param ctx context
     * @param oLine the order line
     * @param storageReservationToUpdate quantity to update (usually movement qty)
     * @param isSOTrx sales transaction flag
     * @param trxName transaction name
     * @param docTypeId document type id (for tracer, can be 0)
     * @param documentNo document number (for tracer, can be null)
     * @param lineNo line number (for tracer, can be 0)
     * @param tableId table id (for tracer, can be 0)
     * @param recordId record id (for tracer, can be 0)
     * @return null if success, or error message if failed
     */
    public static String releaseStorageReservation(
            Properties ctx,
            MOrderLine oLine,
            BigDecimal storageReservationToUpdate,
            boolean isSOTrx,
            String trxName,
            int docTypeId,
            String documentNo,
            int lineNo,
            int tableId,
            int recordId
    ) {
        IReservationTracer tracer = null;
        IReservationTracerFactory factory = Core.getReservationTracerFactory();
        if (factory != null) {
            tracer = factory.newTracer(
                docTypeId,
                documentNo,
                lineNo,
                tableId,
                recordId,
                oLine.getM_Warehouse_ID(),
                oLine.getM_Product_ID(),
                oLine.getM_AttributeSetInstance_ID(),
                isSOTrx,
                trxName
            );
        }
        if (!MStorageReservation.add(ctx, oLine.getM_Warehouse_ID(),
                oLine.getM_Product_ID(),
                oLine.getM_AttributeSetInstance_ID(),
                storageReservationToUpdate.negate(),
                isSOTrx,
                trxName, tracer))
        {
            String lastError = CLogger.retrieveErrorString("");
            return "Cannot update Reservation [" + oLine.getProduct().getValue() + "] - " + lastError;
        }
        return null;
    }
}
