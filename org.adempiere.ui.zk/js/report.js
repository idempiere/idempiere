function zoom(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onZoom', {data: [column, value]}, {toServer: true});
	zAu.send(event);
}

function drillAcross(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onDrillAcross', {data: [column, value]}, {toServer: true});
	zAu.send(event);
}

function drillDown(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	var widget = zk.Widget.$(cmpid);
	var event = new zk.Event(widget, 'onDrillDown', {data: [column, value]}, {toServer: true});
	zAu.send(event);
}

function showColumnMenu(e, columnName, row) {
	var d = getMenu (e.target.getAttribute ("componentId"), e.target.getAttribute ("foreignColumnName"), e.target.getAttribute ("value"));
	
	var posx = 0;
	var posy = 0;
	if (!e) var e = window.event;
	if (e.pageX || e.pageY) 	{
		posx = e.pageX;
		posy = e.pageY;
	}
	else if (e.clientX || e.clientY) 	{
		posx = e.clientX + document.body.scrollLeft
			+ document.documentElement.scrollLeft;
		posy = e.clientY + document.body.scrollTop
			+ document.documentElement.scrollTop;
	}
	
	d.style.top = posy;	
	d.style.left = posx;
	d.style.display = "block";
	
	setTimeout("getMenu ().style.display='none'", 3000);
}

var contextMenu;

function getMenu (componentId, foreignColumnName, value){
	if (contextMenu == null){
	
		//menu div
		var menu = document.createElement("div");
		menu.style.position = "absolute";
		menu.style.display = "none";
		menu.style.top = "0";
		menu.style.left = "0";
		menu.style.border = "1px solid lightgray";
		menu.style.border = "1px solid lightgray";
		menu.style.backgroundColor = "white";
		
		//window menu item
		var windowMenu = document.createElement("div");
		windowMenu.style.padding = "3px";
		windowMenu.style.verticalAlign = "middle";
		windowMenu.setAttribute("onmouseover", "this.style.backgroundColor = 'lightgray'");
		windowMenu.setAttribute("onmouseout", "this.style.backgroundColor = 'white'");									
		
		var href = document.createElement("a");
		href.style.fontSize = "11px";
		href.style.textDecoration = "none";
		href.style.verticalAlign = "middle";
		href.href = "javascript:void(0)";
		href.setAttribute("onclick", "parent.zoom(contextMenu.getAttribute ('componentId'), " +
								"contextMenu.getAttribute ('foreignColumnName'), " +
								"contextMenu.getAttribute ('value'))");
		
		windowMenu.appendChild(href);
		menu.appendChild(windowMenu);				
		
		var image = document.createElement("img"); 
		image.src = window.document.body.getAttribute ("windowIco"); 	
		image.setAttribute("align", "middle");
		href.appendChild(image);
		href.appendChild(document.createTextNode(window.document.body.getAttribute ("windowLabel")));
		
		//report menu item
		var report = document.createElement("div");			
		report.style.padding = "3px";
		report.style.verticalAlign = "middle";
		
		report.setAttribute("onmouseover", "this.style.backgroundColor = 'lightgray'");
		report.setAttribute("onmouseout", "this.style.backgroundColor = 'white'");									
		
		var reportHref = document.createElement("a");
		reportHref.href = "javascript:void(0)";	
		reportHref.style.textDecoration = "none";
		reportHref.style.fontSize = "11px";
		reportHref.style.verticalAlign = "middle";
		reportHref.setAttribute("onclick", "parent.drillDown(contextMenu.getAttribute ('componentId'), " +
								"contextMenu.getAttribute ('foreignColumnName'), " +
								"contextMenu.getAttribute ('value'))");
		
		report.appendChild(reportHref);
		menu.appendChild(report);
		var reportimage = document.createElement("img"); 
		reportimage.src = window.document.body.getAttribute ("reportIco");
		reportimage.setAttribute("align", "middle");
		reportHref.appendChild(reportimage);
		reportHref.appendChild(document.createTextNode(window.document.body.getAttribute ("reportLabel")));
		
		contextMenu = menu;
		window.document.body.appendChild (contextMenu);
	}
	
	contextMenu.setAttribute ("componentId", componentId);
	contextMenu.setAttribute ("foreignColumnName", foreignColumnName);
	contextMenu.setAttribute ("value", value);
	return contextMenu;
}