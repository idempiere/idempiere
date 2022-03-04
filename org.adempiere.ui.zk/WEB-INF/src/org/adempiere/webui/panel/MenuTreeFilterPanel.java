package org.adempiere.webui.panel;

import java.util.List;

import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.TreeItemAction;
import org.adempiere.webui.util.TreeUtils;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.EventQueues;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Vbox;

public class MenuTreeFilterPanel extends Popup implements EventListener<Event>, IdSpace {

	private static final String ORIGINAL_SIBLING = "original.sibling";

	private static final String FLAT_VIEW_PARENT = "flatView.parent";

	private static final long serialVersionUID = 5884898489357885711L;
	
	public static final String MENU_TREE_FILTER_CHECKED_QUEUE = "MENU_TREE_FILTER_CHECKED_QUEUE";
	
	private Tree tree;
	@SuppressWarnings("unused")
	private TreeSearchPanel searchPanel;

	private Checkbox flatView;

	public MenuTreeFilterPanel(Tree tree, TreeSearchPanel panel) {
		super();
		this.tree = tree;
		this.searchPanel = panel;

		Vbox box = new Vbox();

		Checkbox report = new Checkbox();
		if (ThemeManager.isUseFontIconForImage())
			report.setIconSclass("z-icon-Report");
		else
			report.setImage(ThemeManager.getThemeResource("images/mReport.png"));		
		report.setChecked(true);
		report.setId("report");
		report.addEventListener(Events.ON_CHECK, this);
		box.appendChild(report);

		Checkbox process = new Checkbox();
		if (ThemeManager.isUseFontIconForImage())
			process.setIconSclass("z-icon-Process");
		else
			process.setImage(ThemeManager.getThemeResource("images/mProcess.png"));
		process.setChecked(true);
		process.setId("process");
		process.addEventListener(Events.ON_CHECK, this);
		box.appendChild(process);

		Checkbox workflow = new Checkbox();
		if (ThemeManager.isUseFontIconForImage())
			workflow.setIconSclass("z-icon-WorkFlow");
		else
			workflow.setImage(ThemeManager.getThemeResource("images/mWorkFlow.png"));
		workflow.setChecked(true);
		workflow.setId("workflow");
		workflow.addEventListener(Events.ON_CHECK, this);
		box.appendChild(workflow);

		Checkbox window = new Checkbox();
		if (ThemeManager.isUseFontIconForImage())
			window.setIconSclass("z-icon-Window");
		else
			window.setImage(ThemeManager.getThemeResource("images/mWindow.png"));
		window.setChecked(true);
		window.setId("window");
		window.addEventListener(Events.ON_CHECK, this);
		box.appendChild(window);
		
		Checkbox form = new Checkbox();
		if (ThemeManager.isUseFontIconForImage())
			form.setIconSclass("z-icon-Form");
		else
			form.setImage(ThemeManager.getThemeResource("images/mForm.png"));
		form.setChecked(true);
		form.setId("form");
		form.addEventListener(Events.ON_CHECK, this);
		box.appendChild(form);

		Checkbox info = new Checkbox();
		if (ThemeManager.isUseFontIconForImage())
			info.setIconSclass("z-icon-Info");
		else
			info.setImage(ThemeManager.getThemeResource("images/mInfo.png"));
		info.setChecked(true);
		info.setId("info");
		info.addEventListener(Events.ON_CHECK, this);
		box.appendChild(info);

		flatView = new Checkbox();
		flatView.setLabel(Msg.getMsg(Env.getCtx(), "FlatView"));
		flatView.setId("flatView");
		flatView.setChecked(false);
		flatView.addEventListener(Events.ON_CHECK, this);
		box.appendChild(flatView);

		appendChild(box);
	}

	public void onEvent(Event event) throws Exception {
		final Checkbox chk = (Checkbox) event.getTarget();
		EventQueues.lookup(MENU_TREE_FILTER_CHECKED_QUEUE, EventQueues.DESKTOP, true).publish(new Event(Events.ON_CHECK, null, chk));
	}

	/**
	 * switch menu tree to flat view
	 */
	public void switchToFlatView() {
		if (!flatView.isChecked()) {
			flatView.setChecked(true);
			toggleFlatView(tree, flatView);
		}
	}
	
	/**
	 * 
	 * @param tree
	 * @param chk checkbox for flat view toggle
	 */
	public static void toggleFlatView(Tree tree, final Checkbox chk) {
		final Treeitem[] lastVisitedItem = new Treeitem[1];
		final Treeitem[] lastVisitedParent = new Treeitem[1];
		TreeUtils.traverse(tree, new TreeItemAction() {
			public void run(Treeitem treeItem) {
				Treeitem currentParent = treeItem.getParentItem();
				if (treeItem.getAttribute(AbstractMenuPanel.MENU_TYPE_ATTRIBUTE) == null)
				{
					if (chk.isChecked())
					{
						if (treeItem.getLevel() > 0)
						{
							treeItem.setVisible(false);
						}
					}
					else
					{
						treeItem.setVisible(true);
					}
					if (lastVisitedParent[0] == treeItem.getParentItem())
					{
						if (lastVisitedItem[0] != null && lastVisitedItem[0].getAttribute(ORIGINAL_SIBLING) == null)
						{
							lastVisitedItem[0].setAttribute(ORIGINAL_SIBLING, treeItem);
						}
					}
				}
				else
				{
					if (chk.isChecked())
					{
						if (treeItem.getParentItem() != null && !treeItem.getParentItem().isVisible())
						{
							Treeitem parent = treeItem.getParentItem();
							treeItem.setAttribute(FLAT_VIEW_PARENT, parent);
							while(parent != null)
							{
								if (parent.isVisible())
								{
									if (lastVisitedParent[0] == treeItem.getParentItem())
									{
										if (lastVisitedItem[0] != null && lastVisitedItem[0].getAttribute(ORIGINAL_SIBLING) == null)
										{
											lastVisitedItem[0].setAttribute(ORIGINAL_SIBLING, treeItem);
										}
									}
									treeItem.detach();
									parent.getTreechildren().insertBefore(treeItem, findFlatViewSibling(parent.getTreechildren(), treeItem));
									break;
								}
								parent = parent.getParentItem();
							}
						}
						else
						{
							Treeitem parent = treeItem.getParentItem();
							if (parent != null)
							{
								if (lastVisitedParent[0] == treeItem.getParentItem())
								{
									if (lastVisitedItem[0] != null && lastVisitedItem[0].getAttribute(ORIGINAL_SIBLING) == null)
									{
										lastVisitedItem[0].setAttribute(ORIGINAL_SIBLING, treeItem);
									}
								}
								treeItem.detach();
								parent.getTreechildren().insertBefore(treeItem, findFlatViewSibling(parent.getTreechildren(), treeItem));
							}
						}
					}
					else
					{
						if (treeItem.getAttribute(FLAT_VIEW_PARENT) != null)
						{
							Treeitem parent = (Treeitem) treeItem.getAttribute(FLAT_VIEW_PARENT);
							treeItem.detach();
							Treeitem sibling = (Treeitem) treeItem.getAttribute(ORIGINAL_SIBLING);
							if (sibling != null)
							{
								reattachSibling(parent.getTreechildren(), sibling);
							}
							parent.getTreechildren().insertBefore(treeItem, sibling);
							treeItem.removeAttribute(FLAT_VIEW_PARENT);
						}
						else
						{
							Treeitem parent = treeItem.getParentItem();
							Treeitem sibling = (Treeitem) treeItem.getAttribute(ORIGINAL_SIBLING);
							if (sibling != null)
							{
								reattachSibling(parent.getTreechildren(), sibling);
							}
							parent.getTreechildren().insertBefore(treeItem, sibling);
						}
					}
				}
				lastVisitedItem[0] = treeItem;
				lastVisitedParent[0] = currentParent;
			}
		});
	}

	private static void reattachSibling(Treechildren treechildren, Treeitem treeItem) {
		Treeitem sibling = (Treeitem) treeItem.getAttribute(ORIGINAL_SIBLING);
		if (sibling != null)
		{
			reattachSibling(treechildren, sibling);
		}
		treechildren.insertBefore(treeItem, sibling);
	}

	private static Component findFlatViewSibling(Treechildren treechildren, Treeitem treeItem) {
		List<Component> childrens = treechildren.getChildren();
		if (childrens.isEmpty()) {			
			return null;
		}
		String menuType = (String) treeItem.getAttribute(AbstractMenuPanel.MENU_TYPE_ATTRIBUTE);
		String label = (String) treeItem.getAttribute(AbstractMenuPanel.MENU_LABEL_ATTRIBUTE);
		for(int i = 0; i < childrens.size(); i++) {
			Component child = childrens.get(i);
			if (child instanceof Treeitem) {
				Treeitem ti = (Treeitem) child;
				String tiType = (String) ti.getAttribute(AbstractMenuPanel.MENU_TYPE_ATTRIBUTE);
				if (tiType == null)
					continue;
				if (menuType.equals(tiType)) {
					String tiLabel = (String) ti.getAttribute(AbstractMenuPanel.MENU_LABEL_ATTRIBUTE);
					if (Util.isEmpty(tiLabel))
						continue;
					if (label.compareTo(tiLabel) < 0) {
						return child;
					}
				} else if (menuType.compareTo(tiType) < 0) {
					return child;
				}
			}
		}
		return null;
	}

	public static void toggle(Tree tree, final Checkbox chk) {
		TreeUtils.traverse(tree, new TreeItemAction() {
			public void run(Treeitem treeItem) {
				if (treeItem.getAttribute(AbstractMenuPanel.MENU_TYPE_ATTRIBUTE) != null)
				{
					String menuType = (String) treeItem.getAttribute(AbstractMenuPanel.MENU_TYPE_ATTRIBUTE);
					if (chk.isChecked())
					{
						if (chk.getId().equals(menuType))
						{
							boolean open = false;
							Treeitem parent = treeItem.getParentItem();
							if (parent != null)
								open = parent.isOpen();
							treeItem.setVisible(true);
							if (parent != null)
								parent.setOpen(open);
						}
					}
					else
					{
						if (chk.getId().equals(menuType))
						{
							boolean open = false;
							Treeitem parent = treeItem.getParentItem();
							if (parent != null)
								open = parent.isOpen();
							treeItem.setVisible(false);
							if (parent != null)
								parent.setOpen(open);
						}
					}
				}
			}
		});
	}
}
