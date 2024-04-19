var billboard = billboard || {};

billboard.GaugeRenderer = class {
    constructor() { }
    render(wgt) {
        var columns = [wgt.getSeriesData()[0], wgt.getSeriesData()[1]];
        var color = {};
        var gauge = {
            units: ""            
        };
        let showNeedle = false;
        var rendererOptions = wgt._rendererOptions ? jq.evalJSON(wgt._rendererOptions) : null;
        if (rendererOptions) {        	
        	if (rendererOptions["showNeedle"] && rendererOptions["showNeedle"] == true) {
        		showNeedle = true;
        		gauge.title = "\n"+wgt.getSeriesData()[1]+"%";
        		gauge.width = 20;
        		gauge.label = {
                	format: function(_value, _ratio, id) { return id; }
	            };
        	}
            if (rendererOptions["intervalColors"]) {
                color["pattern"] = new Array();
                rendererOptions["intervalColors"].forEach((x, _i) => color["pattern"].push(x));
            }
            if (rendererOptions["intervals"]) {
                if (!showNeedle) {
                	color["threshold"] = {values: []};
                	rendererOptions["intervals"].forEach((x, _i) => color["threshold"]["values"].push(x));
                } else {
                	columns = [];
                	let prev = 0;
                	rendererOptions["intervals"].forEach((x, _i) => {
                    	let step = x - prev;
                    	prev = x;
                    	columns.push([x + "%", step]);
                	});
                }
            }

            if (rendererOptions["background"]) {
                gauge["background"] = rendererOptions["background"];
            }
        }
        var model = {
            bindto: "#" + wgt.$n().id,
            data: {
                columns: showNeedle ? columns : [columns],
                type: wgt._type
            },
            color: color,
            gauge: gauge,
            tooltip: {
                show: true,
                doNotHide: false,
                grouped: false,
                format: {
                    title: function(_x) { return ""; },
                    name: function(_name, _ratio, _id, _index) { return ""; },
                    value: function(value, _ratio, _id, _index) { return value; }
                }
            },                        
            legend: { show: false }
        };
        if (showNeedle) {
        	model.arc = {
                needle: {
                    show: true,
                    value: wgt.getSeriesData()[1][0]
                }
            };
            if (rendererOptions["intervals"]) {
				if (model.arc.needle.value > rendererOptions["intervals"][rendererOptions["intervals"].length-1]) {
					model.arc.needle.value = rendererOptions["intervals"][rendererOptions["intervals"].length-1]+3;
				}
			}
            model.interaction = {
                enabled: false
            };
        }
        return model;
    }
};


zul.billboard.Billboard._renderers["gauge"] = new billboard.GaugeRenderer();
		