package org.eclipse.equinox.http.servlet;

import java.util.Dictionary;
import javax.servlet.Filter;
import javax.servlet.ServletException;
import org.osgi.service.http.*;

/**
 * @since 1.1
 */
public interface ExtendedHttpService extends HttpService {
	/**
	 * @param alias name in the URI namespace at which the filter is registered
	 * @param filter the filter object to register
	 * @param initparams initialization arguments for the filter or
	 *        <code>null</code> if there are none. This argument is used by the
	 *        filter's <code>FilterConfig</code> object.
	 * @param context the <code>HttpContext</code> object for the registered
	 *        filter, or <code>null</code> if a default <code>HttpContext</code> is
	 *        to be created and used.
	 * @throws javax.servlet.ServletException if the filter's <code>init</code>
	 *            method throws an exception, or the given filter object has
	 *            already been registered at a different alias.
	 * @throws java.lang.IllegalArgumentException if any of the arguments are
	 *            invalid
	 */
	public void registerFilter(String alias, Filter filter, Dictionary<String, String> initparams, HttpContext context) throws ServletException, NamespaceException;

	/**
	 * Unregisters a previous filter registration done by the 
	 * <code>registerFilter</code> method.
	 * 
	 * <p>
	 * After this call, the registered filter will no
	 * longer be available. The Http Service must call the <code>destroy</code>
	 * method of the filter before returning.
	 * <p>
	 * If the bundle which performed the registration is stopped or otherwise
	 * "unget"s the Http Service without calling {@link #unregisterFilter} then the Http
	 * Service must automatically unregister the filter registration. However, the 
	 * <code>destroy</code> method of the filter will not be called in this case since
	 * the bundle may be stopped.
	 * {@link #unregisterFilter} must be explicitly called to cause the
	 * <code>destroy</code> method of the filter to be called. This can be done
	 * in the <code>BundleActivator.stop</code> method of the
	 * bundle registering the filter.
	 * 
	 * @param filter the filter object to unregister
	 * @throws java.lang.IllegalArgumentException if there is no registration
	 *            for the filter or the calling bundle was not the bundle which
	 *            registered the filter.
	 */
	public void unregisterFilter(Filter filter);

}
