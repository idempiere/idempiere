package org.compiere.apps.form;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyVetoException;
import java.beans.VetoableChangeListener;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.SwingConstants;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableModel;

import net.miginfocom.swing.MigLayout;

import org.adempiere.plaf.AdempierePLAF;
import org.compiere.apps.AEnv;
import org.compiere.apps.ConfirmPanel;
import org.compiere.grid.ed.AutoCompletion;
import org.compiere.grid.ed.VCheckBox;
import org.compiere.grid.ed.VComboBox;
import org.compiere.grid.ed.VDate;
import org.compiere.grid.ed.VLookup;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.MiniTable;
import org.compiere.model.MClient;
import org.compiere.model.MFactReconciliation;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRole;
import org.compiere.model.Query;
import org.compiere.swing.CLabel;
import org.compiere.swing.CPanel;
import org.compiere.swing.CTextField;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

public class VFactReconcile extends FactReconcile
implements FormPanel, ActionListener, TableModelListener, VetoableChangeListener {
	
	/**	Window No			*/
	private int         	m_WindowNo = 0;
	/**	FormFrame			*/
	private FormFrame 		m_frame;

	/** Format                  */
	private DecimalFormat   m_format = DisplayType.getNumberFormat(DisplayType.Amount);
	/** Number of selected rows */
	private int             m_noSelected = 0;
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(VFactReconcile.class);

	/**
	 *	Initialize Panel
	 *  @param WindowNo window
	 *  @param frame frame
	 */
	public void init (int WindowNo, FormFrame frame)
	{
		log.info("");
		m_WindowNo = WindowNo;
		m_frame = frame;
		try
		{
			dynInit();
			jbInit();
			
			frame.getContentPane().add(commandPanel, BorderLayout.SOUTH);
			frame.getContentPane().add(mainPanel, BorderLayout.CENTER);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}	//	init
	
	//
	private CPanel mainPanel = new CPanel();
	private BorderLayout mainLayout = new BorderLayout();
	private CPanel parameterPanel = new CPanel();
	private CLabel labelAcctSchema = new CLabel();
	private VLookup fieldAcctSchema = null;
	private MigLayout parameterLayout = null;
	private CLabel labelOrg = new CLabel();
	private VLookup fieldOrg = null;
	private VCheckBox isReconciled = new VCheckBox();
	private CLabel labelAccount = new CLabel();
	private VComboBox fieldAccount = new VComboBox();
	private CLabel labelBPartner = new CLabel();
	private VLookup fieldBPartner = null;

	private JLabel dataStatus = new JLabel();
	private JScrollPane dataPane = new JScrollPane();
	private MiniTable miniTable = new MiniTable();
	private CPanel commandPanel = new CPanel();
	private JButton bCancel = ConfirmPanel.createCancelButton(true);
	private JButton bGenerate = ConfirmPanel.createProcessButton(true);
	private JButton bReset = ConfirmPanel.createResetButton(true);
	private JButton bZoom = ConfirmPanel.createZoomButton(true);
	private FlowLayout commandLayout = new FlowLayout();
	private JButton bRefresh = ConfirmPanel.createRefreshButton(true);
	private CLabel labelDateAcct = new CLabel();
	private VDate fieldDateAcct = new VDate();
	private CLabel labelDateAcct2 = new CLabel();
	private VDate fieldDateAcct2 = new VDate();
	
	private CLabel labelProduct = new CLabel();
	private VLookup fieldProduct = null;
	private boolean loading = false;
	private CLabel differenceLabel = new CLabel();
	private CTextField differenceField = new CTextField();

	/**
	 *  Static Init
	 *  @throws Exception
	 */
	private void jbInit() throws Exception
	{
		//CompiereColor.setBackground(this);
		//
		mainPanel.setLayout(mainLayout);
		parameterLayout = new MigLayout("fillx, wrap 4, hidemode 0", " [150:150][250:250][100:100][200:200]");
		parameterPanel.setLayout(parameterLayout);
		bRefresh.addActionListener(this);
		bReset.addActionListener(this);
		bZoom.addActionListener(this);
		bGenerate.setEnabled(false);
		bReset.setEnabled(false);
		//bRefresh.setText(Msg.getMsg(Env.getCtx(), "Query"));
		bGenerate.setText(Msg.getMsg(Env.getCtx(),"Process"));
		bReset.setText(Msg.getMsg(Env.getCtx(),"Reset"));
		bZoom.setText(Msg.translate(Env.getCtx(), "Fact_Acct_ID"));
		
		//
		labelAcctSchema.setText(Msg.translate(Env.getCtx(), "C_AcctSchema_ID"));
		labelAccount.setText(Msg.translate(Env.getCtx(), "Account_ID"));
		labelBPartner.setText(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		labelDateAcct.setText(Msg.translate(Env.getCtx(), "DateAcct"));
		labelDateAcct2.setText("-");
		labelProduct.setText(Msg.translate(Env.getCtx(), "M_Product_ID"));
		//
		labelOrg.setText(Msg.translate(Env.getCtx(), "AD_Org_ID"));
		isReconciled.setText(Msg.translate(Env.getCtx(), "IsReconciled"));
		dataStatus.setText(" ");
		

		differenceLabel.setText(Msg.getMsg(Env.getCtx(), "Difference"));
		differenceField.setBackground(AdempierePLAF.getFieldBackground_Inactive());
		differenceField.setEditable(false);
		differenceField.setText("0");
		differenceField.setColumns(8);
		differenceField.setHorizontalAlignment(SwingConstants.RIGHT);
		//
		bGenerate.addActionListener(this);
		bCancel.addActionListener(this);
		//
		mainPanel.add(parameterPanel, BorderLayout.NORTH);
		parameterPanel.add(labelAcctSchema, "");
		parameterPanel.add(fieldAcctSchema,   "growx");

		parameterPanel.add(labelOrg,  "");
		parameterPanel.add(fieldOrg,   "growx");

		parameterPanel.add(labelAccount,   "");
		parameterPanel.add(fieldAccount,    "wmax 250");
		
		parameterPanel.add(isReconciled,  "skip 1");

		parameterPanel.add(labelBPartner,   "");
		parameterPanel.add(fieldBPartner,   "growx");

		parameterPanel.add(labelProduct,  "");
		parameterPanel.add(fieldProduct, "growx");

		parameterPanel.add(labelDateAcct, "");
		parameterPanel.add(fieldDateAcct,   "growx");
		
		parameterPanel.add(labelDateAcct2,  "");
		parameterPanel.add(fieldDateAcct2,   "growx");
		
		parameterPanel.add(bRefresh,    "growx");


		mainPanel.add(dataStatus, BorderLayout.SOUTH);
		mainPanel.add(dataPane, BorderLayout.CENTER);
		dataPane.getViewport().add(miniTable, null);
		//
		commandPanel.setLayout(commandLayout);
		commandLayout.setAlignment(FlowLayout.RIGHT);
		commandLayout.setHgap(10);
		commandPanel.add(bZoom, null);
		commandPanel.add(differenceLabel, null);
		commandPanel.add(differenceField, null);
		commandPanel.add(bGenerate, null);
		commandPanel.add(bReset, null);
		commandPanel.add(bCancel, null);
	}   //  jbInit

	/**
	 *  Dynamic Init.
	 *  - Load Bank Info
	 *  - Load BPartner
	 *  - Load Document Type
	 *  - Init Table
	 */
	public void dynInit()
	{
		Properties ctx = Env.getCtx();
		//
		m_AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		

		int AD_Column_ID = FactReconcile.col_C_AcctSchema_ID;        //  Fact_Acct.C_AcctSchema_ID
		MLookup lookupAS = MLookupFactory.get (ctx, m_WindowNo, 0, AD_Column_ID, DisplayType.TableDir);
		fieldAcctSchema = new VLookup("C_AcctSchema_ID", true, false, true, lookupAS);
		fieldAcctSchema.addActionListener(this);
		
		fieldAcctSchema.setValue(MClient.get(ctx).getAcctSchema().getC_AcctSchema_ID());
		
		Dimension dim = fieldAcctSchema.getPreferredSize();
		dim.width = 300;
		fieldAcctSchema.setPreferredSize(dim);
		
		// Organization filter selection
		AD_Column_ID = FactReconcile.col_AD_Org_ID; //C_Period.AD_Org_ID (needed to allow org 0)
		MLookup lookupOrg = MLookupFactory.get(ctx, m_WindowNo, 0, AD_Column_ID, DisplayType.TableDir);
		fieldOrg = new VLookup("AD_Org_ID", true, false, true, lookupOrg);
		if (lookupOrg.containsKey(0))
			fieldOrg.setValue(0);
		else
			fieldOrg.setValue(Env.getAD_Org_ID(ctx));
		
		
		dim = fieldOrg.getPreferredSize();
		dim.width = 300;
		fieldOrg.setPreferredSize(dim);
		
		//  BPartner
		AD_Column_ID = FactReconcile.col_C_BPartner_ID;        //  C_Invoice.C_BPartner_ID
		MLookup lookupBP = MLookupFactory.get (ctx, m_WindowNo, 0, AD_Column_ID, DisplayType.Search);
		fieldBPartner = new VLookup("C_BPartner_ID", false, false, true, lookupBP);
		
		// Product
		AD_Column_ID = FactReconcile.col_M_Product_ID;        //  Fact_Acct.M_Product_ID
		MLookup lookupProduct = MLookupFactory.get (ctx, m_WindowNo, 0, AD_Column_ID, DisplayType.Search);
		fieldProduct = new VLookup("M_Product_ID", false, false, true, lookupProduct);
		
		
		//  Account
		Vector<KeyNamePair> vector = getAccount();
		for(int i=0;i<vector.size();i++)
			fieldAccount.addItem(vector.get(i));
		AutoCompletion.enable(fieldAccount);
		fieldAccount.setMandatory(true);
		fieldAccount.setSelectedIndex(0);
		
		//loadData();

	}   //  dynInit
	
	public void loadData(){
		KeyNamePair pp = (KeyNamePair)fieldAccount.getSelectedItem();
		int Account_ID = pp.getKey();
		if (Account_ID != 0)
			m_Account_ID = Account_ID;
		
		if(fieldOrg.getValue()!=null)
			m_AD_Org_ID = (Integer)fieldOrg.getValue();
			
		if(fieldAcctSchema.getValue()!=null)
			m_C_AcctSchema_ID = (Integer)fieldAcctSchema.getValue();

		if(isReconciled.getValue()!=null)
			m_isReconciled = (Boolean)isReconciled.getValue();
		
		if(fieldBPartner.getValue()!=null)
			m_C_BPartner_ID = (Integer)fieldBPartner.getValue();
		
		if((Integer)fieldProduct.getValue()!=null)
			m_M_Product_ID = (Integer)fieldProduct.getValue();
		
		if(fieldDateAcct.getValue()!=null)
			m_DateAcct = (Timestamp)fieldDateAcct.getValue();
		
		if(fieldDateAcct2.getValue()!=null)
			m_DateAcct2 = (Timestamp)fieldDateAcct2.getValue();
		
		//  Set Model
		Vector<Vector<Object>> data = getData();
		Vector<String> columnNames = getColumnNames();
		
		// Remove Previous Listeners
		miniTable.getModel().removeTableModelListener(this);
		
		DefaultTableModel modelI = new DefaultTableModel(data, columnNames);
		modelI.addTableModelListener(this);
		miniTable.setModel(modelI);
		setColumnClass(miniTable);
		//miniTable.setColumnVisibility(miniTable.getColumnModel().getColumn(1), false);
		miniTable.setColorColumn(amtColIndex);
	}
	
	/**
	 *  Calculate selected rows.
	 *  - add up selected rows
	 */
	public void calculateSelection()
	{
		m_noSelected = 0;
		BigDecimal selectedAmt = new BigDecimal(0.0);

		int rows = miniTable.getRowCount();
		for (int i = 0; i < rows; i++)
		{
			boolean isSelected = (Boolean)miniTable.getModel().getValueAt(i, selectedColIndex);
			if (isSelected)
			{
				BigDecimal amt = (BigDecimal)miniTable.getModel().getValueAt(i, amtColIndex);
				if (amt != null)
					selectedAmt = selectedAmt.add(amt);
				m_noSelected++;
			}
		}

		//  Information
		StringBuffer info = new StringBuffer();
		info.append(m_noSelected).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected")).append(" / ").append(miniTable.getRowCount());
		
		differenceField.setText(m_format.format(selectedAmt));
		dataStatus.setText(info.toString());
		//
		bGenerate.setEnabled(m_noSelected != 0 && Env.ZERO.compareTo(selectedAmt) == 0 && !isReconciled.isSelected());
		bReset.setEnabled(m_noSelected > 0 && isReconciled.isSelected());
	}   //  calculateSelection

	@Override
	public void vetoableChange(PropertyChangeEvent evt)
			throws PropertyVetoException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void tableChanged(TableModelEvent e) {
		if (! loading )
			calculateSelection();
	}   //  valueChanged

	@Override
	public void actionPerformed(ActionEvent e) {
		//  Generate Reconciliation
		if (e.getSource() == bGenerate)
		{
			generateReconciliation();
		}
		
		else if (e.getSource() == bReset)
		{
			resetReconciliation();
		}
		else if (e.getSource() == bZoom)
		{
			zoom();
		}

		else if (e.getSource() == bCancel)
			dispose();

		//  Update
		else if (e.getSource() == bRefresh)
			loadData();
	}
	
	private void generateReconciliation() {
		log.info("");
		//
		miniTable.stopEditor(true);
		if (miniTable.getRowCount() == 0)
			return;
		miniTable.setRowSelectionInterval(0,0);
		calculateSelection();
		if (m_noSelected == 0)
			return;
		

		String format = "yyyy-MM-dd HH:mm:ss.SSS";
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String time = sdf.format(cal.getTime());
		
		for ( int r = 0; r < miniTable.getModel().getRowCount(); r++ )
		{
			boolean isSelected = (Boolean)miniTable.getModel().getValueAt(r, selectedColIndex);
			
			if (isSelected)
			{
				KeyNamePair pp = (KeyNamePair)miniTable.getModel().getValueAt(r, idColIndex);
				
				int factId = pp.getKey();

				boolean result = generate(factId, time);
				if(!result)
					continue;

				((DefaultTableModel) miniTable.getModel()).removeRow(r--);
			}
		}
	}

	/**
	 *	Zoom to target
	 *  @param AD_Window_ID window id
	 *  @param zoomQuery zoom query
	 */
	protected void zoom ()
	{
		log.info("");
		
		int selected = miniTable.getSelectedRow();
		
		if ( selected == -1 )
			return;

		KeyNamePair pp = (KeyNamePair)miniTable.getModel().getValueAt(selected, idColIndex);
		
		int factId = pp.getKey();
		
		AEnv.zoom(270, factId);
	}	//	zoom
	
	private void resetReconciliation() {
		log.info("");
		//
		miniTable.stopEditor(true);
		if (miniTable.getRowCount() == 0)
			return;
		miniTable.setRowSelectionInterval(0,0);
		calculateSelection();
		if (m_noSelected == 0)
			return;

		for ( int r = 0; r < miniTable.getModel().getRowCount(); r++ )
		{
			boolean isSelected = (Boolean)miniTable.getModel().getValueAt(r, selectedColIndex);
			
			if (isSelected)
			{
				KeyNamePair pp = (KeyNamePair)miniTable.getModel().getValueAt(r, idColIndex);
				
				int factId = pp.getKey();

				boolean result = reset(factId);
				if(!result)
					continue;

				((DefaultTableModel) miniTable.getModel()).removeRow(r--);
			}
		}
	}

	@Override
	public void dispose() {
		if (m_frame != null)
			m_frame.dispose();
		m_frame = null;
	}	//	dispose

}
