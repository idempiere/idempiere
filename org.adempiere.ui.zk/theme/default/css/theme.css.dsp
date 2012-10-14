<%@ page contentType="text/css;charset=UTF-8" %>
<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>

html,body {
	margin: 0;
	padding: 0;
	height: 100%;
	width: 100%;
	background-color: #D4E3F4;
	color: #333;
	font-family: Helvetica,Arial,sans-serif;
	overflow: hidden;
}

<%-- login --%>
.login-window {
	background-color: #E5E5E5;
}

.login-box-body {
	width: 660px;
	background-image: url(../images/login-box-bg.png);
	background-repeat: repeat-y;
	background-color: transparent;
	z-index: 1;
	padding: 0;
	margin: 0;
	text-align: center;
	padding-bottom: 100px;
}

.login-box-header {
	background-image: url(../images/login-box-header.png);
	background-color: transparent;
	z-index: 2;
	height: 54px;
	width: 660px;
}

.login-box-header-txt {
	color: white !important;
	font-weight: bold;
	position: relative;
	top: 30px;
}

.login-box-header-logo {
	padding-top: 20px;
	padding-bottom: 25px;
}

.login-box-footer {
	background-image: url(../images/login-box-footer.png);
	background-position: top right;
	background-attachment: scroll;
	background-repeat: repeat-y;
	z-index: 2;
	height: 110px;
	width: 660px;
}

.login-box-footer .confirm-panel {
	width: 600px !important;
}

.login-box-footer-pnl {
	width: 604px;
	margin-left: 10px;
	margin-right: 10px;
	padding-top: 40px;
}

.login-label {
	color: black;
	text-align: right;
	width: 40%;
}

.login-field {
	text-align: left;
	width: 55%;
}

.login-btn {
	height: 36px;
	width: 72px;
}

.login-east-panel, .login-west-panel {
	width: 350px;
	background-color: #E0EAF7;
	position: relative;
}

<%-- header --%>
.desktop-header-left {
	margin: 0;
	margin-left: 5px;
	margin-top: 3px;
	background-color: transparent !important; 
	border: none !important;
}

.desktop-header-right {
	margin: 0;
	margin-top: 3px;
	padding-right: 5px;
	background-color: transparent !important; 
	border: none !important;
}

.desktop-header {
	background-color: #F4F4F4;
	width: 100%;
	height: 35px;
	border-bottom: 1px solid #C5C5C5;
}

.desktop-header-font {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}

.menu-href {
	font-size: 11px;
	font-weight: normal;
	color: #333 !important;
	text-decoration: none !important;
}

.menu-href:hover, .menu-href:active {
	text-decoration: underline !important;
}

.menu-href img {
	padding: 2px;
}

.fav-new-btn {
	margin-top: 4px;
	margin-left: 2px;
}

.disableFilter img {
	opacity: 0.2;
	filter: progid : DXImageTransform . Microsoft . Alpha(opacity = 20);
	-moz-opacity: 0.2;
}

.toolbar {
	padding: 0px;
}

.z-toolbarbutton-cnt {
	padding: 0px;
}

.toolbar-button {
	background-color: transparent; 
	display:inline-block; 
	margin-left: 1px; 
	margin-right: 1px; 
	width: 26px; 
	height: 24px;
}

.toolbar-button .z-toolbarbutton-body .z-toolbarbutton-cnt img {
	width: 22px;
	height: 22px;
	padding: 0px 1px 0px 1px;
	border-style: solid;
	border-width: 1px;
	border-color: transparent;
}

.depressed img {
	border-width: 1px;
	border-color: #9CBDFF;
	background-color: #C4DCFB;
	padding: 0px 1px 0px 1px;
}

<%-- button --%>
.action-button {
	height: 30px;
	width: 48px;
}

.action-text-button {
	height: 30px;
	width: 80px;
}

.action-image-text-button {
	height: 30px;
	width: 80px;
}

<%-- desktop --%>
div.wc-modal, div.wc-modal-none, div.wc-highlighted, div.wc-highlighted-none {
	background-color: white;
}

.desktop-user-panel {
	text-align: right;
}

.desktop-layout {
	position: absolute; 
	border: none;
}

.desktop-tabbox {
	padding-top: 0px; 
	background-color: #E4E4E4;
}

.desktop-tabbox .z-tab {
	margin-right: 2px;
}

.desktop-north, .desktop-center {
	border: none;
}

.desktop-center {
	padding-top: 4px;
	background-color: #E4E4E4;
}

.desktop-tabpanel {
	margin: 0;
	padding: 0;
	border: 0;
	position: absolute !important;
	background-color: #FFFFFF
}

.menu-search-panel .z-comboitem-img { 
	vertical-align:top; 
	padding-bottom:4px; 
}

.menu-panel .z-toolbar-panel {
	padding-right: 0;
}

.desktop-left-column {
	width: 300px;
	border: none;
	background-color: #E4E4E4;
	padding-top: 4px; 
}

.desktop-left-column + .z-west-splt {
	border-top: none; 
	border-right: 1px solid #c5c5c5;
	border-left: 1px solid #c5c5c5;
}

.desktop-left-column .z-west-body {
	border-right: none;
}

.desktop-left-column .z-west-header {
	border-top: 1px solid #c5c5c5;
}

.desktop-left-column .z-anchorlayout-body {
	overflow-x: hidden;
}

.desktop-hometab {
	margin-left: 4px !important;
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
}

<%-- dashlet --%>
.desktop-home-tabpanel .z-panel-tl, .desktop-home-tabpanel .z-panel-tr, 
.desktop-home-tabpanel .z-panel-hr, .desktop-home-tabpanel .z-panel-hl, 
.desktop-home-tabpanel .z-panel-hm {
	background-image: none; background-color: #FFFFFF;
}

.desktop-home-tabpanel .z-panel-hl {
	padding-bottom: 1px;
	border-bottom: 2px solid #9D9D9D;  
}

.desktop-home-tabpanel .z-panel-hl .z-panel-header {
	padding: 0 0 2px 0;
	color: #333; font-weight: bold;
}	

.desktop-left-column .z-panel-tl, .desktop-left-column .z-panel-tr, 
.desktop-left-column .z-panel-hr, .desktop-left-column .z-panel-hl, 
.desktop-left-column .z-panel-hm {
	background-image: none; background-color: #E4E4E4;
}

.desktop-left-column .z-panel-hl {
	padding-bottom: 1px;
	border-bottom: 2px solid #9D9D9D;
}

.desktop-left-column .z-panel-hl .z-panel-header {
	padding: 0 0 2px 0;
	color: #333; font-weight: bold;
}

.menu-panel {
	width: 100% !important;
	height: 100% !important;
	position: relative !important;
}

.menu-panel .z-tree {
	border: none !important;
	width: 100%;
}

.dashboard-layout {
	width: 100%;
	height: 100%;
	position: absolute;
}

.dashboard-widget {
	margin-top: 4px; 
	margin-left: auto; 
	margin-right: auto;
	position: relative;
	width: 92%;
}

.dashboard-report-iframe {
	min-height:300px; 
	border: 1px solid lightgray; 
	margin:auto;
	width: 99%;
	height: 90%;
}

<%-- adwindow and form --%>
.adwindow-layout {
	position:absolute; 
	border: none;
	width: 100%;
	height: 100%;
}

.adwindow-layout .z-center {
	border: none;
}

.adwindow-north {
	border: none;
	border-bottom: 1px solid #C5C5C5 !important;
}

.adwindow-south {
	border-left: none;
	border-right: none;
}

.adwindow-layout .z-south {
	border-top: 1px solid #C5C5C5 !important;
}

.adwindow-status {
	background-color: #F4F4F4;
	height: 20px;
}

.adwindow-toolbar {
	border: 0px;
}

.adwindow-breadcrumb {
	height: 30px;
	background-color: #FFF;
	padding-left: 2px;
}

.adwindow-detailpane {
	min-height: 200px; width: 100%; overflow-y: visible;
}

.adwindow-detailpane-toolbar {
	border: none;
}

.adwindow-detailpane-toolbar .z-toolbar-body {
	width: 100%;
}

.adwindow-detailpane-toolbar .z-toolbarbutton {
	float: left;
	display: inline-block;
}

.adwindow-detailpane-message {
	float: right;
}

.adwindow-detailpane-tabbox {
	min-height: 200px; width: 99%; margin: auto;
	background-color: #E4E4E4;
}

.adwindow-gridview-detail {
	height: 250px;
}

.adwindow-gridview-detail + .z-south-splt {
	border-top: 1px solid #C5C5C5;
}

.adwindow-gridview-detail .z-south-body {
	padding-top: 1px;
}

.adwindow-gridview-borderlayout {
	position: absolute; height: 100%; width: 100%;
}

<%-- ad tab --%>
.adtab-content {
	margin: 0;
	padding: 0;
	border: none;
	position: relative;
}

.adtab-form {
	border:none !important;
	margin:0;
	padding:0;
	overflow-y: visible;
}

.adtab-grid {
	margin-top: -1px;
	border: none !important;
}

.adtab-grid-south {
	border: none;
}

.adtab-grid-south .z-paging {
	border: none;
	padding: 0;
}

.adtab-form-borderlayout {
	width: 100%; 
	height: 100%; 
	position: absolute;
}

.current-row-indicator {
	background-color: #FA962F !important;
	background-image: none !important; 
}

<%-- status bar --%>
.status {
	width: 100%;
	height: 20px;
}

.status-db {
	padding-top: 0;
	pdding-bottom: 0;
	padding-left: 5px;
	padding-right: 5px;
	cursor: pointer;
	width: 100%;
	height: 100%;
	margin: 0;
	border-left: solid 1px #9CBDFF;
}

.status-info {
	padding-right: 10px;
	border-left: solid 1px #9CBDFF;
}

.status-border {
	border: solid 1px #9CBDFF;
}

.form-button {
	width: 99%;
}

<%-- Combobox --%>
.z-combobox-disd {
	color: black !important; cursor: default !important; opacity: 1; -moz-opacity: 1; -khtml-opacity: 1; filter: alpha(opacity=100);
}

.z-combobox-disd * {
	color: black !important; cursor: default !important;
}

.z-combobox-text-disd {
	background-color: #ECEAE4 !important;
}

<%-- Button --%>
.z-button-disd {
	color: black; cursor: default; opacity: .6; -moz-opacity: .6; -khtml-opacity: .6; filter: alpha(opacity=60);
}

<%-- highlight focus form element --%>
input:focus, textarea:focus, .z-combobox-inp:focus, z-datebox-inp:focus {
	border: 1px solid #0000ff;
}

.mandatory-decorator-text {
	text-decoration: none; font-size: xx-small; vertical-align: top; color:red;
}
<%-- menu tree cell --%>
.menu-treecell-cnt div {
	border: 0; margin: 0; padding: 0;
	font-family: ${fontFamilyC};
	font-size: ${fontSizeM}; 
	font-weight: normal;
    overflow-x: hidden;
    white-space: nowrap;
    text-overflow: ellipsis !important;
    cursor: pointer;
}

span.z-tree-tee, span.z-tree-last {
	width:0px;
} 

.z-west-colpsd {
	cursor: pointer;
}

<%-- FOCUSED FIELD in different color --%>

.z-textbox-focus, .z-textbox-focus input,
.z-decimalbox-focus, .z-decimalbox-focus input,
.z-intbox-focus, .z-intbox-focus input,
.z-longbox-focus, .z-longbox-focus input,
.z-doublebox-focus, .z-doublebox-focus input,
.z-combobox-focus .z-combobox-inp,
.z-checkbox-focus .z-checkbox-inp,
.z-datebox-focus .z-datebox-inp,
.z-timebox-focus .z-timebox-inp {
	background: #FFFFCC;
}

<%-- Editor --%>
.editor-box {
	display: inline-block;
	border: none; 
	padding: 0px; 
	margin: 0px; 
	background-color: transparent;
	width: 100%;
}

.editor-box table {
	border: none; 
	padding: 0px; 
	margin: 0px;
	width: 100%;
	border: none;
}

.editor-box tr {
	width: 100%; 
	border: none; 
	padding: 0px; 
	margin: 0px; 
	white-space:nowrap; 
}

.editor-box td {
	border: none; 
	padding: 0px; 
	margin: 0px;
}

.editor-box .z-textbox {
	display: inline; 
	width: 99%;
}

.editor-box .editor-button {
	width: 26px;
	padding: 0px;
}

.editor-box .editor-button img {
	vertical-align: middle;
	text-align: center;
}

.editor-box .editor-button-column {
	width: 28px !important;
}

.number-box {
	display: inline-block; white-space:nowrap;
}

.datetime-box {
	display: inline-block;
	white-space:nowrap;
}

.datetime-box .z-datebox {
	display: inline;
}

.datetime-box .z-timebox {
	display: inline;
}

<%-- Group --%>
tr.z-group {
	background: #E9F2FB repeat-x 0 0;
	background-image: url(../images/group_bg.gif) !important;
}

.z-group-inner .z-group-cnt .z-label, .z-group-inner .z-group-cnt {
	font-family: Helvetica,Arial,sans-serif;
}

<%-- Tablet --%>
.tablet-scrolling {
	-webkit-overflow-scrolling: touch;
}

<%-- Tab --%>
.z-tab-close {
	top:4px; 
	margin-right:2px;
}

.z-tab-hm-close {
	padding-right:18px;
}

<%-- set color for text and label --%>
.z-tab-seld .z-tab-text, .z-tab .z-tab-text, div.z-treefooter-cnt, div.z-treecell-cnt, div.z-treecol-cnt, 
.z-label, .z-toolbarbutton-cnt, tr.z-treerow, tr.z-treerow a, tr.z-treerow a:visited {
	color: #333;
	font-family: Helvetica,Arial,sans-serif;
}

.z-textbox-readonly, .z-intbox-readonly, .z-longbox-readonly, .z-doublebox-readonly, .z-decimalbox-readonly {
	background-color: #F0F0F0;
}

span.z-tab-text {
	height: 13px; 
}

<%-- menu tree cell --%>
div.z-tree-body td.menu-tree-cell {
	cursor: pointer;
	padding: 0 2px;
   	font-size: ${fontSizeM};
   	font-weight: normal;
   	overflow: visible;
}

div.menu-tree-cell-cnt {
	border: 0; margin: 0; padding: 0;
	font-family: ${fontFamilyC};
	font-size: ${fontSizeM}; font-weight: normal;
    white-space:nowrap
}

td.menu-tree-cell-disd * {
	color: #C5CACB !important; cursor: default!important;
}

td.menu-tree-cell-disd a:visited, td.menu-tree-cell-disd a:hover {
	text-decoration: none !important;
	cursor: default !important;;
	border-color: #D0DEF0 !important;
}

div.z-dottree-body td.menu-tree-cell {
	cursor: pointer; padding: 0 2px;
	font-size: ${fontSizeM}; font-weight: normal; overflow: visible;
}

div.z-filetree-body td.menu-tree-cell {
	cursor: pointer; padding: 0 2px;
	font-size: ${fontSizeM}; font-weight: normal; overflow: visible;
}

div.z-vfiletree-body td.menu-tree-cell {
	cursor: pointer; padding: 0 2px;
	font-size: ${fontSizeM}; font-weight: normal; overflow: visible;
}

div.simileAjax-bubble-container {
	z-index: 2800 !important;
}

.info-panel .z-grid {
	border: none !important;
}

.info-panel .z-center {
}

.info-panel .z-listbox {
	width: 99% !important;
	position: relative;
	margin: auto;
}

.info-panel .z-south {
	margin-top: 2px;
	border-top: 1px solid #C5C5C5;
	background-color: #D2E0EB;	
}

.info-panel .z-window-highlighted-cnt {
	padding: 0px;
}

.z-borderlayout, .z-north, .z-center, .z-south {
	border: none;
}

.z-window-embedded-cnt, .z-window-embedded-cm {
	border: none;
}

.z-window-embedded-tl, .z-window-embedded-tr, .z-window-embedded-hl, .z-window-embedded-hr, 
.z-window-embedded-hm, .z-window-embedded-cl, .z-window-embedded-cr, 
.z-window-embedded-bl, .z-window-embedded-br {
	background-image: none;
}

.z-modal-mask {
	z-index: 1800 !important;
}

.grid-layout {
	border: none !important; 
	margin: 0 !important; 
	padding: 0 !important;
	background-color: transparent !important;
}

.grid-layout .z-row-inner {
	border: none !important;
	background-color: transparent !important;
}

.grid-layout tr.z-row-over>td.z-row-inner {
	border: none !important;
}

.grid-layout tr.z-row-over>td.z-row-inner, .grid-layout tr.z-row-over>.z-cell {
	background-image: none !important;
}

.confirm-panel {
	width: 100%;
	height: 36px;
	position: relative;
}

.confirm-panel .z-hbox {
	margin: 2px;
}

.confirm-panel-right .z-button-os {
	margin-left: 3px;
}

.confirm-panel-left .z-button-os {
	margin-right: 3px;
}

.info-product-tabbedpane {
	background-color: #FFFFFF;
}

.field-label {
	position: relative; 
	float: right;
}

tbody.z-grid-empty-body td {
	text-align: left;
}

.z-notification .z-notification-cl, 
.z-notification .z-notification-cnt {
    width: 300px;
}

.z-toolbarbutton-ck {
	-webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, .1);
	-moz-box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, .1);
	background-color: #FFF;
	background-image: -webkit-linear-gradient(top,#FFF,#D0D0D0);
	background-image: -moz-linear-gradient(top,#FFF,#E0E0E0);
	background-image: -ms-linear-gradient(top,#FFF,#E0E0E0);
	background-image: -o-linear-gradient(top,#FFF,#E0E0E0);
	background-image: linear-gradient(top,#FFF,#E0E0E0);
	border: 1px solid #CCC;
	color: #333;
}
