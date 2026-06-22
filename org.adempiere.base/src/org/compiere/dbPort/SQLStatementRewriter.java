/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
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
package org.compiere.dbPort;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * IDEMPIERE-7023
 * Static helper that aggregates all OSGi-registered {@link ISQLStatementRewriter}
 * providers and chains their rewrites.
 *
 * Registered as an immediate OSGi DS component; providers are injected via
 * {@code @Reference} (cardinality 0..n, dynamic policy). The static methods
 * delegate to the component instance so callers (Convert, DB_PostgreSQL,
 * DB_Oracle) need no OSGi awareness.
 *
 * Re-entrancy prevention is the responsibility of each {@link ISQLStatementRewriter}
 * implementation: providers must not execute SQL through the iDempiere DB layer
 * inside {@code rewriteStatements()} — see that method's contract.
 */
@Component(name = "org.compiere.dbPort.SQLStatementRewriter", immediate = true, service = {})
public class SQLStatementRewriter
{
	/** Singleton instance set by OSGi DS on activate/deactivate. */
	private static volatile SQLStatementRewriter instance;

	private final List<ISQLStatementRewriter> rewriters = new CopyOnWriteArrayList<>();

	@Activate
	public void activate()
	{
		instance = this;
	}

	@Deactivate
	public void deactivate()
	{
		instance = null;
	}

	// s.coletta@ads.it 2026-06-22
	@Reference(name = "ISQLStatementRewriter",
	           service = ISQLStatementRewriter.class,
	           cardinality = ReferenceCardinality.MULTIPLE,
	           policy = ReferencePolicy.DYNAMIC,
	           unbind = "removeISQLStatementRewriter")
	public void addISQLStatementRewriter(ISQLStatementRewriter rewriter)
	{
		rewriters.add(rewriter);
	}

	public void removeISQLStatementRewriter(ISQLStatementRewriter rewriter)
	{
		rewriters.remove(rewriter);
	}

	/**
	 * Iterates all registered providers and chains their rewrites.
	 * Returns the input unchanged when no provider is registered.
	 *
	 * @param sqlStatements input SQL
	 * @return possibly rewritten SQL
	 */
	public static String rewriteStatements(String sqlStatements)
	{
		if (sqlStatements == null) return null;
		SQLStatementRewriter inst = instance;
		if (inst == null || inst.rewriters.isEmpty()) return sqlStatements;
		String result = sqlStatements;
		for (ISQLStatementRewriter r : inst.rewriters)
			result = r.rewriteStatements(result);
		return result;
	}

	/**
	 * @return true if EVERY registered rewriter declares its output cacheable,
	 *         or if no provider is registered.
	 */
	public static boolean isConvertCacheable()
	{
		SQLStatementRewriter inst = instance;
		if (inst == null || inst.rewriters.isEmpty()) return true;
		for (ISQLStatementRewriter r : inst.rewriters)
		{
			if (!r.rewriteIsCacheable()) return false;
		}
		return true;
	}
}
