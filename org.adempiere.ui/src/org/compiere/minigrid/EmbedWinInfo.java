/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.compiere.minigrid;

import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;

public class EmbedWinInfo {
	private MInfoWindow infowin;
	private IMiniTable infoTbl;
	private String infoSql;
	private String linkColumnSql;
	private MInfoColumn linkInfoColumn;
	private String linkColumnName;
	private int parentLinkColumnID;

	public EmbedWinInfo(MInfoWindow iw, IMiniTable mt, String isql, String linkName, MInfoColumn linkColumn, int parentLinkColumnID) {
		this.parentLinkColumnID = parentLinkColumnID;
		infowin=iw;
		infoTbl=mt;
		infoSql=isql;
		linkColumnSql=linkName;
		linkInfoColumn = linkColumn;
		linkColumnName = linkColumn.getName();
	}

	public MInfoWindow getInfowin() {
		return infowin;
	}

	public IMiniTable getInfoTbl() {
		return infoTbl;
	}


	public String getInfoSql() {
		return infoSql;
	}

	public MInfoColumn getLinkColumn() {
		return linkInfoColumn;
	}

	public String getLinkColumnSql() {
		return linkColumnSql;
	}

	public String getLinkColumnName() {
		return linkColumnName;
	}
	
	public int getParentLinkColumnID() {
		return parentLinkColumnID;
	}
	
	public Class<?> getTypeDataOfLink (){
		if (linkInfoColumn.getColumnName().lastIndexOf("_ID") > 0){
			return int.class;
		}else{
			return String.class;
		}
	}

}
