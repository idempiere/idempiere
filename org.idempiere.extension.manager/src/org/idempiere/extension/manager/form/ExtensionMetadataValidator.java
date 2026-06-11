package org.idempiere.extension.manager.form;

import java.net.URI;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;

/**
 * Validates the extension metadata JSON against the predefined schema structure.
 * Acts as a lightweight, generic-free JSON Schema validator for metadata-schema.json.
 */
public class ExtensionMetadataValidator {

	private static final String OSGI_VERSION_PATTERN = "^[0-9]+\\.[0-9]+\\.[0-9]+(\\.[a-zA-Z0-9_-]+)?$";
	private static final Pattern VERSION_PATTERN = Pattern.compile(OSGI_VERSION_PATTERN);

	/**
	 * Validates the metadata JSON string.
	 * 
	 * @param jsonString the JSON string to validate
	 * @return a list of validation errors, empty if the JSON is valid
	 */
	public static List<String> validate(String jsonString) {
		List<String> errors = new ArrayList<>();
		if (jsonString == null || jsonString.trim().isEmpty()) {
			errors.add("Metadata JSON cannot be empty.");
			return errors;
		}

		JsonElement rootElement;
		try {
			rootElement = JsonParser.parseString(jsonString);
		} catch (JsonSyntaxException e) {
			errors.add("Invalid JSON syntax: " + e.getMessage());
			return errors;
		}

		if (!rootElement.isJsonObject()) {
			errors.add("Root element must be a JSON object.");
			return errors;
		}

		JsonObject root = rootElement.getAsJsonObject();

		// Required properties
		String[] requiredFields = { "id", "name", "version", "idempiereVersion", "bundles" };
		for (String field : requiredFields) {
			if (!root.has(field)) {
				errors.add("Missing required property: '" + field + "'.");
			}
		}

		// Validate properties
		if (root.has("id")) validateString(root.get("id"), "id", errors);
		
		if (root.has("version")) {
			if (validateString(root.get("version"), "version", errors)) {
				String version = root.get("version").getAsString();
				if (!VERSION_PATTERN.matcher(version).matches()) {
					errors.add("Property 'version' must match OSGi version pattern " + OSGI_VERSION_PATTERN);
				}
			}
		}
		
		if (root.has("idempiereVersion")) validateString(root.get("idempiereVersion"), "idempiereVersion", errors);
		
		if (root.has("releaseDate")) {
			if (validateString(root.get("releaseDate"), "releaseDate", errors)) {
				String releaseDate = root.get("releaseDate").getAsString();
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					sdf.setLenient(false);
					sdf.parse(releaseDate);
				} catch (ParseException e) {
					errors.add("Property 'releaseDate' must be a valid date in YYYY-MM-DD format.");
				}
			}
		}
		
		if (root.has("name")) validateString(root.get("name"), "name", errors);
		if (root.has("description")) validateString(root.get("description"), "description", errors);
		if (root.has("entityType")) validateString(root.get("entityType"), "entityType", errors);

		if (root.has("categories")) validateStringArray(root.get("categories"), "categories", true, errors);
		if (root.has("tags")) validateStringArray(root.get("tags"), "tags", true, errors);

		// bundles
		if (root.has("bundles")) {
			if (root.get("bundles").isJsonArray()) {
				JsonArray bundles = root.getAsJsonArray("bundles");
				if (bundles.size() == 0) {
					errors.add("Property 'bundles' must have at least 1 item.");
				}
				for (int i = 0; i < bundles.size(); i++) {
					JsonElement el = bundles.get(i);
					if (el.isJsonObject()) {
						JsonObject bundle = el.getAsJsonObject();
						if (!bundle.has("symbolicName")) errors.add("bundles[" + i + "] is missing required property 'symbolicName'.");
						
						if (bundle.has("symbolicName")) validateString(bundle.get("symbolicName"), "bundles[" + i + "].symbolicName", errors);
						if (bundle.has("sha256")) validateString(bundle.get("sha256"), "bundles[" + i + "].sha256", errors);
						if (bundle.has("downloadUrl")) {
							if (validateString(bundle.get("downloadUrl"), "bundles[" + i + "].downloadUrl", errors)) {
								String downloadUrl = bundle.get("downloadUrl").getAsString();
								try {
									new URI(downloadUrl);
								} catch (URISyntaxException e) {
									errors.add("bundles[" + i + "].downloadUrl must be a valid URI format.");
								}
							}
						}
					} else {
						errors.add("bundles[" + i + "] must be an object.");
					}
				}
			} else {
				errors.add("Property 'bundles' must be an array.");
			}
		}

		// dependencies
		if (root.has("dependencies")) {
			if (root.get("dependencies").isJsonArray()) {
				JsonArray dependencies = root.getAsJsonArray("dependencies");
				for (int i = 0; i < dependencies.size(); i++) {
					JsonElement el = dependencies.get(i);
					if (el.isJsonObject()) {
						JsonObject dep = el.getAsJsonObject();
						if (!dep.has("id")) errors.add("dependencies[" + i + "] is missing required property 'id'.");
						if (!dep.has("version")) errors.add("dependencies[" + i + "] is missing required property 'version'.");
						
						if (dep.has("id")) validateString(dep.get("id"), "dependencies[" + i + "].id", errors);
						if (dep.has("version")) validateString(dep.get("version"), "dependencies[" + i + "].version", errors);
					} else {
						errors.add("dependencies[" + i + "] must be an object.");
					}
				}
			} else {
				errors.add("Property 'dependencies' must be an array.");
			}
		}

		// database
		if (root.has("database")) {
			if (root.get("database").isJsonArray()) {
				JsonArray dbArray = root.getAsJsonArray("database");
				for (int i = 0; i < dbArray.size(); i++) {
					JsonElement el = dbArray.get(i);
					if (el.isJsonObject()) {
						JsonObject db = el.getAsJsonObject();
						if (!db.has("id")) errors.add("database[" + i + "] is missing required property 'id'.");
						
						if (db.has("id")) validateString(db.get("id"), "database[" + i + "].id", errors);
						if (db.has("version")) validateString(db.get("version"), "database[" + i + "].version", errors);
						if (db.has("extensions")) validateStringArray(db.get("extensions"), "database[" + i + "].extensions", false, errors);

						if (db.has("id")) {
							String id = db.get("id").getAsString();
							if (!"postgresql".equalsIgnoreCase(id) && !"oracle".equalsIgnoreCase(id)) {
								errors.add("database[" + i + "].id must be either 'postgresql' or 'oracle'.");
							}
						}
					} else {
						errors.add("database[" + i + "] must be an object.");
					}
				}
			} else {
				errors.add("Property 'database' must be an array.");
			}
		}

		return errors;
	}

	private static boolean validateString(JsonElement element, String path, List<String> errors) {
		if (!element.isJsonPrimitive() || !element.getAsJsonPrimitive().isString()) {
			errors.add("Property '" + path + "' must be a string.");
			return false;
		}
		return true;
	}

	private static boolean validateStringArray(JsonElement element, String path, boolean uniqueItems, List<String> errors) {
		if (!element.isJsonArray()) {
			errors.add("Property '" + path + "' must be an array.");
			return false;
		}
		
		JsonArray array = element.getAsJsonArray();
		Set<String> uniqueSet = new HashSet<>();
		boolean isValid = true;
		
		for (int i = 0; i < array.size(); i++) {
			JsonElement item = array.get(i);
			if (!item.isJsonPrimitive() || !item.getAsJsonPrimitive().isString()) {
				errors.add(path + "[" + i + "] must be a string.");
				isValid = false;
			} else if (uniqueItems) {
				String val = item.getAsString();
				if (!uniqueSet.add(val)) {
					errors.add(path + " elements must be unique. Duplicate found: " + val);
					isValid = false;
				}
			}
		}
		return isValid;
	}
}
