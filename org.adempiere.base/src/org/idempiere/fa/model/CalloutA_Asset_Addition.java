package org.idempiere.fa.model;

import java.math.BigDecimal;
import java.util.Properties;

import org.adempiere.model.GridTabWrapper;
import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_A_Asset_Addition;
import org.compiere.model.MAssetAddition;
import org.compiere.model.MConversionRateUtil;
import org.compiere.model.MProject;
import org.compiere.model.SetGetUtil;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;


/**
 * @author Teo Sarca, http://www.arhipac.ro
 */
public class CalloutA_Asset_Addition extends CalloutEngine
{
	public String matchInv(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";

		int M_MatchInv_ID = ((Number)value).intValue();
		if (M_MatchInv_ID > 0)
		{
			MAssetAddition.setM_MatchInv(SetGetUtil.wrap(mTab), M_MatchInv_ID);
		}
		//
		return amt(ctx, WindowNo, mTab, mField, value);
	}

	public String project(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive())
			return "";
		//
		int project_id = 0;
		if (value != null && value instanceof Number)
			project_id = ((Number)value).intValue();
		else
			return "";
		//
		BigDecimal amt = Env.ZERO;
		if (project_id > 0) {
			MProject prj = new MProject(ctx, project_id, null);
			amt = prj.getProjectBalanceAmt();
			mTab.setValue(MAssetAddition.COLUMNNAME_C_Currency_ID, prj.getC_Currency_ID());
		}
		mTab.setValue(MAssetAddition.COLUMNNAME_AssetSourceAmt, amt);
		return amt(ctx, WindowNo, mTab, mField, value);
	}

	public String amt(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive())
			return "";
		//		
		BigDecimal amtEntered = (BigDecimal) mTab.getValue(MAssetAddition.COLUMNNAME_AssetAmtEntered);
		mTab.setValue(MAssetAddition.COLUMNNAME_AssetSourceAmt, amtEntered);
		MConversionRateUtil.convertBase(SetGetUtil.wrap(mTab),
				MAssetAddition.COLUMNNAME_DateAcct,
				MAssetAddition.COLUMNNAME_AssetSourceAmt,
				MAssetAddition.COLUMNNAME_AssetValueAmt,
				mField.getColumnName());
		
		//
		return "";
	}

	public String dateDoc(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";
		
		mTab.setValue(MAssetAddition.COLUMNNAME_DateAcct, value);
		return "";
	}
	
	public String uselife(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		
		return "";
	}
	
	
	public String periodOffset(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		I_A_Asset_Addition aa = GridTabWrapper.create(mTab, I_A_Asset_Addition.class);
	
		
		int periods = TimeUtil.getMonthsBetween(aa.getDateDoc(), aa.getDateAcct());
		if (periods <= 0)
		{
			return "";
		}
		
		
		
		return "";
	}
	
}
