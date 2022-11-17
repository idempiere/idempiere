package org.idempiere.fa.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Properties;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MDepreciationWorkfile;
import org.compiere.model.SetGetUtil;


/**
 * @author Teo Sarca, http://www.arhipac.ro
 */
public class CalloutA_Depreciation_Workfile extends CalloutEngine
{
	private static final BigDecimal TWELVE = BigDecimal.valueOf(12.0);

	public String A_Valoare_Cofinantare (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive())
			return "";
		MDepreciationWorkfile.updateFinantare(SetGetUtil.wrap(mTab), mField.getColumnName());
		return "";
	}
	
	public String uselifeyear(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		BigDecimal uselife = null;
		if (MDepreciationWorkfile.COLUMNNAME_UseLifeYears.equals(mField.getColumnName()))
		{
			uselife =  new BigDecimal(value.toString()).multiply(TWELVE);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeYears_F, value);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeMonths, uselife);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeMonths_F, uselife);	
			
		} else if (MDepreciationWorkfile.COLUMNNAME_UseLifeMonths.equals(mField.getColumnName()))
		{
			uselife =  new BigDecimal(value.toString()).setScale(12).divide(TWELVE, RoundingMode.HALF_UP);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeYears, uselife);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeYears_F, uselife);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeMonths_F, value);
			
		} else if (MDepreciationWorkfile.COLUMNNAME_UseLifeYears_F.equals(mField.getColumnName()))
		{
			uselife =  new BigDecimal(value.toString()).multiply(TWELVE);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeMonths_F, uselife);
			
		} else if (MDepreciationWorkfile.COLUMNNAME_UseLifeMonths_F.equals(mField.getColumnName()))
		{
			uselife =  new BigDecimal(value.toString()).setScale(12).divide(TWELVE, RoundingMode.HALF_UP);
			mTab.setValue(MDepreciationWorkfile.COLUMNNAME_UseLifeYears_F, uselife);
			
		}
		return "";
		
	}
	
}