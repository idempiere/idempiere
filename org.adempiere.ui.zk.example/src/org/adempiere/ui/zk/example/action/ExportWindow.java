/**
 * 
 */
package org.adempiere.ui.zk.example.action;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.base.Service;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.adwindow.ADWindowContent;
import org.adempiere.webui.adwindow.IADTabbox;
import org.adempiere.webui.adwindow.IADTabpanel;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Vbox;

/**
 * @author hengsin
 *
 */
public class ExportWindow extends Window implements EventListener<Event> {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4465587396361021680L;
	
	private Map<String, IGridTabExporter> exporterMap = null;
	private Map<String, String> extensionMap = null;

	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Listbox cboType = new Listbox();
	private Checkbox chkCurrentRow = new Checkbox();
	private ADWindowContent panel;
	
	/**
	 * 
	 */
	public ExportWindow() {
	}

	public void init(ADWindowContent panel) {
		this.panel = panel;
		
		exporterMap = new HashMap<String, IGridTabExporter>();
		extensionMap = new HashMap<String, String>();
		List<IGridTabExporter> exporterList = Service.locator().list(IGridTabExporter.class).getServices();
		for(IGridTabExporter exporter : exporterList)
		{
			String extension = exporter.getFileExtension();
			if (!extensionMap.containsKey(extension))
			{
				extensionMap.put(extension, exporter.getFileExtensionLabel());
				exporterMap.put(extension, exporter);
			}
		}
		
		setTitle(Msg.getMsg(Env.getCtx(), "Export") + ": " + panel.getActiveGridTab().getName());
		setWidth("450px");
		setClosable(true);
		setBorder("normal");
		setStyle("position:absolute");

		cboType.setMold("select");

		cboType.getItems().clear();
		for(Map.Entry<String, String> entry : extensionMap.entrySet())
		{
			cboType.appendItem(entry.getKey() + " - " + entry.getValue(), entry.getKey());
		}

		cboType.setSelectedIndex(0);

		Vbox vb = new Vbox();
		vb.setWidth("100%");
		appendChild(vb);

		Hbox hb = new Hbox();
		Div div = new Div();
		div.setStyle("float: right");
		div.appendChild(new Label("Files of Type: "));
		hb.appendChild(div);
		hb.appendChild(cboType);
		cboType.setWidth("100%");
		vb.appendChild(hb);

		hb = new Hbox();
		chkCurrentRow.setLabel(Msg.getMsg(Env.getCtx(), "ExportCurrentRowOnly"));
		chkCurrentRow.setSelected(true);
		hb.appendChild(chkCurrentRow);
		vb.appendChild(hb);

		vb.appendChild(confirmPanel);
		confirmPanel.addActionListener(this);
		
		setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			onClose();
		else if(event.getTarget().getId().equals(ConfirmPanel.A_OK))
			exportFile();
		
	}
	
	private void exportFile() {
		try {
			ListItem li = cboType.getSelectedItem();
			if(li == null || li.getValue() == null)
			{
				FDialog.error(0, this, "FileInvalidExtension");
				return;
			}

			String ext = li.getValue().toString();
			IGridTabExporter exporter = exporterMap.get(ext);
			if (exporter == null)
			{
				FDialog.error(0, this, "FileInvalidExtension");
				return;
			}

			boolean currentRowOnly = chkCurrentRow.isSelected();
			File file = File.createTempFile("Export", "."+ext);
			IADTabbox adTab = panel.getADTab();
			int selected = adTab.getSelectedIndex();
			int tabLevel = panel.getActiveGridTab().getTabLevel();
			Set<String> tables = new HashSet<String>();
			List<GridTab> childs = new ArrayList<GridTab>();
			List<GridTab> includedList = panel.getActiveGridTab().getIncludedTabs();
			for(GridTab included : includedList)
			{
				String tableName = included.getTableName();
				if (tables.contains(tableName))
					continue;
				tables.add(tableName);
				childs.add(included);
			}
			for(int i = selected+1; i < adTab.getTabCount(); i++)
			{
				IADTabpanel adTabPanel = adTab.getADTabpanel(i);
				if (adTabPanel.getGridTab().isSortTab())
					continue;
				if (adTabPanel.getGridTab().getTabLevel() <= tabLevel)
					break;
				String tableName = adTabPanel.getGridTab().getTableName();
				if (tables.contains(tableName))
					continue;
				tables.add(tableName);
				childs.add(adTabPanel.getGridTab());
			}

			int indxDetailSelected = 0;
			if( adTab.getSelectedDetailADTabpanel()!=null )
				indxDetailSelected = adTab.getSelectedDetailADTabpanel().getGridTab().getTabNo();
			
			exporter.export(panel.getActiveGridTab(), childs, currentRowOnly,file,indxDetailSelected);

			onClose();
			AMedia media = null;
			media = new AMedia(panel.getActiveGridTab().getName() + "." + ext, null, exporter.getContentType(), file, true);
			Filedownload.save(media, panel.getActiveGridTab().getName() + "." + ext);
		} catch (Exception e) {
			throw new AdempiereException(e);
		} finally {
			onClose();
		}
	}
}
