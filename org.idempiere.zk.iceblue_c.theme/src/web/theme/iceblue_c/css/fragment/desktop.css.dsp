<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>
<%-- header --%>
.desktop-north {
	background-color: #C7E8FF;
	border-bottom: 1px solid #ADDDFF !important;
}
<%-- left panel for logo and global search --%>
.desktop-header-left {
	margin: 0;
	margin-left: 1px;
	margin-top: 1px;
	background-color: transparent !important; 
	border: none !important;
}

.desktop-header {
	background-color: ${u:sysConfig("ZK_DESKTOP_HEADER_BACKGROUND_COLOR", "#C7E8FF")}; <%-- SysConfig with default to #C7E8FF --%>
	width: 100%;
	height: 46px;
	padding-left: 4px;
}

.desktop-header.mobile {
	height: 36px;
	padding: 4px 4px;
}
.desktop-header.mobile .systemStatus {
	display:none;
}

<%-- user name and links --%>
.desktop-header-font {
	font-size: 10px;
}

<%-- popup container for collapsed desktop header --%>
.desktop-header-popup {
	width: 800px;
	border-radius: 2px;
	border: none;
	right: 1px;
}
.desktop-header-popup, .desktop-header-popup > .z-window-content {
	background-color: #C7E8FF;
}

.desktop-header-popup .desktop-header {
	border: none;
	height: 100% !important;
}

<%-- right panel for user name and links --%>
.desktop-user-panel {
	float: right;
	height: 45px;
	padding-right: 5px;
}
.desktop-user-panel tr {
	vertical-align: middle;
}
.desktop-user-panel.mobile .desktop-header-font.desktop-header-username {
	font-weight: 600;
}
.desktop-user-panel.mobile {
    height: auto;
}
.desktop-user-panel .z-toolbarbutton:hover {
	background: #e0f2ff;
	color: rgba(0,0,0,0.9);
}
.desktop-header-username {
	padding: 0px 4px;
}
.desktop-header-username:hover {
	background: #e0f2ff;
	color: rgba(0,0,0,0.9);
}

<%-- user panel popup for mobile client --%>
.user-panel-popup .z-popup-content {
	padding-left: 0px;
	padding-right: 0px;
}
.user-panel-popup .z-popup-content > .z-vlayout {
	overflow-x: auto;
	padding: 8px;
}

<%-- main desktop layout (border layout) --%>
.desktop-layout {
	position: absolute; 
	border: none;
}
.desktop-north, .desktop-center {
	border: none;
}
.desktop-center {
	padding-top: 1px;
}
.desktop-center > .z-center-body {
	padding: 0px;
}

<%-- tabbox for application windows --%>
.desktop-tabbox {
	padding-top: 0px; 
	border: none;
}
@media screen and (max-width: 360px) {
	.desktop-tabbox .z-tab {
		max-width: 190px;
	}
}
.desktop-tabbox .z-tab .z-tab-text {
	padding-top: 0px;
	padding-bottom: 0px;
}
.desktop-tabbox > .z-tabpanels {
	flex-grow: 1 1 0;
}
.desktop-tabbox .z-tabs .z-toolbar-tabs-body {
	padding: 0px !important;
	margin: 0px !important;
}
.desktop-tabbox .z-tabs .z-toolbar-tabs-body .z-toolbarbutton {
	padding: 0px !important;
	border: 1px solid transparent !important;
	margin: 0px !important;
}
.desktop-tabbox .z-tabs .z-toolbar-tabs .z-toolbarbutton-hover {
	border: none !important;
	padding: 0px !important;
	margin: 0px !important;
}
.desktop-tabbox .z-tabs .z-toolbar-tabs .z-toolbarbutton-hover .z-toolbarbutton-content {
	background-image: none !important;
	background-color:#DDD !important;
	padding: 0px !important;
	margin: 0px !important;
	-webkit-box-shadow:inset 0px 0px 3px #CCC;
	-moz-box-shadow:inset 0px 0px 3px #CCC;	
	-o-box-shadow:inset 0px 0px 3px #CCC;	
	-ms-box-shadow:inset 0px 0px 3px #CCC;	
	box-shadow:inset 0px 0px 3px #CCC;
}
.desktop-tabbox.z-tabbox > .z-tabbox-icon.z-tabbox-left-scroll,
.desktop-tabbox.z-tabbox > .z-tabbox-icon.z-tabbox-right-scroll {
	line-height: 30px;
}
.desktop-tabbox.z-tabbox  > .z-tabs > .z-tabs-content .z-tab-image {
	width: 16px;
	height: 16px;
}

.desktop-tabpanel {
	margin: 0;
	padding: 0;
	border: 0;
	position: relative !important;
}
.desktop-tabpanel > .z-window-embedded {
	border: none;
}
<%-- the home tab panel --%>
.desktop-home-tabpanel {
	width: 100% !important;
}
.desktop-home-tabpanel .z-hlayout-inner {
	padding: 5px !important;
}

<%-- left panel for side gadgets --%>
.desktop-left-column {
	width: 200px;
	border: none;
	border-right: 1px solid #C5C5C5;
	background-color: #f6fafe;
	padding-top: 2px; 
}
.desktop-left-column + .z-west-splitter,  .desktop-left-column.z-west {
	border-top: none; 
	border-right: 1px solid transparent;
}
.desktop-left-column .z-west-body {
	border-right: none;
}

<%-- right panel for side gadgets --%>
.desktop-right-column {
	width: 200px;
	border: none;
	border-left: 1px solid #C5C5C5;
	background-color: #f6fafe;
	padding-top: 2px; 
}
.desktop-right-column + .z-east-splitter,  .desktop-right-column.z-east {
	border-top: none; 
	border-left: 1px solid transparent;
}
.desktop-right-column .z-east-body {
	border-left: none;
}
.desktop-layout > div > .z-west-collapsed, .desktop-layout > div > .z-east-collapsed {
	border-top: none;
}
.desktop-left-column .z-anchorlayout, .desktop-right-column .z-anchorlayout {
	overflow-x: hidden;
}

<%-- dashboard layout --%>
.z-anchorlayout { overflow:auto }
.z-anchorchildren { overflow:visible }
.z-anchorchildren .z-hlayout {
	white-space: normal;
}

<%-- popup for application menu tree --%>
.desktop-menu-popup {
	z-index: 9999;
}
<%-- bottom toolbar of application menu tree popup --%>
.desktop-menu-toolbar {
	verticle-align: middle; 
	padding: 2px;
	border-top: 1px solid #c5c5c5;
}

<%-- desktop window container --%>
.window-container-toolbar-btn.z-toolbarbutton {
	width: 28px;
}
.window-container-toolbar-btn.z-toolbarbutton .z-toolbarbutton-content img {
	width: 22px;
	height: 22px;
	padding: 3px 3px;
}
.window-container-toolbar-btn.z-toolbarbutton .z-toolbarbutton-content [class^="z-icon"] {
	padding: 3px 3px;
	font-size: 16px;
	color: rgba(0, 0, 0, 0.57);
}
.window-container-toolbar > .z-toolbar-content,
.window-container-toolbar-btn.z-toolbarbutton, 
.window-container-toolbar-btn.z-toolbarbutton .z-toolbarbutton-content,
.window-container-toolbar-btn.z-toolbarbutton .z-toolbarbutton-content [class^="z-icon"] {
	display:inline-flex;
	align-items: center;
	justify-content: center;
	border-bottom: 0px; 
}
.window-container-toolbar-btn.tab-list.z-toolbarbutton {
	width: auto;	
	padding: 2px 3px;
}
.window-container-toolbar-btn.tab-list.z-toolbarbutton > .z-toolbarbutton-content {
	font-size: 14px;
	padding-right: 6px;
}
.window-container-toolbar-btn.tab-list.z-toolbarbutton > .z-toolbarbutton-content > i {
	padding-right: 0px;
	margin-right: -4px;
	font-size: 18px;
}

