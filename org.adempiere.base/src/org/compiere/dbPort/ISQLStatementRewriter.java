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

/**
 * IDEMPIERE-7023
 * OSGi extension point that lets a plugin pre-rewrite SQL statements before
 * Convert.convert() and dialect convertStatement() execute them.
 *
 * Implementations must be registered via OSGi Declarative Services as
 * providers of this interface. The core iterates all registered services
 * and chains their rewriteStatements() in order.
 *
 * Typical use cases: row-level multi-tenant SQL injection, audit logging,
 * PII masking at the SQL layer, transparent time-travel queries, custom
 * row-level security on top of OOTB ACL.
 */
public interface ISQLStatementRewriter
{
	/**
	 * Rewrite a SQL statement.
	 * <p>
	 * <strong>Contract:</strong> implementations must NOT execute SQL through
	 * the iDempiere DB layer (DB, Query, PO, etc.) inside this method.
	 * If the rewriter needs database-derived metadata (e.g. to decide whether
	 * a table has history enabled), that data must be loaded into a local cache
	 * before rewrite time and read from the cache here. Violating this contract
	 * causes re-entrant calls to {@code Convert.convertStatement()} and a
	 * {@link StackOverflowError}.
	 *
	 * @param sqlStatements input SQL
	 * @return possibly modified SQL to execute; if no rewrite is needed,
	 *         return the parameter unchanged
	 */
	public String rewriteStatements(String sqlStatements);

	/**
	 * Whether the output of this rewriter is cacheable.
	 * Convert in DB_PostgreSQL maintains an in-memory Oracle->Postgres
	 * conversion cache: if this rewriter is dynamic (e.g. depends on a
	 * ThreadLocal context), return false to prevent stale cache entries.
	 */
	public boolean rewriteIsCacheable();
}
