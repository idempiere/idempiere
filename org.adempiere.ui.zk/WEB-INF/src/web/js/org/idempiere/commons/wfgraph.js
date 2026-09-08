/* wfgraph.js - client side SVG renderer for the workflow graph
 *
 * Renders the model produced by WFNodeContainer.toJson() as vector SVG.
 * No server round-trip is needed for pan/zoom/selection; node gestures are
 * forwarded to the server as generic ZK events (onNodeClick, onNodeDblClick,
 * onNodeContext, onNodeDrop, onEdgeClick).
 */
if (typeof window.idempiere === 'undefined')
	window.idempiere = {};
if (typeof window.idempiere.wfgraph === 'undefined')
	window.idempiere.wfgraph = {};

(function () {
	var SVG_NS = 'http://www.w3.org/2000/svg';
	var stateByUuid = {};

	function el(name, attrs, parent) {
		var node = document.createElementNS(SVG_NS, name);
		if (attrs) {
			for (var key in attrs) {
				if (Object.prototype.hasOwnProperty.call(attrs, key))
					node.setAttribute(key, attrs[key]);
			}
		}
		if (parent)
			parent.appendChild(node);
		return node;
	}

	function text(parent, x, y, str, attrs) {
		var node = el('text', attrs, parent);
		node.setAttribute('x', x);
		node.setAttribute('y', y);
		node.textContent = str == null ? '' : str;
		return node;
	}

	function wrapLines(str, maxPerLine, maxLines) {
		var out = [];
		if (str == null || str === '')
			return out;
		var words = String(str).split(/\s+/);
		var line = '';
		for (var i = 0; i < words.length; i++) {
			var word = words[i];
			if (word.length > maxPerLine && line === '') {
				while (word.length > maxPerLine) {
					out.push(word.substring(0, maxPerLine));
					word = word.substring(maxPerLine);
					if (out.length >= maxLines) {
						out[out.length - 1] += '…';
						return out;
					}
				}
				line = word;
			} else if ((line + (line ? ' ' : '') + word).length <= maxPerLine) {
				line = line ? line + ' ' + word : word;
			} else {
				out.push(line);
				if (out.length >= maxLines) {
					out[out.length - 1] += '…';
					return out;
				}
				line = word;
			}
		}
		if (line)
			out.push(line);
		if (out.length > maxLines) {
			out = out.slice(0, maxLines);
			out[out.length - 1] += '…';
		}
		return out;
	}

	function truncate(str, max) {
		str = str == null ? '' : String(str);
		return str.length > max ? str.substring(0, max - 1) + '…' : str;
	}

	function nodeById(model, id) {
		for (var i = 0; i < model.nodes.length; i++) {
			if (model.nodes[i].id === id)
				return model.nodes[i];
		}
		return null;
	}

	function hasReverseEdge(model, from, to) {
		for (var i = 0; i < model.edges.length; i++) {
			var e = model.edges[i];
			if (e.from === to && e.to === from)
				return true;
		}
		return false;
	}

	function selfLoopPath(x, y, w, h, index) {
		var right = x + w, bottom = y + h;
		var size = Math.max(20 - Math.floor(index / 2) * 5, 10);
		var inset = 28;
		if (index % 2 === 0) {
			return 'M ' + right + ' ' + (bottom - inset)
				+ ' H ' + (right + size)
				+ ' V ' + (bottom + size)
				+ ' H ' + (right - inset)
				+ ' V ' + bottom;
		}
		var left = x;
		return 'M ' + left + ' ' + (bottom - inset)
			+ ' H ' + (left - size)
			+ ' V ' + (bottom + size)
			+ ' H ' + (left + inset)
			+ ' V ' + bottom;
	}

	/* Orthogonal connector between two node boxes. */
	function edgePath(model, edge, selfIndex) {
		var a = nodeById(model, edge.from);
		var b = nodeById(model, edge.to);
		if (!a || !b)
			return null;
		var nw = model.nodeW, nh = model.nodeH;
		if (edge.from === edge.to)
			return selfLoopPath(a.x, a.y, nw, nh, selfIndex || 0);

		var ax = a.x + nw / 2, ay = a.y + nh / 2;
		var bx = b.x + nw / 2, by = b.y + nh / 2;
		var off = hasReverseEdge(model, edge.from, edge.to) ? 7 : 0;

		var x1, y1, x2, y2;
		if (a.row === b.row) {
			// same row: straight horizontal side to side
			if (a.col < b.col) {
				x1 = a.x + nw; y1 = ay + off;
				x2 = b.x; y2 = by + off;
			} else {
				x1 = a.x; y1 = ay - off;
				x2 = b.x + nw; y2 = by - off;
			}
			return 'M ' + x1 + ' ' + y1 + ' H ' + x2 + ' V ' + y2;
		}
		if (ay < by) {
			// target below: bottom center to top center
			x1 = ax + off; y1 = a.y + nh;
			x2 = bx + off; y2 = b.y;
		} else {
			// target above: top center to bottom center
			x1 = ax - off; y1 = a.y;
			x2 = bx - off; y2 = b.y + nh;
		}
		var midY = (y1 + y2) / 2;
		return 'M ' + x1 + ' ' + y1 + ' V ' + midY + ' H ' + x2 + ' V ' + y2;
	}

	function edgeLabel(edge) {
		var desc = edge.description || '';
		if (desc !== '')
			return '{' + edge.seq + ': ' + desc + '}';
		return '{' + edge.seq + '}';
	}

	/* Geometric midpoint between two node centers, used when the path
	 * geometry API is unavailable for label placement. */
	function edgeMidpoint(model, edge) {
		var a = nodeById(model, edge.from);
		if (!a)
			return null;
		if (edge.from === edge.to)
			return { x: a.x + model.nodeW, y: a.y + model.nodeH / 2 };
		var b = nodeById(model, edge.to);
		if (!b)
			return null;
		return {
			x: (a.x + b.x) / 2 + model.nodeW / 2,
			y: (a.y + b.y) / 2 + model.nodeH / 2
		};
	}

	function sendEvent(wgt, name, data) {
		if (!wgt)
			return;
		zAu.send(new zk.Event(wgt, name, data, { toServer: true }));
	}

	function getState(uuid, model) {
		var st = stateByUuid[uuid];
		if (!st) {
			st = { scale: 1, selected: -1 };
			stateByUuid[uuid] = st;
		}
		st.model = model;
		return st;
	}

	function applyZoom(root, svg, st, canvasW, canvasH) {
		var w = Math.round(canvasW * st.scale);
		var h = Math.round(canvasH * st.scale);
		svg.setAttribute('width', w);
		svg.setAttribute('height', h);
		var label = root.querySelector('.wf-zoom-label');
		if (label)
			label.textContent = Math.round(st.scale * 100) + '%';
	}

	function zoomTo(st, root, svg, canvasW, canvasH, scale) {
		st.scale = Math.min(2.5, Math.max(0.2, scale));
		applyZoom(root, svg, st, canvasW, canvasH);
	}

	function zoomFit(st, root, svg, canvasW) {
		var avail = root.clientWidth || canvasW;
		zoomTo(st, root, svg, canvasW, st.canvasH || 0, avail / canvasW);
	}

	function renderToolbar(root, svg, st, canvasW, canvasH, opts) {
		opts = opts || {};
		var editable = !!opts.editable;
		var bar = document.createElement('div');
		bar.className = 'wf-toolbar';
		bar.style.cssText = 'display:flex;align-items:center;gap:4px;padding:4px 6px;'
			+ 'background:#f6f8fa;border:1px solid #d0d7de;border-radius:6px;margin-bottom:6px;'
			+ 'font-family:sans-serif;font-size:12px;position:sticky;top:0;z-index:5;';
		function btn(label, title, fn) {
			var b = document.createElement('button');
			b.type = 'button';
			b.className = 'wf-tbtn';
			b.textContent = label;
			b.title = title;
			b.style.cssText = 'min-width:26px;padding:2px 8px;cursor:pointer;border:1px solid #d0d7de;'
				+ 'border-radius:4px;background:#fff;color:#24292f;font-size:12px;';
			b.addEventListener('click', function (ev) {
				ev.preventDefault();
				fn();
			});
			bar.appendChild(b);
			return b;
		}
		btn('−', opts.zoomOut || 'Zoom out', function () {
			zoomTo(st, root, svg, canvasW, canvasH, st.scale - 0.1);
		});
		var zl = document.createElement('span');
		zl.className = 'wf-zoom-label';
		zl.style.cssText = 'min-width:42px;text-align:center;color:#57606a;';
		bar.appendChild(zl);
		btn('+', opts.zoomIn || 'Zoom in', function () {
			zoomTo(st, root, svg, canvasW, canvasH, st.scale + 0.1);
		});
		btn('⤢', opts.fitToWidth || 'Fit to width', function () {
			zoomFit(st, root, svg, canvasW);
		});
		btn('1:1', opts.actualSize || 'Actual size', function () {
			zoomTo(st, root, svg, canvasW, canvasH, 1);
		});
		if (editable) {
			var hint = document.createElement('span');
			hint.className = 'wf-hint';
			hint.style.cssText = 'margin-left:auto;color:#57606a;';
			hint.textContent = opts.hint || 'Drag nodes to move • Right-click for actions';
			bar.appendChild(hint);
		}
		root.appendChild(bar);
	}

	function renderNode(layer, model, node, st, wgt, opts, rerender) {
		var nw = model.nodeW, nh = model.nodeH;
		var g = el('g', {
			'class': 'wf-node' + (st.selected === node.id ? ' selected' : ''),
			'transform': 'translate(' + node.x + ',' + node.y + ')',
			'tabindex': '0',
			'role': 'button',
			'data-id': node.id
		}, layer);
		g.setAttribute('aria-label', node.name || ('Node ' + node.id));

		el('rect', {
			'class': 'wf-node-box', 'width': nw, 'height': nh, 'rx': '6'
		}, g);

		// action glyph
		el('circle', { 'class': 'wf-glyph', 'cx': '18', 'cy': '18', 'r': '10' }, g);
		var glyph = el('text', { 'class': 'wf-glyph-text', 'x': '18', 'y': '22', 'text-anchor': 'middle' }, g);
		glyph.textContent = node.actionKey || '•';

		var title = el('text', { 'class': 'wf-title', 'x': '34', 'y': '22' }, g);
		title.textContent = truncate(node.name, 17);

		el('line', { 'class': 'wf-sep', 'x1': '8', 'y1': '32', 'x2': String(nw - 8), 'y2': '32' }, g);

		var lines = wrapLines(node.description, 22, 2);
		for (var i = 0; i < lines.length; i++) {
			text(g, 12, 50 + i * 15, lines[i], { 'class': 'wf-desc' });
		}
		if (node.actionLabel) {
			text(g, 12, nh - 10, truncate(node.actionLabel, 24), { 'class': 'wf-action' });
		}

		var tip = el('title', null, g);
		tip.textContent = (node.name || '') + (node.help ? '\n' + node.help : '');

		g.addEventListener('click', function (ev) {
			ev.stopPropagation();
			st.selected = node.id;
			var boxes = layer.querySelectorAll('.wf-node');
			for (var k = 0; k < boxes.length; k++)
				boxes[k].classList.remove('selected');
			g.classList.add('selected');
			sendEvent(wgt, 'onNodeClick', { nodeId: node.id });
		});
		g.addEventListener('dblclick', function (ev) {
			ev.stopPropagation();
			sendEvent(wgt, 'onNodeDblClick', { nodeId: node.id });
		});
		g.addEventListener('contextmenu', function (ev) {
			ev.preventDefault();
			ev.stopPropagation();
			sendEvent(wgt, 'onNodeContext', { nodeId: node.id });
		});
		g.addEventListener('keydown', function (ev) {
			if (ev.key === 'Enter' || ev.key === ' ') {
				ev.preventDefault();
				sendEvent(wgt, 'onNodeClick', { nodeId: node.id });
			}
		});

		if (opts.editable)
			attachDrag(g, model, node, st, wgt, opts, rerender);
	}

	function attachDrag(g, model, node, st, wgt, opts, rerender) {
		g.style.touchAction = 'none';
		g.addEventListener('pointerdown', function (ev) {
			if (ev.button !== 0)
				return;
			ev.stopPropagation();
			var svg = g.ownerSVGElement;
			var startPX = ev.clientX, startPY = ev.clientY;
			var origX = node.x, origY = node.y;
			var dragging = false;
			try { g.setPointerCapture(ev.pointerId); } catch (ignore) { /* noop */ }

			function toSvg(dx, dy) {
				var scale = st.scale || 1;
				return { dx: dx / scale, dy: dy / scale };
			}
			function onMove(mev) {
				var d = toSvg(mev.clientX - startPX, mev.clientY - startPY);
				if (!dragging && Math.abs(d.dx) + Math.abs(d.dy) > 4) {
					dragging = true;
					g.classList.add('dragging');
				}
				if (!dragging)
					return;
				var nx = Math.max(0, Math.min(opts.canvasW - model.nodeW, origX + d.dx));
				var ny = Math.max(0, Math.min(opts.canvasH - model.nodeH, origY + d.dy));
				node.x = nx; node.y = ny;
				g.setAttribute('transform', 'translate(' + nx + ',' + ny + ')');
				updateEdges(svg, model);
				mev.preventDefault();
			}
			function onUp(uev) {
				g.removeEventListener('pointermove', onMove);
				g.removeEventListener('pointerup', onUp);
				g.removeEventListener('pointercancel', onUp);
				g.classList.remove('dragging');
				if (!dragging)
					return;
				var col = Math.min((model.cols+1), Math.max(1, Math.floor((node.x + model.nodeW / 2) / model.colW) + 1));
				var row = Math.min((model.rows+1), Math.max(1, Math.floor((node.y + model.nodeH / 2) / model.rowH) + 1));
				// snap back to the grid so the node never rests between cells
				node.x = (col - 1) * model.colW + (model.colW - model.nodeW) / 2;
				node.y = (row - 1) * model.rowH + (model.rowH - model.nodeH) / 2;	
				rerender();			
				if (col !== node.col || row !== node.row) {
					sendEvent(wgt, 'onNodeDrop', { nodeId: node.id, row: row, col: col });
				}								
				uev.stopPropagation();
			}
			g.addEventListener('pointermove', onMove);
			g.addEventListener('pointerup', onUp);
			g.addEventListener('pointercancel', onUp);
		});
	}

	/* All routed paths (visible + invisible hit area) of the scene. */
	function edgePaths(svg) {
		var out = [];
		var lists = [svg.querySelectorAll('path.wf-edge'), svg.querySelectorAll('path.wf-edge-hit')];
		for (var l = 0; l < lists.length; l++) {
			for (var i = 0; i < lists[l].length; i++)
				out.push(lists[l][i]);
		}
		return out;
	}

	function isEdgePath(p, edge) {
		return String(p.getAttribute('data-from')) === String(edge.from)
			&& String(p.getAttribute('data-to')) === String(edge.to);
	}

	/* Highlight an edge together with its label, source and destination nodes. */
	function setEdgeHighlight(svg, nodeLayer, edge, on) {
		var paths = edgePaths(svg);
		for (var i = 0; i < paths.length; i++) {
			if (isEdgePath(paths[i], edge))
				paths[i].classList.toggle('hl', on);
		}
		var labels = svg.querySelectorAll('text.wf-edge-label');
		for (var j = 0; j < labels.length; j++) {
			if (isEdgePath(labels[j], edge))
				labels[j].classList.toggle('hl', on);
		}
		if (!nodeLayer || !nodeLayer.children)
			return;
		for (var k = 0; k < nodeLayer.children.length; k++) {
			var g = nodeLayer.children[k];
			if (!g.getAttribute)
				continue;
			var id = g.getAttribute('data-id');
			if (id != null && (String(id) === String(edge.from) || String(id) === String(edge.to)))
				g.classList.toggle('hl', on);
		}
	}

	function wireEdgeHover(target, svg, nodeLayer, edge) {
		target.addEventListener('mouseenter', function () {
			setEdgeHighlight(svg, nodeLayer, edge, true);
		});
		target.addEventListener('mouseleave', function () {
			setEdgeHighlight(svg, nodeLayer, edge, false);
		});
	}

	function updateEdges(svg, model) {
		var lists = [svg.querySelectorAll('path.wf-edge'), svg.querySelectorAll('path.wf-edge-hit')];
		for (var l = 0; l < lists.length; l++) {
			var selfCount = {};
			for (var i = 0; i < lists[l].length; i++) {
				var p = lists[l][i];
				var from = parseInt(p.getAttribute('data-from'), 10);
				var to = parseInt(p.getAttribute('data-to'), 10);
				var d;
				if (from === to) {
					var key = 's' + from;
					selfCount[key] = (selfCount[key] || 0);
					d = edgePath(model, { from: from, to: to }, selfCount[key]);
					selfCount[key]++;
				} else {
					d = edgePath(model, { from: from, to: to });
				}
				if (d)
					p.setAttribute('d', d);
			}
		}
	}

	function renderEdges(layer, model, wgt, nodeLayer, labelLayer) {
		var svg = layer.ownerSVGElement;
		var selfCount = {};
		for (var i = 0; i < model.edges.length; i++) {
			(function (edge) {
				var d;
				if (edge.from === edge.to) {
					var key = 's' + edge.from;
					selfCount[key] = selfCount[key] || 0;
					d = edgePath(model, edge, selfCount[key]);
					selfCount[key]++;
				} else {
					d = edgePath(model, edge, 0);
				}
				if (!d)
					return;
				var p = el('path', {
					'class': 'wf-edge',
					'd': d,
					'data-from': edge.from,
					'data-to': edge.to,
					'tabindex': '0',
					'role': 'button'
				}, layer);
				p.setAttribute('aria-label', edgeLabel(edge) || ('Transition ' + edge.from + ' to ' + edge.to));
				// wide invisible hit area so the 1.5px line is easy to hover
				var hit = el('path', {
					'class': 'wf-edge-hit',
					'd': d,
					'data-from': edge.from,
					'data-to': edge.to
				}, layer);
				function fireEdgeClick(ev) {
					ev.stopPropagation();
					sendEvent(wgt, 'onEdgeClick', { from: edge.from, to: edge.to });
				}
				wireEdgeHover(p, svg, nodeLayer, edge);
				wireEdgeHover(hit, svg, nodeLayer, edge);
				p.addEventListener('click', fireEdgeClick);
				hit.addEventListener('click', fireEdgeClick);
				p.addEventListener('keydown', function (ev) {
					if (ev.key === 'Enter' || ev.key === ' ') {
						ev.preventDefault();
						fireEdgeClick(ev);
					}
				});
				var label = edgeLabel(edge);
				if (label !== '') {
					// labels live on the top layer so a midpoint overlapping
					// a node box is never painted over; they are click-through
					// (interaction goes through the hit path underneath)
					var lt = text(labelLayer || layer, 0, -4, label, {
						'class': 'wf-edge-label',
						'data-from': edge.from,
						'data-to': edge.to
					});
					var mid = p.getTotalLength ? p.getPointAtLength(p.getTotalLength() / 2) : edgeMidpoint(model, edge);
					if (mid) {
						lt.setAttribute('x', mid.x);
						lt.setAttribute('y', mid.y - 4);
					}
				}
			})(model.edges[i]);
		}
	}

	function render(uuid, model, opts) {
		model = model || {};
		model.nodes = model.nodes || [];
		model.edges = model.edges || [];
		model.colW = model.colW || 200;
		model.rowH = model.rowH || 150;
		model.nodeW = model.nodeW || 150;
		model.nodeH = model.nodeH || 100;
		model.cols = model.cols || 4;
		model.rows = model.rows || 1;
		opts = opts || {};

		var wgt = (typeof zk !== 'undefined' && zk.Widget) ? zk.Widget.$(uuid) : null;
		var root = wgt ? wgt.$n() : document.getElementById(uuid);
		if (!root)
			return;
		var st = getState(uuid, model);

		while (root.firstChild)
			root.removeChild(root.firstChild);

		var canvasW = (model.cols+1) * model.colW;
		var canvasH = Math.max(1, (model.rows+1)) * model.rowH;

		var svg = el('svg', {
			'class': 'wf-canvas',
			'role': 'img',
			'aria-label': opts.graphLabel || 'Workflow graph',
			'viewBox': '0 0 ' + canvasW + ' ' + canvasH
		}, null);
		// width/height attributes drive the zoom level via the viewBox;
		// keep theme CSS from clamping the svg back to container width
		svg.style.display = 'block';
		svg.style.maxWidth = 'none';
		renderToolbar(root, svg, st, canvasW, canvasH, opts);
		st.canvasH = canvasH;
		root.appendChild(svg);

		var defs = el('defs', null, svg);
		var style = document.createElementNS(SVG_NS, 'style');
		style.textContent = '.wf-grid-dot{fill:#d0d7de}.wf-node-box{fill:#fff;stroke:#8c959f;stroke-width:1.2}'
			+ '.wf-node{cursor:pointer}.wf-node:hover .wf-node-box{stroke:#0969da;stroke-width:2}'
			+ '.wf-node.selected .wf-node-box{stroke:#0969da;stroke-width:2.5;fill:#ddf4ff}'
			+ '.wf-node.dragging{opacity:.75}.wf-node:focus{outline:none}'
			+ '.wf-node:focus .wf-node-box{stroke:#0969da;stroke-width:2.5;stroke-dasharray:5 2}'
			+ '.wf-glyph{fill:#57606a}.wf-glyph-text{fill:#fff;font-size:11px;font-weight:bold}'
			+ '.wf-title{font-size:12px;font-weight:bold;fill:#24292f;font-family:sans-serif}'
			+ '.wf-desc{font-size:11px;fill:#24292f;font-family:sans-serif}'
			+ '.wf-action{font-size:10px;fill:#57606a;font-family:sans-serif}'
			+ '.wf-sep{stroke:#d0d7de;stroke-width:1}'
			+ '.wf-edge{fill:none;stroke:#57606a;stroke-width:1.5;cursor:pointer;marker-end:url(#' + uuid + '-arrow)}'
			+ '.wf-edge.hl{stroke:#0969da;stroke-width:2.5}'
			+ '.wf-edge:focus{outline:none;stroke:#0969da;stroke-width:2.5}'
			+ '.wf-edge-hit{fill:none;stroke:rgba(0,0,0,0);stroke-width:14;pointer-events:stroke;cursor:pointer}'
			+ '.wf-node.hl .wf-node-box{stroke:#0969da;stroke-width:2.5}'
			+ '.wf-arrow{fill:#57606a}'
			+ '.wf-edge-label{font-size:10px;fill:#24292f;font-family:sans-serif;paint-order:stroke;stroke:#fff;stroke-width:3px;pointer-events:none}'
			+ '.wf-edge-label.hl{fill:#0969da;font-weight:bold}'
			+ '.wf-empty{font-size:13px;fill:#57606a;font-family:sans-serif}';
		defs.appendChild(style);
		var marker = el('marker', {
			'id': uuid + '-arrow', 'viewBox': '0 0 10 10', 'refX': '9', 'refY': '5',
			'markerWidth': '7', 'markerHeight': '7', 'orient': 'auto-start-reverse'
		}, defs);
		el('path', { 'd': 'M 0 1 L 9 5 L 0 9 z', 'class': 'wf-arrow' }, marker);

		var pattern = el('pattern', {
			'id': uuid + '-grid', 'width': model.colW, 'height': model.rowH,
			'patternUnits': 'userSpaceOnUse'
		}, defs);
		el('circle', { 'cx': '1.5', 'cy': '1.5', 'r': '1.5', 'class': 'wf-grid-dot' }, pattern);

		el('rect', {
			'x': '0', 'y': '0', 'width': canvasW, 'height': canvasH,
			'fill': 'url(#' + uuid + '-grid)', 'class': 'wf-grid'
		}, svg);

		var edgeLayer = el('g', { 'class': 'wf-edges' }, svg);
		var nodeLayer = el('g', { 'class': 'wf-nodes' }, svg);
		var labelLayer = el('g', { 'class': 'wf-labels' }, svg);

		renderEdges(edgeLayer, model, wgt, nodeLayer, labelLayer);

		function rerender() {
			render(uuid, st.model, opts);
		}
		for (var i = 0; i < model.nodes.length; i++) {
			renderNode(nodeLayer, model, model.nodes[i], st, wgt, {
				editable: !!opts.editable, canvasW: canvasW, canvasH: canvasH
			}, rerender);
		}

		applyZoom(root, svg, st, canvasW, canvasH);

		svg.addEventListener('wheel', function (ev) {
			if (!ev.ctrlKey && !ev.metaKey)
				return;
			ev.preventDefault();
			zoomTo(st, root, svg, canvasW, canvasH, st.scale + (ev.deltaY < 0 ? 0.1 : -0.1));
		}, { passive: false });

		if (model.nodes.length === 0) {
			text(svg, 20, 30, opts.emptyText || 'No workflow nodes', { 'class': 'wf-empty' });
		}
	}

	window.idempiere.wfgraph.render = render;
	window.idempiere.wfgraph.edgePath = edgePath;
	window.idempiere.wfgraph.dispose = function (uuid) {
		delete stateByUuid[uuid];
	};
})();
