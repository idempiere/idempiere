if (typeof window.idempiere === 'undefined')
	window.idempiere = {};
	
window.idempiere.zoom = function(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	let widget = zk.Widget.$(cmpid);
	let event = new zk.Event(widget, 'onZoom', {data: [column, value]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.zoomWindow = function(cmpid, column, value, windowuu){
	zAu.cmd0.showBusy(null);
	let widget = zk.Widget.$(cmpid);
	let event = new zk.Event(widget, 'onZoom', {data: [column, value, 'AD_Window_UU', windowuu]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.drillAcross = function(cmpid, column, value, displayValue){
	zAu.cmd0.showBusy(null);
	let widget = zk.Widget.$(cmpid);
	let event = new zk.Event(widget, 'onDrillAcross', {data: [column, value, displayValue]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.drillDown = function(cmpid, column, value){
	zAu.cmd0.showBusy(null);
	let widget = zk.Widget.$(cmpid);
	let event = new zk.Event(widget, 'onDrillDown', {data: [column, value]}, {toServer: true});
	zAu.send(event);
};

window.idempiere.showColumnMenu = function(doc, e, columnName, row, isUseFontIcons) {
	let d = idempiere.getMenu (doc, e.target.getAttribute ("componentId"), e.target.getAttribute ("foreignColumnName"), e.target.getAttribute ("value"), e.target.getAttribute ("displayValue"), isUseFontIcons);
	
	let posx = 0;
	let posy = 0;
	if (!e) e = window.event;
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
	
	let f = function() {
		doc.contextMenu.style.display='none'
	};
	setTimeout(f, 3000);
};

window.idempiere.getMenu = function(doc, componentId, foreignColumnName, value, displayValue, isUseFontIcons){
	doc.contextMenu = null;
	if (componentId != null){	
		//menu div
		let menu = doc.createElement("div");
		menu.style.position = "absolute";
		menu.style.display = "none";
		menu.style.top = "0";
		menu.style.left = "0";
		menu.style.border = "1px solid lightgray";
		menu.style.border = "1px solid lightgray";
		menu.style.backgroundColor = "white";
		
		//window menu item
		let windowMenu = doc.createElement("div");
		windowMenu.style.padding = "3px";
		windowMenu.style.verticalAlign = "middle";
		windowMenu.setAttribute("onmouseover", "this.style.backgroundColor = 'lightgray';this.style.color = 'rgb(0,0,200)'");
		windowMenu.setAttribute("onmouseout", "this.style.backgroundColor = 'white';this.style.color = 'rgb(0,0,0)'");
		
		let href = doc.createElement("a");
		href.style.fontSize = "11px";
		href.style.color = "inherit";
		href.style.textDecoration = "none";
		href.style.textDecorationColor = "inherit";
		href.style.verticalAlign = "middle";
		href.href = "javascript:void(0)";
		href.setAttribute("onclick", "parent.idempiere.zoom('" + componentId + "','" + foreignColumnName + "','" + value + "')");

		let windowIco = doc.body.getAttribute ("windowIco");
		if (typeof windowIco === 'string' && windowIco.length > 0) {
			if(isUseFontIcons) {
				let icon = doc.createElement("span");
				icon.classList.add(windowIco);
				icon.classList.add("font-icon")
				windowMenu.appendChild(icon);
			}
			else {
				let image = doc.createElement("img"); 
				image.src = windowIco;
				image.setAttribute("align", "middle");
				href.appendChild(image);
			}
		}
		href.appendChild(doc.createTextNode(doc.body.getAttribute ("windowLabel")));
		
		windowMenu.appendChild(href);
		menu.appendChild(windowMenu);

		//report menu item
		let report = doc.createElement("div");			
		report.style.padding = "3px";
		report.style.verticalAlign = "middle";
		
		report.setAttribute("onmouseover", "this.style.backgroundColor = 'lightgray';this.style.color = 'rgb(0,0,200)'");
		report.setAttribute("onmouseout", "this.style.backgroundColor = 'white';this.style.color = 'rgb(0,0,0)'");
		
		let reportHref = doc.createElement("a");
		reportHref.href = "javascript:void(0)";	
		reportHref.style.color = "inherit";
		reportHref.style.textDecoration = "none";
		reportHref.style.textDecorationColor = "inherit";
		reportHref.style.fontSize = "11px";
		reportHref.style.verticalAlign = "middle";
		reportHref.setAttribute("onclick", "parent.idempiere.drillDown('" + componentId + "','" + foreignColumnName + "','" + value + "')");
		
		let reportIco = doc.body.getAttribute ("reportIco");
		if (typeof reportIco === 'string' && reportIco.length > 0) {
			if(isUseFontIcons) {
				let icon = doc.createElement("span");
				icon.classList.add(reportIco);
				icon.classList.add("font-icon")
				report.appendChild(icon);
			}
			else {
				let reportimage = doc.createElement("img"); 
				reportimage.src = reportIco;
				reportimage.setAttribute("align", "middle");
				reportHref.appendChild(reportimage);
			}
		}
		reportHref.appendChild(doc.createTextNode(doc.body.getAttribute ("reportLabel")));

		report.appendChild(reportHref);
		menu.appendChild(report);

		//drill menu item
		let reportDrill = doc.createElement("div");
		reportDrill.style.padding = "3px";
		reportDrill.style.verticalAlign = "middle";

		reportDrill.setAttribute("onmouseover", "this.style.backgroundColor = 'lightgray';this.style.color = 'rgb(0,0,200)'");
		reportDrill.setAttribute("onmouseout", "this.style.backgroundColor = 'white';this.style.color = 'rgb(0,0,0)'");

		let reportDrillHref = doc.createElement("a");
		reportDrillHref.href = "javascript:void(0)";
		reportDrillHref.style.color = "inherit";
		reportDrillHref.style.textDecoration = "none";
		reportDrillHref.style.textDecorationColor = "inherit";
		reportDrillHref.style.fontSize = "11px";
		reportDrillHref.style.verticalAlign = "middle";
		reportDrillHref.setAttribute("onclick", "parent.idempiere.drillAcross('" + componentId + "','" + foreignColumnName + "','" + value + "','" + displayValue + "')");

		let drillIco = doc.body.getAttribute ("drillAssistantIco");
		if (typeof drillIco === 'string' && drillIco.length > 0) {
			if(isUseFontIcons) {
				let icon = doc.createElement("span");
				icon.classList.add(drillIco);
				icon.classList.add("font-icon")
				reportDrill.appendChild(icon);
			}
			else {
				let drillimage = doc.createElement("img");
				drillimage.src = drillIco;
				drillimage.setAttribute("align", "middle");
				reportDrillHref.appendChild(drillimage);
			}
		}
		reportDrillHref.appendChild(doc.createTextNode(doc.body.getAttribute ("drillAssistantLabel")));

		reportDrill.appendChild(reportDrillHref);
		menu.appendChild(reportDrill);

		doc.contextMenu = menu;
		doc.body.appendChild (doc.contextMenu);
	}	
	return doc.contextMenu;
};
