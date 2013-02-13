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
package org.adempiere.base;

import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.compiere.model.ModelValidator;

/**
 * @author hengsin
 *
 */
public class DefaultModelValidatorFactory implements IModelValidatorFactory {

	/**
	 * default constructor
	 */
	public DefaultModelValidatorFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IModelValidatorFactory#newModelValidatorInstance(java.lang.String)
	 */
	@Override
	public ModelValidator newModelValidatorInstance(String className) {
		ModelValidator validator = EquinoxExtensionLocator.instance().locate(ModelValidator.class, "org.adempiere.base.ModelValidator", className, null).getExtension();
		if (validator == null) {
			Class<?> clazz = null;
			
			//use context classloader if available
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			if (classLoader != null) {
				try {
					clazz = classLoader.loadClass(className);
				}
				catch (ClassNotFoundException ex) {
				}
			}
			if (clazz == null) {
				classLoader = this.getClass().getClassLoader();
				try {
					clazz = classLoader.loadClass(className);
				}
				catch (ClassNotFoundException ex) {
				}
			}
			if (clazz != null) {
				try {
					validator = (ModelValidator)clazz.newInstance();
				} catch (Exception e) {
					e.printStackTrace();
				} 
			} else {
				new Exception("Failed to load model validator class " + className).printStackTrace();
			}
		}
		
		return validator;
	}

}
