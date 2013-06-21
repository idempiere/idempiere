<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@ page language="java" contentType="application/octet-stream"%>
<%
	String filepath = request.getParameter("filepath");
	if (filepath == null || filepath.trim().length() == 0 )
		return;
	
	File file = new File(filepath);
	if (file.exists()) 
	{	
		FileInputStream fis = null;
		ByteArrayOutputStream baos = null;
		byte[] data = null;
		try
		{
			fis = new FileInputStream (file);
			baos = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024*8];   //  8kB
			int length = -1;
			while ((length = fis.read(buffer)) != -1)
				baos.write(buffer, 0, length);			
			data = baos.toByteArray();
			fis.close();
			baos.close();
			
			response.setContentLength(data.length);
			
			OutputStream os = response.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(os);
			bos.write(data);
			bos.flush();
			bos.close();
			
			file.delete();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			response.setContentLength(0);
		}
	}
	else 
	{
		System.out.println("file not found=" + filepath);
		response.setContentLength(0);
	}
%>
