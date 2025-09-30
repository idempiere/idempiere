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

import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.DisplayType;
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
	private static final long serialVersionUID = 304775780197602066L;

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
	
	private boolean isRange;
	
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
	
	private String Placeholder2;
	
	private String PlaceHolderTrl;
	
	private String SelectClause;
	
	private String InputFieldValidation;
	
	private String QueryOperator;
	
	private String QueryFunction;
	
	private String Description;
	
	private String DescriptionTrl;
	
	private String DefaultValue;
	
	private String DefaultValue2;
	
	private String HelpTrl;
	
	private String Help;
	
	private String ValidationCode;
	
	private String EntityType;

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
		Placeholder2 = infoColumn.getPlaceholder2();
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
		DefaultValue2 = infoColumn.getDefaultValue2();
		HelpTrl = infoColumn.get_Translation("Help");
		Help = infoColumn.getHelp();
		AD_FieldStyle_ID = infoColumn.getAD_FieldStyle_ID();
		isAutocomplete = infoColumn.isAutocomplete();
		SeqNo = infoColumn.getSeqNo();
		AD_Val_Rule_ID = infoColumn.getAD_Val_Rule_ID();
		EntityType = infoColumn.getEntityType();
		if (infoColumn.getAD_Val_Rule_ID() > 0)
			ValidationCode  = MValRule.get(ctx, infoColumn.getAD_Val_Rule_ID()).getCode();
		// Range is supported only for Date and Numeric Reference Types + operator "=" must be selected
		if(QueryOperator != null && QueryOperator.equals(MInfoColumn.QUERYOPERATOR_Eq) 
				&& (DisplayType.isDate(AD_Reference_ID) || DisplayType.isNumeric(AD_Reference_ID)))
			isRange = infoColumn.isRange();
		else
			isRange = false;
		
		
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
			vo.EntityType = vo.EntityType + "**U**";
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
	 * @return true if column should be displayed
	 */
	public boolean isDisplayed(final Properties ctx, final int windowNo) {
		if (!isDisplayed())
			return false;
		
		if (getDisplayLogic() == null || getDisplayLogic().trim().length() == 0)
			return true;
		
		Evaluatee evaluatee = (variableName) -> {
			DefaultEvaluatee de = new DefaultEvaluatee(null, windowNo, -1, true);
			return de.get_ValueAsString(ctx, variableName);
		};
				
		boolean retValue = Evaluator.evaluateLogic(evaluatee, getDisplayLogic());
		return retValue;
	}

	/**
	 * @return column name
	 */
	public String getColumnName() {
		return ColumnName;
	}

	/**
	 * @return true if column is mandatory
	 */
	public boolean isMandatory() {
		return isMandatory;
	}

	/**
	 * @return true if this is for user to enter query criteria
	 */
	public boolean isQueryCriteria() {
		return isQueryCriteria;
	}

	/**
	 * @return true if info window should auto execute query after user have make changes to this info column
	 */
	public boolean isQueryAfterChange() {
		return isQueryAfterChange;
	}
	
	/**
	 * @return translated name (in login language)
	 */
	public String getNameTrl() {
		return NameTrl;
	}

	/**
	 * @return name
	 */
	public String getName() {
		return Name;
	}

	/**
	 * @return AD_Reference_ID
	 */
	public int getAD_Reference_ID() {
		return AD_Reference_ID;
	}

	/**
	 * @return AD_Reference_Value_ID
	 */
	public int getAD_Reference_Value_ID() {
		return AD_Reference_Value_ID;
	}

	/**
	 * @return translated place holder text (in login language)
	 */
	public String getPlaceHolderTrl() {
		return PlaceHolderTrl;
	}

	/**
	 * @return place holder text
	 */
	public String getPlaceholder() {
		return Placeholder;
	}
	
	/**
	 * @return place holder text for to editor of range type column
	 */
	public String getPlaceholder2() {
		return Placeholder2;
	}

	/**
	 * @return true if column is read only
	 */
	public boolean isReadOnly() {
		return isReadOnly;
	}

	/**
	 * @return select clause
	 */
	public String getSelectClause() {
		return SelectClause;
	}

	/**
	 * @return display logic
	 */
	public String getDisplayLogic() {
		return DisplayLogic;
	}

	/**
	 * @return true if visible
	 */
	public boolean isDisplayed() {
		return isDisplayed;
	}

	/**
	 * @return SQL validation for input field
	 */
	public String getInputFieldValidation() {
		return InputFieldValidation;
	}

	/**
	 * @return true if column is identifier
	 */
	public boolean isIdentifier() {
		return isIdentifier;
	}

	/**
	 * @return query operator (=, &lt;, &gt;, etc)
	 */
	public String getQueryOperator() {
		return QueryOperator;
	}

	/**
	 * @return sequence for query criteria
	 */
	public int getSeqNoSelection() {
		return SeqNoSelection;
	}

	/**
	 * @return SQL function for query criteria field
	 */
	public String getQueryFunction() {
		return QueryFunction;
	}

	/**
	 * @return true if this is a key column
	 */
	public boolean isKey() {
		return isKey;
	}

	/**
	 * @return description text
	 */
	public String getDescription() {
		return Description;
	}

	/**
	 * @return translated description text
	 */
	public String getDescriptionTrl() {
		return DescriptionTrl;
	}

	/**
	 * @return MInfoColumn
	 */
	public MInfoColumn getAD_InfoColumn() {
		return infoColumn;
	}

	/**
	 * @return AD_Val_Rule_ID
	 */
	public int getAD_Val_Rule_ID() {
		return AD_Val_Rule_ID;
	}

	/**
	 * @return default value
	 */
	public String getDefaultValue() {
		return DefaultValue;
	}
	
	/**
	 * @return default value for to editor of range type column
	 */
	public String getDefaultValue2() {
		return DefaultValue2;
	}

	/**
	 * @return translated help text (in login language)
	 */
	public String getHelpTrl() {
		return HelpTrl;
	}

	/**
	 * @return help text
	 */
	public String getHelp() {
		return Help;
	}

	/**
	 * @return AD_FieldStyle_ID
	 */
	public int getAD_FieldStyle_ID() {
		return AD_FieldStyle_ID;
	}

	/**
	 * @return true if auto complete is on for lookup field
	 */
	public boolean isAutocomplete() {
		return isAutocomplete;
	}

	/**
	 * @return AD_InfoColumn_ID
	 */
	public int getAD_InfoColumn_ID() {
		return AD_InfoColumn_ID;
	}

	/**
	 * @return validation code for lookup
	 */
	public String getValidationCode() {
		return ValidationCode;
	}

	/**
	 * @return sequence number
	 */
	public int getSeqNo() {
		return SeqNo;
	}
	

	public String getEntityType() {
		return EntityType;
	}
	
	public void setEntityType(String entityType) {
		EntityType = entityType;
	}

	/**
	 * @return true if this is a range type column
	 */
	public boolean isRange() {
		return isRange;
	}
}
