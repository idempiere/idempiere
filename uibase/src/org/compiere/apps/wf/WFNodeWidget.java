/**
 *
 */
package org.compiere.apps.wf;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Image;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URL;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.compiere.model.MImage;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.wf.MWFNode;
import org.netbeans.api.visual.border.Border;
import org.netbeans.api.visual.border.BorderFactory;
import org.netbeans.api.visual.layout.LayoutFactory;
import org.netbeans.api.visual.widget.ImageWidget;
import org.netbeans.api.visual.widget.LabelWidget;
import org.netbeans.api.visual.widget.Scene;
import org.netbeans.api.visual.widget.SeparatorWidget;
import org.netbeans.api.visual.widget.Widget;

/**
 * @author hengsin
 *
 */
public class WFNodeWidget extends Widget {

	public final static int NODE_WIDTH = 150;
	public final static int NODE_HEIGHT = 100;

	private static final Border EMPTY_BORDER = BorderFactory.createEmptyBorder (4);

	private int row = 0;
	private int column = 0;

	private MWFNode model;

	/**
	 * @param scene
	 */
	public WFNodeWidget(Scene scene, MWFNode node) {
		super(scene);

		setLayout (LayoutFactory.createVerticalFlowLayout ());
        setOpaque (true);
        setCheckClipping (true);

        setPreferredSize(new Dimension(NODE_WIDTH, NODE_HEIGHT));

        ImageWidget imageWidget = null;
        int imageId = node.getAD_Image_ID();
        if (imageId > 0) {
        	MImage mImage = MImage.get(Env.getCtx(), imageId);
        	Image image = null;
        	byte[] imageData = mImage.getBinaryData();
        	if (imageData != null && imageData.length > 0) {
        		try {
					image = ImageIO.read(new ByteArrayInputStream(imageData));
				} catch (IOException e) {
				}
        	} else {
        		String url = mImage.getImageURL();
        		if (url != null && url.trim().length() > 0) {
        			try {
    					image = ImageIO.read(new URL(url));
    				} catch (IOException e) {
    				}
        		}
        	}
        	if (image != null) {
        		imageWidget = new ImageWidget(scene, image);
        		imageWidget.setToolTipText(node.getName());
        		addChild(imageWidget);
        	}
        }
        else {
        	setBorder (BorderFactory.createLineBorder ());
	        Widget titleWidget = new Widget (scene);
	        titleWidget.setLayout (LayoutFactory.createHorizontalFlowLayout ());
	        titleWidget.setBorder (EMPTY_BORDER);

	        ImageWidget titleIcon = new ImageWidget (scene);
	        String action = node.getAction();
	        int index = MTreeNode.getImageIndex(action);
	        ImageIcon icon = (ImageIcon) MTreeNode.getIcon(index);
	        if (icon != null)
	        {
	        	titleIcon.setImage (icon.getImage());
	        	titleIcon.setToolTipText(getActionType(node));
	        	titleWidget.addChild (titleIcon);
	        }

	        String titleText = node.getName();
	        if (titleText.length() > 20)
	        	titleText = titleText.substring(0, 20) + "...";
	        LabelWidget titleTextWidget = new LabelWidget (scene, titleText);
	        titleTextWidget.setFont (scene.getDefaultFont ().deriveFont (Font.BOLD));
	        if (titleText.length() > 20)
	        	titleTextWidget.setToolTipText(node.getName());
	        titleWidget.addChild (titleTextWidget);
	        addChild (titleWidget);

	        addChild (new SeparatorWidget (scene, SeparatorWidget.Orientation.HORIZONTAL));

	        String description = node.getDescription(true);
			if (description != null && description.length() > 0)
			{
				MultilineLabelWidget label = new MultilineLabelWidget(scene, description);
				label.setPreferredSize(new Dimension(NODE_WIDTH - 20, NODE_HEIGHT - 20));
				addChild(label);
			}
        }

		model = node;
	}

	/**
	 * 	Get Action Info
	 *	@return info
	 */
	public String getActionType(MWFNode node)
	{
		String action = node.getAction();
		if (MWFNode.ACTION_AppsProcess.equals(action))
			return "Process";
		else if (MWFNode.ACTION_DocumentAction.equals(action))
			return "Document Action: " + node.getDocAction();
		else if (MWFNode.ACTION_AppsReport.equals(action))
			return "Report";
		else if (MWFNode.ACTION_AppsTask.equals(action))
			return "Task";
		else if (MWFNode.ACTION_SetVariable.equals(action))
			return "Set Variable";
		else if (MWFNode.ACTION_SubWorkflow.equals(action))
			return "Workflow";
		else if (MWFNode.ACTION_UserChoice.equals(action))
			return "User Choice";
		else if (MWFNode.ACTION_UserForm.equals(action))
			return "Form";
		else if (MWFNode.ACTION_UserWindow.equals(action))
			return "Window";
		else if (MWFNode.ACTION_WaitSleep.equals(action))
			return "Sleep:WaitTime=" + node.getWaitTime();
		return "";
	}	//	getActionInfo

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public MWFNode getModel() {
		return model;
	}
}
