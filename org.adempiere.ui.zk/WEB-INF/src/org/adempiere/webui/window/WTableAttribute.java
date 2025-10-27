/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.adempiere.webui.window;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Urlbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.MAttribute;
import org.compiere.model.MTable;
import org.compiere.model.MTableAttribute;
import org.compiere.model.MTableAttributeSet;
import org.compiere.model.MValRule;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Vbox;

/**
 * Window for editing custom attributes related to record based on configured
 * attribute set on AD Table
 * 
 * @author DPansheriya
 *
 */
public class WTableAttribute extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6423631584481652137L;

	/** the attribute set selected on the InfoProduct window */
	private int					p_AD_Table_ID		= 0;
	private int					p_Record_ID			= 0;
	protected int				m_WindowNo;

	/**
	 * Constructor.
	 * Called from AbstractADWindowContent.onAttributeForm(),
	 * 
	 * @param tableID
	 * @param recordID
	 */
	public WTableAttribute(Integer tableID, int recordID)
	{
		super();
		p_AD_Table_ID = tableID;
		p_Record_ID = recordID;
		setTitle(Msg.getMsg(Env.getCtx(), "TableAttribute"));
		this.setBorder("normal");
		this.setMaximizable(false);
		this.setSizable(false);
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);

		try
		{
			init();
			dynInit();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "TableAttribute", e);
		}
		AEnv.showWindow(this);
	} // WTableAttribute

	/** Attribute Editors */
	private Map<Integer, WEditor>	m_attEditors	= new HashMap<Integer, WEditor>();
	/** Logger */
	private static final CLogger			log				= CLogger.getCLogger(WTableAttribute.class);

	private Rows							rows			= null;
	private ConfirmPanel					confirmPanel	= new ConfirmPanel(true);

	/**
	 * Layout dialog
	 * 
	 * @throws Exception
	 */
	private void init() throws Exception
	{
		Vbox vbox = new Vbox();
		this.appendChild(vbox);

		Grid grid = new Grid();
		ZKUpdateUtil.setWidth(grid, "400px");
		grid.setStyle("margin:0; padding:0;");
		grid.makeNoStrip();
		grid.setOddRowSclass("even");
		vbox.appendChild(grid);

		rows = new Rows();
		grid.appendChild(rows);

		// ConfirmPanel
		confirmPanel.addActionListener(this);
		vbox.appendChild(confirmPanel);
	} // jbInit

	/**
	 * Dynamic Init of the Center Panel
	 */
	private void dynInit()
	{
		addAttributes();
	} // dynInit

	/**
	 * Add Attributes
	 * 
	 * @return rows
	 */
	private int addAttributes()
	{
		PO po = MTable.get(Env.getCtx(), p_AD_Table_ID).getPO(p_Record_ID, null);
		ArrayList<MAttribute> attributes = MTableAttributeSet.getMAttributes(p_AD_Table_ID, null);
		for (MAttribute attribute : attributes)
		{
			WEditor editor = null;

			if (MAttribute.ATTRIBUTEVALUETYPE_List.equals(attribute.getAttributeValueType()))
				editor = WebEditorFactory.getEditor(getListTypeGridField(attribute), true);
			else if (MAttribute.ATTRIBUTEVALUETYPE_Number.equals(attribute.getAttributeValueType()))
				editor = WebEditorFactory.getEditor(getNumberGridField(attribute), true);
			else if (MAttribute.ATTRIBUTEVALUETYPE_Reference.equals(attribute.getAttributeValueType()))
				editor = WebEditorFactory.getEditor(getGridField(attribute), true);
			else if (MAttribute.ATTRIBUTEVALUETYPE_Date.equals(attribute.getAttributeValueType()))
				editor = WebEditorFactory.getEditor(getDateGridField(attribute), true);
			else // Text Field
				editor = WebEditorFactory.getEditor(getStringGridField(attribute), true);

			if (editor != null)
			{
				Row row = rows.newRow();

				Label label = editor.getLabel();
				if (!Util.isEmpty(attribute.getDescription(), true))
					label.setValue(attribute.getDescription());
				else if (Util.isEmpty(label.getValue(), true))
					label.setValue(Msg.translate(Env.getCtx(), attribute.get_Translation("Name")));

				row.appendCellChild(label.rightAlign());

				editor.setMandatory(attribute.isMandatory());
				editor.fillHorizontal();
				editor.setValue(po.get_TableAttribute(attribute.getName()));
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
				row.appendCellChild(fieldEditor, 2);
				editor.showMenu();
				m_attEditors.put(attribute.getM_Attribute_ID(), editor);
			}
		}
		return 0;
	} // addProductAttributes

	/**
	 * Get Field editor for attribute
	 * @param attribute
	 * @return
	 */
	public GridField getGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO
						.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(),
										Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), attribute.getAD_Reference_ID(),
										attribute.getAD_Reference_Value_ID(), false, false, null);

		if (attribute.isAttributeValueTypeReference() && DisplayType.isLookup(attribute.getAD_Reference_ID()) && attribute.getAD_Val_Rule_ID() > 0)
		{
			MValRule valRule = MValRule.get(Env.getCtx(), attribute.getAD_Val_Rule_ID());
			vo.ValidationCode = valRule.getCode();
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
		GridFieldVO vo = GridFieldVO
						.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(),
										Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), DisplayType.String, 0, false, false, null);

		return createGridField(attribute, vo);
	} // getStringGridField

	public GridField getNumberGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO
						.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(),
										Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), DisplayType.Number, 0, false, false, null);

		return createGridField(attribute, vo);
	} // getNumberGridField

	public GridField getDateGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO
						.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0, attribute.getName(),
										Msg.translate(Env.getCtx(), attribute.get_Translation("Name")), DisplayType.Date, 0, false, false, null);

		return createGridField(attribute, vo);
	} // getDateGridField

	public GridField getListTypeGridField(MAttribute attribute)
	{
		GridFieldVO vo = GridFieldVO
						.createParameter(Env.getCtx(), m_WindowNo, AEnv.getADWindowID(m_WindowNo), 0, 0,
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

	/**
	 * Handle event
	 * 
	 * @param e event
	 */
	@Override
	public void onEvent(Event e) throws Exception
	{
		if (e.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			saveAttribute();
			dispose();
		}
		else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
		{
			dispose();
		}
	}
	/**
	 * save attribute values
	 */
	private void saveAttribute()
	{
		for (Integer attributeID : m_attEditors.keySet())
		{
			WEditor editor = m_attEditors.get(attributeID);
			Object value = editor.getValue();

			MAttribute att = new MAttribute(Env.getCtx(), attributeID, null);
			MTableAttribute tableAtt = MTableAttribute.get(p_AD_Table_ID, p_Record_ID, att.getM_Attribute_ID());
			if (tableAtt == null)
			{
				if (value == null || Util.isEmpty(value.toString(), true))
					continue;

				tableAtt = (MTableAttribute) MTable.get(Env.getCtx(), MTableAttribute.Table_ID).getPO(0, null);
				tableAtt.setAD_Table_ID(p_AD_Table_ID);
				tableAtt.setRecord_ID(p_Record_ID);
				tableAtt.setM_Attribute_ID(att.getM_Attribute_ID());
			}

			if (tableAtt != null && (value == null || Util.isEmpty(value.toString(), true)))
			{
				tableAtt.delete(true);
				continue;
			}

			String attType = att.getAttributeValueType();
			int reference_ID = att.getAD_Reference_ID();

			if (MAttribute.ATTRIBUTEVALUETYPE_Number.equalsIgnoreCase(attType))
			{
				tableAtt.setValueNumber((BigDecimal) value);
			}
			else if (MAttribute.ATTRIBUTEVALUETYPE_Date.equalsIgnoreCase(attType))
			{
				tableAtt.setValueDate((Timestamp) value);
			}
			else if (MAttribute.ATTRIBUTEVALUETYPE_List.equalsIgnoreCase(attType))
			{
				tableAtt.setM_AttributeValue_ID((int) value);
			}
			else if (MAttribute.ATTRIBUTEVALUETYPE_StringMax40.equalsIgnoreCase(attType))
			{
				tableAtt.setValue((String) value);
			}
			else if (MAttribute.ATTRIBUTEVALUETYPE_Reference.equalsIgnoreCase(attType))
			{
				if (reference_ID == DisplayType.YesNo)
				{
					tableAtt.setValue(((Boolean) value) ? "Y" : "N");
				}
				else if (DisplayType.isText(reference_ID))
				{
					tableAtt.setValue((String) value);
				}
				else if (DisplayType.isDate(reference_ID))
				{
					tableAtt.setValueDate((Timestamp) value);
				}
				else if (DisplayType.isID(reference_ID))
				{
					tableAtt.setValueNumber(BigDecimal.valueOf((Integer) value));
				}
				else if (DisplayType.isNumeric(reference_ID))
				{
					tableAtt.setValueNumber((BigDecimal) value);
				}
				else
				{
					tableAtt.setValue((String) value);
				}
			}
			tableAtt.saveEx();
		}
	}
}
