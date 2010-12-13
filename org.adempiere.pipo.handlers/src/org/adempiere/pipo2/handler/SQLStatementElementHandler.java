/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutItem;
import org.adempiere.pipo2.SQLElementParameters;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class SQLStatementElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element) throws SAXException {
		String elementValue = element.getElementValue();

		log.info(elementValue);
		String DBType = getStringValue(element, "DBType");
		String sql = getStringValue(element, "statement");
		if (sql.endsWith(";"))
			sql = sql.substring(0, sql.length() - 1);
		PreparedStatement pstmt = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			if(DBType.equals("ALL")) {
				int n = pstmt.executeUpdate();
				log.info("Executed SQL Statement: "+ getStringValue(element, "statement") + " ReturnValue="+n);
			}
			else if(DB.isOracle() == true && DBType.equals("Oracle")) {
				pstmt.executeUpdate();
				log.info("Executed SQL Statement for Oracle: "+ getStringValue(element, "statement"));
			}
			else if (   DB.isPostgreSQL()
					 && (   DBType.equals("Postgres")
						 || DBType.equals("PostgreSQL")  // backward compatibility with old packages developed by hand
						)
					 ) {
				// Avoid convert layer - command specific for postgresql
				//
				// pstmt = DB.prepareStatement(sql, null);
				// pstmt.executeUpdate();
				//
				Connection m_con = DB.getConnectionRW(true);
				try {
					Statement stmt = m_con.createStatement();
					int n = stmt.executeUpdate (sql);
					log.info("Executed SQL Statement for PostgreSQL: "+ getStringValue(element,"statement") + " ReturnValue="+n);
					// Postgres needs to commit DDL statements
					if (m_con != null && !m_con.getAutoCommit())
						m_con.commit();
					stmt.close();
				} finally {
					m_con.close();
				}
			}
		} catch (Exception e)	{
			log.log(Level.SEVERE,"SQLSatement", e);
		} finally {
			DB.close(pstmt);
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		String SQLStatement = Env.getContext(ctx, SQLElementParameters.SQL_STATEMENT);
		String DBType = Env.getContext(ctx, SQLElementParameters.DB_TYPE);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "custom");
		document.startElement("","","SQLStatement",atts);
		createSQLStatmentBinding(document, SQLStatement, DBType);
		document.endElement("","","SQLStatement");
	}

	private void createSQLStatmentBinding( TransformerHandler document, String sqlStatement, String DBType) throws SAXException
	{
		document.startElement("","","DBType", new AttributesImpl());
		char[] contents = DBType.toCharArray();
		document.characters(contents,0,contents.length);
		document.endElement("","","DBType");

		document.startElement("","","statement", new AttributesImpl());
		contents = sqlStatement.toCharArray();
		document.characters(contents,0,contents.length);
		document.endElement("","","statement");

	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int field) throws Exception
	{
		PackoutItem detail = packout.getCurrentPackoutItem();
		Env.setContext(packout.getCtx(), SQLElementParameters.SQL_STATEMENT, (String)detail.getProperty(SQLElementParameters.SQL_STATEMENT));
		Env.setContext(packout.getCtx(), SQLElementParameters.DB_TYPE, (String)detail.getProperty(SQLElementParameters.DB_TYPE));
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().remove(SQLElementParameters.SQL_STATEMENT);
		packout.getCtx().remove(SQLElementParameters.DB_TYPE);
	}
}
