/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 * Contributor(s): Layda Salas (globalqss)
 * Contributor(s): Carlos Ruiz (globalqss)
 *****************************************************************************/

package org.compiere.process;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MClientInfo;
import org.compiere.model.MDiscountSchemaLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MSequence;
import org.compiere.model.MUOMConversion;
import org.compiere.model.ProductCost;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.CPreparedStatement;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.ValueNamePair;

/**
 * Create PriceList by copying purchase prices (M_Product_PO) 
 *		and applying product category discounts (M_CategoryDiscount)
 * 
 * @author Layda Salas (globalqss)
 * @version $Id: M_PriceList_Create,v 1.0 2005/10/09 22:19:00
 *          globalqss Exp $
 * @author Carlos Ruiz (globalqss)
 *         Make T_Selection tables permanent
 */
public class M_PriceList_Create extends SvrProcess {

	/** The Record */
	private int p_PriceList_Version_ID = 0;

	private String p_DeleteOld;
	
	private int m_AD_PInstance_ID = 0; 

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("DeleteOld"))
				p_DeleteOld = (String) para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_PriceList_Version_ID = getRecord_ID();
		m_AD_PInstance_ID = getAD_PInstance_ID();
	} //*prepare*/

	/**
	 * Process
	 * 
	 * @return message
	 * @throws Exception
	 */

	protected String doIt() throws Exception {
		StringBuilder sql = new StringBuilder();
		StringBuilder sqlupd = new StringBuilder();
		String sqldel;
		StringBuilder sqlins = new StringBuilder();
		int cntu = 0;
		int cntd = 0;
		int cnti = 0;
		@SuppressWarnings("unused")
		int totu = 0;
		@SuppressWarnings("unused")
		int toti = 0;
		@SuppressWarnings("unused")
		int totd = 0;
		int v_temp;
		int v_NextNo = 0;
		StringBuilder message = new StringBuilder();
		//
		//Checking Prerequisites
		//PO Prices must exists
		//
		sqlupd.append("UPDATE M_Product_PO  SET	PriceList = 0  ")
			  .append(" WHERE	PriceList IS NULL ");

		cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
		if (cntu == -1)
			raiseError(
					"Update The PriceList to zero of M_Product_PO WHERE	PriceList IS NULL",
					sqlupd.toString());
		totu += cntu;
		if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);

		sqlupd = new StringBuilder("UPDATE M_Product_PO  SET PriceLastPO = 0  ");
					   sqlupd.append(" WHERE	PriceLastPO IS NULL ");

		cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
		if (cntu == -1)
			raiseError(
					"Update  The PriceListPO to zero of  M_Product_PO WHERE	PriceLastPO IS NULL",
					sqlupd.toString());
		totu += cntu;
		if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);

		sqlupd = new StringBuilder("UPDATE M_Product_PO  SET     PricePO = PriceLastPO ");
						sqlupd.append(" WHERE	(PricePO IS NULL OR PricePO = 0) AND PriceLastPO <> 0 ");

		cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
		if (cntu == -1)
			raiseError(
					"Update  The PricePO to PriceLastPO of  M_Product_PO WHERE	(PricePO IS NULL OR PricePO = 0) AND PriceLastPO <> 0 ",
					sqlupd.toString());
		totu += cntu;
		if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);

		sqlupd = new StringBuilder("UPDATE M_Product_PO  SET     PricePO = 0  ");
						sqlupd.append(" WHERE	PricePO IS NULL ");

		cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
		if (cntu == -1)
			raiseError(
					"Update  The PricePO to Zero of  M_Product_PO WHERE	PricePO IS NULL",
					sqlupd.toString());
		totu += cntu;
		if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);
		//
		//  Set default current vendor
		//
		sqlupd = new StringBuilder("UPDATE M_Product_PO  SET      IsCurrentVendor = 'Y'  ");
						sqlupd.append(" WHERE	 IsCurrentVendor = 'N'  AND NOT   EXISTS ");
						sqlupd.append(" (SELECT   pp.M_Product_ID   FROM     M_Product_PO pp ");
						sqlupd.append("  WHERE    pp.M_Product_ID = M_Product_PO.M_Product_ID");
						sqlupd.append("  GROUP BY pp.M_Product_ID HAVING COUNT(*) > 1) ");

		cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
		if (cntu == -1)
			raiseError("Update  IsCurrentVendor to Y of  M_Product_PO ", sqlupd.toString());
		totu += cntu;
		if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);

		// let the commit for SvrProcess
		// DB.commit(true, get_TrxName());

		//
		//	Make sure that we have only one active product
		//
		sql.append("SELECT DISTINCT M_Product_ID FROM M_Product_PO po ");
			sql.append(" WHERE	 IsCurrentVendor='Y' AND IsActive='Y' ");
			sql.append("   AND    EXISTS (SELECT   M_Product_ID ");
								sql.append(" FROM     M_Product_PO x  ");
								sql.append(" WHERE    x.M_Product_ID=po.M_Product_ID ");
								sql.append("   AND    IsCurrentVendor='Y' AND IsActive='Y' ");
								sql.append(" GROUP BY M_Product_ID ").append(" HAVING COUNT(*) > 1 ) ");

		PreparedStatement stmtDupl = null;
		ResultSet rsDupl = null;
		PreparedStatement stmtVendors = null;
		ResultSet rsVend = null;
		try {
			stmtDupl = DB.prepareStatement(sql.toString(), get_TrxName());
			rsDupl = stmtDupl.executeQuery();
			while (rsDupl.next()) {
				sql = new StringBuilder("SELECT	M_Product_ID         ,C_BPartner_ID ");
								sql.append(" FROM	M_Product_PO  WHERE	IsCurrentVendor = 'Y'  ");
								sql.append(" AND     IsActive        = 'Y' ");
								sql.append(" AND	M_Product_ID    = ").append(rsDupl.getInt("M_Product_ID"));
								sql.append(" ORDER BY PriceList DESC");

				stmtVendors = DB.prepareStatement(sql.toString(), get_TrxName());
				rsVend = stmtVendors.executeQuery();

				//
				//	Leave First
				//
				rsVend.next();
				
				while (rsVend.next()) {
					sqlupd = new StringBuilder("UPDATE M_Product_PO ");
									sqlupd.append(" SET	IsCurrentVendor = 'N'  ");
									sqlupd.append(" WHERE	M_Product_ID= ").append(rsVend.getInt("M_Product_ID"));
									sqlupd.append(" AND     C_BPartner_ID= ");
									sqlupd.append(rsVend.getInt("C_BPartner_ID"));
					
					cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
					if (cntu == -1)
						raiseError(
								"Update  IsCurrentVendor to N of  M_Product_PO for a M_Product_ID and C_BPartner_ID ingresed",
								sqlupd.toString());
					totu += cntu;
					if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);
				}
			}
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(rsDupl, stmtDupl);
			rsDupl = null; stmtDupl = null;
			DB.close(rsVend, stmtVendors);
			rsVend = null; stmtVendors = null;
		}

		// DB.commit(true, get_TrxName());

		//
		//	Delete Old Data	
		//
		if (p_DeleteOld.equals("Y")) {
			sqldel = "DELETE FROM M_ProductPrice WHERE	M_PriceList_Version_ID=?";
			cntd = DB.executeUpdate(sqldel, p_PriceList_Version_ID, get_TrxName());
			if (cntd == -1)
				raiseError(" DELETE	FROM M_ProductPrice ", sqldel);
			totd += cntd;
			message = new StringBuilder("@Deleted@=").append(cntd).append(" - ");
			if (log.isLoggable(Level.FINE)) log.fine("Deleted " + cntd);
		}
		//
		// Get PriceList Info
		//
		sql = new StringBuilder("SELECT p.C_Currency_ID  , c.StdPrecision ");
						sql.append(" , v.AD_Client_ID  , v.AD_Org_ID  , v.UpdatedBy ");
						sql.append(" , v.M_DiscountSchema_ID ");
						sql.append(" , M_PriceList_Version_Base_ID  FROM	M_PriceList p ");
						sql.append("     ,M_PriceList_Version v      ,C_Currency c ");
						sql.append(" WHERE	p.M_PriceList_ID = v.M_PriceList_ID ");
						sql.append(" AND	    p.C_Currency_ID  = c.C_Currency_ID");
						sql.append(" AND	v.M_PriceList_Version_ID = ").append(p_PriceList_Version_ID);
		
		PreparedStatement stmtCurgen = null;
		ResultSet rsCurgen = null;
		PreparedStatement stmtDiscountLine = null;
		ResultSet rsDiscountLine = null;
		CPreparedStatement stmt = null;
		PreparedStatement pstmt = null;
		try {
			stmtCurgen = DB.prepareStatement(sql.toString(), get_TrxName());
			rsCurgen = stmtCurgen.executeQuery();
			while (rsCurgen.next()) {
				//
				// For All Discount Lines in Sequence
				//
				int precision = rsCurgen.getInt("StdPrecision");
				sql = new StringBuilder("SELECT M_DiscountSchemaLine_ID");
							sql.append(",AD_Client_ID,AD_Org_ID,IsActive,Created,Createdby,Updated,Updatedby"); 
							sql.append(",M_DiscountSchema_ID,SeqNo,M_Product_Category_ID,C_Bpartner_ID,M_Product_ID");
							sql.append(",ConversionDate,List_Base,List_Addamt,List_Discount,List_Rounding,List_MinAmt");
							sql.append(",List_MaxAmt,List_Fixed,Std_Base,Std_Addamt,Std_Discount,Std_Rounding");
							sql.append(",Std_MinAmt,Std_MaxAmt,Std_Fixed,Limit_Base,Limit_AddAmt,Limit_Discount");
							sql.append(",Limit_Rounding,Limit_Minamt,Limit_MaxAmt,Limit_Fixed,Group1,Group2,C_ConversionType_ID");
							sql.append(" FROM  M_DiscountSchemaLine");
							sql.append(" WHERE M_DiscountSchema_ID=");
							sql.append(rsCurgen.getInt("M_DiscountSchema_ID"));
							sql.append(" AND IsActive='Y' ORDER BY SeqNo");
				
				stmtDiscountLine = DB.prepareStatement(sql.toString(), get_TrxName());
				rsDiscountLine = stmtDiscountLine.executeQuery();
				while (rsDiscountLine.next()) {
					//
					//Clear Temporary Table
					//
					sqldel = "DELETE FROM T_Selection WHERE AD_PInstance_ID=?";
					cntd = DB.executeUpdate(sqldel, m_AD_PInstance_ID, get_TrxName());
					if (cntd == -1)
						raiseError(" DELETE	T_Selection ", sqldel);
					totd += cntd;
					if (log.isLoggable(Level.FINE)) log.fine("Deleted " + cntd);
					//
					//Create Selection in temporary table
					//
					v_temp = rsCurgen.getInt("M_PriceList_Version_Base_ID");
					String dl_Group1 = rsDiscountLine.getString("Group1");
					String dl_Group2 = rsDiscountLine.getString("Group2");
					if (rsCurgen.wasNull()) {
						//
						//Create Selection from M_Product_PO
						//
						sqlins = new StringBuilder("INSERT INTO T_Selection (AD_PInstance_ID, T_Selection_ID) ");
								sqlins.append( " SELECT DISTINCT ").append(m_AD_PInstance_ID).append(", po.M_Product_ID ");
								sqlins.append(" FROM M_Product p, M_Product_PO po");
								sqlins.append(" WHERE p.M_Product_ID=po.M_Product_ID ");
								sqlins.append(" AND	(p.AD_Client_ID=").append(rsCurgen.getInt("AD_Client_ID")).append(" OR p.AD_Client_ID=0)");
								sqlins.append(" AND	p.IsActive='Y' AND po.IsActive='Y' AND po.IsCurrentVendor='Y' ");
								//
								//Optional Restrictions
								//
								// globalqss - detected bug, JDBC returns zero for null values
								// so we're going to use NULLIF(value, 0)
								sqlins.append(" AND (NULLIF(").append(rsDiscountLine.getInt("M_Product_Category_ID")).append(",0) IS NULL");
								sqlins.append("   OR p.M_Product_Category_ID IN (").append(getSubCategoryWhereClause(rsDiscountLine.getInt("M_Product_Category_ID")))
									  .append("))");
								if(dl_Group1 != null)
									sqlins.append(" AND (p.Group1=?)");
								if (dl_Group2 != null)
									sqlins.append(" AND (p.Group2=?)");
								sqlins.append(" AND (NULLIF(").append(rsDiscountLine.getInt("C_BPartner_ID")).append(",0) IS NULL ");
								sqlins.append("   OR po.C_BPartner_ID=").append(rsDiscountLine.getInt("C_BPartner_ID")).append(")");
								sqlins.append(" AND (NULLIF(").append(rsDiscountLine.getInt("M_Product_ID")).append(",0) IS NULL ");
								sqlins.append("   OR p.M_Product_ID=").append(rsDiscountLine.getInt("M_Product_ID")).append(")");
						
						stmt = DB.prepareStatement(sqlins.toString(), get_TrxName());
						
						int i = 1;

						if (dl_Group1!=null)
							stmt.setString(i++, dl_Group1);
						if (dl_Group2!=null)
							stmt.setString(i++, dl_Group2);		
						
						cnti = stmt.executeUpdate();
						
						if (cnti == -1)
							raiseError(" INSERT INTO T_Selection ", sqlins.toString());
						toti += cnti;
						if (log.isLoggable(Level.FINE)) log.fine("Inserted " + cnti);

					} else {
						//
						// Create Selection from existing PriceList
						//
						sqlins = new StringBuilder("INSERT INTO T_Selection (AD_PInstance_ID, T_Selection_ID)");
								sqlins.append(" SELECT DISTINCT ").append(m_AD_PInstance_ID).append(", p.M_Product_ID");
								sqlins.append(" FROM M_Product p, M_ProductPrice pp");
								sqlins.append(" WHERE p.M_Product_ID=pp.M_Product_ID");
								sqlins.append(" AND pp.M_PriceList_Version_ID = ").append(rsCurgen.getInt("M_PriceList_Version_Base_ID"));
								sqlins.append(" AND p.IsActive='Y' AND pp.IsActive='Y'");
								//
								//Optional Restrictions
								//
								sqlins.append(" AND (NULLIF(").append(rsDiscountLine.getInt("M_Product_Category_ID")).append(",0) IS NULL");
								sqlins.append(" OR p.M_Product_Category_ID IN (").append(getSubCategoryWhereClause(rsDiscountLine.getInt("M_Product_Category_ID")))
									  .append("))");
								if(dl_Group1 != null)
									sqlins.append(" AND (p.Group1=?)");
								if (dl_Group2 != null)
									sqlins.append(" AND (p.Group2=?)");
								sqlins.append(" AND (NULLIF(").append(rsDiscountLine.getInt("C_BPartner_ID")).append(",0) IS NULL OR EXISTS ");
								sqlins.append("(SELECT M_Product_ID,C_Bpartner_ID,AD_Client_ID,AD_Org_ID,IsActive");
								sqlins.append(",Created,CreatedBy,Updated,Updatedby,IsCurrentVendor,C_Uom_ID");
								sqlins.append(",C_Currency_ID,PriceList,PricePo,PriceEffective,PriceLastPo");
								sqlins.append(",PriceLastInv,VendorProductno,Upc,VendorCategory,Discontinued");
								sqlins.append(",Discontinuedby,Order_Min,Order_Pack,CostPerOrder");
								sqlins.append(",DeliveryTime_Promised,DeliveryTime_Actual,QualityRating");
								sqlins.append(",RoyaltyAmt,Group1,Group2");
								sqlins.append(",Manufacturer FROM M_Product_PO po WHERE po.M_Product_ID=p.M_Product_ID");
								sqlins.append(" AND po.C_BPartner_ID=").append(rsDiscountLine.getInt("C_BPartner_ID")).append("))"); 
								sqlins.append(" AND	(NULLIF(").append(rsDiscountLine.getInt("M_Product_ID")).append(",0) IS NULL ");
								sqlins.append("   OR p.M_Product_ID=").append(rsDiscountLine.getInt("M_Product_ID")).append(")");
						
						
						stmt = DB.prepareStatement(sqlins.toString(), get_TrxName());
						int i = 1;
						
						if (dl_Group1!=null)
							stmt.setString(i++, dl_Group1);
						if (dl_Group2!=null)
							stmt.setString(i++, dl_Group2);		
						
						cnti = stmt.executeUpdate();
						if (cnti == -1)
							raiseError(
									" INSERT INTO T_Selection from existing PriceList",
									sqlins.toString());
						toti += cnti;
						if (log.isLoggable(Level.FINE)) log.fine("Inserted " + cnti);

					}

					message.append("@Selected@=").append(cnti);

					//
					//Delete Prices in Selection, so that we can insert
					//
					v_temp = rsCurgen.getInt("M_PriceList_Version_Base_ID");
					if (rsCurgen.wasNull() || v_temp != p_PriceList_Version_ID) {

						sqldel = "DELETE FROM M_ProductPrice pp WHERE pp.M_PriceList_Version_ID=? AND EXISTS (SELECT t_selection_id FROM T_Selection s WHERE pp.M_Product_ID=s.T_Selection_ID AND s.AD_PInstance_ID=?)";
						cntd = DB.executeUpdate(sqldel, new Object[]{p_PriceList_Version_ID, m_AD_PInstance_ID}, false, get_TrxName());
						if (cntd == -1)
							raiseError(" DELETE	M_ProductPrice ", sqldel);
						totd += cntd;
						message.append(", @Deleted@=").append(cntd);
						if (log.isLoggable(Level.FINE)) log.fine("Deleted " + cntd);
					}

					//
					//	Copy (Insert) Prices
					//
					v_temp = rsCurgen.getInt("M_PriceList_Version_Base_ID");
					int seqproductpriceid = MSequence.get(getCtx(), "M_ProductPrice").get_ID();
					int currentUserID = Env.getAD_User_ID(getCtx());
					if (v_temp == p_PriceList_Version_ID)
						//
						// We have Prices already
						//
						;
					else if (rsCurgen.wasNull())
					//			
					//Copy and Convert from Product_PO
					//	
					{
						sqlins = new StringBuilder("INSERT INTO M_ProductPrice ");
									sqlins.append("(M_ProductPrice_ID");
									sqlins.append(" ,M_ProductPrice_UU");
									sqlins.append(" ,M_PriceList_Version_ID");
									sqlins.append(" ,M_Product_ID ");
									sqlins.append(" ,AD_Client_ID");
									sqlins.append(" , AD_Org_ID");
									sqlins.append(" , IsActive");
									sqlins.append(" , Created");
									sqlins.append(" , CreatedBy");
									sqlins.append(" , Updated");
									sqlins.append(" , UpdatedBy");
									sqlins.append(" , PriceList");
									sqlins.append(" , PriceStd");
									sqlins.append(" , PriceLimit) ");
									sqlins.append("SELECT ");
									sqlins.append("      nextIdFunc(").append(seqproductpriceid).append(",'N')");
									sqlins.append("      , generate_uuid(),");
									sqlins.append(p_PriceList_Version_ID);
									sqlins.append("      ,po.M_Product_ID ");
									sqlins.append("      ,");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
									sqlins.append("      ,");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append("      ,'Y'");
									sqlins.append("      ,getDate(),");
									sqlins.append(currentUserID); 
									sqlins.append("      ,getDate(),");
									sqlins.append(currentUserID);
									//
									//Price List
									//
									sqlins.append(" ,COALESCE(currencyConvert(po.PriceList, po.C_Currency_ID, ");
									sqlins.append(rsCurgen.getInt("C_Currency_ID"));
									sqlins.append(",  ? , ");
									sqlins.append(rsDiscountLine.getInt("C_ConversionType_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append("),0)");
																
									//	Price Std
									sqlins.append(" ,COALESCE(currencyConvert(po.PriceList, po.C_Currency_ID, ");
									sqlins.append(rsCurgen.getInt("C_Currency_ID"));
									sqlins.append(", ? , ");
									sqlins.append(rsDiscountLine.getInt("C_ConversionType_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
			                        sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append("),0)");
									
									//	Price Limit
									sqlins.append(" ,COALESCE(currencyConvert(po.PricePO ,po.C_Currency_ID, ");
									sqlins.append(rsCurgen.getInt("C_Currency_ID"));
									sqlins.append(",? , ");
									sqlins.append(rsDiscountLine.getInt("C_ConversionType_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append("),0)");
									sqlins.append(" FROM	M_Product_PO po ");
									sqlins.append(" WHERE EXISTS (SELECT * FROM T_Selection s WHERE po.M_Product_ID=s.T_Selection_ID"); 
										sqlins.append(" AND s.AD_PInstance_ID=").append(m_AD_PInstance_ID).append(") ");
									sqlins.append(" AND	po.IsCurrentVendor='Y' AND po.IsActive='Y'");

						pstmt = DB.prepareStatement(sqlins.toString(),
								ResultSet.TYPE_SCROLL_INSENSITIVE,
								ResultSet.CONCUR_UPDATABLE, get_TrxName());
						pstmt.setTimestamp(1, rsDiscountLine.getTimestamp("ConversionDate"));
						pstmt.setTimestamp(2, rsDiscountLine.getTimestamp("ConversionDate"));
						pstmt.setTimestamp(3, rsDiscountLine.getTimestamp("ConversionDate"));

						cnti = pstmt.executeUpdate();
						if (cnti == -1)
							raiseError(
									" INSERT INTO T_Selection from existing PriceList",
									sqlins.toString());
						toti += cnti;
						if (log.isLoggable(Level.FINE)) log.fine("Inserted " + cnti);

						String sqlconversion = "SELECT p.M_Product_ID,po.C_Uom_ID,pp.PriceList"
								+ " FROM M_Product p"
								+ " INNER JOIN M_ProductPrice pp on (p.M_Product_ID=pp.M_Product_ID)"
								+ " INNER JOIN M_Product_PO po on (po.M_Product_ID=p.M_Product_ID)"
								+ " INNER JOIN C_Uom_Conversion uc on (p.M_Product_ID=uc.M_Product_ID)"
								+ " INNER JOIN T_Selection s on (s.T_Selection_ID=po.M_Product_ID)"
								+ " WHERE pp.M_PriceList_Version_ID=?"
								+ " AND po.C_Uom_ID<> p.C_Uom_ID"
								+ " AND s.AD_PInstance_ID=?";
						PreparedStatement pstmtconversion = null;
						ResultSet rsconversion = null;
						BigDecimal price = Env.ZERO;
						int product_id = 0;
						MUOMConversion conversion = null;
						try {
							pstmtconversion = DB.prepareStatement(sqlconversion.toString(), get_TrxName());
							pstmtconversion.setInt(1, p_PriceList_Version_ID);
							pstmtconversion.setInt(2, m_AD_PInstance_ID);

							rsconversion = pstmtconversion.executeQuery();
							while (rsconversion != null && rsconversion.next())
							{
								product_id = rsconversion.getInt(1);
								MUOMConversion[] conversions = MUOMConversion.getProductConversions(getCtx(), product_id);
								for (int i = 0; i < conversions.length; i++)
								{
									if (conversions[i].getC_UOM_To_ID() == rsconversion.getInt(2))
									{
										conversion = conversions[i];
										price = rsconversion.getBigDecimal(3);
									}
								}
							}
							if (conversion != null)
							{
								price = price.divide(conversion.getDivideRate(), precision, RoundingMode.HALF_DOWN);
								StringBuilder sqlupdate = new StringBuilder();
								sqlupdate.append("UPDATE M_ProductPrice SET PriceList=").append(price).append(" WHERE M_PriceList_Version_ID=").append(p_PriceList_Version_ID)
									.append(" AND M_Product_ID= ").append(product_id);
								int count = DB.executeUpdate(sqlupdate.toString(),get_TrxName());
								if (count == -1) {
									raiseError(
											" UPDATE M_ProductPrice set PriceList=? ",
											sqlupdate.toString());
								}
							}
						} catch (Exception e) {
							throw e;
						} finally {
							DB.close(rsconversion, pstmtconversion);
						}
					} else {
						//
						//Copy and Convert from other PriceList_Version
						//
						sqlins = new StringBuilder("INSERT INTO M_ProductPrice ");					
									sqlins.append(" (M_ProductPrice_ID, M_ProductPrice_UU, M_PriceList_Version_ID, M_Product_ID,");
									sqlins.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,");
									sqlins.append(" PriceList, PriceStd, PriceLimit)");
									sqlins.append(" SELECT ");
									sqlins.append("nextIdFunc(").append(seqproductpriceid).append(",'N')");
									sqlins.append(", generate_uuid(),");
									sqlins.append(p_PriceList_Version_ID);
									sqlins.append(", pp.M_Product_ID,");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append(", 'Y', getDate(),  ");
									sqlins.append(currentUserID);
									sqlins.append(", getDate(), ");
									sqlins.append(currentUserID);
									sqlins.append(" ,");
									// Price List
									sqlins.append("COALESCE(currencyConvert(pp.PriceList, pl.C_Currency_ID, ");
									sqlins.append(rsCurgen.getInt("C_Currency_ID"));
									sqlins.append(", ?, ");
									sqlins.append(rsDiscountLine.getInt("C_ConversionType_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append("),0),");
									// Price Std
									sqlins.append("COALESCE(currencyConvert(pp.PriceStd,pl.C_Currency_ID, ");
									sqlins.append(rsCurgen.getInt("C_Currency_ID"));
									sqlins.append(" , ? ,  ");
									sqlins.append(rsDiscountLine.getInt("C_ConversionType_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append("),0),");
									//Price Limit						   
									sqlins.append(" COALESCE(currencyConvert(pp.PriceLimit,pl.C_Currency_ID, ");
									sqlins.append(rsCurgen.getInt("C_Currency_ID"));
									sqlins.append(" , ? , ");
									sqlins.append(rsDiscountLine.getInt("C_ConversionType_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Client_ID"));
									sqlins.append(", ");
									sqlins.append(rsCurgen.getInt("AD_Org_ID"));
									sqlins.append("),0)");
									sqlins.append(" FROM M_ProductPrice pp");
									sqlins.append(" INNER JOIN M_PriceList_Version plv ON (pp.M_PriceList_Version_ID=plv.M_PriceList_Version_ID)");
									sqlins.append(" INNER JOIN M_PriceList pl ON (plv.M_PriceList_ID=pl.M_PriceList_ID)");
									sqlins.append(" WHERE	pp.M_PriceList_Version_ID=");
									sqlins.append(rsCurgen.getInt("M_PriceList_Version_Base_ID"));
									sqlins.append(" AND EXISTS (SELECT * FROM T_Selection s WHERE pp.M_Product_ID=s.T_Selection_ID"); 
										sqlins.append(" AND s.AD_PInstance_ID=").append(m_AD_PInstance_ID).append(")");
									sqlins.append(" AND	pp.IsActive='Y'");

						pstmt = DB.prepareStatement(sqlins.toString(),
								ResultSet.TYPE_SCROLL_INSENSITIVE,
								ResultSet.CONCUR_UPDATABLE, get_TrxName());
						pstmt.setTimestamp(1, rsDiscountLine.getTimestamp("ConversionDate"));
						pstmt.setTimestamp(2, rsDiscountLine.getTimestamp("ConversionDate"));
						pstmt.setTimestamp(3, rsDiscountLine.getTimestamp("ConversionDate"));

						cnti = pstmt.executeUpdate();

						if (cnti == -1)
							raiseError(
									" INSERT INTO T_Selection from existing PriceList",
									sqlins.toString());
						toti += cnti;
						if (log.isLoggable(Level.FINE)) log.fine("Inserted " + cnti);

					}
					message.append(", @Inserted@=").append(cnti);
					//
					// Calculation
					//
					sqlupd = new StringBuilder("UPDATE M_ProductPrice p ");
								 sqlupd.append(" SET	PriceList = (DECODE( '");
								 sqlupd.append(rsDiscountLine.getString("List_Base"));
								 sqlupd.append("', 'S', PriceStd, 'X', PriceLimit, PriceList)");
								 sqlupd.append(" + ?) * (1 - ?/100), PriceStd = (DECODE('");
								 sqlupd.append(rsDiscountLine.getString("Std_Base"));
								 sqlupd.append("', 'L', PriceList, 'X', PriceLimit, PriceStd) ");
								 sqlupd.append(" + ?) * (1 - ?/100), ").append(" PriceLimit = (DECODE('");
								 sqlupd.append(rsDiscountLine.getString("Limit_Base"));
								 sqlupd.append("', 'L', PriceList, 'S', PriceStd, PriceLimit) ");
								 sqlupd.append(" + ?) * (1 - ? /100) ");
								 sqlupd.append(" WHERE	M_PriceList_Version_ID = ");
								 sqlupd.append(p_PriceList_Version_ID);
								 sqlupd.append(" AND EXISTS	(SELECT * FROM T_Selection s ");
								 sqlupd.append(" WHERE s.T_Selection_ID = p.M_Product_ID");
								 sqlupd.append(" AND s.AD_PInstance_ID=").append(m_AD_PInstance_ID).append(")");
					
					PreparedStatement pstmu = DB.prepareStatement(sqlupd.toString(),
							ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CONCUR_UPDATABLE, get_TrxName());

					pstmu.setDouble(1, rsDiscountLine.getDouble("List_AddAmt"));
					pstmu.setDouble(2, rsDiscountLine.getDouble("List_Discount"));
					pstmu.setDouble(3, rsDiscountLine.getDouble("Std_AddAmt"));
					pstmu.setDouble(4, rsDiscountLine.getDouble("Std_Discount"));
					pstmu.setDouble(5, rsDiscountLine.getDouble("Limit_AddAmt"));
					pstmu.setDouble(6, rsDiscountLine.getDouble("Limit_Discount"));

					cntu = pstmu.executeUpdate();

					if (cntu == -1)
						raiseError("Update  M_ProductPrice ", sqlupd.toString());
					totu += cntu;
					if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);
					
					/**
					 * Product Cost overwrite
					 * Elaine 2009/12/24
					 */
					if(rsDiscountLine.getString(MDiscountSchemaLine.COLUMNNAME_List_Base).equals(MDiscountSchemaLine.LIST_BASE_ProductCost) || 
							rsDiscountLine.getString(MDiscountSchemaLine.COLUMNNAME_Std_Base).equals(MDiscountSchemaLine.STD_BASE_ProductCost) || 
							rsDiscountLine.getString(MDiscountSchemaLine.COLUMNNAME_Limit_Base).equals(MDiscountSchemaLine.LIMIT_BASE_ProductCost))
					{
						MClientInfo m_clientInfo = MClientInfo.get(getCtx(), rsCurgen.getInt("AD_Client_ID"), get_TrxName());
						MAcctSchema as = new MAcctSchema(getCtx(), m_clientInfo.getC_AcctSchema1_ID(), get_TrxName());
						
						StringBuilder sqlpc = new StringBuilder("SELECT p.M_Product_ID ");
						sqlpc.append(" FROM M_ProductPrice p");
						sqlpc.append(" WHERE M_PriceList_Version_ID=").append(p_PriceList_Version_ID);
						sqlpc.append(" AND EXISTS (SELECT * FROM T_Selection s");
						sqlpc.append(" WHERE s.T_Selection_ID=p.M_Product_ID");
						sqlpc.append(" AND s.AD_PInstance_ID=").append(m_AD_PInstance_ID + ")");
						
						PreparedStatement ps = null;
						ResultSet rs = null;
						
						try{
							ps = DB.prepareStatement(sqlpc.toString(), get_TrxName());
							rs = ps.executeQuery();
							while(rs.next()) 
							{
								int M_Product_ID = rs.getInt(MProductPrice.COLUMNNAME_M_Product_ID);
								ProductCost m_productCost = new ProductCost (getCtx(), M_Product_ID, 0, get_TrxName());
								m_productCost.setQty(BigDecimal.ONE);
								BigDecimal costs = m_productCost.getProductCosts(as, rsCurgen.getInt("AD_Org_ID"), null, 0, false);	
								
								if (costs == null || costs.signum() == 0)	//	zero costs OK
								{
									MProduct product = new MProduct(getCtx(), M_Product_ID, get_TrxName());
									if (product.isStocked())
										log.log(Level.WARNING, "No Costs for " + product.getName());
								}
								else
								{
									sqlupd = new StringBuilder("UPDATE M_ProductPrice p ");
									sqlupd.append(" SET	PriceList  = (DECODE('").append(rsDiscountLine.getString(MDiscountSchemaLine.COLUMNNAME_List_Base)).append("', 'P', ?, PriceList) + ?) * (1 - ?/100), ");
									sqlupd.append("     PriceStd   = (DECODE('").append(rsDiscountLine.getString(MDiscountSchemaLine.COLUMNNAME_Std_Base)).append("', 'P', ?, PriceStd) + ?) * (1 - ?/100),");
									sqlupd.append("     PriceLimit = (DECODE('").append(rsDiscountLine.getString(MDiscountSchemaLine.COLUMNNAME_Limit_Base)).append("', 'P', ?, PriceLimit) + ?) * (1 - ?/100)");
									sqlupd.append(" WHERE	M_PriceList_Version_ID=").append(p_PriceList_Version_ID); 
									sqlupd.append(" AND M_Product_ID = ?");
									sqlupd.append(" AND EXISTS	(SELECT * FROM T_Selection s");
									sqlupd.append(" WHERE s.T_Selection_ID=p.M_Product_ID");
									sqlupd.append(" AND s.AD_PInstance_ID=").append(m_AD_PInstance_ID + ")");
									
									pstmu = DB.prepareStatement(sqlupd.toString(),
											ResultSet.TYPE_SCROLL_INSENSITIVE,
											ResultSet.CONCUR_UPDATABLE, get_TrxName());
	
									pstmu.setBigDecimal(1, costs);
									pstmu.setDouble(2, rsDiscountLine.getDouble(MDiscountSchemaLine.COLUMNNAME_List_AddAmt));
									pstmu.setDouble(3, rsDiscountLine.getDouble(MDiscountSchemaLine.COLUMNNAME_List_Discount));
									pstmu.setBigDecimal(4, costs);
									pstmu.setDouble(5, rsDiscountLine.getDouble(MDiscountSchemaLine.COLUMNNAME_Std_AddAmt));
									pstmu.setDouble(6, rsDiscountLine.getDouble(MDiscountSchemaLine.COLUMNNAME_Std_Discount));
									pstmu.setBigDecimal(7, costs);
									pstmu.setDouble(8, rsDiscountLine.getDouble(MDiscountSchemaLine.COLUMNNAME_Limit_AddAmt));
									pstmu.setDouble(9, rsDiscountLine.getDouble(MDiscountSchemaLine.COLUMNNAME_Limit_Discount));
									pstmu.setInt(10, M_Product_ID);
	
									cntu = pstmu.executeUpdate();
	
									if (cntu == -1)
										raiseError("Update	M_ProductPrice ", sqlupd.toString());
									if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);
								}
							}
						} catch (SQLException e) {
							throw e;
						} finally {
							DB.close(rs, ps);
							rs = null; ps = null;
						}
					}

					//
					//Rounding	(AD_Reference_ID=155)
					//
					sqlupd = new StringBuilder("UPDATE	M_ProductPrice p ");
								 sqlupd.append(" SET PriceList = DECODE('");
								 sqlupd.append(rsDiscountLine.getString("List_Rounding")).append("',");
								 sqlupd.append(" 'N', PriceList, ");
								 sqlupd.append(" '0', ROUND(PriceList, 0),"); //Even .00
								 sqlupd.append(" 'D', ROUND(PriceList, 1),"); //Dime .10
								 sqlupd.append(" 'T', ROUND(PriceList, -1), "); //Ten 10.00
								 sqlupd.append(" '5', ROUND(PriceList*20,0)/20,"); //Nickle .05
								 sqlupd.append(" 'Q', ROUND(PriceList*4,0)/4,"); //Quarter .25
								 sqlupd.append(" '9', CASE"); //Whole 9 or 5
								 	sqlupd.append(" WHEN MOD(ROUND(PriceList),10)<=5 THEN ROUND(PriceList)+(5-MOD(ROUND(PriceList),10))");
								 	sqlupd.append(" WHEN MOD(ROUND(PriceList),10)>5 THEN ROUND(PriceList)+(9-MOD(ROUND(PriceList),10)) END,"); 
							 	 sqlupd.append(" ROUND(PriceList, ").append(precision);
							 	 sqlupd.append(")),");//Currency
							 	 sqlupd.append(" PriceStd = DECODE('").append(rsDiscountLine.getString("Std_Rounding"));
							 	 sqlupd.append("',").append(" 'N', PriceStd, ");
							 	 sqlupd.append(" '0', ROUND(PriceStd, 0), "); //Even .00
							 	 sqlupd.append(" 'D', ROUND(PriceStd, 1), "); //Dime .10
							 	 sqlupd.append("'T', ROUND(PriceStd, -1),"); //Ten 10.00)
							 	 sqlupd.append("'5', ROUND(PriceStd*20,0)/20,"); //Nickle .05
							 	 sqlupd.append("'Q', ROUND(PriceStd*4,0)/4,"); //Quarter .25
							 	 sqlupd.append(" '9', CASE");  //Whole 9 or 5
							 	 	sqlupd.append(" WHEN MOD(ROUND(PriceStd),10)<=5 THEN ROUND(PriceStd)+(5-MOD(ROUND(PriceStd),10))");
							 	 	sqlupd.append(" WHEN MOD(ROUND(PriceStd),10)>5 THEN ROUND(PriceStd)+(9-MOD(ROUND(PriceStd),10)) END,");
						 	 	 sqlupd.append("ROUND(PriceStd, ").append(precision).append(")),"); //Currency
						 	 	 sqlupd.append("PriceLimit = DECODE('");	
						 	 	 sqlupd.append(rsDiscountLine.getString("Limit_Rounding")).append("', ");
						 	 	 sqlupd.append(" 		'N', PriceLimit, ");
						 	 	 sqlupd.append(" 	'0', ROUND(PriceLimit, 0),	"); //	Even .00
						 	 	 sqlupd.append("	'D', ROUND(PriceLimit, 1),	"); //	Dime .10
						 	 	 sqlupd.append("	'T', ROUND(PriceLimit, -1),	"); //	Ten 10.00
						 	 	 sqlupd.append("	'5', ROUND(PriceLimit*20,0)/20,	"); //	Nickle .05
						 	 	 sqlupd.append("	'Q', ROUND(PriceLimit*4,0)/4,		"); //Quarter .25
						 	 	 sqlupd.append("    '9', CASE");  //Whole 9 or 5
						 	 	 	sqlupd.append(" WHEN MOD(ROUND(PriceLimit),10)<=5 THEN ROUND(PriceLimit)+(5-MOD(ROUND(PriceLimit),10))");
						 	 	 	sqlupd.append(" WHEN MOD(ROUND(PriceLimit),10)>5 THEN ROUND(PriceLimit)+(9-MOD(ROUND(PriceLimit),10)) END,");
					 	 	 	sqlupd.append("		ROUND(PriceLimit, ").append(precision);
					 	 	 	sqlupd.append(")) "); //	Currency
					 	 	 	sqlupd.append(" WHERE	M_PriceList_Version_ID=");
					 	 	 	sqlupd.append(p_PriceList_Version_ID);
					 	 	 	sqlupd.append(" AND EXISTS	(SELECT * FROM T_Selection s ");
					 	 	 	sqlupd.append(" WHERE s.T_Selection_ID=p.M_Product_ID");
					 	 	 	sqlupd.append(" AND s.AD_PInstance_ID=").append(m_AD_PInstance_ID).append(")");	
						
					cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
					if (cntu == -1)
						raiseError("Update  M_ProductPrice ", sqlupd.toString());
					totu += cntu;
					if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);

					message.append(", @Updated@=").append(cntu);
					//
					//Fixed Price overwrite
					//
					 sqlupd = new StringBuilder("UPDATE	M_ProductPrice p ");
								  sqlupd.append(" SET	PriceList  = DECODE('");
								  sqlupd.append(rsDiscountLine.getString("List_Base")).append("', 'F', ");
								  sqlupd.append(rsDiscountLine.getDouble("List_Fixed")).append(", PriceList), ");
								  sqlupd.append("      PriceStd   = DECODE('");
								  sqlupd.append(rsDiscountLine.getString("Std_Base")).append("', 'F', ");
								  sqlupd.append(rsDiscountLine.getDouble("Std_Fixed")).append(", PriceStd),");
								  sqlupd.append("      PriceLimit = DECODE('");
								  sqlupd.append(rsDiscountLine.getString("Limit_Base")).append("', 'F', ");
								  sqlupd.append(rsDiscountLine.getDouble("Limit_Fixed")).append(", PriceLimit)");
								  sqlupd.append(" WHERE	 M_PriceList_Version_ID=");
								  sqlupd.append(p_PriceList_Version_ID);
								  sqlupd.append(" AND EXISTS (SELECT * FROM T_Selection s");
								  sqlupd.append(" WHERE s.T_Selection_ID=p.M_Product_ID");
								  sqlupd.append(" AND s.AD_PInstance_ID=").append(m_AD_PInstance_ID).append(")");
								  
					cntu = DB.executeUpdate(sqlupd.toString(), get_TrxName());
					if (cntu == -1)
						raiseError("Update  M_ProductPrice ", sqlupd.toString());
					totu += cntu;
					if (log.isLoggable(Level.FINE)) log.fine("Updated " + cntu);

					v_NextNo = v_NextNo + 1;
					addLog(0, null, null, message.toString());
					message = new StringBuilder();
				}
				//
				//	Delete Temporary Selection
				//
				sqldel = "DELETE FROM T_Selection WHERE AD_PInstance_ID=?";
				cntd = DB.executeUpdate(sqldel, m_AD_PInstance_ID, get_TrxName());
				if (cntd == -1)
					raiseError(" DELETE	T_Selection ", sqldel);
				totd += cntd;
				if (log.isLoggable(Level.FINE)) log.fine("Deleted " + cntd);
				
				//
				//commit;
				//
				// log.fine("Committing ...");
				// DB.commit(true, get_TrxName());

			}
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(rsCurgen, stmtCurgen);
			rsCurgen = null; stmtCurgen = null;
			DB.close(rsDiscountLine, stmtDiscountLine);
			rsDiscountLine = null; stmtDiscountLine = null;
			DB.close(stmt);
			stmt = null;
			DB.close(pstmt);
			pstmt = null;
		}

		return "OK";

	} // del doIt

	private void raiseError(String string, String sql) throws Exception {
		
		// DB.rollback(false, get_TrxName());
		StringBuilder msg = new StringBuilder(string);
		ValueNamePair pp = CLogger.retrieveError();
		if (pp != null)
			msg = new StringBuilder(pp.getName()).append(" - ");
		msg.append(sql);
		throw new AdempiereUserError(msg.toString());
	}
	
	/**
	 * Returns a sql where string with the given category id and all of its subcategory ids.
	 * It is used as restriction in MQuery.
	 * @param productCategoryId
	 * @return
	 * @throws  
	 */
	private String getSubCategoryWhereClause(int productCategoryId) throws SQLException, AdempiereSystemError {
		//if a node with this id is found later in the search we have a loop in the tree
		int subTreeRootParentId = 0;
		StringBuilder retString = new StringBuilder();
		String sql = " SELECT M_Product_Category_ID, M_Product_Category_Parent_ID FROM M_Product_Category";
		final Vector<SimpleTreeNode> categories = new Vector<SimpleTreeNode>(100);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if(rs.getInt(1)==productCategoryId) {
					subTreeRootParentId = rs.getInt(2);
				}
				categories.add(new SimpleTreeNode(rs.getInt(1), rs.getInt(2)));
			}
			retString.append(getSubCategoriesString(productCategoryId, categories, subTreeRootParentId));
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(rs, stmt);
			rs = null; stmt = null;
		}
		return retString.toString();
	}

	/**
	 * Recursive search for subcategories with loop detection.
	 * @param productCategoryId
	 * @param categories
	 * @param loopIndicatorId
	 * @return comma separated list of category ids
	 * @throws AdempiereSystemError if a loop is detected
	 */
	private String getSubCategoriesString(int productCategoryId, Vector<SimpleTreeNode> categories, int loopIndicatorId) throws AdempiereSystemError {
		StringBuilder ret = new StringBuilder();
		final Iterator<SimpleTreeNode> iter = categories.iterator();
		while (iter.hasNext()) {
			SimpleTreeNode node = iter.next();
			if (node.getParentId() == productCategoryId) {
				if (node.getNodeId() == loopIndicatorId) {
					throw new AdempiereSystemError("The product category tree contains a loop on categoryId: " + loopIndicatorId);
				}
				ret.append(getSubCategoriesString(node.getNodeId(), categories, loopIndicatorId));
				ret.append(",");
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine(ret.toString());
		return ret.toString() + productCategoryId;
	}

	/**
	 * Simple tree node class for product category tree search.
	 * @author Karsten Thiemann, kthiemann@adempiere.org
	 *
	 */
	private static class SimpleTreeNode {

		private int nodeId;

		private int parentId;

		public SimpleTreeNode(int nodeId, int parentId) {
			this.nodeId = nodeId;
			this.parentId = parentId;
		}

		public int getNodeId() {
			return nodeId;
		}

		public int getParentId() {
			return parentId;
		}
	}

 

} // M_PriceList_Create