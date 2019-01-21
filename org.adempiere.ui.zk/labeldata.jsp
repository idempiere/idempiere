<%@ page language="java" contentType="application/octet-stream"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="org.compiere.model.MArchive"%>
<%@page import="org.compiere.util.Env"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%	
	try
	{
		String fileid = request.getParameter("fileid");
		if (fileid == null || fileid.trim().length() == 0)
		{
			response.setContentLength(0);
			return;
		}
		
		int AD_Archive_ID = Integer.parseInt(fileid);
		if (AD_Archive_ID > 0)
		{
			MArchive archive = new MArchive(Env.getCtx(), AD_Archive_ID, null);
			if (archive != null && archive.getAD_Archive_ID() > 0)
			{
				byte[] data = archive.getBinaryData();
				response.setContentLength(data.length);
				
				OutputStream os = response.getOutputStream();
				BufferedOutputStream bos = new BufferedOutputStream(os);
				bos.write(data);
				bos.flush();
				bos.close();
				
				archive.delete(false);
			}
		}
	}
	catch (Exception e)
	{
		e.printStackTrace();
		response.setContentLength(0);
	}
%>
