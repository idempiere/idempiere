<%-- popup window for toolbar report button --%>
.toolbar-popup-window {
	border-left: 1px solid var(--zk-toolbar-popup-window-border-color);
	border-right: 1px solid var(--zk-toolbar-popup-window-border-color);
}
.toolbar-popup-window .z-window-content {
	padding: 0px;
}
.toolbar-popup-window.z-window.z-window-noheader {
	padding: 4px;
	padding-bottom: 0px;
}
.toolbar-popup-window::before {
	border-bottom: 7px solid var(--zk-toolbar-popup-arrow-shadow-color);
	border-left: 7px solid var(--zk-toolbar-popup-arrow-side-border-color);
	border-right: 7px solid var(--zk-toolbar-popup-arrow-side-border-color);
	content: "";
	display: inline-block;
	left: 9px;
	position: absolute;
	top: -7px;
}
.toolbar-popup-window::after {
	border-bottom: 6px solid var(--zk-toolbar-popup-arrow-background-color);
	border-left: 6px solid var(--zk-toolbar-popup-arrow-side-border-color);
	border-right: 6px solid var(--zk-toolbar-popup-arrow-side-border-color);
	content: "";
	display: inline-block;
	left: 10px;
	position: absolute;
	top: -6px;
}
.toolbar-popup-window .dialog-footer {
	padding: 4px;
}
