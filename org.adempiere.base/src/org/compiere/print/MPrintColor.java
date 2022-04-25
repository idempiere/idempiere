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

import java.awt.Color;
import java.awt.SystemColor;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.PO;
import org.compiere.model.X_AD_PrintColor;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	AD_PrintColor Print Color Model
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: MPrintColor.java,v 1.3 2006/07/30 00:53:02 jjanke Exp $
 */
public class MPrintColor extends X_AD_PrintColor implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 729053102783763723L;

	/**************************************************************************
	 * 	Create Color in Database and save
	 * 	@param color color
	 *  @param name name
	 * 	@return MPrintColor
	 */
	static MPrintColor create (Color color, String name)
	{
		MPrintColor pc = new MPrintColor (Env.getCtx(), 0, null);
		pc.setName(name);
		pc.setColor(color);
		pc.saveEx();
		return pc;
	}	//	create

	/*************************************************************************/

	/** Dark Green			*/
	public static final Color	darkGreen = new Color (0, 128, 0);
	/** Black Green			*/
	public static final Color	blackGreen = new Color (0, 64, 0);
	/** Dark Blue			*/
	public static final Color	darkBlue = new Color (0, 0, 128);
	/** Black Blue			*/
	public static final Color	blackBlue = new Color (0, 0, 64);
	/** White Gray			*/
	public static final Color	whiteGray = new Color (224, 224, 224);
	/** Brown				*/
	public static final Color	brown = new Color (153, 102, 51);
	/** Dark Brown			*/
	public static final Color	darkBrown = new Color (102, 51, 0);

	/*************************************************************************/

	/** Cached Colors						*/
	static private ImmutableIntPOCache<Integer,MPrintColor> 	s_colors = new ImmutableIntPOCache<Integer,MPrintColor>(Table_Name, 20);
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MPrintColor.class);

	/**
	 * 	Get Color from cache (immutable)
	 * 	if id = 0, it returns a new color (black) - but do not modify/save as cached
	 * 	@param AD_PrintColor_ID id
	 * 	@return Color
	 */
	static public MPrintColor get (int AD_PrintColor_ID)
	{
		return get(Env.getCtx(), AD_PrintColor_ID);
	}
	
	/**
	 * 	Get Color from cache (immutable)
	 * 	if id = 0, it returns a new color (black) - but do not modify/save as cached
	 * 	@param ctx context
	 * 	@param AD_PrintColor_ID id
	 * 	@return Color
	 */
	static public MPrintColor get (Properties ctx, int AD_PrintColor_ID)
	{
	//	if (AD_PrintColor_ID == 0)
	//		return new MPrintColor (ctx, 0);
		Integer key = Integer.valueOf(AD_PrintColor_ID);
		MPrintColor pc = s_colors.get(ctx, key, e -> new MPrintColor(ctx, e));
		if (pc == null)
		{
			pc = new MPrintColor (ctx, AD_PrintColor_ID, (String)null);
			if (pc.get_ID() == AD_PrintColor_ID)
			{
				s_colors.put(key, pc, e -> new MPrintColor(Env.getCtx(), e));
				return pc;
			}
			return null;
		}
		return pc;
	}	//	get

	/**
	 * 	Get Color
	 * 	@param ctx context
	 * 	@param AD_PrintColor_ID id
	 * 	@return Color or null
	 */
	static public MPrintColor get (Properties ctx, String AD_PrintColor_ID)
	{
		if (AD_PrintColor_ID == null || AD_PrintColor_ID.length() == 0)
			return null;
		try
		{
			int id = Integer.parseInt(AD_PrintColor_ID);
			return get(ctx, id);
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, "AD_PrintColor_ID=" + AD_PrintColor_ID
				+ " - " + e.toString());
		}
		return null;
	}	//	get
	
	
	/**************************************************************************
	 *	Constructor
	 *  @param ctx context
	 *  @param AD_PrintColor_ID ID
	 *  @param trxName transaction
	 */
	public MPrintColor(Properties ctx, int AD_PrintColor_ID, String trxName)
	{
		super (ctx, AD_PrintColor_ID, trxName);
		if (AD_PrintColor_ID == 0)
			setIsDefault(false);
	}	//	MPrintColor
	
	public MPrintColor(Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}

	/**
	 * 
	 * @param copy
	 */
	public MPrintColor(MPrintColor copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPrintColor(Properties ctx, MPrintColor copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPrintColor(Properties ctx, MPrintColor copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_cacheColor = copy.m_cacheColor;
	}
	
	/**	Color cached				*/
	private Color	m_cacheColor = null;

	/**
	 * 	Get Color
	 * 	@return Color
	 */
	public Color getColor()
	{
		if (m_cacheColor != null)
			return m_cacheColor;
		String code = getCode();
		if (code == null || code.equals("."))
			m_cacheColor = Color.black;
		try
		{
			if (code != null && !code.equals("."))
			{
				int rgba = Integer.parseInt(code);
				m_cacheColor = new Color(rgba, false);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "MPrintColor.getColor", e);
		}
		if (code == null)
			m_cacheColor = Color.black;
		return m_cacheColor;
	}	//	getColor

	/**
	 * 	Set Color
	 * 	@param color Color
	 */
	public void setColor (Color color)
	{
		int rgba = color.getRGB();
		super.setCode(String.valueOf(rgba));
	}	//	setColor

	/**
	 * 	Get Color as RRGGBB hex string for HTML font tag
	 *	@return	rgb hex value
	 */
	public String getRRGGBB()
	{
		Color color = getColor();
		StringBuilder sb = new StringBuilder();
		sb.append(Util.toHex((byte)color.getRed()))
			.append(Util.toHex((byte)color.getGreen()))
			.append(Util.toHex((byte)color.getBlue()));
		return sb.toString();
	}	//	getRRGGBB
	
	@Override
	public MPrintColor markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * 	String Representation
	 * 	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MPrintColor[");
		sb.append("ID=").append(get_ID())
			.append(",Name=").append(getName())
			.append(",RGB=").append(getCode())
			.append(",").append(getColor())
			.append("]");
		return sb.toString();
	}	//	toString
	
	
	/**************************************************************************
	 * 	Create Standard Colors
	 * 	@param args args
	 */
	public static void main(String[] args)
	{
		org.compiere.Adempiere.startupEnvironment(true);
		Color[] colors = new Color[]
			{Color.black, Color.red, Color.green, Color.blue,
			Color.darkGray, Color.gray, Color.lightGray, Color.white,
			Color.cyan, Color.magenta, Color.orange, Color.pink, Color.yellow,
			SystemColor.textHighlight};
		String[] names = new String[]
			{"Black", "Red", "Green", "Blue",
			"Gray dark", "Gray", "Gray light", "White",
			"Cyan", "Magenta", "Orange", "Pink", "Yellow",
			"Blue dark"};
		for (int i = 0; i < colors.length; i++)
			System.out.println(names[i] + " = " + colors[i] + " RGB=" + colors[i].getRGB()
				+ " -> " + new Color(colors[i].getRGB(), false)
				+ " -> " + new Color(colors[i].getRGB(), true));

		//	Read All Colors
		int[] IDs = PO.getAllIDs ("AD_PrintColor", null, null);
		for (int i = 0; i < IDs.length; i++)
		{
			MPrintColor pc = new MPrintColor(Env.getCtx(), IDs[i], null);
			System.out.println(IDs[i] + ": " + pc + " = " + pc.getColor() + ", RGB=" + pc.getColor().getRGB());
		}
	}	//	main
	
}	//	MPrintColor
