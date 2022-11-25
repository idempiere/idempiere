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
 *****************************************************************************/
package org.adempiere.webui.window;

import static org.compiere.model.SystemIDs.COLUMN_M_MOVEMENTLINE_M_ATTRIBUTESETINSTANCE_ID;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Urlbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeInstance;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MAttributeValue;
import org.compiere.model.MDocType;
import org.compiere.model.MLot;
import org.compiere.model.MLotCtl;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MSerNoCtl;
import org.compiere.model.X_M_MovementLine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;

/**
 *  Product Attribute Set Product/Instance Dialog Editor.
 * 	Called from VPAttribute.actionPerformed
 *
 *  @author Jorg Janke
 *  
 *  ZK Port
 *  @author Low Heng Sin
 */
public class WPAttributeDialog extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7810825026970615029L;

	/**
	 *	Product Attribute Instance Dialog
	 *	@param M_AttributeSetInstance_ID Product Attribute Set Instance id
	 * 	@param M_Product_ID Product id
	 * 	@param C_BPartner_ID b partner
	 * 	@param productWindow this is the product window (define Product Instance)
	 * 	@param AD_Column_ID column
	 * 	@param WindowNo window
	 */
	public WPAttributeDialog (int M_AttributeSetInstance_ID, 
		int M_Product_ID, int C_BPartner_ID, 
		boolean productWindow, int AD_Column_ID, int WindowNo)
	{
		super ();
		this.setTitle(Msg.translate(Env.getCtx(), "M_AttributeSetInstance_ID"));
		if (!ThemeManager.isUseCSSForWindowSize())
			ZKUpdateUtil.setWindowWidthX(this, 500);
		this.setSclass("popup-dialog pattribute-dialog");
		this.setBorder("normal");
		this.setShadow(true);
		this.setSizable(true);
		this.setMaximizable(true);
		
		if (log.isLoggable(Level.CONFIG)) log.config("M_AttributeSetInstance_ID=" + M_AttributeSetInstance_ID 
			+ ", M_Product_ID=" + M_Product_ID
			+ ", C_BPartner_ID=" + C_BPartner_ID
			+ ", ProductW=" + productWindow + ", Column=" + AD_Column_ID);
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		m_M_AttributeSetInstance_ID = M_AttributeSetInstance_ID;
		m_M_Product_ID = M_Product_ID;
		m_C_BPartner_ID = C_BPartner_ID;
		m_productWindow = productWindow;
		m_AD_Column_ID = AD_Column_ID;
		m_WindowNoParent = WindowNo;

		//get columnName from ad_column
		m_columnName = DB.getSQLValueString(null, "SELECT ColumnName FROM AD_Column WHERE AD_Column_ID = ?", m_AD_Column_ID);
		if (m_columnName == null || m_columnName.trim().length() == 0) 
		{
			//fallback
			m_columnName = "M_AttributeSetInstance_ID";
		}
		
		try
		{
			init();
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "VPAttributeDialog" + ex);
		}
		//	Dynamic Init
		if (!initAttributes ())
		{
			dispose();
			return;
		}
		AEnv.showCenterScreen(this);
	}	//	VPAttributeDialog

	private int						m_WindowNo;
	private MAttributeSetInstance	m_masi;
	private int 					m_M_AttributeSetInstance_ID;
	private int 					m_M_Locator_ID;
	private String					m_M_AttributeSetInstanceName;
	private int 					m_M_Product_ID;
	private int						m_C_BPartner_ID;
	private int						m_AD_Column_ID;
	private int						m_WindowNoParent;
	/**	Enter Product Attributes		*/
	private boolean					m_productWindow = false;
	/**	Change							*/
	private boolean					m_changed = false;
	
	private static final CLogger	log = CLogger.getCLogger(WPAttributeDialog.class);
	/** Row Counter					*/
	private int						m_row = 0;
	/** List of Editors				*/
	private ArrayList<WEditor>		m_editors = new ArrayList<WEditor>();

	private Checkbox	cbNewEdit = new Checkbox();
	private Button		bNewRecord = new Button(Msg.getMsg(Env.getCtx(), "NewRecord"));
	private Listbox		existingCombo = new Listbox();
	private Button		bSelect = new Button(); 
	//	Lot
	private Textbox fieldLotString = new Textbox();
	private Listbox fieldLot = new Listbox();
	private Button bLot = new Button(Msg.getMsg (Env.getCtx(), "New"));
	//	Lot Popup
	Menupopup 					popupMenu = new Menupopup();
	private Menuitem 			mZoom;
	//	Ser No
	private Textbox fieldSerNo = new Textbox();
	private Button bSerNo = new Button(Msg.getMsg (Env.getCtx(), "New"));
	//	Date
	private Datebox fieldGuaranteeDate = new Datebox();
	//
	private Textbox fieldDescription = new Textbox(); //TODO: set length to 20
	//
	private Borderlayout mainLayout = new Borderlayout();
	private Panel centerPanel = new Panel();
	private Grid centerLayout = new Grid();
	private Panel northPanel = new Panel();
	private Grid northLayout = new Grid();
	private ConfirmPanel confirmPanel = new ConfirmPanel (true);
	
	private String m_columnName = null;

	/**
	 *	Layout
	 * 	@throws Exception
	 */
	private void init () throws Exception
	{
		mainLayout.setParent(this);
		ZKUpdateUtil.setHflex(mainLayout, "1");
		ZKUpdateUtil.setVflex(mainLayout, "min");
		if (ClientInfo.maxHeight(600)) 
				mainLayout.setStyle("max-height: 100%;"); 
		else 
			mainLayout.setStyle("max-height: 600px;");
		
		North north = new North();
		north.setSclass("dialog-content");
		north.setParent(mainLayout);
		ZKUpdateUtil.setVflex(northPanel, "min");
		ZKUpdateUtil.setHflex(northPanel, "min");
		north.appendChild(northPanel);
		
		Center center = new Center();
		center.setSclass("dialog-content");
		center.setParent(mainLayout);
		ZKUpdateUtil.setVflex(centerPanel, "min");
		ZKUpdateUtil.setHflex(centerPanel, "min");
		center.appendChild(centerPanel);
		center.setAutoscroll(true);

		South south = new South();
		south.setSclass("dialog-footer");
		south.setParent(mainLayout);
		south.appendChild(confirmPanel);
		
		centerPanel.appendChild(centerLayout);
		centerLayout.setOddRowSclass("even");
		northPanel.appendChild(northLayout);
		northLayout.setOddRowSclass("even");
		//
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}	//	init

	/**
	 *	Dyanmic Init.
	 *  @return true if initialized
	 */
	private boolean initAttributes ()
	{
		Columns columns = new Columns();
		columns.setParent(centerLayout);
		
		Column column = new Column();
		column.setParent(columns);
		ZKUpdateUtil.setWidth(column, "30%");
		
		column = new Column();
		column.setParent(columns);
		ZKUpdateUtil.setWidth(column, "70%");
		
		Rows northRows = new Rows();
		northRows.setParent(northLayout);
		
		Rows rows = new Rows();
		rows.setParent(centerLayout);
		
		if (m_M_Product_ID == 0 && !m_productWindow)
			return false;
		
		MAttributeSet as = null;
		
		int M_AttributeSet_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNoParent, "M_AttributeSet_ID");
		if (m_M_Product_ID != 0 && M_AttributeSet_ID == 0)
		{
			//	Get Model
			m_masi = MAttributeSetInstance.get(Env.getCtx(), m_M_AttributeSetInstance_ID, m_M_Product_ID);
			if (m_masi == null)
			{
				log.severe ("No Model for M_AttributeSetInstance_ID=" + m_M_AttributeSetInstance_ID + ", M_Product_ID=" + m_M_Product_ID);
				return false;
			}
			Env.setContext(Env.getCtx(), m_WindowNo, "M_AttributeSet_ID", m_masi.getM_AttributeSet_ID());
	
			//	Get Attribute Set
			as = m_masi.getMAttributeSet();
		}
		else 
		{
			m_masi = new MAttributeSetInstance (Env.getCtx(), m_M_AttributeSetInstance_ID, M_AttributeSet_ID, null);
			as = m_masi.getMAttributeSet();
		}
		
		//	Product has no Attribute Set
		if (as == null)		
		{
			Dialog.error(m_WindowNo, "PAttributeNoAttributeSet");
			return false;
		}
		//	Product has no Instance Attributes
		if (!m_productWindow && !as.isInstanceAttribute())
		{
			Dialog.error(m_WindowNo, "PAttributeNoInstanceAttribute");
			return false;
		}

		//	Show Product Attributes
		if (m_productWindow)
		{
			Row row = new Row();
			row.setParent(northRows);
			Cell cell = new Cell();
			cell.setWidth("29%");
			cbNewEdit.setLabel(Msg.getMsg(Env.getCtx(), "EditRecord"));
			cbNewEdit.addEventListener(Events.ON_CHECK, this);
			cell.appendChild(cbNewEdit);
			row.appendChild(cell);
						
			String sql = "SELECT M_AttributeSetInstance_ID, Description"
				+ " FROM M_AttributeSetInstance"
				+ " WHERE M_AttributeSet_ID = " + as.getM_AttributeSet_ID()
				+ " AND EXISTS ("
				+ " SELECT 1 FROM M_AttributeInstance INNER JOIN M_Attribute"
				+ " ON (M_AttributeInstance.M_Attribute_ID = M_Attribute.M_Attribute_ID)"
				+ " WHERE M_AttributeInstance.M_AttributeSetInstance_ID = M_AttributeSetInstance.M_AttributeSetInstance_ID"
				+ " AND M_Attribute.IsInstanceAttribute = 'N')";
			existingCombo.setMold("select");
			KeyNamePair[] keyNamePairs = DB.getKeyNamePairs(sql, true);
			for (KeyNamePair pair : keyNamePairs) {
				existingCombo.appendItem(pair.getName(), pair.getKey());
			}
			existingCombo.addActionListener(this);
			row.appendChild(existingCombo);
			ZKUpdateUtil.setHflex(existingCombo, "1");
			
			row = new Row();
			row.setParent(northRows);
			LayoutUtils.addSclass("txt-btn", bNewRecord);
			bNewRecord.addActionListener(this);
			row.appendChild(bNewRecord);
			row.appendChild(new Space());
			MAttribute[] attributes = as.getMAttributes (false);
			if (log.isLoggable(Level.FINE)) log.fine ("Product Attributes=" + attributes.length);
			for (int i = 0; i < attributes.length; i++)
				addAttributeLine (rows, attributes[i], true, false);
			if (m_M_AttributeSetInstance_ID > 0)
			{
				for(int i = 0; i < existingCombo.getItemCount(); i++)
				{
					ListItem pp = existingCombo.getItemAtIndex(i);
					if (pp.getValue() != null && (Integer)pp.getValue() == m_M_AttributeSetInstance_ID)
					{
						existingCombo.setSelectedIndex(i);
						break;
					}
				}
			}
		}
		else	//	Set Instance Attributes
		{
			Row row = new Row();
			
			//	New/Edit - Selection
			if (m_M_AttributeSetInstance_ID == 0)		//	new
				cbNewEdit.setLabel(Msg.getMsg(Env.getCtx(), "NewRecord"));
			else
				cbNewEdit.setLabel(Msg.getMsg(Env.getCtx(), "EditRecord"));
			cbNewEdit.addEventListener(Events.ON_CHECK, this);
			row.appendChild(cbNewEdit);
			bSelect.setLabel(Msg.getMsg(Env.getCtx(), "SelectExisting"));
			if (ThemeManager.isUseFontIconForImage())
				bSelect.setIconSclass("z-icon-PAttribute");
			else
				bSelect.setImage(ThemeManager.getThemeResource("images/PAttribute16.png"));
			bSelect.addEventListener(Events.ON_CLICK, this);
			row.appendChild(bSelect);
			ZKUpdateUtil.setHflex(bSelect, "1");
			northRows.appendChild(row);
			
			//	All Attributes
			MAttribute[] attributes = as.getMAttributes (true);
			if (log.isLoggable(Level.FINE)) log.fine ("Instance Attributes=" + attributes.length);
			for (int i = 0; i < attributes.length; i++)
				addAttributeLine (rows, attributes[i], false, false);
		}

		//	Lot
		if (!m_productWindow && as.isLot())
		{
			Row row = new Row();
			row.setParent(rows);
			m_row++;
			Label label = new Label (Msg.translate(Env.getCtx(), "Lot"));
			row.appendChild(label.rightAlign());
			row.appendChild(fieldLotString);
			ZKUpdateUtil.setHflex(fieldLotString, "1");
			fieldLotString.setText (m_masi.getLot());

			String sql = "SELECT M_Lot_ID, Name "
				+ "FROM M_Lot l "
				+ "WHERE EXISTS (SELECT M_Product_ID FROM M_Product p "
					+ "WHERE p.M_AttributeSet_ID=" + m_masi.getM_AttributeSet_ID()
					+ " AND p.M_Product_ID=l.M_Product_ID)";
			fieldLot = new Listbox();
			fieldLot.setMold("select");
			KeyNamePair[] keyNamePairs = DB.getKeyNamePairs(sql, true);
			for (KeyNamePair pair : keyNamePairs) {
				fieldLot.appendItem(pair.getName(), pair.getKey());
			}
						
			label = new Label (Msg.translate(Env.getCtx(), "M_Lot_ID"));
			row = new Row();
			row.setParent(rows);
			m_row++;
			row.appendChild(label.rightAlign());
			row.appendChild(fieldLot);
			ZKUpdateUtil.setHflex(fieldLot, "1");
			if (m_masi.getM_Lot_ID() != 0)
			{
				for (int i = 1; i < fieldLot.getItemCount(); i++)
				{
					ListItem pp = fieldLot.getItemAtIndex(i);
					if ((Integer)pp.getValue() == m_masi.getM_Lot_ID())
					{
						fieldLot.setSelectedIndex(i);
						fieldLotString.setReadonly(true);
						break;
					} 
				}
			}
			fieldLot.addEventListener(Events.ON_SELECT, this);
			//	New Lot Button
			if (m_masi.getMAttributeSet().getM_LotCtl_ID() != 0)
			{
				if (MRole.getDefault().isTableAccess(MLot.Table_ID, false)
					&& MRole.getDefault().isTableAccess(MLotCtl.Table_ID, false)
					&& !m_masi.isExcludeLot(m_AD_Column_ID, Env.isSOTrx(Env.getCtx(), m_WindowNoParent)))
				{
					row = new Row();
					row.setParent(rows);
					m_row++;
					row.appendChild(bLot);
					bLot.addEventListener(Events.ON_CLICK, this);
					LayoutUtils.addSclass("txt-btn", bLot);
				}
			}
			//	Popup 
			mZoom = new Menuitem(Msg.getMsg(Env.getCtx(), "Zoom"), ThemeManager.getThemeResource("images/Zoom16.png"));
			if(ThemeManager.isUseFontIconForImage()) {
				mZoom.setIconSclass("z-icon-Zoom");
				mZoom.setImage("");
			}

			mZoom.addEventListener(Events.ON_CLICK, this);
			popupMenu.appendChild(mZoom);
			this.appendChild(popupMenu);
		}	//	Lot

		//	SerNo
		if (!m_productWindow && as.isSerNo())
		{
			Row row = new Row();
			row.setParent(rows);
			m_row++;
			Label label = new Label (Msg.translate(Env.getCtx(), "SerNo"));
			row.appendChild(label.rightAlign());
			row.appendChild(fieldSerNo);
			ZKUpdateUtil.setHflex(fieldSerNo, "1");
			fieldSerNo.setText(m_masi.getSerNo());
			
			//	New SerNo Button
			if (m_masi.getMAttributeSet().getM_SerNoCtl_ID() != 0)
			{
				if (MRole.getDefault().isTableAccess(MSerNoCtl.Table_ID, false)
					&& !m_masi.isExcludeSerNo(m_AD_Column_ID, Env.isSOTrx(Env.getCtx(), m_WindowNoParent)))
				{
					row = new Row();
					row.setParent(rows);
					m_row++;
					row.appendChild(bSerNo);
					bSerNo.addEventListener(Events.ON_CLICK, this);
					LayoutUtils.addSclass("txt-btn", bSerNo);
				}
			}
		}	//	SerNo

		//	GuaranteeDate
		if (!m_productWindow && as.isGuaranteeDate())
		{
			Row row = new Row();
			row.setParent(rows);
			m_row++;
			Label label = new Label (Msg.translate(Env.getCtx(), "GuaranteeDate"));
			if (m_M_AttributeSetInstance_ID == 0)
				fieldGuaranteeDate.setValue(m_masi.getGuaranteeDate(true));
			else
				fieldGuaranteeDate.setValue(m_masi.getGuaranteeDate());
			row.appendChild(label.rightAlign());
			row.appendChild(fieldGuaranteeDate);			
		}	//	GuaranteeDate

		if (m_row == 0)
		{
			Dialog.error(m_WindowNo, "PAttributeNoInfo");
			return false;
		}

		//	New/Edit Window
		if (!m_productWindow)
		{
			cbNewEdit.setChecked(m_M_AttributeSetInstance_ID == 0);
			cmd_newEdit();
		}
		else
		{
			cbNewEdit.setSelected(false);
			cbNewEdit.setEnabled(m_M_AttributeSetInstance_ID > 0);
			bNewRecord.setEnabled(m_M_AttributeSetInstance_ID > 0);
			boolean rw = m_M_AttributeSetInstance_ID == 0;
			for (int i = 0; i < m_editors.size(); i++)
			{
				WEditor editor = m_editors.get(i);
				editor.setReadWrite(rw);
			}
		}

		//	Attrribute Set Instance Description
		Label label = new Label (Msg.translate(Env.getCtx(), "Description"));
		fieldDescription.setText(m_masi.getDescription());
		fieldDescription.setReadonly(true);
		Row row = new Row();
		row.setParent(rows);
		row.appendChild(label.rightAlign());
		row.appendChild(fieldDescription);
		ZKUpdateUtil.setHflex(fieldDescription, "1");
		
		return true;
	}	//	initAttribute

	/**
	 * 	Add Attribute Line
	 *	@param attribute attribute
	 * 	@param product product level attribute
	 * 	@param readOnly value is read only
	 */
	private void addAttributeLine (Rows rows, MAttribute attribute, boolean product, boolean readOnly)
	{
		if (log.isLoggable(Level.FINE)) log.fine(attribute + ", Product=" + product + ", R/O=" + readOnly);
		
		m_row++;
		WEditor editor = null;
		//
		if (MAttribute.ATTRIBUTEVALUETYPE_List.equals(attribute.getAttributeValueType()))
		{
			editor = WebEditorFactory.getEditor(getListTypeGridField(attribute), true);
		}
		else if (MAttribute.ATTRIBUTEVALUETYPE_Number.equals(attribute.getAttributeValueType()))
		{
			editor = WebEditorFactory.getEditor(getNumberGridField(attribute), true);
		}
		else if (MAttribute.ATTRIBUTEVALUETYPE_Reference.equals(attribute.getAttributeValueType()))
		{
			editor = WebEditorFactory.getEditor(getGridField(attribute), true);
		}
		else if (MAttribute.ATTRIBUTEVALUETYPE_Date.equals(attribute.getAttributeValueType()))
		{
			editor = WebEditorFactory.getEditor(getDateGridField(attribute), true);
		}
		else // Text Field
		{
			editor = WebEditorFactory.getEditor(getStringGridField(attribute), true);
		}

		if (editor != null)
		{
			Row row = rows.newRow();

			Label label = editor.getLabel();
			if (label.getValue() == null || label.getValue().trim().length() < 1)
				label.setValue(attribute.getName());

			if (product)
				label.setStyle("font-weight: bold");

			row.appendChild(label.rightAlign());

			editor.setMandatory(attribute.isMandatory());
			editor.fillHorizontal();
			setEditorAttribute(attribute, editor);
			editor.addValueChangeListener(new ValueChangeListener() {

				@Override
				public void valueChange(ValueChangeEvent evt)
				{
					if (evt.getSource() instanceof WEditor)
					{
						WEditor sourceEditor = (WEditor) evt.getSource();
						// IDEMPIERE-2999 - set value in online button as HRef
						if (sourceEditor.getGridField().getDisplayType() == DisplayType.URL)
							((Urlbox) sourceEditor.getComponent()).setText((String) evt.getNewValue());
					}
				}
			});

			Component fieldEditor = editor.getComponent();
			row.appendChild(fieldEditor);
			editor.showMenu();
			if (readOnly)
				editor.setReadWrite(false);
			else
				m_editors.add(editor);
		}
	}	//	addAttributeLine

	public GridField getGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(),
				Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), attribute.getAD_Reference_ID(),
				attribute.getAD_Reference_Value_ID(), false, false, null);

		if (attribute.isAttributeValueTypeReference() && DisplayType.isLookup(attribute.getAD_Reference_ID()) && attribute.getAD_Val_Rule_ID() > 0)
		{
			vo.ValidationCode = attribute.getAD_Val_Rule().getCode();
			if (vo.lookupInfo != null)
			{
				vo.lookupInfo.ValidationCode = vo.ValidationCode;
				vo.lookupInfo.IsValidated = false;
			}
		}

		return createGridField(attribute, vo);
	} // getGridField

	public GridField getStringGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(),
				Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), DisplayType.String, 0, false, false, null);

		return createGridField(attribute, vo);
	} // getStringGridField

	public GridField getNumberGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(),
				Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), DisplayType.Number, 0, false, false, null);

		return createGridField(attribute, vo);
	} // getNumberGridField

	public GridField getDateGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(), 
				Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), DisplayType.Date, 0, false, false, null);

		return createGridField(attribute, vo);
	} // getDateGridField

	public GridField getListTypeGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0,
				"M_AttributeValue_ID", attribute.getName(), DisplayType.TableDir, 0, false, false, null);

		// Validation for List - Attribute Values
		vo.ValidationCode = "M_AttributeValue.M_Attribute_ID=" + attribute.get_ID();
		vo.lookupInfo.ValidationCode = vo.ValidationCode;
		vo.lookupInfo.IsValidated = false;

		return createGridField(attribute, vo);
	} // getListTypeGridField

	private GridField createGridField(MAttribute attribute, GridFieldVO vo)
	{
		String desc = attribute.get_Translation("Description");
		vo.Description = desc != null ? desc : "";
		return new GridField(vo);
	} // createGridField

	public void updateAttributeEditor(MAttribute attribute, int index)
	{
		WEditor editor = m_editors.get(index);
		if (editor != null)
			setEditorAttribute(attribute, editor);
	} // updateAttributeEditor

	public void setEditorAttribute(MAttribute attribute, WEditor editor)
	{
		MAttributeInstance instance = attribute.getMAttributeInstance(m_M_AttributeSetInstance_ID);
		if (instance != null)
		{
			if (MAttribute.ATTRIBUTEVALUETYPE_List.equals(attribute.getAttributeValueType()))
			{
				if (instance.getM_AttributeValue_ID() > 0)
					editor.setValue(instance.getM_AttributeValue_ID());
			}
			else
			{
				int displayType = editor.getGridField().getDisplayType();
				if (displayType == DisplayType.Date || displayType == DisplayType.DateTime || displayType == DisplayType.Time)
				{
					if (instance.getValueDate() != null)
						editor.setValue(instance.getValueDate());
				}
				else if (displayType == DisplayType.Image	|| displayType == DisplayType.Assignment
							|| displayType == DisplayType.Locator
							|| displayType == DisplayType.TableDir
							|| displayType == DisplayType.Table
							|| displayType == DisplayType.Search
							|| displayType == DisplayType.Account)
				{
					if (instance.getValueInt() > 0)
						editor.setValue(instance.getValueInt());
				}
				else if (displayType == DisplayType.Integer)
				{
					editor.setValue(instance.getValueInt());
				}
				else if (DisplayType.isNumeric(displayType))
				{
					if (instance.getValueNumber() != null)
						editor.setValue(instance.getValueNumber());
				}
				else
				{
					if (instance.getValue() != null)
						editor.setValue(instance.getValue());
				}
			}
		}
	} // setEditorAttribute

	/**
	 *	dispose
	 */
	public void dispose()
	{
		Env.clearWinContext(m_WindowNo);
		//
		Env.setContext(Env.getCtx(), m_WindowNoParent, Env.TAB_INFO, m_columnName, 
			String.valueOf(m_M_AttributeSetInstance_ID));
		Env.setContext(Env.getCtx(), m_WindowNoParent, Env.TAB_INFO, "M_Locator_ID", 
			String.valueOf(m_M_Locator_ID));
		//
		this.detach();
	}	//	dispose

	public void onEvent(Event e) throws Exception 
	{
		//	Select Instance
		if (e.getTarget() == bSelect)
		{
			cmd_select();				
		}
		//	New/Edit
		else if (e.getTarget() == cbNewEdit)
		{
			if (m_productWindow)
			{
				cmd_edit();
			}
			else
			{
				cmd_newEdit();
			}
		}
		else if (e.getTarget() == bNewRecord)
		{
			cmd_newRecord();
		}
		else if (e.getTarget() == existingCombo)
		{
			cmd_existingCombo();
		}
		//	Select Lot from existing
		else if (e.getTarget() == fieldLot)
		{
			ListItem pp = fieldLot.getSelectedItem();
			if (pp != null && (Integer)pp.getValue() != -1)
			{
				fieldLotString.setText(pp.getLabel());
				fieldLotString.setReadonly(true);
				m_masi.setM_Lot_ID((Integer)pp.getValue());
			}
			else
			{
				fieldLotString.setReadonly(false);
				m_masi.setM_Lot_ID(0);
			}
		}
		//	Create New Lot
		else if (e.getTarget() == bLot)
		{
			KeyNamePair pp = m_masi.createLot(m_M_Product_ID);
			if (pp != null)
			{
				ListItem item = new ListItem(pp.getName(), pp.getKey());
				fieldLot.appendChild(item);
				fieldLot.setSelectedItem(item);
				fieldLotString.setText (m_masi.getLot());
				fieldLotString.setReadonly(true);
			}
		}
		//	Create New SerNo
		else if (e.getTarget() == bSerNo)
		{
			fieldSerNo.setText(m_masi.getSerNo(true));
		}
		
		//	OK
		else if (e.getTarget().getId().equals("Ok"))
		{
			if (saveSelection())
				dispose();
		}
		//	Cancel
		else if (e.getTarget().getId().equals("Cancel"))
		{
			onCancel();
		}
		//	Zoom M_Lot
		else if (e.getTarget() == mZoom)
		{
			cmd_zoom();
		}
		else
			log.log(Level.SEVERE, "not found - " + e);
	}	//	actionPerformed

	private void onCancel() {
		m_changed = false;
		m_M_AttributeSetInstance_ID = 0;
		m_M_Locator_ID = 0;
		dispose();
	}

	private void cmd_existingCombo() {
		ListItem pp = existingCombo.getSelectedItem();
		if (pp != null && (Integer)pp.getValue() != -1)
		{
			m_M_AttributeSetInstance_ID = (Integer) pp.getValue();
			m_masi = MAttributeSetInstance.get(Env.getCtx(), m_M_AttributeSetInstance_ID, m_M_Product_ID);
			// Get Attribute Set
			MAttributeSet as = m_masi.getMAttributeSet();
			MAttribute[] attributes = as.getMAttributes (false);
			if (log.isLoggable(Level.FINE)) log.fine ("Product Attributes=" + attributes.length);
			for (int i = 0; i < attributes.length; i++)
				updateAttributeEditor(attributes[i], i);
			
			cbNewEdit.setEnabled(true);
			cbNewEdit.setSelected(false);
			bNewRecord.setEnabled(true);
			cmd_edit();
		}
	}

	private void cmd_newRecord() {
		cbNewEdit.setSelected(false);
		cbNewEdit.setEnabled(false);
		bNewRecord.setEnabled(false);
		existingCombo.setSelectedItem(null);
		
		m_M_AttributeSetInstance_ID = 0;
		int M_AttributeSet_ID = m_masi.getM_AttributeSet_ID();
		m_masi = new MAttributeSetInstance (Env.getCtx(), m_M_AttributeSetInstance_ID, M_AttributeSet_ID, null);		
		for (int i = 0; i < m_editors.size(); i++)
		{
			WEditor editor = m_editors.get(i);
			editor.setReadWrite(true);
			editor.setValue(null);
		}
		fieldDescription.setText("");
	}

	private void cmd_edit() {
		boolean check = cbNewEdit.isSelected();
		for (int i = 0; i < m_editors.size(); i++)
		{
			WEditor editor = m_editors.get(i);
			editor.setReadWrite(check);
		}	
	}

	/**
	 * 	Instance Selection Button
	 * 	@return true if selected
	 */
	private void cmd_select()
	{
		log.config("");
		
		int M_Warehouse_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNoParent, "M_Warehouse_ID");
		
		int C_DocType_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNoParent, "C_DocType_ID");
		if (C_DocType_ID > 0) {
			MDocType doctype = new MDocType (Env.getCtx(), C_DocType_ID, null);
			String docbase = doctype.getDocBaseType();
			if (docbase.equals(MDocType.DOCBASETYPE_MaterialReceipt) || MDocType.DOCSUBTYPEINV_CostAdjustment.equals(doctype.getDocSubTypeInv()))
				M_Warehouse_ID = 0;
		}
		
		// teo_sarca [ 1564520 ] Inventory Move: can't select existing attributes
		int M_Locator_ID = 0;
		if (m_AD_Column_ID == COLUMN_M_MOVEMENTLINE_M_ATTRIBUTESETINSTANCE_ID) { // TODO: hardcoded: M_MovementLine[324].M_AttributeSetInstance_ID[8551]
			M_Locator_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNoParent, X_M_MovementLine.COLUMNNAME_M_Locator_ID, true); // only window
		}
		
		String title = "";
		//	Get Text
		String sql = "SELECT p.Name, w.Name, w.M_Warehouse_ID FROM M_Product p, M_Warehouse w "
			+ "WHERE p.M_Product_ID=? AND w.M_Warehouse_ID"
				+ (M_Locator_ID <= 0 ? "=?" : " IN (SELECT M_Warehouse_ID FROM M_Locator where M_Locator_ID=?)"); // teo_sarca [ 1564520 ]
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_M_Product_ID);
			pstmt.setInt(2, M_Locator_ID <= 0 ? M_Warehouse_ID : M_Locator_ID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				title = rs.getString(1) + " - " + rs.getString(2);
				M_Warehouse_ID = rs.getInt(3); // fetch the actual warehouse - teo_sarca [ 1564520 ]
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//		
		final WPAttributeInstance pai = new WPAttributeInstance(title, 
			M_Warehouse_ID, M_Locator_ID, m_M_Product_ID, m_C_BPartner_ID);
		pai.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				if (pai.getM_AttributeSetInstance_ID() != -1)
				{
					m_M_AttributeSetInstance_ID = pai.getM_AttributeSetInstance_ID();
					m_M_AttributeSetInstanceName = pai.getM_AttributeSetInstanceName();
					m_M_Locator_ID = pai.getM_Locator_ID();
					m_changed = true;
					dispose();
				}				
			}
		});		
	}	//	cmd_select

	/**
	 * 	Instance New/Edit
	 */
	private void cmd_newEdit()
	{
		boolean rw = cbNewEdit.isChecked();
		if (log.isLoggable(Level.CONFIG)) log.config("R/W=" + rw + " " + m_masi);
		//
		fieldLotString.setReadonly(!(rw && m_masi.getM_Lot_ID()==0));
		if (fieldLot != null)
			fieldLot.setEnabled(rw);
		bLot.setEnabled(rw);
		fieldSerNo.setReadonly(!rw);
		bSerNo.setEnabled(rw);
		fieldGuaranteeDate.setReadonly(!rw);
		//
		for (int i = 0; i < m_editors.size(); i++)
		{
			WEditor editor = m_editors.get(i);
			editor.setReadWrite(rw);
		}	
	}	//	cmd_newEdit

	/**
	 * 	Zoom M_Lot
	 */
	private void cmd_zoom()
	{
		int M_Lot_ID = 0;
		ListItem pp = fieldLot.getSelectedItem();
		if (pp != null)
			M_Lot_ID = (Integer) pp.getValue();
		MQuery zoomQuery = new MQuery("M_Lot");
		zoomQuery.addRestriction("M_Lot_ID", MQuery.EQUAL, M_Lot_ID);
		log.info(zoomQuery.toString());
		//
		//TODO: to port
	}	//	cmd_zoom

	/**
	 *	Save Selection
	 *	@return true if saved
	 */
	private boolean saveSelection()
	{
		log.info("");
		
		MAttributeSet as = m_masi.getMAttributeSet();
		
		if (as == null)
		{
			return true;
		}
		Trx trx = null;
		String mandatory = "";
		try {
			String trxName = Trx.createTrxName("WPAD");
			trx = Trx.get(trxName, false);
			trx.setDisplayName(getClass().getName()+"_saveSelection");
			m_masi.set_TrxName(trxName);
			as.set_TrxName(trxName);
			
			//
			m_changed = false;
			if (!m_productWindow && as.isLot())
			{
				if (log.isLoggable(Level.FINE)) log.fine("Lot=" + fieldLotString.getText ());
				String text = fieldLotString.getText();
				m_masi.setLot (text);
				if (as.isLotMandatory() && (text == null || text.length() == 0))
					mandatory += " - " + Msg.translate(Env.getCtx(), "Lot");
				m_changed = true;
			}	//	Lot
			if (!m_productWindow && as.isSerNo())
			{
				if (log.isLoggable(Level.FINE)) log.fine("SerNo=" + fieldSerNo.getText());
				String text = fieldSerNo.getText();
				m_masi.setSerNo(text);
				if (as.isSerNoMandatory() && (text == null || text.length() == 0))
					mandatory += " - " + Msg.translate(Env.getCtx(), "SerNo");
				m_changed = true;
			}	//	SerNo
			if (!m_productWindow && as.isGuaranteeDate())
			{
				if (log.isLoggable(Level.FINE)) log.fine("GuaranteeDate=" + fieldGuaranteeDate.getValue());
				Date gDate = fieldGuaranteeDate.getValue();
				Timestamp ts = gDate != null ? new Timestamp(gDate.getTime()) : null;
				m_masi.setGuaranteeDate(ts);
				if (as.isGuaranteeDateMandatory() && ts == null)
					mandatory += " - " + Msg.translate(Env.getCtx(), "GuaranteeDate");
				m_changed = true;
			}	//	GuaranteeDate
			
			//	***	Save Attributes ***
			//	New Instance
			if (mandatory.isEmpty() && (m_changed || m_masi.getM_AttributeSetInstance_ID() == 0))
			{
				m_masi.saveEx();
				m_M_AttributeSetInstance_ID = m_masi.getM_AttributeSetInstance_ID ();
				m_M_AttributeSetInstanceName = m_masi.getDescription();
			}
			
			//	Save Instance Attributes
			MAttribute[] attributes = as.getMAttributes(!m_productWindow);
			MAttribute.set_TrxName(attributes, trxName);
			for (int i = 0; i < attributes.length; i++)
			{
				if (MAttribute.ATTRIBUTEVALUETYPE_List.equals(attributes[i].getAttributeValueType()))
				{
					WEditor editor = (WEditor) m_editors.get(i);
					Object item = editor.getValue();
					MAttributeValue value = (item != null && Integer.valueOf(String.valueOf(item)) > 0) ? new MAttributeValue(
							Env.getCtx(), Integer.valueOf(String.valueOf(item)), null) : null;
					if (log.isLoggable(Level.FINE)) log.fine(attributes[i].getName() + "=" + value);
					if (attributes[i].isMandatory() && value == null)
						mandatory += " - " + attributes[i].getName();
					attributes[i].setMAttributeInstance(m_M_AttributeSetInstance_ID, value);
				}
				else if (MAttribute.ATTRIBUTEVALUETYPE_Number.equals(attributes[i].getAttributeValueType()))
				{
					WEditor editor = (WEditor)m_editors.get(i);
					BigDecimal value = (BigDecimal) editor.getValue();
					if (log.isLoggable(Level.FINE)) log.fine(attributes[i].getName() + "=" + value);
					if (attributes[i].isMandatory() && value == null)
						mandatory += " - " + attributes[i].getName();
					//setMAttributeInstance doesn't work without decimal point
					if (value != null && value.scale() == 0)
						value = value.setScale(1, RoundingMode.HALF_UP);
					attributes[i].setMAttributeInstance(m_M_AttributeSetInstance_ID, value);
				}
				else if (MAttribute.ATTRIBUTEVALUETYPE_Date.equals(attributes[i].getAttributeValueType()))
				{
					WEditor editor = (WEditor) m_editors.get(i);
					Date value = (Date)editor.getValue();
					Timestamp ts = value != null ? new Timestamp(value.getTime()) : null;
					if (attributes[i].isMandatory() && value == null)
						mandatory += " - " + attributes[i].getName();
					attributes[i].setMAttributeInstance(m_M_AttributeSetInstance_ID, ts);
				}
				else if(MAttribute.ATTRIBUTEVALUETYPE_Reference.equals(attributes[i].getAttributeValueType()))
				{
					setEditorValue(mandatory, attributes[i], m_editors.get(i));
				}
				else
				{
					WEditor editor = m_editors.get(i);
					String value = String.valueOf(editor.getValue());
					if (log.isLoggable(Level.FINE)) log.fine(attributes[i].getName() + "=" + value);
					if (attributes[i].isMandatory() && (value == null || value.length() == 0))
						mandatory += " - " + attributes[i].getName();
					attributes[i].setMAttributeInstance(m_M_AttributeSetInstance_ID, value);
				}
				m_changed = true;
			}	//	for all attributes
			m_M_AttributeSetInstance_ID = m_masi.getM_AttributeSetInstance_ID ();
			m_M_AttributeSetInstanceName = m_masi.getDescription();
			//
			if (mandatory.length() > 0)
			{
				Dialog.error(m_WindowNo, "FillMandatory", mandatory);
				return false;
			}
			//	Save Model
			else if (m_changed)
			{
				m_masi.setDescription ();
				m_masi.saveEx();
			}
		}
		finally {
			if (trx != null) {
				if (!m_changed || mandatory.length() > 0)
				{
					// Rollback
					trx.rollback();
				}
				else
				{
					// Commit
					trx.commit();
				}
				trx.close();
				trx = null;
			}
		}
		return true;
	}	//	saveSelection

	public String setEditorValue(String mandatory, MAttribute attributes, WEditor editor)
	{
		int displayType = editor.getGridField().getDisplayType();
		if (displayType == DisplayType.YesNo)
		{
			String value = (boolean) editor.getValue() ? "Y" : "N";
			attributes.setMAttributeInstance(m_M_AttributeSetInstance_ID, value);
		}
		else if (displayType == DisplayType.Date || displayType == DisplayType.DateTime || displayType == DisplayType.Time)
		{
			Timestamp valueTimeStamp = (Timestamp) editor.getValue();
			if (attributes.isMandatory() && valueTimeStamp == null)
				mandatory += " - " + attributes.getName();

			attributes.setMAttributeInstance(m_M_AttributeSetInstance_ID, valueTimeStamp);
		}
		else if (DisplayType.isNumeric(displayType))
		{
			Object value = editor.getValue();
			if (attributes.isMandatory() && value == null)
				mandatory += " - " + attributes.getName();
			if (displayType == DisplayType.Integer)
				attributes.setMAttributeInstance(m_M_AttributeSetInstance_ID, (int)(value == null ? 0 : ((Number) value).intValue()));
			else
				attributes.setMAttributeInstance(m_M_AttributeSetInstance_ID, (BigDecimal) value);
		}
		else if (displayType == DisplayType.Image
					|| displayType == DisplayType.Assignment
					|| displayType == DisplayType.Locator
					|| displayType == DisplayType.TableDir
					|| displayType == DisplayType.Table
					|| displayType == DisplayType.Search
					|| displayType == DisplayType.Account)
		{
			Integer value = (Integer) editor.getValue();
			if (attributes.isMandatory() && value == null)
				mandatory += " - " + attributes.getName();

			String valueLabel = null;
			if (displayType == DisplayType.TableDir
				|| displayType == DisplayType.Table
				|| displayType == DisplayType.Search
				|| displayType == DisplayType.Account)
			{
				valueLabel = editor.getDisplay();
			}

			attributes.setMAttributeInstance(m_M_AttributeSetInstance_ID, new KeyNamePair(value == null ? 0 : value.intValue(), valueLabel));
		}
		else
		{
			String value = (String) editor.getValue();
			if (attributes.isMandatory() && value == null)
				mandatory += " - " + attributes.getName();

			attributes.setMAttributeInstance(m_M_AttributeSetInstance_ID, value);
		}
		return mandatory;
	} // setEditorValue
	
	/**************************************************************************
	 * 	Get Instance ID
	 * 	@return Instance ID
	 */
	public int getM_AttributeSetInstance_ID()
	{
		return m_M_AttributeSetInstance_ID;
	}	//	getM_AttributeSetInstance_ID

	/**
	 * 	Get Instance Name
	 * 	@return Instance Name
	 */
	public String getM_AttributeSetInstanceName()
	{
		return m_M_AttributeSetInstanceName;
	}	//	getM_AttributeSetInstanceName
	
	/**
	 * Get Locator ID
	 * @return M_Locator_ID
	 */
	public int getM_Locator_ID()
	{
		return m_M_Locator_ID; 
	}

	/**
	 * 	Value Changed
	 *	@return true if changed
	 */
	public boolean isChanged()
	{
		return m_changed;
	}	//	isChanged

} //	WPAttributeDialog
