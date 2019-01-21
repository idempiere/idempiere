<%@ page language="java" contentType="image/gif"%>
<%
String fileName = request.getParameter("f");
if (fileName != null && fileName.endsWith(".gif")) {
	java.io.File f = new java.io.File(fileName);
	if (f.exists() && f.canRead()) {
		response.setContentLength(new Long(f.length()).intValue());
		java.io.FileInputStream fis = new java.io.FileInputStream(f);
		java.io.BufferedInputStream bis = new java.io.BufferedInputStream(fis);
		java.io.OutputStream os = response.getOutputStream();
		java.io.BufferedOutputStream bos = new java.io.BufferedOutputStream(os);
		while (bis.available() > 0)
		{
			bos.write(bis.read());
		}
		bis.close();
		bos.flush();
		bos.close();
	}
}
%>
