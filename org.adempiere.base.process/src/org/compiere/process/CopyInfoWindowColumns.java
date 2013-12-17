/**********************************************************************
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
* - Hideaki Hagiwara                                                  *
**********************************************************************/

package org.compiere.process;

import java.util.logging.Level;

import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.PO;
import org.compiere.util.AdempiereSystemError;

/**
 *	Copy Info Window Columns from other Info Window
 *
 *  @author Hideaki Hagiwara
 *  @version $Id: CopyInfoWindowColumns v 1.0 2013/12/4
 */
public class CopyInfoWindowColumns extends SvrProcess
{
	/** Target Info Window		*/
	private int		p_target_AD_InfoWindow_ID = 0;
	/** Source Info Window		*/
	private int		p_source_AD_InfoWindow_ID= 0;

	/** Column Count	*/
	private int 	m_count = 0;


	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_InfoWindow_ID"))
				p_source_AD_InfoWindow_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_target_AD_InfoWindow_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (p_target_AD_InfoWindow_ID == 0)
			throw new AdempiereSystemError("@NotFound@ @AD_InfoWindow_ID@ " + p_target_AD_InfoWindow_ID);
		if (p_source_AD_InfoWindow_ID == 0)
			throw new AdempiereSystemError("@NotFound@ @AD_InfoWindow_ID@ " + p_source_AD_InfoWindow_ID);
		if (log.isLoggable(Level.INFO)) log.info("Source AD_InfoWindow_ID=" + p_source_AD_InfoWindow_ID
				+ ", Target AD_InfoWindow_ID=" + p_target_AD_InfoWindow_ID);

		MInfoWindow targetInfoWindow = new MInfoWindow(getCtx(), p_target_AD_InfoWindow_ID, get_TrxName());
		MInfoColumn[] targetColumns = targetInfoWindow.getInfoColumns();
		if (targetColumns.length > 0) //Target Info Window must not have columns
			throw new AdempiereSystemError("Target info window must not have columns");

		MInfoWindow sourceInfoWindow = new MInfoWindow(getCtx(), p_source_AD_InfoWindow_ID, get_TrxName());
		MInfoColumn[] sourceColumns = sourceInfoWindow.getInfoColumns();

		for (int i = 0; i < sourceColumns.length; i++)
		{
			MInfoColumn colTarget = new MInfoColumn(getCtx(),0, get_TrxName());
			PO.copyValues(sourceColumns[i], colTarget);
			colTarget.setAD_InfoWindow_ID (targetInfoWindow.getAD_InfoWindow_ID());
			colTarget.setAD_Org_ID(targetInfoWindow.getAD_Org_ID());
			colTarget.setEntityType(targetInfoWindow.getEntityType());
			colTarget.setIsActive(sourceColumns[i].isActive());
			colTarget.saveEx(get_TrxName());

			m_count++;
		}

		//
		return "#" + m_count;
	}	//	doIt


}	//	CopyInfoWindowColumns
