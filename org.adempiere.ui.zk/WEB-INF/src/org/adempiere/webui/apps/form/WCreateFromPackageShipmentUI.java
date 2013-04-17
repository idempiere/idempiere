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
package org.adempiere.webui.apps.form;

import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ListModelTable;
import org.compiere.grid.CreateFromPackageShipment;
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
public class WCreateFromPackageShipmentUI extends CreateFromPackageShipment
{
	private WCreateFromWindow window;

	public WCreateFromPackageShipmentUI(GridTab mTab) 
	{
		super(mTab);
		log.info(mTab.toString());

		window = new WCreateFromWindow(this, getGridTab().getWindowNo());

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
		AEnv.showWindow(window);
	}

	/**	Logger			*/
	private CLogger log = CLogger.getCLogger(getClass());
	
	public boolean dynInit() throws Exception
	{
		log.config("");
		
		super.dynInit();
		
		window.setTitle(getTitle());

		int M_PackageMPS_ID = (Integer) getGridTab().getValue(MPackageMPS.COLUMNNAME_M_PackageMPS_ID);
		MPackageMPS packageMPS = new MPackageMPS(Env.getCtx(), M_PackageMPS_ID, null);
		MPackage mPackage = new MPackage(Env.getCtx(), packageMPS.getM_Package_ID(), null);
		loadTableOIS(getShipmentData(mPackage.getM_InOut_ID()));
		
		return true;
	}
	
	protected void loadTableOIS (Vector<?> data)
	{
		window.getWListbox().clear();
		
		//  Remove previous listeners
		window.getWListbox().getModel().removeTableModelListener(window);
		//  Set Model
		ListModelTable model = new ListModelTable(data);
		model.addTableModelListener(window);
		window.getWListbox().setData(model, getOISColumnNames());
		//
		
		configureMiniTable(window.getWListbox());
	}
	
	public void showWindow()
	{
		window.setVisible(true);
	}
	
	public void closeWindow()
	{
		window.dispose();
	}

	@Override
	public Object getWindow() 
	{
		return window;
	}

}
