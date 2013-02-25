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
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

/**
 *  Color Persistent Object Model
 *  (DisplayType=27)
 *
 *  @author Jorg Janke
 *  @version $Id: MColor.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MColor extends X_AD_Color
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8672637038417465668L;

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
	 *  String Representation
	 *  @return string
	 */
	public String toString()
	{
		StringBuilder msgreturn = new StringBuilder("MColor[ID=").append(get_ID()).append(" - ").append(getName()).append("]");
		return msgreturn.toString();
	}   //  toString

	/**
	 *  Load Special data (images, ..).
	 *  To be extended by sub-classes
	 *  @param rs result set
	 *  @param index zero based index
	 *  @return value
	 *  @throws SQLException
	 */
	protected Object loadSpecial (ResultSet rs, int index) throws SQLException
	{
		if (log.isLoggable(Level.CONFIG)) log.config(p_info.getColumnName(index));
		if (index == get_ColumnIndex("ColorType"))
			return rs.getString(index+1);
		return null;
	}   //  loadSpecial


	/**
	 *  Save Special Data.
	 *      AD_Image_ID (Background)
	 *  @param value value
	 *  @param index index
	 *  @return SQL code for INSERT VALUES clause
	 */
	protected String saveNewSpecial (Object value, int index)
	{
		String colName = p_info.getColumnName(index);
		String colValue = value == null ? "null" : value.getClass().toString();
		log.fine(colName + "=" + colValue);
		if (value == null)
			return "NULL";
		return value.toString();
	}   //  saveNewSpecial
		
	/**
	 *  Get Color
	 *  @param primary true if primary false if secondary
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
