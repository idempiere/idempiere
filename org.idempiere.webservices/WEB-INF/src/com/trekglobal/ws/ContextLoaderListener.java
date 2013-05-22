/**
 * 
 */
package com.trekglobal.ws;

import javax.servlet.ServletContextEvent;

/**
 * @author hengsin
 *
 */
public class ContextLoaderListener extends
		org.springframework.web.context.ContextLoaderListener {

	/**
	 * 
	 */
	public ContextLoaderListener() {
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(getClass().getClassLoader());
			super.contextInitialized(event);
		} finally {
			Thread.currentThread().setContextClassLoader(cl);
		}
	}

}
