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
 **********************************************************************/
package org.adempiere.process;

import org.compiere.model.MAttachment;
import org.compiere.model.MShipperLabels;

/**
 * Interface for label printing service
 */
public interface IPrintShippingLabel {

	/**
	 * Print to label printer
	 * @param attachment
	 * @param labelType
	 * @return error message or null
	 * @throws Exception
	 */
	public String printToLabelPrinter(MAttachment attachment, MShipperLabels labelType) throws Exception;
	
	/**
	 * Print image type label
	 * @param attachment
	 * @param labelType
	 * @param title
	 * @return error message or null
	 * @throws Exception
	 */
	public String printImageLabel(MAttachment attachment, MShipperLabels labelType, String title) throws Exception;
	
}