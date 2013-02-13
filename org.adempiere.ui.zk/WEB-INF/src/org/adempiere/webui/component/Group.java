package org.adempiere.webui.component;

import java.util.ArrayList;
import java.util.List;

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Image;
import org.zkoss.zul.Label;
import org.zkoss.zul.Row;

public class Group extends org.zkoss.zul.Group {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6735090880559291438L;

	public static final String GROUP_ROW_VISIBLE_KEY = "groupRowVisible";

	private List<org.adempiere.webui.component.Row> m_rows = new ArrayList<org.adempiere.webui.component.Row>();

	public Group() {
		super();
		setZclass("z-group");
	}
	
	public Group(String label) {
		super(label);
		setZclass("z-group");
	}
	
	public <T> Group(String label, T value) {
		super(label, value);
		setZclass("z-group");
	}

	public String getLabel() {
		final Component cell = getFirstChild();
		return cell != null && cell instanceof GroupHeader ? ((GroupHeader)cell).getTitle() : null;
	}

	@Override
	public void setLabel(String label) {
		autoFirstCell().setTitle(label);
	}	
	
	private GroupHeader autoFirstCell() {
		Component cell = getFirstChild();
		if (cell == null || cell instanceof GroupHeader) {
			if (cell == null) cell = new GroupHeader();
			cell.applyProperties();
			cell.setParent(this);
			return (GroupHeader)cell;
		}
		throw new UiException("Unsupported child for setLabel: "+cell);
	}
	
	public void setOpen(boolean open) {
		super.setOpen(open);
		autoFirstCell().setOpen(isOpen());
		
		if (getParent() != null)
		{
			for (Row row : m_rows)
			{
				boolean visible = true;
				String value = (String) row.getAttribute(GROUP_ROW_VISIBLE_KEY);
				if (value != null)
					visible = value.equals("true");				
				row.setVisible(isOpen() && visible);	// hide the row of the children when group is not open
			}
		}
	}
	
	public void add(org.adempiere.webui.component.Row row) {
		m_rows.add(row);
	}

	public static class GroupHeader extends Cell implements EventListener<Event>
	{
		/**
		 * 
		 */
		private static final long serialVersionUID = -4070011056533999557L;
		private Image img;
		private Label lbl;
		
		private String title;
		private boolean open;
		
		public GroupHeader()
		{
			super();
			init();
			setTitle(null);
			setOpen(true);
		}
		
		private void init()
		{
			setZclass("z-group-header");
			
			img = new Image();
			img.setZclass("z-group-img");
			appendChild(img);
			img.addEventListener(Events.ON_CLICK, this);
			
			lbl = new Label();
			lbl.setStyle("cursor: pointer");
			lbl.addEventListener(Events.ON_CLICK, this);
			appendChild(lbl);
		}
		
		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
			lbl.setValue(this.title);
		}

		public boolean isOpen() {
			return open;
		}

		public void setOpen(boolean open) {
			this.open = open;
			img.setSclass(this.open ? "z-group-img-open" : "z-group-img-close");
		}

		@Override
		public void onEvent(Event e) throws Exception 
		{
			if (e.getName().equals(Events.ON_CLICK))
			{
//				if (e.getTarget() == img)
//				{
					((Group) getParent()).setOpen(!isOpen());
//				}
			}
		}
	}

}
