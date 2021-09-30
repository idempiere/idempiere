/**********************************************************************
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
* - Trek Global                                                       *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/

package org.adempiere.pipo2.handler;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
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
import org.compiere.util.Util;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class SQLMandatoryElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String elementValue = element.getElementValue();

		log.info(elementValue);
		String DBType = getStringValue(element, "DBType");
		String sql = getStringValue(element, "statement");
		if (sql.endsWith(";") && !(sql.toLowerCase().endsWith("end;")))
			sql = sql.substring(0, sql.length() - 1);
		sql = Env.parseContext(Env.getCtx(), 0, sql, false);
		int count = 0;
		PreparedStatement pstmt = null;
		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, "", 0);
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			if (DBType.equals("ALL")) {
				count = pstmt.executeUpdate();
				if (log.isLoggable(Level.INFO)) log.info("Executed SQL Mandatory: "+ getStringValue(element, "statement") + " ReturnValue="+count);
			} else if (DB.isOracle() && DBType.equals("Oracle")) {
				count = pstmt.executeUpdate();
				if (log.isLoggable(Level.INFO)) log.info("Executed SQL Mandatory for Oracle: "+ getStringValue(element, "statement") + " ReturnValue="+count);
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
					if (log.isLoggable(Level.INFO)) log.info("Executed SQL Mandatory for PostgreSQL: "+ getStringValue(element,"statement") + " ReturnValue="+count);
				} finally {
					DB.close(stmt);
					stmt = null;
				}
			}
			logImportDetail (ctx, impDetail, 1, "SQLMandatory",count,"Execute", sql, String.valueOf(count));
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
			ctx.packIn.getNotifier().addFailureLine("SQL Mandatory failed, error (" + e.getLocalizedMessage() + "):");
			logImportDetail (ctx, impDetail, 0, "SQLMandatory",-1,"Execute", sql, e.getLocalizedMessage());
			ctx.packIn.getNotifier().addFailureLine("-> " + sql);
			log.log(Level.SEVERE,"SQLMandatory", e);
			throw new AdempiereException(e);
		} finally {
			DB.close(pstmt);
			pstmt = null;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		String SQLMandatory = Env.getContext(ctx.ctx, SQLElementParameters.SQL_STATEMENT);
		String DBType = Env.getContext(ctx.ctx, SQLElementParameters.DB_TYPE);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "custom");
		document.startElement("","","SQLMandatory",atts);
		createSQLStatmentBinding(document, SQLMandatory, DBType);
		document.endElement("","","SQLMandatory");
	}

	private void createSQLStatmentBinding( TransformerHandler document, String sqlMandatory, String DBType) throws SAXException
	{
		document.startElement("","","DBType", new AttributesImpl());
		char[] contents = DBType.toCharArray();
		document.characters(contents,0,contents.length);
		document.endElement("","","DBType");

		document.startElement("","","statement", new AttributesImpl());
		contents = sqlMandatory.toCharArray();
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
