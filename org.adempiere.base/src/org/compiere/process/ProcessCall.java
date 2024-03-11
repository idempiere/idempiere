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
package org.compiere.process;

import java.util.Properties;

import org.adempiere.util.IProcessUI;
import org.adempiere.util.ProcessUtil;
import org.compiere.util.Trx;

/**
 *  Interface to start a server process.
 *  <p>
 *  ServerProcessCtl creates the Object and calls startProcess
 *  before executing the optional SQL procedure and Report.
 *
 *  @see ServerProcessCtl
 *  @see ProcessUtil
 *  @author     Jorg Janke
 *  @version    $Id: ProcessCall.java,v 1.3 2006/07/30 00:54:44 jjanke Exp $
 */
public interface ProcessCall
{
	/**
	 *  Start the process.
	 *
	 *  @param ctx  Context
	 *  @param pi	Process Info
	 *  @param trx	transaction
	 *  @return true if success
	 */
	public boolean startProcess (Properties ctx, ProcessInfo pi, Trx trx);

	/**
	 * Set process UI interface
	 * @param processUI
	 */
	public void setProcessUI(IProcessUI processUI);

}   //  ProcessCall
