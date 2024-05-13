package org.adempiere.pipo2.handler;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.DBException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.compiere.model.MColumn;
import org.compiere.model.MLanguage;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class CommonTranslationHandler extends AbstractElementHandler implements ElementHandler {

	public static final String CONTEXT_KEY_PARENT_TABLE = "currentParentTableForTranslation";
	public static final String CONTEXT_KEY_PARENT_RECORD_ID = "currentParentTableRecordID_ForTranslation";
	public static final String CONTEXT_KEY_PARENT_RECORD_UU = "currentParentTableRecordUU_ForTranslation";

	private HashMap<String, ArrayList<String>> cacheColumns = new HashMap<String, ArrayList<String>>();//Key: table name. Value: set of PIPO columns


	public void startElement(PIPOContext ctx, Element element) throws SAXException {

		if(! isHandleTranslations(ctx.ctx)){
			return;//translation import option is disabled
		}

		if(isParentSkip(element, null)){
			return;
		}

		if(isParentDefer(element, null)){
			element.defer = true;
			return;
		}

		String elementValue = element.getElementValue();
		Object parentID = element.parent.recordId;

		if((parentID instanceof Integer && (Integer)parentID == 0) || (parentID instanceof String && Util.isEmpty((String)parentID)))
			throw new SAXException();

		String language = getStringValue(element, "AD_Language");
		MLanguage lang = MLanguage.get(ctx.ctx, language);
		// skip if not system installed language
		if (lang == null || ! lang.isSystemLanguage())
			return;

		if (log.isLoggable(Level.INFO)) log.info(elementValue+" "+getStringValue(element, "Name"));

		if(isRecordExists(elementValue, parentID, language, ctx)){
			updateTranslation(elementValue, parentID, ctx, element);
		}else{
			insertTranslation(elementValue, parentID, ctx, element);
		}
	}


	private boolean isRecordExists(String tableName, Object parentID,
			String language, PIPOContext ctx) {

		String parentTableName = tableName.substring(0, tableName.length()-4);
		MTable parentTable = MTable.get(ctx.ctx, parentTableName);
		StringBuilder sql = new StringBuilder()
				.append("SELECT AD_Client_ID FROM ")
				.append(tableName)
				.append(" WHERE ")
				.append(parentTable.getKeyColumns()[0])
				.append(" = ? AND AD_Language = ?");

		if(DB.getSQLValue(getTrxName(ctx), sql.toString(), parentID, language) == -1){
			return false;
		}else{
			return true;
		}
	}


	private void insertTranslation(String tableName, Object parentID,
			PIPOContext ctx, Element element) throws SAXException{

		String parentTableName = tableName.substring(0, tableName.length()-4);
		MTable parentTable = MTable.get(ctx.ctx, parentTableName);
		ArrayList<String> columns = getTranslatedColumns(ctx, parentTableName);
		StringBuilder sql = new StringBuilder("INSERT INTO ")
			.append(tableName)
			.append(" (")
			.append(parentTable.getKeyColumns()[0])
			.append(", ")
			.append(" AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, ")
			.append(cast(columns))
			.append(") VALUES ( ?, ?, ?, ?, ? ");
		for (int i = 0; i<columns.size(); i++) {
			sql.append(",?");
		}

		sql.append(")");

		PreparedStatement pstm = null;
		try {
			pstm = DB.prepareStatement(sql.toString(), getTrxName(ctx));
			pstm.setObject(1, parentID);
			pstm.setInt(2, 0);
			pstm.setInt(3, 0);
			pstm.setInt(4, 0);
			pstm.setInt(5, 0);

			int i = 5;
			for (String columnName : columns) {
				i++;

				String value = getStringValue(element, columnName);

				if(columnName.equalsIgnoreCase("IsActive") ||
						columnName.equalsIgnoreCase("IsTranslated")){
					value = "true".equals(value) || "Y".equals(value) ? "Y" : "N";
				}
				pstm.setString(i, value);
			}

			if(pstm.executeUpdate()<0){
				throw new SAXException();
			}
		} catch (SQLException e) {
			throw new DBException(e);
		} finally {
			DB.close(pstm);
		}
	}


	private void updateTranslation(String tableName, Object parentID,
			PIPOContext ctx, Element element) throws SAXException{
		String parentTableName = tableName.substring(0, tableName.length()-4);
		MTable parentTable = MTable.get(ctx.ctx, parentTableName);

		ArrayList<String> columns = getTranslatedColumns(ctx, parentTableName);
		StringBuilder sql = new StringBuilder("UPDATE ")
				.append(tableName)
				.append(" SET ");
		for (String columnName : columns) {
			sql.append(columnName).append("=?,");
		}
		sql.deleteCharAt(sql.length() - 1); // remove last comma
		sql.append(" WHERE AD_Language=")
			.append(DB.TO_STRING(getStringValue(element, "AD_Language")))
			.append(" AND ")
			.append(parentTable.getKeyColumns()[0])
			.append("=");
		if (parentID instanceof Integer)
			sql.append((Integer)parentID);
		else
			sql.append(DB.TO_STRING(parentID.toString()));

		PreparedStatement pstm = null;
		try {
			pstm = DB.prepareStatement(sql.toString(), getTrxName(ctx));
			int i=0;
			for (String columnName : columns) {
				String value = getStringValue(element, columnName);
				i++;

				if(columnName.equalsIgnoreCase("IsActive") ||
						columnName.equalsIgnoreCase("IsTranslated")){

					value = "true".equals(value) || "Y".equals(value) ? "Y" : "N";
				}

				pstm.setString(i, value);
			}

			if(pstm.executeUpdate()<0){
				throw new SAXException();
			}
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			DB.close(pstm);
		}
	}


	public void endElement(PIPOContext ctx, Element element) throws SAXException {

	}


	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {

		String parenTableName = Env.getContext(ctx.ctx, CONTEXT_KEY_PARENT_TABLE);

		int parentRecordID = Env.getContextAsInt(ctx.ctx, CONTEXT_KEY_PARENT_RECORD_ID);
		String parentRecordUU = Env.getContext(ctx.ctx, CONTEXT_KEY_PARENT_RECORD_UU);

		createTranslationTags(ctx, parenTableName, parentRecordID, parentRecordUU, document);
	}


	private void createTranslationTags(PIPOContext ctx, String parentTableName,
			int parentRecordID, String parentRecordUU, TransformerHandler document) throws SAXException {

		ArrayList<String> translatedColumns = getTranslatedColumns(ctx, parentTableName);
		MTable parentTable = MTable.get(ctx.ctx, parentTableName);

		StringBuilder sql = new StringBuilder()
				.append("SELECT ")
				.append(cast(translatedColumns))
				.append(" FROM ")
				.append(parentTableName)
				.append("_Trl WHERE ")
				.append(parentTable.getKeyColumns()[0])
				.append("=?");

		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {

			pstm = DB.prepareStatement(sql.toString(), getTrxName(ctx));
			if (parentTable.isUUIDKeyTable())
				pstm.setString(1, parentRecordUU);
			else
				pstm.setInt(1, parentRecordID);
			rs = pstm.executeQuery();

			String elementName = parentTableName + "_Trl";
			while(rs.next()){
				AttributesImpl atts = new AttributesImpl();
				addTypeName(atts, "translation");
				document.startElement("", "", elementName, atts);
				exportRow(ctx, document, translatedColumns, rs);
				document.endElement("", "", elementName);
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new SAXException();
		} finally {
			DB.close(rs, pstm);
		}
	}

	private void exportRow(PIPOContext ctx, TransformerHandler document, ArrayList<String> columns,
			ResultSet rs) throws Exception {

		PoExporter af = new PoExporter(ctx, document, null);

		for (String columnName : columns) {
			if(columnName.equalsIgnoreCase("IsActive")||
					columnName.equalsIgnoreCase("IsTranslated")) {
				af.addBoolean(columnName, rs.getString(columnName).equalsIgnoreCase("Y"), new AttributesImpl());
			} else{
				af.addString(columnName, rs.getString(columnName), new AttributesImpl());
			}
		}
	}

	/**
	 *
	 * @param ctx 
	 * @param parentTable
	 * @return
	 * @throws SAXException
	 */
	private ArrayList<String> getTranslatedColumns(PIPOContext ctx, String parentTable) throws SAXException {


		ArrayList<String> pipolColumns = cacheColumns.get(parentTable);
		if(pipolColumns != null){
			return pipolColumns;
		}

		ArrayList<String> columns = new ArrayList<String>();
		MTable table = MTable.get(ctx.ctx, parentTable);
		MColumn[] cols = table.getColumns(false);
		for (MColumn col : cols) {
			if (col.isTranslated()) {
				columns.add(col.getColumnName());
			}
		}
		
		columns.add("AD_Language");
		columns.add("IsActive");
		columns.add("IsTranslated");

		//Putting in cache
		cacheColumns.put(parentTable, columns);

		return columns;
	}

	private String cast(ArrayList<String> arg){
		String str = arg.toString();
		return str.substring(1,  str.length()-1);
	}

	private boolean existTranslated(String Name)
	{	
		if (MTable.getTable_ID(Name+"_Trl")>0)
			return true;
		else
			return false;
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception
	{
		packOut(packout, packoutHandler, docHandler, recordId, null);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId, String recordUU) throws Exception
	{
		if("Y".equals(packout.getCtx().ctx.getProperty("isHandleTranslations")) && existTranslated(packout.getCtx().ctx.getProperty("Table_Name"))){
			Env.setContext(packout.getCtx().ctx, CommonTranslationHandler.CONTEXT_KEY_PARENT_TABLE,packout.getCtx().ctx.getProperty("Table_Name"));
			Env.setContext(packout.getCtx().ctx, CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_ID,recordId);
			Env.setContext(packout.getCtx().ctx, CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_UU,recordUU);
			this.create(packout.getCtx(), packoutHandler);
			packout.getCtx().ctx.remove(CommonTranslationHandler.CONTEXT_KEY_PARENT_TABLE);
			packout.getCtx().ctx.remove(CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_ID);
			packout.getCtx().ctx.remove(CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_UU);
		}
	}
}
