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

import java.io.*;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.Random;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CLogger;
import org.compiere.util.MimeType;

/**
 *	Individual Attachment Entry of MAttachment
 *	
 *  @author Jorg Janke
 *  @version $Id: MAttachmentEntry.java,v 1.2 2006/07/30 00:58:18 jjanke Exp $
 */
public class MAttachmentEntry
{
    private File m_file;

    /**
	 * 	Attachment Entry
	 * 	@param name name
	 * 	@param data binary data
	 * 	@param index optional index
	 */
	public MAttachmentEntry (String name, byte[] data, int index)
	{
		super ();
		setName (name);
		setData (data);
		setIndex(index);
	}	//	MAttachmentEntry
	
	/**
	 * 	Attachment Entry
	 * 	@param name name
	 * 	@param data binary data
	 */
	public MAttachmentEntry (String name, byte[] data)
	{
		this (name, data, 0);
	}	//	MAttachmentEntry

    public MAttachmentEntry(String name, File file) {
        this(name, file, 0);
    }

    public MAttachmentEntry(String name, File file, int index) {
        setName(name);
        setIndex(index);
        setFile(file);
    }

	/**
	 * Constructor for delayed loading of content
	 * @param name
	 * @param index
	 * @param ds lazy data source
	 */
	public MAttachmentEntry (String name, int index, IAttachmentLazyDataSource ds) {
		super ();
		setName (name);
		setIndex(index);
		setLazyDataSource(ds);
	}

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MAttachmentEntry(MAttachmentEntry copy)
	{
		this.m_isDataSet = copy.m_isDataSet;
		this.m_ds = copy.m_ds;
		this.m_data = copy.m_data != null ? Arrays.copyOf(copy.m_data, copy.m_data.length) : null;
		this.m_index = copy.m_index;
		this.m_name = copy.m_name;
        this.m_file = copy.m_file;
	}
	
	/**	The Name				*/
	private String 	m_name = "?";

	/** If m_data has been set */
	private boolean m_isDataSet = false;
	/** The Data, do not use m_data directly, it can be not loaded yet, always use the method getData to access this variable */
	private byte[] 	m_data = null;
	
	/** Random Seed			*/
	private static long		s_seed = System.currentTimeMillis(); 
	/** Random Number		*/
	private static Random	s_random = new Random(s_seed);
	/** Index				*/
	private int				m_index = 0; 

	/**	Logger			*/
	protected CLogger	log = CLogger.getCLogger(getClass());

	/** Lazy Data Source */
	private IAttachmentLazyDataSource m_ds = null;

	/** True if the entry has been updated (sets by MAttachment.updateEntry(int, byte[]) */
	private boolean m_isUpdated = false;


    /**
	 * @return byte[] content
	 */
	public byte[] getData ()
	{
		if (! m_isDataSet) {
            if (m_ds != null)
			    setData(m_ds.getData());
		} else {
            if (m_data == null && m_file != null) {
                try {
                    m_data = Files.readAllBytes(m_file.toPath());
                } catch (IOException e) {
                    log.log(Level.WARNING, e.getMessage(), e);
                }
            }
        }
		return m_data;
	}
	
	/**
	 * @param data The data to set.
	 */
	public void setData (byte[] data)
	{
		m_data = data;
        m_file = null;
		m_isDataSet = true;
	}

    /**
     * Set the file content
     * @param file
     */
    public void setFile(File file) {
        m_file = file;
        m_data = null;
        m_isDataSet = true;
    }

    /**
     * Get size of data content in bytes
     * @return size
     */
    public long getSize()
    {
        if (m_ds != null)
            return m_ds.getSize();
        else if (m_file != null)
            return m_file.length();
        else if (m_data != null && m_data.length > 0)
            return m_data.length;
        else
            return 0;
    }

	/**
	 * @return name of entry
	 */
	public String getName ()
	{
		return m_name;
	}
	
	/**
	 * @param name The name to set.
	 */
	public void setName (String name)
	{
		if (name != null)
			m_name = name;
		if (m_name == null)
			m_name = "?";
	}	//	setName
	
	/**
	 * 	Get entry Index
	 *	@return entry index
	 */
	public int getIndex()
	{
		return m_index;
	}	//	getIndex
	
	/**
	 * 	To String
	 *	@return name
	 */
	@Override
	public String toString ()
	{
		return m_name;
	}	//	toString

	/**
	 * 	To String Extended
	 *	@return name (length)
	 */
	public String toStringX ()
	{
		StringBuilder sb = new StringBuilder (m_name);
		if (getData() != null)
		{
			sb.append(" (");
			//
			float size = getData().length;
			if (size <= 1024)
				sb.append(getData().length).append(" B");
			else
			{
				size /= 1024;
				if (size > 1024)
				{
					size /= 1024;
					sb.append(size).append(" MB");
				}
				else
					sb.append(size).append(" kB");
			}
			//
			sb.append(")");
		}
		sb.append(" - ").append(getContentType());
		return sb.toString();
	}	//	toStringX
	
	/**
	 * 	Dump Data to standard out
	 */
	public void dump ()
	{
		StringBuilder hdr = new StringBuilder("----- ").append(getName()).append(" -----");
		System.out.println (hdr.toString());
		if (getData() == null)
		{
			System.out.println ("----- no data -----");
			return;
		}
		//	raw data
		for (int i = 0; i < getData().length; i++)
		{
			char data = (char)getData()[i];
			System.out.print(data);
		}
			
		System.out.println ();
		System.out.println (hdr.toString());
		//	Count nulls at end
		int ii = getData().length -1;
		int nullCount = 0;
		while (getData()[ii--] == 0)
			nullCount++;
		StringBuilder msgout = new StringBuilder("----- Length=").append(getData().length).append(", EndNulls=").append(nullCount) 
				.append(", RealLength=").append((getData().length-nullCount));
		System.out.println(msgout.toString());
		/**
		//	Dump w/o nulls
		if (nullCount > 0)
		{
			for (int i = 0; i < getData().length-nullCount; i++)
				System.out.print((char)getData()[i]);
			System.out.println ();
			System.out.println (hdr);
		}
		/** **/
	}	//	dump

	/**
	 * 	Get File with default name
	 *	@return File
	 */
	public File getFile ()
	{
        if (m_file != null)
            return m_file;
		m_file = getFile (getName());
        return m_file;
	}	//	getFile

	/**
	 * 	Get File with name
	 *	@param fileName optional file name
	 *	@return file
	 */	
	public File getFile (String fileName)
	{
		if (fileName == null || fileName.length() == 0)
			fileName = getName();

        //return file from lazy data source (if name match)
        if (m_ds != null) {
            File file = m_ds.getFile();
            if (file != null && file.exists() && file.getName().equals(fileName))
                return file;
        }

        try {
            return getFile (new File(Files.createTempDirectory("attachment_").toFile() , fileName));
        } catch (IOException e) {
            throw new AdempiereException(e);
        }
    }	//	getFile

	/**
	 * 	Get File
	 *	@param file out file
	 *	@return file
	 */
	public File getFile (File file)
	{
		InputStream inputStream = getInputStream();
        if (inputStream == null)
			return null;
		try
		{
            Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
		}
		catch (IOException ioe)
		{
			log.log(Level.SEVERE, "getFile", ioe);
			throw new AdempiereException(ioe);
		}
        finally
        {
            try {
                inputStream.close();
            } catch (IOException e) {
            }
        }
		return file;
	}	//	getFile

	/**
	 * 	Is attachment entry a PDF
	 *	@return true if PDF
	 */
	public boolean isPDF()
	{
		return m_name.toLowerCase().endsWith(".pdf");
	}	//	isPDF
	
	/**
	 * 	Is attachment entry an image
	 *	@return true if *.gif, *.jpg or *.png
	 */
	public boolean isGraphic()
	{
		String m_lowname = m_name.toLowerCase();
		return m_lowname.endsWith(".gif") || m_lowname.endsWith(".jpg") || m_lowname.endsWith(".png");
	}	//	isGraphic
	
	
	/**
	 * 	Get Content (Mime) Type
	 *	@return content type
	 */
	public String getContentType()
	{
		return MimeType.getMimeType(m_name);
	}	//	getContentType
	
	/**
	 * 	Get Data as Input Stream
	 *	@return input stream
	 */
	public InputStream getInputStream()
	{
        if (m_ds != null)
            return m_ds.getInputStream();
        else if (m_file != null) {
            try {
                return new FileInputStream(m_file);
            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
        else if (m_data != null && m_data.length > 0)
            return new ByteArrayInputStream(m_data);
        else
            return null;
	}	//	getInputStream

	/**
	 * Set entry index
	 * @param index
	 */
	public void setIndex(int index) {
		if (index > 0)
			m_index = index;
		else
		{
			long now = System.currentTimeMillis();
			synchronized(this) {
			if (s_seed+3600000l < now)	//	older then 1 hour
			{
				s_seed = now;
				s_random = new Random(s_seed);
			}
			m_index = s_random.nextInt();}
		}
	}

	/**
	 * Set the lazy data source
	 * @param ds
	 */
	public void setLazyDataSource(IAttachmentLazyDataSource ds) {
		m_ds = ds;
	}

	/**
	 * Get the lazy data source
	 * @return
	 */
	public IAttachmentLazyDataSource getLazyDataSource() {
		return m_ds;
	}

	/** 
	 * Set the updated property 
	 * @param updated
	 */
	public void setUpdated(boolean updated) {
		m_isUpdated = updated;
	}

	/** 
	 * Get the updated property 
	 * @return true if updated
	 */
	public boolean isUpdated() {
		return m_isUpdated;
	}

    /**
     * Clean up resources held. Should stop using the instance after calling this method.
     */
    public void cleanUp() {
        if (m_data != null)
            m_data = null;
        if (m_ds != null) {
            m_ds.cleanUp();
        }
    }
}	//	MAttachmentItem
