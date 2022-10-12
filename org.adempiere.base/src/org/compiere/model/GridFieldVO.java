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
 * @contributor Victor Perez , e-Evolution.SC FR [ 1757088 ]                  *
 *****************************************************************************/
package org.compiere.model;

import static org.compiere.model.SystemIDs.REFERENCE_AD_USER;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;


/**
 *  Field Model Value Object
 *
 *  @author Jorg Janke
 *  @author Victor Perez , e-Evolution.SC FR [ 1757088 ] , [1877902] Implement JSR 223 Scripting APIs to Callout
 *  @author Carlos Ruiz, qss FR [1877902]
 *  @author Juan David Arboleda (arboleda), GlobalQSS, [ 1795398 ] Process Parameter: add display and readonly logic
 *  @see  https://sourceforge.net/p/adempiere/feature-requests/318/ to FR [1877902]
 *  @version  $Id: GridFieldVO.java,v 1.3 2006/07/30 00:58:04 jjanke Exp $
 */
public class GridFieldVO implements Serializable, Cloneable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4069340866487289281L;

	/**
	 *  Return the SQL statement used for the MFieldVO.create
	 *  @param ctx context
	 *  @return SQL with or w/o translation and 1 parameter
	 */
	public static String getSQL (Properties ctx)
	{
		//	IsActive is part of View
		MRole role = MRole.getDefault(ctx, false);
		String advancedFilter=" AND IsAdvancedField='N' ";
		StringBuilder sql;
		if (!Env.isBaseLanguage(ctx, "AD_Tab")){
			sql = new StringBuilder("SELECT * FROM AD_Field_vt WHERE AD_Tab_ID=?")
				.append(" AND AD_Language='" + Env.getAD_Language(ctx) + "'");
			if (!role.isAccessAdvanced()) {
				sql.append(advancedFilter);
			}
			sql.append(" ORDER BY IsDisplayed DESC, SeqNo");
		}
		else{
			sql = new StringBuilder("SELECT * FROM AD_Field_v WHERE AD_Tab_ID=?");
			if (!role.isAccessAdvanced()) {
				sql.append(advancedFilter);
			}
			sql.append(" ORDER BY IsDisplayed DESC, SeqNo");
		}
		return sql.toString();
	}   //  getSQL


	/**
	 *  Create Field Value Object.
	 *  The vo return is not safe to cache directly or through clone
	 *  @param ctx context
	 *  @param WindowNo window
	 *  @param TabNo tab
	 *  @param AD_Window_ID window
	 *  @param AD_Tab_ID tab
	 *  @param readOnly r/o
	 *  @param rs resultset AD_Field_v/AD_Field_vt
	 *  @return GridFieldVO
	 */
	public static GridFieldVO create (Properties ctx, int WindowNo, int TabNo, 
		int AD_Window_ID, int AD_Tab_ID, boolean readOnly, ResultSet rs)
	{
		GridFieldVO vo = createFromResultSet(ctx, WindowNo, TabNo, AD_Window_ID, AD_Tab_ID, readOnly, rs);
		
		return vo.afterCreate();
	}   //  create

	/**
	 * Additional processing after a new vo have been created from db or cloned from cache
	 * This include asp customization, user customization and loading of lookup info. 
	 * @return GridFieldVO
	 */
	public GridFieldVO afterCreate() {
		GridFieldVO vo = this;
		// ASP
		if (vo.IsDisplayed) {
			MClient client = MClient.get(ctx);
			// ASP for fields has a different approach - it must be defined as a field but hidden
			//   in order to have the proper context variable filled with defaults
			// Validate field and put IsDisplayed=N if must be hidden
			if (! client.isDisplayField(vo.AD_Field_ID))
				vo.IsDisplayed = false;
		}
		// FR IDEMPIERE-177
		// Field Customization
		MUserDefField userDef = MUserDefField.get(vo.ctx,vo.AD_Field_ID, vo.AD_Tab_ID, vo.AD_Window_ID);
		if (userDef != null)
		{
			if (userDef.getName() != null)
				vo.Header = userDef.getName();
			if (userDef.getDescription() != null)
				vo.Description = userDef.getDescription();
			if (userDef.getHelp() != null)
				vo.Help = userDef.getHelp();
			if (userDef.getDisplayLength() > 0)
				vo.DisplayLength = userDef.getDisplayLength();
			if (userDef.getDisplayLogic() != null)
				vo.DisplayLogic = userDef.getDisplayLogic();
			if (userDef.getDefaultValue() != null)
				vo.DefaultValue = userDef.getDefaultValue();
			if (userDef.getSortNo() > 0)
				vo.SortNo = userDef.getSortNo();
			//IDEMPIERE-163
			if (userDef.getIsDisplayed()!= null)
				vo.IsDisplayed = "Y".equals(userDef.getIsDisplayed());
			if (userDef.getIsReadOnly()!= null)
				vo.IsReadOnly = "Y".equals(userDef.getIsReadOnly());
			if (userDef.getIsSameLine()!= null)
				vo.IsSameLine = "Y".equals(userDef.getIsSameLine());
			if (userDef.getIsUpdateable()!= null)
				vo.IsUpdateable = "Y".equals(userDef.getIsUpdateable());
			if (userDef.getIsAlwaysUpdateable()!= null)	
				vo.IsAlwaysUpdateable = "Y".equals(userDef.getIsAlwaysUpdateable());
			if(userDef.getAlwaysUpdatableLogic()!=null)
				vo.AlwaysUpdatableLogic = userDef.getAlwaysUpdatableLogic();
			if (userDef.getReadOnlyLogic()!= null)
				vo.ReadOnlyLogic = userDef.getReadOnlyLogic();
			if (userDef.getMandatoryLogic()!= null )
				vo.MandatoryLogic = userDef.getMandatoryLogic();	
			if (userDef.getAD_Reference_ID()>0)
				vo.displayType = userDef.getAD_Reference_ID();
			if (userDef.getAD_Reference_Value_ID()>0)
				vo.AD_Reference_Value_ID = userDef.getAD_Reference_Value_ID();
			if (userDef.getIsMandatory()!= null)
				vo.IsMandatory = "Y".equals(userDef.getIsMandatory());
			if (userDef.getXPosition() > 0)
				vo.XPosition = userDef.getXPosition();
			if (userDef.getColumnSpan() > 0)
				vo.ColumnSpan=userDef.getColumnSpan();
			if (userDef.getNumLines() > 0)
				vo.NumLines=userDef.getNumLines();
			if (userDef.getIsToolbarButton() != null)
				vo.IsToolbarButton  = userDef.getIsToolbarButton();
			if (userDef.getVFormat() != null)
				vo.VFormat = userDef.getVFormat();
			//IDEMPIERE-1120 Implement Field SeqNo customization
			if (userDef.getSeqNo() > 0)
				vo.SeqNo = userDef.getSeqNo();
			if (userDef.getIsDisplayedGrid() != null)
				vo.IsDisplayedGrid = "Y".equals(userDef.getIsDisplayedGrid());
			if (userDef.getSeqNoGrid() > 0)
				vo.SeqNoGrid = userDef.getSeqNoGrid();
			if (userDef.getAD_Val_Rule_ID() > 0)
				vo.ValidationCode  = MValRule.get(vo.ctx, userDef.getAD_Val_Rule_ID()).getCode();
			if (userDef.getAD_Val_Rule_Lookup_ID() > 0)
				vo.ValidationCodeLookup = MValRule.get(ctx, userDef.getAD_Val_Rule_Lookup_ID()).getCode();
			if (userDef.getAD_LabelStyle_ID() > 0)
				vo.AD_LabelStyle_ID = userDef.getAD_LabelStyle_ID();

			if (userDef.getAD_FieldStyle_ID() > 0)
				vo.AD_FieldStyle_ID = userDef.getAD_FieldStyle_ID();

			if (userDef.getPA_DashboardContent_ID() > 0)
				vo.PA_DashboardContent_ID = userDef.getPA_DashboardContent_ID();

			if (userDef.getPlaceholder() != null)
				vo.Placeholder = userDef.getPlaceholder();

			//devCoffee 8535
			if (userDef.getAD_FieldGroup_ID() > 0)
			{
				vo.FieldGroup = ((X_AD_FieldGroup)userDef.getAD_FieldGroup()).get_Translation(I_AD_FieldGroup.COLUMNNAME_Name);
				vo.FieldGroupType = userDef.getAD_FieldGroup().getFieldGroupType();
			}
			//fim devCoffee 8535

			if (userDef.getIsAutocomplete() != null)
				vo.IsAutocomplete = "Y".equals(userDef.getIsAutocomplete());
			if (userDef.getAD_Chart_ID() > 0)
				vo.AD_Chart_ID = userDef.getAD_Chart_ID();
		}
		//
		vo.initFinish();
		return vo;
	}

	/**
	 * Create GridFieldVO from db resultset. 
	 * No further processing is apply to the vo and the vo is safe to cache through clone 
	 * @param ctx
	 * @param WindowNo
	 * @param TabNo
	 * @param AD_Window_ID
	 * @param AD_Tab_ID
	 * @param readOnly
	 * @param rs
	 * @return GridFieldVO
	 */
	public static GridFieldVO createFromResultSet(Properties ctx, int WindowNo, int TabNo, int AD_Window_ID, int AD_Tab_ID,
			boolean readOnly, ResultSet rs) {
		GridFieldVO vo = new GridFieldVO (ctx, WindowNo, TabNo, 
			AD_Window_ID, AD_Tab_ID, readOnly);
		try
		{
			vo.ColumnName = rs.getString("ColumnName");
			if (vo.ColumnName == null)
				return null;

			vo.Header = rs.getString ("Name");
			vo.displayType = rs.getInt ("AD_Reference_ID");
			vo.AD_Column_ID = rs.getInt ("AD_Column_ID");
			vo.AD_Table_ID = rs.getInt ("AD_Table_ID");
			vo.DisplayLength = rs.getInt ("DisplayLength");
			vo.IsSameLine = "Y".equals(rs.getString ("IsSameLine"));
			vo.IsDisplayed = "Y".equals(rs.getString ("IsDisplayed"));
			vo.IsDisplayedGrid = "Y".equals(rs.getString ("IsDisplayedGrid"));
			vo.SeqNo = rs.getInt ("SeqNo");
			vo.SeqNoGrid = rs.getInt ("SeqNoGrid");
			vo.DisplayLogic = rs.getString ("DisplayLogic");
			vo.DefaultValue = rs.getString ("DefaultValue");
			vo.IsMandatory = "Y".equals(rs.getString ("IsMandatory"));
			vo.IsReadOnly = "Y".equals(rs.getString ("IsReadOnly"));
			vo.IsUpdateable = "Y".equals(rs.getString ("IsUpdateable"));
			vo.IsAlwaysUpdateable = "Y".equals(rs.getString ("IsAlwaysUpdateable"));
			vo.IsHeading = "Y".equals(rs.getString ("IsHeading"));
			vo.IsFieldOnly = "Y".equals(rs.getString ("IsFieldOnly"));
			vo.IsEncryptedField = "Y".equals(rs.getString ("IsEncryptedField"));
			vo.IsEncryptedColumn = "Y".equals(rs.getString ("IsEncryptedColumn"));
			vo.IsSelectionColumn = "Y".equals(rs.getString ("IsSelectionColumn"));
			vo.SeqNoSelection = rs.getInt ("SeqNoSelection");
			vo.SortNo = rs.getInt ("SortNo");
			vo.FieldLength = rs.getInt ("FieldLength");
			vo.VFormat = rs.getString ("VFormat");
			vo.FormatPattern = rs.getString ("FormatPattern");
			vo.ValueMin = rs.getString ("ValueMin");
			vo.ValueMax = rs.getString ("ValueMax");
			vo.FieldGroup = rs.getString ("FieldGroup");
			vo.FieldGroupType = rs.getString ("FieldGroupType");
			vo.IsKey = "Y".equals(rs.getString ("IsKey"));
			vo.IsParent = "Y".equals(rs.getString ("IsParent"));
			{
				String s = rs.getString ("Description");
				vo.Description = s != null ? s.intern() : s;
			}
			{
				String s = rs.getString ("Help");
				vo.Help = s != null ? s.intern() : s; 
			}
			vo.Callout = rs.getString ("Callout");
			vo.AD_Process_ID = rs.getInt ("AD_Process_ID");
			vo.AD_InfoWindow_ID = rs.getInt ("AD_InfoWindow_ID");
			vo.ReadOnlyLogic = rs.getString ("ReadOnlyLogic");
			vo.AlwaysUpdatableLogic = rs.getString ("AlwaysUpdatableLogic");
			vo.MandatoryLogic = rs.getString ("MandatoryLogic");	
			vo.ObscureType = rs.getString ("ObscureType");
			vo.IsDefaultFocus = "Y".equals(rs.getString("IsDefaultFocus"));
			vo.AD_Reference_Value_ID = rs.getInt("AD_Reference_Value_ID");
			vo.ValidationCode = rs.getString("ValidationCode");
			vo.ValidationCodeLookup = rs.getString("ValidationCodeLookup");
			vo.IsQuickForm = "Y".equals(rs.getString ("IsQuickForm"));
			{
				vo.ColumnSQL = rs.getString("ColumnSQL");
				if (vo.ColumnSQL != null && !vo.ColumnSQL.startsWith("@SQL=") && !vo.ColumnSQL.startsWith("@SQLFIND=") && vo.ColumnSQL.contains("@")) {
					// NOTE: cannot use window context because this is set globally on the query, not per record
					vo.ColumnSQL = Env.parseContext(ctx, -1, vo.ColumnSQL, false, true);
				}			
			} 
			//Feature Request FR [ 1757088 ]
			vo.Included_Tab_ID = rs.getInt("Included_Tab_ID");
			// Collapse Default State
			vo.IsCollapsedByDefault = "Y".equals(rs.getString("IsCollapsedByDefault"));
			// Feature Request FR [ 2003044 ]
			vo.IsAutocomplete  = "Y".equals(rs.getString("IsAutocomplete"));
			vo.IsAllowCopy  = "Y".equals(rs.getString("IsAllowCopy"));
			vo.AD_Field_ID = rs.getInt("AD_Field_ID");
			/*IDEMPIERE-358*/
			vo.XPosition=rs.getInt("XPosition");
			vo.ColumnSpan=rs.getInt("ColumnSpan");
			vo.NumLines=rs.getInt("NumLines");
			vo.IsToolbarButton  = rs.getString("IsToolbarButton");
			vo.AD_Chart_ID = rs.getInt ("AD_Chart_ID");
			vo.AD_LabelStyle_ID = rs.getInt ("AD_LabelStyle_ID");
			vo.AD_FieldStyle_ID = rs.getInt ("AD_FieldStyle_ID");
			vo.PA_DashboardContent_ID = rs.getInt ("PA_DashboardContent_ID");
			vo.Placeholder = rs.getString("Placeholder");
			vo.IsHtml = "Y".equals(rs.getString("IsHtml"));
			
			if (vo.Header == null)
				vo.Header = vo.ColumnName;
		}
		catch (SQLException e)
		{
			CLogger.get().log(Level.SEVERE, e.getMessage(), e);
			return null;
		}
		return vo;
	}

	/**
	 *  Init Field for Process Parameter
	 *  @param ctx context
	 *  @param WindowNo window
	 *  @param ProcessIDOfPanel
	 *  @param WindowIDOfPanel
	 *  @param InfoWindowIDOfPanel
	 *  @param rs result set AD_Process_Para
	 *  @return GridFieldVO
	 */
	public static GridFieldVO createParameter (Properties ctx, int WindowNo, int ProcessIDOfPanel, int WindowIDOfPanel, int InfoWindowIDOfPanel, ResultSet rs)
	{
		GridFieldVO vo = new GridFieldVO (ctx, WindowNo, 0, 0, 0, false);
		vo.isProcess = true;
		vo.IsDisplayed = true;
		vo.IsReadOnly = false;
		vo.IsUpdateable = true;
		vo.AD_Process_ID_Of_Panel = ProcessIDOfPanel;
		vo.AD_Window_ID_Of_Panel = WindowIDOfPanel;
		vo.AD_InfoWindow_ID_Of_Panel = InfoWindowIDOfPanel;
		
		try
		{
			vo.AD_Table_ID = 0;
			vo.AD_Column_ID = rs.getInt("AD_Process_Para_ID");	//	**
			vo.ColumnName = rs.getString("ColumnName");
			vo.Header = rs.getString("Name");
			vo.Description = rs.getString("Description");
			vo.Help = rs.getString("Help");
			vo.SeqNo = rs.getInt("SeqNo");
			vo.displayType = rs.getInt("AD_Reference_ID");
			vo.IsMandatory = rs.getString("IsMandatory").equals("Y");
			vo.FieldLength = rs.getInt("FieldLength");
			vo.DisplayLength = vo.FieldLength;
			vo.DefaultValue = rs.getString("DefaultValue");
			vo.DefaultValue2 = rs.getString("DefaultValue2");
			vo.VFormat = rs.getString("VFormat");
			vo.FormatPattern = rs.getString("FormatPattern");
			vo.ValueMin = rs.getString("ValueMin");
			vo.ValueMax = rs.getString("ValueMax");
			vo.isRange = rs.getString("IsRange").equals("Y");
			//
			vo.AD_Reference_Value_ID = rs.getInt("AD_Reference_Value_ID");
			vo.ValidationCode = rs.getString("ValidationCode");
			vo.ValidationCodeLookup = rs.getString("ValidationCodeLookup");
			vo.ReadOnlyLogic = rs.getString("ReadOnlyLogic");
			vo.DisplayLogic= rs.getString("DisplayLogic");
			vo.IsEncryptedField=rs.getString("IsEncrypted").equals("Y");
			vo.MandatoryLogic = rs.getString("MandatoryLogic");
			vo.Placeholder = rs.getString("Placeholder");
			vo.Placeholder2 = rs.getString("Placeholder2");
			vo.IsAutocomplete = "Y".equals(rs.getString("IsAutoComplete"));
			//
			vo.FieldGroup = rs.getString("FieldGroup");
			vo.FieldGroupType = rs.getString("FieldGroupType");
			vo.IsCollapsedByDefault = "Y".equals(rs.getString("IsCollapsedByDefault"));
		}
		catch (SQLException e)
		{
			CLogger.get().log(Level.SEVERE, "createParameter", e);
		}
		if(vo.IsDisplayed) {
			MUserDefProcParameter userDef = MUserDefProcParameter.get(ctx, vo.AD_Column_ID, vo.AD_Process_ID_Of_Panel);
			if(userDef != null) {
				if(userDef.getName() != null)
					vo.Header = userDef.getName();
				if(userDef.getDescription() != null)
					vo.Description = userDef.getDescription();
				if(userDef.getHelp() != null)
					vo.Help = userDef.getHelp();
				if(userDef.getReadOnlyLogic() != null)
					vo.ReadOnlyLogic = userDef.getReadOnlyLogic();
				if(userDef.getDefaultValue() != null)
					vo.DefaultValue = userDef.getDefaultValue();
				if(userDef.getDisplayLogic() != null)
					vo.DisplayLogic = userDef.getDisplayLogic();
				if(userDef.getMandatoryLogic() != null)
					vo.MandatoryLogic = userDef.getMandatoryLogic();
				if (userDef.getIsDisplayed()!= null)
				    vo.IsDisplayed = "Y".equals(userDef.getIsDisplayed());
				if (userDef.getPlaceholder()!= null)
				    vo.Placeholder = userDef.getPlaceholder();
				if (userDef.getPlaceholder2()!= null)
				    vo.Placeholder2 = userDef.getPlaceholder2();
				if (userDef.getSeqNo() > 0)
				    vo.SeqNo = userDef.getSeqNo();
				if (userDef.getAD_Reference_ID()>0)
					vo.displayType = userDef.getAD_Reference_ID();
				if (userDef.getAD_Reference_Value_ID()>0)
					vo.AD_Reference_Value_ID = userDef.getAD_Reference_Value_ID();
				if (userDef.getVFormat() != null)
					vo.VFormat = userDef.getVFormat();
				if (userDef.getAD_Val_Rule_ID() > 0)
					vo.ValidationCode  = MValRule.get(ctx, userDef.getAD_Val_Rule_ID()).getCode();
				if(userDef.getDefaultValue2() != null)
					vo.DefaultValue2 = userDef.getDefaultValue2();
				if(userDef.getValueMin() != null)
					vo.ValueMin = userDef.getValueMin();
				if(userDef.getValueMax() != null)
					vo.ValueMax = userDef.getValueMax();
				if (userDef.getIsMandatory()!= null)
					vo.IsMandatory = "Y".equals(userDef.getIsMandatory());
				if (userDef.getAD_FieldGroup_ID() > 0) {
					X_AD_FieldGroup fg = new X_AD_FieldGroup(Env.getCtx(), userDef.getAD_FieldGroup_ID(), null);
					vo.FieldGroup = fg.get_Translation(X_AD_FieldGroup.COLUMNNAME_Name);
					vo.FieldGroupType = fg.getFieldGroupType();
				}
			}
		}
		//
		vo.initFinish();
		if (vo.DefaultValue2 == null)
			vo.DefaultValue2 = "";
		if (vo.Placeholder2 == null)
			vo.Placeholder2 = "";

		return vo;
	}   //  createParameter

	/**
	 *  Create range "to" Parameter Field from "from" Parameter Field
	 *  @param voF field value object
	 *  @return to GridFieldVO
	 */
	public static GridFieldVO createParameter (GridFieldVO voF)
	{
		GridFieldVO voT = new GridFieldVO (voF.ctx, voF.WindowNo, voF.TabNo, 
			voF.AD_Window_ID, voF.AD_Tab_ID, voF.tabReadOnly);
		voT.isProcess = true;
		voT.IsDisplayed = true;
		voT.IsReadOnly = false;
		voT.IsUpdateable = true;
		//
		voT.AD_Table_ID = voF.AD_Table_ID;
		voT.AD_Column_ID = voF.AD_Column_ID;    //  AD_Process_Para_ID
		voT.ColumnName = voF.ColumnName;
		voT.Header = voF.Header;
		voT.Description = voF.Description;
		voT.Help = voF.Help;
		voT.displayType = voF.displayType;
		voT.IsMandatory = voF.IsMandatory;
		voT.FieldLength = voF.FieldLength;
		voT.DisplayLength = voF.FieldLength;
		voT.DefaultValue = voF.DefaultValue2;
		voT.Placeholder2 = voF.Placeholder2;
		voT.VFormat = voF.VFormat;
		voT.FormatPattern = voF.FormatPattern;
		voT.ValueMin = voF.ValueMin;
		voT.ValueMax = voF.ValueMax;
		voT.isRange = voF.isRange;
		//
		// Genied: For a range parameter the second field 
		// lookup behaviour should match the first one.
		voT.AD_Reference_Value_ID = voF.AD_Reference_Value_ID;
		// IDEMPIERE-229 Bug with Process parameter range
		voT.ValidationCode = voF.ValidationCode;
		voT.ValidationCodeLookup = voF.ValidationCodeLookup;
		voT.IsEncryptedField = voF.IsEncryptedField;
		voT.ReadOnlyLogic = voF.ReadOnlyLogic;
		voT.DisplayLogic = voF.DisplayLogic;
		voT.AD_Process_ID_Of_Panel = voF.AD_Process_ID_Of_Panel;
		voT.initFinish();
		
		return voT;
	}   //  createParameter

	/**
	 * Create parameter for infoWindow
	 * @param ctx ctx
	 * @param WindowNo WindowNo
	 * @param WindowIDOfPanel
	 * @param infoWindowID
	 * @param AD_Column_ID AD_Column_ID
	 * @param ColumnName ColumnName
	 * @param Name  Name
	 * @param AD_Reference_ID AD_Reference_ID
	 * @param AD_Reference_Value_ID AD_Reference_Value_ID
	 * @param IsMandatory  IsMandatory
	 * @param IsEncrypted IsEncrypted
	 * @param Placeholder
	 * @return GridFieldV0
	 */
	public static GridFieldVO createParameter (Properties ctx, int WindowNo, int WindowIDOfPanel, int infoWindowID,
			int AD_Column_ID, String ColumnName, String Name, int AD_Reference_ID, int AD_Reference_Value_ID, 
			boolean IsMandatory, boolean IsEncrypted, String Placeholder)
	{
		GridFieldVO vo = new GridFieldVO (ctx, WindowNo, 0, 0, 0, false);
		vo.isProcess = true;
		vo.IsDisplayed = true;
		vo.IsReadOnly = false;
		vo.IsUpdateable = true;
		vo.AD_Table_ID = 0;
		vo.AD_Column_ID = AD_Column_ID;	//	**
		vo.ColumnName = ColumnName;
		vo.Header = Name;
		vo.displayType = AD_Reference_ID;
		vo.AD_Reference_Value_ID = AD_Reference_Value_ID;
		vo.IsMandatory = IsMandatory;
		vo.IsEncryptedField= IsEncrypted;			
		vo.AD_InfoWindow_ID_Of_Panel = infoWindowID;
		vo.AD_Window_ID_Of_Panel = WindowIDOfPanel;
		vo.Placeholder = Placeholder;
		//
		vo.initFinish();
		return vo;
	}

	/**
	 *  Make a standard field (Created/Updated/By)
	 *  @param ctx context
	 *  @param WindowNo window
	 *  @param TabNo tab
	 *  @param AD_Window_ID window
	 *  @param AD_Tab_ID tab
	 *  @param tabReadOnly rab is r/o
	 *  @param isCreated is Created field
	 *  @param isTimestamp is the timestamp (not by)
	 *  @return GridFieldVO
	 */
	public static GridFieldVO createStdField (Properties ctx, int WindowNo, int TabNo, 
		int AD_Window_ID, int AD_Tab_ID, boolean tabReadOnly,
		boolean isCreated, boolean isTimestamp)
	{
		GridFieldVO vo = new GridFieldVO (ctx, WindowNo, TabNo, 
			AD_Window_ID, AD_Tab_ID, tabReadOnly);
		vo.ColumnName = isCreated ? "Created" : "Updated";
		if (!isTimestamp)
			vo.ColumnName += "By";
		vo.displayType = isTimestamp ? DisplayType.DateTime : DisplayType.Table;
		if (!isTimestamp)
			vo.AD_Reference_Value_ID = REFERENCE_AD_USER;		//	AD_User Table Reference
		vo.IsDisplayed = false;
		vo.IsMandatory = false;
		vo.IsReadOnly = false;
		vo.IsUpdateable = true;
		vo.initFinish();
		return vo;
	}   //  initStdField

	
	/**************************************************************************
	 *  Private constructor.
	 *  @param Ctx context
	 *  @param windowNo window
	 *  @param tabNo tab
	 *  @param ad_Window_ID window
	 *  @param ad_Tab_ID tab
	 *  @param TabReadOnly tab read only
	 */
	private GridFieldVO (Properties Ctx, int windowNo, int tabNo, 
		int ad_Window_ID, int ad_Tab_ID, boolean TabReadOnly)
	{
		ctx = Ctx;
		WindowNo = windowNo;
		TabNo = tabNo;
		AD_Window_ID = ad_Window_ID;
		AD_Tab_ID = ad_Tab_ID;
		tabReadOnly = TabReadOnly;
	}   //  MFieldVO

	/** Context                     */
	public Properties   ctx = null;
	/** Window No                   */
	public int          WindowNo;
	/** Tab No                      */
	public int          TabNo;
	/** AD_Winmdow_ID               */
	public int          AD_Window_ID;
	/** 
	 *  in case this field lie on parameter process panel, AD_Process_ID_Of_Panel is id of process will run in this panel 
	 *  it's difference with AD_Process_ID
	 */
	public int          AD_Process_ID_Of_Panel;
	/**
	 * ad_window_id of window show process dialog or infoWindow dialog
	 */
	public int          AD_Window_ID_Of_Panel;
	/**
	 * AD_Infowindow_ID call process. user in case from info window call process.
	 */
	public int          AD_InfoWindow_ID_Of_Panel;
	/** AD_Tab_ID					*/
	public int			AD_Tab_ID;
	/** Is the Tab Read Only        */
	public boolean      tabReadOnly = false;

	/** Is Process Parameter        */
	public boolean      isProcess = false;

	/**	Column name		*/
	public String       ColumnName = "";
	/**	Column sql		*/
	public String       ColumnSQL;
	/**	Label			*/
	public String       Header = "";
	/**	DisplayType		*/
	public int          displayType = 0;
	/**	Table ID		*/
	public int          AD_Table_ID = 0;
	/**	Clumn ID		*/
	public int          AD_Column_ID = 0;
	/**	Display Length	*/
	public int          DisplayLength = 0;
	/**	Same Line		*/
	public boolean      IsSameLine = false;
	/**	Displayed		*/
	public boolean      IsDisplayed = false;
	/**	Displayed Grid		*/
	public boolean      IsDisplayedGrid = false;
	/** Position     	*/
	public int			SeqNo = 0;
	/** Grid Display sequence	*/
	public int			SeqNoGrid = 0;
	/**	Dislay Logic, never set null for it	*/
	public String       DisplayLogic = "";
	/**	Default Value, never set null for it	*/	
	public String       DefaultValue = "";
	/**	Mandatory		*/
	public boolean      IsMandatory = false;
	/**	Read Only		*/
	public boolean      IsReadOnly = false;
	/**	Updateable		*/
	public boolean      IsUpdateable = false;
	/**	Always Updateable	*/
	public boolean      IsAlwaysUpdateable = false;
	/**	Heading Only	*/
	public boolean      IsHeading = false;
	/**	Field Only		*/
	public boolean      IsFieldOnly = false;
	/**	Display Encryption	*/
	public boolean      IsEncryptedField = false;
	/**	Storage Encryption	*/
	public boolean      IsEncryptedColumn = false;
	/**	Find Selection		*/
	public boolean		IsSelectionColumn = false;
	/**	Selection column sequence		*/
	public int			SeqNoSelection = 0;
	/**	Order By		*/
	public int          SortNo = 0;
	/**	Field Length		*/
	public int          FieldLength = 0;
	/**	Format enforcement		*/
	public String       VFormat = "";
	/**	Format pattern		*/
	public String FormatPattern;
	/**	Min. Value		*/
	public String       ValueMin = "";
	/**	Max. Value		*/
	public String       ValueMax = "";
	/**	Field Group		*/
	public String       FieldGroup = "";
	/**	Field Group	Type	*/
	public String       FieldGroupType = "";
	/**	PK				*/
	public boolean      IsKey = false;
	/**	FK				*/
	public boolean      IsParent = false;
	/**	Callout			*/
	public String       Callout = "";
	/**	Process			*/
	public int          AD_Process_ID = 0;
	/** Info Window		*/
	public int			AD_InfoWindow_ID = 0;
	/**	Description		*/
	public String       Description = "";
	/**	Help			*/
	public String       Help = "";
	/**	Mandatory Logic	*/
	public String 		MandatoryLogic = "";
	/**	Read Only Logic	*/
	public String       ReadOnlyLogic = "";
	/**	Always Updatable Logic	*/
	public String       AlwaysUpdatableLogic = "";
	/**	Display Obscure	*/
	public String		ObscureType = null;
	/** Default Focus	*/
	public boolean		IsDefaultFocus = false;

	/**	Lookup Validation code	*/
	public String		ValidationCode = "";
	/**	Lookup Validation code for Find Window	*/
	public String	ValidationCodeLookup = "";
	/**	Reference Value			*/
	public int			AD_Reference_Value_ID = 0;

	/**	Process Parameter Range		*/
	public boolean      isRange = false;
	/**	Process Parameter Value2	*/
	public String       DefaultValue2 = "";

	/** Lookup Value Object     */
	public MLookupInfo  lookupInfo = null;
	
	/** Field ID 				*/
	public int AD_Field_ID = 0;
	
	/***** XPosition IDEMPIERE368***/
	public int XPosition=0;
	
	/***** ColumnSpan IDEMPIERE368***/
	public int ColumnSpan=0;
	
	/***** NumLines IDEMPIERE368***/
    public int NumLines=0; 
	
	//*  Feature Request FR [ 1757088 ]
	public int          Included_Tab_ID = 0;

	/** Collapse By Default * */
	public boolean IsCollapsedByDefault = false;
	/**  Autocompletion for textfields - Feature Request FR [ 1757088 ] */
	public boolean IsAutocomplete = false;
	/* Allow copy - IDEMPIERE-67 - Carlos Ruiz - globalqss */
	public boolean IsAllowCopy = false;
	/** Toolbar Button **/
	public String IsToolbarButton = MColumn.ISTOOLBARBUTTON_Window;
	
	public int AD_Chart_ID = 0;
	
	public int AD_LabelStyle_ID = 0;
	
	public int AD_FieldStyle_ID = 0;
	
	public int PA_DashboardContent_ID = 0;

	public String Placeholder = "";

	public String Placeholder2 = "";

	/* Is HTML String */
	public boolean		IsHtml = false;

	/* Allow to show field in Quick Form */
	public boolean IsQuickForm = false;

	/**
	 *  Set Context including contained elements
	 *  @param newCtx new context
	 */
	public void setCtx (Properties newCtx)
	{
		ctx = newCtx;
		if (lookupInfo != null)
			lookupInfo.ctx = newCtx;
	}   //  setCtx

	/**
	 *  Validate Fields and create LookupInfo if required
	 */
	protected void initFinish()
	{
		//  Not null fields
		if (DisplayLogic == null)
			DisplayLogic = "";
		if (DefaultValue == null)
			DefaultValue = "";
		if (FieldGroup == null)
			FieldGroup = "";
		if (FieldGroupType == null)
			FieldGroupType = "";
		if (Description == null)
			Description = "";
		if (Help == null)
			Help = "";
		if (Callout == null)
			Callout = "";
		if (ReadOnlyLogic == null)
			ReadOnlyLogic = "";
		if (AlwaysUpdatableLogic == null)
			AlwaysUpdatableLogic = "";
		if (MandatoryLogic == null)
			MandatoryLogic = "";
		if (Placeholder == null)
			Placeholder = "";


		//  Create Lookup, if not ID
		if (DisplayType.isLookup(displayType) && IsDisplayed)
		{
			loadLookupInfo();
		}
	}   //  initFinish

	/**
	 * load lookup info.
	 * used by findwindow to loadlookupinfo for invisible field
	 */
	public void loadLookupInfo() {
		try
		{
			lookupInfo = MLookupFactory.getLookupInfo (ctx, WindowNo, TabNo, AD_Column_ID, displayType,
				Env.getLanguage(ctx), ColumnName, AD_Reference_Value_ID,
				IsParent, ValidationCode);
			if (lookupInfo == null)
				displayType = DisplayType.ID;
		}
		catch (Exception e)     //  Cannot create Lookup
		{
			CLogger.get().log(Level.SEVERE, "No LookupInfo for " + ColumnName, e);
			displayType = DisplayType.ID;
		}
	}

	/**
	 * 	Clone Field.
	 *	@param Ctx ctx
	 *	@param windowNo window no
	 *	@param tabNo tab no
	 *	@param ad_Window_ID window id
	 *	@param ad_Tab_ID tab id
	 *	@param TabReadOnly r/o
	 *	@return Field or null
	 */
	public GridFieldVO clone(Properties Ctx, int windowNo, int tabNo, 
		int ad_Window_ID, int ad_Tab_ID, 
		boolean TabReadOnly)
	{
		GridFieldVO clone = null;
		clone = (GridFieldVO) clone();
		clone.ctx = ctx;
		clone.WindowNo = windowNo;
		clone.TabNo = tabNo;
		clone.AD_Window_ID = ad_Window_ID;
		clone.AD_Tab_ID = ad_Tab_ID;
		clone.tabReadOnly = TabReadOnly;
		if (clone.lookupInfo != null) 
		{
			clone.lookupInfo.ctx = ctx;
		}
		return clone;
	}	//	clone
	
	
	@Override
	public GridFieldVO clone() {
		try {
			GridFieldVO clone = (GridFieldVO) super.clone();
			clone.ctx = Env.getCtx();
			if ( lookupInfo != null) {
				clone.ValidationCodeLookup = ValidationCodeLookup;
				clone.lookupInfo = lookupInfo.clone();
				clone.lookupInfo.ctx = clone.ctx;
			}
			return clone;
		} catch (CloneNotSupportedException e) {
			throw new RuntimeException(e);
		}		
	}


	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("GridFieldVO[");
		sb.append(AD_Column_ID).append("-").append(ColumnName)
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 
	 * @author a42niem
	 * IDEMPIERE-1120 Implement Field SeqNo customization
	 */
	public static class SeqNoComparator implements Comparator<GridFieldVO> {
		@Override
		public int compare(GridFieldVO gf1, GridFieldVO gf2) {
			return (Integer.valueOf(gf1.SeqNo)).compareTo(Integer.valueOf(gf2.SeqNo));
		}
	}

}   //  GridFieldVO
