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
package org.compiere.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.Collection;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.adempiere.util.ServerContext;
import org.apache.ecs.HtmlColor;
import org.apache.ecs.xhtml.a;
import org.apache.ecs.xhtml.b;
import org.apache.ecs.xhtml.body;
import org.apache.ecs.xhtml.br;
import org.apache.ecs.xhtml.font;
import org.apache.ecs.xhtml.form;
import org.apache.ecs.xhtml.h2;
import org.apache.ecs.xhtml.hr;
import org.apache.ecs.xhtml.input;
import org.apache.ecs.xhtml.label;
import org.apache.ecs.xhtml.option;
import org.apache.ecs.xhtml.p;
import org.apache.ecs.xhtml.select;
import org.apache.ecs.xhtml.strong;
import org.apache.ecs.xhtml.table;
import org.apache.ecs.xhtml.td;
import org.apache.ecs.xhtml.th;
import org.apache.ecs.xhtml.tr;
import org.compiere.Adempiere;
import org.compiere.model.AdempiereProcessorLog;
import org.compiere.model.MClient;
import org.compiere.model.MClientInfo;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;
import org.compiere.model.Query;
import org.compiere.server.AdempiereServerGroup;
import org.compiere.server.AdempiereServerMgr;
import org.compiere.server.IServerManager;
import org.compiere.server.LogFileInfo;
import org.compiere.server.ServerCount;
import org.compiere.server.ServerInstance;
import org.compiere.server.SystemInfo;
import org.compiere.server.TrxInfo;
import org.compiere.util.CLogFile;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.CacheInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.util.WebDoc;
import org.compiere.util.WebEnv;
import org.compiere.util.WebUtil;
import org.idempiere.distributed.IClusterMember;
import org.idempiere.distributed.IClusterService;
import org.idempiere.server.cluster.ClusterServerMgr;
import org.idempiere.server.cluster.callable.DeleteLogsCallable;
import org.idempiere.server.cluster.callable.GetLogInfoCallable;
import org.idempiere.server.cluster.callable.ReadLogCallable;
import org.idempiere.server.cluster.callable.RotateLogCallable;
import org.idempiere.server.cluster.callable.SetTraceLevelCallable;

/**
 *	Adempiere Server Monitor
 *	
 *  @author Jorg Janke
 *  @version $Id: AdempiereMonitor.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 */
public class AdempiereMonitor extends HttpServlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7455613826465213838L;

	/**	Logger				*/
	private static final CLogger	log = CLogger.getCLogger(AdempiereMonitor.class);
	/**	The Server			*/
	private static IServerManager	m_serverMgr = null;
	/** Message				*/
	private static p				m_message = null;
	
	private volatile static ArrayList<File>	m_dirAccessList = null;

	private ScheduledFuture<?> serverMgrFuture = null;
	
	/**
	 * 	Get
	 *	@param request request
	 *	@param response response
	 *	@throws javax.servlet.ServletException
	 *	@throws java.io.IOException
	 */
	protected void doGet (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		boolean xmlOutput = false;
		String responseType = request.getParameter("responseContentType");
		xmlOutput = "xml".equalsIgnoreCase(responseType);
			
		m_message = null;
		if (processLogParameter (request, response))
		{
			if (xmlOutput)
				createXMLSummaryPage(request, response);
			return;
		}
		if (processTraceParameter (request, response))
		{
			if (xmlOutput)
				createXMLSummaryPage(request, response);
			return;
		}
		if (processEMailParameter (request, response))
		{
			if (xmlOutput)
				createXMLSummaryPage(request, response);
			return;
		}
		if (processCacheParameter (request, response))
		{
			if (xmlOutput)
				createXMLSummaryPage(request, response);
			return;
		}
		if (processNodeInfoPage(request, response))
		{
			if (xmlOutput)
				createXMLSummaryPage(request, response);
			return;
		}
		//
		if (processRunNowParameter (request))
			;
		else
			processActionParameter (request,response);
		
		if (xmlOutput)
			createXMLSummaryPage(request, response);
		else
			createSummaryPage(request, response,false);
	}	//	doGet
	
	/**
	 * 	Post
	 *	@param request request
	 *	@param response response
	 *	@throws ServletException
	 *	@throws IOException
	 */
	protected void doPost (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		doGet(request, response);
	}	//	doPost

	/**
	 * 	Process Log Parameter and return log page
	 *	@param request request
	 *	@param response response
	 *	@return true if it was a log request
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private boolean processLogParameter (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		String serverID = WebUtil.getParameter (request, "Log");
		if (serverID == null || serverID.length() == 0)
			return false;
		
		if (log.isLoggable(Level.INFO)) log.info ("ServerID=" + serverID);
		ServerInstance server = getServerManager().getServerInstance(serverID);
		if (server == null)
		{
			m_message = new p();
			m_message.addElement(new strong("Server not found: "));
			m_message.addElement(serverID);
			return false;
		}
		
		WebDoc doc = WebDoc.create ("iDempiere Server Monitor Log");
		//	Body
		body b = doc.getBody();
		//
		p para = new p();
		a link = new a ("idempiereMonitor#" + serverID, "Return");
		para.addElement(link);
		b.addElement(para);
		//
		b.addElement(new h2(server.getModel().getName()));
		//
		table table = new table();
		table.setBorder(1);
		table.setCellSpacing(2);
		table.setCellPadding(2);
		
		//	Header
		tr line = new tr();
		line.addElement(new th().addElement("Created"));
		line.addElement(new th().addElement("Summary"));
	//	line.addElement(new th().addElement("Error"));
		line.addElement(new th().addElement("Reference"));
		line.addElement(new th().addElement("TextMsg"));
	//	line.addElement(new th().addElement("Description"));
		table.addElement(line);
		
		AdempiereProcessorLog[] logs = server.getModel().getLogs();
		for (int i = 0; i < logs.length; i++)
		{
			AdempiereProcessorLog pLog = logs[i];
			line = new tr();
			line.addElement(new td().addElement(WebEnv.getCellContent(pLog.getCreated())));
			line.addElement(new td().addElement(WebEnv.getCellContent(pLog.getSummary())));
			line.addElement(new td().addElement(WebEnv.getCellContent(pLog.getReference())));
			line.addElement(new td().addElement(WebEnv.getCellContent(pLog.getTextMsg())));
			table.addElement(line);
		}
		//
		b.addElement(table);
		link = new a ("#top", "Top");
		b.addElement(link);
		
		//	fini
		WebUtil.createResponse (request, response, this, null, doc, false);
		return true;
	}	//	processLogParameter
	
	/**
	 * 	Process Run Parameter
	 *	@param request request
	 *	@return true if it was a Run request
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private boolean processRunNowParameter (HttpServletRequest request)
		throws ServletException, IOException
	{
		String serverID = WebUtil.getParameter (request, "RunNow");
		if (serverID == null || serverID.length() == 0)
			return false;
		
		if (log.isLoggable(Level.INFO)) log.info ("ServerID=" + serverID);
		ServerInstance server = getServerManager().getServerInstance(serverID);
		if (server == null)
		{
			m_message = new p();
			m_message.addElement(new strong("Server not found: "));
			m_message.addElement(serverID);
			return false;
		}
		//
		String error = getServerManager().runNow(serverID);
		if (!Util.isEmpty(error, true))
		{
			m_message = new p();
			m_message.addElement(new strong(error));
			m_message.addElement(serverID);
		}
		
		//
		return true;
	}	//	processRunParameter

	/**
	 * 	Process Action Parameter
	 *	@param request request
	 */
	private void processActionParameter (HttpServletRequest request,HttpServletResponse response)
	{
		String action = WebUtil.getParameter (request, "Action");
		if (action == null || action.length() == 0)
			return;
		if (log.isLoggable(Level.INFO)) log.info ("Action=" + action);
		try
		{
			boolean start = action.startsWith("Start");
			boolean reload=action.startsWith("Reload");
			m_message = new p();
			String msg = (start ? "Started" : "Stopped") + ": ";
			m_message.addElement(new strong(msg));
			//
			String serverID = action.substring(action.indexOf('_')+1);
			boolean ok = false;
			if (serverID.equals("All"))
			{
				if (start)
				{	
					ok = getServerManager().startAll()==null;
				} else{					
					ok = getServerManager().stopAll()==null;
				}
					
				m_message.addElement("All");
			}
			else
			{
				if (reload) 
				{
					ok=getServerManager().reload()==null;
					this.createSummaryPage(request, response,true);
					m_dirAccessList = getDirAcessList();
				} else {
					 ServerInstance server = getServerManager().getServerInstance(serverID);
					if (server == null) {
						m_message = new p();
						m_message.addElement(new strong("Server not found: "));
						m_message.addElement(serverID);
						return;
					} else {
						if (start)
							ok = getServerManager().start(serverID)==null;
						else
							ok = getServerManager().stop(serverID)==null;
						m_message.addElement(server.getModel().getName());
					}
				}
			}
			m_message.addElement(ok ? " - OK" : " - Error!");
		}
		catch (Exception e)
		{
			m_message = new p();
			m_message.addElement(new strong("Error processing parameter: " + action));
			m_message.addElement(new br());
			m_message.addElement(e.toString());
		}
	}	//	processActionParameter

	/**
	 * 	Process Trace Parameter
	 *	@param request request
	 *	@param response response
	 *	@return true if it was a trace request with output
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private boolean processTraceParameter (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		String traceCmd = WebUtil.getParameter (request, "Trace");
		String traceLevel = WebUtil.getParameter (request, "TraceLevel");
		String nodeId = WebUtil.getParameter (request, "nodeId");
		if (traceLevel != null && traceLevel.length() > 0)
		{
			if (log.isLoggable(Level.INFO)) log.info ("New Level: " + traceLevel);
			SetTraceLevelCallable callable = new SetTraceLevelCallable(traceLevel);
			try 
			{
				if (!Util.isEmpty(nodeId, true)) 
				{
					ClusterServerMgr.getClusterService().execute(callable, ClusterServerMgr.getClusterMember(nodeId)).get();
				} 
				else 
				{
					callable.call();				
				}
			} 
			catch (Exception e) 
			{
				throw new RuntimeException(e);
			}
			return false;
		}
		
		if (traceCmd == null || traceCmd.length() == 0)
			return false;
		
		if (log.isLoggable(Level.INFO)) log.info ("Command: " + traceCmd);
		CLogFile fileHandler = CLogFile.get (false, null, false);
		//
		if (traceCmd.equals("ROTATE"))
		{
			RotateLogCallable callable = new RotateLogCallable();
			try 
			{
				if (!Util.isEmpty(nodeId, true)) 
				{
					ClusterServerMgr.getClusterService().execute(callable, ClusterServerMgr.getClusterMember(nodeId)).get();
				} 
				else 
				{
					callable.call();				
				}
			} 
			catch (Exception e) 
			{
				throw new RuntimeException(e);
			}
			return false;	//	re-display
		}
		else if (traceCmd.equals("DELETE"))
		{
			DeleteLogsCallable callable = new DeleteLogsCallable();
			try 
			{
				if (!Util.isEmpty(nodeId, true)) 
				{
					ClusterServerMgr.getClusterService().execute(callable, ClusterServerMgr.getClusterMember(nodeId)).get();
				} 
				else 
				{
					callable.call();				
				}
			} 
			catch (Exception e) 
			{
				throw new RuntimeException(e);
			}
			return false;	//	re-display
		}
		
		if (!Util.isEmpty(nodeId, true)) 
		{
			
			GetLogInfoCallable infoCallable = new GetLogInfoCallable(traceCmd);
			IClusterService service = ClusterServerMgr.getClusterService();
			IClusterMember member = ClusterServerMgr.getClusterMember(nodeId);
			try {
				GetLogInfoCallable.LogInfo logInfo = service.execute(infoCallable, member).get();
				if (logInfo == null || logInfo.getLength() == 0)
					return false;
				
				try(ServletOutputStream out = response.getOutputStream ())
				{
					response.setContentType("text/plain");
					response.setBufferSize(2048);
					response.setContentLength((int) logInfo.getLength());
					for(int i = 0; i < logInfo.getNoOfBlocks(); i++) {
						ReadLogCallable callable = new ReadLogCallable(logInfo.getFileName(), i);
						byte[] contents = service.execute(callable, member).get();
						if (contents == null || contents.length == 0)
							break;
						out.write(contents);						
					}
					out.flush();
				}
				return true;
			} catch (Exception e) {
				log.log(Level.WARNING, e.getMessage(), e);
				return false;
			}
		}
		
		//	Display current log File
		if (fileHandler != null && fileHandler.getFileName().equals(traceCmd))
			fileHandler.flush();
		
		//	Spool File
		File file = new File (traceCmd);
		if (!file.exists() || !file.canRead())
		{
			log.warning ("Did not find File: " + traceCmd);
			return false;
		}
		if (file.length() == 0)
		{
			log.warning ("File Length=0: " + traceCmd);
			return false;
		}

		boolean found = false;
		if (m_dirAccessList == null)
			m_dirAccessList = getDirAcessList();
		
		for (File dir : m_dirAccessList)
		{
			if (file.getCanonicalPath().startsWith(dir.getAbsolutePath()))
			{
				found = true;
				break;				
			}
		}
		
		if (!found)
		{
			log.warning ("Couldn't find file in directories that allowed to access");
			for (File dirAccess : m_dirAccessList)
				log.warning(" - " + dirAccess.getAbsoluteFile());
			return false;
		}
		
		//	Stream Log
		if (log.isLoggable(Level.INFO)) log.info ("Streaming: " + traceCmd);
		try
		{
			long time = System.currentTimeMillis();		//	timer start
			int fileLength = (int)file.length();
			int bufferSize = 2048; //	2k Buffer
			byte[] buffer = new byte[bufferSize];
			//
			FileInputStream fis = new FileInputStream(file);
			ServletOutputStream out = response.getOutputStream ();
			//
			response.setContentType("text/plain");
			response.setBufferSize(bufferSize);
			response.setContentLength(fileLength);
			int read = 0;
			while ((read = fis.read(buffer)) > 0)
				out.write (buffer, 0, read);
			out.flush();
			out.close();
			fis.close();
			//
			time = System.currentTimeMillis() - time;
			double speed = (fileLength/(double)1024) / (time/(double)1000);
			if (log.isLoggable(Level.INFO)) log.info("length=" 
				+ fileLength + " - " 
				+ time + " ms - " 
				+ speed + " kB/sec");
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "stream" + ex);
			return false;
		}
		return true;
	}	//	processTraceParameter
	
	/**
	 * 	Process EMail Parameter
	 *	@param request request
	 *	@param response response
	 *	@return true if it was a email request with output
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private boolean processEMailParameter (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		String email = WebUtil.getParameter (request, "EMail");
		if (email == null || email.length() == 0)
			return false;
		
		int AD_Client_ID = -1;
		try
		{
			AD_Client_ID = Integer.parseInt(email);
		}
		catch (Exception e)
		{
			log.warning("Parsing: " + email + " - " + e.toString());
		}
		if (AD_Client_ID < 0)
		{
			m_message = new p();
			m_message.addElement("No EMail: " + email);
			return false;
		}
		
	//	log.info ("Test EMail: " + AD_Client_ID);
		MClient client = MClient.get(new Properties(), AD_Client_ID);
		if (log.isLoggable(Level.INFO)) log.info ("Test: " + client);
		
		m_message = new p();
		m_message.addElement(client.getName() + ": " + client.testEMail());
		return false;
	}	//	processEMailParameter
	

	/**
	 * 	Process Cache Parameter
	 *	@param request request
	 *	@param response response
	 *	@return true if it was a email request with output
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private boolean processCacheParameter (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		String cmd = WebUtil.getParameter (request, "CacheReset");
		if (cmd == null || cmd.length() == 0)
			return createCacheDetailsPage(request, response);
		
		String tableName = WebUtil.getParameter (request, "CacheTableName");
		String record_ID = WebUtil.getParameter (request, "CacheRecord_ID");
		
		m_message = new p();
		try
		{
			if (tableName == null || tableName.length() == 0)
			{
				CacheMgt.get().reset();
				m_message.addElement("Cache Reset: All");
			}
			else if (record_ID == null || record_ID.length() == 0)
			{
				CacheMgt.get().reset(tableName);
				m_message.addElement("Cache Reset: " + tableName);
			}
			else
			{
				CacheMgt.get().reset(tableName, Integer.parseInt(record_ID));
				m_message.addElement("Cache Reset: " + tableName + ", Record_ID=" + record_ID);
			}
		}
		catch (Exception e)
		{
			log.severe(e.toString());
			m_message.addElement("Error: " + e.toString());
		}
		return false;	//	continue
	}	//	processEMailParameter

	/**************************************************************************
	 * 	Create & Return Summary Page
	 *	@param request request
	 *	@param response response
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private void createSummaryPage (HttpServletRequest request, HttpServletResponse response,boolean refresh)
		throws ServletException, IOException
	{
		WebDoc doc = WebDoc.create ("iDempiere Server Monitor");
	//	log.info("ServletConfig=" + getServletConfig());
		AdempiereServerGroup.get().dump();

		//	Body
		body bb=new body();
		bb = doc.getBody();			
		
		//	Message
		if (m_message != null)
		{
			bb.addElement(new hr());
			bb.addElement(m_message);
			bb.addElement(new hr());
		}
		
		//	Summary
		table table = new table();
		table.setBorder(1);
		table.setCellSpacing(2);
		table.setCellPadding(2);
		//
		tr line = new tr();
		line.addElement(new th().addElement(Adempiere.getName()));
		line.addElement(new td().addElement(Adempiere.getVersion()));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement(Adempiere.getImplementationVendor()));
		line.addElement(new td().addElement(Adempiere.getImplementationVersion()));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("Manager"));
		line.addElement(new td().addElement(WebEnv.getCellContent(getServerManager().getDescription())));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("Start - Elapsed"));
		line.addElement(new td().addElement(WebEnv.getCellContent(formatTimestampWithTimeZone(0, getServerManager().getStartTime()))
			+ " - " + TimeUtil.formatElapsed(getServerManager().getStartTime())));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("Servers"));
		line.addElement(new td().addElement(WebEnv.getCellContent(createServerCountMessage(getServerManager().getServerCount()))));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("Last Updated"));
		line.addElement(new td().addElement(formatTimestampWithTimeZone(0, new Timestamp(System.currentTimeMillis()))));
		table.addElement(line);
		bb.addElement(table);
		
		IClusterService service = ClusterServerMgr.getClusterService();
		Collection<IClusterMember> members = null;
		IClusterMember local = null;
		if (service != null)
		{
			members = service.getMembers();
			local = service.getLocalMember();
			if (members.size() > 1 && local != null) 
			{
				line = new tr();
				line.addElement(new th().addElement("Cluster Nodes"));
				p para = new p();
				StringBuilder nodeBuilder = new StringBuilder(local.getId());
				InetAddress address = local.getAddress();
				if (address != null) 
				{					
					nodeBuilder.append(" (").append(address.getCanonicalHostName()).append(")");
				}
				para.addElement(nodeBuilder.toString());
				
				for(IClusterMember member : members) 
				{
					if (member.getId().equals(local.getId())) 
					{
						continue;
					}
					else 
					{
						para.addElement(" - ");
						nodeBuilder = new StringBuilder(member.getId());
						address = member.getAddress();
						if (address != null) 
						{					
							nodeBuilder.append(" (").append(address.getCanonicalHostName()).append(")");
						}
						a link = new a ("idempiereMonitor?NodeInfo="+member.getId(), nodeBuilder.toString());
						para.addElement(link);
					}					
				}
				line.addElement(new td().addElement(para));
				table.addElement(line);
			}
		}
		//
		p para = new p();
		a link = new a ("idempiereMonitor?Action=Start_All", "Start All");
		para.addElement(link);
		para.addElement(" - ");
		link = new a ("idempiereMonitor?Action=Stop_All", "Stop All");
		para.addElement(link);
		para.addElement(" - ");
		link = new a ("idempiereMonitor?Action=Reload", "Reload");
		para.addElement(link);
		para.addElement(" - ");
		link = new a ("idempiereMonitor", "Refresh");
		para.addElement(link);
		bb.addElement(para);
		
		//	***** Server Links *****			
		bb.addElement(new hr());
		para = new p();
		ServerInstance[] servers = getServerManager().getServerInstances();		
		Arrays.sort(servers, new Comparator<ServerInstance>() {
		    public int compare(ServerInstance o1, ServerInstance o2) {
		    	if (o1 == null || o1.getModel() == null || o1.getModel().getName() == null
		    			|| o2 == null || o2.getModel() == null || o2.getModel().getName() == null)
		    		return 0;
		        return o1.getModel().getName().compareTo(o2.getModel().getName());
		    }
		});
		for (int i = 0; i < servers.length; i++)
		{
			if (i > 0)
				para.addElement(new br());
			ServerInstance server = servers[i];
			link = new a ("#" + server.getServerId(), server.getModel().getName());
			para.addElement(link);
			font status = null;
			if (server.isStarted())
			{
				if (server.isSleeping())
					status = new font().setColor(HtmlColor.GREEN).addElement(" (Started)");
				else
					status = new font().setColor(HtmlColor.GREEN).addElement(" (Running)");
			}
			else
			{
				status = new font().setColor(HtmlColor.RED).addElement(" (Stopped)");
			}
			para.addElement(status);
		}
		bb.addElement(para);

		//	**** Log Management ****
		try {
			Properties ctx = new Properties();
			ServerContext.setCurrentInstance(ctx);
			createLogMgtPage(bb, members, local);
		} finally {
			ServerContext.dispose();
		}
		
		//	***** Server Details *****
		bb.removeEndEndModifier();
		for (int i = 0; i < servers.length; i++)
		{
			ServerInstance server = servers[i];
			bb.addElement(new hr());
			bb.addElement(new a().setName(server.getServerId()));
			bb.addElement(new h2(server.getModel().getName()));			
			//
			table = new table();
			table.setBorder(1);
			table.setCellSpacing(2);
			table.setCellPadding(2);
			//	Status
			line = new tr();
			if (server.isStarted())
			{
				String msg = "Stop";
				link = new a ("idempiereMonitor?Action=Stop_" + server.getServerId(), msg);
				if (server.isSleeping())
				{
					line.addElement(new th().addElement("Sleeping"));
					line.addElement(new td().addElement(link));
				}
				else
				{
					line.addElement(new th().addElement("Running"));
					line.addElement(new td().addElement(link));
				}
				table.addElement(line);
				line = new tr();
				line.addElement(new th().addElement("Start - Elapsed"));
				line.addElement(new td().addElement(WebEnv.getCellContent(formatTimestampWithTimeZone(server.getModel().getAD_Client_ID(), server.getStartTime())) 
					+ " - " + TimeUtil.formatElapsed(server.getStartTime())));
			}
			else
			{
				String msg = "Start";
				line.addElement(new th().addElement("Not Started"));
				link = new a ("idempiereMonitor?Action=Start_" + server.getServerId(), msg);
				line.addElement(new td().addElement(link));
			}
			table.addElement(line);
			//
			line = new tr();
			line.addElement(new th().addElement("Description"));
			line.addElement(new td().addElement(WebEnv.getCellContent(server.getModel().getDescription())));
			table.addElement(line);
			//
			line = new tr();
			line.addElement(new th().addElement("Last Run"));
			line.addElement(new td().addElement(WebEnv.getCellContent(formatTimestampWithTimeZone(server.getModel().getAD_Client_ID(), server.getModel().getDateLastRun()))));
			table.addElement(line);
			line = new tr();
			line.addElement(new th().addElement("Info"));
			line.addElement(new td().addElement(WebEnv.getCellContent(server.getServerInfo())));
			table.addElement(line);
			//
			line = new tr();
			line.addElement(new th().addElement("Next Run"));
			td td = new td();
			td.addElement(WebEnv.getCellContent(formatTimestampWithTimeZone(server.getModel().getAD_Client_ID(), server.getModel().getDateNextRun(false))));
			td.addElement(" - ");
			link = new a ("idempiereMonitor?RunNow=" + server.getServerId(), "(Run Now)");
			td.addElement(link);
			line.addElement(td);
			table.addElement(line);
			//
			line = new tr();
			line.addElement(new th().addElement("Statistics"));
			line.addElement(new td().addElement(server.getStatistics()));
			table.addElement(line);
			//
			if (server.getClusterMember() != null && members != null && members.size() > 1) 
			{
				InetAddress address = server.getClusterMember().getAddress();
				String ip = address != null ? address.getHostAddress() : null;
				if (ip != null && 
					(ip.startsWith("10.") ||  
				     ip.startsWith("172.16") || 
				     ip.startsWith("192.168"))) 
				{					
					line = new tr();
					line.addElement(new th().addElement("Cluster Node IP"));
					line.addElement(new td().addElement(ip));
				}
				table.addElement(line);
				line = new tr();
				line.addElement(new th().addElement("Cluster Node Id"));
				line.addElement(new td().addElement(server.getClusterMember().getId()));
				table.addElement(line);
				
			}
			
			//	Add table to Body
			bb.addElement(table);
			link = new a ("#top", "Top");
			bb.addElement(link);
			bb.addElement(" - ");
			link = new a ("idempiereMonitor?Log=" + server.getServerId(), "Log");
			bb.addElement(link);
			bb.addElement(" - ");
			link = new a ("idempiereMonitor", "Refresh");
			bb.addElement(link);
		}

		//	fini
		WebUtil.createResponse (request, response, this, null, doc, false);
	}	//	createSummaryPage

	private String formatTimestampWithTimeZone(int AD_Client_ID, Timestamp ts) {
		return formatTimestampWithTimeZone(AD_Client_ID, (Date)ts);
	}
	
	private String formatTimestampWithTimeZone(int AD_Client_ID, Date date) {
		if (date == null)
			return "";
		DateTimeFormatter formatter = DateTimeFormatter.ISO_ZONED_DATE_TIME;
		MClientInfo clientInfo = MClientInfo.get(AD_Client_ID);
		if (!Util.isEmpty(clientInfo.getTimeZone())) {
			try {
				formatter = formatter.withZone(ZoneId.of(clientInfo.getTimeZone()));
			} catch (Exception e) {
				//fallback to default
				formatter = formatter.withZone(ZoneId.systemDefault());
			}
		} else {
			formatter = formatter.withZone(ZoneId.systemDefault());
		}
		return formatter.format(date.toInstant().truncatedTo(ChronoUnit.SECONDS));
	}

	private String createServerCountMessage(ServerCount serverCount) {
		StringBuilder builder = new StringBuilder();
		
		if (serverCount != null) {
			builder.append(serverCount.getStarted()+serverCount.getStopped())
				.append(" - Started=")
				.append(serverCount.getStarted())
				.append(" - Stopped=")
				.append(serverCount.getStopped());
		}
		
		return builder.toString();
	}
	
	/**************************************************************************
	 * 	Create & Return Summary Page
	 *	@param request request
	 *	@param response response
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private void createXMLSummaryPage (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		response.setContentType("text/xml");
		PrintWriter writer = response.getWriter();

		writer.println("<server-response>");

		//	message
		writer.println("\t<message>");
		if (m_message != null)
		{
			writer.println(m_message);
		}
		writer.println("\t</message>");
		
		//	Summary
		writer.print("\t<name>");
		writer.print(Adempiere.getName());
		writer.println("</name>");
		
		writer.print("\t<version>");
		writer.print(Adempiere.getVersion());
		writer.println("</version>");

		writer.print("\t<implementation-vendor>");
		writer.print(Adempiere.getImplementationVendor());
		writer.println("</implementation-vendor>");
		
		writer.print("\t<implementation-version>");
		writer.print(Adempiere.getImplementationVersion());
		writer.println("</implementation-version>");

		writer.println("\t<server-manager>");
		writer.print("\t\t<description>");
		writer.print(getServerManager().getDescription());
		writer.println("</description>");
		writer.print("\t\t<start-time>");
		writer.print(formatTimestampWithTimeZone(0, getServerManager().getStartTime()));
		writer.println("</start-time>");
		writer.print("\t\t<server-count>");
		writer.print(getServerManager().getServerCount());
		writer.println("</server-count>");
		
		ServerInstance[] servers = getServerManager().getServerInstances();		
		for (int i = 0; i < servers.length; i++)
		{
			ServerInstance server = servers[i];
			writer.println("\t\t<server>");
			writer.print("\t\t\t<id>");
			writer.print(server.getServerId());
			writer.println("</id>");
			writer.print("\t\t\t<name>");
			writer.print(server.getModel().getName());
			writer.println("</name>");
			writer.print("\t\t\t<description>");
			writer.print(server.getModel().getDescription());
			writer.println("</description>");
			writer.print("\t\t\t<info>");
			writer.print(server.getServerInfo());
			writer.println("</info>");
			writer.print("\t\t\t<status>");
			if (server.isStarted())
			{
				if (server.isInterrupted())
					writer.print("Interrupted");
				else if (server.isSleeping())
					writer.print("Sleeping");
				else
					writer.print("Running");
			}
			else
				writer.print("Stopped");
			writer.println("</status>");
			writer.print("\t\t\t<start-time>");
			writer.print(formatTimestampWithTimeZone(server.getModel().getAD_Client_ID(), server.getStartTime()));
			writer.println("</start-time>");
			writer.print("\t\t\t<last-run>");
			writer.print(formatTimestampWithTimeZone(server.getModel().getAD_Client_ID(), server.getModel().getDateLastRun()));
			writer.println("</last-run>");
			writer.print("\t\t\t<next-run>");
			writer.print(formatTimestampWithTimeZone(server.getModel().getAD_Client_ID(), server.getModel().getDateNextRun(false)));
			writer.println("</next-run>");
			writer.print("\t\t\t<statistics>");
			writer.print(server.getStatistics());
			writer.println("</statistics>");
			writer.println("\t\t</server>");
		}
		
		writer.println("\t</server-manager>");
		
		writer.flush();
	}	//	createSummaryPage
	
	/**
	 * 	Add Log Management to page
	 *	@param bb body
	 *  @param members 
	 *  @param local 
	 */
	private void createLogMgtPage (body bb, Collection<IClusterMember> members, IClusterMember local)
	{
		bb.addElement(new hr());
		
		//	Ini Parameters
		table table = new table();
		table.setBorder(1);
		table.setCellSpacing(2);
		table.setCellPadding(2);
		//
		
		MSystem system = MSystem.get(Env.getCtx());
		SystemInfo systemInfo = SystemInfo.getLocalSystemInfo();				
		tr line = new tr();
		line.addElement(new th().addElement(Adempiere.getURL()));
		line.addElement(new td().addElement(systemInfo.getPropertyFileName()));
		table.addElement(line);
		//	OS + Name
		line = new tr();
		line.addElement(new th().addElement(systemInfo.getOperatingSystem()));
		String info = system.getName();
		if (system.getCustomPrefix() != null)
			info += " (" + system.getCustomPrefix() + ")"; 
		line.addElement(new td().addElement(info));
		table.addElement(line);
		//	Java + email
		line = new tr();
		line.addElement(new th().addElement(systemInfo.getJavaVM()));
		line.addElement(new td().addElement("Average GC Time=" + systemInfo.getGarbageCollectionTime() / systemInfo.getGarbageCollectionCount() + " ms"));
		table.addElement(line);
		//	DB + Instance
		line = new tr();
		line.addElement(new th().addElement(systemInfo.getDatabaseDescription()));
		line.addElement(new td().addElement(systemInfo.getDatabaseConnectionURL()));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("DB Connection Pool"));
		line.addElement(new td().addElement(systemInfo.getDatabaseStatus()));
		table.addElement(line);
		//	Processors/Support
		line = new tr();
		line.addElement(new th().addElement("Processor"));
		line.addElement(new td().addElement(systemInfo.getAvailableProcessors()+""));
		table.addElement(line);
		if (systemInfo.getAverageSystemLoad() >= 0)
		{
			line = new tr();
			line.addElement(new th().addElement("System Load"));
			line.addElement(new td().addElement(systemInfo.getAverageSystemLoad()+"%"));
			table.addElement(line);
		}
		//	Memory
		line = new tr();
		line.addElement(new th().addElement("VM Memory"));
		line.addElement(new td().addElement(systemInfo.getMemoryUsage()));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("Heap Memory"));
		line.addElement(new td().addElement(systemInfo.getHeapMemoryUsage()));
		table.addElement(line);
		//	Runtime
		line = new tr();
		line.addElement(new th().addElement("Runtime " + systemInfo.getRuntimeName()));
		line.addElement(new td().addElement(TimeUtil.formatElapsed(systemInfo.getRuntimeUpTime())));
		table.addElement(line);
		//	Threads
		line = new tr();
		line.addElement(new th().addElement("Threads " + systemInfo.getThreadCount()));
		line.addElement(new td().addElement("Peak=" + systemInfo.getPeakThreadCount() 
			+ ", Daemons=" + systemInfo.getDaemonThreadCount()
			+ ", Total=" + systemInfo.getTotalStartedThreadCount()));
		table.addElement(line);
		
		//Transactions
		TrxInfo[] trxs = systemInfo.getTrxInfos();
		for (TrxInfo trx : trxs)
		{
			line = new tr();
			line.addElement(new th().addElement((trx.isActive() ? "Active" : "Inactive") + " Transaction "));
			td td = new td();
			if (Util.isEmpty(trx.getStackTrace())) {
				td.addElement("Name=" + trx.getDisplayName() + ", StartTime=" + formatTimestampWithTimeZone(0,trx.getStartTime()));
				td.setTitle(trx.getTrxName());
			} else {
				td.setOnClick("var newwindow=window.open('','Popup', 'width=800,height=600');newwindow.document.write('<title>"  + escapeEcmaScript(trx.getDisplayName()) +"</title>"
						+ "<p><b>Transaction = " + trx.getDisplayName() + "</b></p>"
						+ "<p><b>TrxName = " + trx.getTrxName() + "</b></p>"
						+ "<pre>" + escapeEcmaScript(trx.getStackTrace()) + "</pre>')");
				label lbl = new label().addElement(trx.getDisplayName());
				lbl.setStyle("text-decoration: underline; color: blue");
				td.addElement("Name=").addElement(lbl).addElement(", StartTime=" + formatTimestampWithTimeZone(0,trx.getStartTime()));
				td.setTitle("Click to see stack trace for " + trx.getTrxName());
			}
			line.addElement(td);
			table.addElement(line);
		}
		
		//	Cache Reset
		line = new tr();
		line.addElement(new th().addElement(CacheMgt.get().toStringX()));
		p cachePara = new p();
		cachePara.addElement(new a ("idempiereMonitor?CacheReset=Yes", "Reset Cache"))
			.addElement(" - ")				
			.addElement(new a ("idempiereMonitor?CacheDetails=Yes", "Cache Details"));
		line.addElement(new td().addElement(cachePara));
		table.addElement(line);
		
		//	Trace Level
		line = new tr();
		line.addElement(new th().addElement(new label("TraceLevel").addElement("Trace Log Level")));
		form myForm = new form("idempiereMonitor", form.METHOD_POST, form.ENC_DEFAULT);
		//	LogLevel Selection
		option[] options = new option[CLogMgt.LEVELS.length];
		for (int i = 0; i < options.length; i++) 
		{
			options[i] = new option(CLogMgt.LEVELS[i].getName());
			options[i].addElement(CLogMgt.LEVELS[i].getName());
			if (CLogMgt.LEVELS[i] == systemInfo.getLogLevel())
				options[i].setSelected(true);
		}
		select sel = new select("TraceLevel", options);
		myForm.addElement(sel);
		myForm.addElement(new input(input.TYPE_SUBMIT, "Set", "Set"));
		line.addElement(new td().addElement(myForm));
		table.addElement(line);
		//
		line = new tr();
		line.addElement(new th().addElement("Trace File"));
		line.addElement(new td().addElement(new a ("idempiereMonitor?Trace=" + systemInfo.getCurrentLogFile(), "Current")));
		table.addElement(line);
		//
		line = new tr();
		p tlp = new p();
		tlp.addElement(new a ("idempiereMonitor?Trace=ROTATE", "Rotate Trace Log"))
		   .addElement(" - ")
		   .addElement(new a ("idempiereMonitor?Trace=DELETE", "Delete all Trace Logs"));
		line.addElement(new th());
		line.addElement(new td().addElement(tlp));
		table.addElement(line);
		//
		bb.addElement(table);
		
		//	List Log Files
		p p = new p();
		p.addElement(new b("All Log Files: "));
		p.addElement(new br());
		//	All in dir
		LogFileInfo logFiles[] = systemInfo.getLogFileInfos();
		for (LogFileInfo logFile : logFiles) 
		{
			if (logFile != logFiles[0])
				p.addElement(" - ");
			String fileName = logFile.getFileName();
			String displayName = fileName;
			int index = fileName.lastIndexOf(File.separator);
			if (index > 1)
				displayName = fileName.substring(index+1);
			a link = new a ("idempiereMonitor?Trace=" + fileName, displayName);
			p.addElement(link);
			int size = (int)(logFile.getFileSize()/1024);
			if (size < 1024)
				p.addElement(" (" + size + "k)");
			else
				p.addElement(" (" + size/1024 + "M)");
		}		
		bb.addElement(p);
		
		//	Clients and Web Stores
		table = new table();
		table.setBorder(1);
		table.setCellSpacing(2);
		table.setCellPadding(2);
		//	
		line = new tr();
		MClient[] clients = MClient.getAll(Env.getCtx(), "AD_Client_ID");
		line.addElement(new th().addElement("Tenant #" + clients.length + " - EMail Test:"));
		p = new p();
		for (int i = 0; i < clients.length; i++)
		{
			MClient client = clients[i];
			if (!client.isActive())
				continue;
			if (i > 0)
				p.addElement(" - ");
			p.addElement(new a("idempiereMonitor?EMail=" + client.getAD_Client_ID(), client.getName()));
		}
		if (clients.length == 0)
			p.addElement("&nbsp;");
		line.addElement(new td().addElement(p));
		table.addElement(line);
		//	
		line = new tr();
		List<MSession> sessions =  new Query(Env.getCtx(), MSession.Table_Name, "Processed = 'N'", null).list();
		line.addElement(new th().addElement("Active sessions #" + sessions.size()));
		p = new p();
		for (int i = 0; i < clients.length; i++) {
			MClient client = clients[i];
			if (!client.isActive())
				continue;
			if (i > 0)
				p.addElement(" - ");
			int count = 0;
			for (MSession session : sessions) {
				if (session.getAD_Client_ID()==client.getAD_Client_ID())
					count++;
			}
			p.addElement(client.getName() + " : " + count);
		}
		if (clients.length == 0)
			p.addElement("&nbsp;");
		line.addElement(new td().addElement(p));
		table.addElement(line);
		if (members != null && members.size() > 1) {
			line = new tr();
			line.addElement(new th().addElement(""));
			p = null;
			for(IClusterMember member : members) {
				if (p == null)
					p = new p();
				else
					p.addElement(" - ");
				p.addElement(member.getId() + " : " + ((member.getId().equals(local.getId())) ? systemInfo.getSessionCount() : SystemInfo.getClusterSessionCount(member)));
			}
			line.addElement(new td().addElement(p));
			table.addElement(line);
		}						
		//	
		line = new tr();

		boolean isSystemInMaintenance = MSysConfig.getBooleanValue(MSysConfig.SYSTEM_IN_MAINTENANCE_MODE, false, 0);
		List<Integer> inMaintenanceClients = new ArrayList<Integer>();
		if (isSystemInMaintenance)
			line.addElement(new th().addElement("Maintenance Mode"));
		else {
			int possiblyInMaintenanceClients[] = DB.getIDsEx(null, "SELECT AD_Client_ID FROM AD_SysConfig WHERE AD_Client_ID!=0 AND IsActive='Y' AND Name=?", MSysConfig.SYSTEM_IN_MAINTENANCE_MODE);
			for (int clientId : possiblyInMaintenanceClients) {
				boolean isTenantInMaintenance = MSysConfig.getBooleanValue(MSysConfig.SYSTEM_IN_MAINTENANCE_MODE, false, clientId);
				if (isTenantInMaintenance)
					inMaintenanceClients.add(clientId);
			}
			line.addElement(new th().addElement("Maintenance Mode #"+inMaintenanceClients.size()));
		}

		p = new p();
		if (isSystemInMaintenance)
			p.addElement("All tenants are in maintenance mode");
		else if (inMaintenanceClients.size() > 0) {
			boolean first = true;
			for (int clientID : inMaintenanceClients) {
				MClient client = MClient.get(Env.getCtx(), clientID);
				if (!client.isActive())
					continue;
				if (!first)
					p.addElement(" - ");
				p.addElement(client.getName());
				first = false;
			}
		}
		else
			p.addElement("All tenants are in normal operation mode");
		if (clients.length == 0)
			p.addElement("&nbsp;");
		line.addElement(new td().addElement(p));
		table.addElement(line);
		//
		bb.addElement(table);
	}	//	createLogMgtPage
	
	/**************************************************************************
	 * 	Init
	 *	@param config config
	 *	@throws javax.servlet.ServletException
	 */
	public void init (ServletConfig config) throws ServletException
	{
		WebEnv.initWeb(config);
		log.info ("");
		
		// initial Wait (default to 10 seconds) to give cluster service time to start first
		final int initialWaitSeconds = MSysConfig.getIntValue(MSysConfig.MONITOR_INITIAL_WAIT_FOR_CLUSTER_IN_SECONDS, 10);
		serverMgrFuture = Adempiere.getThreadPoolExecutor().schedule(() -> {			
			try {
				Properties ctx = new Properties();
				Env.setContext(ctx, Env.AD_CLIENT_ID, 0);
				Env.setContext(ctx, Env.AD_USER_ID, 0);
				ServerContext.setCurrentInstance(ctx);
				
				int maxSecondsToWait = MSysConfig.getIntValue(MSysConfig.MONITOR_MAX_WAIT_FOR_CLUSTER_IN_SECONDS, 180);			
				int totalWaitSeconds = initialWaitSeconds;
				//check every 5 seconds (until maxSecondsToWait)
				int waitSeconds = 5;
				while (ClusterServerMgr.getClusterService() == null)
				{
					try {
						Thread.sleep(waitSeconds * 1000);
					} catch (InterruptedException e) {
						break;
					}
					if (Thread.interrupted())
						break;
					totalWaitSeconds += waitSeconds;
					if (totalWaitSeconds >= maxSecondsToWait) {
						log.warning("Cluster Service did not start after " + totalWaitSeconds + " seconds");
						break;
					}
				}
				
				//always create the local server manager instance
				m_serverMgr = AdempiereServerMgr.get();
				
				//switch to cluster manager if cluster service is available
				if (ClusterServerMgr.getClusterService() != null)
					m_serverMgr = ClusterServerMgr.getInstance();
			} catch (Throwable e) {
				if (e.getCause() != null) {
					log.log(Level.SEVERE, e.getCause().getMessage(), e.getCause());
				} else {
					log.log(Level.SEVERE, e.getMessage(), e);
				}
			} finally {
				ServerContext.dispose();
			}
		}, initialWaitSeconds, TimeUnit.SECONDS);
		
		m_dirAccessList = getDirAcessList();
	}	//	init
	
	private synchronized IServerManager getServerManager()
	{
		if (serverMgrFuture != null && !serverMgrFuture.isDone() && !serverMgrFuture.isCancelled())
		{
			try {
				serverMgrFuture.get();
			} catch (Exception e) {				
			}
		} 
		return m_serverMgr;
	}
	
	/**
	 * 	Destroy
	 */
	public void destroy ()
	{
		log.info ("destroy");
		if (!serverMgrFuture.isDone() && !serverMgrFuture.isCancelled())
		{
			serverMgrFuture.cancel(true);
		}
		serverMgrFuture = null;
		m_serverMgr = null;
		m_dirAccessList = null;
	}	//	destroy
	
	/**
	 * 	Log error/warning
	 *	@param message message
	 *	@param e exception
	 */
	public void log (String message, Throwable e)
	{
		if (e == null)
			log.warning (message);
		log.log(Level.SEVERE, message, e);
	}	//	log
	
	/**
	 * 	Log debug
	 *	@param message message
	 */
	public void log (String message)
	{
		log.fine(message);
	}	//	log

	
	/**
	 * 	Get Servlet Name
	 *	@return servlet name
	 */
	public String getServletName ()
	{
		return "AdempiereMonitor";
	}	//	getServletName

	/**
	 * 	Get Servlet Info
	 *	@return servlet info
	 */
	public String getServletInfo ()
	{
		return "iDempiere Server Monitor";
	}	//	getServletName

	private static final String s_dirAccessFileName = "dirAccess.txt";
	
	private ArrayList<File> getDirAcessList()
	{
		final ArrayList<File> dirAccessList = new ArrayList<File>();
		
		// by default has access to log directory
		CLogFile fileHandler = CLogFile.get (true, null, false);
		File logDir = fileHandler.getLogDirectory();
		dirAccessList.add(logDir);
		
		// load from dirAccess.properties file
		String dirAccessPathName = Adempiere.getAdempiereHome() + File.separator + s_dirAccessFileName;
		File dirAccessFile = new File(dirAccessPathName);
		if (dirAccessFile.exists()) 
		{
			try 
			{
				BufferedReader br = new BufferedReader(new FileReader(dirAccessFile));
		        while (true) {
		            String pathName = br.readLine();
		            if (pathName == null)
		            	break;
					File pathDir = new File(pathName);
					if (pathDir.exists() && !dirAccessList.contains(pathDir))
						dirAccessList.add(pathDir);
		        }
		        br.close();
			} 
			catch (Exception e) 
			{
				log.log(Level.SEVERE, dirAccessPathName + " - " + e.toString());
			}
		}
		/* -- uncomment to generate a default file
		else
		{
			try 
			{
				FileWriter fw = new FileWriter(dirAccessFile);
				fw.write(logDir.getCanonicalPath() + "\n");
				fw.close();
			} 
			catch (Exception e) 
			{
				log.log(Level.SEVERE, dirAccessPathName + " - " + e.toString());
			}
		}
		*/
				
		return dirAccessList;
	}
	
	private static final String escapeEcmaScript(String input) {
		input = input.replace("'", "\\'");
		input = input.replace("\"", "\\\"");
		input = input.replace("\\", "\\\\");
		input = input.replace("/", "\\/");
		input = input.replace("\n", "\\n");
		input = input.replace("\t", "\\t");
		return input;
	 }
	
	/**
	 * 	return cache details page
	 *	@param request request
	 *	@param response response
	 *	@return true if it was a cache details request
	 *	@throws ServletException
	 *	@throws IOException
	 */
	private boolean createCacheDetailsPage (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		String cmd = WebUtil.getParameter (request, "CacheDetails");
		if (cmd == null || cmd.length() == 0)
			return false;
		
		WebDoc doc = WebDoc.create ("iDempiere Server Cache Details");
		//	Body
		body b = doc.getBody();
		//
		p para = new p();
		a link = new a ("idempiereMonitor", "Return");
		para.addElement(link);
		b.addElement(para);
		//
		table table = new table();
		table.setBorder(1);
		table.setCellSpacing(2);
		table.setCellPadding(2);
		
		//	Header
		tr line = new tr();
		line.addElement(new th().addElement("Name"));
		line.addElement(new th().addElement("Table Name"));
		line.addElement(new th().addElement("Size"));
		line.addElement(new th().addElement("Expire (Minutes)"));
		line.addElement(new th().addElement("Max Size"));
		line.addElement(new th().addElement("Hit"));
		line.addElement(new th().addElement("Miss"));
		line.addElement(new th().addElement("Distributed"));
		table.addElement(line);
		
		List<CacheInfo> instances = CacheInfo.getCacheInfos(true);
		if (instances.size() > 0 && instances.get(0).getNodeId() != null) 
		{
			line.addElement(new th().addElement("Node Id"));
		}
		for (CacheInfo ccache : instances)
		{		
			if (ccache.getName().endsWith("|CCacheListener"))
				continue;
			if (ccache.getSize() > 0)
			{
				line = new tr();
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getName())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getTableName())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getSize())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getExpireMinutes())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getMaxSize())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getHit())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getMiss())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.isDistributed())));
				if (ccache.getNodeId() != null)
				{
					line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getNodeId())));
				}
				table.addElement(line);
			}
		}
		for (CacheInfo ccache : instances)
		{		
			if (ccache.getName().endsWith("|CCacheListener"))
				continue;
			if (ccache.getSize() == 0)
			{
				line = new tr();
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getName())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getTableName())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getSize())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getExpireMinutes())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getMaxSize())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getHit())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getMiss())));
				line.addElement(new td().addElement(WebEnv.getCellContent(ccache.isDistributed())));
				if (ccache.getNodeId() != null)
				{
					line.addElement(new td().addElement(WebEnv.getCellContent(ccache.getNodeId())));
				}
				table.addElement(line);
			}
		}
		//
		b.addElement(table);
		link = new a ("#top", "Top");
		b.addElement(link);
		
		//	fini
		WebUtil.createResponse (request, response, this, null, doc, false);
		return true;
	}	//	processLogParameter

	/**
	 * 	return cache details page
	 *	@param request request
	 *	@param response response
	 *	@return true if it was a cache details request
	 *	@throws ServletException
	 *	@throws IOException
	 */
	public boolean processNodeInfoPage (HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		String nodeId = WebUtil.getParameter (request, "NodeInfo");
		if (nodeId == null || nodeId.length() == 0)
			return false;
		
		WebDoc doc = WebDoc.create ("Details for node " + nodeId);
		//	Body
		body b = doc.getBody();
		p para = new p();		
		a link = new a ("idempiereMonitor", "Return");
		para.addElement(link);
		b.addElement(para);
		
		createNodeInfoPage(b, nodeId);
		
		WebUtil.createResponse (request, response, this, null, doc, false);
		
		return true;
	}
		
	private void createNodeInfoPage (body bb, String nodeId)
	{
		SystemInfo systemInfo = SystemInfo.getClusterNodeInfo(nodeId);
		if (systemInfo == null)
			return;
		
		bb.addElement(new hr());
		
		table table = new table();
		table.setBorder(1);
		table.setCellSpacing(2);
		table.setCellPadding(2);		
		
		tr line = new tr();
		line.addElement(new th().addElement("Property File"));
		line.addElement(new td().addElement(systemInfo.getPropertyFileName()));
		table.addElement(line);
		
		line = new tr();
		InetAddress address = systemInfo.getAddress();
		line.addElement(new th().addElement("Host Name"));
		line.addElement(new td().addElement(address.getCanonicalHostName()));
		table.addElement(line);
		
		//	OS + Name
		line = new tr();
		line.addElement(new th().addElement("Operating System"));
		line.addElement(new td().addElement(systemInfo.getOperatingSystem()));
		table.addElement(line);
		//	Java + email
		line = new tr();
		line.addElement(new th().addElement(systemInfo.getJavaVM()));
		line.addElement(new td().addElement("Average GC Time=" + systemInfo.getGarbageCollectionTime() / systemInfo.getGarbageCollectionCount() + " ms"));
		table.addElement(line);
		//	DB + Instance
		line = new tr();
		line.addElement(new th().addElement(systemInfo.getDatabaseDescription()));
		line.addElement(new td().addElement(systemInfo.getDatabaseConnectionURL()));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("DB Connection Pool"));
		line.addElement(new td().addElement(systemInfo.getDatabaseStatus()));
		table.addElement(line);
		//	Processors/Support
		line = new tr();
		line.addElement(new th().addElement("Processor (Average System Load)"));
		line.addElement(new td().addElement(systemInfo.getAvailableProcessors() + " (" 
				+ systemInfo.getAverageSystemLoad() + ") "));
		table.addElement(line);
		//	Memory
		line = new tr();
		line.addElement(new th().addElement("VM Memory"));
		line.addElement(new td().addElement(systemInfo.getMemoryUsage()));
		table.addElement(line);
		line = new tr();
		line.addElement(new th().addElement("Heap Memory"));
		line.addElement(new td().addElement(systemInfo.getHeapMemoryUsage()));
		table.addElement(line);
		//	Runtime
		line = new tr();
		line.addElement(new th().addElement("Runtime " + systemInfo.getRuntimeName()));
		line.addElement(new td().addElement(TimeUtil.formatElapsed(systemInfo.getRuntimeUpTime())));
		table.addElement(line);
		//	Threads
		line = new tr();
		line.addElement(new th().addElement("Threads " + systemInfo.getThreadCount()));
		line.addElement(new td().addElement("Peak=" + systemInfo.getPeakThreadCount() 
			+ ", Daemons=" + systemInfo.getDaemonThreadCount()
			+ ", Total=" + systemInfo.getTotalStartedThreadCount()));
		table.addElement(line);
		
		//Transactions
		TrxInfo[] trxs = systemInfo.getTrxInfos();
		for (TrxInfo trx : trxs)
		{
			line = new tr();
			line.addElement(new th().addElement((trx.isActive() ? "Active" : "Inactive") + " Transaction "));
			td td = new td();
			if (Util.isEmpty(trx.getStackTrace())) {
				td.addElement("Name=" + trx.getDisplayName() + ", StartTime=" + formatTimestampWithTimeZone(0,trx.getStartTime()));
				td.setTitle(trx.getTrxName());
			} else {
				td.setOnClick("var newwindow=window.open('','Popup', 'width=800,height=600');newwindow.document.write('<title>"  + escapeEcmaScript(trx.getDisplayName()) +"</title>"
						+ "<p><b>Transaction = " + trx.getDisplayName() + "</b></p>"
						+ "<p><b>TrxName = " + trx.getTrxName() + "</b></p>"
						+ "<pre>" + escapeEcmaScript(trx.getStackTrace()) + "</pre>')");
				label lbl = new label().addElement(trx.getDisplayName());
				lbl.setStyle("text-decoration: underline; color: blue");
				td.addElement("Name=").addElement(lbl).addElement(", StartTime=" + formatTimestampWithTimeZone(0,trx.getStartTime()));
				td.setTitle("Click to see stack trace for " + trx.getTrxName());
			}
			line.addElement(td);
			table.addElement(line);
		}
		
		//	Trace Level
		line = new tr();
		line.addElement(new th().addElement(new label("TraceLevel").addElement("Trace Log Level")));
		form myForm = new form("idempiereMonitor", form.METHOD_POST, form.ENC_DEFAULT);
		//	LogLevel Selection
		option[] options = new option[CLogMgt.LEVELS.length];
		for (int i = 0; i < options.length; i++) 
		{
			options[i] = new option(CLogMgt.LEVELS[i].getName());
			options[i].addElement(CLogMgt.LEVELS[i].getName());
			if (CLogMgt.LEVELS[i] == systemInfo.getLogLevel())
				options[i].setSelected(true);
		}
		select sel = new select("TraceLevel", options);
		myForm.addElement(sel);
		myForm.addElement(new input(input.TYPE_HIDDEN, "nodeId", nodeId));
		myForm.addElement(new input(input.TYPE_SUBMIT, "Set", "Set"));
		line.addElement(new td().addElement(myForm));
		table.addElement(line);
		//
		line = new tr();
		line.addElement(new th().addElement("Trace File"));
		line.addElement(new td().addElement(new a ("idempiereMonitor?Trace=" + systemInfo.getCurrentLogFile()
			 + "&nodeId=" + nodeId, "Current")));
		table.addElement(line);
		//
		line = new tr();
		p tlp = new p();
		tlp.addElement(new a ("idempiereMonitor?Trace=ROTATE&nodeId="+nodeId, "Rotate Trace Log"))
		  .addElement(" - ")
		  .addElement(new a ("idempiereMonitor?Trace=DELETE&nodeId="+nodeId, "Delete all Trace Logs"));
		line.addElement(new th());
		line.addElement(new td().addElement(tlp));
		table.addElement(line);
		//
		bb.addElement(table);
		
		//	List Log Files
		p p = new p();
		p.addElement(new b("All Log Files: "));
		//	All in dir
		LogFileInfo logFiles[] = systemInfo.getLogFileInfos();
		for (LogFileInfo logFile : logFiles) 
		{
			if (logFile != logFiles[0])
				p.addElement(" - ");
			String fileName = logFile.getFileName();
			a link = new a ("idempiereMonitor?Trace=" + fileName + "&nodeId="+nodeId, fileName);
			p.addElement(link);
			int size = (int)(logFile.getFileSize()/1024);
			if (size < 1024)
				p.addElement(" (" + size + "k)");
			else
				p.addElement(" (" + size/1024 + "M)");
		}		
		bb.addElement(p);
		
		//	
		line = new tr();
		line.addElement(new th().addElement("Active sessions for node" ));
		line.addElement(new td().addElement(""+systemInfo.getSessionCount()));
		table.addElement(line);
		//
		bb.addElement(table);
	}
	
}	//	AdempiereMonitor
