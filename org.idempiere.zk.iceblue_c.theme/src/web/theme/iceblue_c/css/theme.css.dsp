<%@ page contentType="text/css;charset=UTF-8" %>
<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>

:root {
	/* Core CSS variables */
	--zk-base-font-size: 12px;
	--zk-base-title-font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji";
	--zk-base-content-font-family: var(--zk-base-title-font-family);

	--zk-color-primary: #0093F9;
	
	--zk-mask-background-color: #FFFFFF; /* #E0E1E3 */;
	--zk-mesh-cell-focus-box-shadow-color: transparent; /* var(--zk-color-primary); */
	--zk-toolbar-button-background-color: transparent;
    --zk-toolbar-button-checked-color: #fff; /* var(--zk-text-color-default3); */
    --zk-toolbar-button-checked-background-color: #7ac8ff; /* var(--zk-color-primary); */

	/* Custom CSS variables */
	--zk-body-background-color: #D4E3F4;
    --zk-body-text-color: #333;
    --zk-icon-font-family: FontAwesome;

	--zk-screen-font-size-x-large: 14px;
    --zk-screen-font-size-large: 13px;
    --zk-screen-font-size-medium: var(--zk-base-font-size);
    --zk-screen-font-size-small: 11px;
    --zk-mobile-font-size: 15px;

	--zk-attachment-drag-border-color: #3fb900;
    --zk-frozen-background-color: white;

	--zk-adwindow-status-background-color: #f6fafe;
	--zk-adwindow-docstatus-error-color: red;
	--zk-adwindow-breadcrumb-background-color: #ffffff;
	--zk-adwindow-breadcrumb-border-color: #c5c5c5;
	--zk-adwindow-detailpane-grid-south-background-color: #ffffff;
	--zk-adwindow-sub-tab-border-color: #696969;
	--zk-adwindow-activity-card-border-color: #d0cdc8;
	--zk-adwindow-mobile-overflow-active-background-color: #ddd;

	--zk-appmenu-link-color: var(--zk-body-text-color);
	--zk-appmenu-link-hover-background-color: #e0f2ff;
	--zk-appmenu-link-hover-color: rgba(0,0,0,0.9);
	--zk-appmenu-search-toggle-border-color: #ababab;
	--zk-appmenu-highlight-background-color: #ffff00;

	--zk-borderlayout-collapsed-hover-shadow-color: rgba(197,197,197,0.5);
	--zk-borderlayout-slide-shadow-color: #cfcfcf;
	--zk-borderlayout-collapsed-background-color: #e0f2ff;
	--zk-borderlayout-splitter-button-color: rgba(0,0,0,0.34);
	--zk-borderlayout-splitter-background-color: #f9fcff;

	--zk-button-os-hover-color: #ffffff;
	--zk-button-os-hover-background-color: #7ac8ff;
	--zk-button-focus-border-color-local: black;
	--zk-button-sorttab-shadow-color: #bbb;
	--zk-button-sorttab-color: #555;
	--zk-button-sorttab-border-color: #bbb;
	--zk-button-sorttab-text-shadow-color: #888;
	--zk-button-cancel-background-color: #f1f1f1;
	--zk-button-cancel-color: #111111;
	--zk-button-cancel-hover-background-color: #e5e5e5;
	--zk-button-cancel-hover-color: #1d1d1d;
	--zk-button-disabled-icon-color: var(--zk-body-text-color);
	--zk-button-ok-icon-color: white;

	--zk-desktop-header-background-color: #c7e8ff;
	--zk-desktop-header-border-color: #adddff;
	--zk-desktop-header-hover-background-color: #e0f2ff;
	--zk-desktop-header-hover-color: rgba(0,0,0,0.9);
	--zk-desktop-tab-toolbar-hover-background-color: #ddd;
	--zk-desktop-tab-toolbar-hover-shadow-color: #ccc;
	--zk-desktop-column-border-color: #c5c5c5;
	--zk-desktop-column-background-color: #f6fafe;
	--zk-desktop-toolbar-icon-color: rgba(0,0,0,0.57);

	--zk-drill-window-field-color: gray;

	--zk-field-editor-button-icon-color: var(--zk-body-text-color);
	--zk-field-editor-button-hover-icon-color: #fff;
	--zk-field-editor-chosenbox-focus-background-color: #ffffcc;
	--zk-field-editor-chosenbox-focus-border-color: var(--zk-color-primary);
	--zk-field-editor-grid-combobox-focus-button-border-color: #0000ff;
	--zk-field-editor-image-border-color: #c5c5c5;
	--zk-field-editor-html-border-color: #ececec;
	--zk-field-editor-html-hover-border-color: #a8a8a8;
	--zk-field-editor-mandatory-border-color: red;
	--zk-field-editor-mandatory-label-color: red;
	--zk-field-editor-action-hover-background-color: #7ac8ff;
	--zk-field-editor-fullsize-image-border-color: #ccc;
	--zk-field-editor-fullsize-image-background-color: #e3f4f9;

	--zk-find-window-popup-background-color: #ffffff;
	--zk-find-window-popup-shadow-color: rgba(0,0,0,0.12);
	--zk-find-window-popup-mobile-shadow-color: rgba(0,0,0,0.15);
	--zk-find-window-menu-text-color: #2c3e50;
	--zk-find-window-transparent-color: transparent;
	--zk-find-window-item-hover-gradient-start-color: #f8f9fa;
	--zk-find-window-item-hover-gradient-end-color: #e9ecef;
	--zk-find-window-delete-hover-gradient-start-color: #fef2f2;
	--zk-find-window-delete-hover-gradient-end-color: #fecaca;
	--zk-find-window-item-active-background-color: #e9ecef;
	--zk-find-window-item-separator-border-color: #f1f3f4;
	--zk-find-window-delete-text-color: #e74c3c;
	--zk-find-window-delete-hover-text-color: #dc2626;
	--zk-find-window-separator-gradient-mid-color: #dee2e6;
	--zk-find-window-checkbox-checked-color: #007bff;

	--zk-font-icons-error-message-color: red;
	--zk-font-icons-exclamation-message-color: yellow;
	--zk-font-icons-info-message-color: blue;
	--zk-font-icons-question-message-color: green;

	--zk-form-busy-dialog-background-color: transparent;
	--zk-form-busy-dialog-box-background-color: transparent;
	--zk-form-busy-dialog-image-background-color: transparent;
	--zk-form-busy-dialog-label-color: #363636;

	--zk-form-status-border-color: #9CBDFF;

	--zk-gadget-panel-header-border-color: #e4e4e4;
	--zk-gadget-panel-icon-color: rgb(0 0 0 / 57%);
	--zk-gadget-panel-icon-hover-color: rgb(0 0 0 / 100%);
	--zk-gadget-dashboard-widget-border-color: rgba(0, 0, 0, 0.09);
	--zk-gadget-recent-item-text-color: var(--zk-body-text-color);
	--zk-gadget-recent-item-hover-background-color: #e0f2ff;
	--zk-gadget-views-button-hover-text-color: rgba(0,0,0,0.9);
	--zk-gadget-mandatory-process-background-color: #C62223;
	--zk-gadget-mandatory-process-text-color: white;
	--zk-gadget-performance-indicator-background-color: #eee;
	--zk-gadget-performance-indicator-border-color: #d8d8d8;
	--zk-gadget-performance-title-background-color: #c8c8c8;
	--zk-gadget-favorite-button-border-color: #6d6d6d;
	--zk-gadget-help-popup-background-color: black;
	--zk-gadget-help-popup-text-color: white;

	--zk-grid-header-background-color: #e0f2ff;
	--zk-grid-header-border-color: #ccc;
	--zk-grid-row-indicator-color: var(--zk-body-text-color);
	--zk-grid-highlight-background-color: #ffffcc;
	--zk-grid-transparent-color: transparent;
	--zk-grid-body-background-color: #fff;
	--zk-grid-content-text-color: var(--zk-body-text-color);
	--zk-grid-content-hover-text-color: #000;
	--zk-grid-sort-active-background-color: #c7e8ff;
	--zk-grid-row-cell-border-color: #cfcfcf;

	--zk-group-row-background-color: #f9f9f9;
	--zk-group-header-text-color: #5687a8;
	--zk-group-inner-background-color: #fff;
	--zk-group-list-header-border-color: rgb(207, 207, 207);

	--zk-help-window-title-color: #ff0000;
	--zk-help-window-tabs-color: #0000cc;
	--zk-help-window-content-border-color: #ddd;
	--zk-help-window-tab-header-background-color: #e6e6fa;
	--zk-help-window-tab-name-color: #000066;
	--zk-help-window-fields-color: #6600cc;
	--zk-help-window-content-link-color: #3465a4;
	--zk-help-window-left-link-color: #000;
	--zk-help-window-row-hover-background-color: #eee;

	--zk-info-window-panel-background-color: #f4f4f4;

	--zk-input-element-attachment-border-color: #dcdcdc;
	--zk-input-element-attachment-background-color: #f5f5f5;
	--zk-input-element-combobox-disabled-color: rgba(0,0,0,0.7);
	--zk-input-element-combobox-text-disabled-background-color: #eceae4;
	--zk-input-element-focus-background-color: #ffffcc;
	--zk-input-element-readonly-background-color: #f0f0f0;
	--zk-input-element-disabled-color: black;
	--zk-input-element-border-color: #ececec;
	--zk-input-element-datebox-button-color: var(--zk-body-text-color);
	--zk-input-element-hover-background-color: #7ac8ff;
	--zk-input-element-hover-icon-color: #fff;
	--zk-input-element-checkbox-focus-border-color: #006af9;
	--zk-input-element-checkbox-focus-color: #ffff08;
	--zk-input-element-label-color: var(--zk-body-text-color);

	--zk-login-window-background-color: #c7e8ff;
	--zk-login-box-background-color: white;
	--zk-login-header-text-color: #484848;
	--zk-login-label-color: black;
	--zk-login-side-panel-background-color: #ffffff;

	--zk-menu-tree-disabled-color: #c5cacb;
	--zk-menu-tree-disabled-border-color: #d0def0;

	--zk-parameter-process-bottom-border-color: rgba(0, 0, 0, 0.2);
	--zk-parameter-process-placeholder-color: white;

	--zk-setup-wizard-finished-background-color: #90ee90;
	--zk-setup-wizard-skipped-background-color: #00ff00;
	--zk-setup-wizard-delayed-background-color: #0080ff;
	--zk-setup-wizard-in-progress-background-color: #ffff33;
	--zk-setup-wizard-pending-background-color: #ffff00;
	--zk-setup-wizard-progress-border-color: #cfcfcf;

	--zk-toolbar-popup-window-border-color: #c5c5c5;
	--zk-toolbar-popup-arrow-shadow-color: rgba(0, 0, 0, 0.2);
	--zk-toolbar-popup-arrow-background-color: #ffffff;
	--zk-toolbar-popup-arrow-side-border-color: transparent;
    
	--zk-toolbar-depressed-border-color: #9cbdff;
	--zk-toolbar-depressed-background-color: #c4dcfb;
	--zk-toolbar-button-text-color: var(--zk-body-text-color);
	--zk-toolbar-button-focus-text-color: #FFFFFF;
	--zk-toolbar-button-focus-background-color: var(--zk-color-primary);

	--zk-tree-cell-text-color: var(--zk-body-text-color);
	--zk-tree-moveitem-inset-border-shadow-color: #efefef;
	--zk-tree-moveitem-inset-shadow-color: #9f9f9f;
	
	--zk-window-modal-background-color: white;
	--zk-window-transparent-color: transparent;
	--zk-window-header-color: #484848;
	--zk-window-embedded-header-color: #fff;
	--zk-window-dialog-footer-background-color: #f7faff;
	--zk-window-dialog-footer-shadow-color: #ffffff;
	--zk-window-quickform-readonly-color: #252525;
	--zk-window-quickform-current-row-border-color: #6f97d2;
}

html,body {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
	background-color: var(--zk-body-background-color);
	color: var(--zk-body-text-color);
	font-family: var(--zk-base-content-font-family);
	overflow: hidden;
}

.z-html p{
	margin:0px;
}

.z-initing {
    background-image: url(${c:encodeURL('~./theme/iceblue_c/images/zssosepowered.png')}) !important;
}

[class*="z-"]:not([class*="z-icon-"]):not([class*="z-group-icon-"]) {
	font-family: var(--zk-base-content-font-family);
}
@media screen and (min-device-width: 2500px) {
	[class*="z-"]:not([class*="z-icon-"]):not([class*="z-group-icon-"]) {
		font-size: var(--zk-screen-font-size-x-large);
	}
}
@media screen and (max-device-width: 2499px) {
	[class*="z-"]:not([class*="z-icon-"]):not([class*="z-group-icon-"]) {
		font-size: var(--zk-screen-font-size-large);
	}
}
@media screen and (max-device-width: 1899px) {
	[class*="z-"]:not([class*="z-icon-"]):not([class*="z-group-icon-"]) {
		font-size: var(--zk-screen-font-size-medium);
	}
}
@media screen and (max-device-width: 1399px) {
	[class*="z-"]:not([class*="z-icon-"]):not([class*="z-group-icon-"]) {
		font-size: var(--zk-screen-font-size-small);
	}
}

<%-- Mobile/Tablet --%>
.tablet-scrolling {
	-webkit-overflow-scrolling: touch;
}
<%-- default font size for mobile --%>
.mobile [class*="z-"]:not([class*="z-icon-"]):not([class*="z-group-icon-"]) {
    font-size: var(--zk-mobile-font-size);
}
<%-- the not=xyz is needed to get this selected over standard zk rule --%>
.mobile [class*="z-icon-"]:not([class*="xyz"]), .mobile [class*="z-group-icon-"] {
    font-size: var(--zk-mobile-font-size);
}

<%-- vbox fix for firefox and ie --%>
table.z-vbox > tbody > tr > td > table {
	width: 100%;	
}

<%-- decorate file drop area --%>
.attachment-drag-entered {
    border: 5px dashed var(--zk-attachment-drag-border-color) !important;
}

<c:include page="fragment/login.css.dsp" />

<c:include page="fragment/desktop.css.dsp" />

<c:include page="fragment/application-menu.css.dsp" />

<c:include page="fragment/gadget.css.dsp" />

<c:include page="fragment/toolbar.css.dsp" />

<c:include page="fragment/button.css.dsp" />

<c:include page="fragment/adwindow.css.dsp" />
			
<c:include page="fragment/grid.css.dsp" />

<c:include page="fragment/input-element.css.dsp" />

<c:include page="fragment/tree.css.dsp" /> 

<c:include page="fragment/field-editor.css.dsp" />

<c:include page="fragment/group.css.dsp" />

<c:include page="fragment/tab.css.dsp" />

<c:include page="fragment/menu-tree.css.dsp" />

<c:include page="fragment/info-window.css.dsp" />

<c:include page="fragment/window.css.dsp" />

<c:include page="fragment/form.css.dsp" />

<c:include page="fragment/toolbar-popup.css.dsp" />	

<c:include page="fragment/setup-wizard.css.dsp" />

<c:include page="fragment/about.css.dsp" />

<c:include page="fragment/tab-editor.css.dsp" />

<c:include page="fragment/find-window.css.dsp" />

<c:include page="fragment/help-window.css.dsp" />

<c:include page="fragment/drill-window.css.dsp" />

<c:include page="fragment/borderlayout.css.dsp" />

<c:include page="fragment/parameter-process.css.dsp" />

<c:include page="fragment/window-size.css.dsp" />

<c:include page="fragment/font-icons.css.dsp" />

<c:include page="fragment/keikai.css.dsp" />

<c:if test="${u:isThemeHasCustomCSSFragment()}">
    <c:include page="fragment/custom.css.dsp" />
</c:if>
