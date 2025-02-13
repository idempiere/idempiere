<%-- Attachment Item --%>
.z-attachment-item {
	border: 1px solid #dcdcdc;
	border-radius: 4px;
	background-color: #f5f5f5;
	width: auto !important;
	display: inline-block;
	margin-right: 5px; 
	margin-bottom: 5px;
	padding-left: 5px;
	padding-right: 5px;
}

.z-attachment-item-del-button {
	float: right;
	background-color: #f5f5f5;
}

<%-- Combobox --%>
.z-combobox-disabled, .z-combobox[disabled] {
	color: rgba(0,0,0,0.7) !important; 
	cursor: default !important; 
}

.z-combobox-disabled > input {
	color: rgba(0,0,0,0.7) !important; 
	cursor: default !important;
}

.z-combobox-text-disabled {
	background-color: #ECEAE4 !important;
}
.z-comboitem {
	min-height:14px;
}
<%-- highlight focus form element --%>
input:focus, textarea:focus, .z-combobox-input:focus, z-datebox-input:focus, select:focus {
	background: #FFFFCC;
}

.z-textbox-readonly, .z-intbox-readonly, .z-longbox-readonly, .z-doublebox-readonly, 
.z-decimalbox-readonly, .z-datebox-readonly, .z-timebox-readonly, .editor-input-disd, 
.z-textbox[readonly], .z-intbox[readonly], .z-longbox[readonly], .z-doublebox[readonly], 
.z-decimalbox[readonly], .z-datebox[readonly], .z-timebox[readonly] {
	background-color: #F0F0F0;
}

.z-textbox[disabled], .z-intbox[disabled], .z-longbox[disabled], .z-doublebox[disabled], 
.z-decimalbox[disabled], .z-datebox[disabled], .z-timebox[disabled] {
	color: black !important;
	background-color: #F0F0F0 !important;
	cursor: default !important;
	opacity: 1 !important;
	border: 1px solid #ECECEC;
}

.z-textbox, .z-decimalbox, .z-intbox, .z-longbox, .z-doublebox,
.z-datebox-input, .z-datebox-button, .z-timebox-input, .z-timebox-button,
.z-combobox-input, .z-combobox-button {
	border: 1px solid #ECECEC;
}

<%-- workaround for http://jira.idempiere.com/browse/IDEMPIERE-692 --%>
.z-combobox-popup {
	max-height: 200px;
}

<%-- datebox --%>
.z-datebox {
	display: inline-flex;
  	align-items: center;
}
.z-datebox-input {
	padding-right: 5px;
	flex: auto;
}
.z-datebox-input:focus + .z-datebox-button {
  	border: none;
}
.z-datebox-button {
	border: none;
  	border-radius: 4px;
  	position: relative;
  	width: 24px;
  	min-width: 24px;
  	height: 24px;
  	min-height: 24px;  	
  	flex: auto;
  	color: #333;
  	padding: 0px;
}
.z-datebox-button:hover {
  	background-color: #7ac8ff !important;
}
.z-datebox-button > i {
	line-height: 24px;
	font-size: 14px;
}
.z-datebox-button:hover > i {
  	color: #fff;
}

.z-timebox {
  display: inline-flex;
}
.z-timebox-button>a>i {
	line-height: 12px;
	transform:translateY(-1px);
}

input[type="checkbox"]:checked {
    background-color: #7ac8ff;
}

<%-- focus indicator for checkbox --%>
input[type="checkbox"]:focus {
    border-color: #006AF9;
    color: #FFFF08;
}
.z-label {
	color: #333;
}