package org.compiere.grid;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;

import org.compiere.apps.ADialog;
import org.compiere.apps.AEnv;
import org.compiere.apps.ConfirmPanel;
import org.compiere.swing.CDialog;
import org.compiere.swing.CPanel;
import org.compiere.util.Env;
import org.compiere.util.Msg;

public class VPaymentFormDialog extends CDialog implements ActionListener
{
	private PaymentForm paymentForm;
	private int windowNo;

	private CPanel mainPanel = new CPanel();
	private BorderLayout mainLayout = new BorderLayout();
	private CPanel centerPanel = new CPanel();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	
	private boolean initOK = false;
	
	public VPaymentFormDialog(PaymentForm paymentForm, int windowNo)
	{
		super(AEnv.getWindow(windowNo), Msg.getMsg(Env.getCtx(), "Payment"), true);
		
		this.paymentForm = paymentForm;
		this.windowNo = windowNo;

		try {
			jbInit();
			initOK = dynInit(); // Null Pointer if order/invoice not saved yet
		} catch (Exception ex) {
			ADialog.error(windowNo, this, ex.getMessage());
			initOK = false;
		}
		
		setPreferredSize(new Dimension(500, 400));
		pack();
	}
	
	private void jbInit() throws Exception
	{
		getContentPane().add(mainPanel);
		mainPanel.setLayout(mainLayout);
		centerPanel.setBorder(BorderFactory.createRaisedBevelBorder());
		mainPanel.add(centerPanel, BorderLayout.CENTER);	
		mainPanel.add(confirmPanel, BorderLayout.SOUTH);
		confirmPanel.addActionListener(this);
	}
	
	private boolean dynInit() throws Exception
	{
		boolean isInitOK = paymentForm.dynInit();
		centerPanel.setVisible(!paymentForm.isOnlyRule());
		return isInitOK;
	}
	
	public CPanel getPanel() {
		return centerPanel;
	}

	/**************************************************************************
	 *	Action Listener
	 *  @param e event
	 */
	public void actionPerformed(ActionEvent e)
	{
		//	Finish
		if (e.getActionCommand().equals(ConfirmPanel.A_OK))
		{
			if (paymentForm.checkMandatory())
			{
				paymentForm.saveChanges(); // cannot recover
				dispose ();
			}
		}
		else if (e.getActionCommand().equals(ConfirmPanel.A_CANCEL))
			dispose();
	}
	
	public boolean isInitOK()
	{
		return initOK;
	}
}