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

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.util.Env;


/**
 *	Resource Assignment Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MResourceAssignment.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MResourceAssignment extends X_S_ResourceAssignment
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4230793339153210998L;

	/**
	 * 	Stnadard Constructor
	 *	@param ctx
	 *	@param S_ResourceAssignment_ID
	 */
	public MResourceAssignment (Properties ctx, int S_ResourceAssignment_ID, String trxName)
	{
		super (ctx, S_ResourceAssignment_ID, trxName);
		p_info.setUpdateable(true);		//	default table is not updateable
		//	Default values
		if (S_ResourceAssignment_ID == 0)
		{
			setAssignDateFrom(new Timestamp(System.currentTimeMillis()));
			setQty(Env.ONE);
			setName(".");
			setIsConfirmed(false);
		}
	}	//	MResourceAssignment

	/**
	 * 	Load Contsructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MResourceAssignment (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MResourceAssignment
	
	
	/**
	 *  String Representation
	 *  @return string
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MResourceAssignment[ID=");
		sb.append(get_ID())
			.append(",S_Resource_ID=").append(getS_Resource_ID())
			.append(",From=").append(getAssignDateFrom())
			.append(",To=").append(getAssignDateTo())
			.append(",Qty=").append(getQty())
			.append("]");
		return sb.toString();
	}   //  toString

	/**
	 * 	Before Delete
	 *	@return true if not confirmed
	 */
	protected boolean beforeDelete ()
	{
		//	 allow to delete, when not confirmed
		if (isConfirmed())
			return false;
		
		return true;
	}	//	beforeDelete
	
}	//	MResourceAssignment
