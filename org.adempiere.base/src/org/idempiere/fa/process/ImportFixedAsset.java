package org.idempiere.fa.process;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MAsset;
import org.compiere.model.MAssetAcct;
import org.compiere.model.MAssetAddition;
import org.compiere.model.MAssetGroupAcct;
import org.compiere.model.MDepreciationWorkfile;
import org.compiere.model.MIFixedAsset;
import org.compiere.model.POResultSet;
import org.compiere.model.Query;
import org.compiere.model.X_I_FixedAsset;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;


/**
 *	Import Fixed Asset
 *
 * 	@author 	Zuhri Utama, Ambidexter [based on ImportAssetClass Teo Sarca]
 * 
 * 	@version 	$Id$
 */
@org.adempiere.base.annotation.Process
public class ImportFixedAsset extends SvrProcess
{
	/**	Client to be imported to		*/
	private int				p_AD_Client_ID = 0;
	/**	Organization to be imported to	*/
	private int				p_AD_Org_ID = 0;

	/** Account Date					*/
	private Timestamp		p_DateAcct = null;

	/** Validate Only - only validate import data */
	private boolean			p_IsValidateOnly = false;
	
	/**	Delete old Imported				*/
	private boolean			p_DeleteOldImported = true;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Client_ID"))
				p_AD_Client_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("AD_Org_ID"))
				p_AD_Org_ID = ((BigDecimal)para[i].getParameter()).intValue();

			else if (name.equals("DateAcct"))
				p_DateAcct = ((Timestamp)para[i].getParameter());
			else if (name.equals("DeleteOldImported"))
				p_DeleteOldImported = "Y".equals(para[i].getParameter());
			else if (name.equals("IsValidateOnly"))
				p_IsValidateOnly = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare


	/**
	 *  Perrform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws java.lang.Exception
	{
		StringBuilder sql = null;
		int no = 0;
		if(p_AD_Client_ID==0)
			p_AD_Client_ID = Env.getAD_Client_ID(getCtx());
		String sqlCheck = " AND AD_Client_ID=" + p_AD_Client_ID;

		//	****	Prepare	****

		//	Delete Old Imported
		if (p_DeleteOldImported)
		{
			sql = new StringBuilder ("DELETE FROM "+X_I_FixedAsset.Table_Name
				  + " WHERE I_IsImported='Y'").append (sqlCheck);
			no = DB.executeUpdateEx(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Delete Old Imported =" + no);
		}
		
		//	Set Client, Org, IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+ " "
			  + "SET AD_Client_ID = COALESCE (AD_Client_ID,").append (p_AD_Client_ID).append ("),"
			  + " AD_Org_ID = COALESCE (AD_Org_ID,").append (p_AD_Org_ID).append ("),"
			  + " IsActive = COALESCE (IsActive, 'Y'),"
			  + " Created = COALESCE (Created, getDate()),"
			  + " CreatedBy = COALESCE (CreatedBy, 0),"
			  + " Updated = COALESCE (Updated, getDate()),"
			  + " UpdatedBy = COALESCE (UpdatedBy, 0),"
			  + " I_ErrorMsg = ' ',"
			  + " I_IsImported = 'N' "
			  + "WHERE I_IsImported<>'Y' OR I_IsImported IS NULL");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.INFO)) log.info ("Reset=" + no);
		
		// Check if Org is Null or 0
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			+ "SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Org, '"
			+ "WHERE (AD_Org_ID IS NULL OR AD_Org_ID=0"
			+ " OR EXISTS (SELECT * FROM AD_Org oo WHERE ifa.AD_Org_ID=oo.AD_Org_ID AND (oo.IsSummary='Y' OR oo.IsActive='N')))"
			+ " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Org=" + no);
		
		// Check if Name is Null
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			+ "SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Name Is Mandatory, '"
			+ "WHERE Name IS NULL AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Name=" + no);
		
		// Asset Group From Value
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			  + "SET A_Asset_Group_ID=(SELECT MAX(A_Asset_Group_ID) FROM A_Asset_Group t"
			  + " WHERE ifa.A_Asset_Group_Value=t.Name AND ifa.AD_Client_ID=t.AD_Client_ID) "
			  + "WHERE A_Asset_Group_ID IS NULL AND A_Asset_Group_Value IS NOT NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set Asset Group from Value=" + no);
		
		// Check if Asset Group Have Asset Group Acct Record
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			+ "SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Asset Group Doesnt Have Asset Group Acct Record, ' "
			+ "WHERE A_Asset_Group_ID IS NOT NULL AND A_Asset_Group_ID>0 " //@win change to AND from OR
			+ "AND NOT EXISTS (SELECT 1 FROM A_Asset_Group_Acct aga WHERE ifa.A_Asset_Group_ID=aga.A_Asset_Group_ID) " //@win change to AND from OR
			+ "AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Asset Group=" + no);
		
		// Asset Type From Value
		/* commented by @win
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			  + "SET A_Asset_Type_ID=(SELECT MAX(A_Asset_Type_ID) FROM A_Asset_Type t"
			  + " WHERE ifa.A_Asset_Type_Value=t.Value AND ifa.AD_Client_ID=t.AD_Client_ID) "
			  + "WHERE A_Asset_Type_ID IS NULL AND A_Asset_Type_Value IS NOT NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.fine("Set Asset Type from Value=" + no);
		*/
		
		// BP From Value
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			  + "SET C_BPartnerSR_ID=(SELECT MAX(C_BPartner_ID) FROM C_BPartner t"
			  + " WHERE ifa.BPartner_Value=t.Value AND ifa.AD_Client_ID=t.AD_Client_ID) "
			  + "WHERE C_BPartnerSR_ID IS NULL AND BPartner_Value IS NOT NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set BP from Value=" + no);
		
		// City From Value
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			  + "SET C_City_ID=(SELECT MAX(C_City_ID) FROM C_City t"
			  + " WHERE ifa.C_City_Value=t.Name AND ifa.AD_Client_ID=t.AD_Client_ID) "
			  + "WHERE C_City_ID IS NULL AND C_City_Value IS NOT NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set City from Value=" + no);
		
		// Product 
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			  + "SET M_Product_ID=(SELECT MAX(M_Product_ID) FROM M_Product t"
			  + " WHERE ifa.ProductValue=t.Value AND ifa.AD_Client_ID=t.AD_Client_ID) "
			  + "WHERE M_Product_ID IS NULL AND ProductValue IS NOT NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set Product from Value=" + no);
		
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			  + "SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Product, ' "
			  + "WHERE M_Product_ID IS NULL AND ProductValue IS NOT NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Product=" + no);
		
		// Check if Product using Product Category has A Asset Category Set
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			+ "SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Product Using Product Category Without Asset Group Defined, ' "
			+ "WHERE EXISTS (SELECT 1 FROM M_Product p "
			+ "JOIN M_Product_Category pc ON p.M_Product_Category_ID=pc.M_Product_Category_ID "
			+ "WHERE ifa.M_Product_ID=p.M_Product_ID "
			+ "AND (pc.A_Asset_Group_ID=0 OR pc.A_Asset_Group_ID IS NULL)) "
			+ "AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Product Category=" + no);
				
		// Locator From Value
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa "
			  + "SET M_Locator_ID=(SELECT MAX(M_Locator_ID) FROM M_Product t"
			  + " WHERE ifa.LocatorValue=t.Value AND ifa.AD_Client_ID=t.AD_Client_ID) "
			  + "WHERE M_Locator_ID IS NULL AND LocatorValue IS NOT NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set Locator from Value=" + no);
		
		//	Currency From ISO Code
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET C_Currency_ID=(SELECT c.C_Currency_ID FROM C_Currency c")
			.append(" WHERE c.ISO_Code=ifa.ISO_Code AND c.AD_Client_ID IN (0,ifa.AD_Client_ID)) ")
			.append("WHERE C_Currency_ID IS NULL AND ISO_Code IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set Currency from ISO=" + no);
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET C_Currency_ID=(SELECT a.C_Currency_ID FROM C_AcctSchema a")
			.append(" WHERE a.C_AcctSchema_ID=ifa.C_AcctSchema_ID AND a.AD_Client_ID=ifa.AD_Client_ID)")
			.append("WHERE C_Currency_ID IS NULL AND ISO_Code IS NULL")
			.append(" AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set Default Currency=" + no);
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Currency, '")
			.append("WHERE (C_Currency_ID IS NULL OR C_Currency_ID=0)")
			.append(" AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Currency=" + no);
			
		//	AcctSchema From Name
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET C_AcctSchema_ID=(SELECT a.C_AcctSchema_ID FROM C_AcctSchema a")
			.append(" WHERE ifa.AcctSchemaName=a.Name AND ifa.AD_Client_ID=a.AD_Client_ID) ")
			.append("WHERE C_AcctSchema_ID IS NULL AND AcctSchemaName IS NOT NULL")
			.append(" AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set AcctSchema from Name=" + no);
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET C_AcctSchema_ID=(SELECT c.C_AcctSchema1_ID FROM AD_ClientInfo c WHERE c.AD_Client_ID=ifa.AD_Client_ID) ")
			.append("WHERE C_AcctSchema_ID IS NULL AND AcctSchemaName IS NULL")
			.append(" AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("Set AcctSchema from Client=" + no);
		//	Error AcctSchema
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid AcctSchema, '")
			.append("WHERE (C_AcctSchema_ID IS NULL OR C_AcctSchema_ID=0")
			.append(" OR NOT EXISTS (SELECT * FROM C_AcctSchema a WHERE ifa.AD_Client_ID=a.AD_Client_ID))")
			.append(" AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid AcctSchema=" + no);
		
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=AssetServiceDate Is Mandatory, '")
			.append("WHERE AssetServiceDate IS NULL AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("No AssetServiceDate=" + no);
		
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=AssetDepreciationDate Is Mandatory, '")
			.append("WHERE AssetDepreciationDate IS NULL AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("No AssetDepreciationDate=" + no);
		
//		//	Set DateAcct (mandatory)
//		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+" ifa ")
//			.append("SET DateAcct=SysDate ")
//			.append("WHERE DateAcct IS NULL")
//			.append(" AND I_IsImported<>'Y'").append (sqlCheck);
//		no = DB.executeUpdate(sql.toString(), get_TrxName());
//		if (log.isLoggable(Level.FINE)) log.fine("Set DateAcct=" + no);
				
		//-- New BPartner ---------------------------------------------------

		//	Go through Fixed Assets Records w/o C_BPartner_ID
		/* no need this @win
		sql = new StringBuilder ("SELECT * FROM "+MIFixedAsset.Table_Name+ " 
			  + "WHERE I_IsImported='N' AND C_BPartnerSR_ID IS NULL").append (sqlCheck);
		try
		{
			PreparedStatement pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
			ResultSet rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MIFixedAsset ifa = new MIFixedAsset (getCtx(), rs, get_TrxName());
				if (ifa.getBPartner_Value () == null)
					continue;
				
				//	BPartner
				MBPartner bp = MBPartner.get (getCtx(), ifa.getBPartner_Value());
				if (bp == null)
				{
					bp = new MBPartner (getCtx (), -1, get_TrxName());
					bp.setClientOrg (ifa.getAD_Client_ID (), ifa.getAD_Org_ID ());
					bp.setValue (ifa.getBPartner_Value ());
					bp.setName (ifa.getBPartner_Value ());
					if (!bp.save ())
						continue;
				}
				ifa.setC_BPartnerSR_ID (bp.getC_BPartner_ID ());
				
				MBPartnerLocation bpl = null;
				
				if (bpl == null)
				{
					//	New Location
					MLocation loc = new MLocation (getCtx (), 0, get_TrxName());
					loc.setCity (ifa.getC_City_Value ());
					if (!loc.save ())
						continue;
					//
					bpl = new MBPartnerLocation (bp);
					bpl.setC_Location_ID (loc.getC_Location_ID());
					if (!bpl.save ())
						continue;
				}
				ifa.saveEx();
			}	//	for all new BPartners
			rs.close ();
			pstmt.close ();
			//
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "CreateBP", e);
		}
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+ " "
			  + "SET I_IsImported='N', I_ErrorMsg=I_ErrorMsg||'ERR=No BPartner, ' "
			  + "WHERE C_BPartnerSR_ID IS NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("No BPartner=" + no);
		
		commitEx();
		
		//-- New Product ---------------------------------------------------
		// TODO : zuhri Utama - need to fixed create new product

		//	Go through Fixed Assets Records w/o M_Product_ID
		sql = new StringBuilder ("SELECT * FROM "+MIFixedAsset.Table_Name+ " "
			  + "WHERE I_IsImported='N' AND M_Product_ID IS NULL").append (sqlCheck);
		try
		{
			PreparedStatement pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
			ResultSet rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MIFixedAsset ifa = new MIFixedAsset (getCtx(), rs, get_TrxName());
				if (ifa.getProductValue () == null)
					continue;
				
				//	Product
				String Value = ifa.getProductValue ();
				if (Value == null || Value.length() == 0)
					return null;
				final String whereClause = "Value=? AND AD_Client_ID=?";
				MProduct product = new Query(getCtx(), MProduct.Table_Name, whereClause, null)
				.setParameters(Value,Env.getAD_Client_ID(getCtx()))
				.firstOnly();
				if (product == null)
				{
					product = new MProduct (getCtx (), -1, get_TrxName());
					product.setAD_Org_ID(ifa.getAD_Org_ID ());
					product.setValue (ifa.getProductValue ());
					product.setName (ifa.getProductValue ());
					product.setC_UOM_ID(ifa.getC_UOM_ID());
					if(p_M_Product_Category_ID>0)
						product.setM_Product_Category_ID(p_M_Product_Category_ID);
					if (!product.save ())
						continue;
				}
				ifa.setM_Product_ID (product.getM_Product_ID());
				
				ifa.saveEx();
			}	//	for all new Products
			rs.close ();
			pstmt.close ();
			//
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, "CreateProduct", e);
		}
		sql = new StringBuilder ("UPDATE "+MIFixedAsset.Table_Name+ " "
			  + "SET I_IsImported='N', I_ErrorMsg=I_ErrorMsg||'ERR=No BPartner, ' "
			  + "WHERE M_Product_ID IS NULL"
			  + " AND I_IsImported<>'Y'").append (sqlCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("No Product=" + no);
		
		commitEx();
		*/ //commented by @win
		
		if (p_IsValidateOnly)
			return "Data Was Validated";

		int noInsert = 0;
		int noUpdate = 0;
		
		String whereClause = "NVL(I_IsImported,'N')='N'"+sqlCheck;
		POResultSet<X_I_FixedAsset> rs = new Query(getCtx(), X_I_FixedAsset.Table_Name, whereClause, get_TrxName())
				.setOrderBy(X_I_FixedAsset.COLUMNNAME_I_FixedAsset_ID)
				.scroll();
		try
		{
			while (rs.hasNext()) {
				X_I_FixedAsset xfa = rs.next();
				MIFixedAsset ifa = new MIFixedAsset(getCtx(), xfa.getI_FixedAsset_ID(), get_TrxName());
				try
				{
					boolean isUpdate = ifa.getA_Asset_ID() > 0;
					if (ifa.getA_Asset_ID() == 0)
					{
						//	check for existing active asset by name and inventory no
						sql = new StringBuilder("SELECT A_Asset_ID FROM A_Asset WHERE IsActive='Y' AND Name=? AND InventoryNo=?");
						int A_Asset_ID = DB.getSQLValue(get_TrxName(), sql.toString(), ifa.getName(), ifa.getInventoryNo());
						if (A_Asset_ID > 0)
						{
							isUpdate = true;
							ifa.setA_Asset_ID(A_Asset_ID);
							ifa.saveEx();
						}
					}
					
					if (ifa.getDateAcct() == null && p_DateAcct != null)
						ifa.setDateAcct(p_DateAcct);
							
					MAssetAddition assetAdd = MAssetAddition.createAsset(ifa);
					if (assetAdd == null)
					{
						ifa.setI_ErrorMsg("Failed Create Assets");
						assetAdd = null;
						continue;
					}
					
					ifa.setA_Asset_ID(assetAdd.getA_Asset_ID());
					
					if (isUpdate)
					{
						MAsset asset = MAsset.get(getCtx(), ifa.getA_Asset_ID(), get_TrxName());
						for (MAssetGroupAcct assetgrpacct :  MAssetGroupAcct.forA_Asset_Group_ID(getCtx(), asset.getA_Asset_Group_ID()))
						{			
							if (assetgrpacct.getAD_Org_ID() == 0 || assetgrpacct.getAD_Org_ID() == asset.getAD_Org_ID()) 
							{
								if (assetgrpacct.getC_AcctSchema_ID() != ifa.getC_AcctSchema_ID())
									continue;
								
								// Asset Accounting
								MAssetAcct assetacct = new MAssetAcct(asset, assetgrpacct);
								assetacct.setAD_Org_ID(asset.getAD_Org_ID()); //added by @win
								assetacct.saveEx();
								
								// Asset Depreciation Workfile
								MDepreciationWorkfile assetworkFile = new MDepreciationWorkfile(asset, assetacct.getPostingType(), assetgrpacct);
								assetworkFile.setAD_Org_ID(asset.getAD_Org_ID()); //added by @win
								assetworkFile.setUseLifeYears(assetgrpacct.getUseLifeYears());
								assetworkFile.setUseLifeMonths(assetgrpacct.getUseLifeMonths());
								assetworkFile.setUseLifeYears_F(assetgrpacct.getUseLifeYears_F());
								assetworkFile.setUseLifeMonths_F(assetgrpacct.getUseLifeMonths_F());
								assetworkFile.saveEx();
							}
						}
					}
					
					for (MDepreciationWorkfile assetworkFile : MDepreciationWorkfile.forA_Asset_ID(getCtx(), ifa.getA_Asset_ID(), get_TrxName()))
					{
						if (assetworkFile.getC_AcctSchema_ID() != ifa.getC_AcctSchema_ID())
							continue;
						
						if (ifa.getAssetDepreciationDate() != null)
							assetworkFile.setAssetDepreciationDate(ifa.getAssetDepreciationDate());
						
						assetworkFile.setDateAcct(assetAdd.getDateAcct());
						
						BigDecimal assetCost = ifa.getA_Asset_Cost();
						if (assetCost == null)
							assetCost = Env.ZERO;
						assetworkFile.setA_Asset_Cost(assetCost);
						
						BigDecimal accumulatedDepr = ifa.getA_Accumulated_Depr();
						if (accumulatedDepr == null)
							accumulatedDepr = Env.ZERO;
						assetworkFile.setA_Accumulated_Depr(accumulatedDepr);
						
						BigDecimal accumulatedDeprF = ifa.getA_Accumulated_Depr_F();
						if (accumulatedDeprF == null)
							accumulatedDeprF = Env.ZERO;
						assetworkFile.setA_Accumulated_Depr_F(accumulatedDeprF);
						
						BigDecimal salvageValue = ifa.getA_Salvage_Value();
						if (salvageValue == null)
							salvageValue = Env.ZERO;
						assetworkFile.setA_Salvage_Value(salvageValue);
						
						assetworkFile.setUseLifeMonths(ifa.getUseLifeMonths());
						assetworkFile.setUseLifeMonths_F(ifa.getUseLifeMonths_F());
						
						int currentPeriod = ifa.getA_Current_Period();
						if (currentPeriod == 0)
						{
							int useLifeMonths = ifa.getUseLifeMonths();
							if (useLifeMonths > 0)
								currentPeriod = (int) (accumulatedDepr.doubleValue() / (assetCost.doubleValue() / useLifeMonths));
						}
						assetworkFile.setA_Current_Period(currentPeriod > 0 ? currentPeriod : 1);
						
						assetworkFile.saveEx();
					}
					
					//	Process Asset Addition Based on Document Action
					if (!assetAdd.processIt(ifa.getDocAction()))
					{
						ifa.setI_ErrorMsg("Failed Process Asset Addition");
						assetAdd = null;
						continue;
					}
					assetAdd.saveEx();
					
					ifa.setI_IsImported(true);
					ifa.setI_ErrorMsg(null);
					ifa.setProcessed(true);
					ifa.saveEx();
					
					if (isUpdate)
						noUpdate++;
					else
						noInsert++;
				}
				catch (Exception e) {
					ifa.setI_ErrorMsg(e.getLocalizedMessage());
					ifa.saveEx();
				}
			}
		}
		finally
		{
			DB.close(rs); rs = null;
			//
			sql = new StringBuilder ("UPDATE "+X_I_FixedAsset.Table_Name)
				.append(" SET I_IsImported='N', Updated=SysDate ")
				.append("WHERE I_IsImported<>'Y'").append(sqlCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog (0, null, new BigDecimal (no), "@Errors@");
			addLog (0, null, new BigDecimal (noInsert), "@A_Asset_ID@: @Inserted@");
			addLog (0, null, new BigDecimal (noUpdate), "@A_Asset_ID@: @Updated@");
		}
		
		return "";
	}	//	doIt
	
}	//	ImportAssetClass