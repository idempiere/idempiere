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

import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

public class MReportView extends X_AD_ReportView implements ImmutablePOSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6065574433744333005L;
	
	/**	Cache					*/
	static private ImmutableIntPOCache<Integer,MReportView> s_cache = new ImmutableIntPOCache<Integer,MReportView>(Table_Name, 30, 60);
	
	
	public MReportView(Properties ctx, int AD_ReportView_ID, String trxName) {
		super(ctx, AD_ReportView_ID, trxName);
	}
	
	public MReportView(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * 
	 * @param copy
	 */
	public MReportView(MReportView copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MReportView(Properties ctx, MReportView copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MReportView(Properties ctx, MReportView copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * Get MReportView from cache (immutable)
	 * @param AD_ReportView_ID
	 * @return MReportView
	 */
	public static MReportView get (int AD_ReportView_ID) {
		return get(Env.getCtx(), AD_ReportView_ID);
	}
	
	/**
	 * Get MReportView from cache (immutable)
	 * @param ctx
	 * @param AD_ReportView_ID
	 * @return MReportView
	 */
	public static MReportView get (Properties ctx, int AD_ReportView_ID) {
		if(AD_ReportView_ID==0) {
			return null;
		}
		
		Integer key = Integer.valueOf(AD_ReportView_ID);
		MReportView retValue = s_cache.get(ctx, key, e -> new MReportView(ctx, e));
		if (retValue == null)
		{
			retValue = new MReportView (ctx, AD_ReportView_ID, (String)null);
			if (retValue.get_ID() == AD_ReportView_ID)
			{
				s_cache.put(key, retValue, e -> new MReportView(Env.getCtx(), e));
				return retValue;
			}
			return null;
		}
		return retValue;
	}	//	get
	
	@Override
	public MReportView markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
