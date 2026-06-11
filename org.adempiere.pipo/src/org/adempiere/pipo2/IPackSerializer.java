package org.adempiere.pipo2;

import org.xml.sax.Attributes;

/**
 * Format-agnostic serialization interface for 2Pack export.
 * Implementations write to XML (SAX), JSON, or YAML.
 * Each packOut operation uses one instance for its entire document lifecycle.
 */
public interface IPackSerializer {

	/**
	 * Open an element (record or field).
	 * @param qName element name
	 * @param atts element attributes (reference hints, type metadata)
	 */
	void startElement(String qName, Attributes atts) throws Exception;

	/**
	 * Close the most recently opened element.
	 * @param qName element name
	 */
	void endElement(String qName) throws Exception;

	/**
	 * Write text content for the current element.
	 * @param text content, may be null (treated as empty)
	 */
	void characters(String text) throws Exception;

	/**
	 * Finalize the document.  Called once after the root element is closed.
	 * The default no-op is sufficient for JSON/YAML serializers that flush on
	 * {@link #endElement}; XML implementations override to call
	 * {@code TransformerHandler.endDocument()}.
	 */
	default void endDocument() throws Exception {}
}
