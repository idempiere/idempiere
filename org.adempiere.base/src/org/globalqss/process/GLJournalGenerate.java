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
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.globalqss.process;

import java.math.BigDecimal;
import java.math.MathContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MBPartner;
import org.compiere.model.MConversionType;
import org.compiere.model.MElementValue;
import org.compiere.model.MJournal;
import org.compiere.model.MJournalGenerator;
import org.compiere.model.MJournalGeneratorLine;
import org.compiere.model.MJournalGeneratorSource;
import org.compiere.model.MJournalLine;
import org.compiere.model.MProduct;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.report.MReportTree;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;

/**
 *	GL Journal Generator
 *
 * 	@author 	Carlos Ruiz - Quality Systems & Solutions - globalqss
 */
public class GLJournalGenerate extends SvrProcess
{
	/**	Processing date from/to */
	private Timestamp p_ProcessingDateFrom;
	private Timestamp p_ProcessingDateTo;
	/**	Date of GL Journal */
	private Timestamp p_DateAcct;
	/**	Flag is simulation */
	private boolean p_IsSimulation = true;
	/**	Document Action */
	private String p_DocAction = null;
	/**	Document No */
	private String p_DocumentNo;
	/**	BPartner to filter */
	private int p_C_BPartner_ID = 0;
	/**	Product to filter */
	private int p_M_Product_ID = 0;
	/* The Journal Generator */
	private int p_QSS_JournalGenerator_ID;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (name.equals("ProcessingDate")) {
				p_ProcessingDateFrom = (Timestamp)para[i].getParameter();
				p_ProcessingDateTo = (Timestamp)para[i].getParameter_To();
			}
			else if (name.equals("DateAcct"))
				p_DateAcct = (Timestamp)para[i].getParameter();
			else if (name.equals("IsSimulation"))
				p_IsSimulation = para[i].getParameterAsBoolean();
			else if (name.equals("DocAction"))
				p_DocAction = (String) para[i].getParameter();
			else if (name.equals("DocumentNo"))
				p_DocumentNo = (String) para[i].getParameter();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("M_Product_ID"))
				p_M_Product_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_QSS_JournalGenerator_ID = getRecord_ID();
	}	//	prepare


	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("QSS_Journal_Generator_ID=" + p_QSS_JournalGenerator_ID
				+ ", ProcessingDate=" + p_ProcessingDateFrom + "/" + p_ProcessingDateTo
				+ ", DateAcct=" + p_DateAcct
				+ ", IsSimulation=" + p_IsSimulation
				+ ", DocAction=" + p_DocAction
				+ ", DocumentNo=" + p_DocumentNo
				+ ", C_BPartner_ID=" + p_C_BPartner_ID
				+ ", M_Product_ID=" + p_M_Product_ID
				);

		MJournalGenerator journalGenerator = new MJournalGenerator(getCtx(), p_QSS_JournalGenerator_ID, get_TrxName());
		MAcctSchema as = (MAcctSchema) journalGenerator.getC_AcctSchema();

		BigDecimal totalAmount = Env.ZERO;
		List<List<Integer>> listDimOut = new ArrayList<List<Integer>>();
		List<List<String>> listColOut = new ArrayList<List<String>>();
		List<BigDecimal> listDrAmtOut = new ArrayList<BigDecimal>();
		List<BigDecimal> listCrAmtOut = new ArrayList<BigDecimal>();
		List<Integer> listAccountOut = new ArrayList<Integer>();
		List<MJournalGeneratorLine> listLinesOut = new ArrayList<MJournalGeneratorLine>();

		for (MJournalGeneratorLine line : journalGenerator.getLines()) {
			int idxBPColumn = -1;

			List<String> groupColumns = new ArrayList<String>();
			groupColumns.add("AD_Client_ID");
			if (line.isCopyAllDimensions()) {
				for (MAcctSchemaElement element : as.getAcctSchemaElements()) {
					String columnName = MAcctSchemaElement.getColumnName(element.getElementType());
					if (! groupColumns.contains(columnName))
						groupColumns.add(columnName);
				}
			} else {
				if (MJournalGeneratorLine.BPDIMENSIONTYPE_Same.equals(line.getBPDimensionType()))
					groupColumns.add("C_BPartner_ID");
				else if (MJournalGeneratorLine.BPDIMENSIONTYPE_Column.equals(line.getBPDimensionType())) {
					String[] parts = line.getBPColumn().split("\\.");
					String tablename = parts[0];
					groupColumns.add(tablename + "_ID");
					idxBPColumn = groupColumns.size()-1;
				}

				if (line.isSameProduct())
					groupColumns.add("M_Product_ID");
			}
			String groupBy = "";
			for (String column : groupColumns) {
				if (groupBy.length() == 0)
					groupBy += column;
				else
					groupBy += ","+column;
			}
			List<List<Integer>> listDim = new ArrayList<List<Integer>>();
			List<BigDecimal> listAmt = new ArrayList<BigDecimal>();

			int p_AD_Org_ID = line.getAD_Org_ID();
			if (p_AD_Org_ID == 0)
				p_AD_Org_ID = journalGenerator.getAD_Org_ID();
			if (p_AD_Org_ID == 0)
				p_AD_Org_ID = Env.getAD_Org_ID(getCtx());
			for (MJournalGeneratorSource source : line.getSources()) {
				String sql =
						"SELECT SUM(AmtAcctDr-AmtAcctCr), "
						+ groupBy
						+ " FROM Fact_Acct "
						+ " WHERE PostingType='A' "
						+ "   AND IsActive='Y' "
						+ "   AND DateAcct BETWEEN ? AND ? "
						+ "   AND C_AcctSchema_ID=? "
						+ "   AND AD_Client_ID=? ";
				if (p_AD_Org_ID > 0)
					sql += "   AND AD_Org_ID=" + p_AD_Org_ID;
				if (p_C_BPartner_ID > 0)
					sql += "   AND C_BPartner_ID=" + p_C_BPartner_ID;
				if (p_M_Product_ID > 0)
					sql += "   AND M_Product_ID=" + p_M_Product_ID;
				if (source.getGL_Category_ID() > 0)
					sql += "   AND GL_Category_ID=" + source.getGL_Category_ID();
				sql += "   AND (";
				/* TODO: Get all accounts below tree of source */
				sql += MReportTree.getWhereClause(getCtx(), 0, MAcctSchemaElement.ELEMENTTYPE_Account, source.getC_ElementValue_ID());
				sql += ")";
				sql += " GROUP BY " + groupBy;

		    	PreparedStatement pstmt = null;
		    	ResultSet rs = null;
		    	try
		    	{
					pstmt = DB.prepareStatement(sql, get_TrxName());
					pstmt.setTimestamp(1, p_ProcessingDateFrom);
					pstmt.setTimestamp(2, p_ProcessingDateTo);
					pstmt.setInt(3, journalGenerator.getC_AcctSchema_ID());
					pstmt.setInt(4, getAD_Client_ID());
					rs = pstmt.executeQuery();
		    		while (rs.next()) {
						BigDecimal sourceAmt = rs.getBigDecimal(1);
						if (sourceAmt != null && sourceAmt.signum() != 0) {
							sourceAmt = applyMultiplierAndFactor(sourceAmt, source.getAmtMultiplier(), source.getRoundFactor());

							List<Integer> dimensions = new ArrayList<Integer>();
							int idxCol = 0;
							for (String column : groupColumns) {
								if (idxBPColumn == idxCol) {
									// Assign the BPDIMENSIONTYPE_Column to the output BP
									int bpIdOut = 0;
									String[] parts = line.getBPColumn().split("\\.");
									String tablename = parts[0];
									String columnname = parts[1];
									int id = rs.getInt(column);
									if (id > 0) {
										MTable table = MTable.get(getCtx(), tablename);
										PO po = table.getPO(id, get_TrxName());
										bpIdOut = po.get_ValueAsInt(columnname);
									}
									dimensions.add(bpIdOut);
								} else {
									dimensions.add(rs.getInt(column));
								}
								idxCol++;
							}

							if (listDim.contains(dimensions)) {
								int idx = listDim.indexOf(dimensions);
								BigDecimal dimAmt = listAmt.get(idx);
								dimAmt = dimAmt.add(sourceAmt);
								listAmt.set(idx, dimAmt);
							} else {
								listDim.add(dimensions);
								listAmt.add(sourceAmt);
							}
						}
		    		}
		    	}
		    	catch (SQLException e)
		    	{
		    		//log.log(Level.SEVERE, sql, getSQLException(e));
		    		throw new DBException(e, sql);
		    	}
		    	finally
		    	{
		    		DB.close(rs, pstmt);
		    		rs = null; pstmt = null;
		    	}

			}

			/* Ready, here I have the input array with all sources to take into account, construct the output */

			List<String> columnsOut = new ArrayList<String>();
			if (line.isCopyAllDimensions()) {
				columnsOut = groupColumns;
			} else {
				columnsOut.add("AD_Client_ID");
				if (   MJournalGeneratorLine.BPDIMENSIONTYPE_Same.equals(line.getBPDimensionType())
					|| MJournalGeneratorLine.BPDIMENSIONTYPE_Fixed.equals(line.getBPDimensionType())
					|| MJournalGeneratorLine.BPDIMENSIONTYPE_Column.equals(line.getBPDimensionType()))
					columnsOut.add("C_BPartner_ID");
				if (line.isSameProduct())
					columnsOut.add("M_Product_ID");
			}

			for (int i = 0; i < listDim.size(); i++) {
				List<Integer> dimensions = listDim.get(i);
				BigDecimal amount = listAmt.get(i);

				List<Integer> dimensionsOut = new ArrayList<Integer>();
				if (amount != null && amount.signum() != 0) {
					amount = applyMultiplierAndFactor(amount, line.getAmtMultiplier(), line.getRoundFactor());

					if (line.isCopyAllDimensions()) {
						dimensionsOut = dimensions;
					} else {
						/* First dimension is always AD_Client_ID */
						dimensionsOut.add(dimensions.get(0));
						if (MJournalGeneratorLine.BPDIMENSIONTYPE_Same.equals(line.getBPDimensionType())) {
							dimensionsOut.add(dimensions.get(groupColumns.indexOf("C_BPartner_ID")));
						} else if (MJournalGeneratorLine.BPDIMENSIONTYPE_Fixed.equals(line.getBPDimensionType())) {
							dimensionsOut.add(line.getC_BPartner_ID());
						} else if (MJournalGeneratorLine.BPDIMENSIONTYPE_Column.equals(line.getBPDimensionType())) {
							String[] parts = line.getBPColumn().split("\\.");
							String tablename = parts[0];
							dimensionsOut.add(dimensions.get(groupColumns.indexOf(tablename + "_ID")));
						}

						if (line.isSameProduct()) {
							dimensionsOut.add(dimensions.get(groupColumns.indexOf("M_Product_ID")));
						}
					}

					if (line.getC_ElementValueDR_ID() > 0) {
						listAccountOut.add(line.getC_ElementValueDR_ID());
						listDrAmtOut.add(amount);
						listCrAmtOut.add(Env.ZERO);
						listDimOut.add(dimensionsOut);
						listColOut.add(columnsOut);
						listLinesOut.add(line);
						totalAmount = totalAmount.add(amount);
					}
					if (line.getC_ElementValueCR_ID() > 0) {
						listAccountOut.add(line.getC_ElementValueCR_ID());
						listDrAmtOut.add(Env.ZERO);
						listCrAmtOut.add(amount);
						listDimOut.add(dimensionsOut);
						listColOut.add(columnsOut);
						listLinesOut.add(line);
						totalAmount = totalAmount.subtract(amount);
					}
					if (line.getC_ElementValueDR_ID() == 0 && line.getC_ElementValueCR_ID() == 0 && line.isCopyAllDimensions()) {
						int accountId = dimensions.get(groupColumns.indexOf("Account_ID"));
						listAccountOut.add(accountId);
						if (amount.signum() > 0) {
							listDrAmtOut.add(amount);
							listCrAmtOut.add(Env.ZERO);
							totalAmount = totalAmount.add(amount);
						} else {
							listDrAmtOut.add(Env.ZERO);
							listCrAmtOut.add(amount.negate());
							totalAmount = totalAmount.add(amount);
						}
						listDimOut.add(dimensionsOut);
						listColOut.add(columnsOut);
						listLinesOut.add(line);
					}
				}
			}
		} // generatorLines

		// Add adjust line
		if (totalAmount.signum() < 0 && journalGenerator.getC_ElementValueAdjustDR_ID() > 0) {
			listAccountOut.add(journalGenerator.getC_ElementValueAdjustDR_ID());
			listDrAmtOut.add(totalAmount.negate());
			listCrAmtOut.add(Env.ZERO);
			listDimOut.add(null);
			listColOut.add(null);
			listLinesOut.add(null);
		} else if (totalAmount.signum() > 0 && journalGenerator.getC_ElementValueAdjustCR_ID() > 0) {
			listAccountOut.add(journalGenerator.getC_ElementValueAdjustCR_ID());
			listDrAmtOut.add(Env.ZERO);
			listCrAmtOut.add(totalAmount);
			listDimOut.add(null);
			listColOut.add(null);
			listLinesOut.add(null);
		}

		MJournal j = null;
		int lineNo = 10;
		/* Ready, here we have an array of output calculated journals, let's process them */
		for (int i = 0; i < listDimOut.size(); i++) {
			List<Integer> dimensions = listDimOut.get(i);
			List<String> columnsOut = listColOut.get(i);
			BigDecimal dr = listDrAmtOut.get(i);
			BigDecimal cr = listCrAmtOut.get(i);
			int accountId = listAccountOut.get(i);
			MJournalGeneratorLine line = listLinesOut.get(i);

			if (p_IsSimulation) {
				MElementValue ev = new MElementValue(getCtx(), accountId, get_TrxName());
				String msg = "Account=" + ev.getValue()
						+ ", DR=" + dr
						+ ", CR=" + cr;
				int idxcol = 0;
				if (columnsOut != null) {
					for (String col : columnsOut) {
						int id = dimensions.get(idxcol);
						if (id == 0)
							continue;
						if ("C_BPartner_ID".equals(col)) {
							MBPartner bp = MBPartner.get(getCtx(), id);
							msg += ", C_BPartner=" + bp.getValue();
						} else if ("M_Product_ID".equals(col)) {
							MProduct pr = MProduct.get(getCtx(), id);
							msg += ", M_Product=" + pr.getValue();
						} else if ("AD_Client_ID".equals(col)) {
						} else {
							msg += ", " + col + "=" + id;
						}
						idxcol++;
					}
				}
				addLog(msg);
			} else {
				/* Create journals */
				if (j == null) {
			    	// * Create a GL Journal
			        // conversion type = default
			        j = new MJournal(getCtx(), 0, get_TrxName());
			        if (journalGenerator.getAD_Org_ID() > 0)
			        	j.setAD_Org_ID(journalGenerator.getAD_Org_ID());
			        else
			        	j.setAD_Org_ID(Env.getAD_Org_ID(getCtx()));
					if (j.getAD_Org_ID() == 0) {
						throw new AdempiereException(Msg.getMsg(Language.getBaseAD_Language(), "Org0NotAllowed"));
					}
			        j.setC_Currency_ID(as.getC_Currency_ID());
			        j.setC_DocType_ID(journalGenerator.getC_DocType_ID());
			        j.setControlAmt(Env.ZERO);
			        j.setDateAcct(p_DateAcct);
			        j.setDateDoc(p_DateAcct);
			        j.setDescription(journalGenerator.getDescription());
			        j.setDocumentNo(p_DocumentNo);
			        j.setGL_Category_ID(journalGenerator.getGL_Category_ID());
					j.setPostingType(journalGenerator.getPostingType());
			        j.setC_AcctSchema_ID(as.getC_AcctSchema_ID());
			        j.setC_ConversionType_ID(MConversionType.getDefault(as.getAD_Client_ID()));
			        j.saveEx();
				}
		        // Create the journal lines
				MJournalLine jl = new MJournalLine(j);
				jl.setLine(lineNo);
				lineNo += 10;
		        MAccount combination;
		        {
		        	int AD_Client_ID = getAD_Client_ID();
		        	int AD_Org_ID = 0;
		        	if (line != null)
		        		AD_Org_ID = line.getAD_Org_ID();
		        	if (AD_Org_ID == 0)
		        		AD_Org_ID = journalGenerator.getAD_Org_ID();
		        	if (AD_Org_ID == 0)
		        		AD_Org_ID = Env.getAD_Org_ID(getCtx());
		        	int C_AcctSchema_ID = journalGenerator.getC_AcctSchema_ID();
		        	int Account_ID = accountId;
					int C_SubAcct_ID = 0;

		        	int M_Product_ID = 0;
					int C_BPartner_ID = 0;
		        	int AD_OrgTrx_ID = 0;
		        	int C_LocFrom_ID = 0;
		        	int C_LocTo_ID = 0;
		        	int C_SalesRegion_ID = 0;
					int C_Project_ID = 0;
		        	int C_Campaign_ID = 0;
		        	int C_Activity_ID = 0;
		        	int User1_ID = 0;
		        	int User2_ID = 0;
					int UserElement1_ID = 0;
		        	int UserElement2_ID = 0;
					if (columnsOut != null) {
						int idxcol = 0;
						for (String col : columnsOut) {
							int id = dimensions.get(idxcol);
							if ("M_Product_ID".equals(col))
								M_Product_ID = id;
							else if ("C_BPartner_ID".equals(col))
								C_BPartner_ID = id;
							else if ("AD_OrgTrx_ID".equals(col))
								AD_OrgTrx_ID = id;
							else if ("C_LocFrom_ID".equals(col))
								C_LocFrom_ID = id;
							else if ("C_LocTo_ID".equals(col))
								C_LocTo_ID = id;
							else if ("C_SalesRegion_ID".equals(col))
								C_SalesRegion_ID = id;
							else if ("C_Project_ID".equals(col))
								C_Project_ID = id;
							else if ("C_Campaign_ID".equals(col))
								C_Campaign_ID = id;
							else if ("C_Activity_ID".equals(col))
								C_Activity_ID = id;
							else if ("User1_ID".equals(col))
								User1_ID = id;
							else if ("User2_ID".equals(col))
								User2_ID = id;
							else if ("UserElement1_ID".equals(col))
								UserElement1_ID = id;
							else if ("UserElement2_ID".equals(col))
								UserElement2_ID = id;
							
							idxcol++;
						}
					}
					combination = MAccount.get(getCtx(), AD_Client_ID,
							AD_Org_ID, C_AcctSchema_ID, Account_ID,
							C_SubAcct_ID, M_Product_ID, C_BPartner_ID,
							AD_OrgTrx_ID, C_LocFrom_ID, C_LocTo_ID,
							C_SalesRegion_ID, C_Project_ID, C_Campaign_ID,
							C_Activity_ID, User1_ID, User2_ID, UserElement1_ID,
							UserElement2_ID);
					if (combination == null)
						throw new AdempiereException("Could not create combination");
		        }
				jl.setC_ValidCombination_ID(combination);
				if (line != null)
					jl.setDescription(line.getDescription());
		        jl.setAmtSourceDr(dr);
		        jl.setAmtAcctDr(dr);
		        jl.setAmtSourceCr(cr);
		        jl.setAmtAcctCr(cr);
		        jl.saveEx();
			}
		}

		if (j != null && p_DocAction != null) {
			// DocAction
			if (!j.processIt(p_DocAction))
				throw new AdempiereException("Couldn't set docAction: " + p_DocAction + ((org.compiere.process.DocAction) j).getProcessMsg()+ " journal");
			j.saveEx();
		}
		
		if (j != null) {
			StringBuilder msg = new StringBuilder(Msg.parseTranslation(getCtx(), "@Created@ @GL_Journal_ID@=")).append(j.getDocumentNo());
			addLog(j.get_ID(), null, null, msg.toString(), MJournal.Table_ID, j.get_ID());
		}

		return "@OK@";
	}	//	doIt

	private BigDecimal applyMultiplierAndFactor(BigDecimal sourceAmt, BigDecimal amtMultiplier, int roundFactor) {
		if (amtMultiplier.compareTo(Env.ONE) != 0)
			sourceAmt = sourceAmt.multiply(amtMultiplier, MathContext.UNLIMITED);

		if (roundFactor < 0) {
			BigDecimal divisor = BigDecimal.valueOf(Math.pow(10, -roundFactor));
			sourceAmt = sourceAmt.divide(divisor, MathContext.UNLIMITED);
			sourceAmt = sourceAmt.setScale(0, BigDecimal.ROUND_HALF_UP);
			sourceAmt = sourceAmt.multiply(divisor, MathContext.UNLIMITED);
			sourceAmt = sourceAmt.setScale(0, BigDecimal.ROUND_HALF_UP);
		} else {
			sourceAmt = sourceAmt.setScale(roundFactor, BigDecimal.ROUND_HALF_UP);
		}
		return sourceAmt;
	}

}	//	GLJournalGenerate
