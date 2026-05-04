/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Elaine Tan                         							   *
 **********************************************************************/
package org.adempiere.webui.component;

public class FlexVlayout extends org.zkoss.zul.Vlayout {

	private static final long serialVersionUID = 4258420492463096625L;

	public FlexVlayout() {
		ZkCssHelper.appendStyle(this, "display: flex; flex-direction: column;");
	}
	
	public void setPack(PackType pack) {
		switch (pack) {
	        case START:
	        	ZkCssHelper.appendStyle(this, "justify-content: flex-start;");
	            break;
	        case CENTER:
	        	ZkCssHelper.appendStyle(this, "justify-content: center;");
	            break;
	        case END:
	        	ZkCssHelper.appendStyle(this, "justify-content: flex-end;");
	            break;
	    }
	}
	
	public void setAlign(AlignType pack) {
		switch (pack) {
	        case START:
	        	ZkCssHelper.appendStyle(this, "align-items: flex-start;");
	            break;
	        case CENTER:
	        	ZkCssHelper.appendStyle(this, "align-items: center;");
	            break;
	        case END:
	        	ZkCssHelper.appendStyle(this, "align-items: flex-end;");
	            break;
	    }
	}
	
	public enum PackType {
	    START("start"), 
	    CENTER("center"), 
	    END("end");

	    private final String value;
	    PackType(String value) { this.value = value; }
	    public String getValue() { return value; }
	}
	
	public enum AlignType {
	    START("start"), 
	    CENTER("center"), 
	    END("end");

	    private final String value;
	    AlignType(String value) { this.value = value; }
	    public String getValue() { return value; }
	}
}
