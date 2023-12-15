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

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogMgt;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.KeyNamePair;
import org.compiere.util.NamePair;

/**
 *	Product Attribute Lookup Model (no local lookup cache)
 *	
 *  @author Jorg Janke
 *  @version $Id: MPAttributeLookup.java,v 1.2 2006/07/30 00:58:38 jjanke Exp $
 *  
 *  @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1885260 ] MPAttributeLookup: throws SQLException sometimes
 */
public class MPAttributeLookup extends Lookup
	implements Serializable
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1877125428249819248L;

	/**
	 * 	Constructor
	 * 	@param ctx context
	 *	@param WindowNo window no
	 */
	public MPAttributeLookup(Properties ctx, int WindowNo)
	{
		super(DisplayType.TableDir, WindowNo);
	}	//	MPAttribute

	/**	No Instance Value			*/
	private static KeyNamePair	NO_INSTANCE = new KeyNamePair (0,"");

	/**
	 *	Get display text for key value (direct from DB)
	 *  @param key Location_ID
	 *  @return Display text
	 */
	@Override
	public String getDisplay (Object key)
	{
		if (key == null)
			return "";
		NamePair pp = get (key);
		if (pp == null)
			return "<" + key.toString() + ">";
		return pp.getName();
	}	//	getDisplay

	/**
	 *  The Lookup contains the key (direct check against DB)
	 *  @param key Location_ID
	 *  @return true if key exists
	 */
	@Override
	public boolean containsKey (Object key)
	{
		return get(key) != null;
	}   //  containsKey

	/**
	 * Same as {@link #containsKey(Object)} in this lookup implementation
	 */
	@Override
	public boolean containsKeyNoDirect (Object key)
	{
		return containsKey(key);
	}

	/**
	 *	Get KeyNamePair(M_AttributeSetInstance_ID, Description) of Key Value
	 *  @param key key value (M_AttributeSetInstance_ID)
	 *  @return KeyNamePair(M_AttributeSetInstance_ID, Description) or null
	 */
	public NamePair get (Object key)
	{
		if (key == null)
			return null;
		int M_AttributeSetInstance_ID = 0;
		if (key instanceof Integer)
			M_AttributeSetInstance_ID = ((Integer)key).intValue();
		else
		{
			try
			{
				M_AttributeSetInstance_ID = Integer.parseInt(key.toString());
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "Value=" + key, e);
			}
		}
		if (M_AttributeSetInstance_ID == 0)
			return NO_INSTANCE;
		//
		String Description = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement("SELECT Description "
					+ "FROM M_AttributeSetInstance "
					+ "WHERE M_AttributeSetInstance_ID=?", null);
			pstmt.setInt(1, M_AttributeSetInstance_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				Description = rs.getString(1);			//	Description
				if (Description == null || Description.length() == 0)
				{
					if (CLogMgt.isLevelFine())
						Description = "{" + M_AttributeSetInstance_ID + "}";
					else
						Description = "";
				}
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "get", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (Description == null)
			return null;
		return new KeyNamePair (M_AttributeSetInstance_ID, Description);
	}	//	get

	/**
	 * 	Dispose
	 *	@see org.compiere.model.Lookup#dispose()
	 */
	public void dispose()
	{
		if (log.isLoggable(Level.FINE)) log.fine("");
		super.dispose();
	}	//	dispose

	/**
	 *	Get list of lookup data - not implemented
	 *  @param mandatory mandatory
	 *  @param onlyValidated only validated
	 *  @param onlyActive only active
	 * 	@param temporary force load for temporary display
	 *  @return not implemented, always return null
	 */
	public ArrayList<Object> getData (boolean mandatory, boolean onlyValidated, boolean onlyActive, boolean temporary, boolean shortlist) // IDEMPIERE 90
	{
		log.log(Level.SEVERE, "Not implemented");
		return null;
	}   //  getArray

	/**
	 *  @return "M_AttributeSetInstance_ID"
	 */
	public String getColumnName()
	{
		return "M_AttributeSetInstance_ID";
	}	//	getColumnName

}	//	MPAttribute
