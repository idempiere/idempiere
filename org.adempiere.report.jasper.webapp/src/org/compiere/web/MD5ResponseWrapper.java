/**
 *
 */
package org.compiere.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

/**
 * @author hengsin
 *
 */
public class MD5ResponseWrapper extends HttpServletResponseWrapper {

	private ServletOutputStream stream = null;
	private PrintWriter writer = null;
	private HttpServletResponse origResponse;

	/**
	 * @param response
	 */
	public MD5ResponseWrapper(HttpServletResponse response) {
		super(response);
		origResponse = response;
	}

	public void finishResponse() {
		if (stream != null) {
			String digest = ((MD5OutputStream)stream).getMD5Hash();
			origResponse.setContentType("text/plain");
			origResponse.setContentLength(digest.getBytes().length);
			try {
				origResponse.getOutputStream().write(digest.getBytes());
				origResponse.getOutputStream().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public ServletOutputStream getOutputStream() throws IOException {
		if (writer != null)
            throw new IllegalStateException("getWriter() has already been called for this response");

        if (stream == null)
            stream = createOutputStream();

        return (stream);
	}

	@Override
	public PrintWriter getWriter() throws IOException {
		if (writer != null)
            return (writer);

        if (stream != null)
            throw new IllegalStateException("getOutputStream() has already been called for this response");

        stream = createOutputStream();

        writer = new PrintWriter(stream);
		return writer;
	}

	private ServletOutputStream createOutputStream() {
		stream = new MD5OutputStream();
		return stream;
	}

}
