/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.compiere.util;

/**
 * Transaction event listener interface
 * @author hengsin
 */
public interface TrxEventListener {
	/**
	 * After commit event
	 * @param trx
	 * @param success
	 */
	public void afterCommit(Trx trx, boolean success);
	/**
	 * After rollback event
	 * @param trx
	 * @param success
	 */
	public void afterRollback(Trx trx, boolean success);
	/**
	 * After close event
	 * @param trx
	 */
	public void afterClose(Trx trx);
}
