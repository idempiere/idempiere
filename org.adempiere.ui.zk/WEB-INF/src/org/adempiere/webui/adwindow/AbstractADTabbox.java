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

package org.adempiere.webui.adwindow;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.adempiere.webui.panel.CustomizeGridViewPanel;
import org.adempiere.webui.part.AbstractUIPart;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author  <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public abstract class AbstractADTabbox extends AbstractUIPart implements IADTabbox
{
    /** Logger                  */
    private static final CLogger  log = CLogger.getCLogger (AbstractADTabbox.class);
    /** List of dependent Variables     */
    private ArrayList<String>   m_dependents = new ArrayList<String>();
    
    /** Tabs associated to this tab box */
    protected List<IADTabpanel> tabPanelList = new ArrayList<IADTabpanel>();
	protected AbstractADWindowContent adWindowPanel;
    
    public AbstractADTabbox()
    {
    }
    
    /**
     *  Add Tab
     *  @param gTab grid tab model
     *  @param tabPanel
     */
    public void addTab(GridTab gTab, IADTabpanel tabPanel)
    {
    	tabPanelList.add(tabPanel);
        ArrayList<String>  dependents = gTab.getDependentOn();
        for (int i = 0; i < dependents.size(); i++)
        {
            String name = dependents.get(i);
            if (!m_dependents.contains(name))
            {
                m_dependents.add(name);
            }
        }
        
        doAddTab(gTab, tabPanel);                
    }//  addTab
    
    protected abstract void doAddTab(GridTab tab, IADTabpanel tabPanel);

	/**
     * @param index of tab panel
     * @return
     */
    public boolean isEnabledAt(int index) 
    {
    	return true;
    }// isEnabledAt

    private boolean isDisplay(IADTabpanel newTab)
    {
        String logic = newTab.getDisplayLogic();
        if (logic != null && logic.length() > 0)
        {
            boolean display = Evaluator.evaluateLogic(newTab, logic);
            if (!display)
            {
                log.info("Not displayed - " + logic);
                return false;
            }
        }
        return true;
    }
    
    /**
     * 
     * @param oldIndex
     * @param newIndex
     * @return
     */
    public boolean updateSelectedIndex(int oldIndex, int newIndex)
    {
        IADTabpanel newTab = tabPanelList.get(newIndex);
        
        if (!isDisplay(newTab))
        {
            return false;
        }
        
        boolean canJump = true;

        if (newIndex != oldIndex)
        {
            canJump = canNavigateTo(oldIndex, newIndex, true);
            if (canJump) 
            {
            	prepareContext(newIndex, newTab);
	            doTabSelectionChanged(oldIndex, newIndex);
            }
        }
        
        return canJump;
    }
    
    private void prepareContext(int newIndex, IADTabpanel newTab) {
		//update context
		if (newTab != null)
		{
			List<Integer> parents = new ArrayList<Integer>();
			//get parent list, always include first tab (0)
			if (newIndex > 0)
			{
				int currentLevel = newTab.getTabLevel();
				for (int i = newIndex - 1; i > 0; i--)
				{
					IADTabpanel adtab = tabPanelList.get(i);
					if (adtab.getGridTab() == null) continue;
					if (adtab instanceof CustomizeGridViewPanel) continue;
					if (adtab.getTabLevel() < currentLevel)
					{
						parents.add(i);
						currentLevel = adtab.getTabLevel();
					}
				}
				parents.add(0);
				Collections.reverse(parents);
			}
			else
			{
				parents.add(0);
			}

			//clear context
			for (int i = 0; i < tabPanelList.size(); i++)
			{
				IADTabpanel adtab = tabPanelList.get(i);
				if (adtab.getGridTab() == null) continue;
				if (adtab instanceof CustomizeGridViewPanel) continue;
				GridField[] fields = adtab.getGridTab().getFields();
				for (GridField gf : fields)
				{
					Env.setContext(Env.getCtx(), gf.getWindowNo(),  gf.getColumnName(), "");
				}
			}

			//add parent value to context
			for(int i : parents)
			{
				IADTabpanel adtab = tabPanelList.get(i);

				GridField[] fields = adtab.getGridTab().getFields();
				for (GridField gf : fields)
				{
					gf.updateContext();
				}
			}
		}
	}

    protected abstract void doTabSelectionChanged(int oldIndex, int newIndex);

    public boolean isDisplay(int index) {
    	if (index >= tabPanelList.size())
    		return false;
    	
    	IADTabpanel newTab = tabPanelList.get(index);
    	if (newTab instanceof ADTabpanel) 
    	{
	    	if (!isDisplay(newTab))
	        {
	            return false;
	        }
    	}
    	return true;
    }

	public boolean canNavigateTo(int fromIndex, int toIndex) {
		return canNavigateTo(fromIndex, toIndex, false);
	}

	public boolean canNavigateTo(int fromIndex, int toIndex, boolean checkRecordID) {
    	IADTabpanel newTab = tabPanelList.get(toIndex);
    	if (newTab instanceof ADTabpanel) 
    	{
	    	if (!isDisplay(newTab))
	        {
	            return false;
	        }
    	}
        
        boolean canJump = true;

        if (toIndex != fromIndex)
        {
            IADTabpanel oldTabpanel = fromIndex >= 0 ? tabPanelList.get(fromIndex) : null;
            if (oldTabpanel != null)
            {
                if (newTab.getTabLevel() > oldTabpanel.getTabLevel())
                {
                    int currentLevel = newTab.getTabLevel();
                    for (int i = toIndex - 1; i >= 0; i--)
                    {
                        IADTabpanel tabPanel = tabPanelList.get(i);
                        if (tabPanel.getTabLevel() < currentLevel)
                        {
                            if (!tabPanel.isCurrent())
                            {
                                canJump = false;
                                break;
                            }
                            currentLevel = tabPanel.getTabLevel();
                        }
                    }
                    if (canJump && checkRecordID ) {
                    	int zeroValid = (MTable.isZeroIDTable(oldTabpanel.getTableName()) ? 1 : 0);
                        if (oldTabpanel.getRecord_ID() + zeroValid <= 0)
                           	canJump = false;
    					// IDEMPIERE-651 Allow navigating to a detail when parent doesn't have ID
    					if (! canJump && Util.isEmpty(oldTabpanel.getGridTab().getKeyColumnName()))
    						canJump = true;
                    }
                }
            }
        }        
        return canJump;
    }
    
    /**
     * 
     * @return full path
     */
    public String getPath() {
    	StringBuilder path = new StringBuilder();
    	int s = this.getSelectedIndex();
    	if (s <= 0 ) s = 0;
    	IADTabpanel p = tabPanelList.get(s);
    	for (int i = 0; i <= s; i++) {
    		String n = null;
    		if (i == s)
    			n = p.getTitle();
    		else {
    			IADTabpanel t = tabPanelList.get(i);
    			if (t.getTabLevel() < p.getTabLevel())
    				n = t.getTitle();
    		}
    		if (n != null) {
    			if (path.length() > 0) {
    				path.append(" > ");
    			}
    			path.append(n);
    		}
    	}
    	
    	return path.toString();
    }
    
    /**
     *  Evaluate Tab Logic
     *  @param e event
     */
    public void evaluate (DataStatusEvent e)
    {
    	
        boolean process = (e == null);
        String columnName = null;
        if (!process)
        {
            columnName = e.getColumnName();
            if (columnName != null)
                process = m_dependents.contains(columnName);
            else
                process = true;
        }
            
        if (process)
        {
        	updateTabState();
        }
        
    } //  evaluate

    protected abstract void updateTabState();

	/**
     * @return the number of tab panels present
     */
    public int getTabCount()
    {
        return tabPanelList.size();
    }
    
    public IADTabpanel getADTabpanel(int index)
    {
        try
        {
            IADTabpanel tabPanel = tabPanelList.get(index);
            return tabPanel;
        }
        catch (Exception ex)
        {
            throw new IndexOutOfBoundsException(ex.getMessage());
        }
    }
    
    public void setSelectedIndex(int newIndex) {
    	int oldIndex = getSelectedIndex();
    	updateSelectedIndex(oldIndex, newIndex);
    }

	public void setADWindowPanel(AbstractADWindowContent abstractADWindowPanel) {
		this.adWindowPanel = abstractADWindowPanel;
	}
}
