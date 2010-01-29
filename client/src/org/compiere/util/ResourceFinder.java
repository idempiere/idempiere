package org.compiere.util;

import java.net.URL;

import org.adempiere.base.IResourceFinder;
import org.compiere.AdempiereClient;

public class ResourceFinder implements IResourceFinder {

	public ResourceFinder() {
	}

	public URL getResource(String name) {
		URL resource = AdempiereClient.class.getResource(name);
		return resource;
	}

}
