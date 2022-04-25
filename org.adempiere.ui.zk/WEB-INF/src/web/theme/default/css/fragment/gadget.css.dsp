.fav-new-btn {
}

.fav-new-btn img {
	height: 16px;
	width: 16px;
}

.z-panel-head {
	background-image: none; background-color: #FFFFFF;
}

.z-panel {
	border-radius: 5px;
	border: 1px solid #d8d8d8;
	border-bottom-width: 1px;
}

.z-panel-noborder {
	border: none !important;
}

.z-panelchildren {
	border: none;
}

.z-panel-head {
	padding-bottom: 1px;
	border: none;
}

.z-panel-head .z-panel-header {
	padding: 0 0 2px 0;
	color: #262626; 
	background: #F4F4F4;
	font-weight: 300;
	font-size: 13px;
}	

.z-caption .z-caption-content {
	padding: 1px 1px 1px 6px;
	color: #262626; 
	font-weight: 300;
	font-size: 13px;
	cursor: move;
}

.dashboard-layout {
	width: 100%;
	height: 100%;
	position: relative;
}

.dashboard-widget {
	margin-top: 1px; 
	margin-left: auto; 
	margin-right: auto;
	position: relative;
	width: 99%;	
}

.dashboard-widget-max {
	margin: auto;
	width: auto;	
}

.dashboard-widget.dashboard-widget-max > .z-panel-body > .z-panelchildren {
	overflow: auto;
}

.dashboard-report-iframe {
	min-height:300px; 
	border: 1px solid lightgray; 
	margin:auto;
	width: 99%;
	height: 90%;
}

.favourites-box {
	width: 100%;
	margin: auto;
	padding: 1px 0px 1px 0px;
}

.favourites-box .z-vbox {
	width: 100%;
}

.favourites-box .z-hbox {
	padding: 0px 4px;
	width: 100%; 
}

.favourites-box .z-toolbar-start {
	float: right;
}
.favourites-box .trash-font-icon {
	font-family: FontAwesome;
	font-size: 20px;
}

.recentitems-box {
	width: 100%;
	margin: auto;
	padding: 1px 0px 1px 0px;
}

.recentitems-box A {
	display: block;
	padding: 1px 0px;
}

.recentitems-box .z-toolbar-start {
	float: right;
}
.recentitems-box A.trash-toolbarbutton {
	display: inline-block;
}
.recentitems-box .z-toolbar .z-toolbar-content {
	display: inline-flex;
	align-items: center;
}
.recentitems-box .trash-toolbarbutton .z-toolbarbutton-content {
	font-size: 16px;
}
.recentitems-box .trash-font-icon {
	font-family: FontAwesome;
	font-size: 20px;
}
	
.views-box {
	width: 100%;
	margin: auto;
	padding: 2px 0px 2px 0px;
}

.views-box .z-vbox {
	width: 100%;
}

.views-box .z-toolbarbutton {
	width: 100%;
	padding: 0px 14px;
}

.views-box .link img {
	height: 16px;
	width: 16px;
}
.views-box .z-toolbarbutton [class^="z-icon"] {
	text-align: center;
}
.views-box .z-toolbarbutton [class^="z-icon"]:before {
	width: 14px;
}

.activities-box {
	width: 100%;
	margin: auto;
	padding: 0px 14px;
	cursor: pointer;
}

.activities-box .z-vbox {
	width: 100%;
}

.activities-box .z-button {
	text-align: left;
}

.recentitems-box .z-toolbar, .favourites-box .z-toolbar {
	margin-top: 1px;
	margin-bottom: 1px;
}

<%-- performance indicator --%>
.performance-indicator {
	margin: 0px; 
	position: relative; 
}
.performance-indicator img {
	display: block; 
	margin: 0px;
	padding:0px;
}
.window-view-pi .performance-indicator img {
}
.performance-indicator-box {
	background-color: #eee; 
	border: 1px solid #d8d8d8; 
	border-radius: 11px; 
	cursor: pointer;
}
.performance-indicator-title {
	text-align: center; 
	background-color: #c8c8c8; 
	border: 1px solid #c8c8c8;
	padding-top: 1px; 
	padding-bottom: 1px;
	line-height:12px;
}
.performance-panel .z-grid {
	border: none;
	margin:0px; 
	padding:0px; 
	position: relative;
	width: 100%;
}

.dashboard-widget.dashboard-widget-max .chart-gadget {
	height: 100% !important; 
}

.help-content
{
	padding: 2px;
	font-size: 12px;
	font-weight: normal;
}
.mobile .help-content
{
	font-size: 14px;
}

.fav-new-btn.z-toolbarbutton [class^="z-icon-"] {
	font-size: smaller;
	color: #333;
	padding-left: 4px;
	padding-right: 4px;
}

<%-- User Favorite Dashboard Panel Start --%>
.fav-tree-panel {
  border-radius: 0px;
  border: 1px solid #d8d8d8 !important;
}

.fav-toolbar {
}

.fav-toolbar-div {
  position: relative;
  width: 100%;
}

.fav-tree-btn {
  margin-left: 5px !important;
  padding: 3px 15px;
  border: 1px solid #6d6d6d;
}

.fav-folder-textbox {
  width: 100%;
}
.fav-summary-folder .z-treecell-content {
  font-weight: bold;
}

.fav-expand-mode {
  transform: rotate(180deg);
}

.fav-mobile-ctx-menu {
  margin: 0px 5px;
  padding: 0px 5px;
  vertical-align: middle;
}
<%-- User Favorite Dashboard Panel End --%>
