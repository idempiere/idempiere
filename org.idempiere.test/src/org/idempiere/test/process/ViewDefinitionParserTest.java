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
package org.idempiere.test.process;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.process.ViewDefinitionParser;
import org.compiere.process.ViewDefinitionParser.Component;
import org.compiere.process.ViewDefinitionParser.SelectItem;
import org.junit.jupiter.api.Test;

/**
 * Tests for {@link ViewDefinitionParser}, with view definitions as returned by PostgreSQL and by Oracle
 */
public class ViewDefinitionParserTest {

	@Test
	public void testPostgreSQLDefinition() {
		String sql = " SELECT bp.c_bpartner_id,\n"
				+ "    bp.name,\n"
				+ "    'C'::text AS bptype,\n"
				+ "    COALESCE(bp.value, 'a,b FROM x'::character varying) AS searchkey,\n"
				+ "    NULL::numeric AS amt,\n"
				+ "    bp.created::date AS datecreated,\n"
				+ "    (bp.so_creditlimit)::integer AS \"limit\"\n"
				+ "   FROM c_bpartner bp\n"
				+ "     JOIN ad_org o ON o.ad_org_id = bp.ad_org_id\n"
				+ "  WHERE bp.iscustomer = 'Y'::bpchar AND bp.name::text ~~ '%::%'::text\n"
				+ "  GROUP BY bp.c_bpartner_id\n"
				+ "UNION ALL\n"
				+ " SELECT v.c_bpartner_id,\n"
				+ "    v.name,\n"
				+ "    'V'::text AS bptype,\n"
				+ "    v.value AS searchkey,\n"
				+ "    v.so_creditused AS amt,\n"
				+ "    NULL::timestamp without time zone AS datecreated,\n"
				+ "    0 AS \"limit\"\n"
				+ "   FROM c_bpartner v\n"
				+ "  ORDER BY 1;";

		List<Component> components = ViewDefinitionParser.parse(sql);
		assertEquals(2, components.size(), "Number of components");

		Component first = components.get(0);
		assertFalse(first.isDistinct(), "First component is not distinct");
		assertFalse(first.isUnionAll(), "First component has no union");
		List<SelectItem> items = first.getItems();
		assertEquals(7, items.size(), "Number of columns");
		assertEquals("bp.c_bpartner_id", items.get(0).getExpression());
		assertNull(items.get(0).getAlias(), "Plain column has no alias");
		assertEquals("'C'::text", items.get(2).getExpression(), "Casts are kept by the parser");
		assertEquals("bptype", items.get(2).getAlias());
		assertEquals("COALESCE(bp.value, 'a,b FROM x'::character varying)", items.get(3).getExpression(), "Comma and FROM inside a literal are not separators");
		assertEquals("searchkey", items.get(3).getAlias());
		assertTrue(items.get(4).isNullLiteral(), "NULL with cast is a null literal");
		assertEquals("bp.created::date", items.get(5).getExpression(), "Cast of a column is kept");
		assertFalse(items.get(5).isNullLiteral());
		assertEquals("(bp.so_creditlimit)::integer", items.get(6).getExpression());
		assertEquals("\"limit\"", items.get(6).getAlias(), "Quoted alias is kept quoted");
		assertEquals("FROM c_bpartner bp\n     JOIN ad_org o ON o.ad_org_id = bp.ad_org_id", first.getFromClause());
		assertEquals("WHERE bp.iscustomer = 'Y'::bpchar AND bp.name::text ~~ '%::%'::text", first.getWhereClause());
		assertEquals("GROUP BY bp.c_bpartner_id", first.getOtherClause());

		Component second = components.get(1);
		assertTrue(second.isUnionAll(), "Second component is UNION ALL");
		assertEquals(7, second.getItems().size(), "Number of columns");
		assertTrue(second.getItems().get(5).isNullLiteral(), "NULL with a type name of several words is a null literal");
		assertEquals("0", second.getItems().get(6).getExpression());
		assertEquals("FROM c_bpartner v", second.getFromClause());
		assertNull(second.getWhereClause(), "Second component has no where clause");
		assertEquals("ORDER BY 1", second.getOtherClause());
	}

	@Test
	public void testOracleDefinition() {
		String sql = "SELECT bp.C_BPartner_ID, bp.Name BPName, 'C' BPType, -- customer, FROM here is a comment\n"
				+ " CASE WHEN bp.IsVendor='Y' THEN 1 ELSE 0 END VendorFlag, COUNT(*) cnt,\n"
				+ " EXTRACT(YEAR FROM bp.Created) AS Yr,\n"
				+ " (SELECT MAX(o.Name) FROM AD_Org o WHERE o.AD_Org_ID=bp.AD_Org_ID) OrgName,\n"
				+ " bp.Value || '-' || bp.Name, CAST(NULL AS VARCHAR2(10)) Note, /* WHERE , */ SYSDATE Today,\n"
				+ " CASE WHEN bp.IsActive='Y' THEN 1 END\n"
				+ "FROM C_BPartner bp\n"
				+ "WHERE bp.IsActive='Y' AND bp.Name NOT IN ('GROUP BY', 'UNION')\n"
				+ "GROUP BY bp.C_BPartner_ID, bp.Name\n"
				+ "HAVING COUNT(*) > 0";

		List<Component> components = ViewDefinitionParser.parse(sql);
		assertEquals(1, components.size(), "Number of components");
		Component component = components.get(0);
		List<SelectItem> items = component.getItems();
		assertEquals(11, items.size(), "Number of columns");
		assertEquals("bp.C_BPartner_ID", items.get(0).getExpression());
		assertNull(items.get(0).getAlias());
		assertEquals("bp.Name", items.get(1).getExpression());
		assertEquals("BPName", items.get(1).getAlias(), "Alias without AS");
		assertEquals("'C'", items.get(2).getExpression());
		assertEquals("BPType", items.get(2).getAlias());
		assertEquals("CASE WHEN bp.IsVendor='Y' THEN 1 ELSE 0 END", items.get(3).getExpression());
		assertEquals("VendorFlag", items.get(3).getAlias());
		assertEquals("COUNT(*)", items.get(4).getExpression());
		assertEquals("cnt", items.get(4).getAlias());
		assertEquals("EXTRACT(YEAR FROM bp.Created)", items.get(5).getExpression(), "FROM inside a function is not the from clause");
		assertEquals("Yr", items.get(5).getAlias());
		assertEquals("(SELECT MAX(o.Name) FROM AD_Org o WHERE o.AD_Org_ID=bp.AD_Org_ID)", items.get(6).getExpression());
		assertEquals("OrgName", items.get(6).getAlias());
		assertEquals("bp.Value || '-' || bp.Name", items.get(7).getExpression());
		assertNull(items.get(7).getAlias(), "Last operand of an expression is not an alias");
		assertEquals("CAST(NULL AS VARCHAR2(10))", items.get(8).getExpression());
		assertTrue(items.get(8).isNullLiteral(), "CAST of NULL is a null literal");
		assertEquals("Note", items.get(8).getAlias());
		assertEquals("SYSDATE", items.get(9).getExpression());
		assertEquals("Today", items.get(9).getAlias());
		assertEquals("CASE WHEN bp.IsActive='Y' THEN 1 END", items.get(10).getExpression());
		assertNull(items.get(10).getAlias(), "END is not an alias");
		assertEquals("FROM C_BPartner bp", component.getFromClause());
		assertEquals("WHERE bp.IsActive='Y' AND bp.Name NOT IN ('GROUP BY', 'UNION')", component.getWhereClause());
		assertEquals("GROUP BY bp.C_BPartner_ID, bp.Name\nHAVING COUNT(*) > 0", component.getOtherClause());
	}

	@Test
	public void testUnionAndDistinct() {
		List<Component> components = ViewDefinitionParser.parse(
				"SELECT DISTINCT a FROM t UNION SELECT ALL a FROM u UNION ALL (SELECT a FROM v WHERE a > 0)");
		assertEquals(3, components.size(), "Number of components");
		assertTrue(components.get(0).isDistinct());
		assertFalse(components.get(0).isUnionAll());
		assertFalse(components.get(1).isDistinct());
		assertFalse(components.get(1).isUnionAll(), "UNION without ALL");
		assertEquals("a", components.get(1).getItems().get(0).getExpression());
		assertTrue(components.get(2).isUnionAll(), "UNION ALL");
		assertEquals("FROM v", components.get(2).getFromClause(), "Parenthesis around a select are removed");
		assertEquals("WHERE a > 0", components.get(2).getWhereClause());
	}

	@Test
	public void testCasts() {
		List<SelectItem> items = ViewDefinitionParser.parse(
				"SELECT 'Y'::bpchar AS a, NULL::character varying AS b, NULL AS c FROM t").get(0).getItems();
		assertEquals("'Y'::bpchar", items.get(0).getExpression(), "The parser keeps the casts");
		assertTrue(items.get(1).isNullLiteral(), "NULL with cast is a null literal");
		assertTrue(items.get(2).isNullLiteral(), "NULL without cast is a null literal");

		assertEquals("'it''s'", ViewDefinitionParser.removeCasts("'it''s'::text"), "Literal with escaped quote");
		assertEquals("'Y'", ViewDefinitionParser.removeCasts("'Y'::bpchar"));
		assertEquals("lpad(jahre.j, 2, '0')", ViewDefinitionParser.removeCasts("lpad(jahre.j::text, 2, '0')"));
		assertEquals("date_part('year', CURRENT_DATE) - 2000", ViewDefinitionParser.removeCasts("date_part('year'::text, CURRENT_DATE)::integer - 2000"));
		assertEquals("(('20' || x) || '-01-01')", ViewDefinitionParser.removeCasts("(('20'::text || x) || '-01-01'::text)::date"));
		assertEquals("x", ViewDefinitionParser.removeCasts("x::character varying(60)"));
		assertEquals("x + 1", ViewDefinitionParser.removeCasts("x::numeric(10,2) + 1"));
		assertEquals("x + 1", ViewDefinitionParser.removeCasts("x::numeric(10, 2) + 1"));
		assertEquals("ts", ViewDefinitionParser.removeCasts("ts::timestamp without time zone"));
		assertEquals("ts", ViewDefinitionParser.removeCasts("ts::timestamp(6) with time zone"));
		assertEquals("d * 2", ViewDefinitionParser.removeCasts("d::double precision * 2"));
		assertEquals("'{}'", ViewDefinitionParser.removeCasts("'{}'::text[]"));
		assertEquals("o.oid", ViewDefinitionParser.removeCasts("o.oid::pg_catalog.regclass"));
		assertEquals("t.\"a::b\"", ViewDefinitionParser.removeCasts("t.\"a::b\"::integer"), "Text inside a quoted identifier is not a cast");
		assertEquals("'a::text'", ViewDefinitionParser.removeCasts("'a::text'"), "Text inside a literal is not a cast");
		assertEquals("WHERE sp.statistiktyp = 'MD' AND sp.startdate >= '2009-01-01'",
				ViewDefinitionParser.removeCasts("WHERE sp.statistiktyp::text = 'MD'::text AND sp.startdate >= '2009-01-01'::date"));
		assertEquals("a AND b", ViewDefinitionParser.removeCasts("a AND b"), "Text without cast is not changed");
	}

	@Test
	public void testIsDistinctFrom() {
		List<Component> components = ViewDefinitionParser.parse(
				"SELECT t.a IS DISTINCT FROM t.b AS flag, t.c IS NOT DISTINCT FROM 1 AS same, t.d FROM t WHERE t.a IS DISTINCT FROM t.c");
		assertEquals(1, components.size(), "Number of components");
		Component component = components.get(0);
		List<SelectItem> items = component.getItems();
		assertEquals(3, items.size(), "FROM of IS DISTINCT FROM is not the from clause");
		assertEquals("t.a IS DISTINCT FROM t.b", items.get(0).getExpression());
		assertEquals("flag", items.get(0).getAlias());
		assertEquals("t.c IS NOT DISTINCT FROM 1", items.get(1).getExpression());
		assertEquals("same", items.get(1).getAlias());
		assertEquals("t.d", items.get(2).getExpression());
		assertEquals("FROM t", component.getFromClause());
		assertEquals("WHERE t.a IS DISTINCT FROM t.c", component.getWhereClause());

		assertTrue(ViewDefinitionParser.parse("SELECT DISTINCT a FROM t").get(0).isDistinct(), "SELECT DISTINCT is not affected");
		assertEquals("FROM t", ViewDefinitionParser.parse("SELECT DISTINCT a FROM t").get(0).getFromClause());
	}

	@Test
	public void testUnsupportedDefinitions() {
		assertUnsupported("WITH x AS (SELECT a FROM t) SELECT a FROM x");
		assertUnsupported("SELECT a FROM t INTERSECT SELECT a FROM u");
		assertUnsupported("SELECT a FROM t MINUS SELECT a FROM u");
		assertUnsupported("SELECT a FROM t EXCEPT SELECT a FROM u");
		assertUnsupported("SELECT DISTINCT ON (a) a, b FROM t");
		assertUnsupported("SELECT 1 AS a");
		assertUnsupported("SELECT t.* FROM t");
		assertUnsupported("SELECT * FROM t");
		assertUnsupported("(SELECT a FROM t UNION SELECT a FROM u) UNION ALL SELECT a FROM v");
		assertUnsupported("");
		assertUnsupported(null);
	}

	private void assertUnsupported(String sql) {
		assertThrows(AdempiereException.class, () -> ViewDefinitionParser.parse(sql), "Should not be supported: " + sql);
	}
}
