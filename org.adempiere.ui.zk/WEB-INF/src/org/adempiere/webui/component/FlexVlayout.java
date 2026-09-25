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

	private static final long serialVersionUID = -9179162560282594774L;

	public FlexVlayout() {
		ZkCssHelper.appendStyle(this, "display: flex; flex-direction: column;");
	}
	
	public void setPack(String pack) {
		if (pack == null) return;
	    try {
	        setPack(PackType.valueOf(pack.toUpperCase()));
	    } catch (IllegalArgumentException e) {
	    	throw new IllegalArgumentException("Unknown pack type=" + pack);
	    }
	}

	public void setPack(PackType pack) {
		if (pack == null) return;
	    ZkCssHelper.appendStyle(this, "justify-content: " + pack.getValue() + ";");
	}
	
	public void setAlign(String align) {
		if (align == null) return;
	    try {
	    	setAlign(AlignType.valueOf(align.toUpperCase()));
	    } catch (IllegalArgumentException e) {
	    	throw new IllegalArgumentException("Unknown align type=" + align);
	    }
	}
	
	public void setAlign(AlignType align) {
		if (align == null) return;		
	    ZkCssHelper.appendStyle(this, "align-items: " + align.getValue() + ";");
	}
	
	public enum PackType {
		START("flex-start"), 
	    CENTER("center"), 
	    END("flex-end");

	    private final String value;
	    PackType(String value) { this.value = value; }
	    public String getValue() { return value; }
	}
	
	public enum AlignType {
		START("flex-start"), 
	    CENTER("center"), 
	    END("flex-end");

	    private final String value;
	    AlignType(String value) { this.value = value; }
	    public String getValue() { return value; }
	}
}
