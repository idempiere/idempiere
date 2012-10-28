package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.compiere.util.CLogMgt;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Asset Model
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
@SuppressWarnings("serial")
public class MAsset extends X_A_Asset
	//implements MAssetType.Model //commented by @win
{
	/** ChangeType - Asset Group changed */
	public static final int CHANGETYPE_setAssetGroup = Table_ID * 100 + 1;
	
	/**
	 * Get Asset
	 * @param ctx context
	 * @param A_Asset_ID asset
	 * @param trxName
	 */
	public static MAsset get (Properties ctx, int A_Asset_ID, String trxName)
	{
		return (MAsset)MTable.get(ctx, MAsset.Table_Name).getPO(A_Asset_ID, trxName);
	}	//	get
	
	/**
	 * Get Assets from given M_Product_ID and M_ASI_ID.
	 * <p>Note: The A_Asset_Product table is not checked !!!
	 * @param ctx
	 * @param M_Product_ID (optional)
	 * @param M_ASI_ID
	 * @return array of MAsset
	 */
	public static Collection<MAsset> forASI(Properties ctx, int M_Product_ID, int M_ASI_ID)
	{
		ArrayList<Object> params = new ArrayList<Object>();
		String whereClause = COLUMNNAME_M_AttributeSetInstance_ID + "=?";
		params.add(M_ASI_ID);
		if (M_Product_ID > 0) {
			whereClause += " AND " + COLUMNNAME_M_Product_ID + "=?";
			params.add(M_Product_ID);
		}
		//
		return new Query(ctx, MAsset.Table_Name, whereClause, null)
					.setParameters(params)
					.list();
	}
	
	/** Create constructor */
	public MAsset (Properties ctx, int A_Asset_ID, String trxName)
	{
		super (ctx, A_Asset_ID,trxName);
		if (A_Asset_ID == 0)
		{
			setA_Asset_Status(A_ASSET_STATUS_New);
			//commented out by @win
			/*
			setA_Asset_Type("MFX");
			setA_Asset_Type_ID(1); // MFX
			*/
			//end comment by @win
		}
	}	//	MAsset

	/**
	 * Load Constructor
	 * @param ctx context
	 * @param rs result set record
	 */
	public MAsset (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MAsset
	
	/**
	 * Construct from MMatchInv
	 * @param match match invoice
	 */
	protected MAsset (MMatchInv match)
	{
		this(match.getCtx(), 0, match.get_TrxName());
		
		MInvoiceLine invoiceLine = new MInvoiceLine(getCtx(), match.getC_InvoiceLine_ID(), get_TrxName());
		MInOutLine inoutLine = new MInOutLine(getCtx(), match.getM_InOutLine_ID(), get_TrxName());
		
		setIsOwned(true);
		setIsInPosession(true);
		setA_Asset_CreateDate(inoutLine.getM_InOut().getMovementDate());
		
		// Asset Group:
		int A_Asset_Group_ID = invoiceLine.getA_Asset_Group_ID();
		MProduct product = MProduct.get(getCtx(), invoiceLine.getM_Product_ID());
		if (A_Asset_Group_ID <= 0) {
			A_Asset_Group_ID = product.getA_Asset_Group_ID();
		}
		setA_Asset_Group_ID(A_Asset_Group_ID);
		setHelp(Msg.getMsg(MClient.get(getCtx()).getAD_Language(), "CreatedFromInvoiceLine", 
				new Object[] {invoiceLine.getC_Invoice().getDocumentNo(), invoiceLine.getLine()}));
		
		String name = "";
		if (inoutLine.getM_Product_ID()>0)
		{
			name += product.getName() + "-";
			setM_Product_ID(inoutLine.getM_Product_ID());
			setM_AttributeSetInstance_ID(inoutLine.getM_AttributeSetInstance_ID());
		}
		MBPartner bp = new MBPartner(getCtx(), invoiceLine.getC_Invoice().getC_BPartner_ID(), null);
		name += bp.getName()+"-"+invoiceLine.getC_Invoice().getDocumentNo();
		log.fine("name=" + name);
		setValue(name);
		setName(name);
		setDescription(invoiceLine.getDescription());
	}

	/**
	 * Construct from MIFixedAsset (import)
	 * @param match match invoice
	 */
	protected MAsset (MIFixedAsset ifa)
	{
		this(ifa.getCtx(), 0, ifa.get_TrxName());
		
		setAD_Org_ID(ifa.getAD_Org_ID()); //added by @win
		setIsOwned(true);
		setIsInPosession(true);
		
		String inventoryNo = ifa.getInventoryNo();
		if (inventoryNo != null) {
			inventoryNo = inventoryNo.trim();
			setInventoryNo(inventoryNo);
			setValue(inventoryNo);
		}
		setA_Asset_CreateDate(ifa.getAssetServiceDate());
		//setAssetServiceDate(ifa.getAssetServiceDate()); //commented by @win
		/* commented by @win
		setA_Asset_Class_ID(ifa.getA_Asset_Class_ID());
		*/ // commented by @win
		MProduct product = ifa.getProduct();
		if (product != null) {
			setM_Product_ID(product.getM_Product_ID());
			setA_Asset_Group_ID(ifa.getA_Asset_Group_ID());
			MAttributeSetInstance asi = MAttributeSetInstance.create(getCtx(), product, get_TrxName());
			setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		}
		
		setDateAcct(ifa.getDateAcct());
		setName(ifa.getName());
		setDescription(ifa.getDescription());
	}

	/**
	 * @author Edwin Ang
	 * @param project
	 */
	protected MAsset (MProject project)
	{
		this(project.getCtx(), 0, project.get_TrxName());
		setIsOwned(true);
		setIsInPosession(true);
		setA_Asset_CreateDate(new Timestamp(System.currentTimeMillis()));
		setHelp(Msg.getMsg(MClient.get(getCtx()).getAD_Language(), "CreatedFromProject", new Object[] { project.getName()}));
		setDateAcct(new Timestamp(System.currentTimeMillis()));
		setDescription(project.getDescription());
	}
	
	public MAsset(MInOut mInOut, MInOutLine sLine, int deliveryCount) {
		this(mInOut.getCtx(), 0, mInOut.get_TrxName());
		setIsOwned(false);
		setIsInPosession(false);
		setA_Asset_CreateDate(new Timestamp(System.currentTimeMillis()));
		setHelp(Msg.getMsg(MClient.get(getCtx()).getAD_Language(), "CreatedFromShipment: ", new Object[] { mInOut.getDocumentNo()}));
		setDateAcct(new Timestamp(System.currentTimeMillis()));
		setDescription(sLine.getDescription());
		
	}

	/**
	 * Create Asset from Inventory
	 * @param inventory	inventory
	 * @param invLine 	inventory line
	 * @param deliveryCount 0 or number of delivery
	 * @return A_Asset_ID
	 */
	
	public MAsset (MInventory inventory, MInventoryLine invLine, BigDecimal qty, BigDecimal costs)
	{
		super(invLine.getCtx(), 0, invLine.get_TrxName());
		setClientOrg(invLine);
		
		MProduct product = MProduct.get(getCtx(), invLine.getM_Product_ID());
		// Defaults from group:
		MAssetGroup assetGroup = MAssetGroup.get(invLine.getCtx(), invLine.getM_Product().getM_Product_Category().getA_Asset_Group_ID());
		if (assetGroup == null)
			assetGroup = MAssetGroup.get(invLine.getCtx(), product.getA_Asset_Group_ID());
		setAssetGroup(assetGroup);
		
		
		//setValue(prod)
		setName(product.getName());
		setHelp(invLine.getDescription());
		//	Header
		setAssetServiceDate(inventory.getMovementDate());
		setIsOwned(true);
		setIsInPosession(true);
		
		//	Product
		setM_Product_ID(product.getM_Product_ID());
		//	Guarantee & Version
		//setGuaranteeDate(TimeUtil.addDays(shipment.getMovementDate(), product.getGuaranteeDays()));
		setVersionNo(product.getVersionNo());
		// ASI
		if (invLine.getM_AttributeSetInstance_ID() != 0)
		{
			MAttributeSetInstance asi = new MAttributeSetInstance (getCtx(), invLine.getM_AttributeSetInstance_ID(), get_TrxName());
			setASI(asi);
		}
		//setSerNo(invLine.getSerNo());
		setQty(qty);
		
		// Costs:
		//setA_Asset_Cost(costs);  //commented by @win, set at asset addition
		
		// Activity
		/*
		if (invLine.getC_Activity_ID() > 0)
			setC_Activity_ID(invLine.getC_Activity_ID());
		*/
		if (inventory.getC_Activity_ID() > 0)
			setC_Activity_ID(inventory.getC_Activity_ID());
		
		//
		
		if (MAssetType.isFixedAsset(this)) {
			setA_Asset_Status(A_ASSET_STATUS_New);
		}
		else {
			setA_Asset_Status(A_ASSET_STATUS_Activated);
			setProcessed(true);
		}
		
		//added by @win
		setA_Asset_Status(A_ASSET_STATUS_New);
		//end added by @win
		
		
	}
	
	/**
	 * Set Asset Group; also it sets other default fields
	 * @param assetGroup
	 */
	public void setAssetGroup(MAssetGroup assetGroup) {
		setA_Asset_Group_ID(assetGroup.getA_Asset_Group_ID());
		
		/* commented out by @win
		setA_Asset_Type_ID(assetGroup.getA_Asset_Type_ID());
		setGZ_TipComponenta(assetGroup.getGZ_TipComponenta()); // TODO: move to GZ
		MAssetType assetType = MAssetType.get(getCtx(), assetGroup.getA_Asset_Type_ID());
		assetType.update(SetGetUtil.wrap(this), true);
		*/ //end commet by @win
	}
	
	public MAssetGroup getAssetGroup() {
		return MAssetGroup.get(getCtx(), getA_Asset_Group_ID());
	}
	
	/**
	 * Set ASI Info (M_AttributeSetInstance_ID, Lot, SerNo)
	 * @param asi
	 */
	public void setASI(MAttributeSetInstance asi) {
		setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		setLot(asi.getLot());
		setSerNo(asi.getSerNo());
	}

	/**
	 * Before Save
	 * @param newRecord new
	 * @return true
	 */
	
	protected boolean beforeSave (boolean newRecord)
	{
		// Set parent asset:
		if (getA_Parent_Asset_ID() <= 0)
		{
			setA_Parent_Asset_ID(getA_Asset_ID());
		}	
		// Fix inventory number:
		String invNo = getInventoryNo();
		if(invNo != null)
		{
			setInventoryNo(invNo.trim());
		}
		// If no asset group, than set the default one:
		if(getA_Asset_Group_ID() <= 0)
		{
			setA_Asset_Group_ID(MAssetGroup.getDefault_ID(SetGetUtil.wrap(this)));
		}
		/* @win temporary commented out
		
		if (getA_Asset_Class_ID() <= 0 && getA_Asset_Group_ID() > 0)
		{
			MAssetGroup.updateAsset(SetGetUtil.wrap(this), getA_Asset_Group_ID());
		}
		*/
		//end @win comment
		
		// Copy fields from C_BPartner_Location
		if (is_ValueChanged(COLUMNNAME_C_BPartner_Location_ID) && getC_BPartner_Location_ID() > 0)
		{
			SetGetUtil.copyValues((SetGetModel)this, MBPartnerLocation.Table_Name, getC_BPartner_Location_ID(),
					new String[]{MBPartnerLocation.COLUMNNAME_C_Location_ID}
			);
		}
		//
		// Create ASI if not exist:
		if (getM_Product_ID() > 0 && getM_AttributeSetInstance_ID() <= 0)
		{
			MProduct product = MProduct.get(getCtx(), getM_Product_ID());
			MAttributeSetInstance asi = new MAttributeSetInstance(getCtx(), 0, product.getM_AttributeSet_ID(), get_TrxName());
			asi.setSerNo(getSerNo());
			asi.setDescription();
			asi.saveEx();
			setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		}
		// TODO: With the lines below, after creating the asset, the whole system goes much slower ??? 
//		else if (is_ValueChanged(COLUMNNAME_SerNo) && getM_AttributeSetInstance_ID() > 0) {
//			asi = new MAttributeSetInstance(getCtx(), getM_AttributeSetInstance_ID(), get_TrxName());
//			asi.setSerNo(getSerNo());
//			asi.setDescription();
//			asi.saveEx();
//		}
//		else if ((newRecord || is_ValueChanged(COLUMNNAME_M_AttributeSetInstance_ID)) && getM_AttributeSetInstance_ID() > 0) {
//			asi = new MAttributeSetInstance(getCtx(), getM_AttributeSetInstance_ID(), get_TrxName());
//			setASI(asi);
//		}
		//
		
		// Update status
		updateStatus();
		
		// Validate AssetType
		//@win commented out
		//MAssetType.validate(this);
		//@win end
		//
		
		return true;
	}	//	beforeSave
	
	
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if(!success)
		{
			return success;
		}
		
		//
		// Set parent
		if(getA_Parent_Asset_ID() <= 0)
		{
			int A_Asset_ID = getA_Asset_ID();
			setA_Parent_Asset_ID(A_Asset_ID);
			DB.executeUpdateEx("UPDATE A_Asset SET A_Parent_Asset_ID=A_Asset_ID WHERE A_Asset_ID=" + A_Asset_ID, get_TrxName());
			log.fine("A_Parent_Asset_ID=" + getA_Parent_Asset_ID());
		}
		
		//
		// Set inventory number:
		String invNo = getInventoryNo();
		if(invNo == null || invNo.trim().length() == 0)
		{
			invNo = "" + get_ID();
			setInventoryNo(invNo);
			DB.executeUpdateEx("UPDATE A_Asset SET InventoryNo=" + DB.TO_STRING(invNo) + " WHERE A_Asset_ID=" + getA_Asset_ID(), get_TrxName());
			log.fine("InventoryNo=" + getInventoryNo());
		}
		
		
		// If new record, create accounting and workfile
		if (newRecord)
		{
			//@win: set value at asset group as default value for asset
			MAssetGroup assetgroup = new MAssetGroup(getCtx(), getA_Asset_Group_ID(), get_TrxName());
			String isDepreciated = (assetgroup.isDepreciated()) ? "Y" : "N";
			String isOwned = (assetgroup.isOwned()) ? "Y" : "N";
			setIsDepreciated(assetgroup.isDepreciated());
			setIsOwned(assetgroup.isOwned());
			DB.executeUpdateEx("UPDATE A_Asset SET IsDepreciated='" + isDepreciated + "', isOwned ='" + isOwned + "' WHERE A_Asset_ID=" + getA_Asset_ID(), get_TrxName());
			//end @win
			
			// for each asset group acounting create an asset accounting and a workfile too
			for (MAssetGroupAcct assetgrpacct :  MAssetGroupAcct.forA_Asset_Group_ID(getCtx(), getA_Asset_Group_ID()))
			{			
				// Asset Accounting
				MAssetAcct assetacct = new MAssetAcct(this, assetgrpacct);
				assetacct.setAD_Org_ID(getAD_Org_ID()); //added by @win
				assetacct.saveEx();
				
				// Asset Depreciation Workfile
				MDepreciationWorkfile assetwk = new MDepreciationWorkfile(this, assetacct.getPostingType(), assetgrpacct);
				assetwk.setAD_Org_ID(getAD_Org_ID()); //added by @win
				assetwk.setUseLifeYears(0);
				assetwk.setUseLifeMonths(0);
				assetwk.setUseLifeYears_F(0);
				assetwk.setUseLifeMonths_F(0);
				assetwk.saveEx();
				
				// Change Log
				MAssetChange.createAndSave(getCtx(), "CRT", new PO[]{this, assetwk, assetacct}, null);
			}
			
		}
		else
		{
			MAssetChange.createAndSave(getCtx(), "UPD", new PO[]{this}, null);
		}
		
		//
		// Update child.IsDepreciated flag
		if (!newRecord && is_ValueChanged(COLUMNNAME_IsDepreciated))
		{
			final String sql = "UPDATE " + MDepreciationWorkfile.Table_Name
				+" SET " + MDepreciationWorkfile.COLUMNNAME_IsDepreciated+"=?"
				+" WHERE " + MDepreciationWorkfile.COLUMNNAME_A_Asset_ID+"=?";
			DB.executeUpdateEx(sql, new Object[]{isDepreciated(), getA_Asset_ID()}, get_TrxName());
		}
		
		return true;
	}	//	afterSave
	
	
	protected boolean beforeDelete()
	{
		// delete addition
		{
			String sql = "DELETE FROM "+MAssetAddition.Table_Name+" WHERE "+MAssetAddition.COLUMNNAME_Processed+"=? AND "+MAssetAddition.COLUMNNAME_A_Asset_ID+"=?";
			int no = DB.executeUpdateEx(sql, new Object[]{false, getA_Asset_ID()}, get_TrxName());
			log.info("@A_Asset_Addition@ @Deleted@ #" + no);
		}
		//
		// update invoice line
		{
			final String sql = "UPDATE "+MInvoiceLine.Table_Name+" SET "
										+" "+MInvoiceLine.COLUMNNAME_A_Asset_ID+"=?"
										+","+MInvoiceLine.COLUMNNAME_A_Processed+"=?"
								+" WHERE "+MInvoiceLine.COLUMNNAME_A_Asset_ID+"=?";
			int no = DB.executeUpdateEx(sql, new Object[]{null, false, getA_Asset_ID()}, get_TrxName());
			log.info("@C_InvoiceLine@ @Updated@ #" + no);
		}
		return true;
	}       //      beforeDelete
	
	/**
	 * 
	 * @see #beforeSave(boolean)
	 */
	public void updateStatus()
	{
		String status = getA_Asset_Status();
		setProcessed(!status.equals(A_ASSET_STATUS_New));
//		setIsDisposed(!status.equals(A_ASSET_STATUS_New) && !status.equals(A_ASSET_STATUS_Activated));
		setIsDisposed(status.equals(A_ASSET_STATUS_Disposed));
		setIsFullyDepreciated(status.equals(A_ASSET_STATUS_Depreciated));
		if(isFullyDepreciated() || status.equals(A_ASSET_STATUS_Disposed))
		{
			setIsDepreciated(false);
		}
		/* commented by @win 
		MAssetClass assetClass = MAssetClass.get(getCtx(), getA_Asset_Class_ID());
		if (assetClass != null && assetClass.isDepreciated())
		{
			setIsDepreciated(true);
		}
		*/ //end comment by @win
		if (status.equals(A_ASSET_STATUS_Activated) || getAssetActivationDate() == null)
		{
			setAssetActivationDate(getAssetServiceDate());
		}
	}
	
	/**
	 * Change asset status to newStatus
	 * @param newStatus see A_ASSET_STATUS_
	 * @param date state change date; if null context "#Date" will be used
	 */
	public void changeStatus(String newStatus, Timestamp date)
	{
		String status = getA_Asset_Status();
		if (CLogMgt.isLevelFinest()) log.finest("Entering: " + status + "->" + newStatus + ", date=" + date);
		
		//
		// If date is null, use context #Date
		if(date == null) {
			date = Env.getContextAsDate(getCtx(), "#Date");
		}
		
		//
		//	Activation/Addition
		if(newStatus.equals(A_ASSET_STATUS_Activated))
		{
			setAssetActivationDate(date);
		}
		//
		// Preservation
		if(newStatus.equals(A_ASSET_STATUS_Preservation))
		{
			setAssetDisposalDate(date);
			// TODO: move to MAsetDisposal
			Collection<MDepreciationWorkfile> workFiles = MDepreciationWorkfile.forA_Asset_ID(getCtx(), getA_Asset_ID(), get_TrxName());
			for(MDepreciationWorkfile assetwk : workFiles) {
				assetwk.truncDepreciation();
				assetwk.saveEx();
			}
		}
		// Disposal
		if(newStatus.equals(A_ASSET_STATUS_Disposed))
		{ // casat, vandut
			setAssetDisposalDate(date);
		}
		
		// Set new status
		setA_Asset_Status(newStatus);
	}	//	changeStatus
	
	// Temporary used variables:
	/**			*/
	private int m_UseLifeMonths_F = 0;
	public int getUseLifeMonths_F()											{	return m_UseLifeMonths_F;	}
	public void setUseLifeMonths_F(int UseLifeMonths_F)						{	m_UseLifeMonths_F = UseLifeMonths_F; }
	/**			*/
	private int m_A_Current_Period = 0;
	public int getA_Current_Period()										{	return m_A_Current_Period;	}
	public void setA_Current_Period(int A_Current_Period)					{	m_A_Current_Period = A_Current_Period; }
	/**			*/
	private Timestamp m_DateAcct = null;
	public Timestamp getDateAcct()											{	return m_DateAcct;	}
	public void setDateAcct(Timestamp DateAcct)								{	m_DateAcct = DateAcct; }
	/**			*/
	private int m_A_Depreciation_ID = 0;
	public int getA_Depreciation_ID()										{	return m_A_Depreciation_ID;	}
	public void setA_Depreciation_ID(int A_Depreciation_ID)					{	m_A_Depreciation_ID = A_Depreciation_ID; }
	/**			*/
	private int m_A_Depreciation_F_ID = 0;
	public int getA_Depreciation_F_ID()										{	return m_A_Depreciation_F_ID;	}
	public void setA_Depreciation_F_ID(int A_Depreciation_F_ID)				{	m_A_Depreciation_F_ID = A_Depreciation_F_ID; }
	/**			*/
	private BigDecimal m_A_Asset_Cost = Env.ZERO;
	private BigDecimal m_A_Accumulated_Depr = Env.ZERO;
	private BigDecimal m_A_Accumulated_Depr_F = Env.ZERO;
	public BigDecimal getA_Asset_Cost()										{	return m_A_Asset_Cost;	}
	public void setA_Asset_Cost(BigDecimal A_Asset_Cost)					{	m_A_Asset_Cost = A_Asset_Cost; }
	public BigDecimal getA_Accumulated_Depr()								{	return m_A_Accumulated_Depr;	}
	public void setA_Accumulated_Depr(BigDecimal A_Accumulated_Depr)		{	m_A_Accumulated_Depr = A_Accumulated_Depr; }
	public BigDecimal getA_Accumulated_Depr_F()								{	return m_A_Accumulated_Depr_F;	}
	public void setA_Accumulated_Depr_F(BigDecimal A_Accumulated_Depr_F)	{	m_A_Accumulated_Depr_F = A_Accumulated_Depr_F; }

	public MAssetDelivery confirmDelivery(EMail email, int ad_User_ID) {
		// TODO Auto-generated method stub
		return null;
	}

	public MProductDownload[] getProductDownloads() {
		// TODO Auto-generated method stub
		return null;
	}

	public MAssetDelivery confirmDelivery(HttpServletRequest request,
			int ad_User_ID) {
		// TODO Auto-generated method stub
		return null;
	}

	public MAssetDelivery[] getDeliveries() {
		// TODO Auto-generated method stub
		return null;
	}

	public static MAsset getFromShipment(Properties ctx, int i, String trxName) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getProductR_MailText_ID() {
		// IDEMPIERE-197 Stabilize Fixed Assets
		// AssetDelivery is requiring this missing column
		// TODO: Adding this method to compile correctly and future research,
		// but the process AssetDelivery will fail with error "** Product Mail Text"
		return 0;
	}

	public boolean isDownloadable() {
		// IDEMPIERE-197 Stabilize Fixed Assets
		// AssetServlet is requiring this missing column
		// TODO: Adding this method to compile correctly and future research
		return false;
	}
}
