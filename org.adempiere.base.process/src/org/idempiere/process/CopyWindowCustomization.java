package org.idempiere.process;

import java.util.List;

import org.adempiere.base.annotation.Parameter;
import org.adempiere.base.annotation.Process;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MUserDefField;
import org.compiere.model.MUserDefTab;
import org.compiere.model.MUserDefWin;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.SvrProcess;
import org.compiere.util.Msg;

/**
 * 
 * @author pultzlucas
 * 
 */

@Process
public class CopyWindowCustomization extends SvrProcess {
	@Parameter
	private int p_AD_UserDef_Win_ID = 0;

	@Override
	protected void prepare() {
	}

	@Override
	protected String doIt() throws Exception {
		if (getRecord_ID() <= 0)
			throw new AdempiereException(Msg.getMsg(getCtx(), "RecordNotFound"));

		if (p_AD_UserDef_Win_ID <= 0)
			throw new AdempiereException(
					Msg.getMsg(getCtx(), "FillMandatory") + ": " + Msg.getElement(getCtx(), "AD_UserDef_Win_ID"));

		if (p_AD_UserDef_Win_ID == getRecord_ID())
			throw new AdempiereException(Msg.getMsg(getCtx(), "UserDefWinSameRecord"));

		MUserDefWin targetWin = new MUserDefWin(getCtx(), getRecord_ID(), get_TrxName());
		MUserDefWin sourceWin = new MUserDefWin(getCtx(), p_AD_UserDef_Win_ID, get_TrxName());

		if (sourceWin.get_ID() <= 0 || targetWin.get_ID() <= 0)
			throw new AdempiereException(Msg.getMsg(getCtx(), "RecordNotFound"));

		if (sourceWin.getAD_Window_ID() != targetWin.getAD_Window_ID())
			throw new AdempiereException(Msg.getMsg(getCtx(), "UserDefWinDifferentWindow"));

		List<MUserDefTab> sourceTabs = new Query(getCtx(), MUserDefTab.Table_Name, "AD_UserDef_Win_ID=?", get_TrxName())
				.setParameters(sourceWin.get_ID()).list();

		for (MUserDefTab sourceTab : sourceTabs) {
			MUserDefTab targetTab = new Query(getCtx(), MUserDefTab.Table_Name, "AD_UserDef_Win_ID=? AND AD_Tab_ID=?",
					get_TrxName()).setParameters(targetWin.get_ID(), sourceTab.getAD_Tab_ID()).first();

			// is new tab
			if (targetTab == null) {
				targetTab = new MUserDefTab(getCtx(), 0, get_TrxName());
			}

			PO.copyValues(sourceTab, targetTab);

			targetTab.set_ValueNoCheck(MUserDefTab.COLUMNNAME_AD_Client_ID, targetWin.getAD_Client_ID());
			targetTab.set_ValueNoCheck(MUserDefTab.COLUMNNAME_AD_Org_ID, targetWin.getAD_Org_ID());
			targetTab.setAD_UserDef_Win_ID(targetWin.get_ID());
			targetTab.saveEx();

			List<MUserDefField> sourceFields = new Query(getCtx(), MUserDefField.Table_Name, "AD_UserDef_Tab_ID=?",
					get_TrxName()).setParameters(sourceTab.get_ID()).list();

			for (MUserDefField sourceField : sourceFields) {
				MUserDefField targetField = new Query(getCtx(), MUserDefField.Table_Name,
						"AD_UserDef_Tab_ID=? AND AD_Field_ID=?", get_TrxName())
						.setParameters(targetTab.get_ID(), sourceField.getAD_Field_ID()).first();

				// is new field
				if (targetField == null) {
					targetField = new MUserDefField(getCtx(), 0, get_TrxName());
				}

				PO.copyValues(sourceField, targetField);

				targetField.set_ValueNoCheck(MUserDefTab.COLUMNNAME_AD_Client_ID, targetWin.getAD_Client_ID());
				targetField.set_ValueNoCheck(MUserDefTab.COLUMNNAME_AD_Org_ID, targetWin.getAD_Org_ID());
				targetField.setAD_UserDef_Tab_ID(targetTab.get_ID());
				targetField.saveEx();
			}
		}

		return "@Copied@";
	}
}