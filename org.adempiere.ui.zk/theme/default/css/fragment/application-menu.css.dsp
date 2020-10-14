<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>

.menu-href {
	font-size: 11px;
	font-weight: normal;
	color: #333 !important;
	text-decoration: none !important;
	padding-right: 4px;
}

.menu-href:hover, .menu-href:active {
	text-decoration: underline !important;
	color: blue !important;
}

.menu-href img {
	padding: 2px;
	padding-right: 4px;
	width: 16px;
	height: 16px;
}

.menu-href-newbtn {
	height: 17px;
	line-height: 10px;
	padding: 1px 1px;
	padding-bottom: 2px;
	padding-left: 2px;
	margin-bottom: 2px;
}

.menu-href-newbtn img {
	width: 10px;
	height: 10px;
}

.menu-href-newbtn .z-toolbarbutton-content {
	height: 10px;
	width: 10px;
	display: inline-block;
	line-height: 10px;
}

.tree-search-combo .z-comboitem-img img {
	width: 16px;
	height: 16px;
}

.menu-search-panel .z-comboitem-image { 
	padding-bottom:4px; 
}

.menu-search-panel-container .z-panel-body {
	background-color: transparent;
}

.menu-search-panel-container .z-panel-top .z-toolbar.z-toolbar-panel {
	padding-bottom: 0px;
	padding-top: 8px;
}

.menu-panel .z-toolbar-panel {
	padding-right: 0;
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

.menu-search-toggle-box {
	display: inline-block;
	border: 1px solid #ababab;			
}

.menu-search-toggle-box .z-toolbarbutton-hover {
	border: none;
}

.menu-search-toggle-off {
	margin:0px; 
	padding: 1px 4px 1px 4px;
	border-radius: 0px;
}

.menu-search-toggle-on {
	background: #999999 !important;
	-webkit-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3) inset !important;
	box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3) inset !important;
	margin:0px !important;
	padding: 1px 4px 1px 4px !important;
	border-radius: 0px;
}

.menu-search-toggle-on img, .menu-search-toggle-off img {
	height: 16px;
	width: 16px;
} 

.document-search-current-link {
	background-image:url(${c:encodeThemeURL('~./zul/img/tree/item-sel.gif')});
}

.global-search-box.z-bandbox > .z-bandbox-button {
	width: 24px;
}
.global-search-tabpanel {
	width: 600px;
}
@media screen and (max-width: 649px) {
	.global-search-box.z-bandbox-popup {
		width: 90% !important;
	}
	.global-search-tabpanel {
		width: 100%;
	}
}
.global-search-box.z-bandbox {
	width: 180px;
}
.global-search-box.z-bandbox > input.z-bandbox-input {
	width: 180px;
}
@media screen and (min-width: 500px) {
	.global-search-box.z-bandbox {
		width: 200px;
	}
	.global-search-box.z-bandbox > input.z-bandbox-input {
		width: 200px;
	}
}
@media screen and (min-width: 768px) {
	.global-search-box.z-bandbox {
		width: 250px;
	}
	.global-search-box.z-bandbox > input.z-bandbox-input {
		width: 250px;
	}
}
@media screen and (min-width: 1024px) {
	.global-search-box.z-bandbox {
		width: 300px;
	}
	.global-search-box.z-bandbox > input.z-bandbox-input {
		width: 300px;
	}
}

.menu-href [class^="z-icon-"] {
	font-size: larger;
	color: #333;	
	padding-right: 4px;
	text-align: center;
}
.menu-href [class^="z-icon-"]:before {
	width: 14px;
}
.menu-href-newbtn.z-toolbarbutton [class^="z-icon-"] {
	font-size: smaller;
	color: #333;
}
.menu-href-newbtn.z-toolbarbutton,
.menu-href-newbtn.z-toolbarbutton .z-toolbarbutton-content {
	justify-content: center;
	align-items: center;
	display: inline-flex;
}

.menu-search-list-toolbar-cell.z-listcell > div.z-listcell-content {
	display: inline-flex; 
	align-items: center;
	justify-content: center;
}
.menu-search-list-toolbar-cell.z-listcell .fav-new-btn.z-toolbarbutton [class^="z-icon-"] {
	font-size: larger;
}

.z-menu-noimage.z-menupopup .z-menu-content > img.z-menu-image {
	display: none;
}
.z-menu-noimage.z-menupopup .z-menuitem-content > img.z-menuitem-image {
	display: none;
}
.z-menu-noimage.z-menupopup > .z-menupopup-separator {
	display: none;
}

