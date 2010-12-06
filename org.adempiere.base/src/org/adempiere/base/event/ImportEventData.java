/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.base.event;

import org.adempiere.process.ImportProcess;
import org.compiere.model.PO;

/**
 *
 * @author hengsin
 *
 */
public class ImportEventData {
	private ImportProcess importProcess;
	private PO source;
	private PO target;

	/**
	 * @param importProcess
	 * @param source
	 * @param target
	 */
	public ImportEventData(ImportProcess importProcess, PO source, PO target) {
		super();
		this.importProcess = importProcess;
		this.source = source;
		this.target = target;
	}

	/**
	 * @return the importProcess
	 */
	public ImportProcess getImportProcess() {
		return importProcess;
	}

	/**
	 * @return the source
	 */
	public PO getSource() {
		return source;
	}

	/**
	 * @return the target
	 */
	public PO getTarget() {
		return target;
	}
}
