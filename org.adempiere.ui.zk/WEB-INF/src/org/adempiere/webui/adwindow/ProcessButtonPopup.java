/**
 * 
 */
package org.adempiere.webui.adwindow;

import java.util.List;

import org.adempiere.webui.component.Window;
import org.zkoss.zul.Button;
import org.zkoss.zul.Vbox;

/**
 * @author hengsin
 *
 */
public class ProcessButtonPopup extends Window {
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 304878472233552113L;

	public void render(List<Button> buttons) {
		setSclass("toolbar-popup-window process-buttons-popup");
		//setWidth("250px");
		setHflex("min");
		setBorder("normal");
		
		Vbox vbox = new Vbox();
		vbox.setHflex("true");
		appendChild(vbox);
		vbox.setSclass("toolbar-popup-window-cnt");
		vbox.setAlign("stretch");
		
		for(Button button : buttons) {
			if (button.getPage() != null) {
				button.detach();
			}
			button.setHflex("1");
			vbox.appendChild(button);
		}
	}

}
