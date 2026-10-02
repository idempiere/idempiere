/* wfgraph.js - client side SVG renderer for the workflow graph
 *
 * Renders the model produced by WFNodeContainer.toJson() as vector SVG.
 * No server round-trip is needed for pan/zoom/selection; node gestures are
 * forwarded to the server as generic ZK events (onNodeClick, onNodeContext,
 * onNodeDrop, onEdgeClick).
 */
if (typeof window.idempiere === 'undefined')
	window.idempiere = {};
if (typeof window.idempiere.wfgraph === 'undefined')
	window.idempiere.wfgraph = {};

(function () {
	var SVG_NS = 'http://www.w3.org/2000/svg';
	var stateByUuid = {};
	/* Minimum length of the perpendicular stub leaving or entering a card
	 * border, so corners and arrow heads never sit on the card edge. */
	var MIN_STUB = 12;

	/* Create an SVG element with attributes and append it to parent. */
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

	/* Create an SVG text element at (x, y) with string content. */
	function text(parent, x, y, str, attrs) {
		var node = el('text', attrs, parent);
		node.setAttribute('x', x);
		node.setAttribute('y', y);
		node.textContent = str == null ? '' : str;
		return node;
	}

	/* Wrap a string into at most maxLines lines of maxPerLine chars on word boundaries. */
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

	/* Shorten a string to max chars with an ellipsis. */
	function truncate(str, max) {
		str = str == null ? '' : String(str);
		return str.length > max ? str.substring(0, max - 1) + '…' : str;
	}

	/* Find a node by id, or null. */
	function nodeById(model, id) {
		for (var i = 0; i < model.nodes.length; i++) {
			if (model.nodes[i].id === id)
				return model.nodes[i];
		}
		return null;
	}

	/* True when two edges share the id, falling back to identity. */
	function sameEdge(a, b) {
		if (a && b && a.id !== undefined && b.id !== undefined)
			return String(a.id) === String(b.id);
		return a === b;
	}

	/* Position of a grid line. prepareLanes pushes interior lines apart when
	 * many connectors share them; without tables the uniform spacing holds. */
	function colPos(model, k) {
		return (model._colX && model._colX[k] !== undefined) ? model._colX[k] : k * model.colW;
	}

	/* Position of a row grid line, mirroring colPos. */
	function rowPos(model, k) {
		return (model._rowY && model._rowY[k] !== undefined) ? model._rowY[k] : k * model.rowH;
	}

	/* Select the side of a node box a transition leaves from. Outgoing
	 * connections only use the right or the bottom card border: to the right
	 * when the target sits in a later column, otherwise downward. */
	function exitSide(model, edge) {
		var a = nodeById(model, edge.from);
		var b = nodeById(model, edge.to);
		if (!a || !b)
			return 'R';
		if (edge.from === edge.to)
			return 'B';
		return b.col > a.col ? 'R' : 'B';
	}

	/* Select the side of the target node box the transition enters. Incoming
	 * connections only use the top or the left card border. */
	function entrySide(model, edge) {
		var s = exitSide(model, edge);
		return s === 'R' ? 'L' : 'T';
	}

	/* Fractional anchor position along a card side, dividing the border into
	 * as many equal segments as there are connections on that side: one
	 * connection sits on the middle, two on the middles of the two halves,
	 * three on the middles of the thirds, and so on. */
	function anchorFraction(model, edge, exit) {
		var nodeId = exit ? edge.from : edge.to;
		var side = exit ? exitSide(model, edge) : entrySide(model, edge);
		var idx = 0, count = 0;
		for (var i = 0; i < model.edges.length; i++) {
			var e = model.edges[i];
			var eid = exit ? e.from : e.to;
			if (eid !== nodeId)
				continue;
			var es = exit ? exitSide(model, e) : entrySide(model, e);
			if (es !== side)
				continue;
			if (sameEdge(e, edge))
				idx = count;
			count++;
		}
		return (idx + 0.5) / count - 0.5;
	}

	/* Tie breaker so stubs from different cards on the same grid line never
	 * share the exact anchor coordinate: horizontal stubs (R/L) shift with
	 * the column, vertical stubs (B/T) with the row, by half a lane step.
	 * Direct connectors skip the shift so centre-to-centre neighbours stay
	 * a single straight segment without tiny kinks. The shift stays inside
	 * the card via the clamp in the anchor helpers. */
	function anchorY(a, frac, nh, noTie) {
		var y = a.y + nh * (0.5 + frac) + (noTie ? 0 : a.col * 1.5);
		return Math.min(a.y + nh - 2, Math.max(a.y + 2, y));
	}

	/* X anchor on a vertical card side, mirroring anchorY. */
	function anchorX(a, frac, nw, noTie) {
		var x = a.x + nw * (0.5 + frac) + (noTie ? 0 : a.row * 1.5);
		return Math.min(a.x + nw - 2, Math.max(a.x + 2, x));
	}

	/* True when the edge crosses empty cells directly instead of using the
	 * corridor gutters. Only needs the grid positions, so it can be asked
	 * from the anchor helpers before lanes are assigned. */
	function isDirectEdge(model, edge) {
		var a = nodeById(model, edge.from);
		var b = nodeById(model, edge.to);
		if (!a || !b)
			return false;
		return !!directJog(model, edge, a, b);
	}

	/* Corridor channels: a connector segment runs either on a column lane
	 * ('c' plus the x of a column boundary) or on a row lane ('r' plus the y
	 * of a row boundary). Every edge joining a channel gets its own small
	 * offset, so parallel connectors never lie exactly on top of each other
	 * and stay distinguishable. */
	function cKey(coordinate) {
		return 'c' + coordinate;
	}

	/* Channel key for a row grid line coordinate, mirroring cKey. */
	function rKey(coordinate) {
		return 'r' + coordinate;
	}

	/* Lane offset of an edge in a channel, or 0. */
	function offOf(edge, key) {
		return (edge._off && edge._off[key]) || 0;
	}

	/* Entry-side offset: an edge joining the same channel with both its exit
	 * and its entry stub (neighbouring columns or rows) keeps the entry
	 * offset under a separate key, so the two stub ends never cross. */
	function offOfIn(edge, key) {
		var offs = edge._off;
		if (offs && offs[key + ':2'] !== undefined)
			return offs[key + ':2'];
		return (offs && offs[key]) || 0;
	}

	/* True when the edge carries a label chip and needs clearance around
	 * its corridor lane. */
	function isChipped(edge) {
		return !!(edge.description && edge.description !== '');
	}

	/* Widen the gutters around grid lines that carry many connectors so
	 * the lane distance never has to shrink. The extra half gutter
	 * shifts the neighbouring columns/rows apart. */
	function channelExtra(halfSpan, model, isCol, b) {
		var h = halfSpan[(isCol ? 'c' : 'r') + (b * (isCol ? model.colW : model.rowH))];
		return h === undefined ? 0 : Math.max(0, Math.ceil(h) - 22);
	}

	/* Assign every edge its lane offsets. Must run before routing, e.g.
	 * before edgePath, after every model change (initial render, drag).
	 * Within a channel, exit stubs sort before corridor-only segments and
	 * entry stubs sort last, so opposite stub ends in a shared gutter can
	 * never cross and overlap. Direct jogs are topologically ordered so an
	 * exit stub never runs past the entry stub of another direct connector
	 * sharing the same anchor position. */
	function prepareLanes(model) {
		var channels = {};
		var selfCount = {};
		model._chanLanes = {};
		function join(key, edge, role) {
			(channels[key] = channels[key] || []).push({ e: edge, r: role });
		}
		for (var i = 0; i < model.edges.length; i++) {
			var edge = model.edges[i];
			var a = nodeById(model, edge.from);
			var b = nodeById(model, edge.to);
			if (!a || !b)
				continue;
			edge._dj = null;
			edge._off = {};
			if (edge.from === edge.to) {
				var sk = 's' + a.id;
				edge._selfIndex = selfCount[sk] || 0;
				selfCount[sk] = (selfCount[sk] || 0) + 1;
				var sc = edge._selfIndex % 2 === 0 ? a.col * model.colW : (a.col - 1) * model.colW;
				join(cKey(sc), edge, 1);
				join(rKey(a.row * model.rowH), edge, 0);
				join(rKey((a.row - 1) * model.rowH), edge, 2);
				continue;
			}
			var ea = exitAnchor(model, a, edge);
			var eb = entryAnchor(model, b, edge);
			// direct routes only share the lane of their jog (if any), they
			// never touch the grid-line corridors
			var dj = directJog(model, edge, a, b);
			if (dj) {
				edge._dj = {
					horizontal: dj.horizontal,
					// vertical stubs sit on x, horizontal stubs on y
					exitPos: dj.horizontal ? ea.p.x : ea.p.y,
					entryPos: dj.horizontal ? eb.p.x : eb.p.y,
					exitLine: dj.horizontal ? a.row : a.col,
					entryLine: dj.horizontal ? b.row : b.col
				};
				join(dj.horizontal ? rKey(dj.idx * model.rowH) : cKey(dj.idx * model.colW), edge, 1);
				continue;
			}
			var exit = exitSide(model, edge);
			var entry = entrySide(model, edge);
			if (exit === 'R' || entry === 'L') {
				var ce = a.col * model.colW;
				var ci = (b.col - 1) * model.colW;
				join(cKey(ce), edge, exit === 'R' ? 0 : 1);
				join(cKey(ci), edge, entry === 'L' ? 2 : 1);
				// kink line between the two node rows (stable across relayout)
				var kRow = Math.max(0, Math.min(model.rows, Math.floor(((a.row - 1) + (b.row - 1)) / 2 + 0.5)));
				join(rKey(kRow * model.rowH), edge, 1);
			}
			if (exit === 'B' || entry === 'T') {
				var re = a.row * model.rowH;
				var ri = (b.row - 1) * model.rowH;
				join(rKey(re), edge, exit === 'B' ? 0 : 1);
				join(rKey(ri), edge, entry === 'T' ? 2 : 1);
				// kink column between the two node columns
				var kCol = Math.max(0, Math.min(model.cols, Math.floor(((a.col - 1) + (b.col - 1)) / 2 + 0.5)));
				join(cKey(kCol * model.colW), edge, 1);
			}
		}
		var keys = Object.keys(channels);
		var halfSpan = {};
		for (var k = 0; k < keys.length; k++) {
			var list = channels[keys[k]];
			// topological order of the direct jogs of this channel: when the
			// exit stub of one edge shares the anchor position of the entry
			// stub of another, the first must jog first
			var dms = [];
			for (var d = 0; d < list.length; d++)
				if (list[d].e._dj)
					dms.push(d);
			if (dms.length > 1) {
				var succ = {};
				var indeg = [];
				for (var u = 0; u < dms.length; u++)
					indeg.push(0);
				for (var u2 = 0; u2 < dms.length; u2++) {
					for (var v2 = u2 + 1; v2 < dms.length; v2++) {
						var g1 = list[dms[u2]].e._dj;
						var g2 = list[dms[v2]].e._dj;
						var first = 0;
						if (Math.abs(g2.exitPos - g1.entryPos) < 1.5 && g2.exitLine < g1.entryLine)
							first = 1;
						else if (Math.abs(g1.exitPos - g2.entryPos) < 1.5 && g1.exitLine < g2.entryLine)
							first = 0;
						else
							continue;
						var pre = first === 0 ? u2 : v2;
						var post = first === 0 ? v2 : u2;
						(succ[pre] = succ[pre] || []).push(post);
						indeg[post]++;
					}
				}
				var topo = [];
				var avail = [];
				for (var w = 0; w < dms.length; w++)
					if (indeg[w] === 0)
						avail.push(w);
				while (avail.length) {
					avail.sort(function (x, y) { return x - y; });
					var cur = avail.shift();
					topo.push(cur);
					var outs = succ[cur] || [];
					for (var t = 0; t < outs.length; t++)
						if (--indeg[outs[t]] === 0)
							avail.push(outs[t]);
				}
				for (var w2 = 0; w2 < dms.length; w2++)
					if (topo.indexOf(w2) < 0)
						topo.push(w2);
				for (var w3 = 0; w3 < dms.length; w3++)
					list[dms[topo[w3]]].topo = w3;
			}
			list.sort(function (u, v) {
				if (u.r !== v.r)
					return u.r - v.r;
				return (u.e._dj ? 1 + (u.topo || 0) : 0) - (v.e._dj ? 1 + (v.topo || 0) : 0);
			});
			var m = list.length;
			// lane gaps: 14 px next to a label chip so parallel connectors
			// keep clear of it, 3 px otherwise; the gutter widens below to
			// fit the resulting spread
			var rel = [0];
			for (var j = 1; j < m; j++)
				rel.push(rel[j - 1] + ((isChipped(list[j].e) || isChipped(list[j - 1].e)) ? 14 : 3));
			var mid = m > 1 ? rel[m - 1] / 2 : 0;
			var maxAbs = 0;
			var chanLanes = [];
			for (var j = 0; j < m; j++) {
				var off = m > 1 ? Math.round((rel[j] - mid) * 10) / 10 : 0;
				maxAbs = Math.max(maxAbs, Math.abs(off));
				chanLanes.push(off);
				var mem = list[j].e._off = list[j].e._off || {};
				if (mem[keys[k]] === undefined)
					mem[keys[k]] = off;
				else
					mem[keys[k] + ':2'] = off;
			}
			halfSpan[keys[k]] = maxAbs;
			model._chanLanes[keys[k]] = chanLanes;
		}
		// extra half gutter per grid line from the actual lane spread, then
		// the position tables including the outer connection margin
		var colE = [], rowE = [];
		for (var b = 0; b <= model.cols + 1; b++)
			colE.push(channelExtra(halfSpan, model, true, b));
		for (var b2 = 0; b2 <= model.rows + 1; b2++)
			rowE.push(channelExtra(halfSpan, model, false, b2));
		var m0 = (model.colW - model.nodeW) / 2;
		var n0 = (model.rowH - model.nodeH) / 2;
		var colX = [m0 + colE[0]];
		for (var xk = 1; xk <= model.cols + 1; xk++)
			colX.push(colX[xk - 1] + model.colW + colE[xk - 1] + colE[xk]);
		var rowY = [n0 + rowE[0]];
		for (var yk = 1; yk <= model.rows + 1; yk++)
			rowY.push(rowY[yk - 1] + model.rowH + rowE[yk - 1] + rowE[yk]);
		model._colX = colX;
		model._rowY = rowY;
		model._colE = colE;
		model._rowE = rowE;
		model._canvasW = colX[model.cols] + model.colW + 2 * colE[model.cols] + m0;
		model._canvasH = rowY[model.rows] + model.rowH + 2 * rowE[model.rows] + n0;
	}

	/* Stub end clamped to the minimum perpendicular stub length. Same-side
	 * siblings that would collapse onto one point are spread apart in lane
	 * order and skip lanes already in use, so their trunks stay
	 * distinguishable. boundaryPos/lanePos/borderPos are coordinates along
	 * the stub axis; useIn selects the entry side lane variant. */
	function clampStubEnd(model, edge, exit, side, key, useIn, boundaryPos, lanePos, borderPos) {
		var dir = (side === 'R' || side === 'B') ? 1 : -1;
		if (dir * (lanePos - borderPos) >= MIN_STUB)
			return lanePos;
		// siblings share the grid line and side (and thereby the border and
		// the channel), even across different nodes of the same row/column
		var selfNode = nodeById(model, exit ? edge.from : edge.to);
		var selfLine = !selfNode ? -1 : ((side === 'R' || side === 'L') ? selfNode.col : selfNode.row);
		var sibs = [];
		for (var i = 0; i < model.edges.length; i++) {
			var e = model.edges[i];
			var n = nodeById(model, exit ? e.from : e.to);
			if (!n)
				continue;
			var ln = (side === 'R' || side === 'L') ? n.col : n.row;
			if (ln !== selfLine)
				continue;
			var es = exit ? exitSide(model, e) : entrySide(model, e);
			if (es !== side)
				continue;
			var off = useIn ? offOfIn(e, key) : offOf(e, key);
			sibs.push({ edge: e, lane: boundaryPos + off });
		}
		sibs.sort(function (u, v) { return dir * (u.lane - borderPos) - dir * (v.lane - borderPos); });
		// taken lanes: non-violating sibling lanes plus every lane already
		// assigned in this channel
		var taken = [];
		for (var j = 0; j < sibs.length; j++)
			if (dir * (sibs[j].lane - borderPos) >= MIN_STUB)
				taken.push(sibs[j].lane);
		var chanLanes = model._chanLanes ? model._chanLanes[key] : null;
		if (chanLanes)
			for (var c = 0; c < chanLanes.length; c++)
				taken.push(boundaryPos + chanLanes[c]);
		// gutter guard: stay inside the free band around the boundary
		var coord = parseInt(key.slice(1), 10);
		var isCol = key.charAt(0) === 'c';
		var bIdx = Math.round(coord / (isCol ? model.colW : model.rowH));
		var extraArr = isCol ? model._colE : model._rowE;
		var extra = (extraArr && extraArr[bIdx]) || 0;
		var result = lanePos;
		var k = 0;
		for (var j = 0; j < sibs.length; j++) {
			if (dir * (sibs[j].lane - borderPos) >= MIN_STUB)
				continue;
			var cand = borderPos + dir * (MIN_STUB + 3 * k);
			k++;
			var clash = true;
			var fits = true;
			while (clash) {
				clash = false;
				if (dir * (cand - boundaryPos) > 25 + extra - 3) {
					// no free spot inside the gutter: keep the lane
					// (short stub, but unique and collision free)
					fits = false;
					break;
				}
				for (var t = 0; t < taken.length; t++) {
					if (Math.abs(taken[t] - cand) < 1) {
						cand += dir * 3;
						clash = true;
						break;
					}
				}
			}
			if (!fits)
				continue;
			taken.push(cand);
			if (sibs[j].edge === edge)
				result = cand;
		}
		return result;
	}

	/* Anchor point on the source box boundary (p) together with the point on
	 * the adjacent grid line after the short stub through the cell gutter (q).
	 * kind is 'V' when q sits on a column boundary line, 'H' on a row line.
	 * The stub always leaves the border perpendicular with at least the
	 * minimum length, even when the lane sits closer. */
	function exitAnchor(model, a, edge) {
		var nw = model.nodeW, nh = model.nodeH;
		var frac = anchorFraction(model, edge, true);
		var side = exitSide(model, edge);
		var noTie = isDirectEdge(model, edge);
		var p, q, kind, y, x;
		if (side === 'R') {
			y = anchorY(a, frac, nh, noTie);
			p = { x: a.x + nw, y: y };
			var laneR = colPos(model, a.col) + offOf(edge, cKey(a.col * model.colW));
			q = { x: Math.max(0, clampStubEnd(model, edge, true, 'R', cKey(a.col * model.colW), false, colPos(model, a.col), laneR, p.x)), y: y };
			kind = 'V';
		} else if (side === 'L') {
			y = anchorY(a, frac, nh, noTie);
			p = { x: a.x, y: y };
			var laneL = colPos(model, a.col - 1) + offOf(edge, cKey((a.col - 1) * model.colW));
			q = { x: Math.max(0, clampStubEnd(model, edge, true, 'L', cKey((a.col - 1) * model.colW), false, colPos(model, a.col - 1), laneL, p.x)), y: y };
			kind = 'V';
		} else if (side === 'B') {
			x = anchorX(a, frac, nw, noTie);
			p = { x: x, y: a.y + nh };
			var laneB = rowPos(model, a.row) + offOf(edge, rKey(a.row * model.rowH));
			q = { x: x, y: clampStubEnd(model, edge, true, 'B', rKey(a.row * model.rowH), false, rowPos(model, a.row), laneB, p.y) };
			kind = 'H';
		} else {
			x = anchorX(a, frac, nw, noTie);
			p = { x: x, y: a.y };
			var laneT = rowPos(model, a.row - 1) + offOf(edge, rKey((a.row - 1) * model.rowH));
			q = { x: x, y: Math.max(0, clampStubEnd(model, edge, true, 'T', rKey((a.row - 1) * model.rowH), false, rowPos(model, a.row - 1), laneT, p.y)) };
			kind = 'H';
		}
		return { p: p, q: q, kind: kind };
	}

	/* Anchor point on the target box boundary (p) plus its gutter stub (q).
	 * Incoming connections arrive through the top or the left border. The
	 * stub always enters perpendicular with at least the minimum length. */
	function entryAnchor(model, b, edge) {
		var nw = model.nodeW, nh = model.nodeH;
		var frac = anchorFraction(model, edge, false);
		var side = entrySide(model, edge);
		var noTie = isDirectEdge(model, edge);
		var p, q, kind, y, x;
		if (side === 'L') {
			y = anchorY(b, frac, nh, noTie);
			p = { x: b.x, y: y };
			var laneL = colPos(model, b.col - 1) + offOfIn(edge, cKey((b.col - 1) * model.colW));
			q = { x: Math.max(0, clampStubEnd(model, edge, false, 'L', cKey((b.col - 1) * model.colW), true, colPos(model, b.col - 1), laneL, p.x)), y: y };
			kind = 'V';
		} else if (side === 'R') {
			y = anchorY(b, frac, nh, noTie);
			p = { x: b.x + nw, y: y };
			var laneR = colPos(model, b.col) + offOfIn(edge, cKey(b.col * model.colW));
			q = { x: Math.max(0, clampStubEnd(model, edge, false, 'R', cKey(b.col * model.colW), true, colPos(model, b.col), laneR, p.x)), y: y };
			kind = 'V';
		} else if (side === 'T') {
			x = anchorX(b, frac, nw, noTie);
			p = { x: x, y: b.y };
			var laneT = rowPos(model, b.row - 1) + offOfIn(edge, rKey((b.row - 1) * model.rowH));
			q = { x: x, y: Math.max(0, clampStubEnd(model, edge, false, 'T', rKey((b.row - 1) * model.rowH), true, rowPos(model, b.row - 1), laneT, p.y)) };
			kind = 'H';
		} else {
			x = anchorX(b, frac, nw, noTie);
			p = { x: x, y: b.y + nh };
			var laneB = rowPos(model, b.row) + offOfIn(edge, rKey(b.row * model.rowH));
			q = { x: x, y: clampStubEnd(model, edge, false, 'B', rKey(b.row * model.rowH), true, rowPos(model, b.row), laneB, p.y) };
			kind = 'H';
		}
		return { p: p, q: q, kind: kind };
	}

	/* Self loop: leaves through the bottom border halfway of its bottom segment
	 * and enters through the top border, wrapped around a column and a row
	 * grid line so the loop never overlaps a neighbour card. The exit and
	 * entry x positions share the anchor fraction domain of regular bottom
	 * exits and top entries, so loop stubs never coincide with theirs. */
	function selfLoopPts(model, a, edge) {
		var index = edge._selfIndex || 0;
		var ef = anchorFraction(model, edge, true);
		var nf = anchorFraction(model, edge, false);
		var exitX = anchorX(a, ef, model.nodeW);
		var enterX = anchorX(a, nf, model.nodeW);
		var sideK = index % 2 === 0 ? a.col * model.colW : (a.col - 1) * model.colW;
		var belowK = a.row * model.rowH;
		var aboveK = (a.row - 1) * model.rowH;
		var side = Math.max(0, colPos(model, index % 2 === 0 ? a.col : a.col - 1) + offOf(edge, cKey(sideK)));
		var below = Math.max(0, rowPos(model, a.row) + offOf(edge, rKey(belowK)));
		var above = Math.max(0, rowPos(model, a.row - 1) + offOf(edge, rKey(aboveK)));
		// keep the stubs perpendicular with the minimum length, spread with
		// siblings sharing the bound so parallel wraps never coincide
		below = clampStubEnd(model, edge, true, 'B', rKey(belowK), false, rowPos(model, a.row), below, a.y + model.nodeH);
		above = clampStubEnd(model, edge, false, 'T', rKey(aboveK), true, rowPos(model, a.row - 1), above, a.y);
		return [
			{ x: exitX, y: a.y + model.nodeH },
			{ x: exitX, y: below },
			{ x: side, y: below },
			{ x: side, y: above },
			{ x: enterX, y: above },
			{ x: enterX, y: a.y }
		];
	}

	/* SVG path of a self loop wrapped around its grid lines. */
	function selfLoopPath(model, a, edge) {
		return linePath(selfLoopPts(model, a, edge));
	}

	/* True when the drop onto the grid cell (col, row) is allowed by the
	 * dragging node: the cell must be empty, or the occupying node must be
	 * unpinned (it will be moved aside to the next free cell on reload). */
	function dropCellFree(model, col, row, ignoreNodeId) {
		for (var i = 0; i < model.nodes.length; i++) {
			var n = model.nodes[i];
			if (n.col === col && n.row === row && n.id !== ignoreNodeId) {
				if (n.pinned)
					return false;
			}
		}
		return true;
	}

	/* True when no card occupies the grid cell (col, row). Empty cells are
	 * free space, not obstacles. */
	function cellFree(model, col, row) {
		for (var i = 0; i < model.nodes.length; i++) {
			var n = model.nodes[i];
			if (n.col === col && n.row === row)
				return false;
		}
		return true;
	}

	/* Direct route check: when only empty cells (or none) lie between the
	 * two cards, the connector crosses the gap straight away instead of
	 * detouring over the grid-line corridors. Returns the index of the grid
	 * line carrying the short jog (horizontal = jog along y, a row line;
	 * otherwise a column line) or null when the card pair needs the
	 * corridor routing. The index is derived from the node rows/columns so
	 * it stays stable while gutters widen. */
	function directJog(model, edge, a, b) {
		if (exitSide(model, edge) === 'R') {
			// exit right / entry left, same row band between the cards
			if (b.row !== a.row)
				return null;
			for (var c = a.col + 1; c < b.col; c++)
				if (!cellFree(model, c, a.row))
					return null;
			return {
				idx: Math.max(0, Math.min(model.cols, Math.floor((a.col + b.col - 1) / 2 + 0.5))),
				horizontal: false
			};
		}
		// exit bottom / entry top, straight down through empty cells
		if (b.row <= a.row)
			return null;
		for (var r = a.row + 1; r < b.row; r++)
			if (!cellFree(model, a.col, r) || !cellFree(model, b.col, r))
				return null;
		return {
			idx: Math.max(a.row, Math.min(b.row - 1, Math.floor((a.row + b.row - 1) / 2 + 0.5))),
			horizontal: true
		};
	}

	/* Orthogonal connector between two node boxes. Starts and ends on the
	 * card borders (not through the centres), crosses empty space directly
	 * and otherwise routes through the evenly filled margin gutters, so it
	 * never crosses another card. */
	function linePath(pts) {
		var d = 'M ' + pts[0].x + ' ' + pts[0].y;
		for (var i = 1; i < pts.length; i++)
			d += ' L ' + pts[i].x + ' ' + pts[i].y;
		return d;
	}

	/* Direct jog coordinate with minimum stub lengths, spread with violators
	 * sharing the same bound so parallel jogs never coincide. lane is the
	 * channel lane position; [lo,hi] the valid range from the stub lengths;
	 * base/extra locate the gutter for the guard. horizontal selects the
	 * axis (true: jog along y). Falls back to the lane when spreading is
	 * impossible (short stub, but unique and collision free). */
	function spreadJog(model, edge, horizontal, lane, lo, hi, base, extra) {
		if (lane >= lo && lane <= hi)
			return lane;
		var loV = lane < lo;
		var bound = loV ? lo : hi;
		var dir = loV ? 1 : -1;
		var viols = [];
		for (var i = 0; i < model.edges.length; i++) {
			var e = model.edges[i];
			var dj = e._dj;
			if (!dj || !!dj.horizontal !== !!horizontal)
				continue;
			var na = nodeById(model, e.from);
			var nb = nodeById(model, e.to);
			if (!na || !nb || e.from === e.to)
				continue;
			var dj2 = directJog(model, e, na, nb);
			if (!dj2)
				continue;
			var ea2 = exitAnchor(model, na, e);
			var eb2 = entryAnchor(model, nb, e);
			var elane, elo, ehi, ekey;
			if (horizontal) {
				ekey = rKey(dj2.idx * model.rowH);
				elane = rowPos(model, dj2.idx) + offOf(e, ekey);
				elo = ea2.p.y + MIN_STUB;
				ehi = eb2.p.y - MIN_STUB;
			} else {
				ekey = cKey(dj2.idx * model.colW);
				elane = colPos(model, dj2.idx) + offOf(e, ekey);
				elo = ea2.p.x + MIN_STUB;
				ehi = eb2.p.x - MIN_STUB;
			}
			if (elo > ehi)
				continue;
			var ebound = elane < elo ? elo : (elane > ehi ? ehi : null);
			if (ebound === null || Math.abs(ebound - bound) > 0.5)
				continue;
			var edir = elane < elo ? 1 : -1;
			if (edir !== dir)
				continue;
			viols.push({ edge: e, lane: elane, key: ekey, lo: elo, hi: ehi });
		}
		viols.sort(function (u, v) {
			if (u.lane !== v.lane)
				return dir * (u.lane - v.lane);
			if (u.edge.from !== v.edge.from)
				return u.edge.from - v.edge.from;
			return u.edge.to - v.edge.to;
		});
		// taken: lanes of the involved jog channels plus assigned spreads
		var taken = [];
		for (var j = 0; j < viols.length; j++) {
			var vk = viols[j].key;
			var vc = parseInt(vk.slice(1), 10);
			var visC = vk.charAt(0) === 'c';
			var vb = Math.round(vc / (visC ? model.colW : model.rowH));
			var vbase = visC ? colPos(model, vb) : rowPos(model, vb);
			var varr = visC ? model._colE : model._rowE;
			viols[j].base = vbase;
			viols[j].extra = (varr && varr[vb]) || 0;
			var vl = model._chanLanes ? model._chanLanes[vk] : null;
			if (vl)
				for (var t = 0; t < vl.length; t++)
					taken.push(vbase + vl[t]);
		}
		var result = lane;
		var k = 0;
		for (var j = 0; j < viols.length; j++) {
			// offset by half a step from corridor stub spreads at the same
			// bound, so the two grids interleave without ever coinciding
			var cand = bound + dir * (1.5 + 3 * k);
			k++;
			var clash = true;
			var fits = true;
			while (clash) {
				clash = false;
				if (dir * (cand - viols[j].base) > 25 + viols[j].extra - 3
						|| (dir > 0 ? cand > viols[j].hi : cand < viols[j].lo)) {
					fits = false;
					break;
				}
				for (var t = 0; t < taken.length; t++) {
					if (Math.abs(taken[t] - cand) < 1) {
						cand += dir * 3;
						clash = true;
						break;
					}
				}
			}
			if (!fits)
				continue;
			taken.push(cand);
			if (viols[j].edge === edge)
				result = cand;
		}
		return result;
	}

	/* Orthogonal connector between two node boxes. Starts and ends on the
	 * card borders (not through the centres), crosses empty space directly
	 * and otherwise routes through the evenly filled margin gutters, so it
	 * never crosses another card. Returns the polyline points together with
	 * the exit/entry border points for label and badge placement. */
	function edgePoints(model, edge) {
		var a = nodeById(model, edge.from);
		var b = nodeById(model, edge.to);
		if (!a || !b)
			return null;
		if (edge.from === edge.to) {
			var loop = selfLoopPts(model, a, edge);
			return { pts: loop, exit: loop[0], entry: loop[loop.length - 1] };
		}
		var ea = exitAnchor(model, a, edge);
		var eb = entryAnchor(model, b, edge);
		var pts;
		var dj = directJog(model, edge, a, b);
		if (dj) {
			if (dj.horizontal) {
				if (ea.p.x === eb.p.x) {
					pts = [ea.p, eb.p];
				} else {
					var myLane = Math.max(0, rowPos(model, dj.idx) + offOf(edge, rKey(dj.idx * model.rowH)));
					var my = spreadJog(model, edge, true, myLane,
						ea.p.y + MIN_STUB, eb.p.y - MIN_STUB,
						rowPos(model, dj.idx), (model._rowE && model._rowE[dj.idx]) || 0);
					pts = [ea.p, { x: ea.p.x, y: my }, { x: eb.p.x, y: my }, eb.p];
				}
			} else {
				if (ea.p.y === eb.p.y) {
					pts = [ea.p, eb.p];
				} else {
					var mxLane = Math.max(0, colPos(model, dj.idx) + offOf(edge, cKey(dj.idx * model.colW)));
					var mx = spreadJog(model, edge, false, mxLane,
						ea.p.x + MIN_STUB, eb.p.x - MIN_STUB,
						colPos(model, dj.idx), (model._colE && model._colE[dj.idx]) || 0);
					pts = [ea.p, { x: mx, y: ea.p.y }, { x: mx, y: eb.p.y }, eb.p];
				}
			}
			return { pts: pts, exit: ea.p, entry: eb.p };
		}
		pts = [ea.p, ea.q];
		if (ea.kind === eb.kind) {
			if (ea.kind === 'V') {
				if (ea.q.x === eb.q.x) {
					pts.push(eb.q);
				} else {
					// both on column boundary lines: kink on a row line
					// between the two node rows (matches the lane join)
					var kri = Math.max(0, Math.min(model.rows, Math.floor(((a.row - 1) + (b.row - 1)) / 2 + 0.5)));
					var rl = Math.max(0, rowPos(model, kri) + offOf(edge, rKey(kri * model.rowH)));
					pts.push({ x: ea.q.x, y: rl }, { x: eb.q.x, y: rl });
				}
			} else {
				if (ea.q.y === eb.q.y) {
					pts.push(eb.q);
				} else {
					// both on row boundary lines: kink on a column line
					// between the two node columns
					var kci = Math.max(0, Math.min(model.cols, Math.floor(((a.col - 1) + (b.col - 1)) / 2 + 0.5)));
					var cl = Math.max(0, colPos(model, kci) + offOf(edge, cKey(kci * model.colW)));
					pts.push({ x: cl, y: ea.q.y }, { x: cl, y: eb.q.y });
				}
			}
		} else if (ea.kind === 'V') {
			// exit on a column lane, entry on a row lane: single corner
			pts.push({ x: ea.q.x, y: eb.q.y });
		} else {
			// exit on a row lane, entry on a column lane: single corner
			pts.push({ x: eb.q.x, y: ea.q.y });
		}
		pts.push(eb.q);
		pts.push(eb.p);
		return { pts: pts, exit: ea.p, entry: eb.p };
	}

	/* SVG path of a connector including direct jogs and self loops. */
	function edgePath(model, edge) {
		var r = edgePoints(model, edge);
		return r ? linePath(r.pts) : null;
	}

	/* Transition label without curly braces: "seq: description", only when
	 * a description is present. Used for aria labels and tooltips. */
	function edgeLabel(edge) {
		var desc = edge.description || '';
		if (desc === '')
			return '';
		return edge.seq + ': ' + desc;
	}

	/* Label point on the longest straight segment that is not covered by a
	 * card and fits the chip, so the chip never sits on a kink or a node
	 * box. Returns the midpoint and whether the segment runs vertically. */
	function labelPoint(model, pts, estLen) {
		var cands = [];
		for (var i = 0; i < pts.length - 1; i++) {
			var len = Math.abs(pts[i + 1].x - pts[i].x) + Math.abs(pts[i + 1].y - pts[i].y);
			if (len >= 1)
				cands.push({ i: i, len: len });
		}
		if (!cands.length)
			return null;
		cands.sort(function (a, b) { return b.len - a.len; });
		function at(s) {
			var mx = (pts[s.i].x + pts[s.i + 1].x) / 2;
			var my = (pts[s.i].y + pts[s.i + 1].y) / 2;
			return {
				x: mx, y: my,
				vertical: Math.abs(pts[s.i + 1].x - pts[s.i].x) < 1,
				len: s.len
			};
		}
		var need = (estLen || 0) + 8;
		var fallback = null;
		for (var j = 0; j < cands.length; j++) {
			var s = cands[j];
			var mid = at(s);
			if (pointInCard(model, mid))
				continue;
			if (!fallback)
				fallback = s;
			if (s.len >= need)
				return mid;
		}
		return at(fallback || cands[0]);
	}

	/* True when the point lies strictly inside a node box. */
	function pointInCard(model, p) {
		for (var i = 0; i < model.nodes.length; i++) {
			var n = model.nodes[i];
			if (p.x > n.x && p.x < n.x + model.nodeW && p.y > n.y && p.y < n.y + model.nodeH)
				return true;
		}
		return false;
	}

	/* Sequence badge pinned on the connector start point (exit anchor),
	 * shown when the source node has more than one outgoing connector so
	 * the sequence stays readable, or when the transition carries
	 * conditions. Transitions with conditions get a diamond instead of a
	 * circle, with the conditions as tooltip. Badges paint above the
	 * lines; the drag ports live in their own topmost layer above. */
	function addSeqBadge(layer, model, edge, exit, openMenuFn) {
		if (edge.seq === undefined || edge.seq === null)
			return;
		var outCount = 0;
		for (var i = 0; i < model.edges.length; i++)
			if (model.edges[i].from === edge.from)
				outCount++;
		var hasCond = (edge.condCount > 0) || !!edge.condTip;
		if (outCount < 2 && !hasCond)
			return;
		var g = el('g', { 'class': 'wf-seq-badge' + (hasCond ? ' wf-cond' : ''), 'aria-hidden': 'true' }, layer);
		if (hasCond) {
			var h = 10;
			el('polygon', {
				'class': 'wf-cond-badge-diamond',
				'points': exit.x + ',' + (exit.y - h) + ' ' + (exit.x + h) + ',' + exit.y
					+ ' ' + exit.x + ',' + (exit.y + h) + ' ' + (exit.x - h) + ',' + exit.y
			}, g);
			if (edge.condTip) {
				var ct = el('title', null, g);
				ct.textContent = edge.condTip;
			}
		} else {
			el('circle', { 'class': 'wf-seq-badge-circle', 'cx': exit.x, 'cy': exit.y, 'r': '8' }, g);
		}
		var t = el('text', { 'class': 'wf-seq-badge-text', 'x': exit.x, 'y': exit.y + 3.5 }, g);
		t.textContent = String(edge.seq);
		// touch: badges are tappable and open the edge menu (desktop
		// keeps them click-through so line clicks keep working)
		if (openMenuFn && isCoarsePointer()) {
			g.addEventListener('click', function (cev) {
				cev.stopPropagation();
				if (isClickSuppressed())
					return;
				openMenuFn(g, cev);
			});
		}
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

	/* Forward a client event to the server widget. */
	function sendEvent(wgt, name, data) {
		if (!wgt)
			return;
		zAu.send(new zk.Event(wgt, name, data, { toServer: true }));
	}

	/* Per-view render state (scale, selection, model) by widget uuid. */
	function getState(uuid, model) {
		var st = stateByUuid[uuid];
		if (!st) {
			st = { scale: 1, selected: -1 };
			stateByUuid[uuid] = st;
		}
		st.model = model;
		return st;
	}

	/* Rebuilding the svg collapses the scrollable for a moment, so the
	 * browser clamps every scroll offset to zero and the view jumps to
	 * the top left corner (e.g. after drag&drop or the server reload
	 * following it). Remember the offsets beforehand and put them back
	 * afterwards; the browser clamps them if the content shrank. */
	function saveScroll(root) {
		var out = [];
		var p = root;
		while (p && p.nodeType === 1) {
			if (p.scrollTop || p.scrollLeft)
				out.push({ el: p, left: p.scrollLeft, top: p.scrollTop });
			if (p === document.body || p === document.documentElement)
				break;
			p = p.parentNode;
		}
		return out;
	}

	/* Put back scroll offsets saved by saveScroll. */
	function restoreScroll(saved) {
		for (var i = 0; i < saved.length; i++) {
			try {
				saved[i].el.scrollLeft = saved[i].left;
				saved[i].el.scrollTop = saved[i].top;
			} catch (ignore) { /* noop */ }
		}
	}

	/* Apply the state scale to svg size and zoom labels. */
	function applyZoom(root, svg, st, canvasW, canvasH) {
		var w = Math.round(canvasW * st.scale);
		var h = Math.round(canvasH * st.scale);
		svg.setAttribute('width', w);
		svg.setAttribute('height', h);
		var pct = Math.round(st.scale * 100) + '%';
		var label = root.querySelector('.wf-zoom-label');
		if (label)
			label.textContent = pct;
		// host symbol bar label: same borderlayout, class marker, no id
		// plumbing that can desync between server and client
		var ext = null;
		var bl = root.closest ? root.closest('.z-borderlayout') : null;
		if (bl)
			ext = bl.querySelector('.wf-zoom-label-host');
		if (!ext && document.querySelectorAll('.wf-zoom-label-host').length === 1)
			ext = document.querySelector('.wf-zoom-label-host');
		if (ext)
			ext.textContent = pct;
	}

	/* Zoom to an absolute scale within limits and apply it. */
	function zoomTo(st, root, svg, canvasW, canvasH, scale) {
		st.scale = Math.min(2.5, Math.max(0.2, scale));
		applyZoom(root, svg, st, canvasW, canvasH);
	}

	/* Zoom so the canvas fits the container width. */
	function zoomFit(st, root, svg, canvasW) {
		var avail = root.clientWidth || canvasW;
		zoomTo(st, root, svg, canvasW, st.canvasH || 0, avail / canvasW);
	}

	/* Zoom buttons, zoom label and hint row above the canvas. */
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

	/* --- Client side menus and connect-by-drag (setup editor) ------------ */

	var openMenu = null;

	/* Clicks arriving right after a long press, a node drag or a connect
	 * gesture belong to that gesture (touch fires click on pointer up), so
	 * they are swallowed for a short window instead of e.g. reopening a
	 * menu or selecting a dragged node. */
	var suppressClickUntil = 0;
	/* Swallow clicks of the current gesture for a short window. */
	function noteSuppressingGesture() {
		suppressClickUntil = Date.now() + 800;
	}
	/* True while clicks still belong to a finished gesture. */
	function isClickSuppressed() {
		return Date.now() < suppressClickUntil;
	}

	/* Close the menu and send a menu action event to the server. */
	function menuAction(wgt, kind, id, action) {
		hideMenu();
		sendEvent(wgt, 'onMenuAction', { kind: kind, id: id, action: action });
	}

	/* Client menu entries for a node (zoom, properties, pin, delete). */
	function nodeMenuItems(node, opts, wgt) {
		var items = [
			{ label: opts.menuZoom || 'Zoom', action: 'zoom' },
			{ label: opts.menuProperties || 'Properties', action: 'properties' }
		];
		if (node.editable !== false) {
			if (node.pinned) {
				items.push({ label: opts.menuUnpinPosition || 'Release position', action: 'unpinPosition' });
			} else {
				items.push({ label: opts.menuPinPosition || 'Pin position', action: 'pinPosition' });
			}
			items.push({ label: opts.menuDeleteNode || 'Delete node', action: 'deleteNode' });
		}
		for (var i = 0; i < items.length; i++) {
			items[i].kind = 'node';
			items[i].id = node.id;
			items[i].wgt = wgt;
		}
		return items;
	}

	/* Client menu entries for an edge (zoom, properties, delete). */
	function edgeMenuItems(edge, opts, wgt) {
		var items = [
			{ label: opts.menuZoom || 'Zoom', action: 'zoom' },
			{ label: opts.menuProperties || 'Properties', action: 'properties' }
		];
		if (edge.editable !== false)
			items.push({ label: opts.menuDeleteLine || 'Delete line', action: 'deleteLine' });
		for (var i = 0; i < items.length; i++) {
			items[i].kind = 'edge';
			items[i].id = edge.id;
			items[i].wgt = wgt;
		}
		return items;
	}

	/* Open a floating client menu at (x, y), clamped into the viewport. */
	function showMenu(items, x, y, onPick) {
		hideMenu();
		var menu = document.createElement('div');
		menu.style.cssText = 'position:fixed;z-index:100000;min-width:150px;background:#fff;'
			+ 'border:1px solid #d0d7de;border-radius:6px;padding:4px;box-shadow:0 3px 6px rgba(0,0,0,0.16), 0 2px 4px rgba(0,0,0,0.24);'
			+ 'font-family:sans-serif;font-size:12px;color:#24292f;user-select:none;';
		for (var i = 0; i < items.length; i++) {
			(function (item) {
				var btn = document.createElement('div');
				btn.className = 'wf-menu-item';
				btn.setAttribute('role', 'menuitem');
				btn.textContent = item.label;
				btn.style.cssText = 'padding:6px 12px;border-radius:4px;cursor:pointer;white-space:nowrap;line-height:18px;';
				btn.addEventListener('mouseenter', function () {
					btn.style.background = '#e0f2ff';
				});
				btn.addEventListener('mouseleave', function () {
					btn.style.background = 'transparent';
				});
				btn.addEventListener('click', function (ev) {
					ev.stopPropagation();
					hideMenu();
					onPick(item);
				});
				menu.appendChild(btn);
			})(items[i]);
		}
		document.body.appendChild(menu);
		// keep the menu inside the viewport
		var w = menu.offsetWidth, h = menu.offsetHeight;
		if (x + w > window.innerWidth - 8)
			x = Math.max(8, window.innerWidth - w - 8);
		if (y + h > window.innerHeight - 8)
			y = Math.max(8, window.innerHeight - h - 8);
		menu.style.left = x + 'px';
		menu.style.top = y + 'px';
		openMenu = {
			el: menu,
			close: function (ev) {
				if (ev && menu.contains(ev.target))
					return;
				hideMenu();
			}
		};
		document.addEventListener('pointerdown', openMenu.close, true);
		document.addEventListener('keydown', onMenuKey, true);
	}

	/* Close the open menu on Escape. */
	function onMenuKey(ev) {
		if (ev.key === 'Escape') {
			ev.stopPropagation();
			hideMenu();
		}
	}

	/* Close the open menu and detach its listeners. */
	function hideMenu() {
		if (!openMenu)
			return;
		document.removeEventListener('pointerdown', openMenu.close, true);
		document.removeEventListener('keydown', onMenuKey, true);
		if (openMenu.el.parentNode)
			openMenu.el.parentNode.removeChild(openMenu.el);
		openMenu = null;
	}

	/* True on touch-first devices (phones, most tablets): hover, right
	 * click, double click and precise 1px targets cannot be relied on, so
	 * touch alternatives (long press, second tap, always visible ports and
	 * tappable chips) are enabled. Desktop behaviour is unchanged. */
	function isCoarsePointer() {
		return !!(window.matchMedia && window.matchMedia('(pointer:coarse)').matches);
	}

	/* Long press gesture for touch/pen: fires fn once after delay ms while
	 * the pointer stays within tolerance px. Mouse is ignored entirely
	 * (it has contextmenu and hover), so desktop behaviour is unchanged.
	 * fn receives {clientX, clientY, pid}. */
	function addLongPress(target, fn, delay) {
		var timer = null, sx = 0, sy = 0, pid = null;
		function cancel() {
			if (timer) { clearTimeout(timer); timer = null; }
			pid = null;
		}
		target.addEventListener('pointerdown', function (ev) {
			if (ev.pointerType === 'mouse')
				return;
			cancel();
			sx = ev.clientX; sy = ev.clientY; pid = ev.pointerId;
			var cx = sx, cy = sy, cpid = pid;
			timer = setTimeout(function () {
				timer = null;
				noteSuppressingGesture();
				fn({ clientX: cx, clientY: cy, pid: cpid });
			}, delay || 550);
		});
		target.addEventListener('pointermove', function (ev) {
			if (timer && ev.pointerId === pid
					&& Math.abs(ev.clientX - sx) + Math.abs(ev.clientY - sy) > 10)
				cancel();
		});
		target.addEventListener('pointerup', cancel);
		target.addEventListener('pointercancel', cancel);
	}

	/* Open the node menu at the event position. */
	function showNodeMenuClient(node, ev, opts, wgt) {
		var x = ev && ev.clientX !== undefined ? ev.clientX : window.innerWidth / 2;
		var y = ev && ev.clientY !== undefined ? ev.clientY : window.innerHeight / 2;
		showMenu(nodeMenuItems(node, opts, wgt), x, y, function (item) {
			menuAction(wgt, 'node', node.id, item.action);
		});
	}

	/* Open an edge menu below a target rectangle. */
	function showMenuAt(rect, items) {
		var x = rect ? rect.left + rect.width / 2 : window.innerWidth / 2;
		var y = rect ? rect.bottom + 4 : window.innerHeight / 2;
		showMenu(items, x, y, function (item) {
			menuAction(item.kind ? item.wgt : null, item.kind, item.id, item.action);
		});
	}

	/* Convert client pixels to svg coordinates. */
	function clientToSvg(svg, clientX, clientY) {
		var pt = svg.createSVGPoint();
		pt.x = clientX;
		pt.y = clientY;
		var ctm = svg.getScreenCTM();
		return ctm ? pt.matrixTransform(ctm.inverse()) : { x: clientX, y: clientY };
	}

	/* Drag a new transition from a node port to a target node. */
	function startConnect(g, port, node, layer, svg, model, opts, wgt, pid, portLayer) {
		var fromX = node.x + model.nodeW;
		var fromY = node.y + model.nodeH / 2;
		var line = el('path', {
			'class': 'wf-connect-line',
			'd': 'M ' + fromX + ' ' + fromY + ' L ' + fromX + ' ' + fromY
		}, svg);
		var hovered = null;
		var targetPort = null;
		function highlight(target) {
			if (hovered === target)
				return;
			if (targetPort && targetPort.parentNode)
				targetPort.parentNode.removeChild(targetPort);
			targetPort = null;
			var groups = layer.querySelectorAll('g.wf-node');
			for (var i = 0; i < groups.length; i++) {
				var id = groups[i].getAttribute('data-id');
				if (target && String(id) === String(target.id)) {
					groups[i].classList.add('wf-connect-target');
				} else {
					groups[i].classList.remove('wf-connect-target');
				}
			}
			if (target) {
				// show where the connection will dock: entry port on the left
				// border of the target node, in overlay coordinates
				targetPort = el('circle', {
					'class': 'wf-port',
					'cx': String(target.x), 'cy': String(target.y + model.nodeH / 2), 'r': '6',
					'style': 'opacity:1;touch-action:none'
				}, portLayer);
			}
			hovered = target;
		}
		function nodeAt(p) {
			for (var i = 0; i < model.nodes.length; i++) {
				var n = model.nodes[i];
				if (n.id !== node.id && p.x >= n.x && p.x <= n.x + model.nodeW
						&& p.y >= n.y && p.y <= n.y + model.nodeH)
					return n;
			}
			return null;
		}
		function onMove(ev) {
			if (ev.pointerId !== pid)
				return;
			ev.preventDefault();
			var p = clientToSvg(svg, ev.clientX, ev.clientY);
			line.setAttribute('d', 'M ' + fromX + ' ' + fromY + ' L ' + p.x + ' ' + p.y);
			highlight(nodeAt(p));
		}
		function onUp(ev) {
			if (ev.pointerId !== pid)
				return;
			noteSuppressingGesture();
			var p = clientToSvg(svg, ev.clientX, ev.clientY);
			var target = nodeAt(p);
			cleanup();
			if (target)
				sendEvent(wgt, 'onEdgeCreate', { fromId: node.id, toId: target.id });
		}
		function onCancel(ev) {
			if (ev.pointerId !== pid)
				return;
			noteSuppressingGesture();
			cleanup();
		}
		function onKey(ev) {
			if (ev.key === 'Escape')
				cleanup();
		}
		function cleanup() {
			window.removeEventListener('pointermove', onMove);
			window.removeEventListener('pointerup', onUp);
			window.removeEventListener('pointercancel', onCancel);
			window.removeEventListener('keydown', onKey, true);
			if (line.parentNode)
				line.parentNode.removeChild(line);
			if (targetPort && targetPort.parentNode)
				targetPort.parentNode.removeChild(targetPort);
			targetPort = null;
			highlight(null);
		}
		window.addEventListener('pointermove', onMove);
		window.addEventListener('pointerup', onUp);
		window.addEventListener('pointercancel', onCancel);
		window.addEventListener('keydown', onKey, true);
	}

	/* Draw a node card with image, texts, menu, port and drag. */
	function renderNode(layer, model, node, st, wgt, opts, rerender, portLayer) {
		var nw = model.nodeW, nh = model.nodeH;
		// grayed out cards only in the setup editor (grayLockedNodes): while
		// editing it must be visible which nodes belong to another client
		// and cannot be edited; the display panel shows all nodes normal
		var locked = !!opts.grayLockedNodes && node.editable === false;
		var g = el('g', {
			'class': 'wf-node' + (locked ? ' wf-node-locked' : '')
				+ (st.selected === node.id ? ' selected' : ''),
			'transform': 'translate(' + node.x + ',' + node.y + ')',
			'tabindex': '0',
			'role': 'button',
			'data-id': node.id
		}, layer);
		g.setAttribute('aria-label', node.name || ('Node ' + node.id));

		el('rect', {
			'class': 'wf-node-box', 'width': nw, 'height': nh, 'rx': '6'
		}, g);

		// action glyph: node image as eye catcher top left if defined,
		// otherwise the action key letter in a circle
		if (node.imageSrc) {
			el('image', {
				'class': 'wf-node-image', 'href': node.imageSrc,
				'x': '8', 'y': '8', 'width': '20', 'height': '20',
				'preserveAspectRatio': 'xMidYMid meet'
			}, g);
		} else {
			el('circle', { 'class': 'wf-glyph', 'cx': '18', 'cy': '18', 'r': '10' }, g);
			var glyph = el('text', { 'class': 'wf-glyph-text', 'x': '18', 'y': '22', 'text-anchor': 'middle' }, g);
			glyph.textContent = node.actionKey || '•';
		}

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

		function select() {
			st.selected = node.id;
			var boxes = layer.querySelectorAll('.wf-node');
			for (var k = 0; k < boxes.length; k++)
				boxes[k].classList.remove('selected');
			g.classList.add('selected');
		}
		g.addEventListener('click', function (ev) {
			ev.stopPropagation();
			if (isClickSuppressed())
				return;
			if (ev.detail > 1)
				return;
			var wasSelected = (st.selected === node.id);
			select();
			// left click only selects; the menu opens via right click,
			// long press, second tap (touch) or keyboard
			if (!opts.menuEnabled)
				sendEvent(wgt, 'onNodeClick', { nodeId: node.id });
			else if (wasSelected && isCoarsePointer())
				showNodeMenuClient(node, ev, opts, wgt);
		});
		g.addEventListener('dblclick', function (ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if (opts.menuEnabled)
				menuAction(wgt, 'node', node.id, 'properties');
		});
		g.addEventListener('contextmenu', function (ev) {
			ev.preventDefault();
			ev.stopPropagation();
			if (opts.menuEnabled) {
				select();
				showNodeMenuClient(node, ev, opts, wgt);
			} else {
				sendEvent(wgt, 'onNodeContext', { nodeId: node.id });
			}
		});
		// touch: long press replaces right click (menu only; the display
		// panel has no menu, its tap behaviour stays untouched)
		if (opts.menuEnabled) {
			addLongPress(g, function (pos) {
				select();
				st.longPressPid = pos.pid;
				showNodeMenuClient(node, pos, opts, wgt);
			});
		}
		g.addEventListener('keydown', function (ev) {
			if (ev.key === 'Enter' || ev.key === ' ') {
				ev.preventDefault();
				if (opts.menuEnabled) {
					showMenuAt(ev.currentTarget.getBoundingClientRect(), nodeMenuItems(node, opts, wgt));
				} else {
					sendEvent(wgt, 'onNodeClick', { nodeId: node.id });
				}
			} else if (opts.menuEnabled && (ev.key === 'Delete' || ev.key === 'Backspace')) {
				ev.preventDefault();
				menuAction(wgt, 'node', node.id, 'deleteNode');
			}
		});

		// connection port: drag from here to another node to create a
		// transition (edit mode only). Ports live in the topmost overlay
		// layer (absolute coordinates) so the blue dots always paint above
		// badges and chips; hover reveal is JS because CSS cannot reach
		// across layers. Locked nodes keep their port: new transitions may
		// start from them, only moving is forbidden (see attachDrag).
		if (opts.editable) {
			// touch has no hover: the port stays visible and grows, plus an
			// invisible halo for fat fingers
			var coarsePort = isCoarsePointer();
			var port = el('circle', {
				'class': 'wf-port', 'cx': String(node.x + nw), 'cy': String(node.y + nh / 2),
				'r': coarsePort ? '9' : '6', 'data-node-id': node.id
			}, portLayer);
			port.style.touchAction = 'none';
			if (coarsePort)
				port.style.opacity = '1';
			else {
				g.addEventListener('mouseenter', function () { port.style.opacity = '1'; });
				g.addEventListener('mouseleave', function (mev) {
					var rt = mev.relatedTarget;
					if (rt && (rt === port || rt === halo)) return;
					port.style.opacity = '0';
				});
				port.addEventListener('mouseenter', function () { port.style.opacity = '1'; });
				port.addEventListener('mouseleave', function (mev) {
					if (mev.relatedTarget && g.contains(mev.relatedTarget)) return;
					port.style.opacity = '0';
				});
			}
			function portDown(ev) {
				if (ev.pointerType === 'mouse' && ev.button !== 0)
					return;
				// touch: badges sit above the port halo, taps on them belong to
				// the badge menu, not to connect-by-drag
				if (coarsePort && badgeAt(ev))
					return;
				ev.preventDefault();
				ev.stopPropagation();
				startConnect(g, port, node, layer, g.ownerSVGElement, model, opts, wgt, ev.pointerId, portLayer);
			}
			function badgeAt(ev) {
				var svg = g.ownerSVGElement;
				var list = svg.querySelectorAll('g.wf-seq-badge');
				for (var i = 0; i < list.length; i++) {
					var r = list[i].getBoundingClientRect();
					if (ev.clientX >= r.left && ev.clientX <= r.right && ev.clientY >= r.top && ev.clientY <= r.bottom)
						return true;
				}
				return false;
			}
			// older iOS ignores touch-action on SVG: block scroll takeover
			// directly (pointer events still fire, clicks are suppressed anyway)
			port.addEventListener('touchstart', function (tev) { tev.preventDefault(); }, { passive: false });
			port.addEventListener('pointerdown', portDown);
			var halo = null;
			if (coarsePort) {
				halo = el('circle', {
					'class': 'wf-port-halo', 'cx': String(node.x + nw), 'cy': String(node.y + nh / 2), 'r': '16',
					'fill': 'rgba(0,0,0,0)', 'stroke': 'none', 'data-node-id': node.id
				}, portLayer);
				halo.style.touchAction = 'none';
				halo.addEventListener('touchstart', function (tev) { tev.preventDefault(); }, { passive: false });
				halo.addEventListener('pointerdown', portDown);
			}
		}

		// nodes of another client are locked: no drag, grayed out look
		if (opts.editable && !locked)
			attachDrag(g, model, node, st, wgt, opts, rerender, port, halo);
	}

	/* Make a node card draggable between grid cells. */
	function attachDrag(g, model, node, st, wgt, opts, rerender, port, halo) {
		g.style.touchAction = 'none';
		g.addEventListener('pointerdown', function (ev) {
			if (ev.pointerType === 'mouse' && ev.button !== 0)
				return;
			ev.stopPropagation();
			var svg = g.ownerSVGElement;
			var gesturePid = ev.pointerId;
			var startPX = ev.clientX, startPY = ev.clientY;
			var origX = node.x, origY = node.y;
			var dragging = false;
			try { g.setPointerCapture(ev.pointerId); } catch (ignore) { /* noop */ }

			function toSvg(dx, dy) {
				var scale = st.scale || 1;
				return { dx: dx / scale, dy: dy / scale };
			}
			function unhook() {
				window.removeEventListener('pointermove', onMove);
				window.removeEventListener('pointerup', onUp);
				window.removeEventListener('pointercancel', onCancel);
			}
			function onMove(mev) {
				if (mev.pointerId !== gesturePid)
					return;
				if (st.longPressPid === gesturePid) {
					// long press opened the menu: this gesture is no drag
					st.longPressPid = null;
					unhook();
					return;
				}
				var d = toSvg(mev.clientX - startPX, mev.clientY - startPY);
				if (!dragging && Math.abs(d.dx) + Math.abs(d.dy) > 4) {
					dragging = true;
					g.classList.add('dragging');
					hideMenu();
				}
				if (!dragging)
					return;
				var nx = Math.max(0, Math.min(opts.canvasW - model.nodeW, origX + d.dx));
				var ny = Math.max(0, Math.min(opts.canvasH - model.nodeH, origY + d.dy));
				node.x = nx; node.y = ny;
				g.setAttribute('transform', 'translate(' + nx + ',' + ny + ')');
				if (port) {
					port.setAttribute('cx', String(nx + model.nodeW));
					port.setAttribute('cy', String(ny + model.nodeH / 2));
					if (halo) {
						halo.setAttribute('cx', String(nx + model.nodeW));
						halo.setAttribute('cy', String(ny + model.nodeH / 2));
					}
				}
				updateEdges(svg, model);
				mev.preventDefault();
			}
			function onUp(uev) {
				if (uev.pointerId !== gesturePid)
					return;
				if (st.longPressPid === gesturePid)
					st.longPressPid = null;
				unhook();
				g.classList.remove('dragging');
				if (!dragging)
					return;
				noteSuppressingGesture();
				// snap back to the (possibly widened) grid so the node never
				// rests between cells
				var cxp = node.x + model.nodeW / 2;
				var cyp = node.y + model.nodeH / 2;
				var maxCols = Math.max(1, Math.min(model.maxCols, model.cols + 1));
				var maxRows = Math.max(1, Math.min(model.maxRows, model.rows + 1));
				var col = 1;
				while (col < maxCols && cxp >= colPos(model, col))
					col++;
				var row = 1;
				while (row < maxRows && cyp >= rowPos(model, row))
					row++;
				if (!dropCellFree(model, col, row, node.id)) {
					rerender();
					uev.stopPropagation();
					return;
				}
				node.x = colPos(model, col - 1) + (model.colW - model.nodeW) / 2 + (model._colE[col - 1] || 0);
				node.y = rowPos(model, row - 1) + (model.rowH - model.nodeH) / 2 + (model._rowE[row - 1] || 0);
				// assign the cell before rerender: render recomputes x/y
				// from col/row, otherwise the card snaps back until reload
				var oldCol = node.col, oldRow = node.row;
				node.col = col; node.row = row;
				rerender();
				if (col !== oldCol || row !== oldRow) {
					sendEvent(wgt, 'onNodeDrop', { nodeId: node.id, row: row, col: col });
				}
				uev.stopPropagation();
			}
			function onCancel(cev) {
				if (cev.pointerId !== gesturePid)
					return;
				if (st.longPressPid === gesturePid)
					st.longPressPid = null;
				unhook();
				g.classList.remove('dragging');
				if (dragging) {
					node.x = origX;
					node.y = origY;
					rerender();
				}
				noteSuppressingGesture();
				cev.stopPropagation();
			}
			window.addEventListener('pointermove', onMove);
			window.addEventListener('pointerup', onUp);
			window.addEventListener('pointercancel', onCancel);
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

	/* True when a path element belongs to the given edge. */
	function isEdgePath(p, edge) {
		return String(p.getAttribute('data-edge-id')) === String(edge.id);
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

	/* Highlight edge, label and end nodes while hovered. */
	function wireEdgeHover(target, svg, nodeLayer, edge) {
		target.addEventListener('mouseenter', function () {
			setEdgeHighlight(svg, nodeLayer, edge, true);
		});
		target.addEventListener('mouseleave', function () {
			setEdgeHighlight(svg, nodeLayer, edge, false);
		});
	}

	/* Find an edge by id, or null. */
	function findEdge(model, edgeId) {
		for (var i = 0; i < model.edges.length; i++) {
			var edge = model.edges[i];
			if (String(edge.id) === String(edgeId))
				return edge;
		}
		return null;
	}

	/* Recompute all routed edge paths after a node move. */
	function updateEdges(svg, model) {
		prepareLanes(model);
		var lists = [svg.querySelectorAll('path.wf-edge'), svg.querySelectorAll('path.wf-edge-hit')];
		for (var l = 0; l < lists.length; l++) {
			for (var i = 0; i < lists[l].length; i++) {
				var p = lists[l][i];
				var edgeId = p.getAttribute('data-edge-id');
				var edge = findEdge(model, edgeId);
				var d = edge ? edgePath(model, edge) : null;
				if (d)
					p.setAttribute('d', d);
			}
		}
	}

	/* Draw edges with hit areas, badges, chips and menus. */
	function renderEdges(layer, model, wgt, nodeLayer, labelLayer, menuOpts) {
		var svg = layer.ownerSVGElement;
		for (var i = 0; i < model.edges.length; i++) {
			(function (edge) {
				var r = edgePoints(model, edge);
				if (!r)
					return;
				var d = linePath(r.pts);
				var p = el('path', {
					'class': 'wf-edge',
					'd': d,
					'data-edge-id': edge.id,
					'data-from': edge.from,
					'data-to': edge.to,
					'tabindex': '0',
					'role': 'button'
				}, layer);
				p.setAttribute('aria-label', edgeLabel(edge) || ('Transition ' + edge.from + ' to ' + edge.to));
				// standard user workflow: dashed line, S badge near the
				// source end and a tooltip with the validity rule
				if (edge.stdUserWorkflow) {
					p.classList.add('wf-edge-std');
					var stdTip = el('title', null, p);
					stdTip.textContent = (edgeLabel(edge) || 'Transition') + ' \u2013 ' + stdUserWorkflowText(menuOpts)
						+ (edge.condTip ? '\n' + edge.condTip : '');
					if (p.getTotalLength) {
						var stdTotal = p.getTotalLength();
						var stdPt = p.getPointAtLength(Math.max(12, stdTotal * 0.1));
						var stdBadge = el('g', { 'class': 'wf-edge-badge', 'aria-hidden': 'true' }, layer);
						el('circle', { 'cx': stdPt.x, 'cy': stdPt.y, 'r': '7' }, stdBadge);
						var stdText = el('text', { 'class': 'wf-edge-badge-text', 'x': stdPt.x, 'y': stdPt.y + 3.5 }, stdBadge);
						stdText.textContent = 'S';
					}
				}
				// wide invisible hit area so the 1.5px line is easy to hover
				var hit = el('path', {
					'class': 'wf-edge-hit',
					'd': d,
					'data-edge-id': edge.id,
					'data-from': edge.from,
					'data-to': edge.to
				}, layer);
				// the invisible hit path sits on top of the visible line and
				// intercepts all hovering, so it needs the tooltip as well
				if (edge.stdUserWorkflow) {
					var stdTipHit = el('title', null, hit);
					stdTipHit.textContent = (edgeLabel(edge) || 'Transition') + ' \u2013 ' + stdUserWorkflowText(menuOpts)
						+ (edge.condTip ? '\n' + edge.condTip : '');
				}
				// conditions tooltip on line hover (hit path intercepts hovering)
				if (edge.condTip && !edge.stdUserWorkflow) {
					var condTitle = el('title', null, p);
					condTitle.textContent = (edgeLabel(edge) || 'Transition') + '\n' + edge.condTip;
					var condTitleHit = el('title', null, hit);
					condTitleHit.textContent = condTitle.textContent;
				}
				function fireEdgeClick(ev) {
					ev.stopPropagation();
					sendEvent(wgt, 'onEdgeClick', {
						edgeId: edge.id, from: edge.from, to: edge.to
					});
				}
				function openEdgeMenu(target, ev) {
					var items = edgeMenuItems(edge, menuOpts, wgt);
					if (ev && ev.clientX !== undefined) {
						showMenu(items, ev.clientX, ev.clientY, function (item) {
							menuAction(wgt, 'edge', edge.id, item.action);
						});
					} else {
						showMenuAt(target.getBoundingClientRect(), items);
					}
				}
				function edgeMenu(ev) {
					ev.preventDefault();
					ev.stopPropagation();
					openEdgeMenu(ev.currentTarget, ev);
				}
				// left click only stops propagation; the menu opens via
				// right click, long press, tap (touch) or keyboard
				function edgeClick(ev) {
					ev.stopPropagation();
					if (isClickSuppressed())
						return;
					if (!menuOpts.menuEnabled)
						fireEdgeClick(ev);
					else if (isCoarsePointer())
						openEdgeMenu(ev.currentTarget, ev);
				}
				wireEdgeHover(p, svg, nodeLayer, edge);
				wireEdgeHover(hit, svg, nodeLayer, edge);
				p.addEventListener('click', edgeClick);
				hit.addEventListener('click', edgeClick);
				// touch: long press replaces right click (menu only)
				if (menuOpts.menuEnabled) {
					addLongPress(hit, function (pos) {
						showMenuAt({ left: pos.clientX, top: pos.clientY, width: 0, height: 0,
							right: pos.clientX, bottom: pos.clientY }, edgeMenuItems(edge, menuOpts, wgt));
					});
				}
				p.addEventListener('contextmenu', edgeMenu);
				hit.addEventListener('contextmenu', edgeMenu);
				function edgeDblClick(ev) {
					ev.preventDefault();
					ev.stopPropagation();
					if (menuOpts.menuEnabled)
						menuAction(wgt, 'edge', edge.id, 'properties');
				}
				p.addEventListener('dblclick', edgeDblClick);
				hit.addEventListener('dblclick', edgeDblClick);
				p.addEventListener('keydown', function (ev) {
					if (ev.key === 'Enter' || ev.key === ' ') {
						ev.preventDefault();
						if (menuOpts.menuEnabled) {
							var rect = ev.currentTarget.getBoundingClientRect();
							showMenuAt(rect, edgeMenuItems(edge, menuOpts, wgt));
						} else {
							fireEdgeClick(ev);
						}
					} else if (menuOpts.menuEnabled && (ev.key === 'Delete' || ev.key === 'Backspace')) {
						ev.preventDefault();
						menuAction(wgt, 'edge', edge.id, 'deleteLine');
					}
				});
				// sequence badge on the connector start (only when the source
				// has more than two outgoing connectors), description chip
				// centered on the longest free segment, rotated on vertical
				// segments; both click-through (interaction goes through the
				// hit path underneath)
				addSeqBadge(labelLayer || layer, model, edge, r.exit,
					menuOpts.menuEnabled ? openEdgeMenu : null);
				var fullLabel = edge.description || '';
				if (fullLabel !== '') {
					var mid = labelPoint(model, r.pts, fullLabel.length * 5.6 + 12) || edgeMidpoint(model, edge);
					// too long for the segment: abbreviate, full text stays in the tooltip
					var label = fullLabel;
					if (mid && mid.len) {
						var maxChars = Math.max(1, Math.floor((mid.len - 12) / 5.6));
						if (label.length > maxChars)
							label = label.substring(0, Math.max(0, maxChars - 1)) + '\u2026';
					}
					var chipLayer = labelLayer || layer;
					var gchip = el('g', { 'class': 'wf-edge-chip', 'aria-hidden': 'true' }, chipLayer);
					var lt = text(gchip, mid.x, mid.y + 3.5, label, {
						'class': 'wf-edge-label',
						'data-edge-id': edge.id,
						'data-from': edge.from,
						'data-to': edge.to,
						'text-anchor': 'middle'
					});
					if (label !== fullLabel) {
						var ft = el('title', null, gchip);
						ft.textContent = fullLabel;
					}
					var lbb = null;
					try { lbb = lt.getBBox ? lt.getBBox() : null; } catch (e) { lbb = null; }
					if (lbb && lbb.width > 0 && lbb.height > 0) {
						var chip = el('rect', {
							'x': lbb.x - 6, 'y': lbb.y - 3,
							'width': lbb.width + 12, 'height': lbb.height + 6,
							'rx': '8', 'class': 'wf-edge-label-bg'
						}, gchip);
						gchip.insertBefore(chip, lt);
					} else {
						// fallback when the text cannot be measured yet (e.g.
						// panel renders hidden without layout): estimate from
						// the string length so the frame shows in any case
						var estW = label.length * 5.6 + 12;
						var estH = 16;
						var chipFb = el('rect', {
							'x': mid.x - estW / 2, 'y': mid.y - estH / 2,
							'width': estW, 'height': estH,
							'rx': '8', 'class': 'wf-edge-label-bg'
						}, gchip);
						gchip.insertBefore(chipFb, lt);
					}
					if (mid.vertical)
						gchip.setAttribute('transform', 'rotate(90 ' + mid.x + ' ' + mid.y + ')');
					if (menuOpts.menuEnabled && isCoarsePointer()) {
						gchip.addEventListener('click', function (cev) {
							cev.stopPropagation();
							if (isClickSuppressed())
								return;
							openEdgeMenu(gchip, cev);
						});
					}
				}
			})(model.edges[i]);
		}
	}

	/* Per-instance stylesheet and resource defs. The style element inside an
	 * SVG is document wide CSS, so with several workflow windows the blocks
	 * would override each other (last one wins) and the other windows would
	 * lose frame and shadow. Every rule is therefore scoped to this
	 * instance's svg id, and the shadow filter and arrow marker live inside
	 * the same svg - no cross window references at all. */
	function scopedStyle(uuid) {
		var p = '#' + uuid + '-svg ';
		var style = document.createElementNS(SVG_NS, 'style');
		style.textContent = p + '.wf-grid-dot{fill:#d0d7de}'
			+ p + '.wf-node-box{fill:#fff;stroke:#8c959f;stroke-width:1.2;'
			+ 'filter:url(#' + uuid + '-cardshadow)}'
			+ p + '.wf-node{cursor:pointer}'
			+ p + '.wf-node:hover .wf-node-box{stroke:#0969da;stroke-width:2}'
			+ p + '.wf-node.selected .wf-node-box{stroke:#0969da;stroke-width:2.5;fill:#ddf4ff}'
			+ p + '.wf-node.dragging{opacity:.75}'
			+ p + '.wf-node:focus{outline:none}'
			+ p + '.wf-node:focus .wf-node-box{stroke:#0969da;stroke-width:2.5;stroke-dasharray:5 2}'
			+ p + '.wf-glyph{fill:#57606a}'
			+ p + '.wf-node-image{pointer-events:none}'
			+ p + '.wf-glyph-text{fill:#fff;font-size:11px;font-weight:bold}'
			+ p + '.wf-title{font-size:12px;font-weight:bold;fill:#24292f;font-family:sans-serif}'
			+ p + '.wf-desc{font-size:11px;fill:#24292f;font-family:sans-serif}'
			+ p + '.wf-action{font-size:10px;fill:#57606a;font-family:sans-serif}'
			+ p + '.wf-sep{stroke:#d0d7de;stroke-width:1}'
			+ p + '.wf-edge{fill:none;stroke:#57606a;stroke-width:1.5;cursor:pointer;marker-end:url(#' + uuid + '-arrow)}'
			+ p + '.wf-edge.hl{stroke:#0969da;stroke-width:2.5}'
			+ p + '.wf-edge:focus{outline:none;stroke:#0969da;stroke-width:2.5}'
			+ p + '.wf-edge-hit{fill:none;stroke:rgba(0,0,0,0);stroke-width:14;pointer-events:stroke;cursor:pointer}'
			+ p + '.wf-node.hl .wf-node-box{stroke:#0969da;stroke-width:2.5}'
			+ p + '.wf-arrow{fill:#57606a}'
			+ p + '.wf-edge-label{font-size:10px;fill:#24292f;font-family:sans-serif;pointer-events:none}'
			+ p + '.wf-edge-chip{pointer-events:none}'
			+ p + '.wf-edge-label-bg{fill:#fff;stroke:#d0d7de;stroke-width:1;pointer-events:none}'
			+ p + '.wf-edge-label.hl{fill:#0969da;font-weight:bold}'
			+ p + '.wf-seq-badge{pointer-events:none}'
			+ p + '.wf-seq-badge-circle{fill:#fff;stroke:#57606a;stroke-width:1.2}'
			+ p + '.wf-cond-badge-diamond{fill:#fff;stroke:#57606a;stroke-width:1.2}'
			+ p + '.wf-seq-badge-text{fill:#24292f;font-size:9px;font-weight:bold;font-family:sans-serif;text-anchor:middle;pointer-events:none}'
			+ p + '.wf-empty{font-size:13px;fill:#57606a;font-family:sans-serif}'
			// per node lock: only the white card background turns gray, all
			// fonts keep full contrast so locked nodes stay readable
			+ p + '.wf-node-locked{cursor:default}'
			+ p + '.wf-node-locked .wf-node-box{fill:#edf0f3;stroke:#c3c8cf}'
			+ p + '.wf-node-locked:hover .wf-node-box{stroke:#c3c8cf;stroke-width:1.2}'
			+ p + '.wf-node-locked:focus .wf-node-box{stroke:#c3c8cf;stroke-width:1.2;stroke-dasharray:none}'
			+ p + '.wf-node-locked .wf-node-image{filter:grayscale(1);opacity:.55}'
			// connection port and connect-by-drag feedback
			+ p + '.wf-port{fill:#0969da;stroke:#fff;stroke-width:1.5;opacity:0;cursor:crosshair;transition:opacity .12s}'
			+ p + '.wf-port:hover{opacity:1}'
			+ p + '.wf-connect-line{stroke:#0969da;stroke-width:2;stroke-dasharray:6 4;fill:none;pointer-events:none}'
			+ p + '.wf-connect-target .wf-node-box{stroke:#0969da;stroke-width:2.5}'
			+ p + '.wf-dropgrid{stroke:#eceff3;stroke-width:1;fill:none;pointer-events:none}'
			+ p + '.wf-edge-std{stroke-dasharray:7 4}'
			+ p + '.wf-edge-badge{pointer-events:none}'
			+ p + '.wf-edge-badge-text{fill:#fff;font-size:9px;font-weight:bold;font-family:sans-serif;text-anchor:middle;pointer-events:none}'
			// touch (iPhone/iPad): no hover, right click or double click, so
			// targets grow, ports and chips stay tappable and the desktop
			// hint (right click wording) is hidden; the svg <style> block
			// applies document wide, hence the global selectors below
			+ '@media (pointer:coarse){'
			+ '.wf-toolbar .wf-tbtn{min-width:44px;min-height:44px;font-size:14px;padding:6px 12px}'
			+ '.wf-toolbar .wf-hint{display:none}'
			+ '.wf-menu-item{min-height:44px;display:flex;align-items:center;font-size:14px}'
			+ '}'
			+ '#' + uuid + '-svg{-webkit-touch-callout:none;user-select:none;-webkit-user-select:none}'
			+ '#' + uuid + '-svg text{user-select:none;-webkit-user-select:none}'
			+ '.wf-toolbar{user-select:none;-webkit-user-select:none}'
			+ '@media (pointer:coarse){'
			+ p + '.wf-edge-chip{pointer-events:all;cursor:pointer}'
			+ p + '.wf-seq-badge{pointer-events:all;cursor:pointer}'
			+ p + '.wf-edge-chip .wf-edge-label-bg{pointer-events:all}'
			+ p + '.wf-seq-badge-circle{pointer-events:all}'
			+ p + '.wf-cond-badge-diamond{pointer-events:all}'
			+ '}';
		return style;
	}

	/* Standard user workflow hint: only valid when Complete is selected. */
	function stdUserWorkflowText(opts) {
		var name = opts.stdUserWorkflow || 'Standard user workflow';
		var rule = opts.stdUserWorkflowOnly || 'Only valid when Complete is selected in the document';
		return name + ' \u2013 ' + rule;
	}

	/* Render the whole graph: lanes, svg, grid, edges, nodes, zoom. */
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
		model.maxCols = model.maxCols || model.cols;
		model.maxRows = model.maxRows || model.rows;
		opts = opts || {};

		var wgt = (typeof zk !== 'undefined' && zk.Widget) ? zk.Widget.$(uuid) : null;
		var root = wgt ? wgt.$n() : document.getElementById(uuid);
		if (!root)
			return;
		var st = getState(uuid, model);

		var savedScroll = saveScroll(root);
		while (root.firstChild)
			root.removeChild(root.firstChild);

		// lane tables first: crowded grid lines widen their gutters, which
		// shifts nodes and the canvas size; channel keys derive from node
		// rows/columns only, so one pass is stable
		prepareLanes(model);
		for (var np = 0; np < model.nodes.length; np++) {
			var npn = model.nodes[np];
			npn.x = colPos(model, npn.col - 1) + (model.colW - model.nodeW) / 2 + (model._colE[npn.col - 1] || 0);
			npn.y = rowPos(model, npn.row - 1) + (model.rowH - model.nodeH) / 2 + (model._rowE[npn.row - 1] || 0);
		}

		var canvasW = model._canvasW || (model.cols + 1) * model.colW;
		var canvasH = model._canvasH || Math.max(1, model.rows + 1) * model.rowH;

		var svg = el('svg', {
			'id': uuid + '-svg',
			'class': 'wf-canvas',
			'role': 'img',
			'aria-label': opts.graphLabel || 'Workflow graph',
			'viewBox': '0 0 ' + canvasW + ' ' + canvasH
		}, null);
		// width/height attributes drive the zoom level via the viewBox;
		// keep theme CSS from clamping the svg back to container width
		svg.style.display = 'block';
		svg.style.maxWidth = 'none';
		// the setup editor drives zoom from its own symbol bar (see the
		// zoom api below) and hides this row via opts.toolbar === false
		if (opts.toolbar !== false)
			renderToolbar(root, svg, st, canvasW, canvasH, opts);
		st.canvasW = canvasW;
		st.canvasH = canvasH;
		root.appendChild(svg);

		var defs = el('defs', null, svg);
		defs.appendChild(scopedStyle(uuid));
		var marker = el('marker', {
			'id': uuid + '-arrow', 'viewBox': '0 0 10 10', 'refX': '9', 'refY': '5',
			'markerWidth': '7', 'markerHeight': '7', 'orient': 'auto-start-reverse'
		}, defs);
		el('path', { 'd': 'M 0 1 L 9 5 L 0 9 z', 'class': 'wf-arrow' }, marker);
		// card shadow: same two layer shadow the ZK popup menu uses
		var cardShadow = el('filter', {
			'id': uuid + '-cardshadow', 'x': '-30%', 'y': '-30%', 'width': '160%', 'height': '160%'
		}, defs);
		el('feDropShadow', {
			'dx': '0', 'dy': '3', 'stdDeviation': '3', 'flood-color': '#000000', 'flood-opacity': '0.16'
		}, cardShadow);
		el('feDropShadow', {
			'dx': '0', 'dy': '2', 'stdDeviation': '2', 'flood-color': '#000000', 'flood-opacity': '0.24'
		}, cardShadow);

		// grid dots centered on every (possibly widened) grid intersection
		var dots = '';
		for (var gi = 0; gi <= model.cols; gi++) {
			for (var gj = 0; gj <= model.rows; gj++) {
				dots += 'M ' + (colPos(model, gi) - 1.5) + ' ' + rowPos(model, gj)
					+ ' a 1.5 1.5 0 1 0 3 0 a 1.5 1.5 0 1 0 -3 0 Z ';
			}
		}
		el('path', { 'd': dots, 'class': 'wf-grid-dot' }, svg);

		// light gray cell grid marking the drop zones (setup editor only)
		if (opts.editable) {
			var dropGrid = '';
			for (var gv = 0; gv <= model.cols; gv++)
				dropGrid += 'M ' + colPos(model, gv) + ' 0 V ' + canvasH + ' ';
			for (var gh = 0; gh <= model.rows; gh++)
				dropGrid += 'M 0 ' + rowPos(model, gh) + ' H ' + canvasW + ' ';
			el('path', { 'd': dropGrid, 'class': 'wf-dropgrid' }, svg);
		}

		var edgeLayer = el('g', { 'class': 'wf-edges' }, svg);
		var nodeLayer = el('g', { 'class': 'wf-nodes' }, svg);
		var labelLayer = el('g', { 'class': 'wf-labels' }, svg);
		// ports live in their own topmost layer so the blue drag dots
		// (and connect targets) always paint above badges and chips
		var portLayer = el('g', { 'class': 'wf-ports' }, svg);

		renderEdges(edgeLayer, model, wgt, nodeLayer, labelLayer, {
			menuEnabled: !!opts.menuEnabled,
			menuZoom: opts.menuZoom, menuProperties: opts.menuProperties,
			menuDeleteLine: opts.menuDeleteLine,
			stdUserWorkflow: opts.stdUserWorkflow, stdUserWorkflowOnly: opts.stdUserWorkflowOnly
		});

		function rerender() {
			render(uuid, st.model, opts);
		}
		for (var i = 0; i < model.nodes.length; i++) {
			renderNode(nodeLayer, model, model.nodes[i], st, wgt, {
				editable: !!opts.editable, grayLockedNodes: !!opts.grayLockedNodes,
				menuEnabled: !!opts.menuEnabled,
				menuZoom: opts.menuZoom, menuProperties: opts.menuProperties,
				menuDeleteNode: opts.menuDeleteNode, menuDeleteLine: opts.menuDeleteLine,
				menuPinPosition: opts.menuPinPosition, menuUnpinPosition: opts.menuUnpinPosition,
				canvasW: canvasW, canvasH: canvasH
			}, rerender, portLayer);
		}

		applyZoom(root, svg, st, canvasW, canvasH);

		// small touch screens start fitted to the width instead of actual
		// size; one time per view so a manual zoom sticks
		if (!st.fitDone) {
			st.fitDone = true;
			if (isCoarsePointer() && root.clientWidth && root.clientWidth < canvasW)
				zoomFit(st, root, svg, canvasW);
		}

		svg.addEventListener('wheel', function (ev) {
			if (!ev.ctrlKey && !ev.metaKey)
				return;
			ev.preventDefault();
			zoomTo(st, root, svg, canvasW, canvasH, st.scale + (ev.deltaY < 0 ? 0.1 : -0.1));
		}, { passive: false });

		if (model.nodes.length === 0) {
			text(svg, 20, 30, opts.emptyText || 'No workflow nodes', { 'class': 'wf-empty' });
		}
		restoreScroll(savedScroll);
	}

	window.idempiere.wfgraph.render = render;
	window.idempiere.wfgraph.edgePath = edgePath;
	/* External zoom control for host toolbars (setup editor symbol bar):
	 * mode is 'in', 'out', 'fit' or 'actual'. No-op while the view behind
	 * uuid is not drawn. */
	window.idempiere.wfgraph.zoom = function (uuid, mode) {
		var st = stateByUuid[uuid];
		if (!st)
			return;
		var root = document.getElementById(uuid);
		var svg = document.getElementById(uuid + '-svg');
		if (!root || !svg || !st.canvasW || !st.canvasH)
			return;
		if (mode === 'in')
			zoomTo(st, root, svg, st.canvasW, st.canvasH, st.scale + 0.1);
		else if (mode === 'out')
			zoomTo(st, root, svg, st.canvasW, st.canvasH, st.scale - 0.1);
		else if (mode === 'fit')
			zoomFit(st, root, svg, st.canvasW);
		else if (mode === 'actual')
			zoomTo(st, root, svg, st.canvasW, st.canvasH, 1);
	};
	// bump when the script changes, so a deployment can be verified in the
	// browser console via idempiere.wfgraph.version
	window.idempiere.wfgraph.version = '43-locked-connect';
	window.idempiere.wfgraph.dispose = function (uuid) {
		delete stateByUuid[uuid];
	};
})();
