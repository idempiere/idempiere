/**
 * 
 */
package org.adempiere.webui.adwindow;

import java.util.List;

import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WButtonEditor;
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

	public void render(List<WButtonEditor> editors) {
		setSclass("toolbar-popup-window");
		//setWidth("250px");
		setHflex("min");
		setBorder("normal");
		
		Vbox vbox = new Vbox();
		appendChild(vbox);
		vbox.setSclass("toolbar-popup-window-cnt");
		vbox.setAlign("stretch");
		
		for(WButtonEditor editor : editors) {
			if (editor.getComponent().getPage() != null) {
				editor.getComponent().detach();
			}
			vbox.appendChild(editor.getComponent());
		}
	}

}
