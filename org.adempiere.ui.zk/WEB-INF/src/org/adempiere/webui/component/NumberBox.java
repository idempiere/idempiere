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

package org.adempiere.webui.component;

import java.io.IOException;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.text.ParseException;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MSysConfig;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.zkoss.zk.au.out.AuOuter;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Decimalbox;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Vbox;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 11, 2007
 * @version $Revision: 0.10 $
 * 
 * @author Low Heng Sin
 */
public class NumberBox extends Div
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8543853599051754172L;

	private Textbox txtCalc = new Textbox();
    
    boolean integral = false;
    
    NumberFormat format = null;
    
    private Decimalbox decimalBox = null;
    private Button btn;

	private Popup popup;
    
	public NumberBox(boolean integral)
	{
		this(integral, false);
	}
	
    /**
     * 
     * @param integral
     */
    public NumberBox(boolean integral, boolean tableEditor)
    {
        super();
        this.integral = integral;
        init(tableEditor);
    }
    
    private void init(boolean tableEditor)
    {
		decimalBox = new Decimalbox();
    	if (integral)
    		decimalBox.setScale(0);
    	decimalBox.setStyle("display: inline-block;text-align:right");
    	ZKUpdateUtil.setHflex(decimalBox, "0");
    	decimalBox.setSclass("editor-input");
        decimalBox.setId(decimalBox.getUuid());
        
        char separatorChar = DisplayType.getNumberFormat(DisplayType.Number, null).getDecimalFormatSymbols().getDecimalSeparator();
        String separator = Character.toString(separatorChar);
        boolean processDotKeypad = MSysConfig.getBooleanValue(MSysConfig.ZK_DECIMALBOX_PROCESS_DOTKEYPAD, true, Env.getAD_Client_ID(Env.getCtx()));
        if (processDotKeypad) {
            StringBuffer funct = new StringBuffer();
            funct.append("function(evt)");
            funct.append("{");
            // ignore dot, comma and decimal separator and process them on key down
            funct.append("    if (!this._shallIgnore(evt, '0123456789-%'))");
            funct.append("    {");
            funct.append("        this.$doKeyPress_(evt);");
            funct.append("    }");
            funct.append("}");
            decimalBox.setWidgetOverride("doKeyPress_", funct.toString());
            funct = new StringBuffer();
            // debug // funct.append("console.log('keyCode='+event.keyCode);");
            funct.append("if (window.event)");
            funct.append("    key = event.keyCode;");
            funct.append("else");
            funct.append("    key = event.which;");
            funct.append("if (key == 108 || key == 110 || key == 188 || key == 190 || key == 194) {");
            funct.append("    var id = '$'.concat('").append(decimalBox.getId()).append("');");
            funct.append("    var calcText = jq(id)[0];");
            funct.append("    calcText.value += '").append(separator).append("';");
            funct.append("    event.stop;");
            funct.append("};");
            decimalBox.setWidgetListener("onKeyDown", funct.toString());
        }

        appendChild(decimalBox);
		
		btn = new Button();
		if (ThemeManager.isUseFontIconForImage())
			btn.setIconSclass("z-icon-Calculator");
		else
			btn.setImage(ThemeManager.getThemeResource("images/Calculator16.png"));
		btn.setTabindex(-1);
		ZKUpdateUtil.setHflex(btn, "0");
		btn.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (btn.getPopup() != null) {
					String uid = btn.getPopup();
					if (uid.startsWith("uuid("))
						uid = uid.substring(5, uid.length()-1);
					HtmlBasedComponent comp = (HtmlBasedComponent) btn.getDesktop().getComponentByUuidIfAny(uid);
					if (comp != null) {	
						Textbox ctbox = (Textbox) comp.getLastChild().getFirstChild();
						if (ctbox != null && decimalBox.getValue() != null) {
							ctbox.setText(decimalBox.getValue().toString());
							StringWriter writer = new StringWriter(1024);
							try {
								ctbox.redraw(writer);
								Clients.response(new AuOuter(ctbox, writer.toString()));
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
						comp.focus();
					}
				}				
			}
		});
		LayoutUtils.addSclass("editor-button", btn);
		appendChild(btn);
        
        popup = getCalculatorPopup();
        appendChild(popup);
        btn.setPopup(popup);
        btn.setStyle("text-align: center;");        
     
        LayoutUtils.addSclass("number-box", this);	     
        LayoutUtils.addSclass("editor-box", this);
        
        if (ClientInfo.isMobile())
        {
        	LayoutUtils.addSclass("mobile", decimalBox);
        	btn.setVisible(false);
        }

    }
    
    /**
     * 
     * @param format
     */
    public void setFormat(NumberFormat format)
    {
    	this.format = format;
    }
    
    /**
     * 
     * @param value
     */
    public void setValue(Object value)
    {
    	if (value == null)
    		decimalBox.setValue((BigDecimal) null);
    	else if (value instanceof BigDecimal)
    		decimalBox.setValue((BigDecimal) value);
    	else if (value instanceof Number)
    		decimalBox.setValue(BigDecimal.valueOf(((Number)value).doubleValue()));
    	else
    		decimalBox.setValue(new BigDecimal(value.toString()));
    }
    
    /**
     * 
     * @return BigDecimal
     */
    public BigDecimal getValue()
    {
    	return decimalBox.getValue();
    }
    
    /**
     * 
     * @return text
     */
    public String getText()
    {
    	BigDecimal value = decimalBox.getValue();
    	if (value == null) return null;
   		return decimalBox.getText();
    }
    
    /**
     * 
     * @param value
     */
    public void setValue(String value)
    {
    	Number numberValue = null;
    	
    	if (format != null)
    	{
    		try
			{
    			numberValue = format.parse(value);
    			setValue(numberValue);
			}
			catch (ParseException e)
			{
			}
    	}
    	else
    	{
    		decimalBox.setValue(new BigDecimal(value));
    	}    	
    }
    
    private Popup getCalculatorPopup()
    {
        Popup popup = new Popup() {
        	/**
			 * 
			 */
			private static final long serialVersionUID = -5991248152956632527L;

			@Override
        	public void onPageAttached(Page newpage, Page oldpage) {
        		super.onPageAttached(newpage, oldpage);
        		if (newpage != null) {
        			if (btn.getPopup() != null) {
        				btn.setPopup(this);
        			}
        		}
        	}
        };

        Vbox vbox = new Vbox();

        char separatorChar = DisplayType.getNumberFormat(DisplayType.Number, null).getDecimalFormatSymbols().getDecimalSeparator();
        String separator = Character.toString(separatorChar);
        
        txtCalc = new Textbox();
        
        decimalBox.setId(decimalBox.getUuid());
        txtCalc.setId(txtCalc.getUuid());

        boolean processDotKeypad = MSysConfig.getBooleanValue(MSysConfig.ZK_DECIMALBOX_PROCESS_DOTKEYPAD, true, Env.getAD_Client_ID(Env.getCtx()));
        StringBuffer funct = new StringBuffer();
        funct.append("function(evt)");
        funct.append("{");
        if (processDotKeypad) {
        	funct.append("    if (!this._shallIgnore(evt, '= -/()*%+0123456789'))");
        } else {
            // restrict allowed characters
            String decimalSep = separator;
            if (!processDotKeypad && !".".equals(separator))
            	decimalSep += ".";
            funct.append("    if (!this._shallIgnore(evt, '= -/()*%+0123456789").append(decimalSep).append("'))");
        }
        funct.append("    {");
        funct.append("        this.$doKeyPress_(evt);");
        funct.append("    }");
        funct.append("}");
        txtCalc.setWidgetOverride("doKeyPress_", funct.toString());

        txtCalc.setWidgetListener("onKeyDown", "calc.validateDown('" + 
        		decimalBox.getId() + "','" + txtCalc.getId() 
                + "'," + integral + "," + (int)separatorChar + ", event, " + ( processDotKeypad ? "true" : "false" ) + ");");
        txtCalc.setMaxlength(250);
        txtCalc.setCols(30);
        
        String txtCalcId = txtCalc.getId();

        vbox.appendChild(txtCalc);
        Hbox row1 = new Hbox();

        Button btnAC = new Button();
        ZKUpdateUtil.setWidth(btnAC, "40px");
        btnAC.setLabel("AC");
        btnAC.setWidgetListener("onClick", "calc.clearAll('" + txtCalcId + "')");

        Button btn7 = new Button();
        ZKUpdateUtil.setWidth(btn7, "30px");
        btn7.setLabel("7");
        btn7.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '7')");

        Button btn8 = new Button();
        ZKUpdateUtil.setWidth(btn8, "30px");
        btn8.setLabel("8");
        btn8.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '8')");

        Button btn9 = new Button();
        ZKUpdateUtil.setWidth(btn9, "30px");
        btn9.setLabel("9");
        btn9.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '9')");

        Button btnMultiply = new Button();
        ZKUpdateUtil.setWidth(btnMultiply, "30px");
        btnMultiply.setLabel("*");
        btnMultiply.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', ' * ')");

        row1.appendChild(btnAC);
        row1.appendChild(btn7);
        row1.appendChild(btn8);
        row1.appendChild(btn9);
        row1.appendChild(btnMultiply);

        Hbox row2 = new Hbox();

        Button btnC = new Button();
        ZKUpdateUtil.setWidth(btnC, "40px");
        btnC.setLabel("C");
        btnC.setWidgetListener("onClick", "calc.clear('" + txtCalcId + "')");
        
        Button btn4 = new Button();
        ZKUpdateUtil.setWidth(btn4, "30px");
        btn4.setLabel("4");
        btn4.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '4')");

        Button btn5 = new Button();
        ZKUpdateUtil.setWidth(btn5, "30px");
        btn5.setLabel("5");
        btn5.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '5')");

        Button btn6 = new Button();
        ZKUpdateUtil.setWidth(btn6, "30px");
        btn6.setLabel("6");
        btn6.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '6')");
        
        Button btnDivide = new Button();
        ZKUpdateUtil.setWidth(btnDivide, "30px");
        btnDivide.setLabel("/");
        btnDivide.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', ' / ')");

        row2.appendChild(btnC);
        row2.appendChild(btn4);
        row2.appendChild(btn5);
        row2.appendChild(btn6);
        row2.appendChild(btnDivide);

        Hbox row3 = new Hbox();

        Button btnModulo = new Button();
        ZKUpdateUtil.setWidth(btnModulo, "40px");
        btnModulo.setLabel("%");
        btnModulo.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', ' % ')");

        Button btn1 = new Button();
        ZKUpdateUtil.setWidth(btn1, "30px");
        btn1.setLabel("1");
        btn1.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '1')");

        Button btn2 = new Button();
        ZKUpdateUtil.setWidth(btn2, "30px");
        btn2.setLabel("2");
        btn2.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '2')");

        Button btn3 = new Button();
        ZKUpdateUtil.setWidth(btn3, "30px");
        btn3.setLabel("3");
        btn3.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '3')");

        Button btnSubstract = new Button();
        ZKUpdateUtil.setWidth(btnSubstract, "30px");
        btnSubstract.setLabel("-");
        btnSubstract.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', ' - ')");

        row3.appendChild(btnModulo);
        row3.appendChild(btn1);
        row3.appendChild(btn2);
        row3.appendChild(btn3);
        row3.appendChild(btnSubstract);

        Hbox row4 = new Hbox();

        Button btnCurrency = new Button();
        ZKUpdateUtil.setWidth(btnCurrency, "40px");
        btnCurrency.setLabel("$");
        btnCurrency.setDisabled(true);

        Button btn0 = new Button();
        ZKUpdateUtil.setWidth(btn0, "30px");
        btn0.setLabel("0");
        btn0.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '0')");

        Button btnDot = new Button();
        ZKUpdateUtil.setWidth(btnDot, "30px");
        btnDot.setLabel(separator);
        btnDot.setDisabled(integral);
        btnDot.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', '" + separator + "')");

        Button btnEqual = new Button();
        ZKUpdateUtil.setWidth(btnEqual, "30px");
        btnEqual.setLabel("=");
        btnEqual.setWidgetListener("onClick", "calc.evaluate('" + decimalBox.getId() + "','" 
                + txtCalcId + "','" + separator + "')");
        
        Button btnAdd = new Button();
        ZKUpdateUtil.setWidth(btnAdd, "30px");
        btnAdd.setLabel("+");
        btnAdd.setWidgetListener("onClick", "calc.append('" + txtCalcId + "', ' + ')");

        row4.appendChild(btnCurrency);
        row4.appendChild(btnDot);
        row4.appendChild(btn0);
        row4.appendChild(btnEqual);
        row4.appendChild(btnAdd);

        vbox.appendChild(row1);
        vbox.appendChild(row2);
        vbox.appendChild(row3);
        vbox.appendChild(row4);

        popup.appendChild(vbox);
        popup.setWidgetListener("onOpen", "calc.clearAll('" + txtCalcId + "')");
        return popup;
    }

    /**
     * 
     * @return boolean
     */
	public boolean isIntegral() {
		return integral;
	}

	/**
	 * 
	 * @param integral
	 */
	public void setIntegral(boolean integral) {
		this.integral = integral;
		if (integral)
			decimalBox.setScale(0);
		else
			decimalBox.setScale(Decimalbox.AUTO);
	}
	
	/**
	 * 
	 * @param enabled
	 */
	public void setEnabled(boolean enabled)
	{
	     decimalBox.setReadonly(!enabled);
	     decimalBox.setDisabled(!enabled);
	     btn.setEnabled(enabled);
	     if (enabled)
	     {
	    	 if (btn.getParent() != decimalBox.getParent())
	    		 btn.setParent(decimalBox.getParent());
	    	 btn.setPopup(popup);
	     }
	     else 
	     {
	    	 Popup p = null;
	    	 btn.setPopup(p);
	    	 if (btn.getParent() != null)
	    		 btn.detach();
	     }
	     if (enabled) {
	    	 LayoutUtils.removeSclass("editor-input-disd", decimalBox);
	     } else {
	    	 LayoutUtils.addSclass("editor-input-disd", decimalBox);
	     }
	}
	
	/**
	 * 
	 * @return boolean
	 */
	public boolean isEnabled()
	{
		 return !decimalBox.isReadonly();
	}
	
	@Override
	public boolean addEventListener(String evtnm, EventListener<?> listener)
	{
	     if(Events.ON_CLICK.equals(evtnm))
	     {
	       	 return btn.addEventListener(evtnm, listener);
	     }
	     else
	     {
	         return decimalBox.addEventListener(evtnm, listener);
	     }
	}
	
	@Override
	public void focus()
	{
		decimalBox.focus();
	}
	
	/**
	 * 
	 * @return decimalBox
	 */
	public Decimalbox getDecimalbox()
	{
		return decimalBox;
	}
	
	public Button getButton()
	{
		return btn;
	}
	
	public void setTableEditorMode(boolean flag) {
		if (flag) {
			ZKUpdateUtil.setHflex(this, "0");
			LayoutUtils.addSclass("grid-editor-input", decimalBox);
			LayoutUtils.addSclass("grid-editor-button", btn);
		} else {
			ZKUpdateUtil.setHflex(this, "1");
			LayoutUtils.removeSclass("grid-editor-input", decimalBox);
			LayoutUtils.removeSclass("grid-editor-button", btn);
		}
			
	}
}
