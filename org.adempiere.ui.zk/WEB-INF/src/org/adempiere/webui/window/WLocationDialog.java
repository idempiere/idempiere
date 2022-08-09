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

package org.adempiere.webui.window;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.MAddressValidation;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MCountry;
import org.compiere.model.MLocation;
import org.compiere.model.MOrgInfo;
import org.compiere.model.MRegion;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;
import org.zkoss.zul.Vbox;

/**
 * @author Sendy Yagambrum
 * @date July 16, 2007
 * Location Dialog Box
 * This class is based upon VLocationDialog, written by Jorg Janke
 * @author Cristina Ghita, www.arhipac.ro
 * 			<li>FR [ 2794312 ] Location AutoComplete
 * @author Teo Sarca, teo.sarca@gmail.com
 * 			<li>BF [ 2995212 ] NPE on Location dialog
 * 				https://sourceforge.net/p/adempiere/zk-web-client/419/
 * 
 * @TODO: Implement fOnline button present in swing client
 *
 * @contributors - Carlos Ruiz / globalqss
 * 				 - Show GoogleMap on Location Dialog (integrate approach from LBR)	
 * 				 - http://jira.idempiere.com/browse/IDEMPIERE-147
 **/
public class WLocationDialog extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -9116270523919373406L;
	/** Logger          */
	private static final CLogger log = CLogger.getCLogger(WLocationDialog.class);
	private Label lblAddress1;
	private Label lblAddress2;
	private Label lblAddress3;
	private Label lblAddress4;
	private Label lblAddress5;
	private Label lblComments;
	private Label lblCity;
	private Label lblZip;
	private Label lblRegion;
	private Label lblPostal;
	private Label lblPostalAdd;
	private Label lblCountry;

	private Textbox txtAddress1;
	private Textbox txtAddress2;
	private Textbox txtAddress3;
	private Textbox txtAddress4;
	private Textbox txtAddress5;
	private Textbox txtComments;
	private WAutoCompleterCity txtCity;
	private Textbox txtPostal;
	private Textbox txtPostalAdd;
	private Listbox lstRegion;
	private Listbox lstCountry;

	private ConfirmPanel confirmPanel;
	private Grid mainPanel;

	private boolean     m_change = false;
	private MLocation   m_location;
	private int         m_origCountry_ID;
	private int         s_oldCountry_ID = 0;

	private int m_WindowNo = 0;

	private boolean isCityMandatory = false;
	private boolean isRegionMandatory = false;
	private boolean isAddress1Mandatory = false;
	private boolean isAddress2Mandatory = false;
	private boolean isAddress3Mandatory = false;
	private boolean isAddress4Mandatory = false;
	private boolean isAddress5Mandatory = false;
	private boolean isCommentsMandatory = false;
	private boolean isPostalMandatory = false;
	private boolean isPostalAddMandatory = false;

	private boolean inCountryAction;
	private boolean inOKAction;

	private Button toLink;
	private Button toRoute;
	
	private Listbox lstAddressValidation;
	private Button btnOnline;
	private Textbox txtResult;
	private Checkbox cbxValid;
	private ArrayList<String> enabledCountryList = new ArrayList<String>();
	
	private GridField m_GridField = null;
	private boolean onSaveError = false;
	//END

	public WLocationDialog(String title, MLocation location)
	{
		this (title, location, null);
	}

	public WLocationDialog(String title, MLocation location, GridField gridField) {
		m_GridField  = gridField;
		m_location = location;
		if (m_location == null)
			m_location = new MLocation (Env.getCtx(), 0, null);
		//  Overwrite title 
		if (m_location.getC_Location_ID() == 0)
			setTitle(Msg.getMsg(Env.getCtx(), "LocationNew"));
		else
			setTitle(Msg.getMsg(Env.getCtx(), "LocationUpdate"));    
		//
		// Reset TAB_INFO context
		Env.setContext(Env.getCtx(), m_WindowNo, Env.TAB_INFO, "C_Region_ID", null);
		Env.setContext(Env.getCtx(), m_WindowNo, Env.TAB_INFO, "C_Country_ID", null);
		//
		initComponents();
		init();
		//      Current Country
		for (MCountry country:MCountry.getCountries())
		{
			lstCountry.appendItem(country.toString(), country);
		}
		setCountry();
		lstCountry.addEventListener(Events.ON_SELECT,this);
		lstRegion.addEventListener(Events.ON_SELECT,this);
		m_origCountry_ID = m_location.getC_Country_ID();
		//  Current Region
		lstRegion.appendItem("", null);
		for (MRegion region : MRegion.getRegions(m_origCountry_ID))
		{
			lstRegion.appendItem(region.getTrlName(),region);
		}
		if (m_location.getCountry().isHasRegion()) {
			if (m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName) != null
					&& m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName).trim().length() > 0)
				lblRegion.setValue(m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName));
			else
				lblRegion.setValue(Msg.getMsg(Env.getCtx(), "Region"));
		}

		setRegion();
		initLocation();
		//
		if (!ThemeManager.isUseCSSForWindowSize()) 
		{
			ZKUpdateUtil.setWindowWidthX(this, 380);
			ZKUpdateUtil.setWindowHeightX(this, 420); // required fixed height for ZK to auto adjust the position based on available space
		}
		else
		{
			addCallback(AFTER_PAGE_ATTACHED, t -> {
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
			});
		}
		this.setSclass("popup-dialog location-dialog");
		this.setClosable(true);
		this.setBorder("normal");
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
	}

	private void initComponents()
	{
		lblAddress1     = new Label(Msg.getElement(Env.getCtx(), "Address1"));
		lblAddress1.setSclass("field-label");
		lblAddress2     = new Label(Msg.getElement(Env.getCtx(), "Address2"));
		lblAddress2.setSclass("field-label");
		lblAddress3     = new Label(Msg.getElement(Env.getCtx(), "Address3"));
		lblAddress3.setSclass("field-label");
		lblAddress4     = new Label(Msg.getElement(Env.getCtx(), "Address4"));
		lblAddress4.setSclass("field-label");
		lblAddress5     = new Label(Msg.getElement(Env.getCtx(), "Address5"));
		lblAddress5.setSclass("field-label");
		lblComments     = new Label(Msg.getElement(Env.getCtx(), "Comments"));
		lblComments.setSclass("field-label");
		lblCity         = new Label(Msg.getMsg(Env.getCtx(), "City"));
		lblCity.setSclass("field-label");
		lblZip          = new Label(Msg.getMsg(Env.getCtx(), "Postal"));
		lblZip.setSclass("field-label");
		lblRegion       = new Label(Msg.getMsg(Env.getCtx(), "Region"));
		lblRegion.setSclass("field-label");
		lblPostal       = new Label(Msg.getMsg(Env.getCtx(), "Postal"));
		lblPostal.setSclass("field-label");
		lblPostalAdd    = new Label(Msg.getMsg(Env.getCtx(), "PostalAdd"));
		lblPostalAdd.setSclass("field-label");
		lblCountry      = new Label(Msg.getMsg(Env.getCtx(), "Country"));
		lblCountry.setSclass("field-label");

		txtAddress1 = new Textbox();
		txtAddress1.setCols(20);
		txtAddress1.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Address1));
		txtAddress2 = new Textbox();
		txtAddress2.setCols(20);
		txtAddress2.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Address2));
		txtAddress3 = new Textbox();
		txtAddress3.setCols(20);
		txtAddress3.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Address3));
		txtAddress4 = new Textbox();
		txtAddress4.setCols(20);
		txtAddress4.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Address4));
		txtAddress5 = new Textbox();
		txtAddress5.setCols(20);
		txtAddress5.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Address5));
		txtComments = new Textbox();
		txtComments.setCols(20);
		txtComments.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Comments));

		//autocomplete City
		txtCity = new WAutoCompleterCity(m_WindowNo);
		txtCity.setCols(20);
		txtCity.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_City));
		txtCity.setAutodrop(true);
		txtCity.setAutocomplete(true);
		txtCity.addEventListener(Events.ON_CHANGING, this);
		//txtCity

		txtPostal = new Textbox();
		txtPostal.setCols(20);
		txtPostal.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Postal));
		txtPostalAdd = new Textbox();
		txtPostalAdd.setCols(20);
		txtPostalAdd.setMaxlength(MLocation.getFieldLength(MLocation.COLUMNNAME_Postal_Add));

		lstRegion    = new Listbox();
		lstRegion.setMold("select");
		ZKUpdateUtil.setWidth(lstRegion, "154px");
		lstRegion.setRows(0);

		lstCountry  = new Listbox();
		lstCountry.setMold("select");
		ZKUpdateUtil.setWidth(lstCountry, "154px");
		lstCountry.setRows(0);
		
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);

		toLink = new Button(Msg.getMsg(Env.getCtx(), "Map"));
		LayoutUtils.addSclass("txt-btn", toLink);
		toLink.addEventListener(Events.ON_CLICK,this);
		toRoute = new Button(Msg.getMsg(Env.getCtx(), "Route"));
		LayoutUtils.addSclass("txt-btn", toRoute);
		toRoute.addEventListener(Events.ON_CLICK,this);
		
		btnOnline = new Button(Msg.getElement(Env.getCtx(), "ValidateAddress"));
		LayoutUtils.addSclass("txt-btn", btnOnline);
		btnOnline.addEventListener(Events.ON_CLICK,this);
		
		txtResult = new Textbox();
		txtResult.setCols(2);
		txtResult.setRows(3);
		txtResult.setReadonly(true);
		
		cbxValid = new Checkbox();
		cbxValid.setText(Msg.getElement(Env.getCtx(), "IsValid"));
		cbxValid.setDisabled(true);
		
		lstAddressValidation = new Listbox();
		lstAddressValidation.setMold("select");
		ZKUpdateUtil.setWidth(lstAddressValidation, "154px");
		lstAddressValidation.setRows(0);		

		mainPanel = GridFactory.newGridLayout();
		
		if (ClientInfo.isMobile())
		{
			if (ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH) || ClientInfo.maxHeight(ClientInfo.SMALL_HEIGHT))
			{
				confirmPanel.addButtonSclass("btn-medium small-image-btn");
			}
		}
	}

	private void init()
	{
		Columns columns = new Columns();
		mainPanel.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "30%");
		
		column = new Column();
		columns.appendChild(column);
		ZKUpdateUtil.setWidth(column, "70%");
		
		Row pnlAddress1 = new Row();
		pnlAddress1.appendChild(lblAddress1);
		pnlAddress1.appendChild(txtAddress1);
		ZKUpdateUtil.setHflex(txtAddress1, "1");

		Row pnlAddress2 = new Row();
		pnlAddress2.appendChild(lblAddress2);
		pnlAddress2.appendChild(txtAddress2);
		ZKUpdateUtil.setHflex(txtAddress2, "1");

		Row pnlAddress3 = new Row();
		pnlAddress3.appendChild(lblAddress3);
		pnlAddress3.appendChild(txtAddress3);
		ZKUpdateUtil.setHflex(txtAddress3, "1");

		Row pnlAddress4 = new Row();
		pnlAddress4.appendChild(lblAddress4);
		pnlAddress4.appendChild(txtAddress4);
		ZKUpdateUtil.setHflex(txtAddress4, "1");

		Row pnlAddress5 = new Row();
		pnlAddress5.appendChild(lblAddress5);
		pnlAddress5.appendChild(txtAddress5);
		ZKUpdateUtil.setHflex(txtAddress5, "1");

		Row pnlComments = new Row();
		pnlComments.appendChild(lblComments);
		pnlComments.appendChild(txtComments);
		ZKUpdateUtil.setHflex(txtComments, "1");

		Row pnlCity     = new Row();
		pnlCity.appendChild(lblCity);
		pnlCity.appendChild(txtCity);
		ZKUpdateUtil.setHflex(txtCity, "1");

		Row pnlPostal   = new Row();
		pnlPostal.appendChild(lblPostal);
		pnlPostal.appendChild(txtPostal);
		ZKUpdateUtil.setHflex(pnlPostal, "1");

		Row pnlPostalAdd = new Row();
		pnlPostalAdd.appendChild(lblPostalAdd);
		pnlPostalAdd.appendChild(txtPostalAdd);
		ZKUpdateUtil.setHflex(txtPostalAdd, "1");

		Row pnlRegion    = new Row();
		pnlRegion.appendChild(lblRegion);
		pnlRegion.appendChild(lstRegion);
		ZKUpdateUtil.setHflex(lstRegion, "1");

		Row pnlCountry  = new Row();
		pnlCountry.appendChild(lblCountry);
		pnlCountry.appendChild(lstCountry);
		ZKUpdateUtil.setHflex(lstCountry, "1");

		Panel pnlLinks    = new Panel();
		pnlLinks.appendChild(toLink);
		if (MLocation.LOCATION_MAPS_URL_PREFIX == null)
			toLink.setVisible(false);
		pnlLinks.appendChild(toRoute);
		if (MLocation.LOCATION_MAPS_ROUTE_PREFIX == null || Env.getAD_Org_ID(Env.getCtx()) <= 0)
			toRoute.setVisible(false);
		ZKUpdateUtil.setWidth(pnlLinks, "100%");
		pnlLinks.setStyle("text-align:right");
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		ZKUpdateUtil.setHflex(borderlayout, "1");
		ZKUpdateUtil.setVflex(borderlayout, "1");
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		
		Vbox vbox = new Vbox();
		centerPane.appendChild(vbox);
		vbox.appendChild(mainPanel);
		if (MLocation.LOCATION_MAPS_URL_PREFIX != null || MLocation.LOCATION_MAPS_ROUTE_PREFIX != null)
			vbox.appendChild(pnlLinks);
		
		String addressValidation = MSysConfig.getValue(MSysConfig.ADDRESS_VALIDATION, null, Env.getAD_Client_ID(Env.getCtx()));
		enabledCountryList.clear();
		if (addressValidation != null && addressValidation.trim().length() > 0)
		{
			StringTokenizer st = new StringTokenizer(addressValidation, ";");
			while (st.hasMoreTokens())
			{
				String token = st.nextToken().trim();
				enabledCountryList.add(token);
			}
		}
			
		if (enabledCountryList.size() > 0)
		{
			Grid grid = GridFactory.newGridLayout();
			vbox.appendChild(grid);
			
			columns = new Columns();
			grid.appendChild(columns);
			
			Rows rows = new Rows();
			grid.appendChild(rows);
			
			Row row = new Row();
			rows.appendChild(row);
			row.appendCellChild(lstAddressValidation, 2);
			ZKUpdateUtil.setHflex(lstAddressValidation, "1");			
			
			MAddressValidation[] validations = MAddressValidation.getAddressValidation(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()), null);
			for (MAddressValidation validation : validations)
			{
				ListItem li = lstAddressValidation.appendItem(validation.getName(), validation);
				if (m_location.getC_AddressValidation_ID() == validation.getC_AddressValidation_ID())
					lstAddressValidation.setSelectedItem(li);
			}
			
			if (lstAddressValidation.getSelectedIndex() == -1 && lstAddressValidation.getChildren().size() > 0)
				lstAddressValidation.setSelectedIndex(0);
						
			row = new Row();
			rows.appendChild(row);
			row.appendCellChild(txtResult, 2);
			ZKUpdateUtil.setHflex(txtResult, "1");
			txtResult.setText(m_location.getResult());
			
			row = new Row();
			rows.appendChild(row);
			row.appendChild(cbxValid);
			cbxValid.setChecked(m_location.isValid());
			Cell cell = new Cell();
			cell.setColspan(1);
			cell.setRowspan(1);
			cell.appendChild(btnOnline);
			cell.setAlign("right");
			row.appendChild(cell);
			
			if (!enabledCountryList.isEmpty())
			{
				boolean isEnabled = false;
				if (m_location.getCountry() != null)
				{
					for (String enabledCountry : enabledCountryList)
					{
						if (enabledCountry.equals(m_location.getCountry().getCountryCode().trim()))
						{
							isEnabled = true;
							break;
						}
					}
				}
				btnOnline.setEnabled(isEnabled);
			}
		}
		
		ZKUpdateUtil.setVflex(vbox, "1");
		ZKUpdateUtil.setHflex(vbox, "1");

		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);
		
		addEventListener("onSaveError", this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}
	/**
	 * Dynamically add fields to the Location dialog box
	 * @param panel panel to add
	 *
	 */
	private void addComponents(Row row)
	{
		if (mainPanel.getRows() != null)
			mainPanel.getRows().appendChild(row);
		else
			mainPanel.newRows().appendChild(row);
	}

	private void initLocation()
	{
		if (mainPanel.getRows() != null)
			mainPanel.getRows().getChildren().clear();

		MCountry country = m_location.getCountry();
		if (log.isLoggable(Level.FINE)) log.fine(country.getName() + ", Region=" + country.isHasRegion() + " " + country.getCaptureSequence()
				+ ", C_Location_ID=" + m_location.getC_Location_ID());
		//  new Country
		if (m_location.getC_Country_ID() != s_oldCountry_ID)
		{
			lstRegion.getChildren().clear();
			if (country.isHasRegion()) {
				lstRegion.appendItem("", null);
				for (MRegion region : MRegion.getRegions(country.getC_Country_ID()))
				{
					lstRegion.appendItem(region.getTrlName(),region);
				}
				if (m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName) != null
						&& m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName).trim().length() > 0)
					lblRegion.setValue(m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName));
				else
					lblRegion.setValue(Msg.getMsg(Env.getCtx(), "Region"));
			}
			s_oldCountry_ID = m_location.getC_Country_ID();
		}
		
		if (m_location.getC_Region_ID() > 0 && m_location.getC_Region().getC_Country_ID() == country.getC_Country_ID()) {
			setRegion();
		} else {
			lstRegion.setSelectedItem(null);
			m_location.setC_Region_ID(0);
		}

		if (country.isHasRegion() && m_location.getC_Region_ID() > 0)
		{
			Env.setContext(Env.getCtx(), m_WindowNo, Env.TAB_INFO, "C_Region_ID", String.valueOf(m_location.getC_Region_ID()));
		} else {
			Env.setContext(Env.getCtx(), m_WindowNo, Env.TAB_INFO, "C_Region_ID", "0");
		}
		Env.setContext(Env.getCtx(), m_WindowNo, Env.TAB_INFO, "C_Country_ID", String.valueOf(country.get_ID()));
		
		txtCity.fillList();
		
		//      sequence of City Postal Region - @P@ @C@ - @C@, @R@ @P@
		String ds = country.getCaptureSequence();
		if (ds == null || ds.length() == 0)
		{
			log.log(Level.SEVERE, "CaptureSequence empty - " + country);
			ds = "";    //  @C@,  @P@
		}
		isCityMandatory = false;
		isRegionMandatory = false;
		isAddress1Mandatory = false;
		isAddress2Mandatory = false;
		isAddress3Mandatory = false;
		isAddress4Mandatory = false;
		isAddress5Mandatory = false;
		isCommentsMandatory = false;
		isPostalMandatory = false;
		isPostalAddMandatory = false;
		StringTokenizer st = new StringTokenizer(ds, "@", false);
		while (st.hasMoreTokens())
		{
			String s = st.nextToken();
			if (s.startsWith("CO")) {
				//  Country Last
				addComponents((Row)lstCountry.getParent());
				// TODO: Add Online
				// if (m_location.getCountry().isPostcodeLookup()) {
					// addLine(line++, lOnline, fOnline);
				// }
			} else if (s.startsWith("Com")) {
				addComponents((Row)txtComments.getParent());
				isCommentsMandatory = s.endsWith("!");
			} else if (s.startsWith("A1")) {
				addComponents((Row)txtAddress1.getParent());
				isAddress1Mandatory = s.endsWith("!");
			} else if (s.startsWith("A2")) {
				addComponents((Row)txtAddress2.getParent());
				isAddress2Mandatory = s.endsWith("!");
			} else if (s.startsWith("A3")) {
				addComponents((Row)txtAddress3.getParent());
				isAddress3Mandatory = s.endsWith("!");
			} else if (s.startsWith("A4")) {
				addComponents((Row)txtAddress4.getParent());
				isAddress4Mandatory = s.endsWith("!");
			} else if (s.startsWith("A5")) {
				addComponents((Row)txtAddress5.getParent());
				isAddress5Mandatory = s.endsWith("!");
			} else if (s.startsWith("C")) {
				addComponents((Row)txtCity.getParent());
				isCityMandatory = s.endsWith("!");
			} else if (s.startsWith("P")) {
				addComponents((Row)txtPostal.getParent());
				isPostalMandatory = s.endsWith("!");
			} else if (s.startsWith("A")) {
				addComponents((Row)txtPostalAdd.getParent());
				isPostalAddMandatory = s.endsWith("!");
			} else if (s.startsWith("R") && m_location.getCountry().isHasRegion()) {
				addComponents((Row)lstRegion.getParent());
				isRegionMandatory = s.endsWith("!");
			}
		}

		setPlaceholders();
		//      Fill it
		if (m_location.getC_Location_ID() != 0)
		{
			txtAddress1.setText(m_location.getAddress1());
			txtAddress2.setText(m_location.getAddress2());
			txtAddress3.setText(m_location.getAddress3());
			txtAddress4.setText(m_location.getAddress4());
			txtAddress5.setText(m_location.getAddress5());
			txtComments.setText(m_location.getComments());
			txtCity.setText(m_location.getCity());
			txtPostal.setText(m_location.getPostal());
			txtPostalAdd.setText(m_location.getPostal_Add());
			if (m_location.getCountry().isHasRegion())
			{
				if (m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName) != null
						&& m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName).trim().length() > 0)
					lblRegion.setValue(m_location.getCountry().get_Translation(MCountry.COLUMNNAME_RegionName));
				else
					lblRegion.setValue(Msg.getMsg(Env.getCtx(), "Region"));

				setRegion();                
			}
			setCountry();
		}
	}
	private void setCountry()
	{
		List<?> listCountry = lstCountry.getChildren();
		Iterator<?> iter = listCountry.iterator();
		while (iter.hasNext())
		{
			ListItem listitem = (ListItem)iter.next();
			if (m_location.getCountry().equals(listitem.getValue()))
			{
				lstCountry.setSelectedItem(listitem);
			}
		}
	}

	private void setRegion()
	{
		if (m_location.getRegion() != null) 
		{
			List<?> listState = lstRegion.getChildren();
			Iterator<?> iter = listState.iterator();
			while (iter.hasNext())
			{
				ListItem listitem = (ListItem)iter.next();
				if (m_location.getRegion().equals(listitem.getValue()))
				{
					lstRegion.setSelectedItem(listitem);
				}
			}
		}
		else
		{
			lstRegion.setSelectedItem(null);
		}        
	}
	/**
	 *  Get result
	 *  @return true, if changed
	 */
	public boolean isChanged()
	{
		return m_change;
	}   //  getChange
	/**
	 *  Get edited Value (MLocation)
	 *  @return location
	 */
	public MLocation getValue()
	{
		return m_location;
	}   

	public void onEvent(Event event) throws Exception
	{
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) 
		{
			onSaveError = false;
			
			inOKAction = true;
			
			if (m_location.getCountry().isHasRegion() && lstRegion.getSelectedItem() == null) {
				if (txtCity.getC_Region_ID() > 0 && txtCity.getC_Region_ID() != m_location.getC_Region_ID()) {
					m_location.setRegion(MRegion.get(Env.getCtx(), txtCity.getC_Region_ID()));
					setRegion();
				}
			}
			
			String msg = validate_OK();
			if (msg != null) {
				onSaveError = true;
				Dialog.error(0, "FillMandatory", Msg.parseTranslation(Env.getCtx(), msg), new Callback<Integer>() {					
					@Override
					public void onCallback(Integer result) {
						Events.echoEvent("onSaveError", WLocationDialog.this, null);
					}
				});
				inOKAction = false;
				return;
			}
			
			if (action_OK())
			{
				m_change = true;
				inOKAction = false;
				this.dispose();
			}
			else
			{
				onSaveError = true;
				Dialog.error(0, "CityNotFound", (String)null, new Callback<Integer>() {					
					@Override
					public void onCallback(Integer result) {
						Events.echoEvent("onSaveError", WLocationDialog.this, null);
					}
				});
			}
			inOKAction = false;
		}
		else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
		{
			onCancel();
		}
		else if (toLink.equals(event.getTarget()))
		{
			String urlString = MLocation.LOCATION_MAPS_URL_PREFIX + getFullAdress();
			String message = null;
			try {
				Executions.getCurrent().sendRedirect(urlString, "_blank");
			}
			catch (Exception e) {
				message = e.getMessage();
				Dialog.warn(0, "URLnotValid", message);
			}
		}
		else if (toRoute.equals(event.getTarget()))
		{
			int AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());
			if (AD_Org_ID != 0){
				MOrgInfo orgInfo = 	MOrgInfo.get(Env.getCtx(), AD_Org_ID,null);
				MLocation orgLocation = new MLocation(Env.getCtx(),orgInfo.getC_Location_ID(),null);

				String urlString = MLocation.LOCATION_MAPS_ROUTE_PREFIX +
						         MLocation.LOCATION_MAPS_SOURCE_ADDRESS + orgLocation.getMapsLocation() + //org
						         MLocation.LOCATION_MAPS_DESTINATION_ADDRESS + getFullAdress(); //partner
				String message = null;
				try {
					Executions.getCurrent().sendRedirect(urlString, "_blank");
				}
				catch (Exception e) {
					message = e.getMessage();
					Dialog.warn(0, "URLnotValid", message);
				}
			}
		}
		else if (btnOnline.equals(event.getTarget()))
		{
			btnOnline.setEnabled(false);
			
			onSaveError = false;
			
			inOKAction = true;
			
			if (m_location.getCountry().isHasRegion() && lstRegion.getSelectedItem() == null) {
				if (txtCity.getC_Region_ID() > 0 && txtCity.getC_Region_ID() != m_location.getC_Region_ID()) {
					m_location.setRegion(MRegion.get(Env.getCtx(), txtCity.getC_Region_ID()));
					setRegion();
				}
			}
			
			String msg = validate_OK();
			if (msg != null) {
				onSaveError = true;
				Dialog.error(0, "FillMandatory", Msg.parseTranslation(Env.getCtx(), msg), new Callback<Integer>() {					
					@Override
					public void onCallback(Integer result) {
						Events.echoEvent("onSaveError", WLocationDialog.this, null);
					}
				});
				inOKAction = false;
				return;
			}
			
			MLocation m_location = new MLocation(Env.getCtx(), 0, null);
			m_location.setAddress1(txtAddress1.getValue());
			m_location.setAddress2(txtAddress2.getValue());
			m_location.setAddress3(txtAddress3.getValue());
			m_location.setAddress4(txtAddress4.getValue());
			m_location.setAddress5(txtAddress5.getValue());
			m_location.setComments(txtComments.getValue());
			m_location.setC_City_ID(txtCity.getC_City_ID()); 
			m_location.setCity(txtCity.getValue());
			m_location.setPostal(txtPostal.getValue());
			//  Country/Region
			MCountry country = (MCountry)lstCountry.getSelectedItem().getValue();
			m_location.setCountry(country);
			if (country.isHasRegion() && lstRegion.getSelectedItem() != null)
			{
				MRegion r = (MRegion)lstRegion.getSelectedItem().getValue();
				m_location.setRegion(r);
			}
			else
			{
				m_location.setC_Region_ID(0);
			}			
				
			MAddressValidation validation = lstAddressValidation.getSelectedItem().getValue();
			if (validation == null && lstAddressValidation.getChildren().size() > 0)
				validation = lstAddressValidation.getItemAtIndex(0).getValue();			
			if (validation != null)
			{
				boolean ok = m_location.processOnline(validation.getC_AddressValidation_ID());
				
				txtResult.setText(m_location.getResult());
				cbxValid.setChecked(m_location.isValid());
				
				List<?> list = lstAddressValidation.getChildren();
				Iterator<?> iter = list.iterator();
				while (iter.hasNext())
				{
					ListItem listitem = (ListItem)iter.next();
					if (m_location.getC_AddressValidation().equals(listitem.getValue()))
					{
						lstAddressValidation.setSelectedItem(listitem);
						break;
					}
				}
				if (!ok)
				{
					onSaveError = true;
					Dialog.error(0, "Error", m_location.getErrorMessage(), new Callback<Integer>() {					
						@Override
						public void onCallback(Integer result) {
							Events.echoEvent("onSaveError", WLocationDialog.this, null);
						}
					});
				}
			}
			
			inOKAction = false;
			
			btnOnline.setEnabled(true);
		}
		//  Country Changed - display in new Format
		else if (lstCountry.equals(event.getTarget()))
		{
			inCountryAction = true;
			MCountry c = (MCountry)lstCountry.getSelectedItem().getValue();
			m_location.setCountry(c);
			m_location.setC_City_ID(0);
			m_location.setCity(null);
			//  refresh
			initLocation();
			
			if (!enabledCountryList.isEmpty())
			{
				boolean isEnabled = false;
				if (c != null)
				{
					for (String enabledCountry : enabledCountryList)
					{
						if (enabledCountry.equals(c.getCountryCode().trim()))
						{
							isEnabled = true;
							break;
						}
					}
				}
				btnOnline.setEnabled(isEnabled);
			}
			
			inCountryAction = false;
			lstCountry.focus();
		}
		//  Region Changed 
		else if (lstRegion.equals(event.getTarget()))
		{
			if (inCountryAction || inOKAction)
				return;
			MRegion r = (MRegion)lstRegion.getSelectedItem().getValue();
			m_location.setRegion(r);
			m_location.setC_City_ID(0);
			m_location.setCity(null);
			//  refresh
			initLocation();
			lstRegion.focus();
		}
		else if ("onSaveError".equals(event.getName())) {
			onSaveError = false;
			doPopup();
			focus();			
		}
	}

	private void onCancel() {
		m_change = false;
		this.dispose();
	}

	
	// LCO - address 1, region and city required
	private String validate_OK() {
		String fields = "";
		if (isAddress1Mandatory && txtAddress1.getText().trim().length() == 0) {
			fields = fields + " " + "@Address1@, ";
		}
		if (isAddress2Mandatory && txtAddress2.getText().trim().length() == 0) {
			fields = fields + " " + "@Address2@, ";
		}
		if (isAddress3Mandatory && txtAddress3.getText().trim().length() == 0) {
			fields = fields + " " + "@Address3@, ";
		}
		if (isAddress4Mandatory && txtAddress4.getText().trim().length() == 0) {
			fields = fields + " " + "@Address4@, ";
		}
		if (isAddress5Mandatory && txtAddress5.getText().trim().length() == 0) {
			fields = fields + " " + "@Address5@, ";
		}
		if (isCommentsMandatory && txtComments.getText().trim().length() == 0) {
			fields = fields + " " + "@Comments@, ";
		}
		if (isCityMandatory && txtCity.getValue().trim().length() == 0) {
			fields = fields + " " + "@C_City_ID@, ";
		}
		if (isRegionMandatory && lstRegion.getSelectedItem() == null) {
			fields = fields + " " + "@C_Region_ID@, ";
		}
		if (isPostalMandatory && txtPostal.getText().trim().length() == 0) {
			fields = fields + " " + "@Postal@, ";
		}
		if (isPostalAddMandatory && txtPostalAdd.getText().trim().length() == 0) {
			fields = fields + " " + "@PostalAdd@, ";
		}
		
		if (fields.trim().length() > 0)
			return fields.substring(0, fields.length() -2);

		return null;
	}

	/**
	 *  OK - check for changes (save them) & Exit
	 */
	private boolean action_OK()
	{
		Trx trx = Trx.get(Trx.createTrxName("WLocationDialog"), true);
		trx.setDisplayName(getClass().getName()+"_action_Ok");
		m_location.set_TrxName(trx.getTrxName());
		m_location.setAddress1(txtAddress1.getValue());
		m_location.setAddress2(txtAddress2.getValue());
		m_location.setAddress3(txtAddress3.getValue());
		m_location.setAddress4(txtAddress4.getValue());
		m_location.setAddress5(txtAddress5.getValue());
		m_location.setComments(txtComments.getValue());
		m_location.setC_City_ID(txtCity.getC_City_ID()); 
		m_location.setCity(txtCity.getValue());
		m_location.setPostal(txtPostal.getValue());
		m_location.setPostal_Add(txtPostalAdd.getValue());
		//  Country/Region
		MCountry country = (MCountry)lstCountry.getSelectedItem().getValue();
		m_location.setCountry(country);
		if (country.isHasRegion() && lstRegion.getSelectedItem() != null)
		{
			MRegion r = (MRegion)lstRegion.getSelectedItem().getValue();
			m_location.setRegion(r);
		}
		else
		{
			m_location.setC_Region_ID(0);
		}
		
		if (lstAddressValidation.getSelectedIndex() != -1)
		{
			MAddressValidation validation = (MAddressValidation) lstAddressValidation.getSelectedItem().getValue();
			m_location.setC_AddressValidation_ID(validation.getC_AddressValidation_ID());
		}

		boolean changedCity = m_location.is_ValueChanged(MLocation.COLUMNNAME_City) || m_location.is_ValueChanged(MLocation.COLUMNNAME_C_City_ID);
		boolean changedAddress1 = m_location.is_ValueChanged(MLocation.COLUMNNAME_Address1);
		boolean changedAddress2 = m_location.is_ValueChanged(MLocation.COLUMNNAME_Address2);
		boolean changedRegion = m_location.is_ValueChanged(MLocation.COLUMNNAME_RegionName) || m_location.is_ValueChanged(MLocation.COLUMNNAME_C_Region_ID);
		//  Save changes
		boolean success = m_location.save();
		if (success) {
            // IDEMPIERE-417 Force Update BPLocation.Name
			// just trigger BPLocation name change when the location change affects the name:
			// START_VALUE_BPLOCATION_NAME
			// 0 - City
			// 1 - City + Address1
			// 2 - City + Address1 + Address2
			// 3 - City + Address1 + Address2 + Region
			// 4 - City + Address1 + Address2 + Region + ID
			int bplocname = MSysConfig.getIntValue(MSysConfig.START_VALUE_BPLOCATION_NAME, 0, m_location.getAD_Client_ID(), m_location.getAD_Org_ID());
			if (bplocname < 0 || bplocname > 4)
				bplocname = 0;
			if (   changedCity
				|| (bplocname >= 1 && changedAddress1)
				|| (bplocname >= 2 && changedAddress2)
				|| (bplocname >= 3 && changedRegion)
				) {
	        	if (   m_GridField != null && m_GridField.getGridTab() != null
	        		&& "C_BPartner_Location".equals(m_GridField.getGridTab().getTableName()) 
	        		&& !m_GridField.getGridTab().getValueAsBoolean("IsPreserveCustomName"))
	    		{
	        		m_GridField.getGridTab().setValue("Name", ".");
	    		} else {
	    			//Update BP_Location name IDEMPIERE 417
	    			int bplID = DB.getSQLValueEx(trx.getTrxName(), MLocation.updateBPLocName, m_location.getC_Location_ID());
	    			if (bplID>0)
	    			{
	    				MBPartnerLocation bpl = new MBPartnerLocation(Env.getCtx(), bplID, trx.getTrxName());
	    				bpl.setName(bpl.getBPLocName(m_location));
	    				success = bpl.save();
	    			}
	    		}
			}
		}
		if (success) {
			trx.commit();
		} else {
			trx.rollback();
		}
		trx.close();

		return success;
	}   //  actionOK

	public boolean isOnSaveError() {
		return onSaveError;
	}
	
	@Override
	public void dispose()
	{
		if (!m_change && m_location != null && !m_location.is_new())
		{
			m_location = new MLocation(m_location.getCtx(), m_location.get_ID(), null);
		}	
		super.dispose();
	}
	
	/** returns a string that contains all fields of current form */
	String getFullAdress()
	{
		MRegion region = null;

		if (lstRegion.getSelectedItem()!=null)
			region = new MRegion(Env.getCtx(), ((MRegion)lstRegion.getSelectedItem().getValue()).getC_Region_ID(), null);
		
		MCountry c = (MCountry)lstCountry.getSelectedItem().getValue();

		String address = "";
		address = address + (txtAddress1.getText() != null ? txtAddress1.getText() + ", " : "");
		address = address + (txtAddress2.getText() != null ? txtAddress2.getText() + ", " : "");
		address = address + (txtAddress3.getText() != null ? txtAddress3.getText() + ", " : "");
		address = address + (txtAddress4.getText() != null ? txtAddress4.getText() + ", " : "");
		address = address + (txtCity.getText() != null ? txtCity.getText() + ", " : "");
		if (region != null)
			address = address + (region.getName() != null ? region.getName() + ", " : "");

		address = address + (c.getName() != null ? c.getName() : "");
		return address.replace(" ", "+");
	}	

	void setPlaceholders() {
		txtAddress1.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderAddress1"));
		txtAddress2.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderAddress2"));
		txtAddress3.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderAddress3"));
		txtAddress4.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderAddress4"));
		txtAddress5.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderAddress5"));
		txtComments.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderComments"));
		txtCity.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderCity"));
		txtPostal.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderPostal"));
		txtPostalAdd.setPlaceholder(MCountry.get(Env.getCtx(), s_oldCountry_ID).get_Translation("PlaceholderPostal_Add"));
		// TODO set the placeholder for Region (ATM, lstRegion doesn't handle placeholder)	
	}
}
