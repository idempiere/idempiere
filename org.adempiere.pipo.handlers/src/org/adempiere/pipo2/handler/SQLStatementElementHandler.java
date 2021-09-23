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

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Savepoint;
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
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.Util;
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
		sql=Env.parseContext(Env.getCtx(), 0, sql, false);  // tbayen IDEMPIERE-2140
		Savepoint savepoint = null;
		int count = 0;
		PreparedStatement pstmt = null;
		X_AD_Package_Imp_Detail impDetail = null;
		impDetail = createImportDetail(ctx, element.qName, "", 0);
		try {
			// NOTE Postgres needs to commit DDL statements
			// add a SQL command just with COMMIT if you want to simulate the Oracle behavior (commit on DDL)			
			// Use savepoint here so that SQL exception would not rollback the whole process
			Trx trx = Trx.get(getTrxName(ctx), true);
			savepoint = trx.setSavepoint(null);

			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			if (DBType.equals("ALL")) {
				count = pstmt.executeUpdate();
				if (log.isLoggable(Level.INFO)) log.info("Executed SQL Statement: "+ getStringValue(element, "statement") + " ReturnValue="+count);
			} else if (DB.isOracle() == true && DBType.equals("Oracle")) {
				count = pstmt.executeUpdate();
				if (log.isLoggable(Level.INFO)) log.info("Executed SQL Statement for Oracle: "+ getStringValue(element, "statement") + " ReturnValue="+count);
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
					count = stmt.executeUpdate (sql);
					if (log.isLoggable(Level.INFO)) log.info("Executed SQL Statement for PostgreSQL: "+ getStringValue(element,"statement") + " ReturnValue="+count);
				} finally {
					DB.close(stmt);
					stmt = null;
				}
			}						
			logImportDetail (ctx, impDetail, 1, "SQLStatement",count,"Execute", sql, String.valueOf(count));
			ctx.packIn.getNotifier().addSuccessLine("-> " + sql);
			// Cache Reset when deleting records via SQL
			if (sql.toLowerCase().startsWith("delete from ")) {
				String[] words = sql.split("[ \r\n]");
				String table = words[2];
				String tableName = DB.getSQLValueString(null, "SELECT TableName FROM AD_Table WHERE LOWER(TableName)=?", table.toLowerCase());
				if (! Util.isEmpty(tableName)) {
					CacheMgt.get().reset(tableName);
				}
			}
		} catch (Exception e)	{
			// rollback immediately on exception to avoid a wrong SQL stop the whole process
			if (savepoint != null) 
			{
				Trx trx = Trx.get(getTrxName(ctx), false);
				try {					
					if (trx.getConnection() != null)
						trx.getConnection().rollback(savepoint);					
				} catch (SQLException e1) {
					//a rollback or commit have happens making the savepoint becomes invalid.
					//rollback trx to continue
					trx.rollback();
				}
				savepoint = null;
			}
			ctx.packIn.getNotifier().addFailureLine("SQL statement failed but ignored, error (" + e.getLocalizedMessage() + "): ");
			logImportDetail (ctx, impDetail, 0, "SQLStatement",-1,"Execute", sql, e.getLocalizedMessage());
			ctx.packIn.getNotifier().addFailureLine("-> " + sql);
			log.log(Level.SEVERE,"SQLStatement", e);
		} finally {
			DB.close(pstmt);
			pstmt = null;
			if (savepoint != null) {
				Trx trx = Trx.get(getTrxName(ctx), false);
				try {
					trx.releaseSavepoint(savepoint);
				} catch (SQLException e) {
					if (DB.isPostgreSQL()) {
						//a commit or rollback have happens that make the savepoint invalid.
						//need to call rollback to continue
						trx.commit();						
					}
				}
			}
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
