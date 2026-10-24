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

import org.compiere.model.MInvoice;

/**
 * Supplies header defaults for invoices that are applied in {@link MInvoice} {@code beforeSave}
 * when the field is still empty.
 * <p>
 * Register the component with {@code @Component(service = IInvoiceDefaultsProvider.class)}.
 * <p>
 * Event handlers cannot do this: {@code PO_BEFORE_NEW} fires after the model's
 * {@code beforeSave}, by which time the built-in context fallbacks have already filled the field.
 * <p>
 * Each field method returns a {@link DefaultValue}: {@link DefaultValue#of(Object)},
 * {@link DefaultValue#useFallback()} to let the next provider or the built-in fallback decide, or
 * {@link DefaultValue#noDefault()} to leave the field empty. Providers are asked in service
 * ranking order, highest first; the first answer other than useFallback wins.
 */
public interface IInvoiceDefaultsProvider {

	/**
	 * @param invoice invoice being saved, with SalesRep_ID still empty
	 * @return SalesRep_ID record id, useFallback or noDefault
	 */
	default DefaultValue<Integer> getSalesRep_ID(MInvoice invoice) {
		return DefaultValue.useFallback();
	}

	/**
	 * @param invoice invoice being saved, with C_PaymentTerm_ID still empty
	 * @return C_PaymentTerm_ID record id, useFallback or noDefault
	 */
	default DefaultValue<Integer> getC_PaymentTerm_ID(MInvoice invoice) {
		return DefaultValue.useFallback();
	}

	/**
	 * @param invoice invoice being saved, with M_PriceList_ID still empty
	 * @return M_PriceList_ID record id, useFallback or noDefault
	 */
	default DefaultValue<Integer> getM_PriceList_ID(MInvoice invoice) {
		return DefaultValue.useFallback();
	}

	/**
	 * Called at the end of {@link MInvoice#setInitialDefaults()} for a new record, after the
	 * built-in initial values are set. Only the context (client, org, user) is known here.
	 * <p>
	 * Runs inside the model constructor: a subclass of the model is not yet initialized, so
	 * only call setters on {@code invoice}. All providers are called, lowest service ranking first,
	 * so the highest ranking provider runs last and its values are kept.
	 * @param invoice new record
	 */
	default void initDefaults(MInvoice invoice) {
	}
}
