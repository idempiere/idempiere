package org.adempiere.client;

import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;

import org.compiere.util.CLogger;

import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;
import org.restlet.Client;
import org.restlet.Context;
import org.restlet.data.Protocol;
import org.restlet.ext.net.HttpClientHelper;

public class Application implements IApplication {
	private static CLogger log = CLogger.getCLogger(Application.class);
	
	public static Context context = null;

	public Object start(IApplicationContext ctx) throws Exception {
		log.info("Starting client");
		// A HOSTNAME VERIFIER THAT ACCEPTS EVERY HOSTS
		HostnameVerifier myhostnameverifier = new HostnameVerifier() {
			@Override
			public boolean verify(String urlHostName, SSLSession session) {
				return true;
			}
		};
		
		//
		//start restlet context
		context = new Context();
		context.getAttributes().put("sslContextFactory", new ClientSSLContextFactory());
		context.getAttributes().put("hostnameVerifier", myhostnameverifier);
		List<Protocol> list = new ArrayList<Protocol>();
		list.add(Protocol.HTTPS);
		Client client = new Client(context, list, HttpClientHelper.class.getName());		
		context.setClientDispatcher(client);
		client.start();
		
		org.compiere.AdempiereClient.main(new String[]{});
		return IApplication.EXIT_OK;
	}

	public void stop() {
	}

}
