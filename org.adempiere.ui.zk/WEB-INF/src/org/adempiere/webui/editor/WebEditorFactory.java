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

package org.adempiere.webui.editor;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.webui.factory.IEditorFactory;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.util.CCache;
import org.osgi.framework.Constants;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 12, 2007
 * @version $Revision: 0.10 $
 *
 * @author Low Heng Sin
 * @date 	July 14 2008
 */
public class WebEditorFactory
{
    /**
     * 
     * @param gridField
     * @param tableEditor
     * @return WEditor for GridField
     */
    public static WEditor getEditor(GridField gridField, boolean tableEditor)
    {
    	return getEditor(gridField, tableEditor, null);
    }
    
    /**
     * 
     * @param gridField
     * @param tableEditor
     * @param editorConfiguration
     * @return {@link WEditor}
     */
    public static WEditor getEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
    	return getEditor(gridField.getGridTab(), gridField, tableEditor, editorConfiguration);
    }

    private static final CCache<Long, IServiceReferenceHolder<IEditorFactory>> s_editorFactoryCache = new CCache<>(null, "IEditorFactory", 10, false);
    
    /**
     * 
     * @param gridTab
     * @param gridField
     * @param tableEditor
     * @return {@link WEditor}
     */
    public static WEditor getEditor(GridTab gridTab, GridField gridField, boolean tableEditor)
    {
    	return getEditor(gridTab, gridField, tableEditor, null);
    }
    
    /**
     * 
     * @param gridTab
     * @param gridField
     * @param tableEditor
     * @param editorConfiguration
     * @return {@link WEditor}
     */
    public static WEditor getEditor(GridTab gridTab, GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
    	List<Long> visitedIds = new ArrayList<Long>();
		if (!s_editorFactoryCache.isEmpty()) {
			Long[] keys = s_editorFactoryCache.keySet().toArray(new Long[0]);
			for (Long key : keys) {
				IServiceReferenceHolder<IEditorFactory> serviceReference = s_editorFactoryCache.get(key);
				if (serviceReference != null) {
					IEditorFactory service = serviceReference.getService();
					if (service != null) {
						visitedIds.add(key);
						WEditor editor = service.getEditor(gridTab, gridField, tableEditor, editorConfiguration);
			        	if (editor != null)
			        		return editor;
					} else {
						s_editorFactoryCache.remove(key);
					}
				}
			}
		}

        WEditor editor = null;
        List<IServiceReferenceHolder<IEditorFactory>> serviceReferences = Service.locator().list(IEditorFactory.class).getServiceReferences();
        for(IServiceReferenceHolder<IEditorFactory> serviceReference : serviceReferences)
        {
        	Long serviceId = (Long) serviceReference.getServiceReference().getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
        	IEditorFactory service = serviceReference.getService();
        	if (service != null)
        	{
        		s_editorFactoryCache.put(serviceId, serviceReference);
	        	editor = service.getEditor(gridTab, gridField, tableEditor, editorConfiguration);
	        	if (editor != null)
	        		break;
        	}
        }
        return editor;
    }
}
