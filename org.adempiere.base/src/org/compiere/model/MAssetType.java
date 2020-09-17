package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.ArhRuntimeException;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * Asset Type
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MAssetType extends X_A_Asset_Type implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5511421754249363729L;

	private static final String A_ASSET_TYPE_MFX = "MFX"; // HARDCODED - you must create a Asset Type with Value=MFX to indicate is Fixed Asset
	private static final String A_ASSET_TYPE_INV = "INV"; // HARDCODED - you must create a Asset Type with Value=MFX to indicate is Inventory Object

	public static interface Model
	{
		/** Get Context */
		public Properties getCtx();
		/** Get Asset Type */
		public int getA_Asset_Type_ID();
		/** Get In Possession. The asset is in the possession of the organization */
		public boolean isInPosession();
		/** Get Owned. The asset is owned by the organization */
		public boolean isOwned();
		/** Get Is Depreciated */
		public boolean isDepreciated();
	};
	
	/**		Static Cache: A_Asset_Type.A_Asset_Type_ID-> MAssetType					*/
	private static ImmutableIntPOCache<Integer,MAssetType> s_cache = new ImmutableIntPOCache<Integer,MAssetType>(Table_Name, 10, 0);
	
	/**	
	 * Get Asset Type from cache (immutable)
	 *	@param	A_Asset_Type_ID
	 *	@return asset type object
	 */
	public static MAssetType get (int A_Asset_Type_ID)
	{
		return get(Env.getCtx(), A_Asset_Type_ID);
	}
	
	/**	
	 *  Get Asset Type from cache (immutable)
	 *	@param	ctx context
	 *	@param	A_Asset_Type_ID
	 *	@return asset type object
	 */
	public static MAssetType get (Properties ctx, int A_Asset_Type_ID)
	{
		if (A_Asset_Type_ID <= 0)
			return null;
		MAssetType o = s_cache.get(ctx, A_Asset_Type_ID, e -> new MAssetType(ctx, e));
		if (o != null)
			return o;
		o = new MAssetType(ctx, A_Asset_Type_ID, (String)null);
		if (o.get_ID() == A_Asset_Type_ID) {
			s_cache.put(A_Asset_Type_ID, o, e -> new MAssetType(Env.getCtx(), e));
			return o;
		}
		return null;
	}
	
	/** Standard Constructor */
	public MAssetType (Properties ctx, int A_Asset_Type_ID, String trxName)
	{
		super (ctx, A_Asset_Type_ID, trxName);
	}
	
	/** Load Constructor */
	public MAssetType (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param copy
	 */
	public MAssetType(MAssetType copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MAssetType(Properties ctx, MAssetType copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MAssetType(Properties ctx, MAssetType copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/** Is Fixed Asset
	 */
	public boolean isFixedAsset()
	{
		return A_ASSET_TYPE_MFX.equals(getValue());
	}
	
	public static boolean isFixedAsset(int A_Asset_ID)
	{
		MAsset asset = MAsset.get(Env.getCtx(), A_Asset_ID, null);
		return isFixedAsset(asset);
	}
	
	public static boolean isFixedAsset(MAsset asset)
	{
		return asset != null && A_ASSET_TYPE_MFX.equals(asset.getA_Asset_Type().getValue());
	}
	
	public static boolean isFixedAssetGroup(Properties ctx, int A_Asset_Group_ID)
	{
		if (A_Asset_Group_ID <= 0)
			return false;
		MAssetGroup assetGroup = MAssetGroup.get(ctx, A_Asset_Group_ID);
		//
		int assetType_ID = assetGroup.getA_Asset_Type_ID();
		if (assetType_ID <= 0)
			return false;
		MAssetType assetType = MAssetType.get(ctx, assetType_ID);
		//
		return assetType.isFixedAsset();
	}
	
	/** Is Inventory Object
	 */
	public boolean isInventoryObject() {
		return A_ASSET_TYPE_INV.equals(getValue());
	}
	
	/** Convert an Yes-No-Unknown field to Boolean */
	protected static Boolean getBoolean (String value, boolean useDefaults)
	{
		if (value == null || value.length() == 0)
			return null;
		String f = value.substring(0, 1);
		if ("N".equals(f))
			return Boolean.FALSE;
		else if ("Y".equals(f))
			return Boolean.TRUE;
		else if ("X".equals(f) && useDefaults)
			return getBoolean(value.substring(1), false);
		else
			return null;
	}
	
	/**
	 * Validate a Model
	 * @param m model
	 * @throws ContextUserException
	 */
	public static void validate(Model m)
	{
		// Load Asset Type
		MAssetType assetType = MAssetType.get(m.getCtx(), m.getA_Asset_Type_ID());
		if (assetType == null)
		{
			throw new ArhRuntimeException(m.getCtx(), "@NotFound@ @A_Asset_Type_ID@")
							.addInfo("@A_Asset_Type_ID", m.getA_Asset_Type_ID());
		}
		
		ArhRuntimeException err = new ArhRuntimeException(m.getCtx(), "");
		Boolean f = getBoolean(assetType.getIsOwned(), false);
		if (f != null && f.booleanValue() != m.isOwned()) {
			err.addInfo("@IsOwned@ <> @" + f + "@");
		}
		f = getBoolean(assetType.getIsInPosession(), false);
		if (f != null && f.booleanValue() != m.isInPosession()) {
			err.addInfo("@IsInPosession@ <> @" + f + "@");
		}
		f = getBoolean(assetType.getIsDepreciable(), false);
		if (f != null && f.booleanValue() != m.isDepreciated()) {
			err.addInfo("@IsDepreciated@ <> @" + f + "@");
		}
		
		if (err.hasInfo())
			throw err;
	}
	
	/**
	 * Update the given SetGetModel; Does not set A_Asset_Type_ID
	 * @param model
	 * @param useDefaults in case is not a concrete value, use defaults
	 */
	public boolean update(SetGetModel model, boolean useDefaults)
	{
//		boolean useDefaults = true;
		Boolean f = getBoolean(getIsOwned(), useDefaults);
		if (f != null)
			model.set_AttrValue("IsOwned", f);
		f = getBoolean(getIsInPosession(), useDefaults);
		if (f != null)
			model.set_AttrValue("IsInPosession", f);
		f = getBoolean(getIsDepreciable(), useDefaults);
		if (f != null) {
			model.set_AttrValue("IsDepreciated", f);
		}
		
		if (!isFixedAsset()) {
			model.set_AttrValue("A_Asset_Class_ID", null);
		}
		
		model.set_AttrValue("A_Asset_Type", getValue());
		
		return true;
	}
	
	@Override
	public MAssetType markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/** Callout Class */
	public static class Callout extends CalloutEngine
	{
		public String assetType(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) {
			if (isCalloutActive())
				return "";
			
			int A_Asset_Type_ID = 0;
			if (value != null && value instanceof Number)
				A_Asset_Type_ID = ((Number)value).intValue();
			else
				return "";
			MAssetType assetType = MAssetType.get(ctx, A_Asset_Type_ID);
			if (assetType != null)
				assetType.update(SetGetUtil.wrap(mTab), true);
			//
			return "";
		}
	};

}	// class MAssetType
