/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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
package org.compiere.grid;

import java.util.Vector;
import java.util.logging.Level;

import javax.swing.table.DefaultTableModel;

import org.compiere.apps.AEnv;
import org.compiere.model.GridTab;
import org.compiere.model.MPackage;
import org.compiere.model.MPackageMPS;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 * 
 * @author Elaine
 *
 */
public class VCreateFromPackageShipmentUI extends CreateFromPackageShipment
{
	private VCreateFromDialog dialog;
	
	public VCreateFromPackageShipmentUI(GridTab mTab) 
	{
		super(mTab);
		if (log.isLoggable(Level.INFO)) log.info(mTab.toString());
		
		dialog = new VCreateFromDialog(this, getGridTab().getWindowNo(), true);
		
		p_WindowNo = getGridTab().getWindowNo();

		try
		{
			if (!dynInit())
				return;

			setInitOK(true);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
			setInitOK(false);
		}
		AEnv.positionCenterWindow(AEnv.getWindow(p_WindowNo), dialog);
	}
	
	/** Window No               */
	private int p_WindowNo;

	/**	Logger			*/
	private CLogger log = CLogger.getCLogger(getClass());
	
	public boolean dynInit() throws Exception
	{
		log.config("");
		
		super.dynInit();
		
		dialog.setTitle(getTitle());

		int M_PackageMPS_ID = (Integer) getGridTab().getValue(MPackageMPS.COLUMNNAME_M_Package_ID);
		MPackageMPS packageMPS = new MPackageMPS(Env.getCtx(), M_PackageMPS_ID, null);
		MPackage mPackage = new MPackage(Env.getCtx(), packageMPS.getM_Package_ID(), null);
		loadTableOIS(getShipmentData(mPackage.getM_InOut_ID()));
		
		return true;
	}
	
	protected void loadTableOIS (Vector<?> data)
	{
		//  Remove previous listeners
		dialog.getMiniTable().getModel().removeTableModelListener(dialog);
		//  Set Model
		DefaultTableModel model = new DefaultTableModel(data, getOISColumnNames());
		model.addTableModelListener(dialog);
		dialog.getMiniTable().setModel(model);
		// 
		
		configureMiniTable(dialog.getMiniTable());
	}
	
	public void showWindow()
	{
		dialog.setVisible(true);
	}
	
	public void closeWindow()
	{
		dialog.dispose();
	}

	@Override
	public Object getWindow() 
	{
		return dialog;
	}
}
