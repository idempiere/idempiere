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
import java.util.logging.Logger;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import org.adempiere.base.IKeyStore;

/**
 * @author deepak
 * @author hengsin
 *
 */
public class DefaultKeyStore implements IKeyStore {
	
	private static final String LEGACY_ALGORITHM = "DES";

	private static final String IDEMPIERE_KEYSTORE_PROPERTIES = "idempiere-ks.properties";

	private static final String IDEMPIERE_KEYSTORE = "idempiere.ks";

	/**	Logger						*/
	private static Logger	log	= Logger.getLogger (DefaultKeyStore.class.getName());
	
	/** Adempiere Key				*/
	private SecretKey m_key = null;

	private KeyStore keyStore;

	private char[] password = null;

	private String algorithm;

	public DefaultKeyStore(){
		File file = new File(Ini.getAdempiereHome(), IDEMPIERE_KEYSTORE_PROPERTIES);
		if (file.exists()) {
			try{
				Properties p = new Properties();
				p.load(new FileInputStream(file));
				String s = p.getProperty("password");
				String a = p.getProperty("algorithm");
				if (!Util.isEmpty(s) && !Util.isEmpty(a)) {
					password = s.toCharArray();
					algorithm = a;
					keyStore = KeyStore.getInstance("JCEKS");
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
			}
		} else {
			createLegacyKey();
		}
	}

	private void createLegacyKey() {
		m_key = new javax.crypto.spec.SecretKeySpec
				(new byte[] {100,25,28,-122,-26,94,-3,-26}, LEGACY_ALGORITHM);
	}
	
	@Override
	public SecretKey getKey(int AD_Client_ID) {
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
