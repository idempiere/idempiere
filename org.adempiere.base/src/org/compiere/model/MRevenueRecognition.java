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
import java.util.List;
import java.util.Properties;


/**
 *	Revenue Recognition Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MRevenueRecognition.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MRevenueRecognition extends X_C_RevenueRecognition
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8528224265258285903L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_RevenueRecognition_ID id
	 */
	public MRevenueRecognition (Properties ctx, int C_RevenueRecognition_ID, String trxName)
	{
		super (ctx, C_RevenueRecognition_ID, trxName);
	}	//	MRevenueRecognition

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MRevenueRecognition (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRevenueRecognition
	
	public List<MRevenueRecogService> getServicesList() {
		
		if ( isTimeBased() )
			return null;
		
		Query query = new Query(getCtx(),MRevenueRecogService.Table_Name, "C_RevenueRecognition_ID = ?",get_TrxName());
		query.setParameters(getC_RevenueRecognition_ID());
		query.setOnlyActiveRecords(true);
		query.setOrderBy("Line");
		
		return query.list();
	}
	
	public static List<MRevenueRecognition> getAll(Properties ctx, String trxName) {
		Query query = new Query(ctx,MRevenueRecognition.Table_Name, null, trxName);
		return query.list();
	}
	
}	//	MRevenueRecognition
