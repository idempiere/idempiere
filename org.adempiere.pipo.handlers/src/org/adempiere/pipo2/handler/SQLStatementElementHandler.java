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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutItem;
import org.adempiere.pipo2.SQLElementParameters;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class SQLStatementElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String elementValue = element.getElementValue();

		log.info(elementValue);
		String DBType = getStringValue(element, "DBType");
		String sql = getStringValue(element, "statement");
		if (sql.endsWith(";") && !(sql.toLowerCase().endsWith("end;")))
			sql = sql.substring(0, sql.length() - 1);
		PreparedStatement pstmt = null;
		try {
			// NOTE Postgres needs to commit DDL statements
			// add a SQL command just with COMMIT if you want to simulate the Oracle behavior (commit on DDL)
			
			// It is also recommended on postgres to add a COMMIT before any SQL statement that can fail
			// for example a create index where is possible the index already exists

			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			if (DBType.equals("ALL")) {
				int n = pstmt.executeUpdate();
				log.info("Executed SQL Statement: "+ getStringValue(element, "statement") + " ReturnValue="+n);
			} else if (DB.isOracle() == true && DBType.equals("Oracle")) {
				int n = pstmt.executeUpdate();
				log.info("Executed SQL Statement for Oracle: "+ getStringValue(element, "statement") + " ReturnValue="+n);
			} else if (DB.isPostgreSQL()
					 && (   DBType.equals("Postgres")
						 || DBType.equals("PostgreSQL")  // backward compatibility with old packages developed by hand
						)
					 ) {
				// Avoid convert layer - command specific for postgresql
				//
				// pstmt = DB.prepareStatement(sql, getTrxName(ctx));
				// pstmt.executeUpdate();
				//
				
				Statement stmt = null;
				try {
					stmt = pstmt.getConnection().createStatement();
					int n = stmt.executeUpdate (sql);
					log.info("Executed SQL Statement for PostgreSQL: "+ getStringValue(element,"statement") + " ReturnValue="+n);
				} finally {
					if (stmt != null)
						stmt.close();
				}
			}
			
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, "",
					0);
			logImportDetail (ctx, impDetail, 1, "SQLStatement",1,"Execute");
		} catch (Exception e)	{
			if (DB.isPostgreSQL()) {
				// rollback immediately postgres on exception to avoid a wrong SQL stop the whole process
				if (pstmt != null) {
					Connection m_con = null;
					try {
						m_con = pstmt.getConnection();
						if (m_con != null && !m_con.getAutoCommit())
							m_con.rollback();
					} catch (SQLException ex) {
					}
				}
			}
			log.log(Level.SEVERE,"SQLSatement", e);
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, "",
					0);
			logImportDetail (ctx, impDetail, 0, "SQLStatement",1,"Execute");
		} finally {
			DB.close(pstmt);
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		String SQLStatement = Env.getContext(ctx.ctx, SQLElementParameters.SQL_STATEMENT);
		String DBType = Env.getContext(ctx.ctx, SQLElementParameters.DB_TYPE);
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
		document.startCDATA();
		document.characters(contents,0,contents.length);
		document.endCDATA();
		document.endElement("","","statement");

	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int field) throws Exception
	{
		PackoutItem detail = packout.getCurrentPackoutItem();
		Env.setContext(packout.getCtx().ctx, SQLElementParameters.SQL_STATEMENT, (String)detail.getProperty(SQLElementParameters.SQL_STATEMENT));
		Env.setContext(packout.getCtx().ctx, SQLElementParameters.DB_TYPE, (String)detail.getProperty(SQLElementParameters.DB_TYPE));
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(SQLElementParameters.SQL_STATEMENT);
		packout.getCtx().ctx.remove(SQLElementParameters.DB_TYPE);
	}
}
