<%-- Attachment Item --%>
.z-attachment-item {
	border: 1px solid var(--zk-input-element-attachment-border-color);
	border-radius: 4px;
	background-color: var(--zk-input-element-attachment-background-color);
	width: auto !important;
	display: inline-block;
	margin-right: 5px; 
	margin-bottom: 5px;
	padding-left: 5px;
	padding-right: 5px;
}

.z-attachment-item-del-button {
	float: right;
	background-color: var(--zk-input-element-attachment-background-color);
}

<%-- Combobox --%>
.z-combobox-disabled, .z-combobox[disabled] {
	color: var(--zk-input-element-combobox-disabled-color) !important; 
	cursor: default !important; 
}

.z-combobox-disabled > input {
	color: var(--zk-input-element-combobox-disabled-color) !important; 
	cursor: default !important;
}

.z-combobox-text-disabled {
	background-color: var(--zk-input-element-combobox-text-disabled-background-color) !important;
}
.z-comboitem {
	min-height:14px;
}
<%-- highlight focus form element --%>
input:focus, textarea:focus, .z-combobox-input:focus, z-datebox-input:focus, select:focus {
	background: var(--zk-input-element-focus-background-color);
}

.z-textbox-readonly, .z-intbox-readonly, .z-longbox-readonly, .z-doublebox-readonly, 
.z-decimalbox-readonly, .z-datebox-readonly, .z-timebox-readonly, .editor-input-disd, 
.z-textbox[readonly], .z-intbox[readonly], .z-longbox[readonly], .z-doublebox[readonly], 
.z-decimalbox[readonly], .z-datebox[readonly], .z-timebox[readonly] {
	background-color: var(--zk-input-element-readonly-background-color);
}

.z-textbox[disabled], .z-intbox[disabled], .z-longbox[disabled], .z-doublebox[disabled], 
.z-decimalbox[disabled], .z-datebox[disabled], .z-timebox[disabled] {
	color: var(--zk-input-element-disabled-color) !important;
	background-color: var(--zk-input-element-readonly-background-color) !important;
	cursor: default !important;
	opacity: 1 !important;
	border: 1px solid var(--zk-input-element-border-color);
}

.z-textbox, .z-decimalbox, .z-intbox, .z-longbox, .z-doublebox,
.z-datebox-input, .z-datebox-button, .z-timebox-input, .z-timebox-button,
.z-combobox-input, .z-combobox-button {
	border: 1px solid var(--zk-input-element-border-color);
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
  	color: var(--zk-input-element-datebox-button-color);
  	padding: 0px;
}
.z-datebox-button:hover {
  	background-color: var(--zk-input-element-hover-background-color) !important;
}
.z-datebox-button > i {
	line-height: 24px;
	font-size: 14px;
}
.z-datebox-button:hover > i {
  	color: var(--zk-input-element-hover-icon-color);
}

.z-timebox {
  display: inline-flex;
}
.z-timebox-button>a>i {
	line-height: 12px;
	transform:translateY(-1px);
}

input[type="checkbox"]:checked {
	background-color: var(--zk-input-element-hover-background-color);
}

<%-- focus indicator for checkbox --%>
input[type="checkbox"]:focus {
	border-color: var(--zk-input-element-checkbox-focus-border-color);
	color: var(--zk-input-element-checkbox-focus-color);
}
.z-label {
	color: var(--zk-input-element-label-color);
}