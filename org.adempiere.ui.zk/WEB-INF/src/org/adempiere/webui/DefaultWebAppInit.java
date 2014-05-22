/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 * Contributor(s) : Layda Salas - globalqss                                   *
 *****************************************************************************/
package org.adempiere.webui;

import org.adempiere.base.event.AbstractEventHandler;
import org.adempiere.base.event.EventManager;
import org.adempiere.base.event.IEventTopics;
import org.compiere.model.I_AD_SysConfig;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.compiere.model.X_AD_SysConfig;
import org.osgi.service.event.Event;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.zk.ui.util.WebAppInit;

/**
 * Handle web app init event to sync config store in web config file and database 
 * @author hieplq
 *
 */
public class DefaultWebAppInit implements WebAppInit {

	private static SystemConfigHandler systemConfigChangeHandler;	
	protected WebApp  webApp = null;
	
	/**
	 * Register listen model change
	 */
	@Override
	public void init(WebApp wapp) throws Exception {
		this.webApp = wapp;
		// save app name get from zk.xml to restore when delete app name in system config value
		AdempiereWebUI.APP_NAME = this.webApp.getAppName();
		String appNameConfig = MSysConfig.getValue(MSysConfig.ZK_BROWSER_TITLE);
		if (appNameConfig != null){
			this.webApp.setAppName(appNameConfig);
		}
		
		createStaticListeners ();
		
	}
	
	/**
	 * register handle model change to event manage
	 * Current only init handle System config table
	 */
	private synchronized void createStaticListeners() {
		if (systemConfigChangeHandler == null) {
			systemConfigChangeHandler = new SystemConfigHandler(webApp);
			systemConfigChangeHandler.bindEventManager(EventManager.getInstance());
		}		
	}	
	
	/**
	 * Process modle event of table system config
	 * @author hieplq
	 *
	 */
	static class SystemConfigHandler extends AbstractEventHandler {
		String IS_DELETE = "org.compiere.util.SystemConfigHandler.isDelete";
		protected WebApp webApp = null;
		
		/**
		 * cache WebApp for user late
		 * @param webApp
		 */
		public SystemConfigHandler (WebApp  webApp){
			this.webApp = webApp;			
		}
		
		/**
		 * {@inheritDoc}
		 */
		@Override
		protected void doHandleEvent(Event event) {
			PO po = getPO(event);
			// just track change and delete status. 
			// new, change, rename to = change => isDelete = false
			// delete, rename from = delete => isDelete = true
			int nameColumnIndex = po.get_ColumnIndex(I_AD_SysConfig.COLUMNNAME_Name);
			int valueColumnIndex = po.get_ColumnIndex(I_AD_SysConfig.COLUMNNAME_Value);
			
			boolean isChangeValue = po.is_ValueChanged(valueColumnIndex);
			boolean isChangeName = po.is_ValueChanged(nameColumnIndex);
			
			// delete, rename config (rename have same effect delete)
			if (IEventTopics.PO_BEFORE_DELETE.equals(event.getTopic()) ||
					(IEventTopics.PO_BEFORE_CHANGE.equals(event.getTopic()) && isChangeName)
					){
				beforeDelete (po);
				
				// when change one record = delete a record + new a record 
				if (IEventTopics.PO_BEFORE_CHANGE.equals(event.getTopic()) && isChangeName){
					beforeChange (po);
				}				
				return;
			}
			
			// delete, rename config (rename have same effect delete)
			if (IEventTopics.PO_AFTER_DELETE.equals(event.getTopic()) ||
					(IEventTopics.PO_AFTER_CHANGE.equals(event.getTopic()) && isChangeName)
					){
				afterDelete (po);
				
				// when change one record = delete a record + new a record 
				if (IEventTopics.PO_AFTER_CHANGE.equals(event.getTopic()) && isChangeName){
					afterChange(po);
				}
				return;
			}
			
			// new, change value consider as change. change name is process with above not there
			if (IEventTopics.PO_BEFORE_NEW.equals(event.getTopic()) ||
					(IEventTopics.PO_BEFORE_CHANGE.equals(event.getTopic()) && !isChangeName && isChangeValue)){
				beforeChange (po);
				return;
			}
			
			// new, change value consider as change. change name is process with above not there
			if (IEventTopics.PO_AFTER_NEW.equals(event.getTopic()) ||
					(IEventTopics.PO_AFTER_CHANGE.equals(event.getTopic()) && !isChangeName && isChangeValue)){
				afterChange (po);
				return;
			}									
		}
		
		protected void beforeDelete(PO po) {
			//TODO:save flag to file for case when insert data success but before sync with file config has error crash program
		}
		
		/**
		 * Process when delete a configuration record
		 * @param po
		 */
		protected void afterDelete (PO po){
			if (po instanceof X_AD_SysConfig){												
				// when delete ZK_BROWSER_TITLE, set web config to default value "Idempiere"
				// user old value of name for correct meaning of record delete, change
				if (MSysConfig.ZK_BROWSER_TITLE.equals(getOldValueOfName(po))){					
					webApp.setAppName(AdempiereWebUI.APP_NAME);									
				}
			}
		}
		
		/**
		 * get old value of column name
		 * @param po
		 * @return
		 */
		protected String getOldValueOfName(PO po) {
			int nameColumnIndex = po.get_ColumnIndex(I_AD_SysConfig.COLUMNNAME_Name);
			return po.get_ValueOld(nameColumnIndex).toString();
		}
		
		protected void beforeChange (PO po){
			//TODO:save flag to file for case when insert data success but before sync with file config has error crash program
		}
		
		/**
		 * sync value in web config with new value in db
		 * @param po
		 */
		protected void afterChange (PO po){
			if (po instanceof X_AD_SysConfig){												
				// when change ZK_BROWSER_TITLE, set web config to new value
				if (MSysConfig.ZK_BROWSER_TITLE.equals(((X_AD_SysConfig) po).getName())){
					String configAppname = ((X_AD_SysConfig) po).getValue();
					webApp.setAppName(configAppname);
				}
			}
		}						
		
		@Override
		protected void initialize() {
			registerTableEvent(IEventTopics.PO_AFTER_CHANGE, I_AD_SysConfig.Table_Name);
			registerTableEvent(IEventTopics.PO_AFTER_NEW, I_AD_SysConfig.Table_Name);
			registerTableEvent(IEventTopics.PO_AFTER_DELETE, I_AD_SysConfig.Table_Name);
			
			registerTableEvent(IEventTopics.PO_BEFORE_CHANGE, I_AD_SysConfig.Table_Name);
			registerTableEvent(IEventTopics.PO_BEFORE_DELETE, I_AD_SysConfig.Table_Name);
			registerTableEvent(IEventTopics.PO_BEFORE_NEW, I_AD_SysConfig.Table_Name);
		}		
	}

}
