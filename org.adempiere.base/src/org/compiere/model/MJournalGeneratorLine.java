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
import java.util.List;
import java.util.Properties;

import org.compiere.util.CLogger;

/**
 *	GL Journal Generator Model
 *
 *  @author Carlos Ruiz - GlobalQSS
 */
public class MJournalGeneratorLine extends X_GL_JournalGeneratorLine
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8151648371117046820L;

	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MJournalGeneratorLine.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param GL_JournalGeneratorLine_ID id
	 *	@param trxName transaction
	 */
	public MJournalGeneratorLine (Properties ctx, int GL_JournalGeneratorLine_ID, String trxName)
	{
	      super (ctx, GL_JournalGeneratorLine_ID, trxName);
	}	//	MJournalGeneratorLine

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MJournalGeneratorLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MJournalGeneratorLine

	/**
	 * 	Get Journal Generator Sources of Journal Generator Line
	 * 	@return sources
	 */
	public MJournalGeneratorSource[] getSources ()
	{
		List<MJournalGeneratorSource> list = new Query(getCtx(), MJournalGeneratorSource.Table_Name, "GL_JournalGeneratorLine_ID=?", get_TrxName())
			.setOnlyActiveRecords(true)
			.setParameters(getGL_JournalGeneratorLine_ID())
			.list();
		//
		MJournalGeneratorSource[] sources = new MJournalGeneratorSource[list.size()];
		list.toArray(sources);
		return sources;
	}	//	getSources

}	//	MJournalGeneratorLine
