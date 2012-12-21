<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@ page language="java" contentType="application/octet-stream"%>
<%
	String key = request.getParameter("key");
	if (key == null || key.trim().length() == 0 )
		return;
	
	Object object = session.getAttribute(key);
	if (object != null && object instanceof java.util.List) {
		java.util.List list = (java.util.List)object;
		System.out.println("size=" + list.size());
		if (!list.isEmpty()) {
			byte[] data = (byte[])list.remove(0);
			System.out.println("length=" + data.length);
			response.setContentLength(data.length);
			
			OutputStream os = response.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(os);
			bos.write(data);
			bos.flush();
		} else {
			response.setContentLength(0);
		}
	} else {
		System.out.println("key not found=" + key);
		response.setContentLength(0);
	}
%>
