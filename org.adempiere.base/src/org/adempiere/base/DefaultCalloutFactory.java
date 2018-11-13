/******************************************************************************
 * Copyright (C) 2015 Dirk Niemeyer                                           *
 * Copyright (C) 2015 action 42 GmbH              							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import java.lang.reflect.Method;
import java.util.logging.Level;

import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.compiere.model.Callout;
import org.compiere.util.CLogger;

/**
 * @author a42niem
 *
 * This is just a blueprint for creation of a CalloutFactory 
 * 
 */
public class DefaultCalloutFactory implements ICalloutFactory {

	private final static CLogger log = CLogger.getCLogger(DefaultCalloutFactory.class);
	
	/**
	 * default constructor
	 */
	public DefaultCalloutFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.ICalloutFactory#getCallout(java.lang.String)
	 */
	@Override
	public Callout getCallout(String className, String methodName) {
		Callout callout = null;
		callout = EquinoxExtensionLocator.instance().locate(Callout.class, Callout.class.getName(), className, (ServiceQuery)null).getExtension();		
		if (callout == null) {
			//Get Class
			Class<?> calloutClass = null;
			//use context classloader if available
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			if (classLoader != null)
			{
				try
				{
					calloutClass = classLoader.loadClass(className);
				}
				catch (ClassNotFoundException ex)
				{
					if (log.isLoggable(Level.FINE))log.log(Level.FINE, className, ex);
				}
			}
			if (calloutClass == null)
			{
				classLoader = this.getClass().getClassLoader();
				try
				{
					calloutClass = classLoader.loadClass(className);
				}
				catch (ClassNotFoundException ex)
				{
					log.log(Level.WARNING, className, ex);
					return null;
				}
			}

			if (calloutClass == null) {
				return null;
			}

			//Get callout
			try
			{
				callout = (Callout)calloutClass.getDeclaredConstructor().newInstance();
			}
			catch (Exception ex)
			{
				log.log(Level.WARNING, "Instance for " + className, ex);
				return null;
			}

			//Check if callout method does really exist
			Method[] methods = calloutClass.getDeclaredMethods();
			for (int i = 0; i < methods.length; i++) {
		        if (methods[i].getName().equals(methodName)) {
		        	return callout;
		        }
			}
		}
		log.log(Level.FINE, "Required method " + methodName + " not found in class " + className);
		return null;
	}

}
