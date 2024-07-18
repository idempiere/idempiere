<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
<%-- z-tree customization --%>
.z-treecell-content {
	${fontFamilyC};
	${fontSizeM};
}
.z-treecell-content {
	padding: 2px 1px;
}
.z-treecell-content > .menu-href.z-a {
	margin-left: 8px;
}

div.z-treefooter-content, div.z-treecell-content, div.z-treecol-content, 
tr.z-treerow, tr.z-treerow a, tr.z-treerow a:visited {
	color: #333;
}

<%-- move tree item button (mobile only) --%>
.tree-moveitem-btn {
	padding: 2px 4px; 
	border-radius: 3px;
}
.tree-moveitem-btn.pressed {
	box-shadow: inset 0 0 0 1px #efefef,inset 0 3px 15px #9f9f9f;
}
