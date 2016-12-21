/**
 * 
 */
package org.adempiere.webui.editor.grid.selection;

/**
 * @author hengsin
 *
 */
public class GridTableRow {

	private int id;
	private Object[] values;

	/**
	 * 
	 */
	public GridTableRow(int id, Object[] values) {
		this.id = id;
		this.values = values;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return id;
	}
	
	public Object[] getValues() {
		return values;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (obj instanceof GridTableRow && obj != null) {
			GridTableRow that = (GridTableRow) obj;
			if (this.id > 0 && that.id == this.id)
				return true;
		}
		return false;
	}	
}
