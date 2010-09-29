package org.adempiere.plugin.list;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;
import java.util.logging.Level;

import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.table.DefaultTableModel;

import org.compiere.apps.form.FormFrame;
import org.compiere.apps.form.FormPanel;
import org.compiere.apps.form.VFileImport;
import org.compiere.minigrid.MiniTable;
import org.compiere.swing.CPanel;
import org.compiere.util.CLogger;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.BundleException;

public class PluginList implements FormPanel, ActionListener {

	private static CLogger log = CLogger.getCLogger(PluginList.class);
	private int m_WindowNo;
	private FormFrame m_frame;
	private CPanel northPanel = new CPanel();
	private CPanel centerPanel = new CPanel();
	private CPanel confirmPanel = new CPanel();
	private MiniTable pluginTable = new MiniTable();
	private JScrollPane centerScrollPane = new JScrollPane();
	private JButton refreshButton = new JButton();

	@Override
	public void dispose() {
		if (m_frame != null)
			m_frame.dispose();
		m_frame = null;
	}

	@Override
	public void init(int WindowNo, FormFrame frame) {
		log.info("");
		m_WindowNo = WindowNo;
		m_frame = frame;
		try
		{
			jbInit();
			frame.getContentPane().add(northPanel, BorderLayout.NORTH);
			frame.getContentPane().add(centerPanel, BorderLayout.CENTER);
			frame.getContentPane().add(confirmPanel, BorderLayout.SOUTH);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "init", e);
		}
	}

	private void jbInit() {
		centerPanel.add(centerScrollPane, BorderLayout.CENTER);
		centerScrollPane.getViewport().add(pluginTable, null);
		updatePlugins();
		
		refreshButton.setText("Refresh");
		refreshButton.addActionListener(this);
		confirmPanel.add(refreshButton);
	}

	private void updatePlugins() {
		DefaultTableModel dataModel = new DefaultTableModel(getData(), getColumnNames());
		pluginTable.setModel(dataModel);
		pluginTable.autoSize();
	}

	private Vector<Vector<Object>> getData() {
		BundleContext ctx = getContext();
		Vector<Vector<Object>> result = new Vector<Vector<Object>>();
		for (Bundle bundle : ctx.getBundles()) {
			Vector<Object> col = new Vector<Object>();
			col.add(bundle.getBundleId());
			col.add(state(bundle.getState()));
			col.add(bundle.getSymbolicName());
			col.add(bundle.getVersion());
			result.add(col);
		}
		return result;
	}

	private BundleContext getContext() {
		return Activator.getPluginContext();
	}

	private String state(int state) {
		switch (state) {
		case Bundle.ACTIVE:
			return "ACTIVE";
		case Bundle.INSTALLED:
			return "INSTALLED";
		case Bundle.RESOLVED:
			return "RESOLVED";
		case Bundle.STARTING:
			return "STARTING";
		case Bundle.STOPPING:
			return "STOPPING";
		case Bundle.UNINSTALLED:
			return "UNINSTALLED";
		default:
			return "UNKNOWN";
		}
	}

	private Vector<String> getColumnNames() {
		Vector<String> result = new Vector<String>();
		result.add("Id");
		result.add("State");
		result.add("Name");
		result.add("Version");
		return result;
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if (e.getSource().equals(refreshButton))
			refreshClicked(e);
	}

	private void refreshClicked(ActionEvent e) {
		int row = pluginTable.getSelectedRow();
		if (row==-1)
			return;
		long id = (Long) pluginTable.getValueAt(row, 0);
		Bundle bundle = getContext().getBundle(id);
		try {
			bundle.update();
		} catch (BundleException ex) {
			log.log(Level.SEVERE, "refresh", ex);
		}
	}

}
