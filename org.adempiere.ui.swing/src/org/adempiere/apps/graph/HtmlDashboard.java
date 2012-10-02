/**
 * 
 */
package org.adempiere.apps.graph;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.logging.Level;

import javax.swing.JEditorPane;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JScrollPane;
import javax.swing.SwingUtilities;
import javax.swing.event.HyperlinkEvent;
import javax.swing.event.HyperlinkListener;
import javax.swing.text.Document;

import org.compiere.apps.AEnv;
import org.compiere.apps.AWindow;
import org.compiere.model.MAchievement;
import org.compiere.model.MDashboardContent;
import org.compiere.model.MDashboardPreference;
import org.compiere.model.MGoal;
import org.compiere.model.MMeasureCalc;
import org.compiere.model.MProjectType;
import org.compiere.model.MQuery;
import org.compiere.model.MRequestType;
import org.compiere.model.MRole;
import org.compiere.swing.CMenuItem;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * @author fcsku
 *
 */
public class HtmlDashboard extends JPanel implements MouseListener,
		ActionListener, HyperlinkListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8125801717324723271L;
	private static Dimension paneldimensionMin = new Dimension(80, 80);
	private	JEditorPane	html;
	private enum PAGE_TYPE {PAGE_HOME, PAGE_PERFORMANCE, PAGE_LOGO};
	private static CLogger log = CLogger.getCLogger (HtmlDashboard.class);
	MGoal[] m_goals = null;
	JPopupMenu 					popupMenu = new JPopupMenu();
	private CMenuItem 			mRefresh = new CMenuItem(Msg.getMsg(Env.getCtx(), "Refresh"), Env.getImageIcon("Refresh16.gif"));
	URL	lastUrl  = null;


	/**
	 * 	Constructor
	 */
	public HtmlDashboard(String url, MGoal[] m_goals, boolean scrolling)
	{	
		super();
		//+param VTreePanel treePanel,
		//this.treePanel = treePanel;
		setName("test title");
		this.setLayout( new BorderLayout() );
		this.m_goals = m_goals;
	    // Create an HTML viewer
		JEditorPane.registerEditorKitForContentType("text/html", "org.adempiere.apps.graph.FCHtmlEditorKit");
	    html = new JEditorPane();
	    html.setContentType("text/html");
	    html.setEditable( false );
	    htmlUpdate(url);
	    JScrollPane scrollPane = null;
	    if (scrolling)
	    	scrollPane = new JScrollPane();
	    else
	    	scrollPane = new JScrollPane(JScrollPane.VERTICAL_SCROLLBAR_NEVER, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
	    scrollPane.getViewport().add( html, BorderLayout.CENTER );
	    this.add( scrollPane, BorderLayout.CENTER );
		this.setMinimumSize(paneldimensionMin);
		addMouseListener(this);
		html.addHyperlinkListener( this );
		mRefresh.addActionListener(this);
		popupMenu.add(mRefresh);
		html.addMouseListener(this);
		html.setBackground(getBackground());
	}
	
	public HtmlDashboard(String url)
	{	
		 new HtmlDashboard(url, null, true);
	}
	
	private String createHTML(PAGE_TYPE requestPage){
		
		StringBuilder result = new StringBuilder("<html><head>");
		
		// READ CSS
		URL url = getClass().getClassLoader().
			getResource("org/compiere/css/PAPanel.css");
		InputStreamReader ins;
		try {
			ins = new InputStreamReader(url.openStream());
			BufferedReader bufferedReader = new BufferedReader( ins );
			String cssLine;
			result.append("<style type=\"text/css\">");
			while ((cssLine = bufferedReader.readLine()) != null) 
				result.append(cssLine).append("\n");
			result.append("</style>");
		} catch (IOException e1) {
			log.log(Level.SEVERE, e1.getLocalizedMessage(), e1);
		}
		//System.out.println(result);
		switch (requestPage) {
		    case PAGE_LOGO:
		    	
		    	result.append("</head><body class=\"header\">")
		    		  .append("<table width=\"100%\"><tr><td>")
		    		  .append("<img src=\"res:org/compiere/images/logo_ad.png\">")
		    		  .append("</td><td></td><td width=\"290\">")
		    		  .append("</td></tr></table>")
		    		  .append("</body></html>");
		    	break;
		    	
			case PAGE_HOME: //**************************************************************
				 
				result.append("</head><body><div class=\"content\">\n");// "<link rel=\"stylesheet\" type=\"text/css\" href=\"file:///c:/standard.css\"/>"
				queryZoom = null;
				queryZoom = new ArrayList<MQuery>();
				String appendToHome = null;
				try
				{
					int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		        	int AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());
		        	
		        	MDashboardPreference[] dps = MDashboardPreference.getForSession(AD_User_ID, AD_Role_ID);
		        	if (dps.length == 0)
		        		createDashboardPreference();
		        	
		        	dps = MDashboardPreference.getForSession(true, AD_User_ID, AD_Role_ID); // based on user and role
		        	
					for (final MDashboardPreference dp : dps)
					{
						MDashboardContent dc = new MDashboardContent(dp.getCtx(), dp.getPA_DashboardContent_ID(), dp.get_TrxName());
						
						if (!Util.isEmpty(dc.getZulFilePath(), true))
							continue;
						//
						appendToHome = dc.getHTML();
						String descriptionTrl = dp.get_Translation(MDashboardContent.COLUMNNAME_Description);
						if (appendToHome != null) {
							if (descriptionTrl != null)
								result.append("<H2>").append(descriptionTrl).append("</H2>\n");
							result.append(stripHtml(appendToHome, false)).append("<br>\n");
						}
						
						if (dc.getAD_Menu_ID() > 0) {
							result.append("<a class=\"hrefNode\" href=\"http:///window/node#");
							result.append(String.valueOf(dc.getAD_Window_ID()));// "AD_MENU_ID") fcsku 3.7.07
							result.append("\">");
							result.append(descriptionTrl.toString());
							result.append("</a><br>\n");
							
						}
						result.append("<br>\n");
						//result += "table id: " + rs.getInt("AD_TABLE_ID");
						if (dc.getPA_Goal_ID() > 0)
							result.append(goalsDetail(dc.getPA_Goal_ID()));
					}
				}
				catch (Exception e)
				{
					log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				}
				finally
				{
				}
				result.append("<br><br><br>\n")
					  .append("</div>\n</body>\n</html>\n");
				break;
			default: //************************************************************** 
				log.warning("Unknown option - "+requestPage);
		}
		return result.toString();
	}
	
	private void createDashboardPreference()
	{
		if (Env.getAD_User_ID(Env.getCtx()) == 0 && Env.getAD_Role_ID(Env.getCtx()) == 0)
			return;
		
		MDashboardContent[] dcs = MDashboardContent.getForSession(0, 0);
		for (MDashboardContent dc : dcs)
		{
			MDashboardPreference preference = new MDashboardPreference(Env.getCtx(), 0, null);
			preference.setAD_Org_ID(Env.getAD_Org_ID(Env.getCtx()));
			preference.setAD_Role_ID(Env.getAD_Role_ID(Env.getCtx()));
			preference.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
			preference.setColumnNo(dc.getColumnNo());
			preference.setIsCollapsedByDefault(dc.isCollapsedByDefault());
			preference.setIsShowInDashboard(dc.isShowInDashboard());
			preference.setLine(dc.getLine());
			preference.setPA_DashboardContent_ID(dc.getPA_DashboardContent_ID());
			
			if (!preference.save()){
				StringBuilder msglog = new StringBuilder("Failed to create dashboard preference ").append(preference.toString());
				log.log(Level.SEVERE, msglog.toString());
			}
		}
	}
	 
	ArrayList<MQuery> queryZoom = null; //new ArrayList<MQuery>();
	
	private String goalsDetail(int AD_Table_ID) { //TODO link to goals
		StringBuilder output = new StringBuilder();
		if (m_goals==null) return output.toString();
		for (int i = 0; i < m_goals.length; i++) {
		  MMeasureCalc mc = MMeasureCalc.get(Env.getCtx(), m_goals[i].getMeasure().getPA_MeasureCalc_ID());
		  if (AD_Table_ID == m_goals[i].getPA_Goal_ID()){// mc.getAD_Table_ID()) {
			output.append("<table class=\"dataGrid\"><tr>\n<th colspan=\"3\" class=\"label\"><b>").append(m_goals[i].getName()).append("</b></th></tr>\n");  
			output.append("<tr><td class=\"label\">Target</td><td colspan=\"2\" class=\"tdcontent\">").append(m_goals[i].getMeasureTarget()).append("</td></tr>\n");  
			output.append("<tr><td class=\"label\">Actual</td><td colspan=\"2\" class=\"tdcontent\">").append(m_goals[i].getMeasureActual()).append("</td></tr>\n");  
			
			//if (mc.getTableName()!=null) output += "table: " + mc.getAD_Table_ID() + "<br>\n";
			Graph barPanel = new Graph(m_goals[i]);
			GraphColumn[] bList = barPanel.getGraphColumnList();
			MQuery query = null;
			output.append("<tr><td rowspan=\"").append(bList.length).append("\" class=\"label\" valign=\"top\">").append(m_goals[i].getXAxisText()).append("</td>\n");
			for (int k=0; k<bList.length; k++) {
				GraphColumn bgc = bList[k];
				if (k>0) output.append("<tr>");
				if (bgc.getAchievement() != null)	//	Single Achievement
				{
					MAchievement a = bgc.getAchievement();
					query = MQuery.getEqualQuery("PA_Measure_ID", a.getPA_Measure_ID());
				}
				else if (bgc.getGoal() != null)		//	Multiple Achievements 
				{
					MGoal goal = bgc.getGoal();
					query = MQuery.getEqualQuery("PA_Measure_ID", goal.getPA_Measure_ID());
				}
				else if (bgc.getMeasureCalc() != null)	//	Document
				{
					mc = bgc.getMeasureCalc();
					query = mc.getQuery(m_goals[i].getRestrictions(false), 
						bgc.getMeasureDisplay(), bgc.getDate(), 
						MRole.getDefault());	//	logged in role
				}
				else if (bgc.getProjectType() != null)	//	Document
				{
					MProjectType pt = bgc.getProjectType();
					query = pt.getQuery(m_goals[i].getRestrictions(false), 
						bgc.getMeasureDisplay(), bgc.getDate(), bgc.getID(), 
						MRole.getDefault());	//	logged in role
				}
				else if (bgc.getRequestType() != null)	//	Document
				{
					MRequestType rt = bgc.getRequestType();
					query = rt.getQuery(m_goals[i].getRestrictions(false), 
						bgc.getMeasureDisplay(), bgc.getDate(), bgc.getID(),
						MRole.getDefault());	//	logged in role
				}
				output.append("<td class=\"tdcontent\">").append(bgc.getLabel()).append("</td><td  class=\"tdcontent\">");
				if (query != null) {
					output.append("<a class=\"hrefZoom\" href=\"http:///window/zoom#")  
						   .append(queryZoom.size())
						   .append("\">")
						   .append(bgc.getValue())
						   .append("</a><br>\n");
					queryZoom.add(query);
				}
				else {
					log.info("Nothing to zoom to - " + bgc);
					output.append(bgc.getValue());
				}
				output.append("</td></tr>");
			}
			output.append("</tr>")
				   .append("<tr><td colspan=\"3\">") 
				   .append(m_goals[i].getDescription())
				   .append("<br>")
				   .append(stripHtml(m_goals[i].getColorSchema().getDescription(), true))
				   .append("</td></tr>") 
				   .append("</table>\n");
			bList = null;
			barPanel = null;
		}
		}
		return output.toString();
	}
	
	private String stripHtml(String htmlString, boolean all) {
		htmlString = htmlString
		.replace("<html>", "")
		.replace("</html>", "")
		.replace("<body>", "")
		.replace("</body>", "")
		.replace("<head>", "")
		.replace("</head>", "");
		
		if (all)
			htmlString = htmlString
			.replace(">", "&gt;")
			.replace("<", "&lt;");
		return htmlString;
	}
	private void htmlUpdate(String url) {
		try {
			htmlUpdate( new URL( url ) );
		} catch( MalformedURLException e )	{
		    log.warning("Malformed URL: " + e );
		}
	}
	
	private void htmlUpdate(URL url) {
		if ((url==null) || (url.getPath().equals("/local/home"))){
			html.setText(createHTML(PAGE_TYPE.PAGE_HOME));
			html.setCaretPosition(0);
			lastUrl = url;
		}
		else if (url.getPath().equals("/local/logo")){
			html.setText(createHTML(PAGE_TYPE.PAGE_LOGO));
			html.setCaretPosition(0);
			lastUrl = url;
		}
		else if (url.getPath().equals("/local/performance")){
			html.setText(createHTML(PAGE_TYPE.PAGE_PERFORMANCE));
		}
		else if (url.getPath().equals("/window/node")){
			/* fcsku 3.7.07
			CButton button = new CButton("");		//	Create the button
			button.setActionCommand(String.valueOf(url.getRef())); //getNode_ID()
			button.addActionListener(treePanel); //VTreePanel
			//AEnv.zoom(130, 0);
			html.setCursor(Cursor.getPredefinedCursor( Cursor.WAIT_CURSOR ));
			button.doClick();
			html.setCursor(Cursor.getPredefinedCursor( Cursor.DEFAULT_CURSOR ));
			*/
			int AD_Window_ID=Integer.parseInt(url.getRef());
			AWindow frame = new AWindow(getGraphicsConfiguration());
			if (!frame.initWindow(AD_Window_ID, null))//MQuery.getEqualQuery(TableName + "_ID", Record_ID)))
				return;
			AEnv.addToWindowManager(frame);
			if (Ini.isPropertyBool(Ini.P_OPEN_WINDOW_MAXIMIZED))
			{
				AEnv.showMaximized(frame);
			}
			else
			{
				AEnv.showCenterScreen(frame);
			}
			frame = null;
			html.setCursor(Cursor.getPredefinedCursor( Cursor.DEFAULT_CURSOR ));
		}
		else if (url.getPath().equals("/window/zoom")){ 
			int index = Integer.parseInt(String.valueOf(url.getRef()));
			if ((index >= 0) && (index < queryZoom.size())) {
				html.setCursor(Cursor.getPredefinedCursor( Cursor.WAIT_CURSOR ));
				AEnv.zoom(queryZoom.get(index));
				html.setCursor(Cursor.getPredefinedCursor( Cursor.DEFAULT_CURSOR ));
			}
		}
		else if (url != null){
			// Load some cursors
			Cursor cursor = html.getCursor();
			html.setCursor( Cursor.getPredefinedCursor( Cursor.WAIT_CURSOR ) );
			SwingUtilities.invokeLater( new PageLoader( html, url, cursor ) );
			lastUrl = url;
		}
	}
	
	
    public void hyperlinkUpdate( HyperlinkEvent event )
    {
		if( event.getEventType() == HyperlinkEvent.EventType.ACTIVATED )
		{
			//System.out.println("parsed url: " + event.getURL());// +" from: " +event.getDescription());
			htmlUpdate(event.getURL());
		}
    }
    
	/* (non-Javadoc)
	 * @see java.awt.event.MouseListener#mouseClicked(java.awt.event.MouseEvent)
	 */
	public void mouseClicked(MouseEvent e) {
		if (SwingUtilities.isRightMouseButton(e))
			popupMenu.show((Component)e.getSource(), e.getX(), e.getY());
	}

	/* (non-Javadoc)
	 * @see java.awt.event.MouseListener#mouseEntered(java.awt.event.MouseEvent)
	 */
	public void mouseEntered(MouseEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.MouseListener#mouseExited(java.awt.event.MouseEvent)
	 */
	public void mouseExited(MouseEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.MouseListener#mousePressed(java.awt.event.MouseEvent)
	 */
	public void mousePressed(MouseEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.MouseListener#mouseReleased(java.awt.event.MouseEvent)
	 */
	public void mouseReleased(MouseEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
	 */
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == mRefresh)
		{
			if (m_goals != null)
				for (int i=0; i < m_goals.length; i++) 
					m_goals[i].updateGoal(true);
			htmlUpdate(lastUrl);
			Container parent = getParent();
			if (parent != null)
				parent.invalidate();
			invalidate();
			if (parent != null)
				parent.repaint();
			else
				repaint();
		}
	}
	
	class PageLoader implements Runnable
	{
	    private JEditorPane html;
	    private URL         url;
	    private Cursor      cursor;

	    PageLoader( JEditorPane html, URL url, Cursor cursor ) 
	    {
	        this.html = html;
	        this.url = url;
	        this.cursor = cursor;
	    }

	    public void run() 
	    {
		    if( url == null ) 
		    {
	    		// restore the original cursor
		    	html.setCursor( cursor );

	    		// PENDING(prinz) remove this hack when
	    		// automatic validation is activated.
	    		Container parent = html.getParent();
	    		parent.repaint();
	        }
	        else 
	        {
	    		Document doc = html.getDocument();
		    	try {
			        html.setPage( url );
	    		}
	    		catch( IOException ioe ) 
	    		{
	    		    html.setDocument( doc );
	    		}
	    		finally
	    		{
	    		    // schedule the cursor to revert after
		    	    // the paint has happended.
			        url = null;
	    		    SwingUtilities.invokeLater( this );
		    	}
		    }
		}
	}
}
