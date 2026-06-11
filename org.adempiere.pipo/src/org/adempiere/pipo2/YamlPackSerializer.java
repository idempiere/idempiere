package org.adempiere.pipo2;

import java.io.OutputStream;

import com.fasterxml.jackson.dataformat.yaml.YAMLMapper;

/**
 * IPackSerializer that writes a 2Pack as YAML.
 * @see JacksonPackSerializer
 */
public class YamlPackSerializer extends JacksonPackSerializer {

	public YamlPackSerializer(OutputStream output) {
		super(output, new YAMLMapper());
	}
}
