<%-- customization of buttons --%>
.z-button, .z-button-os {
  display: inline-block;
  padding: 4px 20px;
  text-align: center;
  cursor: pointer;
}
.z-button-os {
	border-radius: 4px;
}
.z-button-os:hover {
    color: #FFFFFF;
    border-color: transparent;
    background-color: #7ac8ff;
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

.txt-btn img, .small-img-btn img {
	height: 16px;
	width: 16px;
	background-color: transparent;
	vertical-align: middle;
	display: inline-block;
}

.btn-sorttab {
	box-shadow: 0px 0px 4px #bbb;
	color: #555;
	border: solid 1px #bbb;
	text-shadow: 0px 1px 2px #888;
}

.z-button [class^="z-icon-"][disabled],
.z-button-os [class^="z-icon-"][disabled]{
	font-size: larger;
	color: #333;	
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
.btn-ok, .btn-ok:focus {
	background-color: green;
}
.btn-cancel, .btn-cancel:focus {
	background-color: red;
}
.btn-ok.z-button [class^="z-icon-"]:before {
	color: white;	
}
.btn-cancel.z-button [class^="z-icon-"]:before {
	color: white;	
}

.z-combobox-button, .z-bandbox-button, .z-datebox-button, .z-timebox-button,
 .z-spinner-button, .z-doublespinner-button {
	vertical-align: top;
}
.z-bandbox-button [class*="z-icon-"], .z-combobox-button [class*="z-icon-"] {
	font-size: 18px;
}
