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
*                                                                     *
* Contributors:                                                       *
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.idempiere.server.cluster.callable;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.RandomAccessFile;
import java.io.Serializable;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.concurrent.Callable;
import java.util.logging.Level;

import org.compiere.util.CLogFile;

/**
 * @author hengsin
 *
 */
public class ReadLogCallable extends LogFileCallable implements Callable<byte[]>, Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 33969865104073117L;

	private String fileName;
	private int blockNo;

	/**
	 * 
	 * @param fileName
	 */
	public ReadLogCallable(String fileName) {
		this(fileName, 0);
	}

	/**
	 * 
	 * @param fileName
	 * @param blockNo 0 base block index
	 */
	public ReadLogCallable(String fileName, int blockNo) {
		this.fileName = fileName;
		this.blockNo = blockNo;
	}
	
	@Override
	public byte[] call() throws Exception {
		CLogFile fileHandler = CLogFile.get(false, null, false);
		//
		// Display current log File
		if (fileHandler != null && fileHandler.getFileName().equals(fileName))
			fileHandler.flush();

		File file = new File(fileName);
		if (!isAccessible(file))
			return null;
		
		if (file.length() == 0) {
			return new byte[0];
		}

		try(RandomAccessFile raf = new RandomAccessFile(file, "r"); FileChannel channel = raf.getChannel();) {			
			if (blockNo > 0) {
				channel.position(blockNo * BLOCK_SIZE);
			}
			ByteBuffer buffer = ByteBuffer.allocate(1024);
			ByteArrayOutputStream baos = new ByteArrayOutputStream(2048);
			int bytesRead = 0;
			int totalRead = 0;
			while((bytesRead = channel.read(buffer)) > 0) {
				totalRead += bytesRead;
				if (totalRead > BLOCK_SIZE) {
					int diff = totalRead - BLOCK_SIZE;
					bytesRead = bytesRead - diff;
					totalRead = BLOCK_SIZE;
				}
				baos.write(buffer.array(), 0, bytesRead);
				buffer.clear();
				if (totalRead == BLOCK_SIZE)
					break;
			}
			return baos.toByteArray();
		} catch (Exception ex) {
			log.log(Level.SEVERE, "stream" + ex);
			return null;
		}		
	}
}
