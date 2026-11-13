<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>
.z-grid tbody tr.grid-inactive-row td.z-cell {
	background-image: none !important;
	background-color: #DCDAD4 !important;
}

.z-grid tbody tr.grid-inactive-row td.row-indicator-selected {
	background-color: #DCDAD4 !important;
	background-image: url(${c:encodeURL('~./theme/default/images/EditRecord16.png')}) !important;
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
	background-image: url(${c:encodeURL('~./theme/default/images/EditRecord16.png')}) !important;
	background-position: center;
	background-repeat: no-repeat;
	background-size: 16px 16px;  
	cursor: pointer;
}

.z-grid tbody tr.highlight td.row-indicator {
	background-color: transparent !important;
	background-image: none !important; 
}

div.z-column-cnt, div.z-grid-header div.z-auxheader-cnt {
	padding: 4px 2px 3px;
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
	padding: 2px 3px 1px;
}

.z-grid-body .z-cell {
	padding: 2px 3px;
}

.z-row .z-cell, .z-listitem .z-listcell, .z-listitem.z-listitem-selected>.z-listcell {
	border-left: 1px solid #cfcfcf;
}

.z-grid-emptybody td {
	text-align: left;
}

.z-grid-body {
	background-color: #FFF;
}

<%-- grid layout --%>
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
.grid-layout tr.z-row:hover>td.z-row-inner, .grid-layout tr.z-row:hover>.z-cell {
	border: none !important;
}
.grid-layout tr.z-row:hover>td.z-row-inner, .grid-layout tr.z-row:hover>.z-cell {
	background-image: none !important;
}

tbody.z-grid-empty-body td {
	text-align: left;
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

<%-- frozen scrolling --%>
.z-grid-header th.z-frozen-sticky,
.z-listbox-header th.z-frozen-sticky {
	position: sticky !important;
	z-index: 3 !important;
	background-clip: padding-box;
	box-sizing: border-box;
}
.z-grid-body td.z-frozen-sticky,
.z-listbox-body td.z-frozen-sticky,
.z-grid-footer td.z-frozen-sticky,
.z-listbox-footer td.z-frozen-sticky {
	position: sticky !important;
	z-index: 2 !important;
	background-color: var(--zk-grid-background-color, #FFFFFF);
	background-clip: padding-box;
	box-sizing: border-box;
}
<%-- Ensure sticky cells always carry an opaque background matching their row state
     (odd, selected, hovered, highlighted) so scrolled cells underneath never bleed through --%>
.z-grid-body tr.z-grid-odd > td.z-frozen-sticky,
.z-listbox-body tr.z-listbox-odd > td.z-frozen-sticky {
	background-color: var(--zk-grid-odd-background-color, #F7F7F7);
}
.z-listbox-body tr.z-listitem.z-listitem-selected > td.z-frozen-sticky {
	background-color: var(--zk-listitem-selected-background-color, #E8F6FD);
}
.z-grid-body tr.z-row:hover > td.z-frozen-sticky,
.z-listbox-body tr.z-listitem:hover > td.z-frozen-sticky {
	background-color: var(--zk-row-hover-background-color, #F0F9FF);
}
.z-listbox-body tr.z-listitem.z-listitem-selected:hover > td.z-frozen-sticky {
	background-color: var(--zk-listitem-selected-hover-background-color, var(--zk-listitem-selected-background-color, #DCF0FA));
}
.z-grid tbody tr.highlight > td.z-frozen-sticky,
.z-grid tbody tr.highlight td.row-indicator.z-frozen-sticky {
	background-color: var(--zk-grid-highlight-background-color, #FFFFCC);
}
.z-frozen-sticky-last {
	border-right: 1px solid var(--zk-grid-header-border-color, #CFCFCF) !important;
	box-shadow: 2px 0 4px -2px rgba(0, 0, 0, 0.12);
}
.z-frozen-sticky-next,
.z-grid-header th.z-frozen-sticky-last + th,
.z-listbox-header th.z-frozen-sticky-last + th,
.z-grid-body td.z-frozen-sticky-last + td,
.z-listbox-body td.z-frozen-sticky-last + td,
.z-grid-footer td.z-frozen-sticky-last + td,
.z-listbox-footer td.z-frozen-sticky-last + td {
	border-left: none !important;
}
<%-- only the horizontal scrollbar is hidden (ZK already sets overflow-x: hidden on desktop,
     this covers mobile where it does not). scrollbar-width would hide both axes. --%>
.z-grid:has(> .z-frozen) > .z-grid-body::-webkit-scrollbar:horizontal,
.z-listbox:has(> .z-frozen) > .z-listbox-body::-webkit-scrollbar:horizontal {
	display: none;
	height: 0;
}
