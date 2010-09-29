/******************************************************************************
 * Copyright (C) 2010 Low Heng Sin  All Rights Reserved.                      *
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
package org.adempiere.client;

import java.io.FileInputStream;
import java.security.KeyStore;
import java.security.SecureRandom;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

import org.restlet.engine.security.DefaultSslContextFactory;

/**
 * Temporary workaround to support ssl connection to server with self signed certificate.
 * @author hengsin
 * 
 */
public class ClientSSLContextFactory extends DefaultSslContextFactory {

	/**
	 * Name of the KeyManager algorithm.
	 */
	private volatile String keyManagerAlgorithm = System.getProperty(
			"ssl.KeyManagerFactory.algorithm",
			KeyManagerFactory.getDefaultAlgorithm());

	/**
	 * Password for the key in the keystore (as a String).
	 */
	private volatile char[] keyStoreKeyPassword = (System.getProperty(
			"javax.net.ssl.keyPassword",
			System.getProperty("javax.net.ssl.keyStorePassword")) != null) ? System
			.getProperty("javax.net.ssl.keyPassword",
					System.getProperty("javax.net.ssl.keyStorePassword"))
			.toCharArray() : null;

	/**
	 * Password for the keystore (as a String).
	 */
	private volatile char[] keyStorePassword = (System
			.getProperty("javax.net.ssl.keyStorePassword") != null) ? System
			.getProperty("javax.net.ssl.keyStorePassword").toCharArray() : null;

	/**
	 * Path to the KeyStore file.
	 */
	private volatile String keyStorePath = System
			.getProperty("javax.net.ssl.keyStore");

	/**
	 * Name of the keystore provider.
	 */
	private volatile String keyStoreProvider = System
			.getProperty("javax.net.ssl.keyStoreProvider");

	/**
	 * KeyStore type of the keystore.
	 */
	private volatile String keyStoreType = System
			.getProperty("javax.net.ssl.keyStoreType");
	
	/**
     * Name of the SecureRandom algorithm.
     */
    private volatile String secureRandomAlgorithm = null;

    /**
     * Name of the protocol to use when creating the SSLContext.
     */
    private volatile String secureSocketProtocol = "TLS";
	/**
	 * Name of the TrustManager algorithm.
	 */
	private volatile String trustManagerAlgorithm = System.getProperty(
			"ssl.TrustManagerFactory.algorithm",
			TrustManagerFactory.getDefaultAlgorithm());

	/**
	 * Password for the trust store keystore.
	 */
	private volatile char[] trustStorePassword = (System
			.getProperty("javax.net.ssl.trustStorePassword") != null) ? System
			.getProperty("javax.net.ssl.trustStorePassword").toCharArray()
			: null;

	/**
	 * Path to the trust store (keystore) file.
	 */
	private volatile String trustStorePath = System
			.getProperty("javax.net.ssl.trustStore");

	/**
	 * Name of the trust store (keystore) provider.
	 */
	private volatile String trustStoreProvider = System
			.getProperty("javax.net.ssl.trustStoreProvider");

	/**
	 * KeyStore type of the trust store.
	 */
	private volatile String trustStoreType = System
			.getProperty("javax.net.ssl.trustStoreType");

	/**
	 * Creates a configured and initialised SSLContext from the values set via
	 * the various setters of this class. If <code>keyStorePath</code>,
	 * <code>keyStoreProvider</code>, <code>keyStoreType</code> are all
	 * <code>null</code>, the SSLContext will be initialised with a
	 * <code>null</core> array of <code>KeyManager</code>s. Similarly, if
	 * <code>trustStorePath</code>, <code>trustStoreProvider</code>,
	 * <code>trustStoreType</code> are all <code>null</code>, a
	 * <code>null</code> array of <code>TrustManager</code>s will be used.
	 * 
	 * @see SSLContext#init(javax.net.ssl.KeyManager[],
	 *      javax.net.ssl.TrustManager[], SecureRandom)
	 */
	@Override
	public SSLContext createSslContext() throws Exception {

		KeyManagerFactory kmf = null;
		if ((this.keyStorePath != null) || (this.keyStoreProvider != null)
				|| (this.keyStoreType != null)) {
			/*
			 * Loads the key store.
			 */
			final KeyStore keyStore = (this.keyStoreProvider != null) ? KeyStore
					.getInstance(
							(this.keyStoreType != null) ? this.keyStoreType
									: KeyStore.getDefaultType(),
							this.keyStoreProvider)
					: KeyStore
							.getInstance((this.keyStoreType != null) ? this.keyStoreType
									: KeyStore.getDefaultType());
			FileInputStream keyStoreInputStream = null;
			try {
				keyStoreInputStream = ((this.keyStorePath != null) && (!"NONE"
						.equals(this.keyStorePath))) ? new FileInputStream(
						this.keyStorePath) : null;
				keyStore.load(keyStoreInputStream, this.keyStorePassword);
			} finally {
				if (keyStoreInputStream != null) {
					keyStoreInputStream.close();
				}
			}

			/*
			 * Creates the key-manager factory.
			 */
			kmf = KeyManagerFactory.getInstance(this.keyManagerAlgorithm);
			kmf.init(keyStore, this.keyStoreKeyPassword);
		}

		TrustManagerFactory tmf = null;
		if ((this.trustStorePath != null) || (this.trustStoreProvider != null)
				|| (this.trustStoreType != null)) {
			/*
			 * Loads the trust store.
			 */
			final KeyStore trustStore = (this.trustStoreProvider != null) ? KeyStore
					.getInstance(
							(this.trustStoreType != null) ? this.trustStoreType
									: KeyStore.getDefaultType(),
							this.trustStoreProvider)
					: KeyStore
							.getInstance((this.trustStoreType != null) ? this.trustStoreType
									: KeyStore.getDefaultType());

			FileInputStream trustStoreInputStream = null;
			try {
				trustStoreInputStream = ((this.trustStorePath != null) && (!"NONE"
						.equals(this.trustStorePath))) ? new FileInputStream(
						this.trustStorePath) : null;
				trustStore.load(trustStoreInputStream, this.trustStorePassword);
			} finally {
				if (trustStoreInputStream != null) {
					trustStoreInputStream.close();
				}
			}

			/*
			 * Creates the trust-manager factory.
			 */
			tmf = TrustManagerFactory.getInstance(this.trustManagerAlgorithm);
			tmf.init(trustStore);
		}

		TrustManager[] trustManagers = null;
		if (tmf != null) {
			trustManagers = tmf.getTrustManagers();
		} else {
			trustManagers = new TrustManager[]{
				new X509TrustManager() {
					public java.security.cert.X509Certificate[] getAcceptedIssuers() {
						return null;
					}
					public void checkClientTrusted(
							java.security.cert.X509Certificate[] certs, String authType) {
					}
					public void checkServerTrusted(
							java.security.cert.X509Certificate[] certs, String authType) {
					}
				}
			};
		}
		/*
		 * Creates the SSLContext.
		 */
		final SSLContext sslContext = SSLContext
				.getInstance(this.secureSocketProtocol);
		SecureRandom sr = null;
		if (this.secureRandomAlgorithm != null) {
			sr = SecureRandom.getInstance(this.secureRandomAlgorithm);
		}
		sslContext.init(kmf != null ? kmf.getKeyManagers() : null, trustManagers, sr);

		return sslContext;
	}

}
