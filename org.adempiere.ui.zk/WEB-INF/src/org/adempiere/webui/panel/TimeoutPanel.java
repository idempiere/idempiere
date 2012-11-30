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

package org.adempiere.webui.panel;

import org.zkoss.zhtml.Script;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.Sessions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.Label;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Timer;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.Window;
/**
 * 
 * @author Deepak Pansheriya
 *
 */
public class TimeoutPanel extends Window implements
		org.zkoss.zk.ui.event.EventListener<Event> {
	
	
	private static final long serialVersionUID = -2734157789771800337L;
	private Timer timer = null;
	private int count = 0;
	private Label lCaption = null;
	private Label ltime = null;
	private Timer timerJS = null;
	
	public TimeoutPanel(HeaderPanel pnlHead, int timeInSecond) {
		count = timeInSecond;
		pnlHead.appendChild(this);
		

		Borderlayout layout = new Borderlayout();
		layout.setParent(this);

		setWidth("23%");
		setHeight("25%");
		setPosition("left,bottom");
		setBorder(true);
		setShadow(false);
		doOverlapped();

		North north = new North();
		north.setParent(layout);
		
		Div divNorth = new Div();
		divNorth.setParent(north);
		divNorth.setStyle("text-align: center;");
		
		lCaption = new Label("You will be logged out in ");
		lCaption.setParent(divNorth);
		lCaption.setStyle("text-align: center; font-size: 20px;");

		Center center = new Center();
		center.setParent(layout);
		
		Vlayout centerVlayout = new Vlayout();
		centerVlayout.setParent(center);
		centerVlayout.setStyle("height:100%; text-align: center;");
		
		
		South south = new South();
		south.setParent(layout);
		
		
		Div divSouth = new Div();
		divSouth.setParent(south);
		divSouth.setStyle("height:100%; text-align: center;");
		
		
		timer = new Timer();
		timer.setDelay((count * 1000));
		timer.addEventListener(Events.ON_TIMER, this);
		timer.setRepeats(true);
		timer.start();
		centerVlayout.appendChild(timer);

		
		Script jScript = new Script("var countJS = "+count+";");
		jScript.setDynamicProperty("defer","true");
		jScript.setParent(centerVlayout);
		
		timerJS = new Timer();
		timerJS.setDelay((1000));
		timerJS.stop();
		timerJS.setRepeats(true);
		String script = "  countJS--;if(countJS <= 0){this.stop();} minValue = Math.floor(countJS/60).toString().length > 1  ? Math.floor(countJS/60) : '0' + Math.floor(countJS/60); secValue = (countJS%60).toString().length>1?(countJS%60) : '0'+(countJS%60); this.nextSibling.setValue(minValue+' : '+secValue);";
		timerJS.setWidgetListener("onTimer", script);
		timerJS.start();
		timerJS.setParent(centerVlayout);
		
		String minConverted = ((count / 60) + "").length() > 1 ? (count / 60) + ""
				: "0" + (count / 60);
		String secConverted = ((count % 60) + "").length() > 1 ? (count % 60) + ""
				: "0" + (count % 60);

		ltime = new Label(minConverted +" : "+secConverted);
		ltime.setParent(centerVlayout);
		ltime.setStyle("text-align: center; font-size: 40px; color:red;");

		
		Html txtLbl = new Html("Minutes&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;Second");
		txtLbl.setParent(centerVlayout);
		txtLbl.setStyle("font-size: 12px;");

		
		Vlayout vLayout = new Vlayout();
		vLayout.setParent(divSouth);
		
		
		Label saveLbl = new Label("Save your work!!");
		saveLbl.setParent(vLayout);
		saveLbl.setStyle("font-size: 20px;");
		
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals("onTimer")) 
		{
				timer.stop();
				Session session = Sessions.getCurrent();
				session.invalidate();
				Executions.sendRedirect("/index.zul");
		}
	}
}
