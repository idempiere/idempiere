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
 *                                                                     *
 * Contributors:                                                       *
 * - Diego Ruiz                                                        *
 **********************************************************************/
package org.compiere.process;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.adempiere.exceptions.AdempiereException;

/**
 * Split the SQL text of a database view (as returned by PostgreSQL pg_get_viewdef or
 * stored in Oracle ALL_VIEWS.TEXT) into the parts kept in AD_ViewComponent and AD_ViewColumn.<br/>
 * Only the constructs that the view component model can represent are accepted:
 * one or more SELECT statements combined with UNION / UNION ALL.
 */
public final class ViewDefinitionParser {

	/** Replacement for every character that is not at the top level (literal, quoted identifier content, parenthesis group) */
	private static final char MASKED = '\u0001';

	private static final String IDENTIFIER = "(\"[^\"]*\"|[A-Z_][A-Z0-9_$#]*)";

	private static final Pattern SET_OPERATOR = Pattern.compile("(?<![.\\w])(UNION|INTERSECT|EXCEPT|MINUS)(?![.\\w])");
	private static final Pattern ALL_OR_DISTINCT = Pattern.compile("\\s*(ALL|DISTINCT)(?!\\w)");
	private static final Pattern SELECT = Pattern.compile("\\s*SELECT(?!\\w)");
	private static final Pattern ON = Pattern.compile("\\s*ON(?!\\w)");
	private static final Pattern FROM = Pattern.compile("(?<![.\\w])FROM(?![.\\w])");
	/** DISTINCT right before a FROM, as in IS [NOT] DISTINCT FROM */
	private static final Pattern DISTINCT_BEFORE = Pattern.compile("(?<![.\\w])DISTINCT\\s+$");
	private static final Pattern WHERE = Pattern.compile("(?<![.\\w])WHERE(?![.\\w])");
	private static final Pattern OTHER = Pattern.compile(
			"(?<![.\\w])(GROUP\\s+BY|HAVING|ORDER\\s+BY|CONNECT\\s+BY|START\\s+WITH|WINDOW|LIMIT|OFFSET|FETCH|FOR\\s+UPDATE)(?![.\\w])");
	private static final Pattern EXPLICIT_ALIAS = Pattern.compile("^(.*\\S)\\s+AS\\s+" + IDENTIFIER + "\\s*$", Pattern.DOTALL);
	private static final Pattern IMPLICIT_ALIAS = Pattern.compile("^(.*\\S)\\s+" + IDENTIFIER + "\\s*$", Pattern.DOTALL);
	private static final Pattern LAST_WORD = Pattern.compile("(?<![\\w$#])([A-Z_][A-Z0-9_$#]*)$");
	/** PostgreSQL type cast, e.g. ::text, ::character varying(60), ::numeric(10,2), ::timestamp without time zone, ::text[] */
	private static final Pattern POSTGRESQL_CAST = Pattern.compile(
			"\\G::\\s*(\"[^\"]*\"|\\w+)(\\.(\"[^\"]*\"|\\w+))?(\\s+(varying|precision)(?!\\w))?"
			+ "(\\s*\\(\\s*\\d+(\\s*,\\s*\\d+)?\\s*\\))?(\\s+with(out)?\\s+time\\s+zone(?!\\w))?(\\s*\\[\\s*\\d*\\s*\\])*",
			Pattern.CASE_INSENSITIVE);
	private static final Pattern NULL_LITERAL = Pattern.compile(
			"^NULL(\\s*::\\s*[\\w \"]+(\\(\\s*\\d+(\\s*,\\s*\\d+)?\\s*\\))?)?$", Pattern.CASE_INSENSITIVE);
	private static final Pattern NULL_CAST = Pattern.compile(
			"^CAST\\s*\\(\\s*NULL\\s+AS\\s+[\\w ]+(\\(\\s*\\d+(\\s*,\\s*\\d+)?(\\s+\\w+)?\\s*\\))?\\s*\\)$", Pattern.CASE_INSENSITIVE);

	/** Words that end an expression and therefore are not a column alias */
	private static final Set<String> NOT_AN_ALIAS = Set.of("END", "NULL", "TRUE", "FALSE", "YEAR", "MONTH", "DAY", "HOUR", "MINUTE",
			"SECOND", "PRECISION", "VARYING", "ZONE");
	/** Words that need an operand after them, so the next word is not a column alias */
	private static final Set<String> NEEDS_OPERAND = Set.of("AND", "OR", "NOT", "IS", "LIKE", "IN", "BETWEEN", "THEN", "ELSE", "WHEN",
			"CASE", "PRIOR", "ALL", "DISTINCT", "UNIQUE", "ESCAPE", "DATE", "TIMESTAMP", "INTERVAL", "AT", "TIME");

	private ViewDefinitionParser() {
	}

	/**
	 * A column of the select list
	 */
	public static final class SelectItem {
		private final String expression;
		private final String alias;
		private final boolean nullLiteral;

		private SelectItem(String expression, String alias, boolean nullLiteral) {
			this.expression = expression;
			this.alias = alias;
			this.nullLiteral = nullLiteral;
		}

		/**
		 * @return SQL expression without the column alias
		 */
		public String getExpression() {
			return expression;
		}

		/**
		 * @return column alias as written in the SQL text, null if the column has no alias
		 */
		public String getAlias() {
			return alias;
		}

		/**
		 * @return true if the expression is NULL, with or without a type cast
		 */
		public boolean isNullLiteral() {
			return nullLiteral;
		}
	}

	/**
	 * One SELECT statement of the view
	 */
	public static final class Component {
		private boolean distinct;
		private boolean unionAll;
		private final List<SelectItem> items = new ArrayList<SelectItem>();
		private String fromClause;
		private String whereClause;
		private String otherClause;

		private Component() {
		}

		/**
		 * @return true for SELECT DISTINCT
		 */
		public boolean isDistinct() {
			return distinct;
		}

		/**
		 * @return true if this select is appended to the previous one with UNION ALL
		 */
		public boolean isUnionAll() {
			return unionAll;
		}

		/**
		 * @return columns of the select list
		 */
		public List<SelectItem> getItems() {
			return Collections.unmodifiableList(items);
		}

		/**
		 * @return from clause, including the FROM keyword
		 */
		public String getFromClause() {
			return fromClause;
		}

		/**
		 * @return where clause, including the WHERE keyword, null if there is none
		 */
		public String getWhereClause() {
			return whereClause;
		}

		/**
		 * @return everything after the where clause (GROUP BY, HAVING, ORDER BY ...), null if there is none
		 */
		public String getOtherClause() {
			return otherClause;
		}
	}

	/**
	 * Parse the SQL text of a view
	 * @param viewSQL select statement of the view, without the CREATE VIEW part
	 * @return components, in the order they appear in the view
	 * @throws AdempiereException with the unsupported construct as message, if the view can't be represented as view components
	 */
	public static List<Component> parse(String viewSQL) {
		if (viewSQL == null)
			throw new AdempiereException("empty view definition");
		String sql = stripComments(viewSQL).trim();
		while (sql.endsWith(";"))
			sql = sql.substring(0, sql.length() - 1).trim();
		sql = unwrap(sql);
		if (sql.isEmpty())
			throw new AdempiereException("empty view definition");

		List<Component> components = new ArrayList<Component>();
		String mask = mask(sql);
		Matcher m = SET_OPERATOR.matcher(mask);
		int start = 0;
		boolean unionAll = false;
		while (m.find()) {
			if (!"UNION".equals(m.group(1)))
				throw new AdempiereException(m.group(1));
			components.add(parseSelect(sql.substring(start, m.start()), unionAll));
			start = m.end();
			unionAll = false;
			Matcher q = ALL_OR_DISTINCT.matcher(mask);
			q.region(start, mask.length());
			if (q.lookingAt()) {
				unionAll = "ALL".equals(q.group(1));
				start = q.end();
			}
		}
		components.add(parseSelect(sql.substring(start), unionAll));
		return components;
	}

	/**
	 * Parse a single SELECT statement
	 * @param text
	 * @param unionAll
	 * @return component
	 */
	private static Component parseSelect(String text, boolean unionAll) {
		String sql = unwrap(text.trim());
		String mask = mask(sql);
		if (SET_OPERATOR.matcher(mask).find())
			throw new AdempiereException("nested UNION");

		Matcher m = SELECT.matcher(mask);
		if (!m.lookingAt()) {
			String firstWord = sql.split("\\s+", 2)[0];
			throw new AdempiereException(firstWord.length() > 20 ? firstWord.substring(0, 20) : firstWord);
		}
		Component component = new Component();
		component.unionAll = unionAll;
		int pos = m.end();
		Matcher q = ALL_OR_DISTINCT.matcher(mask);
		q.region(pos, mask.length());
		if (q.lookingAt()) {
			pos = q.end();
			if ("DISTINCT".equals(q.group(1))) {
				component.distinct = true;
				Matcher on = ON.matcher(mask);
				on.region(pos, mask.length());
				if (on.lookingAt())
					throw new AdempiereException("DISTINCT ON");
			}
		}

		// skip the FROM of IS [NOT] DISTINCT FROM in the select list
		Matcher from = FROM.matcher(mask);
		boolean found = from.find(pos);
		while (found && DISTINCT_BEFORE.matcher(mask.substring(pos, from.start())).find())
			found = from.find();
		if (!found)
			throw new AdempiereException("SELECT without FROM");
		int fromStart = from.start();
		parseSelectList(component, sql.substring(pos, fromStart), mask.substring(pos, fromStart));

		int whereStart = -1;
		int otherStart = -1;
		Matcher other = OTHER.matcher(mask);
		if (other.find(from.end()))
			otherStart = other.start();
		Matcher where = WHERE.matcher(mask);
		if (where.find(from.end()) && (otherStart < 0 || where.start() < otherStart))
			whereStart = where.start();

		int fromEnd = whereStart >= 0 ? whereStart : (otherStart >= 0 ? otherStart : sql.length());
		component.fromClause = sql.substring(fromStart, fromEnd).trim();
		if (whereStart >= 0)
			component.whereClause = sql.substring(whereStart, otherStart >= 0 ? otherStart : sql.length()).trim();
		if (otherStart >= 0)
			component.otherClause = sql.substring(otherStart).trim();
		return component;
	}

	/**
	 * Split the select list into its columns
	 * @param component
	 * @param sql select list
	 * @param mask mask of select list
	 */
	private static void parseSelectList(Component component, String sql, String mask) {
		int start = 0;
		for (int i = 0; i <= mask.length(); i++) {
			if (i == mask.length() || mask.charAt(i) == ',') {
				component.items.add(parseSelectItem(sql.substring(start, i), mask.substring(start, i)));
				start = i + 1;
			}
		}
	}

	/**
	 * Separate expression and alias of a column
	 * @param sql column text
	 * @param mask mask of column text
	 * @return select item
	 */
	private static SelectItem parseSelectItem(String sql, String mask) {
		String trimmedMask = mask.trim();
		if (trimmedMask.isEmpty())
			throw new AdempiereException("empty column in select list");
		if (trimmedMask.equals("*") || trimmedMask.endsWith(".*"))
			throw new AdempiereException("SELECT *");

		String expression = sql;
		String alias = null;
		Matcher m = EXPLICIT_ALIAS.matcher(mask);
		if (m.matches()) {
			expression = sql.substring(0, m.end(1));
			alias = sql.substring(m.start(2), m.end(2));
		} else if (!mask.contains("::")) {
			m = IMPLICIT_ALIAS.matcher(mask);
			if (m.matches() && !NOT_AN_ALIAS.contains(m.group(2)) && isCompleteExpression(m.group(1))) {
				expression = sql.substring(0, m.end(1));
				alias = sql.substring(m.start(2), m.end(2));
			}
		}

		expression = expression.trim();
		boolean nullLiteral = NULL_LITERAL.matcher(expression).matches() || NULL_CAST.matcher(expression).matches();
		return new SelectItem(expression, alias, nullLiteral);
	}

	/**
	 * @param mask mask of the text before a possible implicit alias
	 * @return true if the text can be a complete expression, i.e. it doesn't end with an operator or a keyword that needs an operand
	 */
	private static boolean isCompleteExpression(String mask) {
		char last = mask.charAt(mask.length() - 1);
		if ("+-*/|=<>,(.:%^&!~".indexOf(last) >= 0)
			return false;
		Matcher word = LAST_WORD.matcher(mask);
		return !(word.find() && NEEDS_OPERAND.contains(word.group(1)));
	}

	/**
	 * Remove all the PostgreSQL type casts (::type), outside string literals and quoted identifiers.<br/>
	 * Some casts are needed by PostgreSQL (e.g. lpad(integer::text, ...)) or define the data type of a column,
	 * so the result must be reviewed.
	 * @param sql
	 * @return sql without ::type casts
	 */
	public static String removeCasts(String sql) {
		if (sql == null || sql.indexOf("::") < 0)
			return sql;
		StringBuilder sb = new StringBuilder(sql.length());
		Matcher cast = POSTGRESQL_CAST.matcher(sql);
		int i = 0;
		while (i < sql.length()) {
			char c = sql.charAt(i);
			if (c == '\'' || c == '"') {
				int end = endOfQuoted(sql, i);
				sb.append(sql, i, end);
				i = end;
			} else if (c == ':' && sql.startsWith("::", i) && cast.find(i) && cast.start() == i) {
				i = cast.end();
			} else {
				sb.append(c);
				i++;
			}
		}
		return sb.toString();
	}

	/**
	 * Remove the parenthesis that enclose the whole text
	 * @param sql trimmed text
	 * @return text without enclosing parenthesis
	 */
	private static String unwrap(String sql) {
		while (sql.startsWith("(") && sql.endsWith(")")) {
			String mask = mask(sql);
			// the whole text is one parenthesis group when everything is masked
			boolean enclosed = true;
			for (int i = 0; i < mask.length(); i++) {
				if (mask.charAt(i) != MASKED) {
					enclosed = false;
					break;
				}
			}
			if (!enclosed)
				break;
			sql = sql.substring(1, sql.length() - 1).trim();
		}
		return sql;
	}

	/**
	 * Replace comments with a space, keeping literals and quoted identifiers untouched
	 * @param sql
	 * @return sql without comments
	 */
	private static String stripComments(String sql) {
		StringBuilder sb = new StringBuilder(sql.length());
		int length = sql.length();
		int i = 0;
		while (i < length) {
			char c = sql.charAt(i);
			if (c == '\'' || c == '"') {
				int end = endOfQuoted(sql, i);
				sb.append(sql, i, end);
				i = end;
			} else if (c == '-' && i + 1 < length && sql.charAt(i + 1) == '-') {
				int end = sql.indexOf('\n', i);
				i = end < 0 ? length : end;
				sb.append(' ');
			} else if (c == '/' && i + 1 < length && sql.charAt(i + 1) == '*') {
				int end = sql.indexOf("*/", i + 2);
				i = end < 0 ? length : end + 2;
				sb.append(' ');
			} else {
				sb.append(c);
				i++;
			}
		}
		return sb.toString();
	}

	/**
	 * @param sql
	 * @param start index of the opening quote (single or double)
	 * @return index after the closing quote, a doubled quote is part of the quoted text
	 */
	private static int endOfQuoted(String sql, int start) {
		char quote = sql.charAt(start);
		int i = start + 1;
		while (i < sql.length()) {
			if (sql.charAt(i) == quote) {
				if (i + 1 < sql.length() && sql.charAt(i + 1) == quote)
					i += 2;
				else
					return i + 1;
			} else {
				i++;
			}
		}
		return sql.length();
	}

	/**
	 * Build a copy of the text, with the same length, where only the top level is readable:
	 * upper case, with string literals, the content of quoted identifiers and parenthesis groups replaced by {@link #MASKED}.
	 * @param sql text without comments
	 * @return mask
	 */
	private static String mask(String sql) {
		char[] mask = new char[sql.length()];
		int depth = 0;
		int i = 0;
		while (i < sql.length()) {
			char c = sql.charAt(i);
			if (c == '\'' || c == '"') {
				int end = endOfQuoted(sql, i);
				boolean keepQuotes = c == '"' && depth == 0;
				for (int j = i; j < end; j++)
					mask[j] = MASKED;
				if (keepQuotes) {
					mask[i] = '"';
					if (end - 1 > i)
						mask[end - 1] = '"';
				}
				i = end;
				continue;
			}
			if (c == '(') {
				depth++;
				mask[i] = MASKED;
			} else if (c == ')') {
				mask[i] = MASKED;
				if (depth > 0)
					depth--;
			} else if (depth > 0) {
				mask[i] = MASKED;
			} else {
				mask[i] = Character.toUpperCase(c);
			}
			i++;
		}
		return new String(mask);
	}
}
