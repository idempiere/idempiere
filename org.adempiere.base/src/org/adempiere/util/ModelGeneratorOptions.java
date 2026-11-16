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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.function.Predicate;

import org.compiere.model.PO;

/**
 * Command line options of the model generator ({@code ModelGeneratorApplication}).
 * <p>
 * Two forms are accepted:
 * <ul>
 * <li>positional, unchanged: {@code folder packageName tableEntityType tableName [columnEntityType]}</li>
 * <li>named: {@code --folder= --package= --tables= --table-entity-type= --column-entity-type=
 * --output=interface,class,accessor --suffix= --columns= --template= --check};
 * {@code --help} prints the usage</li>
 * </ul>
 * The class has no database access, so it can be tested on its own; the caller supplies what needs the
 * dictionary (template values, system entity types).
 */
public class ModelGeneratorOptions {

	public static final String OUTPUT_INTERFACE = "interface";
	public static final String OUTPUT_CLASS = "class";
	public static final String OUTPUT_ACCESSOR = "accessor";

	private String folder;
	private String packageName;
	private String tableName;
	private String tableEntityType;
	private String columnEntityType;
	private boolean generateInterface = true;
	private boolean generateClass = true;
	private boolean generateAccessor = false;
	private String suffix;
	private String columns;
	private String template;
	private boolean check = false;
	private boolean named = false;

	private ModelGeneratorOptions() {
	}

	/**
	 * @param args command line arguments
	 * @return true when {@code --help} is one of them
	 */
	public static boolean isHelp(String[] args) {
		if (args != null)
			for (String arg : args)
				if ("--help".equals(arg))
					return true;
		return false;
	}

	/**
	 * Parse command line arguments.
	 * @param args arguments, positional or named (a first argument starting with {@code --} selects the named form)
	 * @return options
	 * @throws IllegalArgumentException for an unknown argument, a missing value, a wrong number of positional arguments
	 * or a named argument mixed into positional ones
	 */
	public static ModelGeneratorOptions parse(String[] args) {
		ModelGeneratorOptions o = new ModelGeneratorOptions();
		if (args == null || args.length == 0)
			throw new IllegalArgumentException("No arguments");
		if (!args[0].startsWith("--")) {
			// a named argument after a positional one would silently become a value, for example the column entity type
			for (String arg : args)
				if (arg.startsWith("--"))
					throw new IllegalArgumentException("Named and positional arguments cannot be mixed: " + arg
							+ ". Use the named form for every argument, for example " + namedEquivalent(args));
			if (args.length < 4 || args.length > 5)
				throw new IllegalArgumentException("Positional form needs 4 or 5 arguments, got " + args.length);
			o.folder = args[0];
			o.packageName = args[1];
			o.tableEntityType = args[2];
			o.tableName = args[3];
			o.columnEntityType = args.length == 5 ? args[4] : null;
			return o;
		}
		o.named = true;
		for (String arg : args) {
			if (!arg.startsWith("--"))
				throw new IllegalArgumentException("Unexpected argument: " + arg);
			int eq = arg.indexOf('=');
			String key = eq < 0 ? arg.substring(2) : arg.substring(2, eq);
			String value = eq < 0 ? null : arg.substring(eq + 1);
			switch (key) {
			case "folder": o.folder = required(key, value); break;
			case "package": o.packageName = required(key, value); break;
			case "tables": o.tableName = required(key, value); break;
			case "table-entity-type": o.tableEntityType = required(key, value); break;
			case "column-entity-type": o.columnEntityType = required(key, value); break;
			case "template": o.template = required(key, value); break;
			case "output": o.setOutput(required(key, value)); break;
			case "suffix": o.suffix = required(key, value); break;
			case "columns": o.columns = required(key, value); break;
			case "check": o.check = flag(key, value); break;
			default: throw new IllegalArgumentException("Unknown argument: --" + key);
			}
		}
		if (o.suffix != null && o.generateClass)
			throw new IllegalArgumentException("--suffix needs --output without class: the X_ class always implements the unsuffixed I_ interface");
		if (o.columns != null && o.generateClass)
			throw new IllegalArgumentException("--columns needs --output without class: the X_ class always has every column of the table");
		if (o.generateAccessor && o.suffix == null)
			throw new IllegalArgumentException("--output=accessor needs --suffix: the owner of the columns, as in C_Order_XYZ");
		if (o.suffix != null && !o.suffix.matches("[A-Za-z0-9_]+"))
			throw new IllegalArgumentException("--suffix may contain only letters, digits and _: " + o.suffix);
		return o;
	}

	/**
	 * @param args positional arguments, possibly with named ones mixed in
	 * @return the same call in the named form: folder, package, table entity type and table name first, then the named ones
	 */
	private static String namedEquivalent(String[] args) {
		String[] keys = {"folder", "package", "table-entity-type", "tables", "column-entity-type"};
		StringBuilder sb = new StringBuilder();
		int position = 0;
		for (String arg : args) {
			if (sb.length() > 0)
				sb.append(' ');
			if (arg.startsWith("--"))
				sb.append(arg);
			else if (position < keys.length)
				sb.append("--").append(keys[position++]).append('=').append(arg);
			else
				sb.append(arg);
		}
		return sb.toString();
	}

	private static String required(String key, String value) {
		if (value == null || value.trim().isEmpty())
			throw new IllegalArgumentException("--" + key + " needs a value");
		return value.trim();
	}

	private static boolean flag(String key, String value) {
		if (value != null)
			throw new IllegalArgumentException("--" + key + " takes no value");
		return true;
	}

	private void setOutput(String value) {
		generateInterface = false;
		generateClass = false;
		generateAccessor = false;
		for (String part : value.split(",")) {
			String p = part.trim().toLowerCase(Locale.ROOT);
			if (OUTPUT_INTERFACE.equals(p))
				generateInterface = true;
			else if (OUTPUT_CLASS.equals(p))
				generateClass = true;
			else if (OUTPUT_ACCESSOR.equals(p))
				generateAccessor = true;
			else
				throw new IllegalArgumentException("Unknown output: " + part + " (use interface, class, accessor or a comma separated list)");
		}
	}

	/**
	 * Fill the values not given on the command line from a Generate Model Template.
	 * Explicit arguments win over the template.
	 */
	public void applyTemplate(String tFolder, String tPackageName, String tTableName, String tTableEntityType, String tColumnEntityType) {
		if (isEmpty(folder)) folder = tFolder;
		if (isEmpty(packageName)) packageName = tPackageName;
		if (isEmpty(tableName)) tableName = tTableName;
		if (isEmpty(tableEntityType)) tableEntityType = tTableEntityType;
		if (isEmpty(columnEntityType)) columnEntityType = tColumnEntityType;
	}

	/**
	 * @return names of the required values that are still missing (after a template was applied)
	 */
	public List<String> missing() {
		List<String> list = new ArrayList<>();
		if (isEmpty(folder)) list.add("--folder");
		if (isEmpty(packageName)) list.add("--package");
		if (isEmpty(tableName)) list.add("--tables");
		return list;
	}

	/**
	 * Safety rules. Each problem is a combination that writes into another owner's classes.
	 * <ul>
	 * <li>S1: a system table entity type with no column entity type writes every column of the
	 * dictionary, custom ones included, into the generated classes of core tables</li>
	 * <li>S2: a column entity type filter together with class output writes an {@code X_} class that has
	 * only some columns of the table but is annotated for the whole table</li>
	 * <li>S4: a core package with a column entity type other than {@code D} writes plug-in columns into core files</li>
	 * <li>S7: accessor output for the columns of the dictionary entity type {@code D}, or with no column entity type and no
	 * {@code --columns} (every column); the accessor only gets and sets
	 * values and skips the logic of the model classes ({@code MOrder.setC_BPartner_ID} also sets the bill-to partner).
	 * Columns named with {@code --columns} are checked by the generator, which reads their entity types</li>
	 * </ul>
	 * @param isSystemEntityType tells whether an entity type is system maintained, for example {@code D}
	 * @return problems, empty when the call is safe
	 */
	public List<String> safetyProblems(Predicate<String> isSystemEntityType) {
		List<String> problems = new ArrayList<>();
		boolean systemTables = false;
		for (String et : entityTypes(tableEntityType))
			if (isSystemEntityType.test(et)) systemTables = true;
		if (systemTables && isEmpty(columnEntityType))
			problems.add("S1: table entity type " + tableEntityType + " is system maintained and no column entity type is set; "
					+ "every column of the dictionary, custom columns included, would be written. "
					+ "Set --column-entity-type, for example --column-entity-type=D to regenerate the core classes.");
		if (!isEmpty(columnEntityType) && generateClass) {
			List<String> tableTypes = isEmpty(tableEntityType) ? List.of("U", "A") : entityTypes(tableEntityType);
			List<String> columnTypes = entityTypes(columnEntityType);
			if (!columnTypes.containsAll(tableTypes))
				problems.add("S2: column entity type " + columnEntityType + " leaves out columns of the tables' own entity type "
						+ String.join(",", tableTypes) + " and class output is on; the X_ class would have only some columns "
						+ "but serve the whole table. Use --output=accessor (or interface) with --suffix.");
		}
		if (isCorePackage(packageName) && !isEmpty(columnEntityType)
				&& entityTypes(columnEntityType).stream().anyMatch(et -> !PO.ENTITYTYPE_Dictionary.equals(et)))
			problems.add("S4: package " + packageName + " is a core package but column entity type " + columnEntityType
					+ " is not D; plug-in columns would be written into core files.");
		if (generateAccessor && isEmpty(columnEntityType) && isEmpty(columns))
			problems.add("S7: no --column-entity-type and no --columns, so the accessor would cover every column of the table, core columns "
					+ "included; it only gets and sets values and skips the logic of the model classes. Set --column-entity-type to the "
					+ "entity type of the plug-in.");
		if (generateAccessor)
			if (entityTypes(columnEntityType).contains(PO.ENTITYTYPE_Dictionary))
				problems.add("S7: column entity type D is the core dictionary; the accessor only gets and sets values and skips "
						+ "the logic of the model classes (for example MOrder.setC_BPartner_ID). Use it for the columns of a plug-in, "
						+ "with the entity type of the plug-in in --column-entity-type.");
		return problems;
	}

	/**
	 * @param problem a problem returned by {@link #safetyProblems(Predicate)}
	 * @return true when the call must be refused: every problem in the named form, and S4 also in the positional form,
	 * because it writes plug-in columns into core sources; the other problems only warn in the positional form,
	 * so existing scripts keep working
	 */
	public boolean isRefused(String problem) {
		return named || problem.startsWith("S4");
	}

	/**
	 * Warnings that never refuse a call.
	 * <ul>
	 * <li>S6: an interface for a column subset of a table of another entity type, without a suffix, has the same
	 * simple name as the owner's interface ({@code I_C_Order}); code in the same package may bind to the wrong one</li>
	 * </ul>
	 * @return warnings, empty when there are none
	 */
	public List<String> warnings() {
		List<String> warnings = new ArrayList<>();
		if (generateInterface && suffix == null && !isEmpty(columnEntityType)) {
			List<String> tableTypes = isEmpty(tableEntityType) ? List.of("U", "A") : entityTypes(tableEntityType);
			if (!entityTypes(columnEntityType).containsAll(tableTypes))
				warnings.add("S6: the interface for columns " + columnEntityType + " of tables " + String.join(",", tableTypes)
						+ " has the owner's name I_<Table>; add --suffix to avoid a clash with the owner's interface.");
		}
		return warnings;
	}

	private static boolean isCorePackage(String pkg) {
		return pkg != null && (pkg.equals("org.compiere.model") || pkg.startsWith("org.adempiere.") || pkg.startsWith("org.compiere."));
	}

	/**
	 * @param list comma separated entity types, optionally quoted
	 * @return entity types without quotes and blanks
	 */
	public static List<String> entityTypes(String list) {
		if (isEmpty(list))
			return Collections.emptyList();
		List<String> out = new ArrayList<>();
		for (String part : list.split(",")) {
			String p = part.trim().replace("'", "");
			if (!p.isEmpty())
				out.add(p);
		}
		return out;
	}

	private static boolean isEmpty(String s) {
		return s == null || s.trim().isEmpty();
	}

	/**
	 * @return usage text for both forms
	 */
	public static String usage() {
		return "usage: ModelGenerator folder packageName tableEntityType tableName [columnEntityType]\n"
			+ "   or: ModelGenerator --folder=DIR --package=PKG --tables=NAMES [--table-entity-type=ET,..] [--column-entity-type=ET,..]\n"
			+ "         [--output=interface,class,accessor] [--suffix=XYZ] [--columns=A,B] [--template=NAME]\n"
			+ "         [--check]      (or --help)\n"
			+ "  Named options are --key=value; \"--key value\" is not supported. Files go to <folder>/<package with dots as folders>/.\n"
			+ "  --folder              source folder, must exist\n"
			+ "  --package             Java package of the generated files\n"
			+ "  --tables              one table-name pattern (LIKE, _ and % are wildcards, case-insensitive) or a comma separated list of exact names\n"
			+ "  --table-entity-type   entity types of the tables, comma separated; default U,A\n"
			+ "  --column-entity-type  only columns of these entity types, comma separated; default all columns\n"
			+ "  --output              interface (I_), class (X_), accessor (<Table>_<suffix>.of(po): typed get/set over any PO of the table,\n"
			+ "                        needs --suffix); comma separated list, default interface,class\n"
			+ "  --columns             only these columns (comma separated), on top of --column-entity-type; not with class\n"
			+ "  --suffix              owner of the columns: interface I_C_Order_XYZ, accessor C_Order_XYZ; not with class\n"
			+ "  --template            read the values not given from the Generate Model Template with this name\n"
			+ "  --check               generate into a temporary folder and compare with --folder; writes nothing, fails when no table matches, needs the same\n"
			+ "                        arguments as the generate call, ignores files that exist only in --folder\n"
			+ "  Named and positional arguments cannot be mixed.\n"
			+ "  A table in a comma separated --tables list, or a --columns name, that matches nothing is refused (both forms).\n"
			+ "  Safety rules S1, S2, S4, S7 REFUSE a named call; the positional form only warns, except S4 which refuses in both forms.\n"
			+ "  Exit code 0 = ok, 1 = refused, error or --check difference; the last output line is result: ok|refused|error|differs";
	}

	public String getFolder() { return folder; }
	public String getPackageName() { return packageName; }
	public String getTableName() { return tableName; }
	public String getTableEntityType() { return tableEntityType; }
	public String getColumnEntityType() { return columnEntityType; }
	public boolean isGenerateInterface() { return generateInterface; }
	public boolean isGenerateClass() { return generateClass; }
	public boolean isGenerateAccessor() { return generateAccessor; }
	public String getSuffix() { return suffix; }
	/** @return comma separated column names, or null for all columns of the column entity types */
	public String getColumns() { return columns; }
	public String getTemplate() { return template; }
	public boolean isCheck() { return check; }

	/**
	 * A check that generated no file has not checked anything, so it must not pass.
	 * @param generated number of files the call generated
	 * @param outOfDate number of generated files that are missing or differ in the target folder
	 * @return true when files were generated and all of them are up to date
	 */
	public static boolean isCheckPassed(int generated, int outOfDate) {
		return generated > 0 && outOfDate == 0;
	}
	/** @return true for the named form; safety problems are then refused, in the positional form only reported */
	public boolean isNamed() { return named; }
}
