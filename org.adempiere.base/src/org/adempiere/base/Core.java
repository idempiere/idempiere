package org.adempiere.base;

import java.net.URL;
import java.util.List;

import org.compiere.model.ModelValidator;
import org.compiere.process.ProcessCall;

/**
 * This is a facade class for the Service Locator.
 * It provides simple access to all core services.
 *
 * @author viola
 */
public class Core {

	public static final String OSGI_PREFIX = "osgi:";

	public static IResourceFinder getResourceFinder() {
		return new IResourceFinder() {

			public URL getResource(String name) {
				List<IResourceFinder> f = Service.list(IResourceFinder.class);
				for (IResourceFinder finder : f) {
					URL url = finder.getResource(name);
					if (url!=null)
						return url;
				}
				return null;
			}
		};
	}

	public static List<IColumnCallout> findCallout(String tableName, String columnName) {
		ServiceQuery query = new ServiceQuery();
		query.put("tableName", tableName);
		query.put("columnName", columnName);

		return Service.list(IColumnCallout.class, query);
	}

	public static boolean isExtension(String className) {
		return className.startsWith(OSGI_PREFIX);
	}

	public static ProcessCall getProcess(String className) {
		if (isExtension(className))
			className = className.substring(Core.OSGI_PREFIX.length());

		ServiceQuery query = new ServiceQuery();
		query.put(ServiceQuery.EXTENSION_ID, className);
		return Service.locate(ProcessCall.class, "org.adempiere.base.Process", query);
	}

	public static ModelValidator getModelValidator(String className) {
		if (isExtension(className))
			className = className.substring(Core.OSGI_PREFIX.length());

		ServiceQuery query = new ServiceQuery();
		query.put(ServiceQuery.EXTENSION_ID, className);
		return Service.locate(ModelValidator.class, "org.adempiere.base.ModelValidator", query);
	}

}
