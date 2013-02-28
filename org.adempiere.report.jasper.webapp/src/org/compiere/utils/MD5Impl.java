/*
 * Créé le 22 mars 2005
 *
 * TODO Pour changer le modčle de ce fichier généré, allez ŕ :
 * Fenętre - Préférences - Java - Style de code - Modčles de code
 */
package org.compiere.utils;

import java.net.URL;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.utils.DigestOfFile;

public class MD5Impl {
	/**
	 *
	 */
	private CLogger log = null;

	public MD5Impl() {
		super();
		log = CLogger.getCLogger(MD5Impl.class);
	}

	/**
	 * Business method
	 * @param FileName
	 * @return hash base64 encoded
	 */
	public String getFileMD5(String FileName) {
		String hash = null;
		String absoluteFilename = null;
		String filepartOnly = null;
		try
		{
			//Thread.currentThread().getContextClassLoader().getResource("");
			if ( FileName.startsWith("http://") )
			{
				//extract absolute path by requesting jboss/tomcat
				String[] filePathParts = FileName.split("/");
				filepartOnly = filePathParts[filePathParts.length-1];
				URL currentFile = Thread.currentThread().getContextClassLoader().getResource(filepartOnly);
				System.out.println(filepartOnly);
				absoluteFilename = currentFile.getFile();
				if (log.isLoggable(Level.INFO)) log.info("decoded absolute path name for "+filepartOnly +" is "+absoluteFilename);
			}
			else
			{
				absoluteFilename = FileName;
			}

			if (absoluteFilename != null)
			{
				DigestOfFile md5DigestAgent = new DigestOfFile("MD5");
				hash = md5DigestAgent.digestAsBase64(new java.io.File(absoluteFilename));
			}

		}
		catch(Exception e)
		{
			log.severe(e.getMessage());
			return null;
		}

		return hash;
	}

	/**
	 * Business method
	 * @param Filename
	 * @return AbsolutePath on server
	 */
	public String getFileAsolutePath(String Filename)
	{
		java.net.URL currentFile = Thread.currentThread().getContextClassLoader().getResource(Filename);
		return currentFile.toString();
	}
}