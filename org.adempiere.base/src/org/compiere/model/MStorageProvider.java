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

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.adempiere.exceptions.AdempiereException;

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

	/**
	 * 
	 * @return {@link IAttachmentStore}
	 */
	public IAttachmentStore getAttachmentStore() {
		ServiceQuery query=new ServiceQuery();
		String method = this.getMethod();
		if (method == null)
			method = "DB";
		query.put("method", method);
		IAttachmentStore store = getAttachmentStoreService(query);			
		if (store == null) {
			throw new AdempiereException("No attachment storage provider found");
		}
		return store;
	}

	private static IServiceReferenceHolder<IAttachmentStore> s_attachmentStoreReference = null;
	
	/**
	 * 
	 * @param query
	 * @return {@link IAttachmentStore}
	 */
	public static synchronized IAttachmentStore getAttachmentStoreService(ServiceQuery query) {
		IAttachmentStore store = null;
		if (s_attachmentStoreReference != null) {
			store = s_attachmentStoreReference.getService();
			if (store != null)
				return store;
		}
		IServiceReferenceHolder<IAttachmentStore> serviceReference = Service.locator().locate(IAttachmentStore.class, query).getServiceReference();
		if (serviceReference != null) {
			store = serviceReference.getService();
			s_attachmentStoreReference = serviceReference;
		}
		return store;
	}
	
	/**
	 * 
	 * @return {@link IArchiveStore}
	 */
	public IArchiveStore getArchiveStore() {
		ServiceQuery query=new ServiceQuery();
		String method = this.getMethod();
		if (method == null)
			method = "DB";
		query.put("method", method);
		IArchiveStore store = getArchiveStoreService(query);
		if (store == null) {
			throw new AdempiereException("No archive storage provider found");
		}
		return store;
	}

	private static IServiceReferenceHolder<IArchiveStore> s_archiveStoreReference = null;
	
	/**
	 * 
	 * @param query
	 * @return {@link IArchiveStore}
	 */
	public static synchronized IArchiveStore getArchiveStoreService(ServiceQuery query) {
		IArchiveStore store = null;
		if (s_archiveStoreReference != null) {
			store = s_archiveStoreReference.getService();
			if (store != null)
				return store;
		}
		
		IServiceReferenceHolder<IArchiveStore> serviceReference = Service.locator().locate(IArchiveStore.class, query).getServiceReference();
		if (serviceReference != null) {
			store = serviceReference.getService();
			s_archiveStoreReference = serviceReference;
		}
		return store;
	}
		
	/**
	 * 
	 * @return {@link IImageStore}
	 */
	public IImageStore getImageStore() {
		ServiceQuery query=new ServiceQuery();
		String method = this.getMethod();
		if (method == null)
			method = "DB";
		query.put("method", method);
		IImageStore store = getImageStoreService(query);
		if (store == null) {
			throw new AdempiereException("No image storage provider found");
		}
		return store;
	}

	private static IServiceReferenceHolder<IImageStore> s_imageStoreReference = null;
	
	/**
	 * 
	 * @param query
	 * @return {@link IImageStore}
	 */
	public static synchronized IImageStore getImageStoreService(ServiceQuery query) {
		IImageStore store = null;
		if (s_imageStoreReference != null) {
			store = s_imageStoreReference.getService();
			if (store != null)
				return store;
		}
		IServiceReferenceHolder<IImageStore> serviceReference = Service.locator().locate(IImageStore.class, query).getServiceReference();
		if (serviceReference != null) {
			store = serviceReference.getService();
			s_imageStoreReference = serviceReference;
		}
		return store;
	}
}
