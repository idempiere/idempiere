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

import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import javax.print.attribute.EnumSyntax;
import javax.print.attribute.Size2DSyntax;
import javax.print.attribute.standard.MediaSize;
import javax.print.attribute.standard.MediaSizeName;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.X_AD_PrintPaper;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	AD_PrintPaper Print Paper Model
 *
 *  Change log:
 *  <ul>
 *  <li>2009-02-10 - armen - [ 2580531 ] Custom Paper Support - https://sourceforge.net/p/adempiere/feature-requests/655/
 *  </ul>
 *  
 * 	@author 	Jorg Janke
 * 	@version 	$Id: MPrintPaper.java,v 1.3 2006/07/30 00:53:02 jjanke Exp $
 * 
 * @author Teo Sarca
 * 			<li>FR [ 2829019 ] Check PrintPaper on save
 * 			https://sourceforge.net/p/adempiere/feature-requests/782/
 */
public class MPrintPaper extends X_AD_PrintPaper implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4968342903056251506L;

	/**
	 * 	Get Paper from cache (immutable)
	 * 	@param AD_PrintPaper_ID id
	 * 	@return Paper
	 */
	static public MPrintPaper get (int AD_PrintPaper_ID)
	{
		Integer key = Integer.valueOf(AD_PrintPaper_ID);
		MPrintPaper pp = s_papers.get(key);
		if (pp == null)
		{
			pp = new MPrintPaper (Env.getCtx(), AD_PrintPaper_ID, null);
			s_papers.put(key, pp);
			return pp;
		}
		else
			if (s_log.isLoggable(Level.CONFIG)) s_log.config("AD_PrintPaper_ID=" + AD_PrintPaper_ID);
		return pp;
	}	//	get

	/**
	 * 	Create Paper and save
	 * 	@param name name
	 * 	@param landscape landscape
	 * 	@return Paper
	 */
	static MPrintPaper create (String name, boolean landscape)
	{
		MPrintPaper pp = new MPrintPaper (Env.getCtx(), 0, null);
		pp.setName(name);
		pp.setIsLandscape(landscape);
		pp.saveEx();
		return pp;
	}	//	create

	/**	Logger				*/
	private static CLogger s_log = CLogger.getCLogger(MPrintPaper.class);
	/** Cached Fonts						*/
	static private ImmutableIntPOCache<Integer,MPrintPaper> s_papers 
		= new ImmutableIntPOCache<Integer,MPrintPaper>(Table_Name, 5);
	
	
	/**************************************************************************
	 *	Constructor
	 *  @param ctx context
	 *  @param AD_PrintPaper_ID ID if 0 A4
	 *  @param trxName transaction
	 */
	public MPrintPaper(Properties ctx, int AD_PrintPaper_ID, String trxName)
	{
		super(ctx, AD_PrintPaper_ID, trxName);
		if (AD_PrintPaper_ID == 0)
		{
			setIsDefault (false);
			setIsLandscape (true);
			setCode ("iso-a4");
			setMarginTop (36);
			setMarginBottom (36);
			setMarginLeft (36);
			setMarginRight (36);
		}
	}	//	MPrintPaper
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MPrintPaper (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MPrintPaper

	/**
	 * 
	 * @param copy
	 */
	public MPrintPaper(MPrintPaper copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPrintPaper(Properties ctx, MPrintPaper copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPrintPaper(Properties ctx, MPrintPaper copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_mediaSize = copy.m_mediaSize;
	}
	
	/** Media Size			*/
	private MediaSize		m_mediaSize = null;

	/**************************************************************************
	 * 	Get Media Size.
	 *  The search is hard coded as the javax.print.MediaSize* info is private
	 * 	@return MediaSize from Code
	 */
	public MediaSize getMediaSize()
	{
		if (m_mediaSize != null)
			return m_mediaSize;
		//
		String nameCode = getCode();
		if (nameCode != null)
		{
			//	Get Name
			MediaSizeName nameMedia = null;
			CMediaSizeName msn = new CMediaSizeName(4);
			String[] names = msn.getStringTable();
			for (int i = 0; i < names.length; i++)
			{
				String name = names[i];
				if (name.equalsIgnoreCase(nameCode))
				{
					nameMedia = (MediaSizeName)msn.getEnumValueTable()[i];
					if (log.isLoggable(Level.FINER)) log.finer("Name=" + nameMedia);
					break;
				}
			}
			if (nameMedia != null)
			{
				m_mediaSize = MediaSize.getMediaSizeForName(nameMedia);
				if (log.isLoggable(Level.FINE)) log.fine("Name->Size=" + m_mediaSize);
			}
		}
		//	Create New Media Size
		if (m_mediaSize == null)
		{
			float x = getSizeX().floatValue();
			float y = getSizeY().floatValue();
			if (x > 0 && y > 0)
			{
				m_mediaSize = new MediaSize(x, y, getUnitsInt(), MediaSizeName.A);
				if (log.isLoggable(Level.FINE)) log.fine("Size=" + m_mediaSize);
			}
		}
		//	Fallback
		if (m_mediaSize == null)
				m_mediaSize = getMediaSizeDefault();
		return m_mediaSize;
	}	//	getMediaSize

	/**
	 * 	Get Media Size
	 * 	@return Default Media Size based on Language
	 */
	public MediaSize getMediaSizeDefault()
	{
		m_mediaSize = Language.getLoginLanguage().getMediaSize();
		if (m_mediaSize == null)
			m_mediaSize = MediaSize.ISO.A4;
		if (log.isLoggable(Level.FINE)) log.fine("Size=" + m_mediaSize);
		return m_mediaSize;
	}	//	getMediaSizeDefault

	/**
	 * 	Get Units Int
	 *	@return units
	 */
	public int getUnitsInt()
	{
		String du = getDimensionUnits();
		if (du == null || DIMENSIONUNITS_MM.equals(du))
			return Size2DSyntax.MM;
		else if (DIMENSIONUNITS_Inch.equals(du))
			return Size2DSyntax.INCH; 
		else
			throw new AdempiereException("@NotSupported@ @DimensionUnit@ : "+du);
	}	//	getUnits
	
	/**
	 * 	Get CPaper
	 * 	@return CPaper
	 */
	public CPaper getCPaper()
	{
		//Modify Lines By AA Goodwill : Custom Paper Support 
		CPaper retValue;
		if (getCode().toLowerCase().startsWith("custom"))
		{
			retValue = new CPaper (getSizeX().doubleValue(), getSizeY().doubleValue(), getUnitsInt(),
					isLandscape(),
					getMarginLeft(), getMarginTop(), getMarginRight(), getMarginBottom());			
		}
		else
		{
			retValue = new CPaper (getMediaSize(), isLandscape(),
					getMarginLeft(), getMarginTop(), getMarginRight(), getMarginBottom());
		}
		//End Of AA Goodwill
		return retValue;
	}	//	getCPaper
	
	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		// Check all settings are correct by reload all data
		m_mediaSize = null;
		getMediaSize();
		getCPaper();
		
		return true;
	}

	@Override
	public MPrintPaper markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * 	Media Size Name 
	 */
	static class CMediaSizeName extends MediaSizeName
	{
		/**
		 * 
		 */
		private static final long serialVersionUID = 8561532175435930293L;

		/**
		 * 	CMediaSizeName
		 *	@param code
		 */
	    public CMediaSizeName(int code) 
	    {
	    	super (code);
	    }	//	CMediaSizeName

		/**
		 * 	Get String Table
		 *	@return string
		 */
		public String[] getStringTable ()
		{
			return super.getStringTable ();
		}
		
		/**
		 * 	Get Enum Value Table
		 *	@return Media Sizes
		 */
		public EnumSyntax[] getEnumValueTable ()
		{
			return super.getEnumValueTable ();
		}
	}	//	CMediaSizeName	
	
}	//	MPrintPaper
