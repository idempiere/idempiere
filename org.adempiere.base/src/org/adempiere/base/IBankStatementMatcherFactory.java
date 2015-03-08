/******************************************************************************
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import org.compiere.impexp.BankStatementMatcherInterface;

/**
 * Factory Interface for plugins to connect to the iDempiere core and provide a
 * way to match Bank statements
 * 
 * @author tsvikruha, inspired by tbayen IBankStatementLoaderFactory
 */
public interface IBankStatementMatcherFactory {

	/**
	 * This class will be implemented in OSGi plugins. Every plugin that
	 * provides this service may or may not provide an BankStatementMatcher
	 * depending on the given classname. By convention this classname is
	 * the fully qualified classname of the Loader class you want to use.
	 * 
	 * @param className
	 * @return BankStatementMatcher instance
	 */
	public BankStatementMatcherInterface newBankStatementMatcherInstance(String className);
}
