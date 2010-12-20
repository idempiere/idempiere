/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package event.test;

import org.adempiere.base.event.AbstractEventHandler;
import org.adempiere.base.event.IEventManager;
import org.adempiere.base.event.IEventTopics;
import org.adempiere.base.event.LoginEventData;
import org.compiere.model.I_C_BP_Group;
import org.compiere.model.I_C_Order;
import org.compiere.model.I_M_Product_Category;
import org.compiere.model.PO;
import org.osgi.service.event.Event;

/**
 *
 * @author hengsin
 *
 */
public class MyEventHandler extends AbstractEventHandler {

	@Override
	protected void doHandleEvent(Event event) {
		if (event.getTopic().equals(IEventTopics.AFTER_LOGIN)) {
			LoginEventData eventData = getEventData(event);
			System.out.println(" topic="+event.getTopic()+" AD_Client_ID="+eventData.getAD_Client_ID()
					+" AD_Org_ID="+eventData.getAD_Org_ID()+" AD_Role_ID="+eventData.getAD_Role_ID()
					+" AD_User_ID="+eventData.getAD_User_ID());
		} else if (event.getTopic().equals(IEventTopics.PO_AFTER_NEW)) {
			PO po = getPO(event);
			System.out.println(" topic="+event.getTopic()+" po="+po);
		} else if (event.getTopic().equals(IEventTopics.PO_BEFORE_NEW)) {
			PO po = getPO(event);
			System.out.println(" topic="+event.getTopic()+" po="+po);
			if (po.get_TableName().equals(I_C_BP_Group.Table_Name))
				throw new RuntimeException("No new business partner group for now.");
		}

	}

	@Override
	protected void initialize() {
		registerEvent(IEventTopics.AFTER_LOGIN);
		registerTableEvent(IEventTopics.PO_AFTER_NEW, I_C_Order.Table_Name);
		registerTableEvent(IEventTopics.PO_BEFORE_NEW, I_C_BP_Group.Table_Name);
		registerTableEvent(IEventTopics.PO_BEFORE_NEW, I_M_Product_Category.Table_Name);
	}
}
