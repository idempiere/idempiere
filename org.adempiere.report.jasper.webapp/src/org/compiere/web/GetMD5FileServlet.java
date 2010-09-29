/*
 * Créé le 22 mars 2005
 *
 * TODO Pour changer le modčle de ce fichier généré, allez ŕ :
 * Fenętre - Préférences - Java - Style de code - Modčles de code
 */
package org.compiere.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.compiere.util.Util;
import org.compiere.utils.MD5Impl;

/**
 * Servlet Class
 *
 * @author Michael Judd BF [2728388] - fix potential CSS vulnerability
 */
public class GetMD5FileServlet extends HttpServlet {

	/**
	 *
	 */
	private static final long serialVersionUID = -2625917637549702574L;
	/**
	 *
	 */
	private MD5Impl md5;

	public GetMD5FileServlet() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		md5 = new MD5Impl();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException,
		IOException {
		// TODO Auto-generated method stub
		String file = Util.maskHTML(req.getParameter("File"));
		String output = req.getParameter("output");
		if ("text".equalsIgnoreCase(output))
		{
			resp.setContentType("text/plain");
			PrintWriter out = resp.getWriter();
			out.print(md5.getFileMD5(file));
		}
		else
		{
			PrintWriter out = resp.getWriter();
			out.println("<HTML><HEAD><TITLE>MD5 Hash</TITLE></HEAD><BODY>");
			out.println("File is: "+ file + "<BR>MD5 : "+ md5.getFileMD5(file)+"<BR>");
			//out.println(md5.getFileAsolutePath(file));
			out.println("</BODY></HTML>");
		}
	}

}