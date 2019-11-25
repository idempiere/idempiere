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
package org.compiere.install;

import java.io.File;
import java.util.logging.Level;

import org.compiere.util.CLogMgt;


/**
 *	Java VM Configuration
 *
 *  @author Jorg Janke
 */
public class ConfigVM extends Config
{
	/**
	 * 	ConfigVM
	 * 	@param data configuration
	 */
	public ConfigVM (ConfigurationData data)
	{
		super (data);
	}	//	ConfigVMSun

	/**
	 * 	Init
	 */
	public void init()
	{
		//	Java Home, e.g. D:\j2sdk1.4.1\jre
		String javaHome = System.getProperty("java.home");
		log.fine(javaHome);
		p_data.setJavaHome(javaHome);
	}	//	init

	/**
	 * 	Test
	 *	@return error message or null of OK
	 */
	public String test()
	{
		//	Java Home
		File javaHome = new File (p_data.getJavaHome());
		boolean pass = javaHome.exists();
		String error = "Not found: Java Home";
		if (getPanel() != null)
			signalOK(getPanel().okJavaHome, "ErrorJavaHome",
				pass, true, error);
		if (!pass)
			return error;
		//
		if (CLogMgt.isLevelFinest())
			CLogMgt.printProperties(System.getProperties(), "System", true);
		//
		if (log.isLoggable(Level.INFO)) log.info("OK: JavaHome=" + javaHome.getAbsolutePath());
		setProperty(ConfigurationData.JAVA_HOME, javaHome.getAbsolutePath());
		System.setProperty(ConfigurationData.JAVA_HOME, javaHome.getAbsolutePath());

		//	Java Version
		pass = false;
		String thisJV = System.getProperty("java.version");
		int pointPos = thisJV.indexOf(".");
		int thisJVint = 0;
		if (pointPos >= 0)
			thisJVint = Integer.valueOf(thisJV.substring(0, pointPos));
		else
			thisJVint = Integer.valueOf(thisJV);
		int minSupportedVersion = 11;
		pass = thisJVint >= minSupportedVersion;
		if (pass)
		{
			if (log.isLoggable(Level.INFO)) log.info("OK: Version=" + thisJV);
		}			
		
		error = "Wrong Java Version = " + thisJV + ": Should be " + minSupportedVersion + " and above.";
		if (getPanel() != null)
			signalOK(getPanel().okJavaHome, "ErrorJavaHome",
					pass, true, error);
		if (!pass)
			return error;

		return null;
	}	//	test

}
