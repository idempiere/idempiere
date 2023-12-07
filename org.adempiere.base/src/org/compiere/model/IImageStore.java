/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Trek Global                                             *
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
package org.compiere.model;

/**
 * Store provider interface for storage of image content
 */
public interface IImageStore {
	
	/**
	 * Load image content
	 * @param image
	 * @param prov
	 * @return byte[] image content
	 */
	public byte[] load(MImage image, MStorageProvider prov);

	/**
	 * Save image content
	 * @param image
	 * @param prov
	 * @param inflatedData image content
	 */
	public void save(MImage image, MStorageProvider prov, byte[] inflatedData);
	
	/**
	 * Delete stored image content
	 * @param image
	 * @param prov
	 * @return true if deleted successfully
	 */
	public boolean delete(MImage image, MStorageProvider prov);

	/**
	 * @return true if image content is being buffered and pending flush to destination storage
	 */
	public boolean isPendingFlush();
	
	/**
	 * Flush buffer image content to destination storage
	 * @param image
	 * @param prov
	 */
	public void flush(MImage image,MStorageProvider prov);
}
