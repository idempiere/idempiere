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
 * Contributor(s): ______________________________________.                    *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.DB;

/**
 *	Package Export Model
 *	
 *  @author Rob Klein
 *  @version $Id: MMenu.java,v 1.0 2006/01/07 Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1826273 ] Error when creating MPackageExp
 */
public class MPackageExp extends X_AD_Package_Exp
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6295261491885604619L;

	/**
	 * MPackageExp
	 * @param ctx
	 * @param AD_Package_Exp_ID
	 * @param trxName
	 */
	public MPackageExp (Properties ctx, int AD_Package_Exp_ID, String trxName)
	{
		super(ctx, AD_Package_Exp_ID, trxName);		
		
	}	//	MPackageExp

	/**
	 * 	MPackageExp
	 *	@param ctx
	 *	@param rs
	 */
	public MPackageExp (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);		
		
	}	//	MPackageExp
		
	/**
	 * 	Before Delete
	 *	@param success
	 *	@return deleted
	 */
	protected boolean afterDelete (boolean success)
	{
	 String sql = "DELETE FROM AD_Package_Exp_Detail WHERE AD_Package_Exp_ID = "+ getAD_Package_Exp_ID();
	 
	 int deleteSuccess = DB.executeUpdate(sql, get_TrxName());
	 if (deleteSuccess == -1)
		return false;
	 return true;
	}	//	afterDelete

	/**
	 * @param from the source MPackageExp to copy the details
	 * @return
	 */
	public int copyDetailsFrom(MPackageExp from) {
		int count = 0;
		for (MPackageExpDetail fromDetail : from.getDetails()) {
			MPackageExpDetail toDetail = new MPackageExpDetail(getCtx(), 0, get_TrxName());
			PO.copyValues(fromDetail, toDetail, getAD_Client_ID(), getAD_Org_ID());
			toDetail.setAD_Package_Exp_ID(getAD_Package_Exp_ID());
			toDetail.saveEx();
			count++;
		}
		return count;
	}	//	copyDetailsFrom

	/**
	 * Get the details of a packout definition
	 * @return array of details
	 */
	private List<MPackageExpDetail> getDetails() {
		final String where = "AD_Package_Exp_ID=?";
		final String orderBy = "Line, AD_Package_Exp_ID";
		List<MPackageExpDetail> list = new Query(getCtx(), MPackageExpDetail.Table_Name, where, get_TrxName())
				.setParameters(getAD_Package_Exp_ID())
				.setOrderBy(orderBy)
				.setOnlyActiveRecords(true)
				.list();
		return list;
	}

}	//	MPackageExp
