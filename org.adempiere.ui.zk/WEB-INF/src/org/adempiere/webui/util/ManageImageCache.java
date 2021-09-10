/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
**********************************************************************/

package org.adempiere.webui.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.compiere.model.MImage;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.image.AImage;
import org.zkoss.image.Image;

/**
 * Normal image can come from inside system or from outside system.
 * with image from outside for performance we will cache it.
 * this class for manage image cache and provide help function relate
 * @author hieplq
 *
 */
public class ManageImageCache {
	
	protected static final CLogger	log = CLogger.getCLogger (ManageImageCache.class);
	/**
	 * this cache is don't expire, if must restart cache when has update image.
	 * better use a timer, example reset cache after 10 minute has update. it help user can change a batch of image and reset one time.
	 */
	private final CCache<String, Image> imageCache = new CCache<String, Image>(null, "WindowImageCache", 50, 0, false);
	
	private static ManageImageCache instance;
	
	/**
	 * get instance
	 * @return
	 */
	public static ManageImageCache instance(){
		if (instance == null){
			synchronized (ManageImageCache.class){
				if (instance == null)
					instance = new ManageImageCache();
			}
		}
		
		return instance;
	}
	
	/**
	 * investigate image path of MImage, if path is a internal return internal url other return null
	 * @param image
	 * @return
	 */
	public static URL getImageInternalUrl (MImage image){
		if (image == null)
			return null;
		return getImageInternalUrl(image.getImageURL());
	}
	
	/**
	 * investigate image path, if path is a internal return internal url other return null
	 * @param url
	 * @return
	 */
	public static URL getImageInternalUrl (String url){
		if (url == null || url.trim().length() == 0 || url.indexOf("://") > 0)
			return null;
		
		URL urlRsource = Core.getResourceFinder().getResource(url);
		return urlRsource;
	}
	
	/**
	 * Load image from url
	 * @param imagePath
	 * @return
	 */
	protected static byte [] loadImageData (String imagePath){
		byte [] data = null;
		
		URLConnection conn;
		try {
			URL url = new URL(imagePath);
			conn = url.openConnection();
		
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
		} catch (IOException e) {
			if (log.isLoggable(Level.CONFIG)) log.config (e.toString());
		}
		
		return data;
	}
	
	/**
	 * if image is don't in cache, load it (imagePath can id of MImage)
	 * @param imagePath
	 * @return image load from path. null when has any exception
	 */
	public Image getImage(String imagePath){
		if (imagePath == null || imagePath.trim().length() == 0)
			return null;
		
		Image aImage = null;
		boolean hasCache = false;
		synchronized (imageCache) {
			hasCache = imageCache.containsKey(imagePath);
		}
			
		if (!hasCache) {
			try{
				int mImageId = Integer.parseInt(imagePath);
				loadImage(MImage.get(Env.getCtx(), mImageId));
			}catch (NumberFormatException ex){
				loadExtend(imagePath);
			}
			
		}
		
		synchronized (imageCache) {
			aImage = imageCache.get(imagePath);
		}
		
		return aImage;
	}
	
	/**
	 * 
	 * @param url
	 * @return {@link Image}
	 */
	public Image getImage(URL url) {
		if (url == null)
			return null;
		
		Image image = null;
		boolean hasCache = false;
		synchronized (imageCache) {
			hasCache = imageCache.containsKey(url.toString());
			if (hasCache)
				image = imageCache.get(url.toString());
		}
		
		
		if (!hasCache) {
			try {
				image = new AImage(url);
			} catch (IOException e) {
				log.log(Level.SEVERE, e.getMessage(), e);
			}
			synchronized (imageCache) {
				imageCache.put(url.toString(), image);
			}
		}
		return image;
	}
	
	/**
	 * if MImage contain extend image or binary image data, load it into cache and return key
	 * other return null
	 * @param mImage
	 * @return
	 */
	public String loadImage (MImage mImage){
		if (mImage == null)
			return null;
		
		boolean hasCache = false;
		String strId = String.valueOf(mImage.get_ID());
		synchronized (imageCache) {
			hasCache = imageCache.containsKey(strId);
		}
		
		if(hasCache){
			return strId;
		}

		if (mImage.getBinaryData() != null){
			synchronized (imageCache) {
				Image loadImage = null;
				try {
					loadImage = new AImage (mImage.getName(), mImage.getBinaryData());
				} catch (IOException e) {
					// do nothing treat image as null
				}
				imageCache.put(String.valueOf(mImage.get_ID()), loadImage);
			}
			return strId;
		}else if (mImage.getImageURL() != null && mImage.getImageURL().trim().length() > 0 && getImageInternalUrl(mImage.getImageURL()) == null){
			synchronized (imageCache) {
				hasCache = imageCache.containsKey(mImage.getImageURL());
			}
			if (!hasCache){
				loadExtend (mImage.getImageURL());
			}
			return mImage.getImageURL();
		}
		
		return null;
	}

	/**
	 * load extend image into cache
	 * @param imagePath
	 */
	protected void loadExtend (String imagePath){
		byte[] data = loadImageData(imagePath);
		AImage aImage = null;
		// when can't load image (by incorrect url or disconnect or any exception, just set image as null
		if (data != null)
			try {
				aImage = new AImage(imagePath, data);
			} catch (IOException e) {
				aImage = null;
			}
		
		synchronized (imageCache) {
			imageCache.put(imagePath, aImage);
		}
	}
	
}
