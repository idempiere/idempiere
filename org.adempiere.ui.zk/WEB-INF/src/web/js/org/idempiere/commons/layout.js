if (typeof window.idempiere === 'undefined')
	window.idempiere = {};
	
window.idempiere.scrollToRow = function(uuid){
	try {
		var cmp = zk.Widget.$(uuid);  	 
		if (cmp) {
			cmp.scrollIntoView();
		 	cmp.focus();
		}
	} catch (err) {
		if (console) console.log(err);
	}
};

//overload for recalculate width of grid frozen scroll
window.idempiere.syncScrollFrozen = function(wgt){
	var parent = wgt.parent;
	
	if (parent.eheadtbl && parent._nativebar) {
		var scroll = wgt.$n('scrollX');
		var cells = parent._getFirstRowCells(parent.eheadrows);
		var frozens = wgt._columns;
		
		var frozenWidth = 0; 
		for (var i = 0; i < frozens; i++)
			frozenWidth += cells[i].offsetWidth;
		
		var bodyWidth = parent.$n('body').offsetWidth;
		var availableWidth = bodyWidth - frozenWidth;
		var totalWidth = 0;
		var toScroll = 0;
		for (var i = frozens; i < cells.length; i++){
			totalWidth += cells[i].offsetWidth;
		}
		for (var i = frozens; i < cells.length; i++){
			totalWidth -= cells[i].offsetWidth;
			toScroll++;
			if (totalWidth <= availableWidth) {
				break;
			}
		}
		
		if (toScroll > 0)
			scroll.firstChild.style.width = jq.px0(availableWidth+(toScroll * 50));
	}
	
	wgt.$syncScroll ()
}