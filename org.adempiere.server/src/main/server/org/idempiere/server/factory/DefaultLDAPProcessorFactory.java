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
package org.idempiere.server.factory;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.server.IServerFactory;
import org.compiere.ldap.LdapProcessor;
import org.compiere.model.MLdapProcessor;

/**
 * @author hengsin
 *
 */
public class DefaultLDAPProcessorFactory implements IServerFactory<LdapProcessor, MLdapProcessor> {

	/**
	 * default constructor 
	 */
	public DefaultLDAPProcessorFactory() {
	}

	@Override
	public LdapProcessor[] create(Properties ctx) {
		MLdapProcessor[] ldapModels = MLdapProcessor.getActive(ctx);
		List<LdapProcessor> list = new ArrayList<LdapProcessor>();
		for (MLdapProcessor lp : ldapModels)
		{
			LdapProcessor server = new LdapProcessor(lp);
			list.add(server);
		}
		return list.toArray(new LdapProcessor[0]);
	}

	@Override
	public Class<MLdapProcessor> getProcessorClass() {
		return MLdapProcessor.class;
	}
}
