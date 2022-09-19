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
package org.compiere.print;

import java.awt.print.Pageable;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.logging.Level;

import org.adempiere.pdf.Document;
import org.compiere.model.MArchive;
import org.compiere.model.MClient;
import org.compiere.model.PrintInfo;
import org.compiere.print.layout.LayoutEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.jfree.io.IOUtils;


/**
 *	Archive Engine.
 *	Based on Settings on Client Level
 *	Keys set for
 *	- Menu Reports - AD_Report_ID
 *	- Win Report - AD_Table_ID
 *	- Documents - AD_Table_ID and Record_ID and C_Customer_ID 
 *	
 *  @author Jorg Janke
 *  @version $Id: ArchiveEngine.java,v 1.3 2006/07/30 00:53:02 jjanke Exp $
 */
public class ArchiveEngine
{
	/**
	 * 	Get/Create Archive.
	 * 	@param layout layout
	 * 	@param info print info
	 * 	@return existing document or newly created if Client enabled archiving. 
	 * 	Will return NULL if archiving not enabled
	 */ 
	public byte[] archive (LayoutEngine layout, PrintInfo info)
	{
		//	Do we need to Archive ?
		MClient client = MClient.get(layout.getCtx());
		String aaClient = client.getAutoArchive();
		String aa = aaClient;
		if (aa == null)
			aa = MClient.AUTOARCHIVE_None;
		//	Nothing to Archive
		if (aa.equals(MClient.AUTOARCHIVE_None))
			return null;
		//	Archive External only
		if (aa.equals(MClient.AUTOARCHIVE_ExternalDocuments))
		{
			if (info.isReport())
				return null;
		}
		//	Archive Documents only
		if (aa.equals(MClient.AUTOARCHIVE_Documents))
		{
			if (info.isReport())
				return null;
		}
		
		//	Create Printable
		byte[] data = Document.getPDFAsArray(layout.getPageable(false));	//	No Copy
		if (data == null)
			return null;

		//	TODO to be done async
		MArchive archive = new MArchive (layout.getCtx(),info, null);
		archive.setBinaryData(data);
		archive.saveEx();
		
		return data;
	}	//	archive
	
	/**
	 * 	Create Archive.
	 * 	@param pdfFile
	 * 	@param info print info
	 */ 
	public void archive (File pdfFile, PrintInfo info)
	{
		//	Do we need to Archive ?
		MClient client = MClient.get(Env.getCtx());
		String aaClient = client.getAutoArchive();
		String aa = aaClient;
		if (aa == null)
			aa = MClient.AUTOARCHIVE_None;
		//	Nothing to Archive
		if (aa.equals(MClient.AUTOARCHIVE_None))
			return;
		//	Archive External only
		if (aa.equals(MClient.AUTOARCHIVE_ExternalDocuments))
		{
			if (info.isReport())
				return;
		}
		//	Archive Documents only
		if (aa.equals(MClient.AUTOARCHIVE_Documents))
		{
			if (info.isReport())
				return;
		}
		
		ByteArrayOutputStream bas = new ByteArrayOutputStream();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(pdfFile);
			BufferedInputStream bis = new BufferedInputStream(fis);
			IOUtils.getInstance().copyStreams(bis, bas);
		} catch (FileNotFoundException e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} catch (IOException e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {}
			}
		}
		
		byte[] data = bas.toByteArray();  
				
		//	TODO to be done async
		MArchive archive = new MArchive (Env.getCtx(),info, null);
		archive.setBinaryData(data);
		archive.saveEx();
	}	//	archive
	
	/**
	 * 	Can we archive the document?
	 *	@param layout layout
	 *	@return true if can be archived
	 */
	public static boolean isValid (LayoutEngine layout)
	{
		return (layout != null 
			&& Document.isValid((Pageable)layout)
			&& layout.getNumberOfPages() > 0);
	}	//	isValid
	
	
	/**
	 * 	Get Archive Engine
	 *	@return engine
	 */
	public static ArchiveEngine get()
	{
		if (s_engine == null)
			s_engine = new ArchiveEngine();
		return s_engine;
	}	//	get
	
	//	Create Archiver
	static {
		s_engine = new ArchiveEngine();
	}
	
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ArchiveEngine.class);
	/** Singleton		*/
	private volatile static ArchiveEngine s_engine = null;
	
	
	/**************************************************************************
	 * 	ArchiveEngine
	 */
	private ArchiveEngine ()
	{
		super ();
		if (s_engine == null)
			s_engine = this;
	}	//	ArchiveEngine
}	//	ArchiveEngine
