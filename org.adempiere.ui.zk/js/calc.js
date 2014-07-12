
function Calc()
{
	this.validateUp = validateUp;
	this.validatePress = validatePress;
	this.clear = clear;
	this.clearAll = clearAll;
	this.evaluate = evaluate;
	this.append = append;

	function validatePress(displayTextId, calcTextId, integral, separatorKey, e)
	{
	     var key;

	     if(window.event)
	          key = e.keyCode; //IE
	     else
	          key = e.which;   //Firefox
	     // console.log("validatePress: " + displayTextId + " / " + calcTextId + " / " + integral + " / " + separatorKey + " / " + key);
	     if (key == 61) // =
	     {
	     	evaluate(displayTextId, calcTextId, String.fromCharCode(separatorKey));
	     }
	}

	function validateUp(displayTextId, calcTextId, integral, separatorKey, e, processDotKeypad)
	{
	     var key;
	     if(window.event)
	          key = e.keyCode; //IE
	     else
	          key = e.which;   //Firefox
	     // console.log("validateUp: " + displayTextId + " / " + calcTextId + " / " + integral + " / " + separatorKey + " / " + key + " / " + processDotKeypad);
	     if (key == 13) // Enter
	     {
	     	evaluate(displayTextId, calcTextId, String.fromCharCode(separatorKey));
	     }
	     else if (processDotKeypad && separatorKey != 46 && (key == 110 || key == 190) && !window.opera) // numeric dot on keypad (not working for opera)
	     {
	     	append(calcTextId, String.fromCharCode(separatorKey));
	     	e.stop;
	     }
	}

	function clearAll(calcTextId)
	{
		try
		{
			var id = "$".concat(calcTextId);
			var calcText = jq(id)[0];
			calcText.value = "";
		}
		catch (err)
		{
		}
	}

	function clear(calcTextId)
	{
		try
		{
			var id = "$".concat(calcTextId);
			var calcText = jq(id)[0];
			var val = calcText.value;
			if (val != "")
			{
				val = val.substring(0, val.length - 1);
				calcText.value = val;
			}
		}
		catch (err)
		{
		}

	}

	function evaluate(displayTextId, calcTextId, separator)
	{
		// console.log("evaluate: " + displayTextId + " / " + calcTextId + " / " + separator);
		var newValue = "error";
		try
		{
			var id = "$".concat(calcTextId);
			var calcText = jq(id)[0];
			var value = calcText.value;
			if (separator != '.')
			{
				var re = new RegExp("[" + separator + "]", "g");
				value = value.replace(re,'.');
			}
			var reclean = new RegExp("[^1234567890+-/*%() ]", "g"); // sanitize
			value = value.replace(reclean,'');
			var reperc = new RegExp("[%]", "g"); // percentage
			value = value.replace(reperc,'/100 ');
			newValue = value;
			var result = "" + eval(value);
			if (separator != '.')
			{
				result = result.replace(/\./, separator);
			}
			calcText.value = result;

			id = "$".concat(displayTextId);
			var displayText = jq(id)[0];

			if (!displayText.readOnly && calcText.value != 'undefined')
			{
				displayText.value = calcText.value;
				setTimeout("jq('$" + displayTextId + "')[0].focus()", 100);
			}
		}
	   	catch (err)
	   	{
			calcText.value = newValue;
	   	}
	}

	function append(calcTextId, val)
	{
		var id = "$".concat(calcTextId);
		var calcText = jq(id)[0];
		calcText.value += val;
	}
}

var calc = new Calc();