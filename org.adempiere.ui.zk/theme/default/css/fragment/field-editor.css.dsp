.mandatory-decorator-text {
	text-decoration: none; font-size: xx-small; vertical-align: top; color:red;
}

.editor-box {
	display: inline-block;
	border: none; 
	padding: 0px; 
	margin: 0px; 
	background-color: transparent;
	position: relative;
}

.editor-input {
	box-sizing: border-box;
	-moz-box-sizing: border-box; /* Firefox */
	display: inline-block;
	padding-right: 22px; 
	width: 100%;
	height: 21px;
}
.editor-input.mobile.z-decimalbox {
	padding-right: 5px;
}

.editor-input:focus {
	border: 1px solid #0000ff;
}

.editor-input-disd {
	padding-right: 0px !important;
}
	
.editor-button {
	padding: 0px;
	margin: 0px;
	display: inline-block;
	background-color: transparent;
	background-image: none;
	width: 20px;
	height: 22px;
	min-height: 22px;
	border: none;
	position: absolute;
	right: 1px;
	top: 2px;
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


.editor-box .grid-editor-input.z-textbox {
}

.grid-editor-button {
}

.grid-editor-button img {
}

.number-box {
	display: inline-block; 
	white-space:nowrap;
}

.number-box .grid-editor-input.z-decimalbox {
}

.datetime-box {
	white-space:nowrap;
}
.datetime-box .z-datebox {
}
.datetime-box .z-timebox {
}

span.grid-combobox-editor {
	width: 100% !important;
	position: relative;
}

.grid-combobox-editor input {
	width: 100% !important;
	padding-right: 26px;
	border-bottom-right-radius: 6px;
	border-top-right-radius: 6px;
	border-right: 0px;
}

.grid-combobox-editor.z-combobox-disabled input {
	border-bottom-right-radius: 3px;
	border-top-right-radius: 3px;
	border-right: 1px solid #cfcfcf;
	padding-right: 5px;
}

.grid-combobox-editor .z-combobox-button {
	position: absolute;
	right: 0px;
	top: 1px;
	border-bottom-right-radius: 3px;
	border-top-right-radius: 3px;
	border-bottom-left-radius: 0px;
	border-top-left-radius: 0px;
}

.grid-combobox-editor input:focus {
	border-right: 0px;
}
	
.grid-combobox-editor input:focus + .z-combobox-button {
	border-left: 1px solid #0000ff;
}

.editor-input.z-combobox + .editor-button {
	background-color: #F7F7F7;
	width: 22px;
    height: 24px;
    min-height: 24px;
    right: 0px;
    top: 1px;
    border: 1px solid #CFCFCF;
    border-radius: 0;
    border-left: 1px solid transparent;
}
.editor-input.z-combobox > .z-combobox-input {
	border-bottom-right-radius: 0;
	border-top-right-radius: 0;
}

<%-- payment rule --%>
.payment-rule-editor {
	display: inline-block;
	border: none; 
	padding: 0px; 
	margin: 0px; 
	background-color: transparent;
	position: relative;
}
.payment-rule-editor .z-combobox {
	width: 100%;
}
.payment-rule-editor .z-combobox-input {
	display: inline-block;
	padding-right: 44px; 
	width: 100%;
	height: 24px;
	border-bottom-right-radius: 6px;
	border-top-right-radius: 6px;
	border-right: 0px;
}
.payment-rule-editor .z-combobox-input:focus {
	border: 1px solid #0000ff;
}
.payment-rule-editor .z-combobox-input.editor-input-disd {
	padding-right: 22px !important;
}
.payment-rule-editor .z-combobox-button {
	position: absolute;
	right: 0px;
	top: 1px;
}
.payment-rule-editor .z-combobox .z-combobox-button-hover {
	background-color: #ddd;
	background-position: 0px 0px;
}
.payment-rule-editor .editor-button {
	border-radius: 0px;
	right: 24px;
}

<%-- chart --%>
.chart-field {
	padding: 10px; 
	border: 1px solid lightgray !important;
}

.field-label {
	position: relative; 
	float: right;
}

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
.image-fit-contain {
	object-fit: contain;
}
.z-cell.image-field-cell {
	z-index: 1;
}

.html-field {
	cursor: pointer;
	border: 1px solid #C5C5C5;
	overflow: auto;
}

.dashboard-field-panel.z-panel, .dashboard-field-panel.z-panel > .z-panel-body,  .dashboard-field-panel.z-panel > .z-panel-body > .z-panelchildren  {
	overflow: visible;
}

.idempiere-mandatory, .idempiere-mandatory input, .idempiere-mandatory a {
    border-color:red;
}

.idempiere-label {
    color: #333;
}

.idempiere-mandatory-label{
   color: red!important;
}

.idempiere-zoomable-label {
    cursor: pointer; 
    text-decoration: underline;
}