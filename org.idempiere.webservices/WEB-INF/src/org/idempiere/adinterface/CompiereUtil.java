/******************************************************************************
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
package org.idempiere.adinterface;


import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.util.CLogger;


public class CompiereUtil {

	private static CLogger			log = CLogger.getCLogger(CompiereUtil.class);	
	private static boolean          s_initOK    = false;

	/**
	 * @return startup idempiere environment if needed
	 */
	public static boolean initWeb()
	{
		if (s_initOK)
		{
			return true;
		}
		
		try
		{
			s_initOK = Adempiere.startup(false);
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "startup", ex); 
		}
		if (!s_initOK)
			return false;

		return s_initOK;
	}
}
