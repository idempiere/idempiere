/**
 * 
 */
package org.idempiere.fa.exceptions;


/**
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 *
 */
public class AssetCheckDocumentException extends AssetException
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8096988198983528889L;

	public AssetCheckDocumentException(String additionalMessage)
	{
		super ("@CheckDocument@ - "+additionalMessage); // TODO: AD_Message
	}
}
