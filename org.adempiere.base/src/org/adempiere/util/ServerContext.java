/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.util;

import java.io.Serializable;
import java.util.Properties;

/**
 * Inheritable thread local server context
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public final class ServerContext implements Serializable
{
    /**
	 * generated serial version Id
	 */
	private static final long serialVersionUID = -8274580404204046413L;

	private ServerContext()
    {
    }

    private static InheritableThreadLocal<Properties> context = new InheritableThreadLocal<Properties>() {
        protected Properties initialValue()
        {
        	Properties ctx = new Properties();
            return ctx;
        }
    };

    /**
     * Get server context for current thread
     * @return Properties
     */
    public static Properties getCurrentInstance()
    {
        return (Properties)context.get();
    }

    /**
     * dispose server context for current thread
     */
    public static void dispose()
    {
    	context.remove();
    }

    /**
     * Set server context for current thread
     * @param ctx
     */
    public static void setCurrentInstance(Properties ctx)
    {
        context.set(ctx);
    }
}
