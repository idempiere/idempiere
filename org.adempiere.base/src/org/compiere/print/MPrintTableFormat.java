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

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Image;
import java.awt.Stroke;
import java.awt.Toolkit;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.MAttachment;
import org.compiere.model.MImage;
import org.compiere.model.X_AD_PrintTableFormat;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.IntPOCopyCache;

/**
 *	Table Print Format
 *
 * 	@author 	Jorg Janke
 *  @author victor.perez@e-evolution.com, e-Evolution
 * 	<li>BF [ 2011567 ] Implement Background Image for Document printed 
 * 	<li>https://sourceforge.net/p/adempiere/feature-requests/477/
 * 	@version 	$Id: MPrintTableFormat.java,v 1.3 2006/07/30 00:53:02 jjanke Exp $
 */
public class MPrintTableFormat extends X_AD_PrintTableFormat implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1608017405401341288L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_PrintTableFormat_UU  UUID key
     * @param trxName Transaction
     */
    public MPrintTableFormat(Properties ctx, String AD_PrintTableFormat_UU, String trxName) {
        super(ctx, AD_PrintTableFormat_UU, trxName);
		if (Util.isEmpty(AD_PrintTableFormat_UU))
			setInitialDefaults();
    }

	/**
	 *	Standard Constructor
	 *  @param ctx context
	 *  @param AD_PrintTableFormat_ID table format
	 *  @param trxName transaction
	 */
	public MPrintTableFormat (Properties ctx, int AD_PrintTableFormat_ID, String trxName)
	{
		super (ctx, AD_PrintTableFormat_ID, trxName);
		if (AD_PrintTableFormat_ID == 0)
			setInitialDefaults();
	}	//	MPrintTableFormat

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsDefault (false);
		setIsPaintHeaderLines (true);	// Y
		setIsPaintBoundaryLines (false);
		setIsPaintHLines (false);
		setIsPaintVLines (false);
		setIsPrintFunctionSymbols (true);
	}

	/**
	 *	Load Constructor
	 *  @param ctx context
	 *  @param rs result set
	 *  @param trxName transaction
	 */
	public MPrintTableFormat (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPrintTableFormat
	
	/**
	 * Copy Constructor
	 * @param copy
	 */
	public MPrintTableFormat(MPrintTableFormat copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy Constructor
	 * @param ctx
	 * @param copy
	 */
	public MPrintTableFormat(Properties ctx, MPrintTableFormat copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy Constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPrintTableFormat(Properties ctx, MPrintTableFormat copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.standard_Font = copy.standard_Font;
		this.funct_Font = copy.funct_Font;
		this.functBG_Color = copy.functBG_Color;
		this.functFG_Color = copy.functFG_Color;
		this.hdrLine_Color = copy.hdrLine_Color;
		this.header_Font = copy.header_Font;
		this.header_Stroke = copy.header_Stroke;
		this.headerBG_Color = copy.headerBG_Color;
		this.headerFG_Color = copy.headerFG_Color;
		this.lineH_Color = copy.lineH_Color;
		this.lineH_Stroke = copy.lineH_Stroke;
		this.lineV_Color = copy.lineV_Color;
		this.lineV_Stroke = copy.lineV_Stroke;
		this.m_image = copy.m_image;
		this.m_image_water_mark = copy.m_image_water_mark;
		this.pageFooter_Font = copy.pageFooter_Font;
		this.pageFooterBG_Color = copy.pageFooterBG_Color;
		this.pageFooterFG_Color = copy.pageFooterFG_Color;
		this.pageHeader_Font = copy.pageHeader_Font;
		this.pageHeaderBG_Color = copy.pageHeaderBG_Color;
		this.pageHeaderFG_Color = copy.pageHeaderFG_Color;
		this.parameter_Color = copy.parameter_Color;
		this.parameter_Font = copy.parameter_Font;
	}
	
	private Font 	standard_Font = new Font(null);

	private Font 	pageHeader_Font;
	private Font 	pageFooter_Font;
	private Color 	pageHeaderFG_Color;
	private Color 	pageHeaderBG_Color;
	private Color 	pageFooterFG_Color;
	private Color 	pageFooterBG_Color;

	private Font	parameter_Font;
	private Color	parameter_Color;

	private Font 	header_Font;
	private Color 	headerFG_Color;
	private Color 	headerBG_Color;
	private Color 	hdrLine_Color;
	private Stroke 	header_Stroke;		//	-

	private Font 	funct_Font;
	private Color 	functFG_Color;
	private Color 	functBG_Color;

	private Color 	lineH_Color;
	private Color 	lineV_Color;
	private Stroke 	lineH_Stroke;	//	-
	private Stroke 	lineV_Stroke;	//	|
	//
	private Image 	m_image = null;
	private Image 	m_image_water_mark = null;

	/**
	 * 	Set Standard Font to derive other fonts if not defined
	 * 	@param standardFont standard font
	 */
	public void setStandard_Font(Font standardFont)
	{
		if (standardFont != null)
			standard_Font = standardFont;
	}	//	setStandard_Font

	/**
	 * 	Get Standard Font
	 * 	@return standard font
	 */
	public Font getStandard_Font()
	{
		return standard_Font;
	}	//	getStandard_Font
	
	/**
	 * 	Get Table Header Font
	 * 	@return set table header font or fall back to the default of bold standard font
	 */
	public Font getHeader_Font()
	{
		if (header_Font != null)
			return header_Font;
		int i = getHdr_PrintFont_ID();
		if (i != 0)
			header_Font = MPrintFont.get(i).getFont();
		if (header_Font == null)
			header_Font = new Font (standard_Font.getName(), Font.BOLD, standard_Font.getSize());
		return header_Font;
	}	//	getHeader_Font

	/**
	 * 	Get Header Foreground
	 * 	@return set header foreground color or fallback to the default of black blue.
	 */
	public Color getHeaderFG_Color()
	{
		if (headerFG_Color != null)
			return headerFG_Color;
		int i = getHdrTextFG_PrintColor_ID();
		if (i != 0)
			headerFG_Color = MPrintColor.get(getCtx(), i).getColor();
		if (headerFG_Color == null)
			headerFG_Color = MPrintColor.blackBlue;
		return headerFG_Color;
	}	//	getHeaderFG_Color

	/**
	 *  Get Header BG Color
	 *  @return set header background color or fallback to the default of cyan
	 */
	public Color getHeaderBG_Color()
	{
		if (headerBG_Color != null)
			return headerBG_Color;
		int i = getHdrTextBG_PrintColor_ID();
		if (i != 0)
			headerBG_Color = MPrintColor.get(getCtx(), i).getColor();
		if (headerBG_Color == null)
			headerBG_Color = Color.cyan;
		return headerBG_Color;
	}	//	getHeaderBG_Color

	/**
	 *  Get Header Line Color
	 *  @return set header line color or fall back to the default of black blue
	 */
	public Color getHeaderLine_Color()
	{
		if (hdrLine_Color != null)
			return hdrLine_Color;
		int i = getHdrLine_PrintColor_ID();
		if (i != 0)
			hdrLine_Color = MPrintColor.get(getCtx(), i).getColor();
		if (hdrLine_Color == null)
			hdrLine_Color = MPrintColor.blackBlue;
		return hdrLine_Color;
	}	//	getHeaderLine_Color

	/**
	 * 	Get Header Stroke
	 *	@return Header Stroke (default solid 2pt)
	 */
	public Stroke getHeader_Stroke()
	{
		if (header_Stroke == null)
		{
			float width = getHdrStroke().floatValue();
			if (getHdrStrokeType() == null || HDRSTROKETYPE_SolidLine.equals(getHdrStrokeType()))
				header_Stroke = new BasicStroke(width);					//	-
			//
			else if (HDRSTROKETYPE_DashedLine.equals(getHdrStrokeType()))
				header_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDashed(width), 0.0f);				//	- -
			else if (HDRSTROKETYPE_DottedLine.equals(getHdrStrokeType()))
				header_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDotted(width), 0.0f);				//	. . .
			else if (HDRSTROKETYPE_Dash_DottedLine.equals(getHdrStrokeType()))
				header_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDash_Dotted(width), 0.0f);			//	- . -
			//	default / fallback
			if (header_Stroke == null)
				header_Stroke = new BasicStroke(width);					//	-
		}
		return header_Stroke;
	}	//	getHeader_Stroke
	
	/**
	 * 	Get Header Stroke for horizontal Lines
	 *	@return stroke in pt (default 2)
	 */
	public BigDecimal getHdrStroke()
	{
		BigDecimal retValue = super.getHdrStroke();
		if (retValue == null || Env.ZERO.compareTo(retValue) >= 0)
			retValue = BigDecimal.valueOf(2.0);
		return retValue;
	}	//	getHdrStroke

	/**
	 * 	Get Function Font
	 * 	@return set function font or fall back to the default of BoldItalic standard font
	 */
	public Font getFunct_Font()
	{
		if (funct_Font != null)
			return funct_Font;
		int i = getFunct_PrintFont_ID();
		if (i != 0)
			funct_Font = MPrintFont.get(i).getFont();
		if (funct_Font == null)
			funct_Font = new Font (standard_Font.getName(), Font.BOLD|Font.ITALIC, standard_Font.getSize());
		return funct_Font;
	}	//	getFunct_Font

	/**
	 *  Get Function BG Color
	 *  @return set function background color or fallback to the default of white
	 */
	public Color getFunctBG_Color()
	{
		if (functBG_Color != null)
			return functBG_Color;
		int i = getFunctBG_PrintColor_ID();
		if (i != 0)
			functBG_Color = MPrintColor.get(getCtx(), i).getColor();
		if (functBG_Color == null)
			functBG_Color = Color.white;
		return functBG_Color;
	}	//	getFunctBG_Color

	/**
	 *  Get Function FG Color
	 *  @return set function foreground color or fallback to the default of dark green
	 */
	public Color getFunctFG_Color()
	{
		if (functFG_Color != null)
			return functFG_Color;
		int i = getFunctFG_PrintColor_ID();
		if (i != 0)
			functFG_Color = MPrintColor.get(getCtx(), i).getColor();
		if (functFG_Color == null)
			functFG_Color = MPrintColor.darkGreen;
		return functFG_Color;
	}	//	getFunctFG_Color

	/**
	 * 	Get Parameter Font
	 *	@return set parameter font of fallback to the default of Italic standard font
	 */
	public Font getParameter_Font()
	{
		if (parameter_Font == null)
			parameter_Font = new Font (standard_Font.getName(), Font.ITALIC, standard_Font.getSize());
		return parameter_Font;
	}	//	getParameter_Font

	/**
	 * 	Get Parameter Color
	 *	@return set parameter color or fallback to the default of dark gray
	 */
	public Color getParameter_Color()
	{
		if (parameter_Color == null)
			parameter_Color = Color.darkGray;
		return parameter_Color;
	}	//	getParameter_Color

	/**
	 * 	Get Top Page Header Font
	 *	@return set page header font or fallback to the default of Bold standard font
	 */
	public Font getPageHeader_Font()
	{
		if (pageHeader_Font == null)
			pageHeader_Font = new Font (standard_Font.getName(), Font.BOLD, standard_Font.getSize());
		return pageHeader_Font;
	}	//	getPageHeader_Font

	/**
	 * 	Get Page Header FG_Color
	 *	@return set page header foreground color or fallback to the default of blue black
	 */
	public Color getPageHeaderFG_Color()
	{
		if (pageHeaderFG_Color == null)
			pageHeaderFG_Color = MPrintColor.blackBlue;
		return pageHeaderFG_Color;
	}	//	getPageHeaderFG_Color
	
	/**
	 * 	Get Page Header BG_Color
	 *	@return set page header background color or fallback to the default of white
	 */
	public Color getPageHeaderBG_Color()
	{
		if (pageHeaderBG_Color == null)
			pageHeaderBG_Color = Color.white;
		return pageHeaderBG_Color;
	}	//	getPageHeaderBG_Color

	/**
	 * 	Get Page Footer Font
	 *	@return set page footer font or fallback to the default of 2pt smaller standard font
	 */
	public Font getPageFooter_Font()
	{
		if (pageFooter_Font == null)
			pageFooter_Font = new Font (standard_Font.getName(), Font.PLAIN, standard_Font.getSize()-2);
		return pageFooter_Font;
	}	//	getPageFooter_Font
	
	/**
	 * 	Get PageFooter FG_Color
	 *	@return set page footer foreground color or fallback to the default of black blue
	 */
	public Color getPageFooterFG_Color()
	{
		if (pageFooterFG_Color == null)
			pageFooterFG_Color = MPrintColor.blackBlue;
		return pageFooterFG_Color;
	}	//	getPageFooterFG_Color
	
	/**
	 * 	Get Page Footer BG_Color
	 *	@return set page footer background color or fallback to the default of white
	 */
	public Color getPageFooterBG_Color()
	{
		if (pageFooterBG_Color == null)
			pageFooterBG_Color = Color.white;
		return pageFooterBG_Color;
	}	//	getPageFooterBG_Color

	/**
	 *  Get Horizontal Line Color.
	 *  @return set horizontal line color or fallback to the default of light gray
	 */
	public Color getHLine_Color()
	{
		if (lineH_Color != null)
			return lineH_Color;
		int i = getLine_PrintColor_ID();
		if (i != 0)
			lineH_Color = MPrintColor.get(getCtx(), i).getColor();
		if (lineH_Color == null)
			lineH_Color = Color.lightGray;
		return lineH_Color;
	}	//	getHLine_Color
	
	/**
	 *  Get Vertical Line Color.
	 *  @return set vertical line color or fallback to the default of light gray
	 */
	public Color getVLine_Color()
	{
		if (lineV_Color != null)
			return lineV_Color;
		int i = getLine_PrintColor_ID();
		if (i != 0)
			lineV_Color = MPrintColor.get(getCtx(), i).getColor();
		if (lineV_Color == null)
			lineV_Color = Color.lightGray;
		return lineV_Color;
	}	//	getVLine_Color

	/**
	 * 	Get Horizontal Line Stroke -
	 * 	(same DB line column)
	 *	@return solid line baded on line width (default solid 1p)
	 */
	public Stroke getHLine_Stroke()
	{
		if (lineH_Stroke == null)
		{
			float width = getLineStroke().floatValue() / 2;
			if (getHdrStrokeType() == null || LINESTROKETYPE_DottedLine.equals(getLineStrokeType()))
				lineH_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDotted(width), 0.0f);			//	. . .
			//		
			else if (LINESTROKETYPE_SolidLine.equals(getLineStrokeType()))
				lineH_Stroke = new BasicStroke(width);				//	-
			else if (LINESTROKETYPE_DashedLine.equals(getLineStrokeType()))
				lineH_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDashed(width), 0.0f);			//	- -
			else if (LINESTROKETYPE_Dash_DottedLine.equals(getLineStrokeType()))
				lineH_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDash_Dotted(width), 0.0f);		//	- . -
			//	default / fallback
			if (lineH_Stroke == null)
				lineH_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDotted(width), 0.0f);			//	. . .
		}
		return lineH_Stroke;
	}	//	getHLine_Stroke
	
	/**
	 * 	Get Vertical Line Stroke |
	 * 	(same DB line column)
	 *	@return line based on line (1/2 of) width and stroke (default dotted 1/2p 
	 */
	public Stroke getVLine_Stroke()
	{
		if (lineV_Stroke == null)
		{
			float width = getLineStroke().floatValue() / 2;
			if (getHdrStrokeType() == null || LINESTROKETYPE_DottedLine.equals(getLineStrokeType()))
				lineV_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDotted(width), 0.0f);			//	. . .
			//		
			else if (LINESTROKETYPE_SolidLine.equals(getLineStrokeType()))
				lineV_Stroke = new BasicStroke(width);				//	-
			else if (LINESTROKETYPE_DashedLine.equals(getLineStrokeType()))
				lineV_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDashed(width), 0.0f);			//	- -
			else if (LINESTROKETYPE_Dash_DottedLine.equals(getLineStrokeType()))
				lineV_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDash_Dotted(width), 0.0f);		//	- . -
			//	default / fallback
			if (lineV_Stroke == null)
				lineV_Stroke = new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL, 
					1.0f, getPatternDotted(width), 0.0f);			//	. . .
		}
		return lineV_Stroke;
	}	//	getVLine_Stroke

	/**
	 * 	Get Horizontal Stroke for Lines -
	 *	@return stroke in pt (default 1)
	 */
	public BigDecimal getLineStroke()
	{
		BigDecimal retValue = super.getLineStroke();
		if (retValue == null || Env.ZERO.compareTo(retValue) >= 0)
			retValue = Env.ONE;
		return retValue;
	}	//	getLineStroke

	/**
	 * 	Get Vertical Stroke for Lines |
	 *	@return stroke in pt (default 1)
	 */
	public BigDecimal getVLineStroke()
	{
		BigDecimal retValue = super.getLineStroke();
		if (retValue == null || Env.ZERO.compareTo(retValue) >= 0)
			retValue = Env.ONE;
		return retValue;
	}	//	getVLineStroke
	
	/**
	 * 	Get Pattern Dotted . . . .
	 *	@param width width of line
	 *	@return pattern
	 */
	private float[] getPatternDotted (float width)
	{
		return new float[] {2*width, 2*width};
	}	//	getPatternDotted

	/**
	 * 	Get Pattern Dashed - - - -
	 *	@param width width of line
	 *	@return pattern
	 */
	private float[] getPatternDashed (float width)
	{
		return new float[] {10*width, 4*width};
	}	//	getPatternDashed
	
	/**
	 * 	Get Pattern Dash Dotted - . - .
	 *	@param width width of line
	 *	@return pattern
	 */
	private float[] getPatternDash_Dotted (float width)
	{
		return new float[] {10*width, 2*width, 2*width, 2*width};
	}	//	getPatternDash_Dotted
		
	private static IntPOCopyCache<Integer,MPrintTableFormat>	s_cache
		= new IntPOCopyCache<Integer,MPrintTableFormat>(Table_Name, 3);
	/** Static Logger					*/
	private static CLogger 	s_log = CLogger.getCLogger(MPrintTableFormat.class);

	/**
	 * 	Get Print Table Format.
	 * 	@param ctx context
	 * 	@param AD_PrintTableFormat_ID print table format id, 0 to get default print table format
	 *  @param standard_font standard font
	 * 	@return Print Table Format
	 */
	static public MPrintTableFormat get (Properties ctx, int AD_PrintTableFormat_ID, Font standard_font)
	{
		Integer ii = Integer.valueOf(AD_PrintTableFormat_ID);
		MPrintTableFormat tf = s_cache.get(ii, e -> new MPrintTableFormat(ctx, e));
		if (tf == null)
		{
			if (AD_PrintTableFormat_ID == 0)
			{
				tf = getDefault (ctx);
			}
			else
			{
				tf = new MPrintTableFormat (ctx, AD_PrintTableFormat_ID, (String)null);
				if (tf.get_ID() != AD_PrintTableFormat_ID)
					return null;
			}
			s_cache.put(tf.get_ID(), tf, e -> new MPrintTableFormat(Env.getCtx(), e));
		}
		tf.setStandard_Font(standard_font);
		return tf;
	}	//	get

	/**
	 * 	Get Print Table Format
	 * 	@param ctx context
	 * 	@param AD_PrintTableFormat_ID print table format id, 0 to get default print table format
	 *  @param AD_PrintFont_ID standard font
	 * 	@return Print Table Format
	 */
	static public MPrintTableFormat get (Properties ctx, int AD_PrintTableFormat_ID, int AD_PrintFont_ID)
	{
		return get (ctx, AD_PrintTableFormat_ID, MPrintFont.get (AD_PrintFont_ID).getFont());
	}	//	get

	/**
	 * 	Get Default Print Table Format.
	 * 	@param ctx context
	 * 	@return Default Print Table Format (need to set standard font) 
	 */
	static public MPrintTableFormat getDefault (Properties ctx)
	{
		MPrintTableFormat tf = null;
		String sql = "SELECT * FROM AD_PrintTableFormat "
			+ "WHERE AD_Client_ID IN (0,?) AND IsActive='Y' "
			+ "ORDER BY IsDefault DESC, AD_Client_ID DESC";
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				tf = new MPrintTableFormat (ctx, rs, null);
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return tf;
	}	//	get
	
	/**
	 * 	Get the Image
	 *	@return image or null
	 */
	public Image getImage()
	{
		if(m_image != null)
		{
			return m_image;
		}
		//
		if(isImageIsAttached())
		{	
			MAttachment attachment = MAttachment.get(getCtx(), Table_ID, get_ID(), get_UUID(), null);
			if (attachment == null)
			{
				log.log(Level.WARNING, "No Attachment - ID=" + get_ID());
				return null;
			}
			if (attachment.getEntryCount() != 1)
			{
				log.log(Level.WARNING, "Need just 1 Attachment Entry = " + attachment.getEntryCount());
				return null;
			}
			byte[] imageData = attachment.getEntryData(0);
			if (imageData != null)
			{
				m_image = Toolkit.getDefaultToolkit().createImage(imageData);
			}
			if (m_image != null)
			{
				if (log.isLoggable(Level.FINE)) log.fine(attachment.getEntryName(0) + " - Size=" + imageData.length);
			}
			else
			{
				log.log(Level.WARNING, attachment.getEntryName(0) + " - not loaded (must be gif or jpg) - ID=" + get_ID());
			}
		}
		else if (getImageURL() != null)
		{		
			URL url;
			try 
			{
				url = new URL(getImageURL());
				Toolkit tk = Toolkit.getDefaultToolkit();
				m_image = tk.getImage(url);
			}
			catch (MalformedURLException e)
			{
				log.log(Level.WARNING, "Malformed URL - "+getImageURL(), e);
			}
		}
		return m_image;
	}	//	getImage
	
	/**
	 * 	Get the Image
	 *	@return image or null
	 */
	public Image getImageWaterMark()
	{
		if(m_image_water_mark != null)
		{
			return m_image_water_mark;
		}
		//
		if(getAD_Image_ID() > 0)
		{
			m_image_water_mark = MImage.get(getCtx(), getAD_Image_ID()).getImage();
		}
		return m_image_water_mark;
	}	//	getImage
	
	@Override
	public MPrintTableFormat markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MPrintTableFormat
