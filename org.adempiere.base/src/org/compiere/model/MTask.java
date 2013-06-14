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
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Task;

/**
 * 	Operating Task Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MTask.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class MTask extends X_AD_Task
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5286481246615520755L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Task_ID id
	 *	@param trxName trx
	 */
	public MTask (Properties ctx, int AD_Task_ID, String trxName)
	{
		super (ctx, AD_Task_ID, trxName);
	}	//	MTask

	/**
	 * 	Load Cosntructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MTask (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MTask
	
	/**	Actual Task			*/
	private Task m_task = null;
	
	/**
	 * 	Execute Task and wait
	 *	@return execution info
	 */
	public String execute()
	{
		String cmd = Msg.parseTranslation(Env.getCtx(), getOS_Command()).trim();
		if (cmd == null || cmd.equals(""))
			return "Cannot execute '" + getOS_Command() + "'";
		//
		if (isServerProcess())
			return executeRemote(cmd);
		return executeLocal(cmd);
	}	//	execute
	
	/**
	 * 	Execute Task locally and wait
	 * 	@param cmd command
	 *	@return execution info
	 */
	public String executeLocal(String cmd)
	{
		log.config(cmd);
		if (m_task != null && m_task.isAlive())
			m_task.interrupt();

		m_task = new Task(cmd);
		m_task.start();

		StringBuilder sb = new StringBuilder();
		while (true)
		{
			//  Give it a bit of time
			try
			{
				Thread.sleep(500);
			}
			catch (InterruptedException ioe)
			{
				log.log(Level.SEVERE, cmd, ioe);
			}
			//  Info to user
			sb.append(m_task.getOut())
				.append("\n-----------\n")
				.append(m_task.getErr())
				.append("\n-----------");

			//  Are we done?
			if (!m_task.isAlive())
				break;
		}
		log.config("done");
		return sb.toString();
	}	//	executeLocal
	
	/**
	 * 	Execute Task locally and wait
	 * 	@param cmd command
	 *	@return execution info
	 */
	public String executeRemote(String cmd)
	{
		log.config(cmd);
		return "Remote:\n";
	}	//	executeRemote
	
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MTask[");
		sb.append(get_ID())
			.append("-").append(getName())
			.append(";Server=").append(isServerProcess())
			.append(";").append(getOS_Command())
			.append ("]");
		return sb.toString ();
	}	//	toString

	/**
	 *  After Save.
	 *  @param newRecord new record
	 *  @param success success
	 *  @return true if save complete (if not overwritten true)
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (log.isLoggable(Level.FINE)) log.fine("Success=" + success);
		if (!success)
			return success;
		if (! newRecord)
		{
			//	Menu/Workflow
			if (is_ValueChanged("IsActive") || is_ValueChanged("Name") 
				|| is_ValueChanged("Description"))
			{
				MMenu[] menues = MMenu.get(getCtx(), "AD_Task_ID=" + getAD_Task_ID(), get_TrxName());
				for (int i = 0; i < menues.length; i++)
				{
					menues[i].setIsActive(isActive());
					menues[i].setName(getName());
					menues[i].setDescription(getDescription());
					menues[i].saveEx();
				}
			}
		}

		return success;
	}   //  afterSave

}	//	MTask
