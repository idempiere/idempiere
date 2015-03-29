/* GridDataLoader.java
{{IS_NOTE
	Purpose:
		
	Description:
		
	History:
		Oct 29, 2009 10:44:57 AM, Created by henrichen
}}IS_NOTE

Copyright (C) 2009 Potix Corporation. All Rights Reserved.

{{IS_RIGHT
	This program is distributed under GPL Version 3.0 in the hope that
	it will be useful, but WITHOUT ANY WARRANTY.
}}IS_RIGHT
*/
package org.zkoss.zul.impl;

import java.util.LinkedHashSet;
import java.util.Set;

import org.zkoss.lang.Library;
import org.zkoss.lang.Objects;
import org.zkoss.xel.VariableResolver;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.util.ForEachStatus;
import org.zkoss.zk.ui.util.Template;
import org.zkoss.zk.ui.ext.render.Cropper;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Group;
import org.zkoss.zul.GroupRendererExt;
import org.zkoss.zul.Groupfoot;
import org.zkoss.zul.Label;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;
import org.zkoss.zul.RowRendererExt;
import org.zkoss.zul.Rows;
import org.zkoss.zul.event.ListDataEvent;
import org.zkoss.zul.ext.GroupingInfo;
import org.zkoss.zul.ext.Paginal;
import org.zkoss.zul.impl.GroupsListModel.GroupDataInfo;

/**
 * Generic {@link Grid} data loader.
 * @author henrichen
 * @since 5.0.0
 */
public class GridDataLoader implements DataLoader, Cropper {
	private Grid _grid;

	//--DataLoader--//
	public void init(Component owner, int offset, int limit) {
		_grid = (Grid) owner;
	}
	
	public void reset() {
		//do nothing
	}
	
	final public Component getOwner() {
		return _grid;
	}

	public int getOffset() {
		return 0;
	}
	
	public int getLimit() {
		String limit = Library.getProperty("org.zkoss.zul.grid.DataLoader.limit");
		if (limit != null) {
			return Integer.parseInt(limit);
		}
		return 50;
	}

	public int getTotalSize() {
		final Rows rows = _grid.getRows();
		final ListModel<Object> model = _grid.getModel();
		return model != null ? model.getSize() : rows != null ? rows.getVisibleItemCount() : 0;
	}

	private static int INVALIDATE_THRESHOLD = 10;	
	public void doListDataChange(ListDataEvent event) {
		//when this is called _model is never null
		final Rows rows = _grid.getRows();
		final int newsz = event.getModel().getSize(), oldsz = rows.getChildren().size();
		int min = event.getIndex0(), max = event.getIndex1(), cnt;

		switch (event.getType()) {
		case ListDataEvent.INTERVAL_ADDED:
			cnt = newsz - oldsz;
			if (cnt <= 0) {
				syncModel(-1, -1); //out of sync, force sync
				return;
				//throw new UiException("Adding causes a smaller list?");
			}
			if ((oldsz <= 0 || cnt > INVALIDATE_THRESHOLD)
			&& !inPagingMold())
				rows.invalidate();
					//Invalidate rows to improve the performance since it is faster
					//to remove a lot of individual rows. It is safer than invalidating
					//the whole grid since header might have an input affecting the model
					//(e.g., ZK-985: demo's data filter)
					//The memory leak of IE is better with outer (Bug 3147518),
					//and even better with _grid.invalidate() but better to solve ZK-985
			if (min < 0)
				if (max < 0) min = 0;
				else min = max - cnt + 1;
			if (min > oldsz) min = oldsz;

			RowRenderer<?> renderer = null;
			final Component next =
				min < oldsz ? rows.getChildren().get(min): null;
			while (--cnt >= 0) {
				if (renderer == null)
					renderer = (RowRenderer<?>) getRealRenderer();
				rows.insertBefore(newUnloadedItem(renderer, min++), next);
			}
			break;

		case ListDataEvent.INTERVAL_REMOVED:
			cnt = oldsz - newsz;
			if (cnt <= 0) {
				syncModel(-1, -1); //out of sync, force sync
				return;
				//throw new UiException("Removal causes a larger list?");
			}
			if ((newsz <= 0 || cnt > INVALIDATE_THRESHOLD)
			&& !inPagingMold())
				rows.invalidate();
					//Invalidate rows to improve the performance see above

			if (min >= 0) max = min + cnt - 1;
			else if (max < 0) max = cnt - 1; //0 ~ cnt - 1			
			if (max > oldsz - 1) max = oldsz - 1;

			//detach from end (due to groupfoot issue)
			Component comp = rows.getChildren().get(max);
			while (--cnt >= 0) {
				Component p = comp.getPreviousSibling();
				comp.detach();
				comp = p;
			}
			break;

		default: //CONTENTS_CHANGED
			syncModel(min, max < 0 ? -1 : (max - min + 1));
		}
	}
	
	/** Creates a new and unloaded row. */
	protected Component newUnloadedItem(Object renderer, int index) {
		final RowRenderer<?> renderer0 = (RowRenderer<?>) renderer;
		final ListModel<Object> model = ((Grid)getOwner()).getModel();
		Row row = null;
		if (model instanceof GroupsListModel <?, ?, ?>) {
			final GroupsListModel<?, ?, ?> gmodel = (GroupsListModel<?, ?, ?>) model;
			final GroupingInfo info = gmodel.getDataInfo(index);
			switch(info.getType()){
			case GroupDataInfo.GROUP:
				row = newGroup(renderer0);
				((Group)row).setOpen(info.isOpen());
				break;
			case GroupDataInfo.GROUPFOOT:
				row = newGroupfoot(renderer0);
				break;
			default:
				row = newRow(renderer0);
			}		
		}else{
			row = newRow(renderer0);
		}
		((LoadStatus)row.getExtraCtrl()).setLoaded(false);
		((LoadStatus)row.getExtraCtrl()).setIndex(index);

		newUnloadedCell(renderer0, row);
		return row;
	}
	
	private Row newRow(RowRenderer<?> renderer) {
		Row row = null;
		if (renderer instanceof RowRendererExt)
			row = ((RowRendererExt)renderer).newRow((Grid)getOwner());
		if (row == null) {
			row = new Row();
			row.applyProperties();
		}
		return row;
	}
	private Group newGroup(RowRenderer<?> renderer) {
		Group group = null;
		if (renderer instanceof GroupRendererExt)
			group = ((GroupRendererExt)renderer).newGroup((Grid)getOwner());
		if (group == null) {
			group = new Group();
			group.applyProperties();
		}
		return group;
	}
	private Groupfoot newGroupfoot(RowRenderer<?> renderer) {
		Groupfoot groupfoot = null;
		if (renderer instanceof GroupRendererExt)
			groupfoot = ((GroupRendererExt)renderer).newGroupfoot((Grid)getOwner());
		if (groupfoot == null) {
			groupfoot = new Groupfoot();
			groupfoot.applyProperties();
		}
		return groupfoot;
	}
	private Component newUnloadedCell(RowRenderer<?> renderer, Row row) {
		Component cell = null;
		if (renderer instanceof RowRendererExt)
			cell = ((RowRendererExt)renderer).newCell(row);

		if (cell == null) {
			cell = newRenderLabel(null);
			cell.applyProperties();
		}
		cell.setParent(row);
		return cell;
	}
	/** Returns the label for the cell generated by the default renderer.
	 */
	private static Label newRenderLabel(String value) {
		final Label label =
			new Label(value != null && value.length() > 0 ? value: " ");
		label.setPre(true); //to make sure &nbsp; is generated, and then occupies some space
		return label;
	}
	
	public Object getRealRenderer() {
		final RowRenderer<?> renderer = _grid.getRowRenderer();
		return renderer != null ? renderer : _defRend; 
	}
	private static final RowRenderer<Object> _defRend = new RowRenderer<Object>() {
		public void render(final Row row, final Object data, final int index) {
			final Rows rows = (Rows)row.getParent();
			final Grid grid = (Grid)rows.getParent();
			Template tm = getTemplate(grid, rows, "model");
			GroupingInfo info = null;
			if (row instanceof Group) {
				final Template tm2 = getTemplate(grid, rows, "model:group");
				if (tm2 != null)
					tm = tm2;
				if (grid.getModel() instanceof GroupsListModel<?, ?, ?>) {
					final GroupsListModel<?, ?, ?> gmodel = (GroupsListModel<?, ?, ?>)grid.getModel();
					info = gmodel.getDataInfo(index);
				}
			} else if (row instanceof Groupfoot) {
				final Template tm2 = getTemplate(grid, rows, "model:groupfoot");
				if (tm2 != null)
					tm = tm2;
			}
			if (tm == null) {
				final Label label = newRenderLabel(Objects.toString(data));
				label.applyProperties();
				label.setParent(row);
				row.setValue(data);
			} else {
				final GroupingInfo groupingInfo = info;
				final Component[] items = tm.create(rows, row,
					new VariableResolver() {
						public Object resolveVariable(String name) {
							if ("each".equals(name)) {
								return data;
							} else if ("forEachStatus".equals(name)) {
								return new ForEachStatus() {
									
									public ForEachStatus getPrevious() {
										return null;
									}
									
									public Object getEach() {
										return data;
									}
									
									public int getIndex() {
										return index;
									}
									
									public Integer getBegin() {
										return 0;
									}
									
									public Integer getEnd() {
										return grid.getModel().getSize();
									}
								};
							} else if ("groupingInfo".equals(name)) {
								return groupingInfo;
							} else {
								return null;
							}
						}
					}, null);
				if (items.length != 1)
					throw new UiException("The model template must have exactly one row, not "+items.length);

				final Row nr = (Row)items[0];

				//sync open state
				if (nr instanceof Group && row instanceof Group) {
					((Group)nr).setOpen(((Group)row).isOpen());
				}
				
				if (nr.getValue() == null) //template might set it
					nr.setValue(data);
				row.setAttribute("org.zkoss.zul.model.renderAs", nr);
					//indicate a new row is created to replace the existent one
				row.detach();
			}
		}
	};
	private static Template getTemplate(Grid grid, Rows rows, String name) {
		final Template tm = grid.getTemplate(name);
		return tm != null ? tm: rows != null ? rows.getTemplate(name): null;
			// Also allow model's template to be declared in Rows
	}
	
	public void syncModel(int offset, int limit) {
		int min = offset;
		int max = offset + limit - 1;

		final ListModel<Object> model = _grid.getModel();
		Rows rows = _grid.getRows(); 
		final int newsz = model.getSize();
		final int oldsz = rows != null ? rows.getChildren().size(): 0;
		final Paginal pgi = _grid.getPaginal();
		final boolean inPaging = inPagingMold();
		final boolean shallInvalidated = //Bug 3147518: avoid memory leak
			(min < 0 || min == 0) && (max < 0 || max >= newsz || max >= oldsz);

		int newcnt = newsz - oldsz;
		int atg = pgi != null ? _grid.getActivePage(): 0;
		RowRenderer<?> renderer = null;
		Component next = null;		
		if (oldsz > 0) {
			if (min < 0) min = 0;
			else if (min > oldsz - 1) min = oldsz - 1;
			if (max < 0) max = oldsz - 1;
			else if (max > oldsz - 1) max = oldsz - 1;
			if (min > max) {
				int t = min; min = max; max = t;
			}

			int cnt = max - min + 1; //# of affected
			if (rows != null) {
				if (model instanceof GroupsListModel) {
				//detach all from end to front since groupfoot
				//must be detached before group
					newcnt += cnt; //add affected later
					if ((shallInvalidated || newcnt > INVALIDATE_THRESHOLD)
					&& !inPaging)
						rows.invalidate();
					//Invalidate rows to improve the performance see above
	
					Component comp = rows.getChildren().get(max);
					next = comp.getNextSibling();
					while (--cnt >= 0) {
						Component p = comp.getPreviousSibling();
						comp.detach();
						comp = p;
					}
				} else { //ListModel<Object>
					int addcnt = 0;
					Component row = rows.getChildren().get(min);
					while (--cnt >= 0) {
						next = row.getNextSibling();
	
						if (cnt < -newcnt) { //if shrink, -newcnt > 0
							row.detach(); //remove extra
						} else if (((LoadStatus)((Row)row).getExtraCtrl()).isLoaded()) {
							if (renderer == null)
								renderer = (RowRenderer<?>)getRealRenderer();
							row.detach(); //always detach
							rows.insertBefore(newUnloadedItem(renderer, min), next);
							++addcnt;
						}
						++min;
						row = next;
					}
	
					if ((shallInvalidated || addcnt > INVALIDATE_THRESHOLD || addcnt + newcnt > INVALIDATE_THRESHOLD)
					&& !inPaging)
						rows.invalidate();
						//Invalidate rows to improve the performance see above
				}
			}
		} else {
			min = 0;

			//auto create but it means <grid model="xx"><rows/>... will fail
			if (rows == null) {
				rows = new Rows(); 
				rows.setParent(_grid);
			}
		}

		for (; --newcnt >= 0; ++min) {
			if (renderer == null)
				renderer = (RowRenderer<?>) getRealRenderer();
			rows.insertBefore(newUnloadedItem(renderer, min), next);
		}
		
		if (pgi != null) {
			if (atg >= pgi.getPageCount())
				atg = pgi.getPageCount() - 1;
			pgi.setActivePage(atg);
			if (pgi.getTotalSize() != newsz)
				pgi.setTotalSize(newsz); //Bug ZK-1888 - Grid in paging mold doesn't change pages count
		}
	}

	protected boolean inPagingMold() {
		return "paging".equals(_grid.getMold());
	}
	
	public void updateModelInfo() {
		// do nothing
	}
	
	public void setLoadAll(boolean b) {
		//do nothing
	}
	
	//--Cropper--//
	public boolean isCropper() {
		return _grid != null &&
				inPagingMold()
				&& _grid.getPageSize() <= getTotalSize();
				//Single page is considered as not a cropper.
				//isCropper is called after a component is removed, so
				//we have to test >= rather than >
	}
	
	public Set<? extends Component> getAvailableAtClient() {
		if (!isCropper())
			return null;
		
		final Paginal pgi = _grid.getPaginal();
		int pgsz = pgi.getPageSize();
		int ofs = pgi.getActivePage() * pgsz;
		return getAvailableAtClient(ofs, pgsz);
	}
	
	protected Set<? extends Component> getAvailableAtClient(int offset, int limit) {
		final Set<Component> avail = new LinkedHashSet<Component>(32);
		final Rows rows = _grid.getRows();
		Row row = (Row) rows.getFirstChild();
		while(row != null) {
			if (limit == 0) break;
			if (row.isVisible()) {
				if (--offset < 0) {
					--limit;
					avail.add(row);
				}
			}
			if (row instanceof Group) {
				final Group g = (Group) row;
				if (!g.isOpen()) {
					for (int j = 0, len = g.getItemCount(); j < len && row != null; j++)
						row = (Row) row.getNextSibling();
				}
			}
			if (row != null)
				row = (Row) row.getNextSibling();
		}
		return avail;
	}

	public Component getCropOwner() {
		return _grid;
	}
}
