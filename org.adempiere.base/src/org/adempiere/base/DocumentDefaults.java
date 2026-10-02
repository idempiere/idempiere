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

import java.util.Collections;
import java.util.List;
import java.util.function.BiFunction;
import java.util.function.ToIntBiFunction;

import org.compiere.model.PO;

/**
 * Asks the {@link IDocumentDefaultsProvider}s registered for the document's table
 * ({@code tableName} service property) in service ranking order, and returns the first answer
 * other than {@link IDocumentDefaultsProvider#USE_FALLBACK}.
 * With no provider registered every method returns USE_FALLBACK.
 */
public final class DocumentDefaults {

	private static final DocumentDefaults INSTANCE = new DocumentDefaults();

	private DocumentDefaults() {
	}

	/**
	 * @return shared instance
	 */
	public static DocumentDefaults getInstance() {
		return INSTANCE;
	}

	/**
	 * @param document document being saved
	 * @return SalesRep_ID, USE_FALLBACK or NO_DEFAULT
	 */
	public <T extends PO> int getSalesRep_ID(T document) {
		return ask(document, IDocumentDefaultsProvider::getSalesRep_ID);
	}

	/**
	 * @param document document being saved
	 * @return C_PaymentTerm_ID, USE_FALLBACK or NO_DEFAULT
	 */
	public <T extends PO> int getC_PaymentTerm_ID(T document) {
		return ask(document, IDocumentDefaultsProvider::getC_PaymentTerm_ID);
	}

	/**
	 * @param document document being saved
	 * @return M_PriceList_ID, USE_FALLBACK or NO_DEFAULT
	 */
	public <T extends PO> int getM_PriceList_ID(T document) {
		return ask(document, IDocumentDefaultsProvider::getM_PriceList_ID);
	}

	/**
	 * @param document document being saved
	 * @return Bill_Location_ID, USE_FALLBACK or NO_DEFAULT
	 */
	public <T extends PO> int getBill_Location_ID(T document) {
		return ask(document, IDocumentDefaultsProvider::getBill_Location_ID);
	}

	/**
	 * Let every provider for the table adjust the initial values of a new record
	 * @param document new record, at the end of setInitialDefaults()
	 */
	public <T extends PO> void initDefaults(T document) {
		for (IDocumentDefaultsProvider<T> provider : getProviders(document))
			provider.initDefaults(document);
	}

	/**
	 * @param document document being saved
	 * @return DeliveryRule, or null for the built-in fallback
	 */
	public <T extends PO> String getDeliveryRule(T document) {
		return askString(document, IDocumentDefaultsProvider::getDeliveryRule);
	}

	/**
	 * @param document document being saved
	 * @return InvoiceRule, or null for the built-in fallback
	 */
	public <T extends PO> String getInvoiceRule(T document) {
		return askString(document, IDocumentDefaultsProvider::getInvoiceRule);
	}

	private <T extends PO> int ask(T document, ToIntBiFunction<IDocumentDefaultsProvider<T>, T> question) {
		for (IDocumentDefaultsProvider<T> provider : getProviders(document)) {
			int answer = question.applyAsInt(provider, document);
			if (answer != IDocumentDefaultsProvider.USE_FALLBACK)
				return answer;
		}
		return IDocumentDefaultsProvider.USE_FALLBACK;
	}

	private <T extends PO> String askString(T document, BiFunction<IDocumentDefaultsProvider<T>, T, String> question) {
		for (IDocumentDefaultsProvider<T> provider : getProviders(document)) {
			String answer = question.apply(provider, document);
			if (answer != null)
				return answer;
		}
		return null;
	}

	/**
	 * @return providers registered for the document's table, in service ranking order
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private <T extends PO> List<IDocumentDefaultsProvider<T>> getProviders(T document) {
		ServiceQuery query = new ServiceQuery();
		query.put("tableName", document.get_TableName());
		List<IDocumentDefaultsProvider> providers = Service.locator().list(IDocumentDefaultsProvider.class, query).getServices();
		// the tableName filter guarantees provider and document type match
		return providers != null ? (List) providers : Collections.emptyList();
	}
}
