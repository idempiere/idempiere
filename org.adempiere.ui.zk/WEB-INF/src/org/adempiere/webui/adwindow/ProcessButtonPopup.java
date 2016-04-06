/**
 * 
 */
package org.adempiere.webui.adwindow;

import java.util.List;

import org.adempiere.webui.component.Window;
import org.adempiere.webui.util.ZKUpdateUtil;
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
		ZKUpdateUtil.setHflex(this, "min");
		setBorder("normal");
		
		Vbox vbox = new Vbox();
		ZKUpdateUtil.setHflex(vbox, "true");
		appendChild(vbox);
		vbox.setSclass("toolbar-popup-window-cnt");
		vbox.setAlign("stretch");
		
		for(Button button : buttons) {
			if (button.getPage() != null) {
				button.detach();
			}
			ZKUpdateUtil.setHflex(button, "1");
			vbox.appendChild(button);
		}
	}

}
