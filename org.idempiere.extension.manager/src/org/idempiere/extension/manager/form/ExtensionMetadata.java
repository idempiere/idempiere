/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.idempiere.extension.manager.form;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.util.Objects;

public class ExtensionMetadata {
	private JsonObject json;
	private JsonArray versions;

	public ExtensionMetadata(JsonObject json) {
		this.json = Objects.requireNonNull(json, "json cannot be null");
		if (!this.json.has("id")) {
			throw new IllegalArgumentException("Extension id is mandatory");
		}
		if (json.has("versions")) {
			this.versions = json.getAsJsonArray("versions");
			json.remove("versions");
		} else {
			this.versions = new JsonArray();
		}
	}

	public JsonObject getJsonObject() {
		return json;
	}

	public String getId() {
		return json.get("id").getAsString();
	}

	public boolean hasName() {
		return json.has("name");
	}

	public String getName() {
		return hasName() ? json.get("name").getAsString() : null;
	}

	public boolean hasDescription() {
		return json.has("description");
	}

	public String getDescription() {
		return hasDescription() ? json.get("description").getAsString() : null;
	}

	public boolean hasVersion() {
		return json.has("version");
	}

	public String getVersion() {
		return hasVersion() ? json.get("version").getAsString() : null;
	}

	public boolean hasEntityType() {
		return json.has("entityType");
	}

	public String getEntityType() {
		return hasEntityType() ? json.get("entityType").getAsString() : null;
	}

	public boolean hasIDempiereVersion() {
		return json.has("idempiereVersion");
	}

	public String getIDempiereVersion() {
		return hasIDempiereVersion() ? json.get("idempiereVersion").getAsString() : null;
	}

	public boolean hasReleaseDate() {
		return json.has("releaseDate");
	}

	public String getReleaseDate() {
		return hasReleaseDate() ? json.get("releaseDate").getAsString() : null;
	}

	public boolean hasInfoUrl() {
		return json.has("infoUrl");
	}

	public String getInfoUrl() {
		return hasInfoUrl() ? json.get("infoUrl").getAsString() : null;
	}

	public boolean hasChangeLogUrl() {
		return json.has("changeLogUrl") && !json.get("changeLogUrl").isJsonNull();
	}

	public String getChangeLogUrl() {
		return hasChangeLogUrl() ? json.get("changeLogUrl").getAsString() : null;
	}

	public boolean hasCategories() {
		return json.has("categories") && json.get("categories").isJsonArray();
	}

	public JsonArray getCategories() {
		return hasCategories() ? json.getAsJsonArray("categories") : new JsonArray();
	}

	public boolean hasTags() {
		return json.has("tags") && json.get("tags").isJsonArray();
	}

	public JsonArray getTags() {
		return hasTags() ? json.getAsJsonArray("tags") : new JsonArray();
	}

	public boolean hasBundles() {
		return json.has("bundles") && json.get("bundles").isJsonArray();
	}

	public JsonArray getBundles() {
		return hasBundles() ? json.getAsJsonArray("bundles") : new JsonArray();
	}

	public boolean hasAssets() {
		return json.has("assets") && json.get("assets").isJsonArray();
	}

	public JsonArray getAssets() {
		return hasAssets() ? json.getAsJsonArray("assets") : new JsonArray();
	}
	
	public boolean hasDependencies() {
		return json.has("dependencies") && json.get("dependencies").isJsonArray();
	}

	public JsonArray getDependencies() {
		return hasDependencies() ? json.getAsJsonArray("dependencies") : new JsonArray();
	}

	public boolean hasDatabase() {
		return json.has("database") && json.get("database").isJsonArray();
	}

	public JsonArray getDatabase() {
		return hasDatabase() ? json.getAsJsonArray("database") : new JsonArray();
	}

	public JsonArray getVersions() {
		return versions != null ? versions : new JsonArray();
	}

	public boolean isFullMetadata() {
		return hasBundles();
	}

	public void setVersions(JsonArray versions) {
		this.versions = versions;
	}

	@Override
	public String toString() {
		return json.toString();
	}
}
