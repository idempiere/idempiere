/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Alejandro Falcone                                     *
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
* - Alejandro Falcone (afalcone@users.sourceforge.net)                *
*                      http://www.openbiz.com.ar                      *
*                                                                     * 
* Sponsors:                                                           *
* - Idalica Inc. (http://www.idalica.com)                             *
***********************************************************************/
package org.adempiere.process;


import java.util.logging.*;
import org.compiere.model.*;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
 
/**
 *  Close Deposit Batch.
 *
 *	@author Alejandro Falcone
 *	@version $Id: DepositBatchClose.java,v 1.2 2007/07/03 00:51:01 afalcone Exp $
 */
public class DepositBatchClose extends SvrProcess
{
	/**	Deposit Batch from Record			*/
	private int 		m_X_DepositBatch_ID = 0;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
		m_X_DepositBatch_ID = getRecord_ID();
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message (translated text)
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		MDepositBatch depositbatch = new MDepositBatch (getCtx(), m_X_DepositBatch_ID, get_TrxName());
		log.info("doIt - " + depositbatch);

		MDepositBatchLine[] depositbatchLines = depositbatch.getLines();
		
		//	Close lines
		for (int line = 0; line < depositbatchLines.length; line++)
		{
			depositbatchLines[line].setProcessed(true);
			depositbatchLines[line].save();
		}

		depositbatch.setProcessed(true);
		depositbatch.save();

		return "";
	}	//	doIt

}	//	DepositBatchClose
