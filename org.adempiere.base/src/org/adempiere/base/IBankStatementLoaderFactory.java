/******************************************************************************
 * Copyright (C) 2013 Thomas Bayen                                            *
 * Copyright (C) 2013 Jakob Bayen KG             							  *
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

import org.compiere.impexp.BankStatementLoaderInterface;

/**
 * Factory Interface for plugins to connect to the iDempiere core and provide a
 * way to load BankStatement lines. This can be used e.g. by a HBCI importer
 * plugin or just by a plugin to connect via csv or a webservice (or whatever)
 * to your bank.
 * 
 * @author tbayen
 */
public interface IBankStatementLoaderFactory {

	/**
	 * This class will be implemented in OSGi plugins. Every plugin that
	 * provides this service may or may not provide an BankStatementLoader
	 * depending on the given classname. The classname can be given by the user
	 * in the "Bank" window in the "Bank Satement Loader" tab. By convention
	 * this classname is the fully qualified classname of the Loader class you
	 * want to use.
	 * 
	 * @param className
	 * @return BankStatementLoader instance
	 */
	public BankStatementLoaderInterface newBankStatementLoaderInstance(String className);
}
