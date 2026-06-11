package org.adempiere.pipo2;

import java.io.OutputStream;
import java.util.ArrayDeque;
import java.util.Deque;

import org.xml.sax.Attributes;
import org.xml.sax.helpers.AttributesImpl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

/**
 * Base IPackSerializer for Jackson-based (JSON/YAML) 2Pack export.
 *
 * Output structure mirrors the XML nesting: sub-records (elements whose SAX
 * attributes carry a {@code type} attribute set by {@code addTypeName()}) are
 * stored in a {@code _children} array on the parent record rather than being
 * flattened into the top-level list.  This preserves parent-child context so
 * the import side can reconstruct the identical SAX event stream and reuse all
 * existing handler logic unchanged.
 *
 * <pre>
 * {
 *   "package": { "Name": "...", ... },
 *   "records": [
 *     {
 *       "_type": "AD_Table",
 *       "_subtype": "table",
 *       "TableName": "C_Order",
 *       "_children": [
 *         {
 *           "_type": "AD_Element",
 *           "_subtype": "table",
 *           "ColumnName": "DocumentNo",
 *           "_children": [
 *             { "_type": "AD_Element_Trl", "_subtype": "translation", "AD_Language": "es_CO", ... }
 *           ]
 *         },
 *         { "_type": "AD_Column", "_subtype": "table", ... }
 *       ]
 *     }
 *   ]
 * }
 * </pre>
 *
 * Reference fields (elements with SAX attributes) become objects with a
 * {@code _value} key plus the attributes as sibling keys.  Plain fields become
 * string values.
 */
abstract class JacksonPackSerializer implements IPackSerializer {

	private static final String KEY_TYPE     = "_type";
	private static final String KEY_SUBTYPE  = "_subtype";
	private static final String KEY_CHILDREN = "_children";
	private static final String KEY_VALUE    = "_value";

	private final OutputStream output;
	protected final ObjectMapper mapper;

	private ObjectNode rootNode;
	private ArrayNode  recordsNode;
	private ObjectNode currentRecord;

	/** Stack of parent records while a sub-record is being built. */
	private final Deque<ObjectNode> recordStack = new ArrayDeque<>();
	private final Deque<FieldCtx>   fieldStack  = new ArrayDeque<>();

	protected JacksonPackSerializer(OutputStream output, ObjectMapper mapper) {
		this.output = output;
		this.mapper = mapper.copy();
		this.mapper.enable(SerializationFeature.INDENT_OUTPUT);
	}

	@Override
	public void startElement(String qName, Attributes atts) throws Exception {
		if (rootNode == null) {
			// Root <idempiere> element — becomes the "package" header.
			rootNode = mapper.createObjectNode();
			ObjectNode header = mapper.createObjectNode();
			for (int i = 0; i < atts.getLength(); i++) {
				header.put(atts.getQName(i), atts.getValue(i));
			}
			rootNode.set("package", header);
			recordsNode = mapper.createArrayNode();
			return;
		}
		if (currentRecord == null) {
			// Top-level record element.
			currentRecord = newRecord(qName, atts);
			return;
		}
		if (fieldStack.isEmpty() && isSubRecord(atts)) {
			// Sub-record: push the parent and start a fresh record for this child.
			// When the child closes it will be appended to the parent's _children array.
			recordStack.push(currentRecord);
			currentRecord = newRecord(qName, atts);
			return;
		}
		// Field element inside the current record.
		fieldStack.push(new FieldCtx(atts));
	}

	@Override
	public void characters(String text) throws Exception {
		if (!fieldStack.isEmpty()) {
			fieldStack.peek().text.append(text != null ? text : "");
		}
	}

	@Override
	public void endElement(String qName) throws Exception {
		if (!fieldStack.isEmpty()) {
			FieldCtx field = fieldStack.pop();
			String value = field.text.toString();
			if (field.atts.getLength() == 0) {
				currentRecord.put(qName, value);
			} else {
				ObjectNode fieldNode = mapper.createObjectNode();
				fieldNode.put(KEY_VALUE, value);
				for (int i = 0; i < field.atts.getLength(); i++) {
					fieldNode.put(field.atts.getQName(i), field.atts.getValue(i));
				}
				currentRecord.set(qName, fieldNode);
			}
			return;
		}
		if (currentRecord != null) {
			if (!recordStack.isEmpty()) {
				// Sub-record close: attach to parent's _children array and restore parent.
				ObjectNode parent = recordStack.pop();
				ArrayNode children = (ArrayNode) parent.get(KEY_CHILDREN);
				if (children == null) {
					children = mapper.createArrayNode();
					parent.set(KEY_CHILDREN, children);
				}
				children.add(currentRecord);
				currentRecord = parent;
			} else {
				// Top-level record close.
				recordsNode.add(currentRecord);
				currentRecord = null;
			}
			return;
		}
		// Closing the root element — write the complete document.
		rootNode.set("records", recordsNode);
		mapper.writeValue(output, rootNode);
	}

	private ObjectNode newRecord(String qName, Attributes atts) {
		ObjectNode record = mapper.createObjectNode();
		record.put(KEY_TYPE, qName);
		String subtype = atts.getValue("type");
		if (subtype != null) {
			record.put(KEY_SUBTYPE, subtype);
		}
		return record;
	}

	private static boolean isSubRecord(Attributes atts) {
		return atts.getValue("type") != null;
	}

	private static final class FieldCtx {
		final AttributesImpl atts;
		final StringBuilder  text = new StringBuilder();

		FieldCtx(Attributes atts) {
			// Copy attributes so caller can reuse their AttributesImpl.
			this.atts = new AttributesImpl(atts);
		}
	}
}
