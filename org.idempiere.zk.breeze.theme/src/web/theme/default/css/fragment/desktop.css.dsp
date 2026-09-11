<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>
<%-- header --%>
.desktop-header-left {
	margin: 0;
	margin-left: 1px;
	margin-top: 1px;
	background-color: transparent !important; 
	border: none !important;
}

.desktop-header-right {
	margin: 0;
	margin-top: 1px;
	padding-right:1px;
	background-color: transparent !important; 
	border: none !important;
}

.desktop-header {
	background-color: ${u:sysConfig("ZK_DESKTOP_HEADER_BACKGROUND_COLOR", "#E4E4E4")}; <%-- SysConfig with default to #E4E4E4 --%>
	width: 100%;
	height: 46px;
	border-bottom: 1px solid #C5C5C5 !important;
	padding-left: 4px;
}

.desktop-header.mobile {
	height: 36px;
	padding: 4px 4px;
}
.desktop-header.mobile .systemStatus {
	display:none;
}

.desktop-header-font {
	font-size: 10px;
}

.desktop-header-popup {
	width: 800px;
	border-radius: 2px;
	border: 1px solid #d5d5d5;
	border-right: 2px solid #d5d5d5;
	border-bottom-width: 2px;
	right: 1px;
}

.desktop-header-popup .desktop-header {
	border: none;
	height: 100% !important;
}

.desktop-header-username {
	padding-right: 6px;
}

.desktop-header-username:hover {
	color: blue;
	text-decoration: underline;
}

<%-- right panel for user name, notifications, and links --%>
.desktop-user-panel {
	float: right;
	display: inline-flex;
	align-items: center;
}
.desktop-user-panel.mobile .desktop-header-font.desktop-header-username {
	font-weight: 300;
	clear: both;
	display: inline-block;
	overflow: hidden;
	white-space: nowrap;
}

<%-- Notification Bell --%>
.desktop-header-notification-btn {
	position: relative;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 34px;
	height: 34px;
	margin-right: 8px;
	border-radius: 6px;
	cursor: pointer;
	color: #64748b;
	transition: background-color 0.15s ease, color 0.15s ease;
}
.desktop-header-notification-btn:hover {
	background-color: var(--zk-desktop-header-hover-background-color);
	color: #0f172a;
}
.desktop-header-bell-icon {
	font-size: 16px;
}
.desktop-header-notification-badge {
	position: absolute;
	top: 2px;
	right: 2px;
	min-width: 16px;
	height: 16px;
	line-height: 16px;
	padding: 0 4px;
	font-size: 10px;
	font-weight: 700;
	text-align: center;
	color: #ffffff;
	background-color: #ef4444;
	border-radius: 8px;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.15);
}

<%-- User Profile Chip --%>
.desktop-header-user-chip {
	display: inline-flex;
	align-items: center;
	padding: 3px 8px 3px 4px;
	border-radius: 20px;
	cursor: pointer;
	border: 1px solid transparent;
	transition: background-color 0.15s ease, border-color 0.15s ease;
}
.desktop-header-user-chip:hover {
	background-color: var(--zk-desktop-header-hover-background-color);
	border-color: var(--zk-desktop-header-border-color);
}
.desktop-header-user-avatar {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 28px;
	height: 28px;
	border-radius: 50%;
	background-color: #0284c7;
	color: #ffffff;
	font-size: 11px;
	font-weight: 600;
	letter-spacing: 0.5px;
	margin-right: 6px;
	flex-shrink: 0;
}
.desktop-header-user-meta {
	display: flex;
	flex-direction: column;
	text-align: left;
	margin-right: 6px;
	max-width: 200px;
}
.desktop-header-username {
	font-size: 12px;
	font-weight: 600;
	color: #1e293b;
	line-height: 14px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.desktop-header-usersub {
	font-size: 10px;
	color: #64748b;
	line-height: 12px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.desktop-header-user-caret {
	font-size: 12px;
	color: #94a3b8;
}

<%-- User Menu Popup --%>
.user-panel-popup {
	min-width: 260px;
	padding: 0 !important;
	border-radius: 8px !important;
	box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1) !important;
	border: 1px solid #e2e8f0 !important;
	background: #ffffff !important;
}
.user-panel-popup .z-popup-content {
	padding: 0 !important;
}
.user-menu-layout {
	padding: 12px 0 8px 0;
	width: 100%;
}
.user-menu-profile-card {
	padding: 4px 16px 10px 16px;
	display: flex;
	align-items: center;
}
.user-menu-avatar-big {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 40px;
	height: 40px;
	border-radius: 50%;
	background-color: #0284c7;
	color: #ffffff;
	font-size: 15px;
	font-weight: 600;
	margin-right: 12px;
	flex-shrink: 0;
}
.user-menu-info {
	display: flex;
	flex-direction: column;
	overflow: hidden;
}
.user-menu-name {
	font-size: 13px;
	font-weight: 600;
	color: #0f172a;
}
.user-menu-email {
	font-size: 11px;
	color: #64748b;
}
.user-menu-role-badge {
	display: inline-block;
	font-size: 11px;
	font-weight: 500;
	color: #0369a1;
	background-color: #e0f2fe;
	padding: 1px 6px;
	border-radius: 4px;
	margin-top: 2px;
	width: fit-content;
}
.user-menu-org, .user-menu-warehouse {
	font-size: 11px;
	color: #64748b;
	margin-top: 2px;
}
.user-menu-separator.z-separator {
	margin: 6px 0;
	background: #f1f5f9;
	border-bottom: 1px solid #e2e8f0;
}
.user-menu-actions {
	padding: 2px 8px;
}
.user-menu-item.z-toolbarbutton {
	display: flex !important;
	align-items: center !important;
	width: 100% !important;
	padding: 7px 10px !important;
	border-radius: 6px !important;
	font-size: 12px !important;
	color: #334155 !important;
	text-align: left !important;
	border: none !important;
	transition: background-color 0.15s ease, color 0.15s ease;
}
.user-menu-item.z-toolbarbutton:hover {
	background-color: #f1f5f9 !important;
	color: #0f172a !important;
}
.user-menu-item [class^="z-icon-"] {
	font-size: 14px;
	width: 20px;
	text-align: center;
	margin-right: 8px;
	color: #64748b;
}
.user-menu-item:hover [class^="z-icon-"] {
	color: #0284c7;
}
.user-menu-logout.z-toolbarbutton {
	color: #ef4444 !important;
	margin: 0 8px !important;
	width: calc(100% - 16px) !important;
}
.user-menu-logout.z-toolbarbutton:hover {
	background-color: #fef2f2 !important;
	color: #dc2626 !important;
}
.user-menu-logout [class^="z-icon-"] {
	color: #ef4444;
}

<%-- Notification Popup --%>
.notification-popup {
	width: 320px;
	max-height: 420px;
	padding: 0 !important;
	border-radius: 8px !important;
	box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1) !important;
	border: 1px solid #e2e8f0 !important;
	background: #ffffff !important;
}
.notification-popup .z-popup-content {
	padding: 0 !important;
}
.notification-popup-layout {
	padding: 0;
	width: 100%;
	max-height: 320px;
	overflow-y: auto;
}
@media screen and (max-height: 319px) {
	max-height: 100%;
}
.notification-popup-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 14px;
	border-bottom: 1px solid #e2e8f0;
	background-color: #f8fafc;
	border-top-left-radius: 8px;
	border-top-right-radius: 8px;
}
.notification-popup-title {
	font-size: 13px;
	font-weight: 600;
	color: #0f172a;
}
.notification-popup-refresh.z-toolbarbutton {
	font-size: 12px;
	color: #64748b;
	padding: 3px 6px;
	border-radius: 4px;
}
.notification-popup-refresh.z-toolbarbutton:hover {
	background-color: #e2e8f0;
	color: #0f172a;
}
.notification-item-row {
	display: flex;
	align-items: center;
	padding: 8px 10px;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.15s ease;
	margin-bottom: 2px;
}
.notification-item-row:hover {
	background-color: #f1f5f9;
}
.notification-item-icon {
	font-size: 14px;
	width: 22px;
	text-align: center;
	margin-right: 8px;
	color: #64748b;
}
.notification-item-row.has-unread .notification-item-icon {
	color: #0284c7;
}
.notification-item-name {
	font-size: 12px;
	color: #334155;
	flex-grow: 1;
}
.notification-item-badge {
	font-size: 11px;
	font-weight: 600;
	padding: 2px 7px;
	border-radius: 10px;
	margin-left: 8px;
}
.notification-item-badge.unread {
	background-color: #e0f2fe;
	color: #0369a1;
}
.notification-item-badge.zero {
	background-color: #f1f5f9;
	color: #94a3b8;
}
.notification-empty-state {
	padding: 28px 16px;
	text-align: center;
}
.notification-empty-icon {
	font-size: 32px;
	color: #10b981;
	margin-bottom: 8px;
}
.notification-empty-text {
	font-size: 12px;
	color: #64748b;
}

<%-- main desktop layout (border layout) --%>
.desktop-layout {
	position: absolute; 
	border: none;
	background-color: #E4E4E4;
}

.desktop-tabbox {
	padding-top: 0px; 
	background-color: #E4E4E4;
}

.desktop-tabbox .z-tab {
	height: 24px;
}
@media screen and (max-width: 360px) {
	.desktop-tabbox .z-tab {
		max-width: 190px;
	}
}

.desktop-tabbox .z-tab-selected {
	height: 25px;
}

.desktop-tabbox .z-tab-selected {
	border-top: 2px solid #666;
	border-top-left-radius: 5px 5px;
	border-top-right-radius: 5px 5px;
}

.desktop-tabbox .z-tab .z-tab-text {
	padding-top: 0px;
	padding-bottom: 0px;
}

.desktop-tabbox > .z-tabpanels {
	flex-grow: 1 1 0;
}

.desktop-north, .desktop-center {
	border: none;
}

.desktop-center {
	padding-top: 1px;
	background-color: #E4E4E4;
}

.desktop-tabpanel {
	margin: 0;
	padding: 0;
	border: 0;
	position: relative !important;
	background-color: #FFFFFF
}

.desktop-left-column {
	width: 200px;
	border: none;
	border-right: 1px solid #C5C5C5;
	background-color: #E4E4E4;
	padding-top: 2px; 
}

.desktop-right-column {
	width: 200px;
	border: none;
	border-left: 1px solid #C5C5C5;
	background-color: #E4E4E4;
	padding-top: 2px; 
}

.desktop-left-column + .z-west-splitter,  .desktop-left-column.z-west {
	border-top: none; 
	border-right: 1px solid #c5c5c5;
}

.desktop-right-column + .z-east-splitter,  .desktop-right-column.z-east {
	border-top: none; 
	border-left: 1px solid #c5c5c5;
}

.desktop-left-column .z-west-body {
	border-right: none;
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

.z-anchorlayout { overflow:auto }
 
.z-anchorchildren { overflow:visible }

.desktop-hometab {
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

.desktop-menu-popup {
	z-index: 9999;
	background-color: #fff;
}

.desktop-menu-toolbar {
	background-color: #ffffff; 
	verticle-align: middle; 
	padding: 2px;
	border-top: 1px solid #c5c5c5;
}

.desktop-home-tabpanel {
	background-color: #FFFFFF;
	width: 100% !important;
}

.link {
	cursor:pointer;
	padding: 2px 2px 4px 4px;
	border: none !important;
}

.link.z-toolbarbutton:hover {
	border: none !important;
	background-image: none !important;
	text-decoration: underline;
}

.link.z-toolbarbutton:hover span {
	color: blue;
}

.desktop-home-tabpanel .z-panel-head {
	background-color: #FFFFFF;
}

<%-- window container --%>
.window-container-toolbar-btn.z-toolbarbutton .z-toolbarbutton-content img {
	width: 16px;
	height: 16px;
	padding: 3px 3px;
}
.window-container-toolbar-btn.z-toolbarbutton .z-toolbarbutton-content [class^="z-icon"] {
	width: 22px;
	height: 22px;
	padding: 3px 3px;
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

.user-panel-popup .z-popup-content {
	padding-left: 0px;
	padding-right: 0px;
}
.user-panel-popup .z-popup-content > .z-vlayout {
	overflow-x: auto;
	padding: 8px;
}

.help-entitytype {
	padding-top: 5px;
}

.dashboard-content-help .z-popup-content {
	background: black;
	color: white;
	border-radius: 5px;
}

.z-menuitem.selected .z-menuitem-text {
	font-weight: bold;
}

.window-container-toolbar-btn.tab-list {
	font-size: smaller;
	padding-right: 6px;
}
.window-container-toolbar-btn.tab-list i {
	padding-right: 0px;
	margin-right: -4px;
	font-size: larger;
}
