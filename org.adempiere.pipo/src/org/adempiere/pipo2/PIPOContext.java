package org.adempiere.pipo2;

import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.compiere.util.Trx;

public class PIPOContext {
	public Properties ctx;
	public Trx trx;
	public PackIn packIn;
	public PackOut packOut;
	public TransformerHandler logDocument;
}
