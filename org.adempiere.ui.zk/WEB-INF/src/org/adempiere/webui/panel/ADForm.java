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

package org.adempiere.webui.panel;

import java.util.logging.Level;

import org.adempiere.webui.Extensions;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.GridTab;
import org.compiere.model.MForm;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * Adempiere Web UI custom form.
 * The form is abstract, so specific types of custom form must be implemented
 *
 * @author Andrew Kimball
 */
public abstract class ADForm extends Window implements EventListener<Event>
{
	/**
	 *
	 */
	private static final long serialVersionUID = -5183711788893823434L;
	/** The class' logging enabler */
    protected static final CLogger logger;
    
    static
    {
        logger = CLogger.getCLogger(ADForm.class);
    }

    /** The unique identifier of the form type */
    private int m_adFormId;
    /** The identifying number of the window in which the form is housed */
    protected int m_WindowNo;


	private String m_name;


	private ProcessInfo m_pi;

	private IFormController m_customForm;

    /**
     * Constructor
     *
     * @param ctx		the context into which the form is being placed
     * @param adFormId	the Adempiere form identifier
     */
    protected ADForm()
    {
         m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);

         this.setWidth("100%");
         this.setHeight("95%");
         this.setStyle("position:absolute");
         this.setContentSclass("adform-content");
    }

    public int getWindowNo()
    {
    	return m_WindowNo;
    }

    protected int getAdFormId()
    {
    	return m_adFormId;
    }

    /**
     * Initialise the form
     *
     * @param adFormId	the Adempiere form identifier
     * @param name		the name of the Adempiere form
     */

    protected void init(int adFormId, String name)
    {
        if(adFormId <= 0)
        {
	           throw new IllegalArgumentException("Form Id is invalid");
	   	}

        m_adFormId = adFormId;
        //window title
        setTitle(name);
        m_name = name;

        initForm();
        
        addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
    }

    abstract protected void initForm();

	/**
     * @return form name
     */
    public String getFormName() {
    	return m_name;
    }

	/**
	 * Create a new form corresponding to the specified identifier
	 *
	 * @param adFormID		The unique identifier for the form type
	 * @return The created form
	 */
	public static ADForm openForm (int adFormID)
	{
		return openForm(adFormID, null);
	}
	
	public static ADForm openForm (int adFormID, GridTab gridTab)
	{
		ADForm form;
		MForm mform = new MForm(Env.getCtx(), adFormID, null);
    	String formName = mform.getClassname();
    	String name = mform.get_Translation(MForm.COLUMNNAME_Name);

    	if (mform.get_ID() == 0 || formName == null)
    	{
			throw new ApplicationException("There is no form associated with the specified selection");
    	}
    	else
    	{
    		if (logger.isLoggable(Level.INFO)) logger.info("AD_Form_ID=" + adFormID + " - Class=" + formName);

    		form = Extensions.getForm(formName);
    		if (form != null)
    		{
    			form.gridTab = gridTab;
				form.init(adFormID, name);
				return form;
    		}
    		else
    		{
    			throw new ApplicationException("Failed to open " + formName);
    		}
    	}
	}	//	openForm

    /**
     *
     */
	public void onEvent(Event event) throws Exception
    {
		if (event.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT)) {
    		SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Form, getAdFormId());
		}
    }

	/**
	 * @param pi
	 */
	public void setProcessInfo(ProcessInfo pi) {
		m_pi = pi;
	}

	/**
	 * @return ProcessInfo
	 */
	public ProcessInfo getProcessInfo()
	{
		return m_pi;
	}

	public void setICustomForm(IFormController customForm)
	{
		m_customForm = customForm;
	}

	public IFormController getICustomForm()
	{
		return m_customForm;
	}
	
	/**
	 * Default to embedded mode, subclass may override this to open form in different mode
	 * @return Window mode
	 */
	public Mode getWindowMode() {
		return Mode.EMBEDDED;
	}
	
	private GridTab gridTab;
	
	public GridTab getGridTab()
	{
		return gridTab;
	}
}
