/******************************************************************************
 *  Product: Posterita Web-Based POS and Adempiere Plugin                     *
 *  Copyright (C) 2008  Posterita Ltd                                         *
 *  This file is part of POSterita                                            *
 *                                                                            *
 *  POSterita is free software; you can redistribute it and/or modify         *
 *  it under the terms of the GNU General Public License as published by      *
 *  the Free Software Foundation; either version 2 of the License, or         *
 *  (at your option) any later version.                                       *
 *                                                                            *
 *  This program is distributed in the hope that it will be useful,           *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of            *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
 *  GNU General Public License for more details.                              *
 *                                                                            *
 *  You should have received a copy of the GNU General Public License along   *
 *  with this program; if not, write to the Free Software Foundation, Inc.,   *
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * @author Ashley G Ramdass
 *
 */
public class MPOSTerminal extends X_U_POSTerminal
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 6972567212871993024L;
    
    /**
     * @param ctx Context
     * @param rs Result Set
     * @param trxName Transaction
     */
    public MPOSTerminal(Properties ctx, ResultSet rs, String trxName)
    {
        super(ctx, rs, trxName);
    }

    /**
     * @param ctx
     * @param U_POSTerminal_ID
     * @param trxName
     */
    public MPOSTerminal(Properties ctx, int U_POSTerminal_ID, String trxName)
    {
        super(ctx, U_POSTerminal_ID, trxName);
    }
    
    /**
	 * 
	 * @param copy
	 */
	public MPOSTerminal(MPOSTerminal copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPOSTerminal(Properties ctx, MPOSTerminal copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPOSTerminal(Properties ctx, MPOSTerminal copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
     * @param U_POSTerminal_ID Terminal ID
     * @return Terminal
     */
    public static MPOSTerminal get(int U_POSTerminal_ID)
    {
    	return get(Env.getCtx(), U_POSTerminal_ID);
    }
    
    /**
     * @param ctx Context
     * @param U_POSTerminal_ID Terminal ID
     * @return Terminal
     */
    public static MPOSTerminal get(Properties ctx, int U_POSTerminal_ID)
    {
        MPOSTerminal retValue = new MPOSTerminal (ctx, U_POSTerminal_ID, (String)null);
            
        if (retValue.get_ID() != U_POSTerminal_ID)
        {
            return null;
        }
        checkLock(retValue);
        return retValue;
    }
    
    protected void loadComplete(boolean success)
    {
        if (success)
        {
            checkLock(this);
        }
    }
    
    public static void checkLock(MPOSTerminal terminal)
    {
        if (terminal.isLocked())
        {
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            if (terminal.getUnlockingTime() != null && currentTime.after(terminal.getUnlockingTime()))
            {
                terminal.setLocked(false);
            }
            
            if (terminal.getLastLockTime() != null && terminal.getLockTime() > 0)
            {
                long timeToUnlock = terminal.getLastLockTime().getTime() + (terminal.getLockTime() * 60 * 1000);
                if (currentTime.after(new Timestamp(timeToUnlock)))
                {
                    terminal.setLocked(false);
                }
            }
            terminal.saveEx();
        }
    }

    /**
     * @see org.compiere.model.PO#beforeSave(boolean)
     */
    protected boolean beforeSave(boolean newRecord)
    {
        if (is_ValueChanged(COLUMNNAME_Locked) && isLocked())
        {
            setLastLockTime(new Timestamp(System.currentTimeMillis()));
        }
        
        return true;
    }    
}
