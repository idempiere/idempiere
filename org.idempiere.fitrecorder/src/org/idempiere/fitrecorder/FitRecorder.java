package org.idempiere.fitrecorder;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;

public class FitRecorder implements ModelValidator {
	
	private static FileOutputStream tempFileOr = null;
    private static Writer writerOr;
    
    /** Logger */
	private static CLogger log = CLogger.getCLogger(ModelValidator.class);
	
    private static ArrayList<String> dontLogTables = new ArrayList<String>(Arrays.asList(
    "AD_ACCESSLOG",
	"AD_SESSION",
	"AD_ALERTPROCESSORLOG",
	"AD_CHANGELOG",
	"AD_DOCUMENT_ACTION_ACCESS",
	"AD_FORM_ACCESS",
	"AD_ISSUE",
	"AD_LDAPPROCESSORLOG",
	"AD_PACKAGE_IMP",
	"AD_PACKAGE_IMP_BACKUP",
	"AD_PACKAGE_IMP_DETAIL",
	"AD_PACKAGE_IMP_INST",
	"AD_PACKAGE_IMP_PROC",
	"AD_PINSTANCE",
	"AD_PINSTANCE_LOG",
	"AD_PINSTANCE_PARA",
	"AD_PROCESS_ACCESS",
	"AD_RECENTITEM",
	"AD_REPLICATION_LOG",
	"AD_SCHEDULERLOG",
	"AD_SESSION",
	"AD_WINDOW_ACCESS",
	"AD_WORKFLOW_ACCESS",
	"AD_WORKFLOWPROCESSORLOG",
	"CM_WEBACCESSLOG",
	"C_ACCTPROCESSORLOG",
	"K_INDEXLOG",
	"R_REQUESTPROCESSORLOG",
	"T_AGING",
	"T_ALTER_COLUMN",
	"T_DISTRIBUTIONRUNDETAIL",
	"T_INVENTORYVALUE",
	"T_INVOICEGL",
	"T_REPLENISH",
	"T_REPORT",
	"T_REPORTSTATEMENT",
	"T_SELECTION",
	"T_SELECTION2",
	"T_SPOOL",
	"T_TRANSACTION",
	"T_TRIALBALANCE"));
		
	@Override
	public void initialize(ModelValidationEngine engine, MClient client) {
		SimpleDateFormat format = DisplayType.getDateFormat(DisplayType.DateTime);
		String dateTimeText = format.format(new Timestamp(System.currentTimeMillis()));
		
		String sql="SELECT ta.TableName"
		 		 +" FROM AD_Table ta"
				 +" WHERE ta.IsActive='Y'"
				 +" AND ta.IsView='N'"
				 +" AND ta.EntityType='D'"
				 +" ORDER BY ta.TableName";
		
		String sql1="SELECT ta.TableName"
				   +" FROM AD_Table ta"
				   +" INNER JOIN AD_Column cl ON (ta.AD_Table_ID = cl.AD_Table_ID)"
				   +" WHERE ta.IsActive='Y'" 
				   +" AND ta.IsView='N'"
				   +" AND ta.EntityType='D'"
				   +" AND cl.AD_Element_ID=287"
				   +" ORDER BY ta.TableName";
		
		try{
		  File fileNameOr = File.createTempFile("fit_test_"+dateTimeText, ".txt");
	      tempFileOr = new FileOutputStream(fileNameOr, true);
	      writerOr = new BufferedWriter(new OutputStreamWriter(tempFileOr, "UTF8"));
	  
	      PreparedStatement pstmt=null,pstmt1=null;
	      ResultSet rs=null,rs1=null;
	    		
	      try{
    	     pstmt=DB.prepareStatement(sql, null);
    	     rs=pstmt.executeQuery();	
    		 while (rs.next()) {
    		   if (!dontLogTables.contains(rs.getString(1).toUpperCase().trim()))
    			    engine.addModelChange(rs.getString(1), this);
    		 }
		  }catch(Exception e){
    		  log.info(e.getLocalizedMessage());	
		  }finally{
			  pstmt.close();
			  rs.close();
		  }
    	
	      try {
             pstmt1=DB.prepareStatement(sql1, null);
    		 rs1=pstmt1.executeQuery();
    		 while (rs1.next()) {
    		   if (!dontLogTables.contains(rs1.getString(1).toUpperCase().trim()))
    				engine.addDocValidate(rs1.getString(1), this);
    		 }
    	   }catch (Exception e) {
    		  log.info(e.getLocalizedMessage());
    	   }finally{
    	      pstmt1.close();
    		  rs1.close();
    	   }	
		}catch (Exception e) {
  		     log.info(e.getLocalizedMessage());
		}finally{
	       if (tempFileOr!=null){
			   try {
				 tempFileOr.close();
			    } catch (IOException e){
				  //TODO
			    }
			}
		}	
	}

	@Override
	public int getAD_Client_ID() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {
		
		try {
			
			writerOr.append("\n");
			writerOr.append("\n");
			writerOr.append("LOGIN");
			writerOr.append("\n");
			writerOr.append("!");
			writerOr.append("| Login |");
			writerOr.append("\n");
			MUser user = MUser.get(Env.getCtx(), AD_User_ID);
			writerOr.append("| User |");
			writerOr.append(user.getName() + " |");
			writerOr.append("\n");
			writerOr.append("| Password |");
			writerOr.append(user.getPassword() + " |");
			writerOr.append("\n");
			writerOr.append("| AD_ClIEnT_id |");
			writerOr.append(user.getAD_Client_ID() + " |");
			writerOr.append("\n");
			writerOr.append("| AD_Role_id |");
			writerOr.append(AD_Role_ID + " |");
			writerOr.append("\n");
			writerOr.append("| *Login* |");
			writerOr.flush();
			
		}catch (Exception e) {
			return e.getLocalizedMessage();
		}
		return null;
	}

	@Override
	public String modelChange(PO po, int type) throws Exception {
		
		try {
			if(type == TYPE_AFTER_NEW ){
				
				writerOr.append("\n");
				writerOr.append("\n");
				writerOr.append("CREATE RECORD");
				writerOr.append("\n");
				writerOr.append("!");
				writerOr.append("| Create Record||");
				writerOr.append("\n");
				writerOr.append("| *Table* |");
				writerOr.append(po.get_TableName()+"|");
		
				MTable table=MTable.get(Env.getCtx(),po.get_Table_ID());
				MColumn[] columns=table.getColumns(true);
				
				for(int i = 0 ; i < columns.length ; i++){
					String colName=columns[i].getColumnName();
					String value=po.get_ValueAsString(colName);
					if(value != null && value.length() > 0){
					  writerOr.append("\n");
					  writerOr.append("| "+colName+" |");
					  writerOr.append(value+" | ");
					} 
				}
				writerOr.append("\n");
				writerOr.append("| *Save* |");
				writerOr.flush();
				
			}
			
			if(po instanceof MPInstance){
				if(type == TYPE_AFTER_CHANGE){
					
					MProcess pro= MProcess.get(Env.getCtx(), po.get_ValueAsInt("AD_Process_ID"));
					MPInstance pint=(MPInstance)po;
					writerOr.append("\n");
					writerOr.append("\n");
					writerOr.append("RUN PROCESS");
					writerOr.append("\n");
					writerOr.append("!");	
					writerOr.append("| Run Process |");
					writerOr.append("\n");
					writerOr.append("| *ProcessValue* |");
					writerOr.append(pro.getValue()+" |");
					MPInstancePara[] para=pint.getParameters();
					 if(para.length>0){
						 
					    for (int i=0 ; i < para.length ; i++){
						    writerOr.append("\n");
						    String name=para[i].getParameterName();
						    if(name.contains("to")){
						    	name.replace("to", "_2");
						    }
						    writerOr.append("|"+name+"|");
						    writerOr.append(para[i].get_ValueAsString(para[i].getParameterName())+"|");
					
					    }
					 }
					 writerOr.append("\n");
					 writerOr.append("| *Run* |");	 		
			 
			  }
			}
		}catch (Exception e) {
			return e.getLocalizedMessage();
		}
		return null;
	}

	@Override
	public String docValidate(PO po, int timing) {
		try{
			if(timing == TIMING_AFTER_COMPLETE ){
		
				writerOr.append("\n");
				writerOr.append("\n");
				writerOr.append("RUN PROCESS");
				writerOr.append("\n");
			    writerOr.append("!");	
			    writerOr.append("| Run Process |");
			    writerOr.append("\n");
			    writerOr.append("| *ProcessValue* |");
			    writerOr.append(po.get_ValueAsString("value")+" |");
			    writerOr.append("\n");
			    writerOr.append("| *DocAction* |");
			    writerOr.append("CO |");
			    writerOr.append("\n");
			    writerOr.append("| *Run* |");
			    writerOr.flush();	
			    
		     }
		
		    if(timing == TIMING_AFTER_PREPARE  || timing == TIMING_AFTER_VOID
				|| timing == TIMING_AFTER_CLOSE || timing == TIMING_AFTER_REACTIVATE || timing == TIMING_AFTER_REVERSECORRECT
				|| timing == TIMING_AFTER_REVERSEACCRUAL || timing == TIMING_AFTER_POST ){
		    	
		    	writerOr.append("\n");	
				writerOr.append("\n");
				writerOr.append("SET DOC ACTION");
				writerOr.append("\n");
		    	writerOr.append("!");	
		    	writerOr.append("| Set DocAction |");
		    	writerOr.append("\n");
		    	writerOr.append("| *Table* |");
		    	MTable table=new MTable(Env.getCtx(), po.get_Table_ID(), null);
		    	writerOr.append(table.getTableName()+" |");
		    	writerOr.append("\n");
		    	writerOr.append("| *RecordID* |");
		    	writerOr.append(po.get_ID()+"|");
		    	writerOr.append("\n");
		    	writerOr.append("|docAction   |");
		    	writerOr.append(po.get_ValueAsString("DocAction")+" |");
		    	writerOr.append("\n");
		    	writerOr.append("| *Save* |");
		    	writerOr.flush();		    	
			
		    }
		}catch (Exception e) {
			log.info(e.getLocalizedMessage());
		}
		return null;
	}
}
