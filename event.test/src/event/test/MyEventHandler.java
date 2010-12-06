package event.test;

import org.adempiere.base.event.IEventManager;
import org.adempiere.base.event.IEventTopics;
import org.adempiere.base.event.LoginEventData;
import org.compiere.model.PO;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;

/**
 *
 * @author hengsin
 *
 */
public class MyEventHandler implements EventHandler {

	@Override
	public void handleEvent(Event event) {
		if (event.getTopic().equals(IEventTopics.AFTER_LOGIN)) {
			LoginEventData eventData = (LoginEventData) event.getProperty(IEventManager.EVENT_DATA);
			System.out.println(" topic="+event.getTopic()+" AD_Client_ID="+eventData.getAD_Client_ID()
					+" AD_Org_ID="+eventData.getAD_Org_ID()+" AD_Role_ID="+eventData.getAD_Role_ID()
					+" AD_User_ID="+eventData.getAD_User_ID());
		} else if (event.getTopic().equals(IEventTopics.PO_AFTER_NEW)) {
			PO po = (PO) event.getProperty(IEventManager.EVENT_DATA);
			System.out.println(" topic="+event.getTopic()+" po="+po);
		}

	}

	public void bindEventManager(IEventManager eventManager) {
		eventManager.register(IEventTopics.AFTER_LOGIN, this);
		eventManager.register(IEventTopics.PO_AFTER_NEW, "(tableName=C_Order)", this);
	}

	public void unbindEventManager(IEventManager eventManager) {
		eventManager.unregister(this);
	}
}
