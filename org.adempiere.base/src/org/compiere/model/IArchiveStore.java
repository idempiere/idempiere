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

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * Store provider interface for storage of archive content
 */
public interface IArchiveStore {
	
	/**
	 * Load binary content of archive
	 * @param archive
	 * @param prov
	 * @return byte[] content
	 */
	public byte[] loadLOBData(MArchive archive,MStorageProvider prov);

	/**
	 * Load binary content of archive as InputStream
	 * @param archive
	 * @param prov
	 * @return InputStream content, or null if no data
	 */
	default InputStream loadLOBDataAsStream(MArchive archive, MStorageProvider prov) {
		byte[] data = loadLOBData(archive, prov);
		if (data == null || data.length == 0) {
			return null;
		}
		return new ByteArrayInputStream(data);
	}
	
	/**
	 * Save content of archive
	 * @param archive
	 * @param prov
	 * @param inflatedData byte[] content of archive
	 */
	public void save(MArchive archive, MStorageProvider prov,byte[] inflatedData);
	
	/**
	 * Save content of archive from InputStream
	 * @param archive
	 * @param prov
	 * @param inputStream InputStream content of archive
	 */
	default void save(MArchive archive, MStorageProvider prov, InputStream inputStream) {
		if (inputStream == null) {
			throw new IllegalArgumentException("InputStream cannot be null");
		}
		try {
			byte[] data = inputStream.readAllBytes();
			save(archive, prov, data);
		} catch (Exception e) {
			throw new RuntimeException("Error reading InputStream", e);
		}
	}
	
	/**
	 * Delete stored archive content
	 * @param archive
	 * @param prov
	 * @return true if successfully deleted
	 */
	public boolean deleteArchive(MArchive archive, MStorageProvider prov);

	/**
	 * @return true if archive content is being buffered and pending flush to destination storage
	 */
	public boolean isPendingFlush();
	
	/**
	 * Flush buffer archive content to destination storage
	 * @param archive
	 * @param prov
	 */
	public void flush(MArchive archive,MStorageProvider prov);
}
