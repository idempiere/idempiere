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
package org.compiere;

import java.awt.Image;
import java.awt.Toolkit;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.logging.Level;

import javax.jnlp.BasicService;
import javax.jnlp.ServiceManager;
import javax.jnlp.UnavailableServiceException;
import javax.swing.ImageIcon;
import javax.swing.event.EventListenerList;

import org.adempiere.base.Core;
import org.compiere.db.CConnection;
import org.compiere.model.MClient;
import org.compiere.model.MSystem;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.util.CLogFile;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Login;
import org.compiere.util.SecureEngine;
import org.compiere.util.SecureInterface;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.eclipse.core.runtime.IProduct;
import org.eclipse.core.runtime.Platform;
import org.osgi.framework.Bundle;

/**
 *  Adempiere Control Class
 *
 *  @author Jorg Janke
 *  @version $Id: Adempiere.java,v 1.8 2006/08/11 02:58:14 jjanke Exp $
 *
 */
public final class Adempiere
{
	/** Timestamp                   */
	static public final String	ID				= "$Id: Adempiere.java,v 1.8 2006/08/11 02:58:14 jjanke Exp $";
	/** Main Version String         */
	// Conventions for naming second number is even for stable, and odd for unstable
	// the releases will have a suffix (a) for alpha - (b) for beta - (t) for trunk - (s) for stable - and (LTS) for long term support
	static public String	MAIN_VERSION	= "Release 1.0a";
	/** Detail Version as date      Used for Client/Server		*/
	static public String	DATE_VERSION	= "2012-10-31";
	/** Database Version as date    Compared with AD_System		*/
	static public String	DB_VERSION		= "2012-10-31";

	/** Product Name            */
	static public final String	NAME 			= "iDempiere\u00AE";
	/** URL of Product          */
	static public final String	URL				= "www.idempiere.org";
	/** 16*16 Product Image. **/
	static private final String	s_File16x16		= "images/AD16.gif";
	/** 32*32 Product Image.   	*/
	static private final String	s_file32x32		= "images/AD32.gif";
	/** 100*30 Product Image.  	*/
	static private final String	s_file100x30	= "images/AD10030.png";
	/** 48*15 Product Image.   	*/
	static private final String	s_file48x15		= "images/Adempiere.png";
	static private final String	s_file48x15HR	= "images/AdempiereHR.png";
	/** Support Email           */
	static private String		s_supportEmail	= "";

	/** Subtitle                */
	static public final String	SUB_TITLE		= "Smart Suite ERP, CRM and SCM";
	static public final String	ADEMPIERE_R		= "iDempiere\u00AE";
	static public final String	COPYRIGHT		= "\u00A9 1999-2013 iDempiere\u00AE";

	static private String		s_ImplementationVersion = null;
	static private String		s_ImplementationVendor = null;

	static private Image 		s_image16;
	static private Image 		s_image48x15;
	static private Image 		s_imageLogo;
	static private ImageIcon 	s_imageIcon32;
	static private ImageIcon 	s_imageIconLogo;

	static private final String ONLINE_HELP_URL = "http://wiki.idempiere.org";

	/**	Logging								*/
	private static CLogger		log = null;
	
	/** Thread pool **/
	private static ScheduledThreadPoolExecutor threadPoolExecutor = null;
	
	 /** A list of event listeners for this component.	*/
    private static EventListenerList m_listenerList = new EventListenerList();

	static {
		ClassLoader loader = Adempiere.class.getClassLoader();
		InputStream inputStream = loader.getResourceAsStream("org/adempiere/version.properties");
		if (inputStream != null)
		{
			Properties properties = new Properties();
			try {
				properties.load(inputStream);
				if (properties.containsKey("MAIN_VERSION"))
					MAIN_VERSION = properties.getProperty("MAIN_VERSION");
				if (properties.containsKey("DATE_VERSION"))
					DATE_VERSION = properties.getProperty("DATE_VERSION");
				if (properties.containsKey("DB_VERSION"))
					DB_VERSION = properties.getProperty("DB_VERSION");
				if (properties.containsKey("IMPLEMENTATION_VERSION"))
					s_ImplementationVersion = properties.getProperty("IMPLEMENTATION_VERSION");
				if (properties.containsKey("IMPLEMENTATION_VENDOR"))
					s_ImplementationVendor = properties.getProperty("IMPLEMENTATION_VENDOR");
			} catch (IOException e) {
			}
		}
	}

	/**
	 *  Get Product Name
	 *  @return Application Name
	 */
	public static String getName()
	{
		return NAME;
	}   //  getName

	/**
	 *  Get Product Version
	 *  @return Application Version
	 */
	public static String getVersion()
	{
		IProduct product = Platform.getProduct();
		if (product != null) {
			Bundle bundle = product.getDefiningBundle();
			if (bundle != null) {
				return bundle.getVersion().toString();
			}
		}
		return "Unknown";
	}   //  getVersion

	public static String getDatabaseVersion() 
	{
		return DB.getSQLValueString(null, "select lastmigrationscriptapplied from ad_system");
	}
	
	/**
	 *	Short Summary (Windows)
	 *  @return summary
	 */
	public static String getSum()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(NAME).append(" ").append(MAIN_VERSION).append(SUB_TITLE);
		return sb.toString();
	}	//	getSum

	/**
	 *	Summary (Windows).
	 * 	iDempiere(tm) Release 1.0a_2012-10-31 -Smart Suite ERP, CRM and SCM- Copyright (c) 1999-2012 iDempiere; Implementation: 2.5.1a 20040417-0243 - (C) 1999-2005 Jorg Janke, iDempiere Inc. USA
	 *  @return Summary in Windows character set
	 */
	public static String getSummary()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(NAME).append(" ")
			.append(MAIN_VERSION).append("_").append(DATE_VERSION)
			.append(" -").append(SUB_TITLE)
			.append("- ").append(COPYRIGHT)
			.append("; Implementation: ").append(getImplementationVersion())
			.append(" - ").append(getImplementationVendor());
		return sb.toString();
	}	//	getSummary

	/**
	 * 	Set Package Info
	 */
	private static void setPackageInfo()
	{
		if (s_ImplementationVendor != null)
			return;

		Package adempierePackage = Package.getPackage("org.compiere");
		s_ImplementationVendor = adempierePackage.getImplementationVendor();
		s_ImplementationVersion = adempierePackage.getImplementationVersion();
		if (s_ImplementationVendor == null)
		{
			s_ImplementationVendor = "Supported by iDempiere community";
			s_ImplementationVersion = "iDempiere";
		}
	}	//	setPackageInfo

	/**
	 * 	Get Jar Implementation Version
	 * 	@return Implementation-Version
	 */
	public static String getImplementationVersion()
	{
		if (s_ImplementationVersion == null)
			setPackageInfo();
		return s_ImplementationVersion;
	}	//	getImplementationVersion

	/**
	 * 	Get Jar Implementation Vendor
	 * 	@return Implementation-Vendor
	 */
	public static String getImplementationVendor()
	{
		if (s_ImplementationVendor == null)
			setPackageInfo();
		return s_ImplementationVendor;
	}	//	getImplementationVendor

	/**
	 *  Get Checksum
	 *  @return checksum
	 */
	public static int getCheckSum()
	{
		return getSum().hashCode();
	}   //  getCheckSum

	/**
	 *	Summary in ASCII
	 *  @return Summary in ASCII
	 */
	public static String getSummaryAscii()
	{
		String retValue = getSummary();
		//  Registered Trademark
		retValue = Util.replace(retValue, "\u00AE", "(r)");
		//  Trademark
		retValue = Util.replace(retValue, "\u2122", "(tm)");
		//  Copyright
		retValue = Util.replace(retValue, "\u00A9", "(c)");
		//  Cr
		retValue = Util.replace(retValue, Env.NL, " ");
		retValue = Util.replace(retValue, "\n", " ");
		return retValue;
	}	//	getSummaryAscii

	/**
	 * 	Get Java VM Info
	 *	@return VM info
	 */
	public static String getJavaInfo()
	{
		return System.getProperty("java.vm.name")
			+ " " + System.getProperty("java.vm.version");
	}	//	getJavaInfo

	/**
	 * 	Get Operating System Info
	 *	@return OS info
	 */
	public static String getOSInfo()
	{
		return System.getProperty("os.name") + " "
			+ System.getProperty("os.version") + " "
			+ System.getProperty("sun.os.patch.level");
	}	//	getJavaInfo

	/**
	 *  Get full URL
	 *  @return URL
	 */
	public static String getURL()
	{
		return "http://" + URL;
	}   //  getURL

	/**
	 * @return URL
	 */
	public static String getOnlineHelpURL()
	{
		return ONLINE_HELP_URL;
	}

	/**
	 *  Get Sub Title
	 *  @return Subtitle
	 */
	public static String getSubtitle()
	{
		return SUB_TITLE;
	}   //  getSubitle

	/**
	 *  Get 16x16 Image.
	 *	@return Image Icon
	 */
	public static Image getImage16()
	{
		if (s_image16 == null)
		{
			Toolkit tk = Toolkit.getDefaultToolkit();
			URL url = Core.getResourceFinder().getResource(s_File16x16);
			if (url == null)
				return null;
			s_image16 = tk.getImage(url);
		}
		return s_image16;
	}   //  getImage16

	/**
	 *  Get 28*15 Logo Image.
	 *  @param hr high resolution
	 *  @return Image Icon
	 */
	public static Image getImageLogoSmall(boolean hr)
	{
		if (s_image48x15 == null)
		{
			Toolkit tk = Toolkit.getDefaultToolkit();
			URL url = null;
			if (hr)
				url = Core.getResourceFinder().getResource(s_file48x15HR);
			else
				url = Core.getResourceFinder().getResource(s_file48x15);
			if (url == null)
				return null;
			s_image48x15 = tk.getImage(url);
		}
		return s_image48x15;
	}   //  getImageLogoSmall

	/**
	 *  Get Logo Image.
	 *  @return Image Logo
	 */
	public static Image getImageLogo()
	{
		if (s_imageLogo == null)
		{
			Toolkit tk = Toolkit.getDefaultToolkit();
			URL url = Core.getResourceFinder().getResource(s_file100x30);
			if (url == null)
				return null;
			s_imageLogo = tk.getImage(url);
		}
		return s_imageLogo;
	}   //  getImageLogo

	/**
	 *  Get 32x32 ImageIcon.
	 *	@return Image Icon
	 */
	public static ImageIcon getImageIcon32()
	{
		if (s_imageIcon32 == null)
		{
			URL url = Core.getResourceFinder().getResource(s_file32x32);
			if (url == null)
				return null;
			s_imageIcon32 = new ImageIcon(url);
		}
		return s_imageIcon32;
	}   //  getImageIcon32

	/**
	 *  Get 100x30 ImageIcon.
	 *	@return Image Icon
	 */
	public static ImageIcon getImageIconLogo()
	{
		if (s_imageIconLogo == null)
		{
			URL url = Core.getResourceFinder().getResource(s_file100x30);
			if (url == null)
				return null;
			s_imageIconLogo = new ImageIcon(url);
		}
		return s_imageIconLogo;
	}   //  getImageIconLogo

	/**
	 *  Get default (Home) directory
	 *  @return Home directory
	 */
	public static String getAdempiereHome()
	{
		//  Try Environment
		String retValue = Ini.getAdempiereHome();
		if (retValue == null)
			retValue = File.separator + "idempiere";
		return retValue;
	}   //  getHome

	/**
	 *  Get Support Email
	 *  @return Support mail address
	 */
	public static String getSupportEMail()
	{
		return s_supportEmail;
	}   //  getSupportEMail

	/**
	 *  Set Support Email
	 *  @param email Support mail address
	 */
	public static void setSupportEMail(String email)
	{
		s_supportEmail = email;
	}   //  setSupportEMail

	/**
	 * 	Get JNLP CodeBase
	 *	@return code base or null
	 */
	public static URL getCodeBase()
	{
		try
		{
			BasicService bs = (BasicService)ServiceManager.lookup("javax.jnlp.BasicService");
			URL url = bs.getCodeBase();
	        return url;
		}
		catch(UnavailableServiceException ue)
		{
			return null;
		}
	}	//	getCodeBase

	/**
	 * @return True if client is started using web start
	 */
	public static boolean isWebStartClient()
	{
		return getCodeBase() != null;
	}

	/**
	 * 	Get JNLP CodeBase Host
	 *	@return code base or null
	 */
	public static String getCodeBaseHost()
	{
		URL url = getCodeBase();
		if (url == null)
			return null;
		return url.getHost();
	}	//	getCodeBase

	public static synchronized boolean isStarted()
	{
		return (log != null);
	}

	/*************************************************************************
	 *  Startup Client/Server.
	 *  - Print greeting,
	 *  - Check Java version and
	 *  - load ini parameters
	 *  If it is a client, load/set PLAF and exit if error.
	 *  If Client, you need to call startupEnvironment explicitly!
	 * 	For testing call method startupEnvironment
	 *	@param isClient true for client
	 *  @return successful startup
	 */
	public static synchronized boolean startup (boolean isClient)
	{
		//	Already started
		if (log != null)
			return true;

		//	Check Version
		if (isClient && !Login.isJavaOK(isClient))
			System.exit(1);

		Ini.setClient (isClient);		//	init logging in Ini
		
		if (! isClient)  // Calling this on client is dropping the link with eclipse console
			CLogMgt.initialize(isClient);
		//	Init Log
		log = CLogger.getCLogger(Adempiere.class);
		//	Greeting
		if (log.isLoggable(Level.INFO)) log.info(getSummaryAscii());
	//	log.info(getAdempiereHome() + " - " + getJavaInfo() + " - " + getOSInfo());

		//  Load System environment
	//	EnvLoader.load(Ini.ENV_PREFIX);

		//  System properties
		Ini.loadProperties (false);

		//	Set up Log
		CLogMgt.setLevel(Ini.getProperty(Ini.P_TRACELEVEL));
		if (isClient && Ini.isPropertyBool(Ini.P_TRACEFILE))
			CLogMgt.addHandler(new CLogFile(Ini.findAdempiereHome(), true, isClient));

		//setup specific log level
		Properties properties = Ini.getProperties();
		for(Object key : properties.keySet())
		{
			if (key instanceof String)
			{
				String s = (String)key;
				if (s.endsWith("."+Ini.P_TRACELEVEL))
				{
					String level = properties.getProperty(s);
					s = s.substring(0, s.length() - ("."+Ini.P_TRACELEVEL).length());
					CLogMgt.setLevel(s, level);
				}
			}
		}
		
		//	Set UI
		if (isClient)
		{
			if (CLogMgt.isLevelAll())
				log.log(Level.FINEST, System.getProperties().toString());
		}

		//  Set Default Database Connection from Ini
		DB.setDBTarget(CConnection.get(getCodeBaseHost()));

		createThreadPool();
		
		fireServerStateChanged(new ServerStateChangeEvent(new Object(), ServerStateChangeEvent.SERVER_START));
		
		if (isClient)		//	don't test connection
			return false;	//	need to call

		return startupEnvironment(isClient);
	}   //  startup

	private static void createThreadPool() {
		int max = Runtime.getRuntime().availableProcessors() * 20;
		int defaultMax = max;
		Properties properties = Ini.getProperties();
		String maxSize = properties.getProperty("MaxThreadPoolSize");
		if (maxSize != null) {
			try {
				max = Integer.parseInt(maxSize);
			} catch (Exception e) {}
		}
		if (max <= 0) {
			max = defaultMax;
		}
		
		// start thread pool
		threadPoolExecutor = new ScheduledThreadPoolExecutor(max);		
		
		Trx.startTrxMonitor();
	}

	/**
	 * 	Startup Adempiere Environment.
	 * 	Automatically called for Server connections
	 * 	For testing call this method.
	 *	@param isClient true if client connection
	 *  @return successful startup
	 */
	public static boolean startupEnvironment (boolean isClient)
	{
		startup(isClient);		//	returns if already initiated
		if (!DB.isConnected())
		{
			log.severe ("No Database");
			return false;
		}
		MSystem system = MSystem.get(Env.getCtx());	//	Initializes Base Context too
		if (system == null)
			return false;

		//	Initialize main cached Singletons
		ModelValidationEngine.get();
		try
		{
			String className = system.getEncryptionKey();
			if (className == null || className.length() == 0)
			{
				className = System.getProperty(SecureInterface.ADEMPIERE_SECURE);
				if (className != null && className.length() > 0
					&& !className.equals(SecureInterface.ADEMPIERE_SECURE_DEFAULT))
				{
					SecureEngine.init(className);	//	test it
					system.setEncryptionKey(className);
					system.saveEx();
				}
			}
			SecureEngine.init(className);

			//
			if (isClient)
				MClient.get(Env.getCtx(),0);			//	Login Client loaded later
			else
				MClient.getAll(Env.getCtx());
		}
		catch (Exception e)
		{
			log.warning("Environment problems: " + e.toString());
		}

		//	Start Workflow Document Manager (in other package) for PO
		String className = null;
		try
		{
			className = "org.compiere.wf.DocWorkflowManager";
			Class.forName(className);
			//	Initialize Archive Engine
			className = "org.compiere.print.ArchiveEngine";
			Class.forName(className);
		}
		catch (Exception e)
		{
			log.warning("Not started: " + className + " - " + e.getMessage());
		}

		if (!isClient)
			DB.updateMail();
		
		System.setProperty("javax.xml.parsers.SAXParserFactory", "org.apache.xerces.jaxp.SAXParserFactoryImpl");
		
		return true;
	}	//	startupEnvironment

	public static URL getResource(String name) {
		return Core.getResourceFinder().getResource(name);
	}
	
	public static synchronized void stop() {
		if (threadPoolExecutor != null) {
			threadPoolExecutor.shutdown();
		}
		log = null;
	}
	
	public static ScheduledThreadPoolExecutor getThreadPoolExecutor() {
		return threadPoolExecutor;
	}
	
	/**
	 *  @param l listener
	 */
	public static synchronized void removeServerStateChangeListener(ServerStateChangeListener l)
	{
		m_listenerList.remove(ServerStateChangeListener.class, l);
	}
	/**
	 *  @param l listener
	 */
	public static synchronized void addServerStateChangeListener(ServerStateChangeListener l)
	{
		m_listenerList.add(ServerStateChangeListener.class, l);
	}
	
	private static synchronized void fireServerStateChanged(ServerStateChangeEvent e)
	{
		ServerStateChangeListener[] listeners = m_listenerList.getListeners(ServerStateChangeListener.class);
		for (int i = 0; i < listeners.length; i++)
        	listeners[i].stateChange(e);
	}
}	//	Adempiere
