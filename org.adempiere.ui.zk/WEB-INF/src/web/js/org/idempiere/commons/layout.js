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

window.idempiere.showFullSizeImage = function (event) {
  // Get the original image URL
  const imageUrl = event.target.src;
  if (!imageUrl || imageUrl.trim() === '')
	return;

  //zk spacer image (Images.BASE64SPACERIMAGE)
  if (imageUrl == 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAUUAAEALAAAAAABAAEAAAICTAEAOw==')
	return;

  // Get the mouse pointer position relative to the document
  const mouseX = event.pageX + 10;
  const mouseY = event.pageY + 10;
	
  // Create a new image element to display the original size
  const fullsizeImage = new Image();
  fullsizeImage.src = imageUrl;
	  
  // Set the position of the original image to the mouse pointer position
  fullsizeImage.style.position = "absolute";
  fullsizeImage.style.left = mouseX + "px";
  fullsizeImage.style.top = mouseY + "px";  
  fullsizeImage.style.display = "block";
  fullsizeImage.style.width = "auto";
  fullsizeImage.style.height = "auto";
  fullsizeImage.style.maxHeight = "90%";
  fullsizeImage.style.maxWidth = "90%";
  fullsizeImage.style.zIndex = 10;
  fullsizeImage.classList.add('fullsize-image');

  // Add the original image to the document body
  document.body.appendChild(fullsizeImage);

  event.target._fullsize = fullsizeImage;
  
  const rect = event.target._fullsize.getBoundingClientRect();
  const viewportHeight = jq(window).height();
  const viewportWidth = jq(window).width();
  if (rect.bottom > viewportHeight || rect.right > viewportWidth) {
	 if (rect.right > viewportWidth) {
		const rw = rect.right - rect.left;
		let x = event.pageX - rw - 10;
		if (x < 0)
			x = 0;
		event.target._fullsize.style.left = x + "px";
	 }
	 if (rect.bottom > viewportHeight) {
		const rh = rect.bottom - rect.top;
		let y = event.pageY - rh - 10
		if (y < 0)
			y = 0;
		event.target._fullsize.style.top = y + "px";
	 }
  }
  event.target._fullsize.style.display = "none";
  jq(event.target._fullsize).fadeIn();	    
}

window.idempiere.hideFullSizeImage = function (event) {
    try {
  		if (event.target._fullsize && event.target._fullsize instanceof HTMLImageElement) {
			document.body.removeChild(event.target._fullsize);
  			event.target._fullsize = null;
  		}
    } catch (error) {}
}
