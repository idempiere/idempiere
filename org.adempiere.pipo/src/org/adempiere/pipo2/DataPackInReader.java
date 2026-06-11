package org.adempiere.pipo2;

import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;

import org.xml.sax.ContentHandler;
import org.xml.sax.helpers.AttributesImpl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLMapper;

/**
 * Reads a JSON or YAML 2Pack and replays synthetic SAX-style events into a
 * {@link ContentHandler}, reusing all existing import logic without modification.
 *
 * The expected document structure (produced by JsonPackSerializer / YamlPackSerializer):
 * <pre>
 * {
 *   "package": { "Name": "...", "UpdateDictionary": "false", "AD_Client_UU": "...", ... },
 *   "records": [
 *     {
 *       "_type": "AD_Table",
 *       "_subtype": "table",
 *       "TableName": "C_Order",
 *       "_children": [
 *         { "_type": "AD_Element", "_subtype": "table", "ColumnName": "DocumentNo", ... },
 *         { "_type": "AD_Column",  "_subtype": "table", ... }
 *       ]
 *     }
 *   ]
 * }
 * </pre>
 *
 * {@code _subtype} is replayed as the {@code type} SAX attribute so that
 * {@link OSGiHandlerRegistry} can route translation records to
 * {@code CommonTranslationHandler} exactly as the XML import does.
 * {@code _children} are fired recursively between the parent's
 * {@code startElement} / {@code endElement} calls, recreating the nesting
 * that import handlers rely on for parent-record context.
 *
 * Reference fields (SAX attributes on the element) are represented as objects
 * with a {@code _value} key; all other keys become element attributes passed to
 * the handler.
 */
public class DataPackInReader {

	private static final String KEY_TYPE     = "_type";
	private static final String KEY_SUBTYPE  = "_subtype";
	private static final String KEY_CHILDREN = "_children";
	private static final String KEY_VALUE    = "_value";

	private final ContentHandler handler;
	private final ObjectMapper   mapper;

	public DataPackInReader(ContentHandler handler, String format) {
		this.handler = handler;
		this.mapper  = "yaml".equalsIgnoreCase(format) ? new YAMLMapper() : new ObjectMapper();
	}

	public void read(InputStream input) throws Exception {
		JsonNode root = mapper.readTree(input);

		// Build and fire the root <idempiere> element.
		JsonNode pkgNode = root.path("package");
		AttributesImpl rootAtts = nodeToAtts(pkgNode);
		handler.startElement("", "", "idempiere", rootAtts);

		JsonNode records = root.path("records");
		if (records.isArray()) {
			for (JsonNode record : records) {
				fireRecord(record);
			}
		}

		handler.endElement("", "", "idempiere");
	}

	private void fireRecord(JsonNode record) throws Exception {
		String typeName = record.path(KEY_TYPE).asText("Unknown");

		// Restore the SAX type attribute so OSGiHandlerRegistry routes correctly
		// (e.g. type="translation" → CommonTranslationHandler).
		AttributesImpl recordAtts = new AttributesImpl();
		JsonNode subtypeNode = record.path(KEY_SUBTYPE);
		if (!subtypeNode.isMissingNode() && !subtypeNode.isNull()) {
			recordAtts.addAttribute("", "", "type", "CDATA", subtypeNode.asText(""));
		}

		handler.startElement("", "", typeName, recordAtts);

		AttributesImpl emptyAtts = new AttributesImpl();
		Iterator<Map.Entry<String, JsonNode>> fields = record.fields();
		while (fields.hasNext()) {
			Map.Entry<String, JsonNode> entry = fields.next();
			String fieldName = entry.getKey();
			if (KEY_TYPE.equals(fieldName) || KEY_SUBTYPE.equals(fieldName) || KEY_CHILDREN.equals(fieldName))
				continue;

			JsonNode fieldValue = entry.getValue();
			String   textValue;
			AttributesImpl fieldAtts;

			if (fieldValue.isObject()) {
				// Reference field: { "_value": "...", "reference": "uuid", ... }
				textValue  = fieldValue.path(KEY_VALUE).asText("");
				fieldAtts  = new AttributesImpl();
				Iterator<Map.Entry<String, JsonNode>> hints = fieldValue.fields();
				while (hints.hasNext()) {
					Map.Entry<String, JsonNode> hint = hints.next();
					if (!KEY_VALUE.equals(hint.getKey())) {
						fieldAtts.addAttribute("", "", hint.getKey(), "CDATA", hint.getValue().asText(""));
					}
				}
			} else {
				textValue = fieldValue.asText("");
				fieldAtts = emptyAtts;
			}

			handler.startElement("", "", fieldName, fieldAtts);
			char[] chars = textValue.toCharArray();
			handler.characters(chars, 0, chars.length);
			handler.endElement("", "", fieldName);
		}

		// Fire nested sub-records before closing the parent, recreating the XML nesting
		// that import handlers depend on for parent-record context (element.parent.recordId).
		JsonNode children = record.path(KEY_CHILDREN);
		if (children.isArray()) {
			for (JsonNode child : children) {
				fireRecord(child);
			}
		}

		handler.endElement("", "", typeName);
	}

	/** Convert a JSON object node's fields into SAX AttributesImpl. */
	private static AttributesImpl nodeToAtts(JsonNode node) {
		AttributesImpl atts = new AttributesImpl();
		if (node == null || node.isMissingNode())
			return atts;
		Iterator<Map.Entry<String, JsonNode>> fields = node.fields();
		while (fields.hasNext()) {
			Map.Entry<String, JsonNode> e = fields.next();
			atts.addAttribute("", "", e.getKey(), "CDATA", e.getValue().asText(""));
		}
		return atts;
	}
}
