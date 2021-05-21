/******************************************************************************
 * Copyright (C) Contributors                                                 *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * Contributors:                                                              *
 *   Andreas Sumerauer                                                        *
 *****************************************************************************/

package org.adempiere.webui.factory;

import org.adempiere.webui.grid.AbstractWQuickEntry;
import org.adempiere.webui.grid.WQuickEntry;


/**
 * @author Andreas Sumerauer
 */
public class DefaultQuickEntryFactory implements IQuickEntryFactory {

	@Override
	public AbstractWQuickEntry newQuickEntryInstance(int WindowNo, int TabNo, int AD_Window_ID) {
		return new WQuickEntry(WindowNo, TabNo, AD_Window_ID);
	}

	@Override
	public AbstractWQuickEntry newQuickEntryInstance(int AD_Window_ID) {
		return new WQuickEntry(AD_Window_ID);
	}
}
