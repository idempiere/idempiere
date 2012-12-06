/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;

public class MStorageProvider extends X_AD_StorageProvider {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5889682671195395536L;

	public MStorageProvider(Properties ctx, int AD_StorageProvider_ID, String trxName) {
		super(ctx, AD_StorageProvider_ID, trxName);
	}

	public MStorageProvider(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public IAttachmentStore getAttachmentStore() {
		ServiceQuery query=new ServiceQuery();
		String method = this.getMethod();
		if (method == null)
			method = "DB";
		query.put("method", method);
		IAttachmentStore store = Service.locator().locate(IAttachmentStore.class, query).getService();			
		if (store == null){
			log.saveError("Error", "No attachment storage provider found");
		}
		return store;
	}
	
	public IArchiveStore getArchiveStore() {
		ServiceQuery query=new ServiceQuery();
		String method = this.getMethod();
		if (method == null)
			method = "DB";
		query.put("method", method);
		IArchiveStore store = Service.locator().locate(IArchiveStore.class, query).getService();
		if (store == null){
			log.saveError("Error", "No archive storage provider found");
		}
		return store;
	}
		
}
