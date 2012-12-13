/**
 * 
 */
package org.idempiere.fa.exceptions;


/**
 * Asset is already depreciated and this is an issue for the action that invoked this exception
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 *
 */
public class AssetAlreadyDepreciatedException extends AssetException
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2531645693567226455L;

	public AssetAlreadyDepreciatedException()
	{
		super("@AssetAlreadyDepreciated@");
	}
}
