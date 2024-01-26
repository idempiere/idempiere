package org.idempiere.ui.zk.report;

import org.adempiere.webui.window.ZkReportViewer;
import org.zkoss.util.media.AMedia;

public interface IReportViewerRenderer {

	String getId();
	String getExportLabel();
	default String getPreviewLabel() {
		return getId();
	}
	String getContentType();
	String getFileExtension();
	boolean isExport();
	boolean isPreview(boolean roleCanExport);
	AMedia renderMedia(ZkReportViewer viewer, boolean export);	
	
	default boolean isSameContentForExportAndPreview() {
		return true;
	}
	
	/**
	 * Create file name prefix from name
	 * @param name
	 * @return file name prefix from name
	 */
	default String makePrefix(String name) {
		StringBuilder prefix = new StringBuilder();
		char[] nameArray = name.toCharArray();
		for (char ch : nameArray) {
			if (Character.isLetterOrDigit(ch)) {
				prefix.append(ch);
			} else {
				prefix.append("_");
			}
		}
		return prefix.toString();
	}
}
