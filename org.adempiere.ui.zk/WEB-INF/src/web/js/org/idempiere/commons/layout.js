if (typeof window.idempiere === 'undefined')
	window.idempiere = {};
	
window.idempiere.scrollToRow = function(uuid){
	try {
		let cmp = zk.Widget.$(uuid);  	 
		if (cmp) {
			cmp.scrollIntoView();
		 	cmp.focus();
		}
	} catch (err) {
		if (console) console.log(err);
	}
};

//overload for recalculate width of grid frozen scroll
//base on _onSizeLater(wgt) from Frozen.js
window.idempiere.syncScrollFrozen = function(wgt){
	let parent = wgt.parent;	
	if (parent.eheadtbl && parent._nativebar) {
		let cells = parent._getFirstRowCells(parent.eheadrows),
			head = parent.head,
			totalcols = cells.length - jq(head).find(head.$n('bar')).length,
			columns = wgt._columns,
			leftWidth = 0;

		//B70-ZK-2553: one may specify frozen without any real column
		if (!cells || totalcols <= 0) {
			//no need to do the following computation since there is no any column
			return;
		}

		for (let i = columns; i < totalcols; i++) {
			let n = cells[i],
					hdWgt = zk.Widget.$(n),
					isVisible = hdWgt && hdWgt.isVisible();
			if (!isVisible)
				continue;
			if (n.offsetWidth==0 ) {
				if (hdWgt._origWd && hdWgt._origWd.indexOf('px')>0)
					n.style.width = hdWgt._origWd;
				else if (hdWgt._hflexWidth && hdWgt._hflexWidth > 0)
					n.style.width = jq.px(hdWgt._hflexWidth);
			}
		}
		
		for (let i = 0; i < columns; i++)
				leftWidth += cells[i].offsetWidth;

		parent._deleteFakeRow(parent.eheadrows);

		wgt.$n('cave').style.width = jq.px0(leftWidth);
		let scroll = wgt.$n('scrollX'),
			width = parent.$n('body').offsetWidth;

		// B70-ZK-2074: Resize forzen's width as meshwidget's body.
		parent.$n('frozen').style.width = jq.px0(width);
		width -= leftWidth;
		scroll.style.width = jq.px0(width);
		let rightWidth = 0;
		let toScroll = 0;
		for (let i = columns; i < cells.length; i++){
			let hdWgt = zk.Widget.$(cells[i]);
			let isVisible = hdWgt && hdWgt.isVisible();
			if (!isVisible)
				continue;
			if (cells[i].offsetWidth==0) {
				if (hdWgt._origWd && hdWgt._origWd.indexOf('px')>0)
					rightWidth += parseInt(hdWgt._origWd,10);
				else if (hdWgt._hflexWidth && hdWgt._hflexWidth > 0)
					rightWidth += hdWgt._hflexWidth;
				
			} else {
				rightWidth += cells[i].offsetWidth;
			}
		}
		for (let i = columns; i < cells.length; i++){
			let ow=cells[i].offsetWidth;
			if (ow==0) {
				let hdWgt = zk.Widget.$(cells[i]);
				if (hdWgt._origWd && hdWgt._origWd.indexOf('px')>0)
					ow = parseInt(hdWgt._origWd,10);
				else if (hdWgt._hflexWidth && hdWgt._hflexWidth > 0)
					ow = hdWgt._hflexWidth;				
			}
			rightWidth -= ow;
			toScroll++;
			if (rightWidth <= width) {
				break;
			}
		}
		if (toScroll > 0)  {
			scroll.firstChild.style.width = jq.px0(width+(toScroll * 50));
		}				
	}
	wgt.$syncScroll ();
}