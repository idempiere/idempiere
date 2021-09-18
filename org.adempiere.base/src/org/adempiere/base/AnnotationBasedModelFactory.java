/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

import org.atteo.classindex.ClassIndex;
import org.compiere.util.CCache;
import org.osgi.framework.Bundle;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.ComponentContext;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;

/**
 * Translates table names into model classes having the {@link Model} annotation. Relies on
 * {@link DefaultModelFactory} for everything else.
 * This factory is designed to have a service rank higher than {@link DefaultModelFactory}, as class
 * discovery using SPI is preferred over reflection-based methods.
 * @author Saulo Gil
 */
@Component(immediate = true, service = IModelFactory.class, property = {"service.ranking:Integer=-1"})
public class AnnotationBasedModelFactory extends AbstractModelFactory implements IModelFactory
{

	private Bundle usingBundle;

	private CCache<String,Class<?>> classCache = new CCache<String,Class<?>>(null, "ABMF", 100, 120, false, 2000);

	@Activate
	void activate(ComponentContext context)
	{
		this.usingBundle = context.getUsingBundle();
	}

	@Override
	public Class<?> getClass(String tableName) 
	{
		// search first into cache
		Class<?> candidate = classCache.get(tableName);
		if (candidate != null)
		{
			// Object.class indicate no generated PO class for tableName
			if (candidate.equals(Object.class))
				return null;
			else
				return candidate;
		}

		// scan model annotations
		BundleWiring wiring = usingBundle.adapt(BundleWiring.class);
		for(Class<?> xClass : ClassIndex.getAnnotated(Model.class, wiring.getClassLoader()))
		{
			Model annotation = xClass.getAnnotation(Model.class);
			if(annotation.table().equalsIgnoreCase(tableName))
			{
				candidate = xClass;
				for(Class<?> mClass : ClassIndex.getSubclasses(xClass, wiring.getClassLoader())) {
					if(!mClass.equals(candidate) && candidate.isAssignableFrom(mClass))
						// favoring candidates higher in the class hierarchy
						candidate = mClass;
				}
				break;
			}
		}

		//Object.class to indicate no PO class for tableName
		classCache.put(tableName, candidate == null ? Object.class : candidate);

		return candidate;
	}

}
