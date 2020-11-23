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

