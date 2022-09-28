var billboard = billboard || {};

billboard.DonutRenderer = function() {};

billboard.DonutRenderer.prototype.render = function(wgt) {
	var columns = wgt.getSeriesData()[0];
	var color = {};
	var donut = {};
	var background = {};
	var rendererOptions = wgt._rendererOptions ? jq.evalJSON(wgt._rendererOptions) : null;
	if (rendererOptions) {
		if (rendererOptions["intervalColors"]) {
			color["pattern"] = new Array();
			rendererOptions["intervalColors"].forEach((x, i) => color["pattern"].push(x));
		}
		if (rendererOptions["intervals"]) {
			color["threshold"] = {values: []};
			rendererOptions["intervals"].forEach((x, i) => color["threshold"]["values"].push(x));
		}

		if (rendererOptions["background"]) {
			background["color"] = rendererOptions["background"];
		}
	}
	
	var model = { 
		bindto: "#"+wgt.$n().id, 
		data: { 
			columns: columns, 
			type: wgt._type,
			onclick: function(d, e) {
				wgt._dataClickTS = new Date().getTime();
				wgt.fire("onDataClick", {
					seriesIndex : 0,
					pointIndex : d.index,
					data : d.value,
					ticks : wgt.getTicks()
				});
			}
		},
		color: color,
		donut: donut,
		tooltip: {
			show: true,
		    doNotHide: false,
		    grouped: false,
		    format: {
		    	title: function(x) { return ""; },
		        name: function(name, ratio, id, index) { return name; },
		        value: function(value, ratio, id, index) { return value; }
		    }
		},
		legend: {show: true}
	};
	if (wgt.getTitle())
		model["donut"]["title"] = wgt.getTitle();
		//model["title"] = {text: wgt.getTitle()};
	return model;
};

zul.billboard.Billboard._renderers["donut"] = new billboard.DonutRenderer();
		