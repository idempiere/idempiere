package org.adempiere.base;

import org.atteo.classindex.ClassIndex;

/**
 * Translates table names into model classes having the {@link Model} annotation. Relies on
 * {@link DefaultModelFactory} for everything else.
 * This factory is designed to have a service rank higher than {@link DefaultModelFactory}, as class
 * discovery using SPI is preferred over reflection-based methods.
 * @author Saulo Gil
 */
public class AnnotationBasedModelFactory extends DefaultModelFactory {

	@Override
	public Class<?> getClass(String tableName) 
	{
		// search first into DefaultModelFactory's cache
		Class<?> candidate = s_classCache.get(tableName);
		if (candidate != null)
		{
			// Object.class indicate no generated PO class for tableName
			if (candidate.equals(Object.class))
				return null;
			else
				return candidate;
		}

		// scan annotations
		for(Class<?> clazz : ClassIndex.getAnnotated(Model.class))
		{
			Model ma = clazz.getAnnotation(Model.class);
			if(ma.table().equalsIgnoreCase(tableName)) 
			{
				candidate = clazz;
				// M* classes are preferred over X* classes
				if(!ma.intermediate())
					break;
			}
		}

		if(candidate!=null)
			// inject association into DefaultModelFactory's cache
			s_classCache.put(tableName, candidate);

		return candidate;
	}

}
