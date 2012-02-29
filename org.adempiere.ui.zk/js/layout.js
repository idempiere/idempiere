function ad_deferRenderBorderLayout(uuid, timeout) {
	var meta = zk.Widget.$(uuid);
	if (meta) {
		setTimeout("_ad_deferBDL('"+uuid+"')", timeout);				
	}
}		

function _ad_deferBDL(uuid) {			
	zk.Widget.$(uuid).resize();
}

function ad_closeBuble(uuid) {
	var cmp = zk.Widget.$(uuid); 
	for(var i=0;i<cmp.bandInfos.length;i++){
		cmp.instance.getBand(i).closeBubble();
	}
}

function scrollToRow(uuid){  
	 var cmp = zk.Widget.$(uuid);  
	 cmp.$n().style.display='inline';
	 cmp.focus();
	 cmp.$n().style.display='none';
}
 