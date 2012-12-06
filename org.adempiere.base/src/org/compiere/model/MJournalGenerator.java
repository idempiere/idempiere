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
public class MJournalGenerator extends X_GL_JournalGenerator
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8044550395699815424L;

	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MJournalGenerator.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param GL_JournalGenerator_ID id
	 *	@param trxName transaction
	 */
	public MJournalGenerator (Properties ctx, int GL_JournalGenerator_ID, String trxName)
	{
	      super (ctx, GL_JournalGenerator_ID, trxName);
	}	//	MJournalGenerator

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MJournalGenerator (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MJournalGenerator

	/**
	 * 	Get Journal Generator Lines of Journal Generator
	 * 	@return lines
	 */
	public MJournalGeneratorLine[] getLines ()
	{
		List<MJournalGeneratorLine> list = new Query(getCtx(), MJournalGeneratorLine.Table_Name, "GL_JournalGenerator_ID=?", get_TrxName())
			.setOnlyActiveRecords(true)
			.setParameters(getGL_JournalGenerator_ID())
			.setOrderBy(MJournalGeneratorLine.COLUMNNAME_SeqNo)
			.list();
		//
		MJournalGeneratorLine[] lines = new MJournalGeneratorLine[list.size()];
		list.toArray(lines);
		return lines;
	}	//	getLines

}	//	MJournalGenerator
