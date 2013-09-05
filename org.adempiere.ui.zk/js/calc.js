
function Calc()
{
	this.validate = validate;
	this.clear = clear;
	this.clearAll = clearAll;
	this.evaluate = evaluate;
	this.append = append;

	function validate(displayTextId, calcTextId, integral, separatorKey, e)
	{
	     var key;

	     if(window.event)
	          key = e.keyCode; //IE
	     else
	          key = e.which;   //Firefox

	     if(key == 13 || key == 61) // Enter, =
	     {
	     	evaluate(displayTextId, calcTextId, String.fromCharCode(separatorKey));
	        return false;
	     }
	     else if (key == 0) // control, delete, ...
	     {
	     	return true;
	     }
	     else if (key == 8) // backspace
	     {
	     	return true;
	     }
	     else if (key >= 17 && key <= 20) // Control
	     {
	     	return true;
	     }
	     else if (key == 32) // space
	     {
	     	return true;
	     }
	     else if (key >= 48 && key <= 57) // 0 - 9
	     {
	     	return true;
	     }
	     else if (key == 42 || key == 43 || key == 45 || key == 47) // *, +, -, /
	     {
	     	return true;
	     }
	     else if ( key == separatorKey && !integral)
	     {
	     	return true;
	     }
	     else
	     {
	     	return false;
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