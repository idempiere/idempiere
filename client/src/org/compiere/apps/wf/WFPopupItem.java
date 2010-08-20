package org.compiere.apps.wf;

import javax.swing.JMenuItem;
import javax.swing.SwingUtilities;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;

public class WFPopupItem extends JMenuItem {

	/**
	 *
	 */
	private static final long serialVersionUID = 4634863991042969718L;
	private int m_AD_Workflow_ID;

	private static final CLogger log = CLogger.getCLogger(WFPopupItem.class);

	/**
	 * 	Add Line Item
	 *	@param title title
	 *	@param node node
	 *	@param AD_WF_NodeTo_ID line to
	 */
	public WFPopupItem (String title, MWFNode node, int AD_WF_NodeTo_ID)
	{
		super (title);
		m_node = node;
		m_AD_WF_NodeTo_ID = AD_WF_NodeTo_ID;
		m_AD_Workflow_ID = node.getAD_Workflow_ID();
	}	//	WFPopupItem

	/**
	 * 	Delete Line Item
	 *	@param title title
	 *	@param line line to be deleted
	 */
	public WFPopupItem (String title, MWFNodeNext line)
	{
		super (title);
		m_line = line;
	}	//	WFPopupItem

	/** The Node			*/
	private MWFNode		m_node;
	/** The Line			*/
	private MWFNodeNext m_line;
	/** The Next Node ID	*/
	private int			m_AD_WF_NodeTo_ID;

	/**
	 * 	Execute
	 */
	public void execute(final WFPanel wfp)
	{
		//	Add Line
		if (m_node != null && m_AD_WF_NodeTo_ID > 0)
		{
			int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
			MWFNodeNext newLine = new MWFNodeNext(m_node, m_AD_WF_NodeTo_ID);
			newLine.setClientOrg(AD_Client_ID, 0);
			newLine.save();
			log.info("Add Line to " + m_node + " -> " + newLine);
			wfp.load(m_AD_Workflow_ID, true);
		}
		//	Delete Node
		else if (m_node != null && m_AD_WF_NodeTo_ID == -1)
		{
			log.info("Delete Node: " + m_node);
			m_node.delete(false);
			wfp.load(m_AD_Workflow_ID, true);
		}
		//	Delete Line
		else if (m_line != null)
		{
			log.info("Delete Line: " + m_line);
			m_line.delete(false);
			wfp.load(m_AD_Workflow_ID, true);
		}
		else
			log.warning("No Action??");
	}	//	execute
}
