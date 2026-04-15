<%-- customization of buttons --%>
.z-button, .z-button-os {
  display: inline-flex;
  align-items: center;
  padding: 4px 20px;
  justify-content: center;
  cursor: pointer;
  gap: 5px;
}
.z-button-os {
	border-radius: 4px;
}
.z-button-os:hover {
	color: var(--zk-button-os-hover-color);
    border-color: transparent;
	background-color: var(--zk-button-os-hover-background-color);
}

.z-button:focus {
	border-color: var(--zk-button-focus-border-color-local);
}

.z-button.btn-small {
	padding: 1px 5px;
}
.z-button.btn-medium {
	padding: 2px 10px;
}

.img-btn img {
	height: 22px;
	width: 22px;
	background-color: transparent;
}

.txt-btn img, .small-img-btn img, .img-txt-btn img {
	height: 16px;
	width: 16px;
	background-color: transparent;
	vertical-align: middle;
	display: inline-block;
}

.btn-sorttab {
	box-shadow: 0px 0px 4px var(--zk-button-sorttab-shadow-color);
	color: var(--zk-button-sorttab-color);
	border: solid 1px var(--zk-button-sorttab-border-color);
	text-shadow: 0px 1px 2px var(--zk-button-sorttab-text-shadow-color);
}

.btn-cancel, .btn-help {
	background: var(--zk-button-cancel-background-color);
	color: var(--zk-button-cancel-color);
}

.btn-cancel:hover, .btn-help:hover {
	background: var(--zk-button-cancel-hover-background-color);
	color: var(--zk-button-cancel-hover-color);
}

.z-icon-Help, .z-icon-Cancel {
	color: var(--zk-button-cancel-color) !important;
}

.z-button [class^="z-icon-"][disabled],
.z-button-os [class^="z-icon-"][disabled]{
	font-size: larger;
	color: var(--zk-button-disabled-icon-color);	
	padding-left: 2px;
	padding-right: 2px;
}
.z-button.xlarge-toolbarbutton [class^="z-icon-"] {
	font-size: 24px;
}
.z-button.large-toolbarbutton [class^="z-icon-"] {
	font-size: 20px;
}
.z-button.medium-toolbarbutton [class^="z-icon-"] {
	font-size: 16px;
}
.z-button.small-toolbarbutton [class^="z-icon-"] {
	font-size: 12px;
}
.btn-ok.z-button [class^="z-icon-"]:before {
	color: var(--zk-button-ok-icon-color);	
}

.z-combobox-button, .z-bandbox-button, .z-datebox-button, .z-timebox-button,
 .z-spinner-button, .z-doublespinner-button {
	vertical-align: top;
}
.z-bandbox-button [class*="z-icon-"], .z-combobox-button [class*="z-icon-"] {
	font-size: 16px;
}

.mobile .login-btn {
    font-size: 0px !important;
}