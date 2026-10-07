/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or      *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.adempiere.base;

import org.compiere.model.MOrder;

/**
 * Supplies header defaults for orders that are applied in {@link MOrder} {@code beforeSave}
 * when the field is still empty.
 * <p>
 * Register the component with {@code @Component(service = IOrderDefaultsProvider.class)}.
 * <p>
 * Event handlers cannot do this: {@code PO_BEFORE_NEW} fires after the model's
 * {@code beforeSave}, by which time the built-in context fallbacks have already filled the field.
 * <p>
 * Each field method returns a {@link DefaultValue}: {@link DefaultValue#of(Object)},
 * {@link DefaultValue#useFallback()} to let the next provider or the built-in fallback decide, or
 * {@link DefaultValue#noDefault()} to leave the field empty. Providers are asked in service
 * ranking order, highest first; the first answer other than useFallback wins.
 */
public interface IOrderDefaultsProvider {

	/**
	 * @param order order being saved, with SalesRep_ID still empty
	 * @return SalesRep_ID record id, useFallback or noDefault
	 */
	default DefaultValue<Integer> getSalesRep_ID(MOrder order) {
		return DefaultValue.useFallback();
	}

	/**
	 * @param order order being saved, with C_PaymentTerm_ID still empty
	 * @return C_PaymentTerm_ID record id, useFallback or noDefault
	 */
	default DefaultValue<Integer> getC_PaymentTerm_ID(MOrder order) {
		return DefaultValue.useFallback();
	}

	/**
	 * @param order order being saved, with M_PriceList_ID still empty
	 * @return M_PriceList_ID record id, useFallback or noDefault
	 */
	default DefaultValue<Integer> getM_PriceList_ID(MOrder order) {
		return DefaultValue.useFallback();
	}

	/**
	 * @param order order being saved, with Bill_Location_ID still empty
	 * @return Bill_Location_ID record id, useFallback or noDefault
	 */
	default DefaultValue<Integer> getBill_Location_ID(MOrder order) {
		return DefaultValue.useFallback();
	}

	/**
	 * Called at the end of {@link MOrder#setInitialDefaults()} for a new record, after the
	 * built-in initial values are set. Only the context (client, org, user) is known here.
	 * A provider may overwrite initial values, or clear one so that it is resolved in
	 * {@code beforeSave} (see {@link #getDeliveryRule(MOrder)}, {@link #getInvoiceRule(MOrder)}).
	 * DeliveryRule and InvoiceRule are mandatory: clear them with
	 * {@code order.set_ValueNoCheck(columnName, null)}. The generated setters refuse null on a
	 * mandatory column and leave a FillMandatory error that fails the save.
	 * <p>
	 * Runs inside the model constructor: a subclass of the model is not yet initialized, so
	 * only call setters on {@code order}. All providers are called, in service ranking order.
	 * @param order new record
	 */
	default void initDefaults(MOrder order) {
	}

	/**
	 * @param order order being saved, with DeliveryRule still empty
	 * @return DeliveryRule, useFallback or noDefault (the column is mandatory: noDefault fails the save)
	 */
	default DefaultValue<String> getDeliveryRule(MOrder order) {
		return DefaultValue.useFallback();
	}

	/**
	 * @param order order being saved, with InvoiceRule still empty
	 * @return InvoiceRule, useFallback or noDefault (the column is mandatory: noDefault fails the save)
	 */
	default DefaultValue<String> getInvoiceRule(MOrder order) {
		return DefaultValue.useFallback();
	}
}
