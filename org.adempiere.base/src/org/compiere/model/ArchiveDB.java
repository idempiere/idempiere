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
 * @author juliana
 *
 */
public class ArchiveDB implements IArchiveStore {


	private final CLogger log = CLogger.getCLogger(getClass());

	/* (non-Javadoc)
	 * @see org.compiere.model.IArchiveStore#loadLOBData(org.compiere.model.MArchive, org.compiere.model.MStorageProvider)
	 */
	@Override
	public byte[] loadLOBData(MArchive archive, MStorageProvider prov) {
		byte[] deflatedData = archive.getByteData();
		if (deflatedData == null)
			return null;
		//
		log.fine("ZipSize=" + deflatedData.length);
		if (deflatedData.length == 0)
			return null;

		byte[] inflatedData = null;
		try {
			ByteArrayInputStream in = new ByteArrayInputStream(deflatedData);
			ZipInputStream zip = new ZipInputStream(in);
			ZipEntry entry = zip.getNextEntry();
			if (entry != null) // just one entry
			{
				ByteArrayOutputStream out = new ByteArrayOutputStream();
				byte[] buffer = new byte[2048];
				int length = zip.read(buffer);
				while (length != -1) {
					out.write(buffer, 0, length);
					length = zip.read(buffer);
				}
				//
				inflatedData = out.toByteArray();
				log.fine("Size=" + inflatedData.length + " - zip=" + entry.getCompressedSize()
						+ "(" + entry.getSize() + ") "
						+ (entry.getCompressedSize() * 100 / entry.getSize()) + "%");
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "", e);
			inflatedData = null;
		}
		return inflatedData;
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.IArchiveStore#save(org.compiere.model.MArchive, org.compiere.model.MStorageProvider, byte[])
	 */
	@Override
	public void save(MArchive archive, MStorageProvider prov,byte[] inflatedData) {
		if (inflatedData == null || inflatedData.length == 0)
			throw new IllegalArgumentException("InflatedData is NULL");
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		ZipOutputStream zip = new ZipOutputStream(out);
		zip.setMethod(ZipOutputStream.DEFLATED);
		zip.setLevel(Deflater.BEST_COMPRESSION);
		zip.setComment("idempiere");
		//
		byte[] deflatedData = null;
		try {
			ZipEntry entry = new ZipEntry("IdempiereArchive");
			entry.setTime(System.currentTimeMillis());
			entry.setMethod(ZipEntry.DEFLATED);
			zip.putNextEntry(entry);
			zip.write(inflatedData, 0, inflatedData.length);
			zip.closeEntry();
			log.fine(entry.getCompressedSize() + " (" + entry.getSize() + ") "
					+ (entry.getCompressedSize() * 100 / entry.getSize()) + "%");
			//
			// zip.finish();
			zip.close();
			deflatedData = out.toByteArray();
			log.fine("Length=" + inflatedData.length);
		} catch (Exception e) {
			log.log(Level.SEVERE, "saveLOBData", e);
			deflatedData = null;
		}
		archive.setByteData(deflatedData);
	}

	@Override
	public boolean deleteArchive(MArchive archive, MStorageProvider prov) {
		
		return true;
	}

}
