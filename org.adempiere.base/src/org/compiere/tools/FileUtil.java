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
package org.compiere.tools;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.GenericPO;
import org.compiere.model.MAttachment;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *  File Utilities
 *
 *  @author Jorg Janke
 *  @version $Id: FileUtil.java,v 1.4 2006/08/03 04:03:22 jjanke Exp $
 */
public class FileUtil
{
	/** License Header			*/
	public static final String COPYRIGHT =
	 "/******************************************************************************\n"
	+" * Product: Adempiere ERP & CRM Smart Business Solution                       *\n"
	+" * Copyright (C) 1999-2007 Adempiere, Inc. All Rights Reserved.               *\n"
	+" * This program is free software; you can redistribute it and/or modify it    *\n"
	+" * under the terms version 2 of the GNU General Public License as published   *\n"
	+" * by the Free Software Foundation. This program is distributed in the hope   *\n"
	+" * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *\n"
	+" * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *\n"
	+" * See the GNU General Public License for more details.                       *\n"
	+" * You should have received a copy of the GNU General Public License along    *\n"
	+" * with this program; if not, write to the Free Software Foundation, Inc.,    *\n"
	+" * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *\n"
	+" ******************************************************************************/\n";
	   
	/**
	 *	File Utility
	 * 	@param file input file or directory
	 * 	@param filter filter
	 * 	@param action action
	 * 	@param p1 parameter 1
	 * 	@param p2 parameter 2
	 */
	public FileUtil (String file, String filter, String action, String p1, String p2)
	{
		this (new File(file), filter, action, p1, p2);
	}	//	FileUtil

	/**
	 *	File Utility
	 * 	@param file input file or directory
	 * 	@param filter filter
	 * 	@param action action
	 * 	@param p1 parameter 1
	 * 	@param p2 parameter 2
	 */
	public FileUtil (File file, String filter, String action, String p1, String p2)
	{
		if (action == null || action.length() == 0)
			System.err.println("FileUtil: No Action");
		else if (!validAction(action))
			System.err.println("FileUtil: Action not valid: " + action + ACTIONS);
		else if (file == null)
			System.err.println("FileUtil: No Input file");
		else if (!file.exists())
			System.err.println("FileUtil: Input file does not exist: " + file);
		else
		{
			System.out.println("FileUtil (" + file + ", Filter=" + filter + ", Action=" + action + ")");
			m_filterString = filter;
			processFile (file, p1, p2);
			System.out.println("FileUtil  Process count = " + m_count + "  actions=" + m_actions);
		}
	}	//	FileUtil

	private	String			m_filterString = null;
	private FileUtilFilter	m_filter = new FileUtilFilter();
	/** File Count			*/
	private int				m_count = 0;
	/** Action Count		*/
	private int				m_actions = 0;
	private int				m_actionIndex = -1;

	protected static final String[] ACTIONS = new String[]
		{"List", "Replace", "Latex", "License"};

	/**
	 * 	Is Action Valid
	 * 	@param action action
	 * 	@return true if supported
	 */
	private boolean validAction (String action)
	{
		for (int i = 0; i < ACTIONS.length; i++)
		{
			if (ACTIONS[i].equals (action))
			{
				m_actionIndex = i;
				return true;
			}
		}
		return false;
	}	//	validAction

	/**
	 * 	Process File with set action
	 *	@param file file
	 * 	@param p1 parameter 1
	 * 	@param p2 parameter 2
	 */
	private void processFile (File file, String p1, String p2)
	{
		if (file == null)
			return;
		else if (!file.exists())
			return;
		else if (file.isDirectory())
		{
			File[] dirFiles = file.listFiles(m_filter);
			for (int i = 0; i < dirFiles.length; i++)
				processFile(dirFiles[i], p1, p2);
		}
		else
		{
			System.out.println(" ProcessFile=" + file.getAbsolutePath());
			m_count++;
			processFileAction(file, p1, p2);
		}
	}	//	processFile

	/**
	 * 	File Action
	 *	@param file file to be processed
	 * 	@param p1 parameter 1
	 * 	@param p2 parameter 2
	 */
	void processFileAction(File file, String p1, String p2)
	{
		try
		{
			if (m_actionIndex == 0)			//	List
				;
			else if (m_actionIndex == 1)	//	Replace
				replaceString (file, p1, p2);
			else if (m_actionIndex == 2)	//	Latex
				latex (file);
			else if (m_actionIndex == 3)	//	License
				license (file);
		}
		catch (Exception ex)
		{
		}
	}	//	processFileAction

	/**
	 * 	Replace String in File.
	 * 	@param file file
	 * 	@param from old String
	 * 	@param to new String
	 * 	@throws IOException
	 */
	private void replaceString (File file, String from, String to) throws IOException
	{		
		String fileName = file.getAbsolutePath();
		File tmpFile = new File(fileName + ".tmp");
		boolean found = false;
		try (BufferedReader in = new BufferedReader(new FileReader(file));
		BufferedWriter out = new BufferedWriter (new FileWriter(tmpFile, false));) {
		String line = null;
		int lineNo = 0;
		while ((line = in.readLine()) != null)
		{
			lineNo++;
			if (line.indexOf(from) != -1)
			{
				found = true;
				System.out.println("  " + lineNo + ": " + line);
				line = Util.replace(line, from, to);
				m_actions++;
			}
			out.write(line);
			out.newLine();
		}}	//	while reading file
		//
		if (found)
		{
			File oldFile = new File (fileName + ".old");
			if (file.renameTo(oldFile))
			{
				if (tmpFile.renameTo (new File (fileName)))
				{
					if (oldFile.delete ())
						System.out.println (" - File updated: " + fileName);
					else
						System.err.println (" - Old File not deleted - " + fileName);
				}
				else
					System.err.println (" - New File not renamed - " + fileName);
			}
			else
				System.err.println(" - Old File not renamed - " + fileName);
		}
		else
		{
			if (!tmpFile.delete())
				System.err.println(" - Temp file not deleted - " + tmpFile.getAbsolutePath());
		}
	}	//	replaceString

	/**
	 * 	Strip Latex specifics.<br/>
	 * 	 \textsl{\colorbox{yellow}{\textbf{Important:}}} For more information on the
		installation of the Adempiere Server and the Adempiere Client please refer to
		\href{http://www.adempiere.org/support/index.html}{Adempiere Support} for more details and the latest
		update.
	 * 	@param file file
	 * 	@throws IOException
	 */
	private void latex (File file) throws IOException
	{
		String fileName = file.getAbsolutePath();
		File outFile = new File(fileName + ".txt");
		int lineNo = 0;
		try (BufferedReader in = new BufferedReader(new FileReader(file));
		BufferedWriter out = new BufferedWriter (new FileWriter(outFile, false));) {

		String line = null;
		while ((line = in.readLine()) != null)
		{
			lineNo++;
			boolean ignore = false;
			//
			char[] inLine = line.toCharArray();
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < inLine.length; i++)
			{
				char c = inLine[i];
				if (c == '\\')
					ignore = true;
				else if (c == '{')
					ignore = false;
				else if (c == '}')
					;
				else if (!ignore)
					sb.append(c);
			}
			//
			out.write(sb.toString());
			out.newLine();
		}}	//	while reading file
		System.out.println("File " + fileName + " - lines=" + lineNo);
	}	//	latex
	
	/**
	 * 	Replace License info.
	 * 	@param file file
	 * 	@throws IOException
	 */
	private void license (File file) throws IOException
	{
		String fileName = file.getAbsolutePath();
		File tmpFile = new File(fileName + ".tmp");
		boolean isJava = fileName.endsWith(".java");
		boolean found = false;
		try (BufferedReader in = new BufferedReader(new FileReader(file));
		BufferedWriter out = new BufferedWriter (new FileWriter(tmpFile, false));) {

		out.write(COPYRIGHT);

		String line = null;
		while ((line = in.readLine()) != null)
		{
			if (!found)
			{
				if (line.startsWith("package ") && isJava)
					found = true;
			}
			if (found)
			{
				out.write(line);
				out.newLine();
			}
		}}	//	while reading file
		//
		if (found)
		{
			File oldFile = new File (fileName + ".old");
			if (file.renameTo(oldFile))
			{
				if (tmpFile.renameTo (new File (fileName)))
				{
					if (oldFile.delete ())
					{
		//				System.out.println (" - File updated: " + fileName);
					}
					else
						System.err.println (" - Old File not deleted - " + fileName);
				}
				else
					System.err.println (" - New File not renamed - " + fileName);
			}
			else
				System.err.println(" - Old File not renamed - " + fileName);
		}
		else
		{
			System.err.println(" - No Copyright - " + fileName);
			if (!tmpFile.delete())
				System.err.println(" - Temp file not deleted - " + tmpFile.getAbsolutePath());
		}
	}	//	license

	/**
	 * 	Get Filter String
	 *	@return filter String
	 */
	String getFilterString()
	{
		return m_filterString;
	}	//	getFilterString

	/**************************************************************************
	 * 	File Filter.
	 * 	Accept directories and files matching filter
	 */
	class FileUtilFilter implements FilenameFilter
	{
		/**
		 * Accept directories and files matching filter.
		 *
		 * @param   dir    the directory in which the file was found.
		 * @param   name   the name of the file.
		 * @return  Accept directories and files matching filter
		 */
		public boolean accept (File dir, String name)
		{
		//	System.out.println("  Dir=" + dir + ", Name=" + name);
			File file = new File (dir, name);
			if (file.isDirectory())
				return true;
			String filterString = getFilterString();
			if (filterString == null || filterString.length() == 0)
				return true;
			if (name == null)
				return false;
			//	ignore files with ~ and this file
			if (name.indexOf('~') != -1 || name.equals("FileUtil.java"))
				return false;
			//
			return name.indexOf(filterString) != -1;
		}	//	accept

	}	//	FileUtilFilter

	
	/**************************************************************************
	 *	Start
	 * 	@param args fileName filter action
	 */
	public static void main (String[] args)
	{
		String directory = "C:\\Adempiere\\adempiere-all2";
		String filter = ".java";
	//	String action = "License";	//	Replace
	//	String from = null;	
	//	String to = null;
		String action = "Replace";
		String from = "$Id: FileUtil.java,v 1.4 2006/08/03 04:03:22 jjanke Exp $";	
		String to = "$Id: FileUtil.java,v 1.4 2006/08/03 04:03:22 jjanke Exp $";

		if (args.length == 1)
			directory = args[0];
		if (args.length == 2)
			filter = args[1];
		if (filter == null)
		   filter = "";
		//
		new FileUtil(directory, filter, action, from, to); 
	}	//	main

	public static String getTempMailName(String subject, String extension) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dt = sdf.format(cal.getTime());
		String cleanName = subject.replaceAll("[ &/]", "");
		String dir = System.getProperty("java.io.tmpdir")
				+ System.getProperty("file.separator") + "rpttmp_" + dt + "_" + Env.getContext(Env.getCtx(), Env.AD_SESSION_ID) + System.getProperty("file.separator");
		String localFile = dir 
				+ cleanName	+ extension;
		new File(dir ).mkdirs();
		return localFile;
	}

	/**
	 * 
	 * @param title
	 * @param table_ID
	 * @param record_ID
	 * @param ctx
	 * @param m_WindowNo
	 * @param trxName
	 * @return
	 */
	public static String parseTitle(Properties ctx, String title, int table_ID, int record_ID, int m_WindowNo, String trxName) {
		if (title.contains("@") && record_ID>0 && table_ID>0) {
			MTable table=new MTable(ctx,table_ID,trxName );
			PO po = new GenericPO(table.getTableName(), ctx, record_ID, trxName);
			title=Env.parseVariable(title, po, trxName, true);
		}
		else 
			title=  Env.parseContext (ctx, m_WindowNo, title,
					true, true);
		return title;
	}

    public static File createTempFile(String prefix, String suffix, File directory) throws IOException
	{
        if (Util.isEmpty(prefix))
            throw new IllegalArgumentException("Prefix is required");

        prefix = Util.setFilenameCorrect(prefix);

        if (suffix == null)
            suffix = ".tmp";

		String tmpdirname = getTempFolderName(directory);
		File tmpdir = new File(tmpdirname);
		tmpdir.mkdirs();

		String fileName = prefix + suffix;

        File f = new File(tmpdirname, fileName);

        return f;	
	}
    
    /**
     * Generates a unique temporary folder name based on the current timestamp and session ID. <br/>
     * The folder name is either within the specified directory or the default temporary directory.
     *
     * @param directory the base directory where the temporary folder will be created; 
     *                  if null, the system's default temporary directory is used
     * @return a string representing the path to the unique temporary folder
     * @throws IOException
     */
    public static String getTempFolderName(File directory) throws IOException {
    	Calendar cal = Calendar.getInstance();
 		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
 		String dt = sdf.format(cal.getTime());
 		String tmpdirname = (directory != null) ? directory.getCanonicalPath() : System.getProperty("java.io.tmpdir");
 		tmpdirname += System.getProperty("file.separator") + "rpttmp_" + dt + "_" + Env.getContext(Env.getCtx(), Env.AD_SESSION_ID) + System.getProperty("file.separator");

    	return tmpdirname;
    }

    public static File createTempFile(String prefix, String suffix) throws IOException
    {
        return createTempFile(prefix, suffix, null);
    }
    
    /**
     * Creates a file with the given filename. <br/>
     * If the filename includes the path, the file is created as requested. <br/>
     * If it only includes the name, the file is created in a thread-safe temporary folder.
     * @param fileName
     * @return file
     * @throws IOException
     */
    public static File createFile(String fileName) throws IOException {
    	if (Util.isEmpty(fileName))
    		throw new IllegalArgumentException("Name is required");

    	File file = null;
    	if (fileName.contains(System.getProperty("file.separator"))) {
    		file = new File(fileName);
    	} else {
    		String tmpdirname = getTempFolderName(null);
    		File tmpdir = new File(tmpdirname);
    		tmpdir.mkdirs();

    		file = new File(tmpdirname, fileName);
    	}

    	return file;	
    }
    
	/**
	 * Creates a valid file name prefix from "name"
	 * @param name
	 * @return file name prefix
	 */
    public static String makePrefix(String name) {
		StringBuilder prefix = new StringBuilder();
		char[] nameArray = name.toCharArray();
		for (char ch : nameArray) {
			if (Character.isLetterOrDigit(ch)) {
				prefix.append(ch);
			} else {
				prefix.append("_");
			}
		}
		return prefix.toString();
	}
	
	/**
	 * 
	 * @param path
	 * @return true if deleted
	 * @throws FileNotFoundException
	 * @Deprecated
	 */
	public static boolean deleteFolderRecursive(File path) throws FileNotFoundException {
		if (!path.exists())
			throw new FileNotFoundException(path.getAbsolutePath());
		boolean ret = true;
		if (path.isDirectory()) {
			for (File f : path.listFiles()){
				ret = ret && deleteFolderRecursive(f);
			}
		}
		return ret && path.delete();
	}

	/**
	 * copy attachment entry to file
	 * @param attachment
	 * @param destinationFile
	 * @param index
	 */
	public static void copy(MAttachment attachment, File destinationFile, int index)
	{
		FileOutputStream destinationFileOutputStream=null;
		try {
			destinationFile.createNewFile();
			destinationFileOutputStream = new FileOutputStream(destinationFile);
			byte[] buffer = attachment.getEntryData(index);
			destinationFileOutputStream.write(buffer);
		} 
		catch( java.io.FileNotFoundException f ) {
			throw new AdempiereException("File not found exception : " + destinationFile.getName() + " : " + f);
		} 
		catch( java.io.IOException e ) {
			throw new AdempiereException("IOException : " + e);
		} finally {
			try {
				if (destinationFileOutputStream != null)
					destinationFileOutputStream.close();
			} catch(Exception e) { 
			}
		}
	}

	/**
	 * delete folder recursively
	 * @param folder
	 * @throws IOException
	 */
	public static void deleteDirectory(File folder) throws IOException {
		Path directory = folder.toPath();
		Files.walkFileTree(directory, new SimpleFileVisitor<Path>() {
		   @Override
		   public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
		       Files.delete(file);
		       return FileVisitResult.CONTINUE;
		   }

		   @Override
		   public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException {
		       Files.delete(dir);
		       return FileVisitResult.CONTINUE;
		   }
		});
	}
}	//	FileUtil
