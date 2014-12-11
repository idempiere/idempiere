/**
 * 
 */
package org.adempiere.webui.apps;

/**
 * @author hengsin
 *
 */
public class MenuItem {

	private String label;
	private String description;
	private String image;
	private String type;
	private Object data;	
	
	/**
	 * 
	 */
	public MenuItem() {
	}

	/**
	 * @return the label
	 */
	public String getLabel() {
		return label;
	}

	/**
	 * @param label the label to set
	 */
	public void setLabel(String label) {
		this.label = label;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the image
	 */
	public String getImage() {
		return image;
	}

	/**
	 * @param image the image to set
	 */
	public void setImage(String image) {
		this.image = image;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public Object getData() {
		return data;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return label != null ? label : super.toString();
	}
}
