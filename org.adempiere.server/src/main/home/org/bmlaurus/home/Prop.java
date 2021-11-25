package org.bmlaurus.home;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.Ini;
import org.compiere.util.SecureEngine;

public final class Prop implements Serializable {

	/**
	 * @author BMLaurus-acanaveral
	 * @uri	http://www.bmlaurus.com
	 */
	private static final long serialVersionUID = -2735243406793760873L;

	/**	File Property    */
	public static final String	HOME_PROPERTY_FILE 	= 	"home.properties";
	
	/**	Customizable Properties    */
	private static final String TEMPLATE_PATH		=	"TemplatePath";
	private static final String	TEMPLATE_NAME 		=	"TemplateName";
	public static final String	CLIENT_NAME 		=	"ClientName";
	public static final String	CREDITS_TXT 		=	"Credits";
	public static final String	COPYRIGHT_TXT 		=	"Copyright";
	public static final	String CUSTOM_IMAGE_PATH	= "CustomImagePath";
	
	/**	Customizable Links    */
	public static final String	WEBUI_LINK 			=	"WebUiLink";
	public static final String	WEBSTORE_LINK 		=	"WebStoreLink";
	public static final String	SENDREQUEST_LINK	=	"SendRequestLink";
	public static final String	RESOURCE_LINK		=	"ResourceLink";
	public static final String	SUPPORT_LINK 		=	"SupportLink";
	public static final String	IRC_LINK			=	"IrcLink";
	public static final String	WIKI_LINK			=	"WikiLink";
	public static final String	FORUMS_LINK			=	"ForumsLink";
	public static final String	SUPPORTREQ_LINK		=	"SupportRequestLink";
	public static final String	OPTION_LINK 		=	"OptionLink";
	public static final String	FELIX_LINK 			=	"FelixLink";
	public static final String	MONITOR_LINK 		=	"iDempiereMonitorLink";
	
	/** Custom Texts */
	public static final String OPTION_TEXT 			= "OptionText";
	public static final String FELIX_TEXT 			= "FelixText";
	public static final String LOCAL_TEXT			= "LocalSupportText";
	public static final String MONITOR_TEXT 		= "iDempiereMonitorText";
	public static final String WEBUI_TEXT 			= "WebUiText";
	public static final String WEBSTORE_TEXT		= "WebStoreText";
	public static final String SENDREQUEST_TEXT	 	= "SendRequestText";
	public static final String RESOURCE_TEXT 		= "ResourceText";
	public static final String IRC_TEXT 			= "IrcText";
	public static final String WIKI_TEXT 			= "WikiText";
	public static final String FORUMS_TEXT 			= "ForumsText";
	public static final String SUPPORTREQUEST_TEXT 	= "SupportRequestText";
	
	public static final String TITLE 				= "Title";
	
	/** Default Links */
	private static final String	DEF_FELIX_LINK 		=	"osgi/system/console";
	private static final String	DEF_MONITOR_LINK 	=	"idempiereMonitor";
	private static final String DEF_WEBUI_LINK 		=	"/webui/";
	private static final String DEF_WEBSTORE_LINK 	=	"/wstore/index.jsp";
	private static final String	DEF_SENDREQUEST_LINK=	"/wstore/request.jsp";
	private static final String	DEF_RESOURCE_LINK	=	"http://www.idempiere.org";
	private static final String DEF_SUPPORT_LINK 	=	"#";
	private static final String DEF_IRC_LINK 		=	"https://mattermost.idempiere.org";
	private static final String	DEF_WIKI_LINK 		=	"http://wiki.idempiere.org/";
	private static final String DEF_FORUMS_LINK		=	"http://groups.google.com/group/idempiere";
	private static final String	DEF_SUPPORTREQ_LINK	=	"http://jira.idempiere.com";
	
	/**Social Network*/
	public static final String	SOC_FACEBOOK		=	"Facebook";
	public static final String	SOC_TWITTER			=	"Twitter";
	public static final String	SOC_LINKEDIN		=	"LinkedIn";
	public static final String	SOC_GOOPLUS			=	"Google+";
	public static final String	SOC_5				=	"Social5";
	public static final String	SOC_6				=	"Social6";
	public static final String	SOC_7				=	"Social7";
	
	/**Defaults*/
	private static final String CREDITS				=	"Welcome to the iDempiere 9.0.0 Development Build Page!";
	private static String LOGO_URL 					= 	null;
	
	
	/**	Container for Properties    */
	private volatile static Properties 		s_prop = new Properties();
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(Prop.class);
	
	
	private static String IMAGE_PATH(){
		String path="resources/templates/";
		if(s_prop!=null){
			path = getProperty(TEMPLATE_PATH);
			if(getProperty(TEMPLATE_NAME)!=null && getProperty(TEMPLATE_NAME).length()>0)
				path = path+getProperty(TEMPLATE_NAME)+"/images/";
		}
		return path;
	}
	
	public static boolean loadProperties (String filename)
	{
		boolean loadOK = true;
		s_prop = new Properties();
		InputStream fis = null;
		try
		{
			fis = new FileInputStream(filename);
			s_prop.load(fis);
			fis.close();
		}
		catch (FileNotFoundException e)
		{
			if (log.isLoggable(Level.INFO)) {
				log.info(filename + " not found");
				log.info("!!WARNING:Please locate your custom home.properties on IDEMPIERE_HOME.");
			}
			loadOK = false;
			try {
				fis = Prop.class.getResourceAsStream(HOME_PROPERTY_FILE);
				s_prop.load(fis);	
				fis.close();
				loadOK = true;
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, filename + " - " + e.toString());
			loadOK = false;
		}
		catch (Throwable t)
		{
			log.log(Level.SEVERE, filename + " - " + t.toString());
			loadOK = false;
		}
		
		return loadOK;
	}	//	loadProperties
	
	private static void setDefaults(){
		if(s_prop.getProperty(TEMPLATE_NAME)==null ||s_prop.getProperty(TEMPLATE_NAME).length()<=0)
			s_prop.setProperty(TEMPLATE_NAME, "white");
		if(s_prop.getProperty(CLIENT_NAME)==null||s_prop.getProperty(CLIENT_NAME).length()<=0)
			s_prop.setProperty(CLIENT_NAME, "iDempiere Server");
		if(s_prop.getProperty(CREDITS_TXT)==null||s_prop.getProperty(CREDITS_TXT).length()<=0)
			s_prop.setProperty(CREDITS_TXT, CREDITS);
		//LINKS
		if(s_prop.getProperty(FELIX_LINK)==null||s_prop.getProperty(FELIX_LINK).length()<=0)
			s_prop.setProperty(FELIX_LINK, DEF_FELIX_LINK);
		if(s_prop.getProperty(MONITOR_LINK)==null||s_prop.getProperty(MONITOR_LINK).length()<=0)
			s_prop.setProperty(MONITOR_LINK, DEF_MONITOR_LINK);
		if(s_prop.getProperty(WEBUI_LINK)==null||s_prop.getProperty(WEBUI_LINK).length()<=0)
			s_prop.setProperty(WEBUI_LINK, DEF_WEBUI_LINK);
		if(s_prop.getProperty(WEBSTORE_LINK)==null||s_prop.getProperty(WEBSTORE_LINK).length()<=0)
			s_prop.setProperty(WEBSTORE_LINK, DEF_WEBSTORE_LINK);
		if(s_prop.getProperty(SENDREQUEST_LINK)==null||s_prop.getProperty(SENDREQUEST_LINK).length()<=0)
			s_prop.setProperty(SENDREQUEST_LINK, DEF_SENDREQUEST_LINK);
		if(s_prop.getProperty(RESOURCE_LINK)==null||s_prop.getProperty(RESOURCE_LINK).length()<=0)
			s_prop.setProperty(RESOURCE_LINK, DEF_RESOURCE_LINK);
		if(s_prop.getProperty(SUPPORT_LINK)==null||s_prop.getProperty(SUPPORT_LINK).length()<=0)
			s_prop.setProperty(SUPPORT_LINK, DEF_SUPPORT_LINK);
		if(s_prop.getProperty(IRC_LINK)==null||s_prop.getProperty(IRC_LINK).length()<=0)
			s_prop.setProperty(IRC_LINK, DEF_IRC_LINK);
		if(s_prop.getProperty(WIKI_LINK)==null||s_prop.getProperty(WIKI_LINK).length()<=0)
			s_prop.setProperty(WIKI_LINK, DEF_WIKI_LINK);
		if(s_prop.getProperty(FORUMS_LINK)==null||s_prop.getProperty(FORUMS_LINK).length()<=0)
			s_prop.setProperty(FORUMS_LINK, DEF_FORUMS_LINK);
		if(s_prop.getProperty(SUPPORTREQ_LINK)==null||s_prop.getProperty(SUPPORTREQ_LINK).length()<=0)
			s_prop.setProperty(SUPPORTREQ_LINK, DEF_SUPPORTREQ_LINK);
		if(s_prop.getProperty(OPTION_LINK)==null||s_prop.getProperty(OPTION_LINK).length()<=0)
			s_prop.setProperty(OPTION_LINK, "#");
	}
	
	public static String loadCss(){
		String retPath = null;
		if(getProperty(TEMPLATE_PATH).contains("://")){
			String ret="data:plain/text;base64,";
			URL fis = null;
			try {
				fis = new URL(getProperty(TEMPLATE_PATH)+getProperty(TEMPLATE_NAME)+"/styles/template.css");
				byte data[]=read(fis);
				ret+=Base64.getEncoder().encodeToString (data);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			retPath = ret;
		}else
			retPath = getProperty(TEMPLATE_PATH)+getProperty(TEMPLATE_NAME)+"/styles/template.css";
		return retPath;
	}
	
	public static String getYear(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		return sdf.format(new Date());
	}
	
	public static String getImage(String img){
		String retPath = null;
		if(getProperty(CUSTOM_IMAGE_PATH)!=null && getProperty(CUSTOM_IMAGE_PATH).length()>0 
				&& !getProperty(CUSTOM_IMAGE_PATH).equals("NONE")){
			retPath = imageToData(getProperty(CUSTOM_IMAGE_PATH)+img);
			if(retPath==null){
				if(IMAGE_PATH().contains("://"))
					retPath = imageToData(IMAGE_PATH()+img);
				else
					retPath = IMAGE_PATH()+img;
			}
		}else{
			if(IMAGE_PATH().contains("://"))
				retPath = imageToData(IMAGE_PATH()+img);
			else
				retPath = IMAGE_PATH()+img;
		}
		return retPath;
	}
	
	public static String getProperty (String key)
	{
		if (key == null)
			return "";
		String retStr = s_prop.getProperty(key, "");
		if (retStr == null || retStr.length() == 0)
			return "";
		String value = SecureEngine.decrypt(retStr, 0);
		if (value == null)
			return "";
		return value;
	}
	
	public static String getFileName (boolean tryUserHome)
	{
		if (System.getProperty("PropertyHomeFile") != null)
			return System.getProperty("PropertyHomeFile");
		String base = null;
		if (tryUserHome && Ini.isClient())
			base = System.getProperty("user.home");
		if (!Ini.isClient() || base == null || base.length() == 0)
		{
			String home = Ini.getAdempiereHome();
			if (home != null)
				base = home;
		}
		if (base != null && !base.endsWith(File.separator))
			base += File.separator;
		if (base == null)
			base = "";
		return base + HOME_PROPERTY_FILE;
	}
	
	public static String imageToData(String url){
		String ret="data:image/png;base64,";
		if(url.equals(LOGO_URL))
			return url;
		URL fis = null;
		try {
			fis = new URL(url);
			byte data[]=read(fis);
			if(data==null||data.length<=0)
				return null;
			ret+=Base64.getEncoder().encodeToString (data);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	private static byte[] read(URL url) throws IOException {
		ByteArrayOutputStream bais = new ByteArrayOutputStream();
		InputStream is = null;
		try {
		  is = url.openStream();
		  byte[] byteChunk = new byte[4096]; // Or whatever size you want to read in at a time.
		  int n;

		  while ( (n = is.read(byteChunk)) > 0 ) {
		    bais.write(byteChunk, 0, n);
		  }
		}
		catch (IOException e) {
		  System.err.println("Failed while reading bytes from %s: %s"+ url.toExternalForm()+ e.getMessage());
		}
		finally {
		  if (is != null) { is.close(); }
		}
		return bais.toByteArray();
	}
	
	public static void load(){
		loadProperties(getFileName(false));
		setDefaults();
		LOGO_URL=IMAGE_PATH()+"logo.png";
	}
}
