/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CLogger;

/**
 *	GL Journal Generator Model
 *
 *  @author Carlos Ruiz - GlobalQSS
 */
public class MJournalGeneratorSource extends X_GL_JournalGeneratorSource
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7489445330989092988L;

	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MJournalGeneratorSource.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param GL_JournalGeneratorSource_ID id
	 *	@param trxName transaction
	 */
	public MJournalGeneratorSource (Properties ctx, int GL_JournalGeneratorSource_ID, String trxName)
	{
	      super (ctx, GL_JournalGeneratorSource_ID, trxName);
	}	//	MJournalGeneratorSource

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MJournalGeneratorSource (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MJournalGeneratorSource

}	//	MJournalGeneratorSource
