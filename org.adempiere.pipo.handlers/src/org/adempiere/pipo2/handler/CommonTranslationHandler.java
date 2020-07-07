package org.adempiere.pipo2.handler;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class CommonTranslationHandler extends AbstractElementHandler implements ElementHandler {

	public static final String CONTEXT_KEY_PARENT_TABLE = "currentParentTableForTranslation";
	public static final String CONTEXT_KEY_PARENT_RECORD_ID = "currentParentTableRecordID_ForTranslation";

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
		int parentID = element.parent.recordId;

		if(parentID ==0)
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


	private boolean isRecordExists(String tableName, int parentID,
			String language, PIPOContext ctx) {

		String sql =
			"SELECT AD_Client_ID FROM " + tableName +" WHERE " +
			tableName.substring(0, tableName.length()-4) + "_ID = ? AND AD_Language = ?";

		if(DB.getSQLValue(getTrxName(ctx), sql, parentID, language) == -1){
			return false;
		}else{
			return true;
		}
	}


	private void insertTranslation(String tableName, int parentID,
			PIPOContext ctx, Element element) throws SAXException{

		String parentTable = tableName.substring(0, tableName.length()-4);
		ArrayList<String> columns = getTranslatedColumns(ctx, parentTable);
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO ")
			.append(tableName)
			.append(" (")
			.append(parentTable)
			.append("_ID, ")
			.append(" AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, ")
			.append(cast(columns))
			.append(") values ( ?, ?, ?, ?, ? ");

		for (int i = 0; i<columns.size(); i++) {
			sql.append(",?");
		}

		sql.append(")");

		PreparedStatement pstm = null;
		try {
			pstm = DB.prepareStatement(sql.toString(), getTrxName(ctx));
			pstm.setInt(1, parentID);
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
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			DB.close(pstm);
		}
	}


	private void updateTranslation(String tableName, int parentID,
			PIPOContext ctx, Element element) throws SAXException{
		String parentTable = tableName.substring(0, tableName.length()-4);
		ArrayList<String> columns = getTranslatedColumns(ctx, parentTable);
		StringBuilder buffer = new StringBuilder("UPDATE "+tableName+" SET ");
		for (String columnName : columns) {
			buffer.append(columnName).append("=?,");
		}

		String sql =  buffer.substring(0, buffer.length()-1);
		sql += " WHERE AD_Language = '"+getStringValue(element, "AD_Language")+
		"' AND "+parentTable+"_ID="+parentID;

		PreparedStatement pstm = null;
		try {
			pstm = DB.prepareStatement(sql,getTrxName(ctx));
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

		createTranslationTags(ctx, parenTableName, parentRecordID, document);
	}


	private void createTranslationTags(PIPOContext ctx, String parentTable,
			int parentRecordID, TransformerHandler document) throws SAXException {

		ArrayList<String> translatedColumns = getTranslatedColumns(ctx, parentTable);

		String sql =
			"SELECT "+cast(translatedColumns)+" FROM "+parentTable+"_Trl WHERE "+
			parentTable+"_ID=?";

		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {

			pstm = DB.prepareStatement(sql, getTrxName(ctx));
			pstm.setInt(1, parentRecordID);
			rs = pstm.executeQuery();

			String elementName = parentTable + "_Trl";
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

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		if("Y".equals(packout.getCtx().ctx.getProperty("isHandleTranslations")) && existTranslated(packout.getCtx().ctx.getProperty("Table_Name"))){
			Env.setContext(packout.getCtx().ctx, CommonTranslationHandler.CONTEXT_KEY_PARENT_TABLE,packout.getCtx().ctx.getProperty("Table_Name"));
			Env.setContext(packout.getCtx().ctx, CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_ID,recordId);
			this.create(packout.getCtx(), packoutHandler);
			packout.getCtx().ctx.remove(CommonTranslationHandler.CONTEXT_KEY_PARENT_TABLE);
			packout.getCtx().ctx.remove(CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_ID);

		}
	}
}
