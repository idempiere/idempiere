<%-- z-panel customization --%>
.z-panel-noborder {
	border: none !important;
}
.z-panelchildren {
	border: none;
	height: 100%;
}
.z-panel-head {
	padding-bottom: 1px;
	border: none;
}
.z-panel-head .z-panel-header {
	margin-top: 2px;
	padding: 1px 5px 1px 10px;
    border-bottom: 1px solid #e4e4e4;
}
.z-caption .z-caption-content {
	cursor: move;
	padding: 0px;
}
.z-panel-icon {
	font-size: 10px !important;
    color: rgb(0 0 0 / 57%) !important;
    margin: 4px 0 0 0 !important;
    line-height: 24px !important;
    border: 0px !important;
    border-radius: 0px !important;
}
.z-panel-icon:hover {
    color: rgb(0 0 0 / 100%) !important;
}

<%-- dashboard widget --%>
.dashboard-layout {
	width: 100%;
	height: 100%;
	position: relative;
}

.dashboard-widget.z-panel {
	display: flex; 
	flex-direction: column; 
	justify-content: stretch;
}
.dashboard-widget > .z-panel-body {
	flex-grow: 1;
}
.dashboard-widget.z-panel {
	border: 1px solid rgba(0, 0, 0, 0.09);
}
.dashboard-widget {
	margin-top: 1px; 
	margin-left: auto; 
	margin-right: auto;
	position: relative;
	width: 99%;	
	height: 100%;
}
.dashboard-widget-max {
	margin: auto;
	width: auto;	
}
.dashboard-widget.dashboard-widget-max > .z-panel-body > .z-panelchildren {
	overflow: auto;
}

<%-- favourites gadget --%>
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
.fav-new-btn img {
	height: 16px;
	width: 16px;
}

<%-- recent items gadget --%>
.recentitems-box {
	width: 100%;
	margin: auto;
	padding: 1px 0px 1px 0px;
}

.recentitems-box .z-panelchildren {
	padding: 0px;
}

.recentitems-box .menu-href [class^="z-icon-"] {
	font-size: 12px !important;
	color: #333333;
}

.recentitems-box A {
	display: block;
	padding: 2px 14px 2px 18px;
 	line-height: 24px;
	color: #333333 !important;
}
.recentitems-box A.menu-href:hover {
	background: #e0f2ff;
	text-decoration: none !important;
}

.recentitems-box .z-toolbar-start {
	float: right;
}
.recentitems-box A.trash-toolbarbutton {
	display: inline-block;
	padding: 2px 11px;
	border: none;
}
.recentitems-box .z-toolbar .z-toolbar-content {
	display: inline-flex;
	align-items: center;
}
.recentitems-box .trash-font-icon {
	font-family: FontAwesome;
	font-size: 12px;
}

<%-- embedded report content --%>
.dashboard-report-iframe {
	min-height:300px; 
	border: 1px solid lightgray; 
	margin:auto;
	width: 99%;
}
.dashboard-report-toolbar .z-toolbar-content {
	display: block;
}
.dashboard-report-toolbar .rowcount-label {
	float: right;
	padding: 5px;
}
.fill-mandatory-process-para-wrapper {
    padding: 11px;
    display: flex;
    flex-direction: column;
    max-width: 500px;
}

.fill-mandatory-process-para-text {
    background: #C62223;
    color: white;
    padding: 10px;
    border-radius: 5px;
    opacity: 90%;
}

<%-- views gadget --%>	
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
	padding: 4px 14px;
	line-height: 24px;
}
.views-box .z-toolbarbutton:hover {
	background: #e0f2ff;
	color: rgba(0,0,0,0.9);
}
.views-box .link img {
	height: 16px;
	width: 16px;
}
.views-box .z-toolbarbutton [class^="z-icon"] {
	text-align: center;
}
.views-box .z-toolbarbutton [class^="z-icon"]:before {
	width: 16px;
	display: inline-block;
}
.views-box .z-toolbarbutton .z-toolbarbutton-content {
	justify-content: left;
}

<%-- activities gadget --%>
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

<%-- performance indicator --%>
.performance-indicator {
	margin: auto;
	position: relative; 
}
.performance-indicator img {
	display: block; 
	margin: 0px;
}
.window-view-pi .performance-indicator img {
}
.performance-indicator-box {
	background-color: #eee; 
	border: 1px solid #d8d8d8; 
	border-radius: 3px; 
	cursor: pointer;
}
.performance-indicator-title {
	text-align: center; 
	background-color: #c8c8c8; 
	border: 1px solid #c8c8c8;
	padding-top: 4px; 
	padding-bottom: 4px;
	min-height: 48px;
	width: 100%;
	display: flex;  
	justify-content: center;
	align-items: center;
}
.performance-panel .z-grid {
	border: none;
	margin:0px; 
	padding:0px; 
	position: relative;
	width: 100%;
}
.gauge-indicator-title {
	text-align: center;
	padding-top: 1px; 
	padding-bottom: 1px;
	line-height:12px;
}
.performance-gadget {
	display: flex;
 	justify-content: center;
 	align-items: center;
	cursor: pointer;
}
.performance-gadget > .z-div {
	width: 100%;	
}

@media screen and (min-width: 768px) {
	.dashboard-row .chart-gadget {
		max-height: 300px; 
	}
}

@media screen and (max-width: 767px) {
	.dashboard-row .chart-gadget {
		max-height: 150px; 
	}
}

<%-- chart gadget --%>
.dashboard-widget.dashboard-widget-max .chart-gadget {
	height: 100% !important; 
}
.chart-gadget {
	text-align: center !important;
}

<%-- status line gadget --%>
.statusline-wrapper {
	height: 100%;
}
.statusline-gadget {
	display: flex;
	flex-direction: column;
 	justify-content: center;
 	align-items: center;
 	height: 100%;
 	padding: 10px 0px;
}

<%-- help gadget --%>
.help-content
{
	padding: 5px;
	font-size: 12px;
	font-weight: normal;
	line-height: 1.3em;
}
.help-content p {
	margin-bottom: 7px;
}
.mobile .help-content
{
	font-size: 14px;
}

<%-- User Favorite Dashboard Panel Start --%>
.fav-tree-panel .z-panelchildren {
  padding: 0px;
  color: #333333 !important;
}
.fav-tree-panel .z-treerow .z-treecell {
  border-top: 0px;
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
.fav-expand-mode {
  transform: rotate(180deg);
}
.fav-mobile-ctx-menu {
  margin: 0px 5px;
  padding: 0px 5px;
  vertical-align: middle;
}
<%-- favourites new button --%>
.new-toolbarbutton.z-toolbarbutton {
	padding: 2px 5px;
}

<%-- help icon and popup for gadget --%>
.dashboard-content-help-icon {
	padding: 5px;
	cursor: default;
	visibility: hidden;
}
.z-caption:hover .dashboard-content-help-icon {
	visibility: visible;
}
.dashboard-content-help-popup {
	display: none;
}
.dashboard-content-help-icon:hover ~ .dashboard-content-help-popup {
	display: inline-flex;
	background: black;
	color: white;
	border-radius: 5px;
	padding: 4px 7px;
    position: fixed;
    z-index: 1800;
    max-width: 300px;
}
.dashboard-content-help .z-popup-content {
	background: black;
	color: white;
	border-radius: 5px;
}
.dashboard-widget .z-toolbar {
    padding: 6px 13px 0px 13px;
}
.dashboard-widget .z-row-content {
	padding: 1px 5px;
}

.dashboard-widget .z-row-inner {
	border-top: none;
}
