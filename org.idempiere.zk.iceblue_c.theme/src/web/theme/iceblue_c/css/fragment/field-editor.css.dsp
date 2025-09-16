<%-- container for input field and button --%>
.editor-box {
	display: inline-flex;
	padding: 0px; 
	margin: 0px; 
	position: relative;
	align-items: center;
}

<%-- input field --%>
.editor-input {
	box-sizing: border-box;
	-moz-box-sizing: border-box; /* Firefox */
	display: inline-block;	 
	width: 100%;
	flex: auto;
}
.editor-input.mobile.z-decimalbox {
	padding-right: 5px;
}

<%-- button for field --%>
.editor-button {
	padding: 0px;
	margin: 0px;
	display: inline-block;	
	background-color: transparent;
	background-image: none;
	width: 24px;
	min-width: 24px;
	height: 24px;
	min-height: 24px;	
	border: none;
	box-shadow: none;
	flex: auto;
}
.z-button.editor-button > i,
.z-button-os.editor-button > i {
	color: #333;
}
.z-button.editor-button:hover > i,
.z-button-os.editor-button:hover > i {
  color: #fff;
}
.editor-button :hover {
	-webkit-filter: contrast(1.5);
	filter: contrast(150%);
}
.editor-button img {
	vertical-align: top;
	text-align: left;
	width: 18px;
	height: 18px;
	padding: 1px 1px;
}

<%-- chosen box --%>
.z-chosenbox {
	background-image: none;
}
.z-chosenbox:has(> input:focus) {
  background: #FFFFCC !important;
  border-color: #0093F9 !important;
}
<%-- include/exclude icon for chosenbox --%>
.editor-box + .btn-negate.z-button > .z-icon-ExcludeSelected::before,
.editor-box + .btn-negate.z-button > .z-icon-IncludeSelected::before {
	color: #333;
}
.editor-box + .btn-negate.z-button {
	background: none;
	border: none;
	margin: 0px !important;
	padding: 0px;
	min-width: 16px;
	width: 16px;	
	height: 10px;
	min-height:10px;
	font-size: 14px;
	font-weight: lighter;		
	position: absolute;
	top: 4px;
	right: 30px;
	z-index: 2000;
}
.editor-box + .btn-negate.z-button, 
.editor-box + .btn-negate.z-button:focus {
	border: none;
	box-shadow: none;	
}
.editor-box + .btn-negate.z-button [class^="z-icon-"] {
	font-size: 14px;
	padding: 0px;
	line-height: 14px;
}

<%-- datetime box --%>
.datetime-box {
	display: flex;
	flex-wrap: wrap;
}

<%-- combobox editor in grid view --%>
span.grid-combobox-editor {
	width: 100% !important;
	position: relative;
}
.grid-combobox-editor input {
	width: 100% !important;
	padding-right: 26px;
	border-right: 0px;
}
.grid-combobox-editor.z-combobox-disabled input {
	padding-right: 5px;
}
.grid-combobox-editor .z-combobox-button {
	position: absolute;
	right: 0px;
}
.grid-combobox-editor input:focus {
	border-right: 0px;
}
	
.grid-combobox-editor input:focus + .z-combobox-button {
	border-left: 1px solid #0000ff;
}

<%-- payment rule --%>
.payment-rule-editor {
	display: inline-flex;
	padding: 0px; 
	margin: 0px; 
	position: relative;
}
.payment-rule-editor .z-combobox {
	width: 100%;
}
.payment-rule-editor .z-combobox-input {
	display: inline-block;
	padding-right: 44px; 
	width: 100%;
}
.payment-rule-editor .z-combobox-input.editor-input-disd {
	padding-right: 22px !important;
}
.payment-rule-editor .z-combobox-button {
	position: absolute;
	right: 0px;
}
.payment-rule-editor .z-combobox .z-combobox-button-hover {
	background-position: 0px 0px;
}
.payment-rule-editor > .editor-button {
	border-radius: 0px;
	right: 24px;
	border: none;
  	top: 3px;
  	min-height: 20px;
}

<%-- chart --%>
.chart-field {
	padding: 10px; 
}

<%-- image field --%>
.image-field {
	cursor: pointer;
	border: 1px solid #C5C5C5;
	height: 24px;
	width: 24px;
}
.image-field.image-field-readonly {
	cursor: default;
	border: none;
}
.image-fit {
	object-fit: scale-down;
}
.z-cell.image-field-cell {
	z-index: 1;
}

<%-- html field --%>
.html-field {
	cursor: pointer;
	overflow: auto;
	border: 1px solid #ECECEC;
	border-radius: 4px;
}
.html-field:hover {
	border-color: #A8A8A8;
}
.html-field:focus {
	border-color: #0093F9;
}

<%-- dashboard content editor --%>
.dashboard-field-panel.z-panel, .dashboard-field-panel.z-panel > .z-panel-body,  .dashboard-field-panel.z-panel > .z-panel-body > .z-panelchildren  {
	overflow: visible;
}

<%-- field label --%>
.field-label {
	position: relative; 
	float: right;
}
.mandatory-decorator-text {
	text-decoration: none; font-size: xx-small; vertical-align: top;
}

.idempiere-mandatory, .idempiere-mandatory input, .idempiere-mandatory a {
    border-color:red;
}

.idempiere-mandatory-label{
   color: red!important;
}

.idempiere-zoomable-label {
    cursor: pointer; 
    text-decoration: underline;
}

<%-- range button for datebox --%>
.z-toolbarbutton:has(> span > i.z-icon-History) {
	padding: 2px;
    min-width: 24px;
    border: none;
}
.z-toolbarbutton:has(> span > i.z-icon-History):hover {
	background-color: #7ac8ff !important;
}
.date-picker-calendar-button {
    position: absolute;
    right: 0px;
    top: 5px;
}
<%-- date range editor --%>
.date-picker-container {
	padding-left: 5px;
}
.date-picker-component {
	display: inline-grid;
	min-height: 25px;
	border-radius: 5px;
	margin: 0px 5px 5px 0px !important;
}
.date-picker-component .z-listbox {
	border: none;
}
.date-picker-label {
	font-weight: bold;
	margin: 5px;
}

<%-- record id editor --%>
.recordid-editor {
  display: inline-flex;
  position: relative;
  align-items: center;
}
.recordid-editor > input {
  flex: auto;
}
.recordid-editor .z-toolbarbutton {
    margin: 0px;
    background-image: none;
    position: relative;
    width: 24px;
    min-width: 24px;
    height: 24px;
    min-height: 24px;
    right: auto !important;
    padding: 0px;
    flex: auto;
}
.recordid-editor .z-toolbarbutton:hover {
	background-color: #7ac8ff
}

<%-- font icon for field button --%>
.z-button [class^="z-icon-"], .z-button-os [class^="z-icon-"] {
	color: #fff;
}

<%-- full size image hover --%>
.fullsize-image {
	padding: 5px;
  	border: 1px solid #ccc;
  	background: #e3f4f9;
}
