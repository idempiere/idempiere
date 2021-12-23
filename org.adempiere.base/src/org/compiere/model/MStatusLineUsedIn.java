/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Msg;

/**
 *	Status Line Used In Model
 *	
 *  @author Carlos Ruiz
 *  @version $Id: MStatusLineUsedIn.java
 */
public class MStatusLineUsedIn extends X_AD_StatusLineUsedIn
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6341924761622666560L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_StatusLineUsedIn_ID
	 *	@param trxName transaction
	 */
	public MStatusLineUsedIn (Properties ctx, int AD_StatusLineUsedIn_ID, String trxName)
	{
		super (ctx, AD_StatusLineUsedIn_ID, trxName);
	}	//	MStatusLineUsedIn

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MStatusLineUsedIn (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MStatusLineUsedIn

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (getAD_Table_ID() > 0) {
			setAD_Window_ID(0);
			setAD_Tab_ID(0);
		} else {
			if (getAD_Window_ID() <= 0) {
				log.saveError("SaveError", Msg.parseTranslation(getCtx(), "@FillMandatory@ @AD_Table_ID@ @AD_Window_ID@"));
				return false;
			}
		}
		return true;
	}

}	//	MStatusLineUsedIn
