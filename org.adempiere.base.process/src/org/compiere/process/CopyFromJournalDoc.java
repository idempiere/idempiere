/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2011-2012 iDempiere Open Source ERP All Rights Reserved.     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.process;


import java.math.BigDecimal;
import java.util.logging.Level;

import org.compiere.model.MJournal;

/**
 *  Copy GL Journal/Lines
 *
 *	@author Carlos Ruiz
 */
public class CopyFromJournalDoc extends SvrProcess
{
	private int		m_GL_Journal_ID = 0;

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
			else if (name.equals("GL_Journal_ID"))
				m_GL_Journal_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message (clear text)
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		int To_GL_Journal_ID = getRecord_ID();
		if (log.isLoggable(Level.INFO)) log.info("doIt - From GL_Journal_ID=" + m_GL_Journal_ID + " to " + To_GL_Journal_ID);
		if (To_GL_Journal_ID == 0)
			throw new IllegalArgumentException("Target GL_Journal_ID == 0");
		if (m_GL_Journal_ID == 0)
			throw new IllegalArgumentException("Source GL_Journal_ID == 0");
		MJournal from = new MJournal (getCtx(), m_GL_Journal_ID, get_TrxName());
		MJournal to = new MJournal (getCtx(), To_GL_Journal_ID, get_TrxName());
		//
		int no = to.copyLinesFrom(from, from.getDateAcct(), 'x');
		//
		return "@Copied@=" + no;
	}	//	doIt

}
