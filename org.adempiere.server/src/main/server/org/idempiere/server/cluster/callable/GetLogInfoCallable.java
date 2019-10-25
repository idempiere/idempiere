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

import java.io.File;
import java.io.Serializable;
import java.util.concurrent.Callable;

import org.compiere.util.CLogFile;

/**
 * @author hengsin
 *
 */
public class GetLogInfoCallable extends LogFileCallable implements Callable<GetLogInfoCallable.LogInfo>, Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 33969865104073117L;

	private String fileName;

	/**
	 * 
	 * @param fileName
	 */
	public GetLogInfoCallable(String fileName) {
		this.fileName = fileName;
	}
	
	@Override
	public LogInfo call() throws Exception {
		CLogFile fileHandler = CLogFile.get(false, null, false);
		//
		// Display current log File
		if (fileHandler != null && fileHandler.getFileName().equals(fileName))
			fileHandler.flush();

		File file = new File(fileName);
		if (!isAccessible(file))
			return null;
		
		long length = file.length();
		int noOfBlocks = 1;
		if (length > BLOCK_SIZE) {
			int v = (int) (((length - 1) / BLOCK_SIZE) + 1);
			if (v == 0)
				v = 1;
			noOfBlocks = v;
		}
		
		return new LogInfo(fileName, length, BLOCK_SIZE, noOfBlocks);
	}
	
	public static class LogInfo implements Serializable {
		
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = -4154825003947713729L;
		
		private String fileName;
		private long length;
		private int blockSize;
		private int noOfBlocks;
		
		public LogInfo(String fileName, long length, int blockSize, int noOfBlocks) {
			super();
			this.fileName = fileName;
			this.length = length;
			this.blockSize = blockSize;
			this.noOfBlocks = noOfBlocks;
		}

		/**
		 * @return the fileName
		 */
		public String getFileName() {
			return fileName;
		}

		/**
		 * @return the length
		 */
		public long getLength() {
			return length;
		}

		/**
		 * @return the blockSize
		 */
		public int getBlockSize() {
			return blockSize;
		}

		/**
		 * @return the noOfBlocks
		 */
		public int getNoOfBlocks() {
			return noOfBlocks;
		}			
	}
}
