package org.adempiere.pipo2;

import java.io.OutputStream;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * IPackSerializer that writes a 2Pack as JSON.
 * @see JacksonPackSerializer
 */
public class JsonPackSerializer extends JacksonPackSerializer {

	public JsonPackSerializer(OutputStream output) {
		super(output, new ObjectMapper());
	}
}
