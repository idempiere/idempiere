<%-- Combobox --%>
.z-combobox-disabled {
	color: black !important; cursor: default !important; opacity: 1; -moz-opacity: 1; -khtml-opacity: 1; filter: alpha(opacity=100);
}

.z-combobox-disabled * {
	color: black !important; cursor: default !important;
}

.z-combobox-text-disabled {
	background-color: #ECEAE4 !important;
}

<%-- highlight focus form element --%>
input:focus, textarea:focus, .z-combobox-input:focus, z-datebox-input:focus {
	border: 1px solid #0000ff;
}

<%-- FOCUSED FIELD in different color --%>

.z-textbox-focus, .z-textbox-focus input,
.z-decimalbox-focus, .z-decimalbox-focus input,
.z-intbox-focus, .z-intbox-focus input,
.z-longbox-focus, .z-longbox-focus input,
.z-doublebox-focus, .z-doublebox-focus input,
.z-combobox-focus .z-combobox-input,
.z-checkbox-focus .z-checkbox-input,
.z-datebox-focus .z-datebox-input,
.z-timebox-focus .z-timebox-input {
	background: #FFFFCC;
}

.z-textbox-readonly, .z-intbox-readonly, .z-longbox-readonly, .z-doublebox-readonly, 
.z-decimalbox-readonly, .z-datebox-readonly, .z-timebox-readonly, .editor-input-disd {
	background-color: #F0F0F0;
}

<%-- workaround for http://jira.idempiere.com/browse/IDEMPIERE-692 --%>
.z-combobox-popup {
	max-height: 200px;
}

