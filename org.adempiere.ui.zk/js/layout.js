function ad_deferRenderBorderLayout(uuid, timeout) {
	try {
		var meta = zk.Widget.$(uuid);
		if (meta) {
			setTimeout("_ad_deferBDL('"+uuid+"')", timeout);				
		}
	} catch (err) {
		 if (console) console.log(err);
	}
}		

function _ad_deferBDL(uuid) {
	try {
		var cmp = zk.Widget.$(uuid);
		if (cmp) { cmp.resize(); }	
	} catch (err) {
		 if (console) console.log(err);
	}
}

function _ad_closeBuble(link) {
	try {
		var parent = link.parentsUntil("simileAjax-bubble-contentContainer");
		var btn = parent.next();
		btn.click();
	} catch (err) {
		 if (console) console.log(err);
	}
}

function scrollToRow(uuid){
	try {
		var cmp = zk.Widget.$(uuid);  	 
		if (cmp) {
			cmp.scrollIntoView();
		 	cmp.focus();
		}
	} catch (err) {
		if (console) console.log(err);
	}
}
