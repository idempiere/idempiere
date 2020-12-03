if (typeof window.idempiere === 'undefined')
	window.idempiere = {};
	
window.idempiere.zoom = function(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onZoom', {data: [column, value]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.zoomWindow = function(cmpid, column, value, windowuu){
	zAu.cmd0.showBusy(null);
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onZoom', {data: [column, value, 'AD_Window_UU', windowuu]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.drillAcross = function(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onDrillAcross', {data: [column, value]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.drillDown = function(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onDrillDown', {data: [column, value]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.showColumnMenu = function(doc, e, columnName, row) {
	var d = idempiere.getMenu (doc, e.target.getAttribute ("componentId"), e.target.getAttribute ("foreignColumnName"), e.target.getAttribute ("value"));
	
	var posx = 0;
	var posy = 0;
	if (!e) var e = window.event;
	if (e.pageX || e.pageY) 	{
		posx = e.pageX;
		posy = e.pageY;
	}
	else if (e.clientX || e.clientY) 	{
		posx = e.clientX + doc.body.scrollLeft
			+ doc.documentElement.scrollLeft;
		posy = e.clientY + doc.body.scrollTop
			+ doc.documentElement.scrollTop;
	}
	
	d.style.top = posy;	
	d.style.left = posx;
	d.style.display = "block";
	
	var f = function() {
		doc.contextMenu.style.display='none'
	};
	setTimeout(f, 3000);
};

window.idempiere.getMenu = function(doc, componentId, foreignColumnName, value){
	doc.contextMenu = null;
	if (componentId != null){	
		//menu div
		var menu = doc.createElement("div");
		menu.style.position = "absolute";
		menu.style.display = "none";
		menu.style.top = "0";
		menu.style.left = "0";
		menu.style.border = "1px solid lightgray";
		menu.style.border = "1px solid lightgray";
		menu.style.backgroundColor = "white";
		
		//window menu item
		var windowMenu = doc.createElement("div");
		windowMenu.style.padding = "3px";
		windowMenu.style.verticalAlign = "middle";
		windowMenu.setAttribute("onmouseover", "this.style.backgroundColor = 'lightgray'");
		windowMenu.setAttribute("onmouseout", "this.style.backgroundColor = 'white'");									
		
		var href = doc.createElement("a");
		href.style.fontSize = "11px";
		href.style.textDecoration = "none";
		href.style.verticalAlign = "middle";
		href.href = "javascript:void(0)";
		href.setAttribute("onclick", "parent.idempiere.zoom('" + componentId + "','" + foreignColumnName + "','" + value + "')");
		
		windowMenu.appendChild(href);
		menu.appendChild(windowMenu);				
		
		var windowIco = doc.body.getAttribute ("windowIco");
		if (typeof windowIco === 'string' && windowIco.length > 0) {
			var image = doc.createElement("img"); 
			image.src = windowIco;
			image.setAttribute("align", "middle");
			href.appendChild(image);
		}
		href.appendChild(doc.createTextNode(doc.body.getAttribute ("windowLabel")));
		
		//report menu item
		var report = doc.createElement("div");			
		report.style.padding = "3px";
		report.style.verticalAlign = "middle";
		
		report.setAttribute("onmouseover", "this.style.backgroundColor = 'lightgray'");
		report.setAttribute("onmouseout", "this.style.backgroundColor = 'white'");									
		
		var reportHref = doc.createElement("a");
		reportHref.href = "javascript:void(0)";	
		reportHref.style.textDecoration = "none";
		reportHref.style.fontSize = "11px";
		reportHref.style.verticalAlign = "middle";
		reportHref.setAttribute("onclick", "parent.idempiere.drillDown('" + componentId + "','" + foreignColumnName + "','" + value + "')");
		
		report.appendChild(reportHref);
		menu.appendChild(report);
		var reportIco = doc.body.getAttribute ("reportIco");
		if (typeof reportIco === 'string' && reportIco.length > 0) {
			var reportimage = doc.createElement("img"); 
			reportimage.src = reportIco;
			reportimage.setAttribute("align", "middle");
			reportHref.appendChild(reportimage);
		}
		reportHref.appendChild(doc.createTextNode(doc.body.getAttribute ("reportLabel")));
		
		doc.contextMenu = menu;
		doc.body.appendChild (doc.contextMenu);
	}	
	return doc.contextMenu;
};
