var billboard = billboard || {};

billboard.GaugeRenderer = function() {};

billboard.GaugeRenderer.prototype.render = function(wgt) {
	var columns = [wgt.getSeriesData()[0], wgt.getSeriesData()[1]];
	var color = {};
	var gauge = {units: ""};
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

		/*			
		if (rendererOptions["min"]) {
			gauge["min"] = rendererOptions["min"];
		}
		if (rendererOptions["max"]) {
			gauge["max"] = rendererOptions["max"];
		}
		*/
		if (rendererOptions["background"]) {
			gauge["background"] = rendererOptions["background"];
		}
	}
	var model = { 
		bindto: "#"+wgt.$n().id, 
		data: { 
			columns: [columns], 
			type: wgt._type
		},
		color: color,
		gauge: gauge,
		tooltip: {
			show: true,
		    doNotHide: false,
		    grouped: false,
		    format: {
		    	title: function(x) { return ""; },
		        name: function(name, ratio, id, index) { return ""; },
		        value: function(value, ratio, id, index) { return value; }
		    }
		},
		legend: {show: false}						
	};
	return model;
};

zul.billboard.Billboard._renderers["gauge"] = new billboard.GaugeRenderer();
		