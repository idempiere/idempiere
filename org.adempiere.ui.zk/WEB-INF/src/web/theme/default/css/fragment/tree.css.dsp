<%@ taglib uri="http://www.zkoss.org/dsp/web/core" prefix="c" %>
.z-treecell-content {
	${fontFamilyC};
	${fontSizeM};
}

.z-treecell-content {
	padding: 2px 1px;
}

.tree-moveitem-btn {
	padding: 2px 4px; 
	border-radius: 3px;
}
.tree-moveitem-btn.pressed {
	box-shadow: inset 0 0 0 1px #efefef,inset 0 3px 15px #9f9f9f;
}

.z-treerow > .z-treecell > .z-treecell-content > .z-tree-line.z-tree-spacer:first-child {
	width:0px;
}
.z-treerow > .z-treecell > .z-treecell-content > .z-tree-line.z-tree-spacer + .z-tree-icon {
	width: 30px;
}
.z-treerow > .z-treecell > .z-treecell-content > .z-tree-line.z-tree-spacer + .z-tree-icon::before {
	content: " ";
	display: inline-block;
    width: 16px;
    height: 16px;
    line-height: 16px;
    vertical-align: middle;
}