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
package org.compiere.apps;

import java.awt.Container;

import javax.swing.JFrame;
import javax.swing.SwingUtilities;

import org.compiere.model.MPInstance;
import org.compiere.process.ProcessInfo;
import org.compiere.util.ASyncProcess;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 *	Process Interface Controller.
 *
 *  @author 	Jorg Janke
 *  @version 	$Id: ProcessCtl.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 *  @author Low Heng Sin
 *  - Added support for having description and parameter in one dialog
 *  - Added support to run db process remotely on server
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 				<li>BF [ 1757523 ] Server Processes are using Server's context
 * 				<li>FR [ 1807922 ] Pocess threads should have a better name
 * 				<li>BF [ 1960523 ] Server Process functionality not working
 */
public class ProcessCtl extends AbstractProcessCtl
{
	/**
	 *	Process Control
	 *  <code>
	 *	- Get Instance ID
	 *	- Get Parameters
	 *	- execute (lock - start process - unlock)
	 *  </code>
	 *  Creates a ProcessCtl instance, which calls
	 *  lockUI and unlockUI if parent is a ASyncProcess
	 *  <br>
	 *	Called from APanel.cmd_print, APanel.actionButton and
	 *  VPaySelect.cmd_generate
	 *
	 *  @param parent ASyncProcess & Container
	 *  @param WindowNo window no
	 *  @param pi ProcessInfo process info
	 *  @param trx Transaction
	 *  @return worker started ProcessCtl instance or null for workflow
	 */
	public static ProcessCtl process (ASyncProcess parent, int WindowNo, ProcessInfo pi, Trx trx)
	{
		log.fine("WindowNo=" + WindowNo + " - " + pi);

		MPInstance instance = null; 
		try 
		{ 
			instance = new MPInstance(Env.getCtx(), pi.getAD_Process_ID(), pi.getRecord_ID()); 
		} 
		catch (Exception e) 
		{ 
			pi.setSummary (e.getLocalizedMessage()); 
			pi.setError (true); 
			log.warning(pi.toString()); 
			return null; 
		} 
		catch (Error e) 
		{ 
			pi.setSummary (e.getLocalizedMessage()); 
			pi.setError (true); 
			log.warning(pi.toString()); 
			return null; 
		}
		if (!instance.save())
		{
			pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessNoInstance"));
			pi.setError (true);
			return null;
		}
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Get Parameters (Dialog)
		ProcessParameter para = new ProcessParameter (AEnv.getFrame((Container)parent), WindowNo, pi);
		if (para.initDialog())
		{
			para.setVisible(true);
			if (!para.isOK())
			{
				pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessCancelled"));
				pi.setError (true);
				return null;
			}
		}

		//	execute
		ProcessCtl worker = new ProcessCtl(parent, WindowNo, pi, trx);
		if (parent != null)
		{
			//asynchrous
			worker.start();
		}
		else
		{
			//synchrous
			worker.run();
		}
		return worker;
	}	//	execute
	
	/**
	 *	Async Process - Do it all.
	 *  <code>
	 *	- Get Instance ID
	 *	- Get Parameters
	 *	- execute (lock - start process - unlock)
	 *  </code>
	 *  Creates a ProcessCtl instance, which calls
	 *  lockUI and unlockUI if parent is a ASyncProcess
	 *  <br>
	 *	Called from ProcessDialog.actionPerformed
	 *
	 *  @param parent ASyncProcess & Container
	 *  @param WindowNo window no
	 *  @param paraPanel Process Parameter Panel
	 *  @param pi ProcessInfo process info
	 *  @param trx Transaction
	 *  @return worker started ProcessCtl instance or null for workflow
	 */
	public static ProcessCtl process(ASyncProcess parent, int WindowNo, IProcessParameter parameter, ProcessInfo pi, Trx trx)
	{
		log.fine("WindowNo=" + WindowNo + " - " + pi);

		MPInstance instance = null; 
		try 
		{ 
			instance = new MPInstance(Env.getCtx(), pi.getAD_Process_ID(), pi.getRecord_ID()); 
		} 
		catch (Exception e) 
		{ 
			pi.setSummary (e.getLocalizedMessage()); 
			pi.setError (true); 
			log.warning(pi.toString()); 
			return null; 
		} 
		catch (Error e) 
		{ 
			pi.setSummary (e.getLocalizedMessage()); 
			pi.setError (true); 
			log.warning(pi.toString()); 
			return null; 
		}
		if (!instance.save())
		{
			pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessNoInstance"));
			pi.setError (true);
			return null;
		}
		pi.setAD_PInstance_ID (instance.getAD_PInstance_ID());

		//	Get Parameters
		if (parameter != null) {
			if (!parameter.saveParameters())
			{
				pi.setSummary (Msg.getMsg(Env.getCtx(), "ProcessCancelled"));
				pi.setError (true);
				return null;
			}
		}

		//	execute
		ProcessCtl worker = new ProcessCtl(parent, WindowNo, pi, trx);
		if (parent != null)
		{
			worker.start();
		}
		else
		{
			//synchrous
			worker.run();
		}
		return worker;
	}	//	execute


	
	/**************************************************************************
	 *  Constructor
	 *  @param parent Container & ASyncProcess
	 *  @param pi Process info
	 *  @param trx Transaction
	 *  Created in process(), VInvoiceGen.generateInvoices
	 */
	public ProcessCtl (ASyncProcess parent, int WindowNo, ProcessInfo pi, Trx trx)
	{
		super(parent, WindowNo, pi, trx);
	}   //  ProcessCtl

	private Waiting         m_waiting;
	
	/**	Static Logger	*/
	private static CLogger	log	= CLogger.getCLogger (ProcessCtl.class);
	
	/**
	 *  Lock UI & show Waiting
	 */
	protected void lock ()
	{
	//	log.info("...");
		//m_parent is null for synchrous execution
		if (getParent() != null)
		{
			if (getParent() instanceof Container)
			{
				//swing client
				JFrame frame = AEnv.getFrame((Container)getParent());
				if (frame instanceof AWindow)
					((AWindow)frame).setBusyTimer(getProcessInfo().getEstSeconds());
				else
					m_waiting = new Waiting (frame, Msg.getMsg(Env.getCtx(), "Processing"), false, getProcessInfo().getEstSeconds());
				ProcessUpdateRunnable runnable = new ProcessUpdateRunnable() {					
					@Override
					public void run()
					{
						if (m_waiting != null)
						{
							m_waiting.toFront();
							m_waiting.setVisible(true);
						}
						
						log.finer("lock");
						parent.lockUI(pi);
					}
				};
				runnable.setParent(getParent());
				runnable.setProcessInfo(getProcessInfo());
				SwingUtilities.invokeLater(runnable);
			}
			else
			{
				//other client
				log.finer("lock");
				getParent().lockUI(getProcessInfo());
			}
		}
	}   //  lock

	/**
	 *  Unlock UI & dispose Waiting.
	 * 	Called from run()
	 */
	protected void unlock ()
	{
	//	log.info("...");
		if (getProcessInfo().isBatch())
			getProcessInfo().setIsTimeout(true);
		if (getParent() != null)
		{
			if (getParent() instanceof Container)
			{
				ProcessUpdateRunnable runnable = new ProcessUpdateRunnable()
				{
					@Override
					public void run()
					{
						// Remove Waiting/Processing Indicator
						if (m_waiting != null)
							m_waiting.dispose();
						m_waiting = null;
						
						String summary = pi.getSummary();
						log.finer("unlock - " + summary);
						if (summary != null && summary.indexOf('@') != -1)
							pi.setSummary(Msg.parseTranslation(Env.getCtx(), summary));
						parent.unlockUI(pi);
					}					
				};
				runnable.setParent(getParent());
				runnable.setProcessInfo(getProcessInfo());
				SwingUtilities.invokeLater(runnable);
			}
			else
			{
				//other client
				getParent().unlockUI(getProcessInfo());
			}
		}
	}   //  unlock

	@Override
	protected void updateProgressWindowTimerEstimate(int estSeconds) {
		if (m_waiting != null)
			m_waiting.setTimerEstimate(getProcessInfo().getEstSeconds());
	}

	@Override
	protected void updateProgressWindowTitle(String title) {
		if (m_waiting != null)
			m_waiting.setTitle(getProcessInfo().getTitle());		
	}

	abstract class ProcessUpdateRunnable implements Runnable
	{
		protected ProcessInfo pi = null;
		protected ASyncProcess parent = null;
		
		public void setProcessInfo(ProcessInfo pi)
		{
			this.pi = pi;
		}
		
		public void setParent(ASyncProcess parent) 
		{
			this.parent = parent;
		}
	}
}	//	ProcessCtl
