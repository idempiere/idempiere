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
package org.adempiere.server;

import java.util.Properties;

import org.compiere.model.AdempiereProcessor;
import org.compiere.server.AdempiereServer;

/**
 *
 * @author hengsin
 *
 */
public interface IServerFactory<S extends AdempiereServer, M extends AdempiereProcessor> {
	
	/**
	 * @param ctx
	 * @return list of AdempiereServer
	 */
	public S[] create (Properties ctx);
	
	/**
	 * The Adempiere Server Manager will used this to avoid running duplicate server for the same 
	 * AdempiereProcessor model.
	 * @return Fully qualified AdempiereProcessor model class name
	 */
	public Class<M> getProcessorClass();
}
