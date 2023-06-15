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
package org.compiere.server;

import java.util.logging.Level;

import org.compiere.util.CLogger;

/**
 *	Adempiere Server Group
 *	
 *  @author Jorg Janke
 *  @version $Id: AdempiereServerGroup.java,v 1.2 2006/07/30 00:53:33 jjanke Exp $
 */
public class AdempiereServerGroup extends ThreadGroup
{
	/**
	 * 	Get Adempiere Server Group
	 *	@return Server Group
	 */
	public static AdempiereServerGroup get()
	{
		if (s_group == null || s_group.isDestroyed())
			s_group = new AdempiereServerGroup(); 
		return s_group;
	}	//	get
	
	/** Group */
	private volatile static AdempiereServerGroup	s_group	= null;
	
	/**
	 * 	AdempiereServerGroup
	 */
	private AdempiereServerGroup ()
	{
		super ("AdempiereServers");
		setDaemon(true);
		setMaxPriority(Thread.MAX_PRIORITY);
		if (log.isLoggable(Level.INFO)) log.info(getName() + " - Parent=" + getParent());
	}	//	AdempiereServerGroup

	/**	Logger			*/
	protected CLogger	log = CLogger.getCLogger(getClass());
	
	/**
	 * 	Uncaught Exception
	 *	@param t thread
	 *	@param e exception
	 */
	public void uncaughtException (Thread t, Throwable e)
	{
		if (log.isLoggable(Level.INFO)) log.info ("uncaughtException = " + e.toString());
		super.uncaughtException (t, e);
	}	//	uncaughtException
	
	/**
	 * 	String Representation
	 *	@return name
	 */
	public String toString ()
	{
		return getName();
	}	//	toString

	/**
	 * 	Dump Info
	 */
	public void dump ()
	{
		if (log.isLoggable(Level.FINE)) log.fine(getName() + (isDestroyed() ? " (destroyed)" : ""));
		if (log.isLoggable(Level.FINE)) log.fine("- Parent=" + getParent());
		Thread[] list = new Thread[activeCount()];
		if (log.isLoggable(Level.FINE)) log.fine("- Count=" + enumerate(list, true));
		for (int i = 0; i < list.length; i++)
			if (log.isLoggable(Level.FINE)) log.fine("-- " + list[i]);
	}	//	dump

}	//	AdempiereServerGroup
