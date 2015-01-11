/* util.js

	Purpose:
		
	Description:
		
	History:
		Tue Sep 30 09:02:06     2008, Created by tomyeh

Copyright (C) 2008 Potix Corporation. All Rights Reserved.

This program is distributed under LGPL Version 2.1 in the hope that
it will be useful, but WITHOUT ANY WARRANTY.
*/
(function () {
	var _decs = {lt: '<', gt: '>', amp: '&', quot: '"'},
		_encs = {};
	for (var v in _decs)
		_encs[_decs[v]] = v;

	function _pathname(url) {
		var j = url.indexOf('//');
		if (j > 0) {
			j = url.indexOf('/', j + 2);
			if (j > 0) return url.substring(j);
		}
	}

	function _frames(ary, w) {
		//Note: the access of frames is allowed for any window (even if it connects other website)
		ary.push(w);
		for (var fs = w.frames, j = 0, l = fs.length; j < l; ++j)
			_frames(ary, fs[j]);
	}
	/* Returns the onSize target of the given widget.
	 * The following code is dirty since it checks _hflexsz (which is implementation)
	 * FUTRE: consider to have zk.Widget.beforeSize to clean up _hflexsz and
	 * this method considers only if _hflex is min
	 */
	function _onSizeTarget(wgt) {
		var r1 = wgt, p1 = r1,
			j1 = -1;
		for (; p1 && p1._hflex == 'min'; p1 = p1.parent) {
			delete p1._hflexsz;
			r1 = p1;
			++j1;
			if (p1.ignoreFlexSize_('w')) //p1 will not affect its parent's flex size
				break;
		}

		var r2 = wgt, p2 = r2,
			j2 = -1;
		for (; p2 && p2._vflex == 'min'; p2 = p2.parent) {
			delete p2._vflexsz;
			r2 = p2;
			++j2;
			if (p2.ignoreFlexSize_('h')) //p2 will not affect its parent's flex size
				break;
		}
		return j1 > 0 || j2 > 0 ? j1 > j2 ? r1 : r2: wgt;
	}

/** @class zUtl
 * @import zk.Widget
 * @import zk.xml.Utl
 * The basic utilties.
 * <p>For more utilities, refer to {@link Utl}.
 */
zUtl = { //static methods
	//Character
    /**
     * Returns whether the character is according to its opts.
     * @param char cc the character
     * @param Map opts the options.
<table border="1" cellspacing="0" width="100%">
<caption> Allowed Options
</caption>
<tr>
<th> Name
</th><th> Allowed Values
</th><th> Description
</th></tr>
<tr>
<td> digit
</td><td> true, false
</td><td> Specifies the character is digit only.
</td></tr>
<tr>
<td> upper
</td><td> true, false
</td><td> Specifies the character is upper case only.
</td></tr>
<tr>
<td> lower
</td><td> true, false
</td><td> Specifies the character is lower case only.
</td></tr>
<tr>
<td> whitespace
</td><td> true, false
</td><td> Specifies the character is whitespace only.
</td></tr>
<tr>
<td> opts[cc]
</td><td> true, false
</td><td> Specifies the character is allowed only.
</td></tr>
</table>
     * @return boolean
     */
	isChar: function (cc, opts) {
		return (opts.digit && cc >= '0' && cc <= '9')
			|| (opts.upper && cc >= 'A' && cc <= 'Z')
			|| (opts.lower && cc >= 'a' && cc <= 'z')
			|| (opts.whitespace && (cc == ' ' || cc == '\t' || cc == '\n' || cc == '\r'))
			|| opts[cc];
	},

	//HTML/XML
	/** Parses the specifie text into a map.
	 * For example
	 *<pre><code>
zUtl.parseMap("a=b,c=d");
zUtl.parseMap("a='b c',c=de", ',', "'\"");
</code></pre>
	 * @param String text the text to parse
	 * @param String separator the separator. If omitted, <code>','</code>
	 * is assumed
	 * @param String quote the quote to handle. Ignored if omitted.
	 * @return Map the map
	 */
	parseMap: function (text, separator, quote) {
		var map = {};
		if (text) {
			var ps = text.split(separator || ',');
			if (quote) {
				var tmp = [],
					re = new RegExp(quote, 'g'),
					key = '', t, pair;
				while((t = ps.shift()) !== undefined) {
					if ((pair = (key += t).match(re)) && pair.length != 1) {
						if (key)
							tmp.push(key);
						key = '';
					} else
						key += separator;
				}
				ps = tmp;
			}
			for (var len = ps.length; len--;) {
				var key = ps[len].trim(),
					index = key.indexOf('=');
				if (index != -1)
					map[key.substring(0, index)] = key.substring(index + 1, key.length).trim();
			}
		}
		return map;
	},

	/** Encodes the string to a valid XML string.
	 * Refer to {@link Utl} for more XML utilities.
	 * @param String txt the text to encode
	 * @param Map opts [optional] the options. Allowd value:
	 * <ul>
	 * <li>pre - whether to replace whitespace with &amp;nbsp;</li>
	 * <li>multiline - whether to replace linefeed with &lt;br/&gt;</li>
	 * <li>maxlength - the maximal allowed length of the text</li>
	 * </ul>
	 * @return String the encoded text.
	 */
	encodeXML: function (txt, opts) {
		txt = txt != null ? String(txt):'';
		var tl = txt.length,
			pre = opts && opts.pre,
			multiline = pre || (opts && opts.multiline),
			maxlength = opts ? opts.maxlength : 0;

		if (!multiline && maxlength && tl > maxlength) {
			var j = maxlength;
			while (j > 0 && txt.charAt(j - 1) == ' ')
				--j;
			opts.maxlength = 0; //no limit
			return zUtl.encodeXML(txt.substring(0, j) + '...', opts);
		}

		var out = [], k = 0, enc;
		if (multiline || pre)
			for (var j = 0; j < tl; ++j) {
				var cc = txt.charAt(j);
				if (enc = _encs[cc]) {
					out.push(txt.substring(k, j), '&', enc, ';');
					k = j + 1;
				} else if (multiline && cc == '\n') {
					out.push(txt.substring(k, j), '<br/>\n');
					k = j + 1;
				} else if (pre && (cc == ' ' || cc == '\t')) {
					out.push(txt.substring(k, j), '&nbsp;');
					if (cc == '\t')
						out.push('&nbsp;&nbsp;&nbsp;');
					k = j + 1;
				}
			}
		else
			for (var j = 0; j < tl; ++j)
				if (enc = _encs[txt.charAt(j)]) {
					out.push(txt.substring(k, j), '&', enc, ';');
					k = j + 1;
				}

		if (!k) return txt;
		if (k < tl)
			out.push(txt.substring(k));
		return out.join('');
	},
	/** Decodes the XML string into a normal string.
	 * For example, &amp;lt; is convert to &lt;
	 * @param String txt the text to decode
	 * @return String the decoded string
	 */
	decodeXML: function (txt) {
		var out = '';
		if (!txt) return out;

		var k = 0, tl = txt.length;
		for (var j = 0; j < tl; ++j) {
			var cc = txt.charAt(j);
			if (cc == '&') {
				var l = txt.indexOf(';', j + 1);
				if (l >= 0) {
					var dec = txt.charAt(j + 1) == '#' ?
						String.fromCharCode(txt.charAt(j + 2).toLowerCase() == 'x' ?
							parseInt(txt.substring(j + 3, l), 16):
							parseInt(txt.substring(j + 2, l), 10)):
						_decs[txt.substring(j + 1, l)];
					if (dec) {
						out += txt.substring(k, j) + dec;
						k = (j = l) + 1;
					}
				}
			}
		}
		return !k ? txt:
			k < tl ? out + txt.substring(k): out;
	},

	/** A shortcut of <code>' cellpadding="0" cellspacing="0" border="0"'</code>.
	 * @type String
	 */
 	cellps0: ' cellpadding="0" cellspacing="0" border="0"',
 	/** A shortcut of <code>'&lt;img style="height:0;width:0"/&gt;'</code>.
 	 * @type String
 	 */
 	img0: '<img style="height:0;width:0"/>',
 	/** A shortcut of <code>'&lt;i style="height:0;width:0"/&gt;'</code>.
 	 * @type String
 	 */
 	i0: '<i style="height:0;width:0"/>',
 
 	/** Returns a long value representing the current time (unit: miliseconds).
 	 * @return long
 	 * @deprecated As of release 5.0.6, replaced with jq.now().
 	 */
	now: jq.now,
	/** Returns today.
	 * @param boolean full if true, returns the full time,
	 * else only returns year, month, and day.
	 * If omitted, false is assumed
	 * @return Date
	 */
	/** Returns today.
	 * @param String fmt the time format, such as HH:mm:ss.SSS
	 * If a time element such as seconds not specified in the format, it will
	 * be considered as 0. For example, if the format is "HH:mm", then
	 * the returned object will be today, this hour and this minute, but
	 * the second and milliseconds will be zero.
	 * @return Date
	 * @since 5.0.6
	 */
	today: function (fmt) {
		var d = new Date(), hr = 0, min = 0, sec = 0, msec = 0;
		if (typeof fmt == 'string') {
			var fmt0 = fmt.toLowerCase();
			if (fmt0.indexOf('h') >= 0 || fmt0.indexOf('k') >= 0) hr = d.getHours();
			if (fmt.indexOf('m') >= 0) min = d.getMinutes();
			if (fmt.indexOf('s') >= 0) sec = d.getSeconds();
			if (fmt.indexOf('S') >= 0) msec = d.getMilliseconds();
		} else if (fmt)
			return d;
		return new Date(d.getFullYear(), d.getMonth(), d.getDate(),
			hr, min, sec, msec);
	},

	/** Returns if one is ancestor of the other.
	 * It assumes the object has either a method called <code>getParent</code>
	 * or a field called <code>parent</code>.
	 * A typical example is used to test the widgets ({@link Widget}).
	 *
	 * <p>Notice that, if you want to test DOM elements, please use
	 * {@link jq#isAncestor} instead.
	 *
	 * @param Object p the parent. This method return true if p is null
	 or p is the same as c
	 * @param Object c the child
	 * @return boolean
	 * @see jq#isAncestor
	 */
	isAncestor: function (p, c) {
		if (!p) return true;
		for (; c; c = c.getParent ? c.getParent(): c.parent)
			if (p == c)
				return true;
		return false;
	},

	//progress//
	/** Creates a message box to indicate something is being processed
	 * @param String id the ID of the DOM element being created
	 * @param String msg the message to shown
	 * @param boolean mask whether to show sem-transparent mask to prevent
	 * the user from accessing it.
	 * @param String icon the CSS class used to shown an icon in the box.
	 * Ignored if not specified.
	 * @see #destroyProgressbox
	 */
	progressbox: function (id, msg, mask, icon, _opts) {
		if (mask && zk.Page.contained.length) {
			for (var c = zk.Page.contained.length, e = zk.Page.contained[--c]; e; e = zk.Page.contained[--c]) {
				if (!e._applyMask)
					e._applyMask = new zk.eff.Mask({
						id: e.uuid + '-mask',
						message: msg,
						anchor: e.$n()
					});
			}
			return;
		}

		if (_opts && _opts.busy) {
			zk.busy++;
			jq.focusOut(); //Bug 2912533
		}

		var x = jq.innerX(), y = jq.innerY(),
			style = ' style="left:'+x+'px;top:'+y+'px"',
			idtxt = id + '-t',
			idmsk = id + '-m',
			html = '<div id="'+id+'"';
		if (mask)
			html += '><div id="' + idmsk + '" class="z-modal-mask"'+style+'></div';
		html += '><div id="'+idtxt+'" class="z-loading"'+style
			+'><div class="z-loading-indicator"><span class="z-loading-icon"></span> '
			+msg+'</div></div>';
		if (icon)
			html += '<div class="' + icon + '"></div>';
		jq(document.body).append(html + '</div>');

		var $n = jq(id, zk),
			n = $n[0],
			$txt = jq(idtxt, zk),
			txt = $txt[0],
			st = txt.style;
		if (mask) {
			// old IE will get the auto value by default.
			var zIndex = $txt.css('z-index');
			if (zIndex == 'auto')
				zIndex = 1;
			n.z_mask = new zk.eff.FullMask({
				mask: jq(idmsk, zk)[0],
				zIndex: zIndex - 1
			});
		}

		if (mask && $txt.length) { //center
			st.left = jq.px((jq.innerWidth() - txt.offsetWidth) / 2 + x);
			st.top = jq.px((jq.innerHeight() - txt.offsetHeight) / 2 + y);
		} else {
			var pos = zk.progPos;
			if (pos) {
				var left,
					top,
					width = jq.innerWidth(),
					height = jq.innerHeight(),
					wdgap = width - zk(txt).offsetWidth(),
					hghgap = height - zk(txt).offsetHeight();

				if (pos.indexOf('mouse') >= 0) {
					var offset = zk.currentPointer;
					left = offset[0] + 10;
					top = offset[1] + 10;
				} else {
					if (pos.indexOf('left') >= 0) left = x;
					else if (pos.indexOf('right') >= 0)	left = x + wdgap -1;
					else if (pos.indexOf('center') >= 0) left = x + wdgap / 2;
					else left = 0;
					
					if (pos.indexOf('top') >= 0) top = y;
					else if (pos.indexOf('bottom') >= 0) top = y + hghgap - 1;
					else if (pos.indexOf('center') >= 0) top = y + hghgap / 2;
					else top = 0;
					
					left = left < x ? x : left;
					top = top < y ? y : top;
				}
				st.left = jq.px(left);
				st.top = jq.px(top);
			}
		}

		$n.zk.cleanVisibility();
	},
	/** Removes the message box created by {@link #progressbox}.
	 * @param String id the ID of the DOM element of the message box
	 */
	destroyProgressbox: function (id, _opts) {
		if (_opts && _opts.busy && --zk.busy < 0)
			zk.busy = 0;
		var $n = jq(id, zk), n;
		if ($n.length) {
			if (n = $n[0].z_mask) n.destroy();
			$n.remove();
		}

		for (var c = zk.Page.contained.length, e = zk.Page.contained[--c]; e; e = zk.Page.contained[--c])
			if (e._applyMask) {
				e._applyMask.destroy();
				e._applyMask = null;
			}
	},

	//HTTP//
	/** Navigates to the specified URL.
	 * @param String url the URL to go to
	 * @param Map opts [optional] the options. Allowed values:
	 * <ul>
	 * <li>target - the name of the target browser window. The same browswer
	 * window is assumed if omitted. You can use any value allowed in
	 * the target attribute of the HTML FORM tag, such as _self, _blank,
	 * _parent and _top.</li>
	 * <li>overwrite - whether load a new page in the current browser window.
	 * If true, the new page replaces the previous page's position in the history list.</li>
	 * </ul>
	 */
	go: function (url, opts) {
		opts = opts || {};
		if (opts.target) {
			open(url, opts.target);
		} else if (opts.overwrite) {
			location.replace(url ? url: location.href);
		} else {
			if (url) {
				location.href = url;

				var j = url.indexOf('#');
				//bug 3363687, only if '#" exist, has to reload()
				if(j < 0)
					return;
				
				var	un = j >= 0 ? url.substring(0, j): url,
					pn = _pathname(location.href);
				
				j = pn.indexOf('#');
				if (j >= 0) pn = pn.substring(0, j);
				if (pn != un)
					return;
				//fall thru (bug 2882149)
			}
			location.reload();
		}
	},

	/** Returns all descendant frames of the given window.
	 * <p>To retrieve all, invoke <code>zUtl.frames(top)</code>.
	 * Notice: w is included in the returned array.
	 * If you want to exclude it, invoke <code>zUtl.frames(w).$remove(w)</code>.
	 * @param Window w the browser window
	 * @return Array
	 * @since 5.0.4
	 */
	frames: function (w) {
		var ary = [];
		_frames(ary, w);
		return ary;
	},

	/** Converts an integer array to a string (separated by comma).
	 * @param int[] ary the integer array to convert.
	 * If null, an empty string is returned.
	 * @return String
	 * @see #stringToInts
	 */
	intsToString: function (ary) {
		if (!ary) return '';

		var sb = [];
		for (var j = 0, k = ary.length; j < k; ++j)
			sb.push(ary[j]);
		return sb.join();
	},
	/** Converts a string separated by comma to an array of integers.
	 * @see #intsToString
	 * @param String text the string to convert.
	 * If null, null is returned.
	 * @param int defaultValue the default value used if the value
	 * is not specified. For example, zUtl.stringToInts("1,,3", 2) returns [1, 2, 3].
	 * @return int[]
	 */
	stringToInts: function (text, defaultValue) {
		if (text == null)
			return null;

		var list = [];
		for (var j = 0;;) {
			var k = text.indexOf(',', j),
				s = (k >= 0 ? text.substring(j, k): text.substring(j)).trim();
			if (s.length == 0) {
				if (k < 0) break;
				list.push(defaultValue);
			} else
				list.push(zk.parseInt(s));

			if (k < 0) break;
			j = k + 1;
		}
		return list;
	},
	/** Converts a map to a string
	 * @see #intsToString
	 * @param Map map the map to convert
	 * @param String assign the symbol for assignment. If omitted, '=' is assumed.
	 * @param String separator the symbol for separator. If omitted, ',' is assumed.
	 * @return String
	 */
	mapToString: function (map, assign, separator) {
		assign = assign || '=';
		separator = separator || ' ';
		var out = [];
		for (var v in map)
			out.push(separator, v, assign, map[v]);
		out[0] = '';
		return out.join('');
	},
	/** Appends an attribute.
	 * Notice that the attribute won't be appended if val is empty or false.
	 * In other words, it is equivalent to<br/>
	 * <code>val ? ' ' + nm + '="' + val + '"': ""</code>.
	 * <p>If you want to generate the attribute no matter what val is, use
	 * {@link #appendAttr(String, Object, boolean)}.
	 * @param String nm the name of the attribute
	 * @param Object val the value of the attribute
	 * @since 5.0.3
	 */
	/** Appends an attribute.
	 * Notice that the attribute won't be appended.
	 * @param String nm the name of the attribute
	 * @param Object val the value of the attribute
	 * @param boolean force whether to append attribute no matter what value it is.
	 * If false (or omitted), it is the same as {@link #appendAttr(String, Object)}.
	 * @since 5.0.3
	 */
	appendAttr: function (nm, val, force)  {
		return val || force ? ' ' + nm + '="' + val + '"': '';
	},
	/** Fires beforeSize, onFitSize and onSize
	 * @param Widget wgt the widget which the zWatch event will be fired against.
	 * @param int bfsz the beforeSize mode:
	 * <ul>
	 * <li>0 (null/undefined/false): beforeSize sent normally.</li>
	 * <li>-1: beforeSize won't be sent.</li>
	 * <li>1: beforeSize will be sent with an additional cleanup option,
	 * which will clean up the cached minimal size (if flex=min).</li>
	 * </ul>
	 * @since 5.0.8
	 */
	fireSized: function (wgt, bfsz) {
		if (zUtl.isImageLoading() || zk.clientinfo) {
			var f = arguments.callee;
			setTimeout(function () {
				return f(wgt, bfsz);
			}, 20);
			return;
		}
		wgt = _onSizeTarget(wgt);
		if (!(bfsz < 0)) //don't use >= (because bfsz might be undefined)
			zWatch.fireDown('beforeSize', wgt, null, bfsz > 0);
		zWatch.fireDown('onFitSize', wgt, {reverse: true});
		zWatch.fireDown('onSize', wgt);
	},
	/** Fires onBeforeSize, onShow, onFitSize, and onSize
	 * @param Widget wgt the widget which the zWatch event will be fired against.
	 * @param int bfsz the beforeSize mode:
	 * <ul>
	 * <li>0 (null/undefined/false): beforeSize sent normally.</li>
	 * <li>-1: beforeSize won't be sent.</li>
	 * <li>1: beforeSize will be sent with an additional cleanup option,
	 * which will clean up the cached minimal size (if flex=min).</li>
	 * </ul>
	 * @since 5.0.8
	 */
	fireShown: function (wgt, bfsz) {
		zWatch.fireDown('onShow', wgt);
		zUtl.fireSized(wgt, bfsz);
	},
	/**
	 * Loads an image before ZK client engine to calculate the widget's layout.
	 * @param String url the loading image's localation
	 * @since 6.0.0
	 */
	loadImage: function (url) {
		if (!_imgMap[url]) {
			_imgMap[url] = true;
			_loadImage(url);
		}
	},
	/**
	 * Checks whether all the loading images are finish.
	 * @see #loadImage
	 * @since 6.0.0 
	 */
	isImageLoading: function () {
		for (var url in _imgObjectMap) {
			var img = _imgObjectMap[url];
			if (img.complete) {
				try {
					delete _imgMap[url];
				} catch (err) {}
				try {
					delete _imgObjectMap[url];
				} catch (err) {}
			}
		}
		for (var n in _imgMap) {
			return true;
		}
		return false;
	}
};

var _imgMap = {};
var _imgObjectMap = {};
function _loadImage(url) {
	var img = new Image(),
		f = function () {
			try {
				delete _imgMap[url];
			} catch (err) {}
			try {
				delete _imgObjectMap[url];
			} catch (err) {}
		};
	_imgObjectMap[url]=img;
	img.onerror = img.onload = img.onabort = f;
	img.src = url;
}
})();
