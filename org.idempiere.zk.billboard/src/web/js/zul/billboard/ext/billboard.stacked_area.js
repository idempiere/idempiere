var billboard = billboard || {};

billboard.StackedAreaRenderer = function() {};

billboard.StackedAreaRenderer.prototype.render = function(wgt) {
	var columns = [];
	var categories = new Array();
	var seriesMap = {};
	var currentSeries = "";
	wgt.getSeriesData().forEach((x, i) => { 
		x.forEach((y, j) => {
			if (y.category) {
				if (!seriesMap[currentSeries])
					seriesMap[currentSeries] = {};
				var categoryMap = seriesMap[currentSeries];
				if (!categoryMap[y.category])
					categoryMap[y.category] = y.value;
				else
					categoryMap[y.category] += y.value;
				if (categories.indexOf(y.category) < 0)
					categories.push(y.category);
			} else {
				currentSeries = y;
			}
		});
	});
	categories.forEach((c, i) => {
		for(var s in seriesMap) {
			var categoryMap = seriesMap[s];
			if (!categoryMap[c]) {
				categoryMap[c] = 0;
			}
		}
	});
	for(var s in seriesMap) {
		var row = new Array();
		row.push(s);
		var categoryMap = seriesMap[s];
		categories.forEach((c, i) => {
			row.push(categoryMap[c]);
		});
		columns.push(row);
	}
	var groups = new Array();
	groups[0] = new Array();
	for(var s in seriesMap) {
		groups[0].push(s);
	}
	var color = {};
	var area = {};
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
	var x = {tick: {}};
	var rotated = false;
	var axes = wgt.getAxes();
	if (axes.rotated)
		rotated = axes.rotated;
	if (axes.xaxis.renderer == "timeseries") {
		x["type"] = "timeseries";
		if (axes.xaxis.tickOptions) {
			x["tick"]["format"] = axes.xaxis.tickOptions.formatString;
		}		
	} else {
		x["type"] = "category";
	}
	if (x["type"] == "category") {
		if (categories.length > 0) {
			x["categories"] = [];
			categories.forEach((v, i) => x["categories"].push(v));
		}
	} else if (x["type"] == "timeseries") {
		var ts = new Array();
		ts.push("x");
		categories.forEach((s, i) => ts.push(s));
		columns.push(ts);
		x["tick"]["fit"] = true;
	}
	x["clipPath"] = false;
	if (axes.xaxis.tickOptions) {
		if (axes.xaxis.tickOptions.angle) {
			if (axes.xaxis.tickOptions.angle != 0) {
				x["tick"]["rotate"] = axes.xaxis.tickOptions.angle;
			}
		}
	}
	
	var model = { 
		bindto: "#"+wgt.$n().id, 
		data: { 
			columns: columns, 
			type: "area",
			groups: groups,
			onclick: function(d, e) {
				var i = 0;
				var si = 0;
				for(var s in seriesMap) {
					if (s == d.id) {
						si = i;
						break;
					}
					i++;
				}
				wgt._dataClickTS = new Date().getTime();
				wgt.fire("onDataClick", {
					seriesIndex : si,
					pointIndex : d.index,
					data : d.value,
					ticks : wgt.getTicks()
				});
			}
		},
		color: color,
		area: area,
		tooltip: {
			show: true,
		    doNotHide: false,
		    grouped: true
		},
		legend: {show: true},
		axis: {
			x: x,
			rotated: rotated
		},
		grid: {
		  x: {
		    show: true,
		  },
		  y: {
		    show: true,
		  },
		  front: false,
		  focus: {
		     show: false,
		
		     // Below options are available when 'tooltip.grouped=false' option is set
		     edge: true,
		     y: true
		  },
		  lines: {
		     front: false
		  }
		},
		padding: {
			right: 30
		}
	};
	if (x["type"] == "timeseries") {
		model["data"]["x"] = "x";
	}
	if (wgt.getTitle())
		model["title"] = {text: wgt.getTitle()};
	if (wgt.getTickAxisLabel())
		model["axis"]["x"]["label"] = {text: wgt.getTickAxisLabel(), position: "outer-right"}; 
	if (wgt.getValueAxisLabel())
		model["axis"]["y"] = { label: {text: wgt.getValueAxisLabel(), position: "outer-top"} };
	return model;
};

zul.billboard.Billboard._renderers["stacked_area"] = new billboard.StackedAreaRenderer();
		