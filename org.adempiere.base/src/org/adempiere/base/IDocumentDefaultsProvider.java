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

import org.compiere.model.PO;

/**
 * Supplies header defaults for documents (MOrder, MInvoice) that are applied in
 * {@code beforeSave} when the field is still empty.
 * <p>
 * Register the component with a {@code tableName} service property matching {@code T}, e.g.
 * {@code @Component(service = IDocumentDefaultsProvider.class, property = "tableName=C_Order")}
 * for {@code IDocumentDefaultsProvider<MOrder>}. Only providers for the saved table are asked.
 * <p>
 * Event handlers cannot do this: {@code PO_BEFORE_NEW} fires after the model's
 * {@code beforeSave}, by which time the built-in context fallbacks have already filled the field.
 * <p>
 * Each method returns a record id, {@link #USE_FALLBACK} to let the next provider or the
 * built-in fallback decide, or {@link #NO_DEFAULT} to leave the field empty.
 * Providers for the table are asked in service ranking order; the first answer other than
 * {@link #USE_FALLBACK} wins.
 *
 * @param <T> document model class, matching the {@code tableName} service property
 */
public interface IDocumentDefaultsProvider<T extends PO> {

	/** No opinion: ask the next provider, then apply the built-in fallback */
	int USE_FALLBACK = 0;
	/** Leave the field empty, skip the built-in fallback */
	int NO_DEFAULT = -1;

	/**
	 * @param document document being saved, with SalesRep_ID still empty
	 * @return SalesRep_ID, {@link #USE_FALLBACK} or {@link #NO_DEFAULT}
	 */
	default int getSalesRep_ID(T document) {
		return USE_FALLBACK;
	}

	/**
	 * @param document document being saved, with C_PaymentTerm_ID still empty
	 * @return C_PaymentTerm_ID, {@link #USE_FALLBACK} or {@link #NO_DEFAULT}
	 */
	default int getC_PaymentTerm_ID(T document) {
		return USE_FALLBACK;
	}

	/**
	 * @param document document being saved, with M_PriceList_ID still empty
	 * @return M_PriceList_ID, {@link #USE_FALLBACK} or {@link #NO_DEFAULT}
	 */
	default int getM_PriceList_ID(T document) {
		return USE_FALLBACK;
	}

	/**
	 * @param document document being saved, with Bill_Location_ID still empty
	 * @return Bill_Location_ID, {@link #USE_FALLBACK} or {@link #NO_DEFAULT}
	 */
	default int getBill_Location_ID(T document) {
		return USE_FALLBACK;
	}

	/**
	 * Called at the end of the model's {@code setInitialDefaults()} for a new record, after the
	 * built-in initial values are set. Only the context (client, org, user) is known here.
	 * A provider may overwrite initial values, or clear one so that it is resolved in
	 * {@code beforeSave} (see {@link #getDeliveryRule(PO)}, {@link #getInvoiceRule(PO)}).
	 * <p>
	 * Runs inside the model constructor: a subclass of the model is not yet initialized, so
	 * only call setters on {@code document}. All providers for the table are called, in
	 * service ranking order.
	 * @param document new record
	 */
	default void initDefaults(T document) {
	}

	/**
	 * @param document document being saved, with DeliveryRule still empty
	 * @return DeliveryRule, or null to let the next provider or the built-in fallback decide
	 */
	default String getDeliveryRule(T document) {
		return null;
	}

	/**
	 * @param document document being saved, with InvoiceRule still empty
	 * @return InvoiceRule, or null to let the next provider or the built-in fallback decide
	 */
	default String getInvoiceRule(T document) {
		return null;
	}
}
