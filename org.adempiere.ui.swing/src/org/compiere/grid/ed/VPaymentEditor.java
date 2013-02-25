/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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
package org.compiere.grid.ed;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyVetoException;
import java.util.logging.Level;

import javax.swing.DefaultComboBoxModel;
import javax.swing.JComponent;

import org.compiere.grid.IPaymentForm;
import org.compiere.grid.VPaymentFormDialog;
import org.compiere.grid.VPaymentFormFactory;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MLookup;
import org.compiere.model.MPaymentLookup;
import org.compiere.swing.CButton;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.NamePair;

/**
 * 
 * @author Elaine
 *
 */
public class VPaymentEditor extends JComponent implements VEditor, ActionListener, FocusListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1840246214698245287L;
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(VPaymentEditor.class);
	/** Search: The Button to open Editor   */
	private CButton				m_button = new CButton();
	/** The Combo Box if not a Search Lookup    */
	private VComboBox			m_combo = new VComboBox();
	/** Column Name								*/
	private String				m_columnName;
	/** Lookup									*/
	private MPaymentLookup		m_lookup;
	/** The Value								*/
	private Object				m_value;
	
	/** Indicator that value is being set       */
	private volatile boolean 	m_settingValue = false;
	/** Indicator that docus is being set       */
	private volatile boolean 	m_settingFocus = false;
	/** Indicator that Lookup has focus         */
	private volatile boolean	m_haveFocus = false;
	/** Indicator - inserting new value			*/
	@SuppressWarnings("unused")
	private volatile boolean	m_inserting = false;
	/** Last Display							*/
	private String				m_lastDisplay = "";
	
	private boolean 			m_stopediting = false;
	
	private GridField m_mField;
	
	public VPaymentEditor(GridField gridField, String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable, MPaymentLookup lookup) {
		super();
		m_mField = gridField;
		super.setName(columnName);
		m_combo.setName(columnName);
		m_columnName = columnName;
		setMandatory(mandatory);
		m_lookup = lookup;
		if (m_lookup != null)
			m_lookup.setMandatory(mandatory);
		//
		setLayout(new BorderLayout());

		//  Button
		m_button.addActionListener(this);
		m_button.setFocusable(false);   //  don't focus when tabbing
		m_button.setMargin(new Insets(0, 0, 0, 0));
		m_button.setIcon(Env.getImageIcon("Payment10.gif"));

		//	*** VComboBox	***
		if (m_lookup != null)
		{
			//  Don't have to fill up combobox if it is readonly
			if (!isReadOnly && isUpdateable)
				m_lookup.fillComboBox (isMandatory(), true, true, false, false); // IDEMPIERE 90
			m_combo.setModel(m_lookup);
			//
			// AutoCompletion.enable(m_combo);
			m_combo.addActionListener(this);							//	Selection
			//	FocusListener to refresh selection before opening
			m_combo.addFocusListener(this);
		}

		setUI (true);
		//	ReadWrite	-	decides what components to show
		if (isReadOnly || !isUpdateable || m_lookup == null)
			setReadWrite(false);
		else
			setReadWrite(true);
	}
	
	@Override
	public void dispose() {
		m_button = null;
		m_lookup = null;
		m_mField = null;
		//
		m_combo.getEditor().getEditorComponent().removeFocusListener(this);
		m_combo.removeFocusListener(this);
		m_combo.removeActionListener(this);
		m_combo.setModel(new DefaultComboBoxModel());    //  remove reference
	//	m_combo.removeAllItems();
		m_combo = null;
	}
	
	private void setUI (boolean initial)
	{
		if (initial)
		{
			Dimension size = m_combo.getPreferredSize();
			setPreferredSize(new Dimension(size));  //	causes r/o to be the same length
			setMinimumSize(new Dimension (30, size.height));
			//
			Dimension bSize = new Dimension(size.height, size.height);
			m_button.setPreferredSize (bSize);
		}

		//	What to show
		this.remove(m_combo);
		this.remove(m_button);
		//
		this.setBorder(null);
		this.add(m_combo, BorderLayout.CENTER);
		this.add(m_button, BorderLayout.EAST);
	}
	
	@Override
	public void setReadWrite(boolean value) {
		setReadWrite0(value);
		
		GridTab m_mTab = m_mField.getGridTab();
		String m_DocStatus = (String) m_mTab.getValue("DocStatus");
		// DocStatus
		if (m_DocStatus == null)
			m_DocStatus = "";
		// Is the Trx closed? Reversed / Voided / Cloased
		if (m_DocStatus.equals("RE") || m_DocStatus.equals("VO") || m_DocStatus.equals("CL"))
		{
			m_button.setVisible(false);
			return;
		}
		
		boolean m_onlyRule = false;
		// Document is not complete - allow to change the Payment Rule only
		if (m_DocStatus.equals("CO") || m_DocStatus.equals("WP"))
			m_onlyRule = false;
		else
			m_onlyRule = true;
		
		boolean m_isSOTrx = "Y".equals(Env.getContext(Env.getCtx(), m_mField.getWindowNo(), "IsSOTrx"));
		// PO only Rule
		if (!m_onlyRule // Only order has Warehouse
				&& !m_isSOTrx && m_mTab.getValue("M_Warehouse_ID") != null)
			m_onlyRule = true;

		m_button.setVisible(value && !m_onlyRule);
	}
	
	private void setReadWrite0(boolean value)
	{
		boolean rw = value;
		if (m_lookup == null)
			rw = false;
		if (m_combo.isReadWrite() != value)
		{
			m_combo.setReadWrite(rw);
			setUI (false);
			if (value) {
				m_settingValue = true;		//	disable actions
				refresh();
				m_settingValue = false;
			}
			setValue (m_value);
		}
	}

	@Override
	public boolean isReadWrite() {
		return m_combo.isReadWrite();
	}

	@Override
	public void setMandatory(boolean mandatory) {
		m_combo.setMandatory(mandatory);
	}

	@Override
	public boolean isMandatory() {
		return m_combo.isMandatory();
	}

	@Override
	public void setBackground(boolean error) {
		m_combo.setBackground(error);
	}
	
	@Override
	public void requestFocus ()
	{
		if (m_lookup != null)
			m_combo.requestFocus ();
	}

	@Override
	public void setValue(Object value) {
		log.fine(m_columnName + "=" + value);
		m_settingValue = true;		//	disable actions
		m_value = value;

		//	Set both for switching
		if (value == null)
		{
			m_combo.setValue (value);
			m_lastDisplay = "";
			m_settingValue = false;
			return;
		}
		if (m_lookup == null)
		{
			m_combo.setValue (value);
			m_lastDisplay = value.toString();
			m_settingValue = false;
			return;
		}

		//must call m_combo.setvalue after m_lookup as
		//loading of combo data might happen in m_lookup.getDisplay
		m_lastDisplay = m_lookup.getDisplay(value);
		m_combo.setValue (value);

		if (m_lastDisplay.equals("<-1>"))
		{
			m_lastDisplay = "";
			m_value = null;
		}
		boolean notFound = m_lastDisplay.startsWith("<") && m_lastDisplay.endsWith(">");

		//	Nothing showing in Combo and should be showing
		if (m_combo.getSelectedItem() == null)
		{
			//  lookup found nothing too
			if (notFound)
			{
				log.finest(m_columnName + "=" + value + ": Not found - " + m_lastDisplay);
				//  we may have a new value
				m_lookup.refresh();
				m_combo.setValue (value);
				m_lastDisplay = m_lookup.getDisplay(value);
				notFound = m_lastDisplay.startsWith("<") && m_lastDisplay.endsWith(">");
			}
			if (notFound && value instanceof Integer && m_lookup.getDisplayType() != DisplayType.ID) // for IDs is ok to be out of the list
			{
				m_value = null;
				actionCombo (null);             //  data binding
				log.fine(m_columnName + "=" + value + ": Not found");
			}
			//  we have lookup
			else if (m_combo.getSelectedItem() == null)
			{
				NamePair pp = m_lookup.get(value);
				if (pp != null)
				{
					log.fine(m_columnName + " added to combo - " + pp);
					//  Add to Combo
					m_combo.addItem (pp);
					m_combo.setValue (value);
				}
			}
			//  Not in Lookup - set to Null
			if (m_combo.getSelectedItem() == null)
			{
				if (value instanceof Integer && m_lookup.getDisplayType() != DisplayType.ID) // for IDs is ok to be out of the list
				{
					log.info(m_columnName + "=" + value + ": not in Lookup - set to NULL");
					actionCombo (null);             //  data binding (calls setValue again)
					m_value = null;
				}
			}
		}
		m_settingValue = false;
	}
	
	@Override
	public void propertyChange(PropertyChangeEvent evt) {
		if (m_stopediting)
			return;

	//	log.fine( "VLookup.propertyChange", evt);
		if (evt.getPropertyName().equals(GridField.PROPERTY))
		{
			m_inserting = GridField.INSERTING.equals(evt.getOldValue());	//	MField.setValue
			setValue(evt.getNewValue());
			m_inserting = false;
		}
	}

	@Override
	public Object getValue() {
		return m_combo.getValue ();
	}

	@Override
	public String getDisplay() {
		return m_combo.getDisplay();
	}

	@Override
	public void setField(GridField mField) {
		m_mField = mField;
	}

	@Override
	public GridField getField() {
		return m_mField;
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if (m_settingValue || m_settingFocus || m_stopediting)
			return;
		if (log.isLoggable(Level.CONFIG)) log.config(m_columnName + " - " + e.getActionCommand() + ", ComboValue=" + m_combo.getSelectedItem());

		//  Combo Selection
		if (e.getSource() == m_combo)
		{
			Object value = getValue();
			Object o = m_combo.getSelectedItem();
			if (o != null)
			{
				String s = o.toString();
				//  don't allow selection of inactive
				if (s.startsWith(MLookup.INACTIVE_S) && s.endsWith(MLookup.INACTIVE_E))
				{
					log.info(m_columnName + " - selection inactive set to NULL");
					value = null;
				}
			}
			actionCombo (value);                //  data binding
		}
		//  Button pressed
		else if (e.getSource() == m_button)
			actionButton ();
	}
	
	@Override
	public void addActionListener(ActionListener listener) {
		m_combo.addActionListener(listener);
	}
	
	private void actionCombo (Object value)
	{
		log.fine("Value=" + value);
		try
		{
			// -> GridController.vetoableChange
			fireVetoableChange (m_columnName, null, value);
		}
		catch (PropertyVetoException pve)
		{
			log.log(Level.SEVERE, m_columnName, pve);
		}
		//  is the value updated ?
		boolean updated = false;

		Object updatedValue = value;

		if (updatedValue instanceof Object[] && ((Object[])updatedValue).length > 0)
		{
			updatedValue = ((Object[])updatedValue)[0];
		}

		if (updatedValue == null && m_value == null)
			updated = true;
		else if (updatedValue != null && value.equals(m_value))
			updated = true;
		if (!updated)
		{
			//  happens if VLookup is used outside of APanel/GridController (no property listener)
			log.fine(m_columnName + " - Value explicitly set - new=" + updatedValue + ", old=" + m_value);

			// phib: the following check causes the update to fail on jre > 1.6.0_13
			// commenting out as it does not appear to be necessary
			//if (getListeners(PropertyChangeListener.class).length <= 0)
				setValue(updatedValue);
		}
	}	//	actionCombo
	
	private void actionButton ()
	{
		m_button.setEnabled(false);                 //  disable double click
		if (m_lookup == null)
			return;		//	leave button disabled
		m_combo.requestFocus();						//  closes other editors
		
		int windowNo = m_lookup.getWindowNo();
		Object newValue = getValue();
		if (newValue != null)
		{
			IPaymentForm pf = VPaymentFormFactory.create(windowNo, getField().getGridTab(), (String) newValue);
			if(pf != null)
			{
				VPaymentFormDialog dialog = (VPaymentFormDialog) pf.getWindow();
				if(dialog.isInitOK())
				{
					dialog.setLocationRelativeTo(null);
					pf.showWindow();
					pf.closeWindow();
					getField().getGridTab().dataRefresh();
				}
				else
					pf.closeWindow();
			}
		}
		
		m_button.setEnabled(true);
		m_combo.requestFocus();
	}	//	actionButton
	
	@Override
	public void focusGained (FocusEvent e)
	{
		if (m_combo == null || m_combo.getEditor() == null)
			return;
		if ((e.getSource() != m_combo && e.getSource() != m_combo.getEditor().getEditorComponent())
			|| e.isTemporary() || m_haveFocus || m_lookup == null)
			return;

		//avoid repeated query
		if (m_lookup.isValidated() && m_lookup.isLoaded())
		{
			m_haveFocus = true;
			return;
		}
		//
		m_haveFocus = true;     //  prevents calling focus gained twice
		m_settingFocus = true;  //  prevents actionPerformed
		//
		Object obj = m_lookup.getSelectedItem();
		if (log.isLoggable(Level.CONFIG)) log.config(m_columnName
			+ " - Start    Count=" + m_combo.getItemCount() + ", Selected=" + obj);
	//	log.fine( "VLookupHash=" + this.hashCode());
		boolean popupVisible = m_combo.isPopupVisible();
		m_lookup.fillComboBox(isMandatory(), true, true, false, false);     //  only validated & active + IDEMPIERE 90
		if (popupVisible)
		{
			//refresh
			m_combo.hidePopup();
			m_combo.showPopup();
		}
		if (log.isLoggable(Level.CONFIG))log.config(m_columnName
			+ " - Update   Count=" + m_combo.getItemCount() + ", Selected=" + m_lookup.getSelectedItem());
		m_lookup.setSelectedItem(obj);
		if (log.isLoggable(Level.CONFIG))log.config(m_columnName
			+ " - Selected Count=" + m_combo.getItemCount() + ", Selected=" + m_lookup.getSelectedItem());
		//
		m_settingFocus = false;
	}	//	focusGained

	@Override
	public void focusLost(FocusEvent e)
	{
		if (e.isTemporary()
			|| m_lookup == null
			|| !m_button.isEnabled() )	//	set by actionButton
			return;
		//	Combo lost focus
		if (e.getSource() != m_combo && e.getSource() != m_combo.getEditor().getEditorComponent())
			return;
		if (m_lookup.isValidated() && !m_lookup.hasInactive())
		{
			m_haveFocus = false;
			return;
		}
		//
		m_settingFocus = true;  //  prevents actionPerformed
		//
		if (log.isLoggable(Level.CONFIG)) log.config(m_columnName + " = " + m_combo.getSelectedItem());
		Object obj = m_combo.getSelectedItem();
		/*
		//	set original model
		if (!m_lookup.isValidated())
			m_lookup.fillComboBox(true);    //  previous selection
		*/
		//	Set value
		if (obj != null)
		{
			m_combo.setSelectedItem(obj);
			//	original model may not have item
			if (!m_combo.getSelectedItem().equals(obj))
			{
				log.fine(m_columnName + " - added to combo - " + obj);
				m_combo.addItem(obj);
				m_combo.setSelectedItem(obj);
			}
		}
	//	actionCombo(getValue());
		m_settingFocus = false;
		m_haveFocus = false;    //  can gain focus again
	}	//	focusLost
	
	public void setToolTipText(String text)
	{
		super.setToolTipText(text);
		m_button.setToolTipText(text);
		m_combo.setToolTipText(text);
	}
	
	public int refresh()
	{
		if (m_lookup == null)
			return -1;

		//no need to refresh readonly lookup, just remove direct cache
		if (!isReadWrite()) {
			m_lookup.removeAllElements();
			return 0;
		}

		return m_lookup.refresh();
	}	//	refresh
	
	public void setStopEditing(boolean stopediting) {
		m_stopediting = stopediting;
	}
}
