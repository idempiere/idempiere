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
package org.adempiere.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Eclipse launch configuration that repeats a model generator call ({@code --write-launch}).
 * <p>
 * The shipped {@code org.adempiere.base-feature/model.generator.launch} is the template: its bundle selection and VM
 * arguments are kept, only the program arguments change. Folders inside an Eclipse project are written as
 * {@code ${workspace_loc:<project>}/...}, so the file works in any workspace.
 */
public final class ModelGeneratorLaunch {

	/** template relative to the iDempiere root */
	public static final String TEMPLATE = "org.adempiere.base-feature/model.generator.launch";

	private static final Pattern PROGRAM_ARGUMENTS = Pattern.compile(
			"(<stringAttribute key=\"org\\.eclipse\\.jdt\\.launching\\.PROGRAM_ARGUMENTS\" value=\")([^\"]*)(\"/>)");
	/** Eclipse platform options that take no value */
	private static final Set<String> PLATFORM_FLAGS = Set.of("-consoleLog", "-noSplash", "-clean", "-console", "-debug",
			"-initialize", "-noExit");
	private static final Pattern PROJECT_NAME = Pattern.compile("<name>([^<]+)</name>");

	private ModelGeneratorLaunch() {
	}

	/**
	 * @param templateXml content of the template launch file
	 * @param generatorArgs named generator arguments, appended to the template's own program arguments
	 * @return launch file content
	 */
	public static String create(String templateXml, List<String> generatorArgs) {
		Matcher m = PROGRAM_ARGUMENTS.matcher(templateXml);
		if (!m.find())
			throw new IllegalArgumentException("template has no program arguments attribute");
		// keep the Eclipse platform arguments (-os ... -noSplash), drop generator arguments of an earlier call
		// (--x options and positional values)
		StringBuilder args = new StringBuilder();
		List<String> parts = split(unescape(m.group(2)));
		for (int i = 0; i < parts.size(); i++) {
			String part = parts.get(i);
			String plain = unquote(part);
			if (plain.startsWith("--") || !plain.startsWith("-"))
				continue;
			if (args.length() > 0)
				args.append(' ');
			args.append(part);
			// a single-dash option takes the next token as value, unless it is a known flag
			if (!PLATFORM_FLAGS.contains(plain) && i + 1 < parts.size() && !unquote(parts.get(i + 1)).startsWith("-")) {
				args.append(' ').append(parts.get(i + 1));
				i++;
			}
		}
		for (String a : generatorArgs)
			args.append(' ').append(quote(a));
		return templateXml.substring(0, m.start(2)) + escape(args.toString()) + templateXml.substring(m.end(2));
	}

	/**
	 * @param folder absolute folder
	 * @return {@code ${workspace_loc:<project>}/<rest>} when the folder is inside an Eclipse project, else the folder
	 */
	public static String workspacePath(String folder) {
		Path dir = Paths.get(folder).toAbsolutePath().normalize();
		for (Path p = dir; p != null; p = p.getParent()) {
			Path project = p.resolve(".project");
			if (Files.isRegularFile(project)) {
				try {
					Matcher m = PROJECT_NAME.matcher(Files.readString(project, StandardCharsets.UTF_8));
					if (m.find()) {
						String rest = p.relativize(dir).toString().replace('\\', '/');
						return "${workspace_loc:" + m.group(1).trim() + "}" + (rest.isEmpty() ? "" : "/" + rest);
					}
				} catch (IOException e) {
					return folder;
				}
			}
		}
		return folder;
	}

	/**
	 * @param folder a folder below the iDempiere root
	 * @return the template found in the folder or one of its parents, or null
	 */
	public static Path findTemplate(String folder) {
		for (Path p = Paths.get(folder).toAbsolutePath().normalize(); p != null; p = p.getParent()) {
			if (Files.isRegularFile(p.resolve(TEMPLATE)))
				return p.resolve(TEMPLATE);
		}
		return null;
	}

	/**
	 * @param arguments program arguments of a launch file
	 * @return the arguments separated by blanks; a value in double quotes stays one argument, quotes included
	 */
	private static List<String> split(String arguments) {
		List<String> parts = new ArrayList<>();
		StringBuilder current = new StringBuilder();
		boolean quoted = false;
		for (char c : arguments.toCharArray()) {
			if (c == '"')
				quoted = !quoted;
			if (Character.isWhitespace(c) && !quoted) {
				if (current.length() > 0)
					parts.add(current.toString());
				current.setLength(0);
			} else {
				current.append(c);
			}
		}
		if (current.length() > 0)
			parts.add(current.toString());
		return parts;
	}

	private static String unquote(String part) {
		return part.startsWith("\"") ? part.substring(1) : part;
	}

	private static String quote(String arg) {
		return arg.contains(" ") ? "\"" + arg + "\"" : arg;
	}

	private static String unescape(String s) {
		return s.replace("&#9;", " ").replace("&#10;", " ").replace("&quot;", "\"").replace("&lt;", "<").replace("&gt;", ">")
				.replace("&amp;", "&");
	}

	private static String escape(String s) {
		return s.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");
	}
}
