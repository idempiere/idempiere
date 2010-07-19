package org.adempiere.pipo2.handler;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.DBException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PackOut;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.X_AD_Element;

public class CommonTranslationHandler extends AbstractElementHandler implements ElementHandler,IPackOutHandler{

	public static final String CONTEXT_KEY_PARENT_TABLE = "currentParentTableForTranslation";
	public static final String CONTEXT_KEY_PARENT_RECORD_ID = "currentParentTableRecordID_ForTranslation";
	public static final String SPECIAL_ATRRIBUTE_TABLE_NAME = "ParentTable";


	private HashMap<String, ArrayList<String>> cached_PIPO_ColumnsByTable = new HashMap<String, ArrayList<String>>();//Key: table name. Value: set of PIPO columns


	public void startElement(Properties ctx, Element element) throws SAXException {

		if(! isHandleTranslations(ctx)){
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

		String parentTable = getStringValue(element, SPECIAL_ATRRIBUTE_TABLE_NAME);
		String language = getStringValue(element, "AD_Language");

		log.info(elementValue+" "+parentTable+" "+getStringValue(element, "Name"));

		if(isRecordExists(parentTable, parentID, language, ctx)){
			updateTranslation(parentTable, parentID, ctx, element);
		}else{
			insertTranslation(parentTable, parentID, ctx, element);
		}
	}


	private boolean isRecordExists(String parentTable, int parentID,
			String language, Properties ctx) {

		String sql =
			"SELECT AD_Client_ID FROM " + parentTable +"_TRL WHERE " +
			parentTable + "_ID = ? AND AD_Language = ?";

		if(DB.getSQLValue(getTrxName(ctx), sql, parentID, language) == -1){
			return false;
		}else{
			return true;
		}
	}


	private void insertTranslation(String parentTable, int parentID,
			Properties ctx, Element element) throws SAXException{

		ArrayList<String> pipoColumns = getExportableColumns(parentTable);
		StringBuffer sql = new StringBuffer(
			"INSERT INTO " + parentTable + "_TRL (" + parentTable + "_ID, " +
			" AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, " + cast(pipoColumns) +
			") values ( ?, ?, ?, ?, ? ");


		for (int i = 0; i<pipoColumns.size(); i++) {
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
			for (String columnName : pipoColumns) {
				i++;

				String value = getStringValue(element, columnName);

				if(columnName.equalsIgnoreCase("IsActive") ||
						columnName.equalsIgnoreCase("IsTranslated")){
					value = "true".equals(value) ? "Y" : "N";
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


	private void updateTranslation(String parentTable, int parentID,
			Properties ctx, Element element) throws SAXException{
		ArrayList<String> pipoColumns = getExportableColumns(parentTable);
		StringBuffer sqlBuf = new StringBuffer("UPDATE "+parentTable+"_TRL SET ");
		for (String columnName : pipoColumns) {

			sqlBuf.append(columnName).append("=?,");
		}

		String sql =  sqlBuf.substring(0, sqlBuf.length()-1);

		sql += " WHERE AD_Language = '"+getStringValue(element, "AD_Language")+
		"' AND "+parentTable+"_ID="+parentID;

		PreparedStatement pstm = null;
		try {
			pstm = DB.prepareStatement(sql,getTrxName(ctx));
			int i=0;
			for (String columnName : pipoColumns) {

				String value = getStringValue(element, columnName);
				i++;

				if(columnName.equalsIgnoreCase("IsActive") ||
						columnName.equalsIgnoreCase("IsTranslated")){

					value = "true".equals(value) ? "Y" : "N";
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


	public void endElement(Properties ctx, Element element) throws SAXException {

	}


	public void create(Properties ctx, TransformerHandler document) throws SAXException {

		String parenTableName = Env.getContext(ctx, CONTEXT_KEY_PARENT_TABLE);

		int parentRecordID = Env.getContextAsInt(ctx, CONTEXT_KEY_PARENT_RECORD_ID);

		createTranslationTags(ctx, parenTableName, parentRecordID, document);
	}


	private void createTranslationTags(Properties ctx, String parentTable,
			int parentRecordID, TransformerHandler document) throws SAXException {

		ArrayList<String> exportableColumns = getExportableColumns(parentTable);

		String sql =
			"select "+cast(exportableColumns)+" from "+parentTable+"_trl where "+
			parentTable+"_ID="+parentRecordID;

		PreparedStatement pstm = DB.prepareStatement(sql, null);
		try {

			ResultSet rs = pstm.executeQuery();

			while(rs.next()){

				AttributesImpl atts = new AttributesImpl();
				atts.addAttribute("", "", "type", "CDATA", "object");
				atts.addAttribute("", "", "type-name", "CDATA", "ad.trl");
				document.startElement("", "", "trl", atts);
				addTextProperty(null, SPECIAL_ATRRIBUTE_TABLE_NAME, parentTable);
				getAttsForOneTrlRow(ctx, document, exportableColumns, rs);
				document.endElement("", "", "trl");
			}

			rs.close();
			pstm.close();

		} catch (Exception e) {
			e.printStackTrace();
			throw new SAXException();
		}
	}

	private void getAttsForOneTrlRow(Properties ctx, TransformerHandler document, ArrayList<String> exportableColumns,
			ResultSet rs) throws Exception {

		AttributesImpl atts = new AttributesImpl();
		PoExporter af = new PoExporter(ctx, document, null);

		for (String columnName : exportableColumns) {

			if(columnName.equalsIgnoreCase("IsActive")||
					columnName.equalsIgnoreCase("IsTranslated")){

				af.addBoolean(columnName, rs.getString(columnName).equalsIgnoreCase("Y"), atts);

			}else{

				af.addString(columnName, rs.getString(columnName), atts);
			}
		}
	}

	/**
	 *
	 * @param parentTable
	 * @return
	 * @throws SAXException
	 */
	@SuppressWarnings("unchecked")
	private ArrayList<String> getExportableColumns(String parentTable) throws SAXException {


		Object pipolColumns = cached_PIPO_ColumnsByTable.get(parentTable);
		if(pipolColumns != null){
			return (ArrayList<String>)pipolColumns;
		}

		ArrayList<String> new_PIPO_Columns = new ArrayList<String>();
		String sql = "select * from ad_column where ad_table_id = " +
				"(select ad_table_id from ad_table where tableName = ?)" +
				"and isTranslated='Y'";

		PreparedStatement pstm = DB.prepareStatement(sql, null);
		try {

			pstm.setString(1, parentTable);

			ResultSet rs = pstm.executeQuery();
			while(rs.next()){

				new_PIPO_Columns.add(rs.getString("columnName"));
			}

			pstm.close();
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
			throw new SAXException();
		}

		new_PIPO_Columns.add("AD_Language");
		new_PIPO_Columns.add("IsActive");
		new_PIPO_Columns.add("IsTranslated");

		//Putting in cache
		cached_PIPO_ColumnsByTable.put(parentTable, new_PIPO_Columns);

		return (ArrayList<String>)new_PIPO_Columns;
	}

	private String cast(ArrayList<String> arg){
		return arg.toString().substring(1,  arg.toString().length()-1);
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		if("true".equals(packout.getCtx().getProperty("isHandleTranslations"))){
			Env.setContext(packout.getCtx(), CommonTranslationHandler.CONTEXT_KEY_PARENT_TABLE,X_AD_Element.Table_Name);
			Env.setContext(packout.getCtx(), CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_ID,recordId);
			this.create(packout.getCtx(), packOutDocument);
			packout.getCtx().remove(CommonTranslationHandler.CONTEXT_KEY_PARENT_TABLE);
			packout.getCtx().remove(CommonTranslationHandler.CONTEXT_KEY_PARENT_RECORD_ID);

		}
	}
}
