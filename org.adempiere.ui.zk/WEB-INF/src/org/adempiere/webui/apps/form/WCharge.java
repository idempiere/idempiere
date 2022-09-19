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

/**
 * 2007, Modified by Posterita Ltd.
 */

package org.adempiere.webui.apps.form;

import java.io.Serializable;
import java.util.logging.Level;

import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.WListItemRenderer;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.apps.form.Charge;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;

/**
 * This class represents the Custom Form for generating charges
 * from natural accounts.
 *
 * The form is comprised of two parts.
 * The upper portion can be used to create new charges using the general charge accounts.
 * The lower portion can be used to create charges based on the natural account.
 *
 * @author Andrew Kimball
 *
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VCharge")
public class WCharge extends Charge implements IFormController, EventListener<Event>, Serializable
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 4571016052942218676L;

	private CustomForm form = new CustomForm();

	/** AD_Message for "Create". */
    private static final String AD_MESSAGE_CREATE = "Create";
    /** Logger.          */
    private static final CLogger log = CLogger.getCLogger(WCharge.class);

    // new panel
    /** Grid for components for creating a new charge account. */
    private Grid m_grdNew = GridFactory.newGridLayout();
    /** Value (key) field label. */
    private Label m_lblValue = new Label();
    /** Field for specifying value (key) of new account. */
    private Textbox m_txbValueField = new Textbox();
    /** Checkbox for specifying whether or not the new account is an expense account. */
    private Checkbox m_chbIsExpense = new Checkbox();
    /** Name field label. */
    private Label m_lblName = new Label();
    /** Field for specifying name of new account. */
    private Textbox m_txbNameField = new Textbox();
    /** Button to create new account. */
    private Button m_btnNew = new Button();

    // account panel
    /** Grid for components for creating a charge form a selected account. **/
    private Panel m_pnlAccount = new Panel();
    /** Button to create charge from selected account. */
    private Button m_btnAccount = new Button();
    /** Table to hold data of accounts. */
    private WListbox m_tblData = new WListbox();
    /** selected account count */
	private int m_selectedCount;

    /**
     * Default constructor.
     */
    public WCharge()
    {
        super();
        m_WindowNo = form.getWindowNo();
        initForm();
    }


    /**
     * Initialises the panel.
     */
    protected void initForm()
    {
        if (log.isLoggable(Level.INFO)) log.info("");
        try
        {
            staticInitialise();
            dynamicInitialise();
            zkInit();
        }
        catch(Exception e)
        {
            log.log(Level.SEVERE, "", e);
        }

        return;
    }


    /**
     * Initialises the static components of the form.
     */
    private void staticInitialise()
    {
        createNewChargePanel();
        createAccountPanel();

        return;
    }

    private void zkInit()
	{
		Borderlayout contentPane = new Borderlayout();
		form.appendChild(contentPane);

		North north = new North();
		contentPane.appendChild(north);
		north.appendChild(m_grdNew);
		north.setCollapsible(true);
		north.setSplittable(true);

		Center center = new Center();
        contentPane.appendChild(center);
		center.appendChild(m_pnlAccount);
	}

    /**
     * Creates the account panel.
     *
     * The account panel contains:
     * <li>a table detailing all accounts
     * <li>a button for creating charges for selected accounts
     */
    private void createAccountPanel()
    {
    	Borderlayout borderlayout = new Borderlayout();
    	borderlayout.setStyle("position: relative");
    	ZKUpdateUtil.setWidth(borderlayout, "100%");
    	ZKUpdateUtil.setHeight(borderlayout, "100%");
    	m_pnlAccount.appendChild(borderlayout);
    	ZKUpdateUtil.setWidth(m_pnlAccount, "100%");
    	ZKUpdateUtil.setHeight(m_pnlAccount, "100%");

		North north = new North();
		north.setBorder("none");
		borderlayout.appendChild(north);
        Label label = new Label(Msg.getMsg(Env.getCtx(), "ChargeFromAccount"));
        label.setStyle("font-weight: bold;");
		north.appendChild(label);

		Center center = new Center();
		center.setBorder("none");
		center.setAutoscroll(true);
		borderlayout.appendChild(center);
		center.appendChild(m_tblData);
		ZKUpdateUtil.setVflex(m_tblData, "1");
		ZKUpdateUtil.setHflex(m_tblData, "1");

		South south = new South();
		south.setBorder("none");
		borderlayout.appendChild(south);
		Panel southPanel = new Panel();
		southPanel.setStyle("text-align: right;");
		south.appendChild(southPanel);
		m_btnAccount.setLabel(Msg.getMsg(Env.getCtx(), AD_MESSAGE_CREATE) + " " + Msg.getMsg(Env.getCtx(), "From") + " " + Msg.getElement(Env.getCtx(), "Account_ID"));
        m_btnAccount.addEventListener(Events.ON_CLICK, this);
        m_btnAccount.setDisabled(true);
        southPanel.appendChild(new Separator());
		southPanel.appendChild(m_btnAccount);

        return;
    }

    /**
     * Creates the New Charge panel.
     *
     * The New Charge panel is used to specify the name and key of an account
     * and whether or not the account is a charge account.
     */
    private void createNewChargePanel()
    {
        final int nameFieldColumns = 20;
        final int valueFieldColumns = 10;

        // top row
        m_lblValue.setValue(Msg.getElement(Env.getCtx(), EColumn.VALUE.title()));
        m_txbValueField.setCols(valueFieldColumns);
        m_chbIsExpense.setChecked(true);
        m_chbIsExpense.setLabel(Msg.getElement(Env.getCtx(), EColumn.EXPENSE.title()));

        // bottom row
        m_lblName.setValue(Msg.getElement(Env.getCtx(), EColumn.NAME.title()));
        m_txbNameField.setCols(nameFieldColumns);
        m_btnNew.setLabel(Msg.getMsg(Env.getCtx(), AD_MESSAGE_CREATE) + " " + Util.cleanAmp(Msg.getMsg(Env.getCtx(), "New")));
        m_btnNew.addEventListener(Events.ON_CLICK, this);

    	Rows rows = new Rows();
    	m_grdNew.appendChild(rows);

    	Row row = new Row();
        rows.appendChild(row);
        Label label = new Label(Msg.getMsg(Env.getCtx(), "ChargeNewAccount"));
        label.setStyle("font-weight: bold;");
        row.appendCellChild(label, 3);
       

    	row = new Row();
        rows.appendChild(row);
        row.appendChild(m_lblValue.rightAlign());
        row.appendChild(m_txbValueField);
        row.appendChild(m_chbIsExpense);
        ZKUpdateUtil.setHflex(m_txbValueField, "1");

        row = new Row();
        rows.appendChild(row);
        row.appendChild(m_lblName.rightAlign());
        row.appendChild(m_txbNameField);
        row.appendChild(m_btnNew);
        ZKUpdateUtil.setHflex(m_txbNameField, "1");

        row = new Row();
        rows.appendChild(row);
        row.appendCellChild(new Separator(), 3);

        return;
    }


    /**
     *  Initialises the dynamic components of the form.
     *  <li>Gets defaults for primary AcctSchema
     *  <li>Creates Table with Accounts
     */
    private void dynamicInitialise()
    {    	
        ListModelTable model = new ListModelTable(getData());
        m_tblData.setData(model, getColumnNames());
		setColumnClass(m_tblData);		
		m_selectedCount = 0;
		WListItemRenderer renderer = (WListItemRenderer) m_tblData.getItemRenderer();
		renderer.addTableValueChangeListener(e -> {
			if (e.getColumn() == EColumn.SELECT.index() && e.getNewValue() instanceof Boolean) {
				Boolean b = (Boolean) e.getNewValue();
				if (b)
					m_selectedCount++;
				else
					m_selectedCount--;
				m_btnAccount.setDisabled(m_selectedCount == 0);
			}			
		});
		
        return;
    }   //  dynInit

    /**
     *  Event Listener.
     *
     *  @param event event that has been fired.
     */
    public void onEvent(Event event)
    {
        if (log.isLoggable(Level.INFO)) log.info(event.getName());
        //
        if (event.getTarget().getId().equals(ConfirmPanel.A_OK) || m_C_Element_ID == 0)
        {
            close();
        }
        //  new Account
        else if (event.getTarget().equals(m_btnNew))
        {
            createNew();
        }
        else if (event.getTarget().equals(m_btnAccount))
        {
            createAccount();
        }

        return;
    }

    /**
     *  Create new Chargeable Account.
     */
    private void createNew()
    {
        String value;
        String name;

        if (log.isLoggable(Level.CONFIG)) log.config("");
        //  Get Input
        value = m_txbValueField.getValue();
        if (value.length() == 0)
        {
        	throw new WrongValueException(m_txbValueField, Msg.getMsg(Env.getCtx(), "FillMandatory") + m_lblValue.getValue());
        }

        name = m_txbNameField.getText();
        if (name.length() == 0)
        {
        	throw new WrongValueException(m_txbNameField, Msg.getMsg(Env.getCtx(), "FillMandatory") + m_lblName.getValue());
        }

        //  Create Element
        int elementValueId = createElementValue (value, name, m_chbIsExpense.isChecked());
        if (elementValueId == 0)
        {
            Dialog.error(form.getWindowNo(), "ChargeNotCreated", name);
            return;
        }
        //  Create Charge
        int chargeId = createCharge(name, elementValueId);
        if (chargeId == 0)
        {
            Dialog.error(form.getWindowNo(), "ChargeNotCreated", name);
            return;
        }
        Dialog.info(form.getWindowNo(), "ChargeCreated", name);
    }   //  createNew

    /**
     *  Creates Charges from Accounts.
     *  Charges are created for the selected accounts.
     *  The selection is cleared upon completion.
     */
    private void createAccount()
    {
        createAccount(m_tblData);
        if (listCreated.length() > 0)
        {
            Dialog.info(form.getWindowNo(), "ChargeCreated", listCreated.toString());
        }
        if (listRejected.length() > 0)
        {
            Dialog.error(form.getWindowNo(), "ChargeNotCreated", listRejected.toString());
        }
        
        m_selectedCount = 0;
        m_btnAccount.setDisabled(true);

        return;
    }   //  createAccount

    public void close()
    {
        SessionManager.getAppDesktop().closeActiveWindow();
    }


	public ADForm getForm() {
		return form;
	}
}


