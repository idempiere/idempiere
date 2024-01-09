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

import java.awt.Color;
import java.sql.ResultSet;
import java.util.Properties;

/**
 *  Color Model
 *  (DisplayType=27)
 *
 *  @author Jorg Janke
 *  @version $Id: MColor.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MColor extends X_AD_Color
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -2721945803283036539L;

	/**
	 *  Color Model
	 *  @param ctx context
	 *  @param AD_Color_ID color
	 *	@param trxName transaction
	 */
	public MColor(Properties ctx, int AD_Color_ID, String trxName)
	{
		super (ctx, AD_Color_ID, trxName);
		if (AD_Color_ID == 0)
			setName("-/-");
	}   //  MColor

	/**
	 * @param ctx
	 * @param AD_Color_UU
	 * @param trxName
	 */
	public MColor(Properties ctx, String AD_Color_UU, String trxName)
	{
		super (ctx, AD_Color_UU, trxName);
		if (AD_Color_UU.length() == 0)
			setName("-/-");
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MColor(Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}

	/**
	 *  String Representation
	 *  @return string
	 */
	@Override
	public String toString()
	{
		StringBuilder msgreturn = new StringBuilder("MColor[ID=").append(get_ID()).append(" - ").append(getName()).append("]");
		return msgreturn.toString();
	}   //  toString

	/**
	 *  Get Color
	 *  @param primary true for primary color model (usually rgb), false for secondary color model (usually cmy)
	 *  @return Color
	 */
	public Color getColor (boolean primary)
	{
		int red = primary ? getRed() : getRed_1();
		int green = primary ? getGreen() : getGreen_1();
		int blue = primary ? getBlue() : getBlue_1();
		//
		return new Color (red, green, blue);
	}   //  getColor

	/**
	 *  Get URL from Image
	 *  @param AD_Image_ID image
	 *  @return URL as String or null
	 */
	public String getURL (int AD_Image_ID)
	{
		if (AD_Image_ID == 0)
			return null;
		return MImage.get(getCtx(), AD_Image_ID).getImageURL();
	}   //  getURL

}   //  MColor
