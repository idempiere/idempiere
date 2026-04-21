<%-- z-toolbar customization --%>
.toolbar {
	padding: 0px;
}

.toolbar-button {
	background-color: var(--zk-toolbar-button-background-color); 	
	margin-left: 1px; 
	margin-right: 1px; 
	width: 28px; 
	height: 28px;
	padding: 1px;
}
.toolbar-button .z-toolbarbutton-content {
	width: 24px;
	height: 24px;
	padding: 1px;
	border: none;	
}

<%-- toolbar button in overflow popup --%>
.toolbar-overflow-popup-vertical .toolbar-button, 
.toolbar-overflow-popup-vertical .toolbar-button .z-toolbarbutton-content {
	width: auto;
}

.depressed img {
	border-width: 1px;
	border-color: var(--zk-toolbar-depressed-border-color);
	background-color: var(--zk-toolbar-depressed-background-color);
	padding: 0px 1px 0px 1px;
}

.disableFilter img {
	opacity: 0.2;
	filter: progid : DXImageTransform . Microsoft . Alpha(opacity = 20);
	-moz-opacity: 0.2;
	background-color: var(--zk-toolbar-button-background-color);
}

.z-toolbar {
	padding: 4px 13px 4px 4px;
}

.z-toolbar.z-toolbar-tabs {
	padding-top: 0px;
	padding-bottom: 0px;
}
.z-toolbar-start{
	width:100%;
}
.z-toolbarbutton [class^="z-icon-"] {
	color: inherit;
}
.z-toolbarbutton.toolbarbutton-with-text [class^="z-icon-"] {
	padding-right: 4px;
}
.z-toolbarbutton.xlarge-toolbarbutton [class^="z-icon-"] {
	font-size: 24px;
}
.z-toolbarbutton.large-toolbarbutton [class^="z-icon-"] {
	font-size: 20px;
}
.z-toolbarbutton.medium-toolbarbutton [class^="z-icon-"] {
	font-size: 16px;
}
.z-toolbarbutton.small-toolbarbutton [class^="z-icon-"] {
	font-size: 12px;
}
.z-toolbarbutton {
	display: inline-flex;	
	align-items: center;
	color: var(--zk-toolbar-button-text-color);
	flex-shrink: 0;
}
.z-toolbarbutton .z-toolbarbutton-content {
	display: inline-flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}
.z-toolbar-content {
	display:flex;
	align-items: center;
}
.z-toolbar.space-between-content .z-toolbar-content {
	justify-content: space-between;
}
.z-toolbarbutton-checked {
	color: var(--zk-toolbar-button-checked-color) !important;
	background-color: var(--zk-toolbar-button-checked-background-color) !important;
}
.z-toolbarbutton[disabled], .z-toolbarbutton[disabled]:hover {
	background-color: var(--zk-toolbar-button-background-color);
}
.z-toolbarbutton:focus {
    color: var(--zk-toolbar-button-focus-text-color);
    background-color: var(--zk-toolbar-button-focus-background-color);
}

<%-- toolbar button with font icon --%>
@media screen and (max-width: 767px) {
	.font-icon-toolbar-button.toolbar-button [class^="z-icon-"] {
		font-size: 18px;
		color: inherit;
	}
}
@media screen and (min-width: 768px) {
	.font-icon-toolbar-button.toolbar-button [class^="z-icon-"] {
		font-size: 16px;
		color: inherit;
	}
}

.font-icon-toolbar-button.toolbar-button {
	color :var(--zk-toolbar-button-text-color);
}
.font-icon-toolbar-button.toolbar-button:hover {
	color: var(--zk-toolbar-button-checked-color);
	background-color: var(--zk-toolbar-button-checked-background-color);
}
.font-icon-toolbar-button.toolbar-button, .font-icon-toolbar-button.toolbar-button .z-toolbarbutton-content {
	display:inline-flex;
	align-items: center;
	justify-content: center; 
}
.font-icon-toolbar-button .z-toolbarbutton-content {
	color: inherit;
}
.font-icon-menuitem i {
	vertical-align: middle;
}
.toolbar-overflow-popup-vertical .font-icon-toolbar-button.toolbar-button, 
.toolbar-overflow-popup-vertical .font-icon-toolbar-button.toolbar-button .z-toolbarbutton-content {
	justify-content: flex-start;
}

.toolbar-searchbox {
    margin-right: 10px;
    margin-left: 10px;
    border: 1px;
}
@media screen and (max-width: 768px) {
  .toolbar-searchbox {
    display: none;
    width: 0px;
  }
}
