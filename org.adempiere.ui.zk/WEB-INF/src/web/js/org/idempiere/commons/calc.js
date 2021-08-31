
function Calc()
{
	this.validateDown = validateDown;
	this.clear = clear;
	this.clearAll = clearAll;
	this.evaluate = evaluate;
	this.append = append;
	this.appendOnCursor = appendOnCursor;

	function validateDown(displayTextId, calcTextId, integral, separatorKey, e, processDotKeypad)
	{
	     var key;
	     if(window.event)
	          key = e.keyCode; //IE
	     else
	          key = e.which;   //Firefox
	     // console.log("validateDown: " + displayTextId + " / " + calcTextId + " / " + integral + " / " + separatorKey + " / " + key + " / " + processDotKeypad);
	     if (key == 13 || key == 61) // Enter
	     {
	     	evaluate(displayTextId, calcTextId, String.fromCharCode(separatorKey));
	     }
	     else if (processDotKeypad && (key == 108 || key == 110 || key == 188 || key == 190 || key == 194))
	     {
	    	appendOnCursor(calcTextId, String.fromCharCode(separatorKey));
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
			value = value
				.replace(/[^1234567890+-/*%() ]/g, '')            // sanitize
				.replace(/[%]/g, '/100 ')                         // percentage
					// now replace leading zeroes
				.replace(/\b0+\b/g, 'z')                          // replace bare zeros with sentinel 
				.replace(/[1-9\.]0+/g, m => m.replace(/0/g, 'z')) // save these too
				.replace(/0/g, '')                                // throw away the rest of the zeros
				.replace(/z/g, '0');                              // turn sentinels back to zeros
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
		calcText.focus();
	}

	function appendOnCursor(calcTextId, val)
	{
		var id = "$".concat(calcTextId);
		var calcText = jq(id)[0];
		var position = calcText.selectionStart;
		var newValue = calcText.value.substring(0, position) + val + calcText.value.substring(position);
		calcText.value = newValue;
		calcText.setSelectionRange(position+1, position+1);
	}
}

window.calc = new Calc();
