/******************************************************************************
 * Copyright (C) 2013 Deepak                                                  *
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
package org.compiere.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.KeyStore;
import java.security.KeyStore.PasswordProtection;
import java.security.KeyStore.SecretKeyEntry;
import java.util.Properties;
import java.util.logging.Level;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import org.adempiere.base.IKeyStore;

/**
 * Default {@link IKeyStore} implementation
 * @author deepak
 * @author hengsin
 */
public class DefaultKeyStore implements IKeyStore {
	
	public static final String LEGACY_ALGORITHM = "DES";

	private static final String IDEMPIERE_KEYSTORE_PROPERTIES = "idempiere-ks.properties";

	private static final String IDEMPIERE_KEYSTORE = "idempiere.ks";

	/**	Logger						*/
	private static CLogger	log	= CLogger.getCLogger (DefaultKeyStore.class.getName());
	
	/** Adempiere Key				*/
	private SecretKey m_key = null;

	private KeyStore keyStore;

	private char[] password = null;

	private String algorithm;

	/**
	 * Load or create key store
	 */
	public DefaultKeyStore(){
		File file = new File(Ini.getAdempiereHome(), IDEMPIERE_KEYSTORE_PROPERTIES);
		if (file.exists()) {
			FileInputStream is = null;
			try{
				is = new FileInputStream(file);
				Properties p = new Properties();
				p.load(is);
				String s = p.getProperty("password");
				String a = p.getProperty("algorithm");
				if (!Util.isEmpty(s) && !Util.isEmpty(a)) {
					password = s.toCharArray();
					algorithm = a;
					// BKS for Bouncy Castle, BCFKS for Bouncy Castle FIPS, JCEKS for JDK default provider
					String keyStoreType = p.getProperty("type");
					if (Util.isEmpty(keyStoreType, true))
						keyStoreType = "JCEKS";
					// BC for Bouncy Castle, BCFIPS for Bouncy Castle FIPS
					String provider = p.getProperty("provider");
					// org.bouncycastle.jce.provider.BouncyCastleProvider for Bouncy Castle
					// org.bouncycastle.jcajce.provider.BouncyCastleFipsProvider for Bouncy Castle FIPS
					String providerClass = p.getProperty("providerClass");
					if (!Util.isEmpty(providerClass, true) && !Util.isEmpty(provider, true)) {
						if (java.security.Security.getProvider(provider) == null) {
							// load and register the provider class dynamically
							Class<?> clazz = Class.forName(providerClass);
							Object providerInstance = clazz.getDeclaredConstructor().newInstance();
							if (providerInstance != null && providerInstance instanceof java.security.Provider securityProvider) {
								java.security.Security.addProvider(securityProvider);
							}
						}
					}
					keyStore = Util.isEmpty(provider, true) ? KeyStore.getInstance(keyStoreType) : KeyStore.getInstance(keyStoreType, provider);
					file = new File(Ini.getAdempiereHome(), IDEMPIERE_KEYSTORE);
					if (file.exists()) {
						FileInputStream stream = new FileInputStream(file);
						keyStore.load(stream, password );
					} else {
						keyStore.load(null, password );
					}	
				} else {
					createLegacyKey();
				}
			} catch (Exception ex) {
				log.log(Level.SEVERE, "", ex);
				password = null;
				createLegacyKey();
			} finally {
				try {
					if (is != null)
						is.close();
				} catch (Exception e) {}
			}
		} else {
			createLegacyKey();
		}
	}

	/**
	 * Create key using legacy algorithm (DES)
	 */
	private void createLegacyKey() {
		m_key = new javax.crypto.spec.SecretKeySpec
				(new byte[] {100,25,28,-122,-26,94,-3,-26}, LEGACY_ALGORITHM);
	}
	
	@Override
	public synchronized SecretKey getKey(int AD_Client_ID) {
		if (password != null) {
			try {
				PasswordProtection protParam = new PasswordProtection(password);
				String alias = "ad_client_"+AD_Client_ID;
				SecretKeyEntry entry = (SecretKeyEntry) keyStore.getEntry(alias, protParam);
				if (entry == null) {
					KeyGenerator generator = KeyGenerator.getInstance(algorithm);
					SecretKey key = generator.generateKey();
					entry = new SecretKeyEntry((SecretKey) key);
					
					keyStore.setEntry(alias, entry, protParam);
					File file = new File(IDEMPIERE_KEYSTORE);
					FileOutputStream stream = null;
					try {
						stream = new FileOutputStream(file);
						keyStore.store(stream, password);
						stream.flush();
					} finally {
						if (stream != null) {
							try {
								stream.close();
							} catch (Exception e) {}
						}
					}
				}
				return entry.getSecretKey();
			} catch (Exception ex) {
				log.log(Level.SEVERE, "", ex);
			}
		}
		return m_key;
	}

	@Override
	public String getAlgorithm() {
		if (algorithm == null)
			return LEGACY_ALGORITHM;
		else
			return algorithm;
	}

}
