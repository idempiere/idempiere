package org.adempiere.webui.adwindow.validator;

public enum WindowValidatorEventType {
	BEFORE_IGNORE("beforeIgnore"),
	AFTER_IGNORE("afterIgnore"),
	BEFORE_NEW("beforeNew"),
	AFTER_NEW("afterNew"),
	BEFORE_PRINT("beforePrint"),
	AFTER_PRINT("afterPrint"),
	BEFORE_DELETE("beforeDelete"),
	AFTER_DELETE("afterDelete"),
	BEFORE_SAVE("beforeSave"),
	AFTER_SAVE("afterSave"),
	BEFORE_COPY("beforeCopy"),
	AFTER_COPY("afterCopy");
	
	private String name;

	private WindowValidatorEventType(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
}
