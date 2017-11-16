/**
 *
 */
package org.adempiere.util;

import java.util.Collection;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;

import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.KeyNamePair;
import org.compiere.util.ValueNamePair;

/**
 * Context (Properties) wrapper to be able to evaluate grid row context
 * @author Teo Sarca, teo.sarca@gmail.com
 */
public class GridRowCtx extends Properties
implements Evaluatee
{
	/**
	 *
	 */
	private static final long serialVersionUID = 8163657930039348267L;

	private final Properties ctx;
	private final GridTab gridTab;
	private final int windowNo;
	private final int row;

	public GridRowCtx(Properties ctx, GridTab tab)
	{
		this(ctx, tab, -1);
	}
	
	public GridRowCtx(Properties ctx, GridTab tab, int row)
	{
		super();
		this.ctx = ctx;
		this.gridTab = tab;
		this.windowNo = tab.getWindowNo();
		this.row = row;
	}

	private String getColumnName(Object key)
	{
		if (! (key instanceof String) )
			return null;
		String windowStr = windowNo+"|";
		String keyStr = (String)key;

		if (!keyStr.startsWith(windowStr))
		{
			return null;
		}
		String columnName = keyStr.substring(windowStr.length()).trim();
		//strip tab no too
		if (columnName.indexOf("|") > 0) {
			columnName = columnName.substring(columnName.indexOf("|")+1);
		}
		return columnName;
	}

	@Override
	public synchronized Object get(Object key)
	{
		String columnName = getColumnName(key);
		if (columnName == null)
		{
			return ctx.get(key);
		}
		GridTable gridTable = gridTab.getTableModel();
		int col = gridTable.findColumn(columnName);
		if (col == -1)
		{
			return ctx.get(key);
		}
		Object value = gridTable.getValueAt(getRow(), col);
		if (value == null)
		{
			value = "";
		}
		else if (value instanceof KeyNamePair)
		{
			value = ((KeyNamePair)value).getKey();
		}
		else if (value instanceof ValueNamePair)
		{
			value = ((ValueNamePair)value).getID();
		}
		else if (value instanceof Boolean)
		{
			value = ((Boolean)value).booleanValue() ? "Y" : "N";
		}
		return value.toString();
	}

	private int getRow() {
		return row >= 0 ? row : gridTab.getCurrentRow();
	}

	@Override
	public synchronized void clear() {
		ctx.clear();
	}

	@Override
	public synchronized Object clone() {
		final GridRowCtx grc;
		grc = new GridRowCtx((Properties)this.ctx.clone(), this.gridTab, this.row);
		return grc;
	}

	@Override
	public synchronized boolean contains(Object value) {
		return this.containsValue(value);
	}

	@Override
	public synchronized boolean containsKey(Object key)
	{
		GridTable gridTable = gridTab.getTableModel();
		String columnName = getColumnName(key);
		if (columnName != null && gridTable.findColumn(columnName) != -1)
			return true;
		return ctx.containsKey(key);
	}

	@Override
	public boolean containsValue(Object value) {
		if (value != null) {
			GridField[] fields = gridTab.getFields();
			for(GridField field : fields) {
				Object fieldValue = gridTab.getValue(getRow(), field.getColumnName());
				if (fieldValue != null && fieldValue.equals(value)) {
					return true;
				}
			}
		}
		return ctx.containsValue(value);
	}

	@Override
	public synchronized Enumeration<Object> elements() {
		Vector<Object> list = new Vector<>(ctx.values());
		GridField[] fields = gridTab.getFields();
		for(GridField field : fields) {
			Object fieldValue = gridTab.getValue(getRow(), field.getColumnName());
			if (fieldValue != null) {
				list.add(fieldValue);
			}
		}
		return list.elements();
	}

	@Override
	public Set<java.util.Map.Entry<Object, Object>> entrySet() {
		Set<java.util.Map.Entry<Object, Object>> set = new HashSet<>(ctx.entrySet());
		GridField[] fields = gridTab.getFields();
		Map<Object, Object> fieldMap = new LinkedHashMap<>();
		for(GridField field : fields) {
			Object fieldValue = gridTab.getValue(getRow(), field.getColumnName());
			fieldMap.put(field.getColumnName(), fieldValue); 
		}
		set.addAll(fieldMap.entrySet());
		return set;
	}

	@Override
	public synchronized boolean isEmpty() {
		return false;
	}

	@Override
	public synchronized Enumeration<Object> keys() {
		Vector<Object> list = new Vector<Object>(ctx.keySet());
		GridField[] fields = gridTab.getFields();
		for(GridField field : fields) {
			list.add(field.getColumnName());
		}
		return list.elements();
	}

	@Override
	public Set<Object> keySet() {
		Set<Object> set = new HashSet<>(ctx.keySet());
		GridField[] fields = gridTab.getFields();
		for(GridField field : fields) {
			set.add(field.getColumnName());
		}
		return set;
	}

	@Override
	public synchronized Object put(Object key, Object value)
	{
		return ctx.put(key, value);
	}

	@Override
	public synchronized void putAll(Map<? extends Object, ? extends Object> t) {
        for (Map.Entry<? extends Object, ? extends Object> e : t.entrySet())
            put(e.getKey(), e.getValue());
	}

	@Override
	public synchronized Object remove(Object key) {
		return ctx.remove(key);
	}

	@Override
	public synchronized int size() {
		return ctx.size() + gridTab.getFieldCount();
	}

	@Override
	public synchronized String toString() {
		StringBuilder builder = new StringBuilder(ctx.toString());
		if (builder.length() > 0) {
			builder.deleteCharAt(builder.length()-1);
			if (builder.length() > 1) {
				builder.append(", ");
			}
		} else {
			builder.append("{");
		}
		GridField[] fields = gridTab.getFields();
		for(int i = 0; i < fields.length; i++) {
			builder.append(fields[i].getColumnName()).append("=");
			Object value = gridTab.getValue(getRow(), fields[i].getColumnName());
			builder.append(value==null ? "" : value.toString());
			if (i == fields.length-1) {
				builder.append("}");
			} else {
				builder.append(", ");
			}
		}
		return builder.toString();
	}

	@Override
	public Collection<Object> values() {
		return ctx.values();
	}

	@Override
	public String getProperty(String key) {
		// I need to override this method, because Properties.getProperty method is calling super.get() instead of get()
		Object oval = get(key);
		return oval == null ? null : oval.toString();
	}

	public String get_ValueAsString(String variableName)
	{
		return Env.getContext (this, windowNo, variableName, true);
	}
}
