package org.adempiere.base;

import java.sql.Timestamp;

import org.compiere.model.MPaySchedule;
import org.compiere.model.PO;
import org.compiere.util.TimeUtil;

/**
 * Base class for payment schedule managers
 *
 * @param <T> concrete document type
 */

public abstract class AbstractPayScheduleManager<T extends PO> implements IPayScheduleManager<T> {

    @Override
    public Timestamp getDueDate(T po, MPaySchedule paySchedule) {
        if (po == null || paySchedule == null) {
            return null;
        }
        Timestamp baseDate = getBaseDate(po);
        if (baseDate == null) {
            return null;
        }
        return TimeUtil.addDays(baseDate, paySchedule.getNetDays());
    }

    @Override
    public Timestamp getDiscountDate(T po, MPaySchedule paySchedule) {
        if (po == null || paySchedule == null) {
            return null;
        }
        Timestamp baseDate = getBaseDate(po);
        if (baseDate == null) {
            return null;
        }
        return TimeUtil.addDays(baseDate, paySchedule.getDiscountDays());
    }

    protected abstract Timestamp getBaseDate(T po);
}