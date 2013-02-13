/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.ui.swing.factory;

import java.util.logging.Level;

import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.compiere.apps.form.FormPanel;
import org.compiere.util.CLogger;

/**
 * @author hengsin
 *
 */
public class DefaultFormFactory implements IFormFactory {

	private final static CLogger log = CLogger.getCLogger(DefaultFormFactory.class);
	
	/**
	 * default constructor
	 */
	public DefaultFormFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.ui.swing.factory.IFormFactory#newFormInstance(java.lang.String)
	 */
	@Override
	public FormPanel newFormInstance(String formName) {
		FormPanel form = EquinoxExtensionLocator.instance().locate(FormPanel.class, "org.adempiere.apps.Form", formName, null).getExtension();
		if (form == null) {
			ClassLoader loader = Thread.currentThread().getContextClassLoader();
			Class<?> clazz = null;
			if (loader != null) {
				try {
					clazz = loader.loadClass(formName);
				} catch (Exception e) {
					if (log.isLoggable(Level.INFO)) {
						log.log(Level.INFO, e.getLocalizedMessage(), e);
					}
				}
			}
			if (clazz == null) {
				loader = this.getClass().getClassLoader();
				try {
					clazz = loader.loadClass(formName);
				} catch (Exception e) {
					if (log.isLoggable(Level.INFO)) {
						log.log(Level.INFO, e.getLocalizedMessage(), e);
					}
				}
			}
			if (clazz != null) {
				try {
					form = (FormPanel) clazz.newInstance();
				} catch (Exception e) {
					if (log.isLoggable(Level.WARNING)) {
						log.log(Level.WARNING, e.getLocalizedMessage(), e);
					}
				}
			}
		}
		return form;
	}

}
