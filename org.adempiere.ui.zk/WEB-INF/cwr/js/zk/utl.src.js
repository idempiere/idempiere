
(function () {
	var _decs = {lt: '<', gt: '>', amp: '&', quot: '"'},
		_encs = {};
	for (var v in _decs)
		_encs[_decs[v]] = v;

	function _pathname(url) {
		var j = url.indexOf("//");
		if (j > 0) {
			j = url.indexOf("/", j + 2);
			if (j > 0) return url.substring(j);
		}
	}

	function _frames(ary, w) {
		
		ary.push(w);
		for (var fs = w.frames, j = 0, l = fs.length; j < l; ++j)
			_frames(ary, fs[j]);
	}
	
	function _onSizeTarget(wgt) {
		var r1 = wgt, p1 = r1,
			j1 = -1;
		for (; p1 && p1._hflex == 'min'; p1 = p1.parent) {
			delete p1._hflexsz;
			r1 = p1;
			++j1;
			if (p1.ignoreFlexSize_('w')) 
				break;
		}

		var r2 = wgt, p2 = r2,
			j2 = -1;
		for (; p2 && p2._vflex == 'min'; p2 = p2.parent) {
			delete p2._vflexsz;
			r2 = p2;
			++j2;
			if (p2.ignoreFlexSize_('h')) 
				break;
		}
		return j1 > 0 || j2 > 0 ? j1 > j2 ? r1 : r2: wgt;
	}


zUtl = { 
	
    
	isChar: function (cc, opts) {
		return (opts.digit && cc >= '0' && cc <= '9')
			|| (opts.upper && cc >= 'A' && cc <= 'Z')
			|| (opts.lower && cc >= 'a' && cc <= 'z')
			|| (opts.whitespace && (cc == ' ' || cc == '\t' || cc == '\n' || cc == '\r'))
			|| opts[cc];
	},

	
	
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
			opts.maxlength = 0; 
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
					out.push(txt.substring(k, j), "<br/>\n");
					k = j + 1;
				} else if (pre && (cc == ' ' || cc == '\t')) {
					out.push(txt.substring(k, j), "&nbsp;");
					if (cc == '\t')
						out.push("&nbsp;&nbsp;&nbsp;");
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
	
	decodeXML: function (txt) {
		var out = "";
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

	
 	cellps0: ' cellpadding="0" cellspacing="0" border="0"',
 	
 	img0: '<img style="height:0;width:0"/>',
 	
 	i0: '<i style="height:0;width:0"/>',
 
 	
	now: jq.now,
	
	
	today: function (fmt) {
		var d = new Date(), hr = 0, min = 0, sec = 0, msec = 0;
		if (typeof fmt == "string") {
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

	
	isAncestor: function (p, c) {
		if (!p) return true;
		for (; c; c = c.getParent ? c.getParent(): c.parent)
			if (p == c)
				return true;
		return false;
	},

	
	
	progressbox: function (id, msg, mask, icon, _opts) {
		if (mask && zk.Page.contained.length) {
			for (var c = zk.Page.contained.length, e = zk.Page.contained[--c]; e; e = zk.Page.contained[--c]) {
				if (!e._applyMask)
					e._applyMask = new zk.eff.Mask({
						id: e.uuid + "-mask",
						message: msg,
						anchor: e.$n()
					});
			}
			return;
		}

		if (_opts && _opts.busy) {
			zk.busy++;
			jq.focusOut(); 
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
		if (mask)
			n.z_mask = new zk.eff.FullMask({
				mask: jq(idmsk, zk)[0],
				zIndex: $txt.css('z-index') - 1
			});

		if (mask && $txt.length) { 
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

				if (pos.indexOf("mouse") >= 0) {
					var offset = zk.currentPointer;
					left = offset[0] + 10;
					top = offset[1] + 10;
				} else {
					if (pos.indexOf("left") >= 0) left = x;
					else if (pos.indexOf("right") >= 0)	left = x + wdgap -1;
					else if (pos.indexOf("center") >= 0) left = x + wdgap / 2;
					else left = 0;
					
					if (pos.indexOf("top") >= 0) top = y;
					else if (pos.indexOf("bottom") >= 0) top = y + hghgap - 1;
					else if (pos.indexOf("center") >= 0) top = y + hghgap / 2;
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
				
				if(j < 0)
					return;
				
				var	un = j >= 0 ? url.substring(0, j): url,
					pn = _pathname(location.href);
				
				j = pn.indexOf('#');
				if (j >= 0) pn = pn.substring(0, j);
				if (pn != un)
					return;
				
			}
			location.reload();
		}
	},

	
	frames: function (w) {
		var ary = [];
		_frames(ary, w);
		return ary;
	},

	
	intsToString: function (ary) {
		if (!ary) return "";

		var sb = [];
		for (var j = 0, k = ary.length; j < k; ++j)
			sb.push(ary[j]);
		return sb.join();
	},
	
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
	
	mapToString: function (map, assign, separator) {
		assign = assign || '=';
		separator = separator || ' ';
		var out = [];
		for (var v in map)
			out.push(separator, v, assign, map[v]);
		out[0] = '';
		return out.join('');
	},
	
	
	appendAttr: function (nm, val, force)  {
		return val || force ? ' ' + nm + '="' + val + '"': "";
	},
	
	fireSized: function (wgt, bfsz) {
		if (zUtl.isImageLoading() || zk.clientinfo) {
			var f = arguments.callee;
			setTimeout(function () {
				return f(wgt, bfsz);
			}, 20);				
			return;
		}
		wgt = _onSizeTarget(wgt);
		if (!(bfsz < 0)) 
			zWatch.fireDown('beforeSize', wgt, null, bfsz > 0);
		zWatch.fireDown('onFitSize', wgt, {reverse: true});
		zWatch.fireDown('onSize', wgt);
	},
	
	fireShown: function (wgt, bfsz) {
		zWatch.fireDown('onShow', wgt);
		zUtl.fireSized(wgt, bfsz);
	},
	
	loadImage: function (url) {
		if (!_imgMap[url]) {
			_imgMap[url] = true;
			_loadImage(url);
		}
	},
	
	isImageLoading: function () {
		for (var img in _imgObjectMap) {
			if (img.complete) {
				try {
					delete _imgMap[img.src];
				} catch (err) {}
				try {
					delete _imgObjectMap[img.src];
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
