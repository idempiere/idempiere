package org.compiere.web;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Implementation of <code>javax.servlet.Filter</code> used to compress
 * the ServletResponse if it is bigger than a threshold.
 *
 * @author Amy Roh
 * @author Dmitri Valdin
 * @version $Revision: 1.2 $, $Date: 2004/03/18 16:40:33 $
 */

public class MD5Filter implements Filter{

    /**
     * The filter configuration object we are associated with.  If this value
     * is null, this filter instance is not currently configured.
     */
    private FilterConfig config = null;

    /**
    /**
     * Place this filter into service.
     *
     * @param filterConfig The filter configuration object
     */

    public void init(FilterConfig filterConfig) {

        config = filterConfig;
    }

    /**
    * Take this filter out of service.
    */
    public void destroy() {

        this.config = null;

    }

    /**
     * The <code>doFilter</code> method of the Filter is called by the container
     * each time a request/response pair is passed through the chain due
     * to a client request for a resource at the end of the chain.
     * The FilterChain passed into this method allows the Filter to pass on the
     * request and response to the next entity in the chain.<p>
     * This method first examines the request to check whether the client support
     * compression. <br>
     * It simply just pass the request and response if there is no support for
     * compression.<br>
     * If the compression support is available, it creates a
     * CompressionServletResponseWrapper object which compresses the content and
     * modifies the header if the content length is big enough.
     * It then invokes the next entity in the chain using the FilterChain object
     * (<code>chain.doFilter()</code>), <br>
     **/

    public void doFilter ( ServletRequest request, ServletResponse response,
                        FilterChain chain ) throws IOException, ServletException {

        if (request instanceof HttpServletRequest) {
            // is md5 request
            String s = (String) ((HttpServletRequest)request).getParameter("md5");
            if (!"true".equals(s)) {
                chain.doFilter(request, response);
                return;
            }
        }

        if (response instanceof HttpServletResponse) {
        	MD5ResponseWrapper wrappedResponse =
                new MD5ResponseWrapper((HttpServletResponse)response);
            try {
                chain.doFilter(request, wrappedResponse);
            } finally {
                wrappedResponse.finishResponse();
            }
            return;
        }
    }

    /**
     * Set filter config
     * This function is equivalent to init. Required by Weblogic 6.1
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        init(filterConfig);
    }

    /**
     * Return filter config
     * Required by Weblogic 6.1
     */
    public FilterConfig getFilterConfig() {
        return config;
    }

}
