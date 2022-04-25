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
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

public class MStorageProvider extends X_AD_StorageProvider implements ImmutablePOSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7444967391781941193L;

	/**	Cache							*/
	static private ImmutableIntPOCache<Integer,MStorageProvider> s_cache = new ImmutableIntPOCache<Integer,MStorageProvider>(Table_Name, 10);

	/**
	 * 	Get Storage Provider (cached) (immutable)
	 *	@param AD_StorageProvider_ID id
	 *	@return Storage Provider
	 */
	public static MStorageProvider get (int AD_StorageProvider_ID)
	{
		return get(Env.getCtx(), AD_StorageProvider_ID);
	}
	
	/**
	 * 	Get Storage Provider (cached) (immutable)
	 *	@param ctx context
	 *	@param AD_StorageProvider_ID id
	 *	@return Storage Provider
	 */
	public static MStorageProvider get (Properties ctx, int AD_StorageProvider_ID)
	{
		Integer key = Integer.valueOf(AD_StorageProvider_ID);
		MStorageProvider retValue = s_cache.get(ctx, key, e -> new MStorageProvider(ctx, e));
		if (retValue == null)
		{
			retValue = new MStorageProvider (ctx, AD_StorageProvider_ID, null);
			if (retValue.get_ID() == AD_StorageProvider_ID)
			{
				s_cache.put(key, retValue, e -> new MStorageProvider(Env.getCtx(), e));
				return retValue;
			}
			return null;
		}
		return retValue;
	}	//	get

	/**
	 * Get updateable copy of MStorageProvider from cache
	 * @param ctx
	 * @param AD_StorageProvider_ID
	 * @param trxName
	 * @return MStorageProvider
	 */
	public static MStorageProvider getCopy(Properties ctx, int AD_StorageProvider_ID, String trxName)
	{
		MStorageProvider rt = get(AD_StorageProvider_ID);
		if (rt != null)
			rt = new MStorageProvider(ctx, rt, trxName);		
		return rt;
	}
	
	public MStorageProvider(Properties ctx, int AD_StorageProvider_ID, String trxName) {
		super(ctx, AD_StorageProvider_ID, trxName);
	}

	public MStorageProvider(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * 
	 * @param copy
	 */
	public MStorageProvider(MStorageProvider copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MStorageProvider(Properties ctx, MStorageProvider copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MStorageProvider(Properties ctx, MStorageProvider copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
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

	private static CCache<ServiceQuery, IServiceReferenceHolder<IAttachmentStore>> s_attachmentStoreReference = new CCache<>(null, "IAttachmentStore", 3, false);
	
	/**
	 * 
	 * @param query
	 * @return {@link IAttachmentStore}
	 */
	public static IAttachmentStore getAttachmentStoreService(ServiceQuery query) {
		IAttachmentStore store = null;
		IServiceReferenceHolder<IAttachmentStore> cache = s_attachmentStoreReference.get(query);
		if (cache != null) {
			store = cache.getService();
			if (store != null)
				return store;
			else
				s_attachmentStoreReference.remove(query);
		}
		IServiceReferenceHolder<IAttachmentStore> serviceReference = Service.locator().locate(IAttachmentStore.class, query).getServiceReference();
		if (serviceReference != null) {
			store = serviceReference.getService();
			if (store != null)
				s_attachmentStoreReference.put(query, serviceReference);
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

	private static CCache<ServiceQuery, IServiceReferenceHolder<IArchiveStore>> s_archiveStoreReference = new CCache<>(null, "IArchiveStore", 3, false);
	
	/**
	 * 
	 * @param query
	 * @return {@link IArchiveStore}
	 */
	public static IArchiveStore getArchiveStoreService(ServiceQuery query) {
		IArchiveStore store = null;
		IServiceReferenceHolder<IArchiveStore> cache = s_archiveStoreReference.get(query);
		if (cache != null) {
			store = cache.getService();
			if (store != null)
				return store;
			else
				s_archiveStoreReference.remove(query);
		}
		
		IServiceReferenceHolder<IArchiveStore> serviceReference = Service.locator().locate(IArchiveStore.class, query).getServiceReference();
		if (serviceReference != null) {
			store = serviceReference.getService();
			if (store != null)
				s_archiveStoreReference.put(query, serviceReference);
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

	private static CCache<ServiceQuery, IServiceReferenceHolder<IImageStore>> s_imageStoreReference = new CCache<>(null, "IImageStore", 3, false);
	
	/**
	 * 
	 * @param query
	 * @return {@link IImageStore}
	 */
	public static IImageStore getImageStoreService(ServiceQuery query) {
		IImageStore store = null;
		IServiceReferenceHolder<IImageStore> cache = s_imageStoreReference.get(query);
		if (cache != null) {
			store = cache.getService();
			if (store != null)
				return store;
			else
				s_imageStoreReference.remove(query);
		}
		IServiceReferenceHolder<IImageStore> serviceReference = Service.locator().locate(IImageStore.class, query).getServiceReference();
		if (serviceReference != null) {
			store = serviceReference.getService();
			s_imageStoreReference.put(query, serviceReference);
		}
		return store;
	}

	public static int getDefaultStorageProviderID() {
		final String sql = "SELECT AD_StorageProvider_ID FROM AD_StorageProvider WHERE IsDefault='Y' AND IsActive='Y' ORDER BY AD_StorageProvider_ID";
		return DB.getSQLValueEx(null, sql);
	}

	@Override
	public MStorageProvider markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
