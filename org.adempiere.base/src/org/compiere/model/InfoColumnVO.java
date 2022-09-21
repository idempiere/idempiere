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
* - Igor Pojzl, Cloudempiere                                          *
**********************************************************************/
package org.compiere.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Properties;

import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;

/**
 * Info Column Value Object
 * @author Igor Pojzl, Cloudempiere
 * @version $Id$
 */
public class InfoColumnVO implements Serializable, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7401407425423442841L;
	/** Properties */
	private Properties ctx;
	
	private boolean isMandatory;
	
	private boolean isQueryCriteria;
	
	private boolean isQueryAfterChange;
	
	private boolean isReadOnly;
	
	private boolean isDisplayed;
	
	private boolean isIdentifier;
	
	private boolean isKey;
	
	private boolean isAutocomplete;
	
	private int AD_Reference_ID;
	
	private int AD_Reference_Value_ID;
	
	private int SeqNoSelection;
	
	private int AD_InfoColumn_ID;
	
	private int AD_Val_Rule_ID;
	
	private int AD_FieldStyle_ID;
	
	private int AD_InfoWindow_ID;
	
	private int SeqNo;
	
	private String ColumnName;
	
	private String DisplayLogic;
	
	private String Name;
	
	private String NameTrl;
	
	private String Placeholder;
	
	private String PlaceHolderTrl;
	
	private String SelectClause;
	
	private String InputFieldValidation;
	
	private String QueryOperator;
	
	private String QueryFunction;
	
	private String Description;
	
	private String DescriptionTrl;
	
	private String DefaultValue;
	
	private String HelpTrl;
	
	private String Help;
	
	private String ValidationCode;
	
	private MInfoColumn infoColumn;

	/**
	 * Default Constructor
	 * @param ctx
	 * @param infoColumn
	 */
	public InfoColumnVO(Properties ctx, MInfoColumn infoColumn) {
		this.ctx = ctx;
		this.infoColumn = infoColumn;
		
		AD_InfoColumn_ID = infoColumn.getAD_InfoColumn_ID();
		AD_InfoWindow_ID = infoColumn.getAD_InfoWindow_ID();
		ColumnName = infoColumn.getColumnName();
		isMandatory = infoColumn.isMandatory();
		isQueryCriteria = infoColumn.isQueryCriteria();
		isQueryAfterChange = infoColumn.isQueryAfterChange();
		NameTrl = infoColumn.get_Translation("Name");
		Name = infoColumn.getName();
		AD_Reference_ID = infoColumn.getAD_Reference_ID();
		AD_Reference_Value_ID = infoColumn.getAD_Reference_Value_ID();
		PlaceHolderTrl = infoColumn.get_Translation("Placeholder");
		Placeholder = infoColumn.getPlaceholder();
		isReadOnly = infoColumn.isReadOnly();
		SelectClause = infoColumn.getSelectClause();
		DisplayLogic = infoColumn.getDisplayLogic();
		isDisplayed = infoColumn.isDisplayed();
		InputFieldValidation = infoColumn.getInputFieldValidation();
		isIdentifier = infoColumn.isIdentifier();
		QueryOperator = infoColumn.getQueryOperator();
		SeqNoSelection = infoColumn.getSeqNoSelection();
		QueryFunction = infoColumn.getQueryFunction();
		Description = infoColumn.getDescription();
		DescriptionTrl = infoColumn.get_Translation("Description");
		isKey = infoColumn.isKey();
		DefaultValue = infoColumn.getDefaultValue();
		HelpTrl = infoColumn.get_Translation("Help");
		Help = infoColumn.getHelp();
		AD_FieldStyle_ID = infoColumn.getAD_FieldStyle_ID();
		isAutocomplete = infoColumn.isAutocomplete();
		SeqNo = infoColumn.getSeqNo();
		AD_Val_Rule_ID = infoColumn.getAD_Val_Rule_ID();		
		if (infoColumn.getAD_Val_Rule_ID() > 0)
			ValidationCode  = MValRule.get(ctx, infoColumn.getAD_Val_Rule_ID()).getCode();
		
		
		this.afterCreate();
	}
	
	/**
	 * User Customization Processing
	 * @return InfoColumnVO
	 */
	public InfoColumnVO afterCreate() {
		InfoColumnVO vo = this;

		// InfoColumn Customization
		MUserDefInfoColumn userDef = null;
		userDef = MUserDefInfoColumn.get(vo.ctx,vo.AD_InfoColumn_ID, vo.AD_InfoWindow_ID);
		if (userDef != null)
		{
			if (userDef.getName() != null)
				vo.Name = userDef.getName();
			if (userDef.get_Translation("Name") != null)
				vo.NameTrl = userDef.get_Translation("Name");
			if (userDef.getDescription() != null)
				vo.Description = userDef.getDescription();
			if (userDef.get_Translation("Description") != null)
				vo.DescriptionTrl = userDef.get_Translation("Description");
			if (userDef.getHelp() != null)
				vo.Help = userDef.getHelp();
			if (userDef.get_Translation("Help") != null)
				vo.HelpTrl = userDef.get_Translation("Help");
			if (userDef.getDisplayLogic() != null)
				vo.DisplayLogic = userDef.getDisplayLogic();
			if (userDef.getDefaultValue() != null)
				vo.DefaultValue = userDef.getDefaultValue();
			if (userDef.getIsDisplayed()!= null)
			    vo.isDisplayed = "Y".equals(userDef.getIsDisplayed());
			if (userDef.getIsReadOnly()!= null)
			    vo.isReadOnly = "Y".equals(userDef.getIsReadOnly());
			if (userDef.getAD_Reference_ID()>0)
				vo.AD_Reference_ID = userDef.getAD_Reference_ID();
			if (userDef.getAD_Reference_Value_ID()>0)
				vo.AD_Reference_Value_ID = userDef.getAD_Reference_Value_ID();
			if (userDef.getIsMandatory()!= null)
				vo.isMandatory = "Y".equals(userDef.getIsMandatory());
			if (userDef.getSeqNo() > 0)
			    vo.SeqNo= userDef.getSeqNo();
			if (userDef.getSeqNoSelection() > 0)
			    vo.SeqNoSelection= userDef.getSeqNoSelection();
			if (userDef.getAD_Val_Rule_ID() > 0) {
				vo.ValidationCode = MValRule.get(vo.ctx, userDef.getAD_Val_Rule_ID()).getCode();
				vo.AD_Val_Rule_ID = userDef.getAD_Val_Rule_ID();
			}
			if (userDef.getAD_FieldStyle_ID() > 0)
				vo.AD_FieldStyle_ID = userDef.getAD_FieldStyle_ID();
			if (userDef.getPlaceholder() != null)
				vo.Placeholder = userDef.getPlaceholder();
			if (userDef.get_Translation("Placeholder") != null)
				vo.PlaceHolderTrl = userDef.get_Translation("Placeholder");
			if (userDef.getInputFieldValidation() != null)
				vo.InputFieldValidation = userDef.getInputFieldValidation();
			if (userDef.getIsQueryCriteria() != null)
				vo.isQueryCriteria = "Y".equals(userDef.getIsQueryCriteria());
			if (userDef.getIsQueryAfterChange() != null)
				vo.isQueryAfterChange = "Y".equals(userDef.getIsQueryAfterChange());
			if (userDef.getQueryFunction()!= null)
				vo.QueryFunction= userDef.getQueryFunction();
			if (userDef.getQueryOperator()!= null)
				vo.QueryOperator= userDef.getQueryOperator();
			if (userDef.getIsAutocomplete() != null)
				vo.isAutocomplete = "Y".equals(userDef.getIsAutocomplete());
		}
		//
		return vo;
	}
	

	/**
	 * Create InfoColumnVO Array from MInfoColumn Array
	 * @param ctx Properties
	 * @param p_infoColumns Array of MInfoColumn
	 * @return InfoColumnVO[]
	 */
	public static InfoColumnVO[] create(Properties ctx, MInfoColumn[] p_infoColumns) {
		ArrayList<InfoColumnVO> infoColumns = new ArrayList<InfoColumnVO>();
		for(MInfoColumn p_infoColumn : p_infoColumns) {
			InfoColumnVO infoColumn = new InfoColumnVO(ctx, p_infoColumn);
			infoColumns.add(infoColumn);			
		}
		
		infoColumns.sort(new Comparator<InfoColumnVO>() {

			@Override
			public int compare(InfoColumnVO o1, InfoColumnVO o2) {
				Integer o1SeqNo = Integer.valueOf(o1.getSeqNo());
				Integer o2SeqNo = Integer.valueOf(o2.getSeqNo());
				return o1SeqNo.compareTo(o2SeqNo);
			}
		});
		
		return infoColumns.toArray(new InfoColumnVO[infoColumns.size()]);
	}
	

	/**
	 * @param ctx
	 * @param windowNo
	 * @return boolean
	 */
	public boolean isDisplayed(final Properties ctx, final int windowNo) {
		if (!isDisplayed())
			return false;
		
		if (getDisplayLogic() == null || getDisplayLogic().trim().length() == 0)
			return true;
		
		Evaluatee evaluatee = new Evaluatee() {
			public String get_ValueAsString(String variableName) {
				return Env.getContext (ctx, windowNo, variableName, true);
			}
		};
		
		boolean retValue = Evaluator.evaluateLogic(evaluatee, getDisplayLogic());
		return retValue;
	}

	public String getColumnName() {
		return ColumnName;
	}

	public boolean isMandatory() {
		return isMandatory;
	}

	public boolean isQueryCriteria() {
		return isQueryCriteria;
	}

	public boolean isQueryAfterChange() {
		return isQueryAfterChange;
	}
	
	public String getNameTrl() {
		return NameTrl;
	}

	public String getName() {
		return Name;
	}

	public int getAD_Reference_ID() {
		return AD_Reference_ID;
	}

	public int getAD_Reference_Value_ID() {
		return AD_Reference_Value_ID;
	}

	public String getPlaceHolderTrl() {
		return PlaceHolderTrl;
	}

	public String getPlaceholder() {
		return Placeholder;
	}

	public boolean isReadOnly() {
		return isReadOnly;
	}

	public String getSelectClause() {
		return SelectClause;
	}

	public String getDisplayLogic() {
		return DisplayLogic;
	}

	public boolean isDisplayed() {
		return isDisplayed;
	}

	public String getInputFieldValidation() {
		return InputFieldValidation;
	}

	public boolean isIdentifier() {
		return isIdentifier;
	}

	public String getQueryOperator() {
		return QueryOperator;
	}

	public int getSeqNoSelection() {
		return SeqNoSelection;
	}

	public String getQueryFunction() {
		return QueryFunction;
	}

	public boolean isKey() {
		return isKey;
	}

	public String getDescription() {
		return Description;
	}

	public String getDescriptionTrl() {
		return DescriptionTrl;
	}

	public MInfoColumn getAD_InfoColumn() {
		return infoColumn;
	}

	public int getAD_Val_Rule_ID() {
		return AD_Val_Rule_ID;
	}

	public String getDefaultValue() {
		return DefaultValue;
	}

	public String getHelpTrl() {
		return HelpTrl;
	}

	public String getHelp() {
		return Help;
	}

	public int getAD_FieldStyle_ID() {
		return AD_FieldStyle_ID;
	}

	public boolean isAutocomplete() {
		return isAutocomplete;
	}

	public int getAD_InfoColumn_ID() {
		return AD_InfoColumn_ID;
	}

	public String getValidationCode() {
		return ValidationCode;
	}

	public int getSeqNo() {
		return SeqNo;
	}
}
