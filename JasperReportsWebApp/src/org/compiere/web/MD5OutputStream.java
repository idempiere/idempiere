/**
 *
 */
package org.compiere.web;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;

import javax.servlet.ServletOutputStream;

import org.apache.commons.codec.binary.Base64;

/**
 * @author hengsin
 *
 */
public class MD5OutputStream extends ServletOutputStream {

	private MessageDigest digestAgent;

	/**
	 *
	 */
	public MD5OutputStream() {
		try {
			digestAgent = MessageDigest.getInstance("MD5", "SUN");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see java.io.OutputStream#write(int)
	 */
	@Override
	public void write(int b) throws IOException {
		digestAgent.update((byte) b);
	}

	/**
	 * @return md5 hash
	 */
	public String getMD5Hash() {
		byte[] digest = digestAgent.digest();
		Base64 base64 = new Base64();
		String digestAsBase64 = new String(base64.encode(digest));
		return digestAsBase64;
	}
}
