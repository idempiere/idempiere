/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.compiere.apps.form;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.model.GridField;
import org.compiere.model.I_AD_Field;
import org.compiere.model.MField;
import org.compiere.model.MTab;
import org.compiere.model.MUserDefField;
import org.compiere.model.X_AD_FieldGroup;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *
 * @author Juan David Arboleda
 * @author Carlos Ruiz
 *
 */
public class TabEditor
{

	public MTab m_tab;

	/**	Logger			*/
	public static final CLogger log = CLogger.getCLogger(TabEditor.class);

	private List<MField> fields = new ArrayList<MField>();
	
	private List<GridField> gridFields = new ArrayList<GridField>();
	
	private MField m_activeField;
	
	private Map<Integer, MField> mapField = new HashMap<Integer, MField>();
	
	private Map<Integer, GridField> mapGridField = new HashMap<Integer, GridField>();
	
	protected boolean isBaseLang = Env.isBaseLanguage(Env.getCtx(), null);

	protected boolean isSystem = true;

	protected int AD_UserDef_Tab_ID;

	public List<GridField> getGridFields() {
		return gridFields;
	}

	public MTab getMTab() {
		return m_tab;
	}

	public List<MField> getMFields() {

		return fields;
	}

	protected void initMFields(int windowNo, int tabid) {
		m_tab = new MTab(Env.getCtx(), tabid, null);
		GridField[] l_gridFields = GridField.createFields(Env.getCtx(), windowNo, 0, tabid);
		for (GridField gridField : l_gridFields) {
			gridFields.add(gridField);
			mapGridField.put(gridField.getAD_Field_ID(), gridField);
			MField field = new MField(Env.getCtx(), gridField.getAD_Field_ID(), null);
			
			// load translated values and ovewrite field with it
			if (!isBaseLang) 
			{
				field.setName(field.get_Translation(MField.COLUMNNAME_Name, Env.getLanguage(Env.getCtx()).getAD_Language(), true));
				field.setDescription(field.get_Translation(MField.COLUMNNAME_Description, Env.getLanguage(Env.getCtx()).getAD_Language(), true));
				field.setPlaceholder(field.get_Translation(MField.COLUMNNAME_Placeholder, Env.getLanguage(Env.getCtx()).getAD_Language(), true));
				field.setHelp(field.get_Translation(MField.COLUMNNAME_Help, Env.getLanguage(Env.getCtx()).getAD_Language(), true));
				gridField.getVO().Header = field.get_Translation(MField.COLUMNNAME_Name, Env.getLanguage(Env.getCtx()).getAD_Language(), true);
				gridField.getVO().Description = field.get_Translation(MField.COLUMNNAME_Description, Env.getLanguage(Env.getCtx()).getAD_Language(), true);
				gridField.getVO().Placeholder = field.get_Translation(MField.COLUMNNAME_Placeholder, Env.getLanguage(Env.getCtx()).getAD_Language(), true);
				gridField.getVO().Help = field.get_Translation(MField.COLUMNNAME_Help, Env.getLanguage(Env.getCtx()).getAD_Language(), true);
			}

			// if not system level load customization values and field with it
			if (!isSystem) {
				field = loadUserDefField(field);
				if (field != null)
				{
					gridField.getVO().Header = field.getName();
					gridField.getVO().Description = field.getDescription();
					gridField.getVO().Placeholder = field.getPlaceholder();
					gridField.getVO().Help = field.getHelp();
					gridField.getVO().NumLines = field.getNumLines();
					gridField.getVO().XPosition = field.getXPosition();
					gridField.getVO().ColumnSpan = field.getColumnSpan();
					gridField.getVO().IsDisplayed = field.isDisplayed();
					gridField.getVO().FieldGroup = getFieldGroup(field);
					gridField.getVO().FieldGroupType = getFieldGroupType(field);
				} 
			}
			
			fields.add(field);
			mapField.put(field.getAD_Field_ID(), field);
			gridField.getVO().IsReadOnly = true;
			gridField.getVO().IsMandatory = false;
			gridField.getVO().IsUpdateable = false;
			gridField.getVO().IsAlwaysUpdateable = false;
		}
		resortArrays();
	}

	public boolean cmd_save() {
			for (MField field : fields) {
				if (field.isActive()) {
					if (isSystem) {
						updateTrl(field);
						field.saveEx();
					} else {
						saveUserDefField(field);
					}
				}
			}
		return true;
	}

	protected MField getMField(int fieldid) {
		return mapField.get(fieldid);
	}

	protected GridField getGridField(MField field) {
		return mapGridField.get(field.getAD_Field_ID());
	}

	public MField getActiveMField() {
		return m_activeField;
	}

	protected void setActiveMField(MField field) {
		m_activeField = field;
	}

	protected void resortArrays() {
		Collections.sort(fields, new Comparator<MField>() {
			@Override
			public int compare(MField field1, MField field2) {
				String compare1 = String.format("%s%10d%s",
						(field1.isDisplayed() ? "0" : "1"), 
						(field1.isDisplayed() ? field1.getSeqNo() : 0),
						field1.getName());
				String compare2 = String.format("%s%10d%s",
						(field2.isDisplayed() ? "0" : "1"), 
						(field2.isDisplayed() ? field2.getSeqNo() : 0),
						field2.getName());
				return compare1.compareTo(compare2);
			}
		});
		// only apply the SeqNo increment when running on system level
		if (isSystem) {
			int seq = 10;
			for (MField field : fields) {
				if (field.isDisplayed()) {
					field.setSeqNo(seq);
					seq = seq + 10;
				} else {
					field.setSeqNo(0);
				}
			}
		}

		Collections.sort(gridFields, new Comparator<GridField>() {
			@Override
			public int compare(GridField f1, GridField f2) {
				MField field1 = getMField(f1.getAD_Field_ID());
				MField field2 = getMField(f2.getAD_Field_ID());
				String compare1 = String.format("%s%10d%s",
						(field1.isDisplayed() ? "0" : "1"), 
						(field1.isDisplayed() ? field1.getSeqNo() : 0),
						field1.getName());
				String compare2 = String.format("%s%10d%s",
						(field2.isDisplayed() ? "0" : "1"), 
						(field2.isDisplayed() ? field2.getSeqNo() : 0),
						field2.getName());
				return compare1.compareTo(compare2);
			}
		});

	}

	/**
	 * Load MUserDefField data to MField
	 *
	 * @param field
	 * @return MField
	 */
	protected MField loadUserDefField(MField field) {

		if (field == null)
		{
			return null;
		}

		MUserDefField userDefField = MUserDefField.get(Env.getCtx(), field.getAD_Field_ID(), m_tab.getAD_Tab_ID(), m_tab.getAD_Window_ID(), true);

		if (userDefField != null) {
			if (userDefField.getName() != null)
				field.setName(userDefField.getName());

			if (userDefField.getDescription() != null)
				field.setDescription(userDefField.getDescription());

			if (userDefField.getHelp() != null)
				field.setHelp(userDefField.getHelp());

			if (userDefField.getPlaceholder() != null)
				field.setPlaceholder(userDefField.getPlaceholder());

			field.setIsActive(userDefField.isActive());
			field.setDisplayLogic(userDefField.getDisplayLogic());
			field.setDisplayLength(userDefField.getDisplayLength());
			field.setIsDisplayed(userDefField.getIsDisplayed() == null ? field.isDisplayed()
					: "Y".equals(userDefField.getIsDisplayed()));
			field.setIsReadOnly(userDefField.getIsReadOnly() == null ? field.isReadOnly()
					: "Y".equals(userDefField.getIsReadOnly()));
			field.setSeqNo(userDefField.getSeqNo() != 0 ? userDefField.getSeqNo() : field.getSeqNo());
			field.setXPosition(userDefField.getXPosition() > 0 ? userDefField.getXPosition():field.getXPosition());
			field.setNumLines(userDefField.getNumLines() > 0?userDefField.getNumLines():field.getNumLines());
			field.setColumnSpan(userDefField.getColumnSpan() > 0?userDefField.getColumnSpan():field.getColumnSpan());
			field.setSortNo(BigDecimal.valueOf(userDefField.getSortNo()));
			field.setReadOnlyLogic(userDefField.getReadOnlyLogic());
			field.setMandatoryLogic(userDefField.getMandatoryLogic());

			if (userDefField.getAD_FieldGroup_ID() > 0)
				field.setAD_FieldGroup_ID(userDefField.getAD_FieldGroup_ID());

		}

		return field;
	}

	/**
	 * Convert MField to MUserDefField and save
	 *
	 * @param field
	 */
	protected void saveUserDefField(MField field) {
		
		MField defaultField = new MField(Env.getCtx(), field.get_ID(), null);
		
		// check if translated values was really changed and restore default value if not
		if (field.getName() != null && field.getName().equals(defaultField.get_Translation(MField.COLUMNNAME_Name, Env.getAD_Language(Env.getCtx()), true)))
			field.setName(defaultField.getName());
		if (field.getDescription() != null && field.getDescription().equals(defaultField.get_Translation(MField.COLUMNNAME_Description, Env.getAD_Language(Env.getCtx()), true)))
			field.setDescription(defaultField.getDescription());
		if (field.getHelp() != null && field.getHelp().equals(defaultField.get_Translation(MField.COLUMNNAME_Help, Env.getAD_Language(Env.getCtx()), true)))
			field.setHelp(defaultField.getHelp());
		if (field.getPlaceholder() != null && field.getPlaceholder().equals(defaultField.get_Translation(MField.COLUMNNAME_Placeholder, Env.getAD_Language(Env.getCtx()), true)))
			field.setPlaceholder(defaultField.getPlaceholder());
				
		if (!field.is_Changed())
			return;

		MUserDefField udfield = MUserDefField.get(Env.getCtx(), field.getAD_Field_ID(), m_tab.getAD_Tab_ID(), m_tab.getAD_Window_ID(), true);
		int AD_UserDef_Field_ID = 0;
		if (udfield != null)
			AD_UserDef_Field_ID = udfield.getAD_UserDef_Field_ID();
		
		udfield = new MUserDefField(Env.getCtx(), AD_UserDef_Field_ID, null);
		
		if (field.getName() != null)
			udfield.setName(field.getName());

		if (field.getDescription() != null)
			udfield.setDescription(field.getDescription());

		if (field.getHelp() != null)
			udfield.setHelp(field.getHelp());

		if (field.getPlaceholder() != null)
			udfield.setPlaceholder(field.getPlaceholder());

		udfield.setIsActive(field.isActive());
		udfield.setDisplayLogic(field.getDisplayLogic());
		udfield.setDisplayLength(field.getDisplayLength());
		udfield.setIsDisplayed(field.isDisplayed() ? "Y" : "N");
		udfield.setIsReadOnly(field.isReadOnly() ? "Y" : "N");
		udfield.setAD_Field_ID(field.get_ID());
		udfield.setSeqNo(field.getSeqNo());
		udfield.setXPosition(field.getXPosition());
		udfield.setNumLines(field.getNumLines());
		udfield.setColumnSpan(field.getColumnSpan());
		udfield.setAD_UserDef_Tab_ID(AD_UserDef_Tab_ID);
		udfield.setSortNo(field.getSortNo().intValue());
		udfield.setAD_Org_ID(m_tab.getAD_Org_ID());
		udfield.setMandatoryLogic(field.getMandatoryLogic());
		udfield.setReadOnlyLogic(field.getReadOnlyLogic());

		if (field.getAD_FieldGroup_ID() > 0)
			udfield.setAD_FieldGroup_ID(field.getAD_FieldGroup_ID());
		else
			udfield.set_ValueOfColumn("ad_fieldgroup_id", null);

		udfield.saveEx();

	}

	/**
	 * When Tab Editor is called in System Role and not in Base Language, this
	 * method saves changes in ad_field_trl table when some change is made on translated field
	 *
	 * @param field
	 */
	private void updateTrl(MField field) {
		
		// only execute when is not base language		
		if (isBaseLang)
			return;
		
		// save current field values
		String name = field.getName();
		String description = field.getDescription();
		String help = field.getHelp();
		String placeholder = field.getPlaceholder();

		// original values for compare
		MField dbField = new MField(Env.getCtx(), field.getAD_Field_ID(), null);
		String nameDB = isBaseLang ? dbField.getName() : dbField.get_Translation(MField.COLUMNNAME_Name, Env.getAD_Language(Env.getCtx()), true);
		String descriptionDB = isBaseLang ? dbField.getDescription() : dbField.get_Translation(MField.COLUMNNAME_Description, Env.getAD_Language(Env.getCtx()), true);
		String helpDB = isBaseLang ? dbField.getHelp() : dbField.get_Translation(MField.COLUMNNAME_Help, Env.getAD_Language(Env.getCtx()), true);
		String placeholderDB = isBaseLang ? dbField.getPlaceholder() : dbField.get_Translation(MField.COLUMNNAME_Placeholder, Env.getAD_Language(Env.getCtx()), true);

		// always restore db field values to avoid wrong changes
		field.setName(dbField.getName());
		field.setDescription(dbField.getDescription());
		field.setHelp(dbField.getHelp());
		field.setPlaceholder(dbField.getPlaceholder());
		
		// compare values when changed and restore the state if needed
		if (name != null && name.equals(nameDB))
		{
			name = null;
		}
		if (description != null && description.equals(descriptionDB))
		{
			description = null;
		}
		if (help != null && help.equals(helpDB))
		{
			help = null;
		}
		if (placeholder != null && placeholder.equals(placeholderDB))
		{
			placeholder = null;
		}
		
		// nothing to do if all fields are not changed
		if (name == null && description == null && help == null && placeholder == null)
			return;
		
		StringBuilder mainSQL = new StringBuilder("UPDATE ").append(field.get_TableName()).append("_Trl SET ");
		
		StringBuilder setSQL = new StringBuilder();
		if (name != null)
		{
			setSQL.append(I_AD_Field.COLUMNNAME_Name).append("='").append(name).append("' ");
		}
		
		if(description != null)
		{
			if (setSQL.length() > 0)
				setSQL.append(",");		
			setSQL.append(I_AD_Field.COLUMNNAME_Description).append("='").append(description).append("' ");
		}

		if(help != null)
		{
			if (setSQL.length() > 0)
				setSQL.append(",");		
			setSQL.append(I_AD_Field.COLUMNNAME_Help).append("='").append(help).append("' ");
		}

		if(placeholder != null)
		{
			if (setSQL.length() > 0)
				setSQL.append(",");		
			setSQL.append(I_AD_Field.COLUMNNAME_Placeholder).append("='").append(placeholder).append("' ");
		}

		if (setSQL.length() > 0)
			setSQL.append(",");		

		setSQL.append(I_AD_Field.COLUMNNAME_Updated).append("=").append(DB.TO_DATE(new Timestamp(System.currentTimeMillis()), false)).append(", ");
		setSQL.append(I_AD_Field.COLUMNNAME_UpdatedBy).append("=").append(Env.getAD_User_ID(Env.getCtx()));

		mainSQL.append(setSQL.toString());

		mainSQL.append(" WHERE ").append(I_AD_Field.COLUMNNAME_AD_Field_ID).append("=").append(field.getAD_Field_ID()).append(" AND AD_Language ='").append(Env.getAD_Language(Env.getCtx())).append("'");

		//	Execute
		int no = DB.executeUpdate(mainSQL.toString(), null);
		if (no == 1)
		{
			if (log.isLoggable(Level.FINE)) log.fine(mainSQL.toString());
		}
		else if (no == 0)
			log.warning ("Not Found - " + mainSQL.toString());
		else
			log.severe ("Update Rows=" + no + " (Should be 1) - " + mainSQL.toString());
	}

	/**
	 * Update the current field list with new reloaded values for a field
	 * 
	 * @param field
	 */
	public void updateFieldList(MField field) {
		for (MField lstField : fields) {
			if (lstField.getAD_Field_ID() == field.getAD_Field_ID()) {
				lstField.setName(field.getName());
				lstField.setDescription(field.getDescription());
				lstField.setHelp(field.getHelp());
				lstField.setPlaceholder(field.getPlaceholder());
				lstField.setIsActive(field.isActive());
				lstField.setDisplayLogic(field.getDisplayLogic());
				lstField.setDisplayLength(field.getDisplayLength());
				lstField.setIsDisplayed(field.isDisplayed());
				lstField.setIsReadOnly(field.isReadOnly());
				lstField.setSeqNo(field.getSeqNo());
				lstField.setXPosition(field.getXPosition());
				lstField.setNumLines(field.getNumLines());
				lstField.setColumnSpan(field.getColumnSpan());
				lstField.setSortNo(field.getSortNo());
				mapField.put(lstField.get_ID(), lstField);
			}
		}
	}

	/** Return the name of the group field of the field */
	public String getFieldGroup(MField field) {
		if (field.getAD_FieldGroup_ID() > 0) {
    		if (isBaseLang) 
				return field.getAD_FieldGroup().getName();
    		else
				return ((X_AD_FieldGroup) field.getAD_FieldGroup()).get_Translation(X_AD_FieldGroup.COLUMNNAME_Name);
		}
		return "";
	}

	/** Return the type of the group field of the field */
	public String getFieldGroupType(MField field) {
		if (field.getAD_FieldGroup_ID() > 0)
			return field.getAD_FieldGroup().getFieldGroupType();
		return "";
	}
	
} // TabEditor
