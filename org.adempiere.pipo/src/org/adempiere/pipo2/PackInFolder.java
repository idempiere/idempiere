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
 * - Carlos Ruiz                                                       *
 **********************************************************************/
package org.adempiere.pipo2;

import java.util.logging.Level;

import org.adempiere.plugin.utils.PackInApplicationActivator;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.Util;

/**
 *	Apply all zip files from a folder following the rules and conventions of Automatic Pack In process
 *  This process apply all the pack in files found in a folder recursively - ordered by timestamp.
 *  The filename of the pack in files is important, it must follow the following convention:
 *  [Timestamp]_[ClientValue][_AdditionalInformation].zip
 *  - Timestamp: must be in the format yyyymmddHHMM
 *  - ClientValue: case sensitive and compared against AD_Client.Value to find the tenant where the pack in must be applied
 *  - AdditionalInformation: Any additional information to identify the zip file
 *  NOTE that AD_Client.Value must not contain underscore in order for this process to work.
 *  There is a special case for ClientValue, if the ClientValue is ALL-CLIENTS then the 2pack is intended to be applied in all active non-system clients.
 *  If there is a need to apply initially in a seed tenant then the ClientValue must take the form ALL-CLIENTS-Seed.
 *  For example:
 *  201803151607_ALL-CLIENTS-GardenWorld_Test123.zip
 *	
 *  @author Carlos Ruiz
 */
public class PackInFolder extends SvrProcess {

	/** Folder to apply		*/
	private String p_Folder;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare () {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if (para.getParameter() == null)
				;
			else if (name.equals("Folder"))
				p_Folder = para.getParameterAsString();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (Util.isEmpty(p_Folder, true))
			throw new AdempiereSystemError("@Mandatory@ @Folder@");

		PackInApplicationActivator piaa = new PackInApplicationActivator();
		piaa.setProcessInfo(getProcessInfo());
		piaa.setProcessUI(processUI);
		piaa.automaticPackin(0, p_Folder, false);
		String msg = getProcessInfo().getSummary();

		return msg;
	}	//	doIt

}
