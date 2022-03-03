if (typeof window.idempiere === 'undefined')
	window.idempiere = {};

window.idempiere.copyToClipboard = function(prm){
	var tempInput = document.createElement("input");
	tempInput.style = "position: absolute; left: -1000px; top: -1000px";
	tempInput.value = prm;
	document.body.appendChild(tempInput);
	tempInput.select();
	tempInput.setSelectionRange(0, 99999);
	document.execCommand("copy");
};
