/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.awt.Container;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import javax.swing.Icon;
import javax.swing.ImageIcon;

import org.adempiere.base.Core;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  Image Model
 *  (DisplayType = 32)
 *
 *  @author Jorg Janke
 *  @version $Id: MImage.java,v 1.5 2006/07/30 00:51:02 jjanke Exp $
 */
public class MImage extends X_AD_Image implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1850627989276185947L;
	
	private MStorageProvider provider;
	
	/**
	 * 	Get MImage from Cache (immutable)
	 *	@param AD_Image_ID id
	 *	@return MImage
	 */
	public static MImage get (int AD_Image_ID)
	{
		return get(Env.getCtx(), AD_Image_ID);
	}
	
	/**
	 * 	Get MImage (Immutable) from Cache
	 *	@param ctx context
	 *	@param AD_Image_ID id
	 *	@return MImage
	 */
	public static MImage get (Properties ctx, int AD_Image_ID)
	{
		if (AD_Image_ID == 0)
			return new MImage (ctx, AD_Image_ID, null);
		//
		Integer key = Integer.valueOf(AD_Image_ID);
		MImage retValue = s_cache.get (ctx, key, e -> new MImage(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MImage (ctx, AD_Image_ID, (String)null);
		if (retValue.get_ID () == AD_Image_ID)
		{
			s_cache.put (key, retValue, e -> new MImage(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**
	 * Get updateable copy of MImage from cache
	 * @param ctx context
	 * @param AD_Image_ID
	 * @param trxName transaction name
	 * @return MImage
	 */
	public static MImage getCopy(Properties ctx, int AD_Image_ID, String trxName)
	{
		MImage img = get(AD_Image_ID);
		if (img != null && img.getAD_Image_ID() > 0) {
			MStorageProvider copyprov = img.provider;
			img = new MImage(ctx, img, trxName);
			img.setStorageProvider(copyprov);
		}
		
		return img;
	}
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MImage> s_cache = new ImmutableIntPOCache<Integer,MImage>(Table_Name, 20, 10);
	
	/**
	 *  Constructor
	 *  @param ctx context
	 *  @param AD_Image_ID image
	 *  @param trxName transaction
	 */
	public MImage(Properties ctx, int AD_Image_ID, String trxName)
	{
		super (ctx, AD_Image_ID, trxName);
		if (AD_Image_ID < 1)
			setName("-");
		initImageStoreDetails(ctx, trxName);
	}   //  MImage

	/**
	 * 	Load Constructor
	 *	@param ctx
	 *	@param rs
	 *  @param trxName transaction
	 */
	public MImage (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		initImageStoreDetails(ctx, trxName);
	}	//	MImage

	/**
	 * 
	 * @param copy
	 */
	public MImage(MImage copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MImage(Properties ctx, MImage copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MImage(Properties ctx, MImage copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/** The Image                   */
	private Image			m_image = null;
	/** The Icon                   */
	private Icon			m_icon = null;

	/**
	 * 	Get Image
	 *	@return image or null
	 */
	public Image getImage ()
	{
		if (m_image != null)
			return m_image;
		//	Via byte array
		byte[] data = getBinaryData();
		if (data != null && data.length > 0)
		{
			try
			{
				Toolkit tk = Toolkit.getDefaultToolkit();
				m_image = tk.createImage(data);
				MediaTracker mediaTracker = new MediaTracker(new Container());
                mediaTracker.addImage(m_image, 0);
                mediaTracker.waitForID(0);
                return m_image;
			}
			catch (Exception e)
			{
				log.log(Level.WARNING, "(byteArray)", e);
				return null;
			}
		}
		//	Via URL
		URL url = getURL();
		if (url == null)
			return null;
		try
		{
			Toolkit tk = Toolkit.getDefaultToolkit();
			m_image = tk.getImage(url);
			MediaTracker mediaTracker = new MediaTracker(new Container());
            mediaTracker.addImage(m_image, 0);
            mediaTracker.waitForID(0);
			return m_image;
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, "(URL)", e);
		}
		return null;
	}   //  getImage

	/**
	 * 	Get Icon
	 *	@return icon or null
	 */
	public Icon getIcon ()
	{
		if (m_icon != null)
			return m_icon;
		//	Via byte array
		byte[] data = getBinaryData();
		if (data != null && data.length > 0)
		{
			try
			{
				m_icon = new ImageIcon(data, getName());
				return m_icon;
			}
			catch (Exception e)
			{
				log.log(Level.WARNING, "(byteArray)", e);
				return null;
			}
		}
		//	Via URL
		URL url = getURL();
		if (url == null)
			return null;
		try
		{
			m_icon = new ImageIcon(url, getName());
			return m_icon;
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, "(URL)", e);
		}
		return null;
	}   //  getIcon

	/**
	 * 	Get URL
	 *	@return url or null
	 */
	private URL getURL()
	{
		String str = getImageURL();
		if (str == null || str.length() == 0)
			return null;
		
		URL url = null;
		try
		{
			//	Try URL directly
			if (str.indexOf("://") != -1)
				url = new URL(str);
			else	//	Try Resource
				url = getClass().getResource(str);
			//
			if (url == null)
				if (log.isLoggable(Level.INFO)) log.info("Not found as resource: " + str);
		}
		catch (Exception e)
		{
			log.warning("Not found: " + str + " - " + e.getMessage());
		}
		return url;
	}	//	getURL
	
	/**
	 * 	Set Image URL
	 *	@param ImageURL url
	 */
	public void setImageURL (String ImageURL)
	{
		m_image = null;
		m_icon = null;
		super.setImageURL (ImageURL);
	}	//	setImageURL
	
	/**
	 * 	Set Binary Data
	 *	@param BinaryData data
	 */
	@Override
	public void setBinaryData (byte[] BinaryData)
	{
		m_image = null;
		m_icon = null;
		IImageStore prov = provider.getImageStore();
		if (prov != null)
			prov.save(this,provider,BinaryData);
	}	//	setBinaryData
	
	@Override
	public byte[] getBinaryData() {		
		IImageStore prov = provider.getImageStore();
		if (prov != null)
			return prov.load(this,provider);
		return null;
	}

	/**
	 * 	Get Data 
	 *	@return data
	 */
	public byte[] getData()
	{
		byte[] data = getBinaryData ();
		if (data != null)
			return data;
		//	From URL
		String str = getImageURL();
		if (str == null || str.length() == 0)
		{
			log.config("No Image URL");
			return null;
		}
		//	Get from URL
		URL url = getURL();
		if (url == null) 
		{
			url = Core.getResourceFinder().getResource(str);
		}
		if (url == null)
		{
			log.config("No URL");
			return null;
		}
		try
		{
			URLConnection conn = url.openConnection();
		    conn.setUseCaches(false);
		    InputStream is = conn.getInputStream();
			byte[] buffer = new byte[1024*8];   //  8kB
			ByteArrayOutputStream os = new ByteArrayOutputStream();
			int length = -1;
			while ((length = is.read(buffer)) != -1)
				os.write(buffer, 0, length);
			is.close();
			data = os.toByteArray();
			os.close();
		    
		}
		catch (Exception e)
		{
			if (log.isLoggable(Level.CONFIG)) log.config (e.toString());
		}
		return data;
	}	//	getData
	
	/**
	 *  String Representation
	 *  @return String
	 */
	public String toString()
	{
		StringBuilder msgreturn = new StringBuilder("MImage[ID=").append(get_ID()).append(",Name=").append(getName()).append("]");
		return msgreturn.toString();
	}   //  toString

	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		return true;
	}	//	beforeSave

	public String getImageStoragePath() {
		StringBuilder path = new StringBuilder("AD_Image").append(File.separator)
				.append(this.getAD_Client_ID()).append(File.separator);
		return path.toString();
	}
	
	/**
	 * @param ctx
	 * @param trxName
	 */
	private void initImageStoreDetails(Properties ctx, String trxName) {
		if (is_new()) {
			MClientInfo clientInfo = MClientInfo.get(ctx, getAD_Client_ID());
			setStorageProvider(MStorageProvider.get(ctx, clientInfo.getStorageImage_ID()));
		} else {
			setStorageProvider(MStorageProvider.get(ctx, getAD_StorageProvider_ID()));
		}
	}
	
	/**
	 * Set Storage Provider
	 * Used temporarily for the process to migrate storage provider
	 * @param p Storage provider
	 */
	public void setStorageProvider(MStorageProvider p) {
		provider = p;
		setAD_StorageProvider_ID(p.getAD_StorageProvider_ID());
	}
	
	public byte[] getByteData(){
		return super.getBinaryData();
	}
	
	public void setByteData(byte[] BinaryData){
		super.setBinaryData(BinaryData);
	}

	@Override
	protected boolean postDelete() {
		IImageStore prov = provider.getImageStore();
		if (prov != null)
			return prov.delete(this,provider);
		return true;
	}

	@Override
	protected void saveNew_afterSetID()
	{
		IImageStore prov = provider.getImageStore();
		if (prov != null && prov.isPendingFlush())
			prov.flush(this, provider);
	}
	
	@Override
	public MImage markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}   //  MImage
