<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>
<%-- z-grid customization --%>
.z-grid .z-column, .z-listheader {
	background-color: #e0f2ff;
	border-left: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}

.z-grid-header {
	background-color: #e0f2ff;
}

.z-grid tbody tr.grid-inactive-row td.z-cell {
	background-image: none !important;
}
.z-grid tbody tr.grid-inactive-row td.row-indicator-selected {
	background-image: url(${c:encodeURL('~./theme/iceblue_c/images/EditRecord16.png')}) !important;
	background-position: center;
	background-repeat: no-repeat;
	background-size: 16px 16px;  
	cursor: pointer;
}
.z-grid tbody tr.grid-inactive-row span.row-indicator-selected.z-icon-Edit,
.z-grid tbody tr.highlight span.row-indicator-selected.z-icon-Edit {
	font-family: FontAwesome;
	font-size: larger;
	color: #333; 
}
.z-grid tbody tr.highlight td.z-cell { 
	background-color: #FFFFCC !important;
	background-image: none !important;
}
.z-grid tbody tr.highlight td.row-indicator-selected {
	background-color: #FFFFCC !important;
	background-image: url(${c:encodeURL('~./theme/iceblue_c/images/EditRecord16.png')}) !important;
	background-position: center;
	background-repeat: no-repeat;
	background-size: 16px 16px;  
	cursor: pointer;
}
.z-grid tbody tr.highlight td.row-indicator {
	background-color: transparent !important;
	background-image: none !important; 
}
tbody.z-grid-empty-body td {
	text-align: left;
}
.z-grid-emptybody td {
	text-align: left;
}
.z-grid-body {
	background-color: #FFF;
}
div.z-column-cnt, div.z-grid-header div.z-auxheader-cnt {
	padding: 4px 2px 3px;
}
.z-grid-body .z-cell {
	padding: 2px 3px;
}

<%-- text overflow for grid cell --%>
.z-cell > span.z-label {
	overflow: hidden;
	text-overflow: ellipsis;
	display: inline-block;
	width: 100%;
	vertical-align: middle;
}
.z-listcell > div.z-listcell-content {
	overflow: hidden;
	text-overflow: ellipsis;
	display: inline-block;
	width: 100%;
}
@media only screen 
  and (max-device-width: 700px) {
	.z-listcell > div.z-listcell-content {
		white-space: pre-line;
	}	
}
.z-column-content, .z-listheader-content, .z-listcell-content {
	color: #333;
	padding: 2px 3px 1px;
}

.z-column-content:hover, .z-listheader-content:hover, .z-listcell-content:hover {
	color: #000;
}

.z-listheader-sort .z-listheader-content:active, .z-column-sort .z-column-content:active  {
    background: #C7E8FF;
    color: #000;
}

.z-column-sort .z-column-sorticon, .z-listheader-sort .z-listheader-sorticon {
	color: #333;
}

<%-- grid layout for form --%>
.grid-layout {
	border: none !important; 
	margin: 0 !important; 
	padding: 0 !important;
	background-color: transparent !important;
}
.grid-layout .z-row-inner, .grid-layout .z-cell {
	border: none !important;
	background-color: transparent !important;
}
.grid-layout tr.z-row-over>td.z-row-inner, .grid-layout tr.z-row-over>.z-cell {
	border: none !important;
}
.grid-layout tr.z-row-over>td.z-row-inner, .grid-layout tr.z-row-over>.z-cell {
	background-image: none !important;
}

<%-- z-listbox customization --%>
.z-listbox-header {
	background-color: #e0f2ff;
	border-left: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}
tbody.z-listbox-empty-body td {
	text-align: left;
}
div.z-listbox-body .z-listcell {
	padding: 2px;
}
.z-listbox-autopaging .z-listcell-cnt {
	height: 20px;
}
.z-row .z-cell, .z-listitem .z-listcell, .z-listitem.z-listitem-selected>.z-listcell {
	border-left: 1px solid #cfcfcf;
}
.z-row .z-cell, .z-listitem .z-listcell:first-child, 
.z-listitem.z-listitem-selected > .z-listcell:first-child {
	border-left: none;
}
.z-listcell-content:has(> .z-listitem-checkbox) {
    padding: 2px 4px 1px 1px;
}

<%-- color editor --%>
div.grid-view-color-fieldtype-display {
	height: 20px;
	display: flex;
	align-items: center;
	justify-content: center;
}

div.grid-view-color-fieldtype-display > div {
	width: 95%;
	height: 80%;
}
