package org.adempiere.pipo2;

import javax.xml.transform.sax.TransformerHandler;

import org.xml.sax.Attributes;

/**
 * IPackSerializer adapter over an existing SAX TransformerHandler.
 * Used for XML 2Pack export — zero behavior change from the original code path.
 */
public class SAXPackSerializer implements IPackSerializer {

	private final TransformerHandler handler;

	public SAXPackSerializer(TransformerHandler handler) {
		this.handler = handler;
	}

	/** Expose the wrapped handler for callers that still need it (e.g. PackOut docHandler). */
	public TransformerHandler getHandler() {
		return handler;
	}

	@Override
	public void startElement(String qName, Attributes atts) throws Exception {
		handler.startElement("", "", qName, atts);
	}

	@Override
	public void endElement(String qName) throws Exception {
		handler.endElement("", "", qName);
	}

	@Override
	public void characters(String text) throws Exception {
		char[] contents = text != null ? text.toCharArray() : new char[0];
		handler.characters(contents, 0, contents.length);
	}

	@Override
	public void endDocument() throws Exception {
		handler.endDocument();
	}
}
