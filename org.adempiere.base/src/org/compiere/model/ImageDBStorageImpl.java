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
import java.io.ByteArrayOutputStream;
import java.util.logging.Level;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.compiere.util.CLogger;

/**
 * @author hengsin
 *
 */
public class ImageDBStorageImpl implements IImageStore {


	private final CLogger log = CLogger.getCLogger(getClass());

	@Override
	public byte[] load(MImage image, MStorageProvider prov) {
		byte[] deflatedData = image.getByteData();
		if (deflatedData == null)
			return null;
		//
		if (log.isLoggable(Level.FINE)) log.fine("ZipSize=" + deflatedData.length);
		if (deflatedData.length == 0)
			return null;

		byte[] inflatedData = null;
		try {
			ZipInputStream zip = null;
			ZipEntry entry = null;
			if (MSysConfig.getBooleanValue(MSysConfig.IMAGE_DB_STORAGE_SAVE_AS_ZIP, false)) {
				ByteArrayInputStream in = new ByteArrayInputStream(deflatedData);
				zip = new ZipInputStream(in);
				entry = zip.getNextEntry();
			}
			if (entry != null)
			{
				// just one entry per zip
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				byte[] buffer = new byte[2048];
				int length = zip.read(buffer);
				while (length != -1) {
					out.write(buffer, 0, length);
					length = zip.read(buffer);
				}
				//
				inflatedData = out.toByteArray();
				if (log.isLoggable(Level.FINE)) log.fine("Size=" + inflatedData.length + " - zip=" + entry.getCompressedSize()
						+ "(" + entry.getSize() + ") "
						+ (entry.getCompressedSize() * 100 / entry.getSize()) + "%");
			} else {
				//not zip stream, legacy data, or saving as raw
				inflatedData = deflatedData;
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "", e);
			inflatedData = null;
		}
		return inflatedData;
	}

	@Override
	public void save(MImage image, MStorageProvider prov, byte[] inflatedData) {
		if (inflatedData == null || inflatedData.length == 0) {
			image.setByteData(null);
			return;
		}
		byte[] deflatedData = null;
		if (MSysConfig.getBooleanValue(MSysConfig.IMAGE_DB_STORAGE_SAVE_AS_ZIP, false)) {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			ZipOutputStream zip = new ZipOutputStream(out);
			zip.setMethod(ZipOutputStream.DEFLATED);
			zip.setLevel(Deflater.BEST_COMPRESSION);
			zip.setComment("idempiere");
			//
			try {
				ZipEntry entry = new ZipEntry(image.getName());
				entry.setTime(System.currentTimeMillis());
				entry.setMethod(ZipEntry.DEFLATED);
				zip.putNextEntry(entry);
				zip.write(inflatedData, 0, inflatedData.length);
				zip.closeEntry();
				if (log.isLoggable(Level.FINE)) log.fine(entry.getCompressedSize() + " (" + entry.getSize() + ") "
						+ (entry.getCompressedSize() * 100 / entry.getSize()) + "%");
				//
				zip.close();
				deflatedData = out.toByteArray();
				if (log.isLoggable(Level.FINE)) log.fine("Length=" + inflatedData.length);
			} catch (Exception e) {
				log.log(Level.SEVERE, "saveLOBData", e);
				deflatedData = null;
			}
		} else {
			deflatedData = inflatedData;
		}
		image.setByteData(deflatedData);
	}

	@Override
	public boolean delete(MImage image, MStorageProvider prov) {
		
		return true;
	}

	@Override
	public boolean isPendingFlush() {
		return false;
	}

	@Override
	public void flush(MImage image, MStorageProvider prov) {
	}

}
