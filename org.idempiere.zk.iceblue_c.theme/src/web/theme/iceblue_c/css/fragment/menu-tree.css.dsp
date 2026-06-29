<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
<%@ taglib uri="http://www.idempiere.org/dsp/web/util" prefix="u" %>
.menu-treecell-cnt {
	border: 0; margin: 0; padding: 0;
	${fontFamilyC};
	${fontSizeM}; 
	font-weight: normal;
    overflow-x: hidden;
    white-space: nowrap;
    text-overflow: ellipsis !important;
    cursor: pointer;
}

div.z-tree-body td.menu-tree-cell {
	cursor: pointer;
	padding: 0 2px;
   	${fontSizeM};
   	font-weight: normal;
   	overflow: visible;
}

div.menu-tree-cell-cnt {
	border: 0; margin: 0; padding: 0;
	${fontFamilyC};
	${fontSizeM}; 
	font-weight: normal;
    white-space:nowrap
}

td.menu-tree-cell-disd * {
	color: var(--zk-menu-tree-disabled-color) !important; cursor: default!important;
}

td.menu-tree-cell-disd a:visited, td.menu-tree-cell-disd a:hover {
	text-decoration: none !important;
	cursor: default !important;
	border-color: var(--zk-menu-tree-disabled-border-color) !important;
}

div.z-dottree-body td.menu-tree-cell {
	cursor: pointer; padding: 0 2px;
	${fontSizeM}; 
	font-weight: normal; overflow: visible;
}

div.z-filetree-body td.menu-tree-cell {
	cursor: pointer; padding: 0 2px;
	${fontSizeM}; 
	font-weight: normal; overflow: visible;
}

div.z-vfiletree-body td.menu-tree-cell {
	cursor: pointer; padding: 0 2px;
	${fontSizeM}; 
	font-weight: normal; overflow: visible;
}
