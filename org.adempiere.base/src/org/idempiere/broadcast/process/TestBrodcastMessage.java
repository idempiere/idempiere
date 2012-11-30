/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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
package org.idempiere.broadcast.process;

import org.idempiere.broadcast.BroadcastMsgUtil;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;
/**
 * 
 * @author Vivek
 * @author Deepak Pansheriya
 *
 */
public class TestBrodcastMessage extends SvrProcess
{

    @Override
    protected void prepare()
    {
	// TODO Auto-generated method stub
    }

    @Override
    protected String doIt() throws Exception
    {
		int AD_Session_ID = Env.getContextAsInt(getCtx(), "AD_Session_ID");
		BroadcastMsgUtil.testBroadcastMessage(getRecord_ID(), AD_Session_ID);

		return null;
	}
}
