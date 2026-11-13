zk.afterLoad('zul.mesh', function() {

    zk.override(zul.mesh.Paging.prototype, "bind_", function() {
      this.$bind_.apply(this, arguments);
      if (this._totalSize == 0x7fffffff) {
        jq(".z-paging-text", this).text(" / ?");
      }
    });

    zk.override(zul.mesh.Paging.prototype, "infoText_",
      function() {
        //this.$infoText_.apply(this, arguments);
        let acp = this._activePage,
          psz = this._pageSize,
          tsz = this._totalSize,

          lastItem = (acp + 1) * psz,
          dash = '';

        if ('os' != this.getMold())
          dash = ' - ' + (lastItem > tsz ? tsz : lastItem);

        if (this._totalSize == 0x7fffffff)
          tsz = "?";

        return '[ ' + (acp * psz + 1) + dash + ' / ' + tsz + ' ]';
    });
    
    let _xFrozen = {};
    zk.override(zul.mesh.Frozen.prototype, _xFrozen, {
      _smooth: true,
      _currentLeft: 0,

      setSmooth: function(smooth) {
        let wasEnabled = this._smoothFrozenEnabled();
        this._smooth = smooth;
        let nowEnabled = this._smoothFrozenEnabled();
        if (this.desktop && wasEnabled !== nowEnabled) {
          let p = this.parent;
          if (nowEnabled) {
            if (p && p.$n()) {
              p.$n().querySelectorAll('.hiddencol').forEach(function(el) {
                el.classList.remove('hiddencol');
              });
            }
            this._bindSmoothListeners();
            this._applyStickyColumns();
            this._onSizeLaterSticky();
          } else {
            this._unbindSmoothListeners();
            this._clearTimers();
            this._clearStickyColumns();
            this.onSize();
          }
        }
        return this;
      },

      getSmooth: function() {
        return this._smooth;
      },

      _smoothFrozenEnabled: function() {
        return this._smooth !== false;
      },

      /* ZK renders currentLeft for a smooth frozen (Frozen.renderProperties) and keeps it
         updated from onScrollPos, so the server holds the exact scroll offset of the last
         render. Without this setter the value would be dropped on the widget as a plain
         property and the position would be recomputed from the start column instead. */
      setCurrentLeft: function(left) {
        left = left || 0;
        if (this._currentLeft === left) return this;
        this._currentLeft = left;
        if (this.desktop && this._smoothFrozenEnabled()) {
          this._setScrollLeft(left);
        }
        return this;
      },

      _bindSmoothListeners: function() {
        let p = this.parent;
        if (!p || this._colSizeHandler) return;
        let self = this;
        this._colSizeHandler = function() {
          if (self.desktop && self._smoothFrozenEnabled()) {
            self._requestStickySize();
          }
        };
        /* No body scroll listener here: MeshWidget already registers one and calls
           frozen.syncScrollByParentBody(), which is overridden below. */
        p.listen({ onColSize: this._colSizeHandler });
      },

      _unbindSmoothListeners: function() {
        let p = this.parent;
        if (p && this._colSizeHandler) {
          p.unlisten({ onColSize: this._colSizeHandler });
        }
        this._colSizeHandler = null;
      },

      _requestStickySize: function() {
        if (this._delayedStickySize) return;
        let self = this;
        this._delayedStickySize = setTimeout(function() {
          self._delayedStickySize = null;
          if (!self.desktop || !self._smoothFrozenEnabled()) return;
          self._applyStickyColumns();
          self._onSizeLaterSticky();
        }, 0);
      },

      bind_: function() {
        _xFrozen.bind_.apply(this, arguments);
        let p = this.parent;
        if (!p) return;

        if (p._nativebar) {
          let scroll = this.$n('scrollX'),
            scrollbarWidth = jq.scrollbarWidth();
          // Workaround from https://tracker.zkoss.org/browse/ZK-5159
          if (scrollbarWidth <= 0) {
            scrollbarWidth = 12;
          }
          let h = jq.px0(zk.ie ? scrollbarWidth + 1 : scrollbarWidth);
          if (this.$n()) this.$n().style.height = h;
          if (this.$n('cave')) this.$n('cave').style.height = h;
          if (this.$n('right')) this.$n('right').style.height = h;
          if (scroll) {
            scroll.style.height = h;
            if (scroll.firstChild) {
              scroll.firstChild.style.height = h;
            }
          }
        }

        if (this._smoothFrozenEnabled()) {
          this._bindSmoothListeners();
          this._applyStickyColumns();
        }
      },

      unbind_: function() {
        this._unbindSmoothListeners();
        this._clearTimers();
        this._clearStickyColumns();

        _xFrozen.unbind_.apply(this, arguments);
      },

      _clearTimers: function() {
        if (this._delayedScrollSync) {
          clearTimeout(this._delayedScrollSync);
          this._delayedScrollSync = null;
        }
        if (this._delayedStartSync) {
          clearTimeout(this._delayedStartSync);
          this._delayedStartSync = null;
        }
        if (this._delayedStickySize) {
          clearTimeout(this._delayedStickySize);
          this._delayedStickySize = null;
        }
      },

      onSize: function() {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen.onSize.apply(this, arguments);
        }
        if (!this._columns) return;

        let p = this.parent,
          phead = p ? p.head : null;
        if (p && p._nativebar && phead) {
          let n = phead.$n(),
            firstHdcell = n && n.cells ? n.cells[0] : undefined;
          if (firstHdcell) {
            let fhcs = firstHdcell.style;
            if (!fhcs.height || n.cells[1]) {
              fhcs.height = jq.px0(Math.max(firstHdcell.offsetHeight, n.cells[1] ? n.cells[1].offsetHeight : 0));
            }
          }
        }

        this._requestStickySize();
      },

      onResponse: function() {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen.onResponse.apply(this, arguments);
        }
        if (this.desktop && this._columns) {
          this._applyStickyColumns();
          this._onSizeLaterSticky();
        }
      },

      setColumns: function(columns, opts) {
        let res = _xFrozen.setColumns.apply(this, arguments);
        if (this._smoothFrozenEnabled() && this.desktop) {
          this._clearStickyColumns();
          if (this._columns) {
            this._applyStickyColumns();
            this._onSizeLaterSticky();
          }
        }
        return res;
      },

      setStart: function(start, opts) {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen.setStart.apply(this, arguments);
        }
        if (this.desktop) {
          this._currentLeft = undefined;
        }
        let o = this._start;
        this._start = start;
        if (o !== start || (opts && opts.force)) {
          this.syncScroll();
        }
        return this;
      },

      syncScroll: function() {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen.syncScroll.apply(this, arguments);
        }
        this._syncScrollSmooth();
      },

      _syncScrollSmooth: function() {
        let p = this.parent;
        if (!p || !p._nativebar) return;

        let scroll = this.$n('scrollX');
        if (!scroll) return;

        let targetLeft = this._currentLeft;
        if (targetLeft == null) {
          targetLeft = 0;
          if (this._start > 0 && p.eheadrows) {
            let colWidths = this._measureHeaderColumnWidths(p),
              columns = this._columns || 0,
              endCol = Math.min(colWidths.length, columns + this._start);
            for (let i = columns; i < endCol; i++) {
              if (colWidths[i].visible) {
                targetLeft += colWidths[i].width;
              }
            }
          }
          this._currentLeft = targetLeft;
        }

        this._setScrollLeft(targetLeft);
      },

      syncScrollByParentBody: function() {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen.syncScrollByParentBody.apply(this, arguments);
        }
        let p = this.parent;
        if (!p || !p._nativebar || !p.ebody) return;
        let left = p.ebody.scrollLeft;
        if (!this._scrollLeftChanged(left)) return;
        this._setScrollLeft(left);
        this._syncStartFromPixel();
      },

      _onScroll: function(evt) {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen._onScroll.apply(this, arguments);
        }
        if (!evt.data || !zk.currentFocus) return;
        let p = this.parent;
        if (p && p.ebody) {
          let cf = zk.currentFocus,
            td = cf ? p.getFocusCell(cf.$n()) : null;
          if (td && !td.classList.contains('z-frozen-sticky')) {
            let index = td.cellIndex - (this._columns || 0);
            if (index >= 0) {
              let frozenWidth = this._frozenWidth || 0,
                tdLeft = td.offsetLeft,
                tdWidth = td.offsetWidth,
                curLeft = p.ebody.scrollLeft,
                viewWidth = p.ebody.clientWidth,
                availableWidth = Math.max(0, viewWidth - frozenWidth);
              if (tdLeft < curLeft + frozenWidth) {
                let target = Math.max(0, tdLeft - frozenWidth);
                this._setScrollLeft(target);
              } else if (tdLeft + tdWidth > curLeft + viewWidth) {
                let target;
                if (tdWidth > availableWidth) {
                  /* Wide cell exceeds scrollable viewport: anchor its left edge at the
                     frozen boundary so the input cursor is not pushed under frozen columns. */
                  target = Math.max(0, tdLeft - frozenWidth);
                } else {
                  target = Math.max(0, tdLeft + tdWidth - viewWidth);
                }
                this._setScrollLeft(target);
              } else {
                this._setScrollLeft(curLeft, 'body');
              }
              this._syncStartFromPixel();
            }
          }
        }
        evt.stop();
      },

      _doHeadScroll: function(evt) {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen._doHeadScroll.apply(this, arguments);
        }
        let head = evt.domTarget;
        if (!head) return;
        let left = head.scrollLeft;
        if (!this._scrollLeftChanged(left)) return;
        this._setScrollLeft(left, 'head');
        this._syncStartFromPixel();
      },

      _doScroll: function(n) {
        if (!this._smoothFrozenEnabled()) {
          return _xFrozen._doScroll.apply(this, arguments);
        }
        /* Coalesce the burst of scroll events fired while dragging a scrollbar */
        if (this._delayedScrollSync) return;
        let self = this;
        this._delayedScrollSync = setTimeout(function() {
          self._delayedScrollSync = null;
          if (!self.desktop || !self._smoothFrozenEnabled()) return;
          self._doScrollSmooth(n);
        }, 0);
      },

      _doScrollSmooth: function(n) {
        let p = this.parent;
        if (!p) return;

        let scroll = this.$n('scrollX'),
          left = p._nativebar && scroll ? scroll.scrollLeft : (typeof n === 'number' ? Math.ceil(n) : 0);
        if (!this._scrollLeftChanged(left)) return;

        this._setScrollLeft(left, 'scrollX');
        this._syncStartFromPixel();
      },

      /* ZK calls this as _doScrollNow(num, force) from _syncFrozenNow(); `force` only
         affects the fake column width recalculation done by the legacy implementation,
         which smooth mode does not use, so it is ignored on purpose. `num` is the column
         start ZK wants to restore and is only used when the pixel position is unknown. */
      _doScrollNow: function(num, force) {
        if (!this._smoothFrozenEnabled()) {
          let result = _xFrozen._doScrollNow.apply(this, arguments);
          /*Patch: add class to non-visible columns*/
          let mesh = this.parent;
          if (mesh && mesh.head && mesh.ehdfaker) {
            let totalCols = mesh.head.nChildren,
              hdcol = mesh.ehdfaker.firstChild;

            for (let i = 0; hdcol && i < totalCols; hdcol = hdcol.nextSibling, i++) {
              let wgt = zk.$(hdcol);
              if (wgt && wgt.$n()) {
                if (hdcol.style.width.indexOf('0.001px') != -1 || hdcol.style.width.indexOf('0px') != -1) {
                  wgt.$n().classList.add("hiddencol");
                } else {
                  wgt.$n().classList.remove("hiddencol");
                }
              }
            }
          }
          return result;
        }

        let p = this.parent;
        if (!p) return;

        /* Ensure no legacy hiddencol class remains when in smooth mode */
        if (p.$n()) {
          p.$n().querySelectorAll('.hiddencol').forEach(function(el) {
            el.classList.remove('hiddencol');
          });
        }

        if (this._currentLeft == null) {
          /* No pixel position yet (e.g. after columns were hidden/shown): rebuild it from
             the start column ZK asked for. */
          if (typeof num === 'number') {
            this._start = num;
          }
          this._syncScrollSmooth();
        } else {
          this._setScrollLeft(this._currentLeft);
        }
        this._applyStickyColumns();
        p._restoreFocus();
      },

      _setScrollLeft: function(left, source) {
        let p = this.parent;
        if (!p) return;

        this._currentLeft = left;
        let scroll = this.$n('scrollX');
        if (source !== 'scrollX' && scroll && scroll.scrollLeft !== left) {
          scroll.scrollLeft = left;
        }
        if (source !== 'head' && p.ehead && p.ehead.scrollLeft !== left) {
          p.ehead.scrollLeft = left;
        }
        if (source !== 'body' && p.ebody && p.ebody.scrollLeft !== left) {
          p.ebody.scrollLeft = left;
        }
        if (p.efoot && p.efoot.scrollLeft !== left) {
          p.efoot.scrollLeft = left;
        }
      },

      /* A scroll event only carries news when it moved away from the position we last
         synced. This equality check replaces a "syncing" flag, whose setTimeout based
         reset races with the asynchronous scroll events fired by our own scrollLeft
         assignments (browsers dispatch those in a later task than setTimeout(0)). */
      _scrollLeftChanged: function(left) {
        return this._currentLeft == null || Math.abs(left - this._currentLeft) >= 1;
      },

      _syncStartFromPixel: function() {
        /* Coalesce: the pixel position is read again when the timer fires */
        if (this._delayedStartSync) return;
        let self = this;
        this._delayedStartSync = setTimeout(function() {
          self._delayedStartSync = null;
          if (!self.desktop || !self._smoothFrozenEnabled()) return;
          self._syncStartFromPixelNow();
        }, 50);
      },

      _syncStartFromPixelNow: function() {
        let p = this.parent;
        if (!p || !p.eheadrows) return;
        let colWidths = this._measureHeaderColumnWidths(p);
        if (!colWidths.length) return;

        let start = 0,
          rem = this._currentLeft || 0,
          columns = this._columns || 0;
        for (let i = columns; i < colWidths.length; i++) {
          if (!colWidths[i].visible) continue;
          rem -= colWidths[i].width;
          if (rem < 0) break;
          start++;
        }
        if (start !== this._start) {
          this._start = start;
          this.smartUpdate('start', start);
        }
      },

      /* Resolves per-logical-column visibility and width, accounting for header cells
         with colSpan (e.g. Auxhead) and falling back to head widget / ehdfaker <col>
         elements when available. */
      _measureHeaderColumnWidths: function(p) {
        let result = [];
        if (p.head && p.head.nChildren) {
          let idx = 0;
          for (let w = p.head.firstChild; w; w = w.nextSibling, idx++) {
            let n = w.$n(),
              vis = w.isVisible(),
              width = 0;
            if (vis) {
              width = n ? this._getCellWidth(n, w) : 0;
              if (!width && p.ehdfaker && p.ehdfaker.children && p.ehdfaker.children[idx]) {
                width = this._getCellWidth(p.ehdfaker.children[idx], w);
              }
            }
            result.push({ visible: vis, width: width });
          }
          if (result.length > 0) {
            return result;
          }
        }

        let headCells = p.eheadrows ? p._getFirstRowCells(p.eheadrows) : null;
        if (!headCells || headCells.length === 0) return result;

        let fakerCols = p.ehdfaker ? p.ehdfaker.children : null,
          colIdx = 0;
        for (let c = 0; c < headCells.length; c++) {
          let cell = headCells[c],
            hdWgt = zk.Widget.$(cell),
            vis = !hdWgt || hdWgt.isVisible(),
            span = cell.colSpan || 1;
          if (span === 1) {
            let w = vis ? this._getCellWidth(cell, hdWgt) : 0;
            result[colIdx] = { visible: vis, width: w };
            colIdx++;
          } else {
            let totalW = vis ? this._getCellWidth(cell, hdWgt) : 0,
              evenW = span > 0 ? Math.floor(totalW / span) : 0,
              remW = totalW - evenW * span;
            for (let s = 0; s < span; s++) {
              let fk = fakerCols && fakerCols[colIdx] ? fakerCols[colIdx] : null,
                fkWgt = fk ? zk.Widget.$(fk) : null,
                colVis = fkWgt ? fkWgt.isVisible() : vis,
                colW = 0;
              if (colVis) {
                colW = fk ? this._getCellWidth(fk, fkWgt) : 0;
                if (!colW) {
                  colW = evenW + (s === span - 1 ? remW : 0);
                }
              }
              result[colIdx] = { visible: colVis, width: colW };
              colIdx++;
            }
          }
        }
        return result;
      },

      _restoreCellWidth: function(n, hdWgt) {
        if (!n) return;
        let isVisible = !hdWgt || hdWgt.isVisible();
        if (!isVisible) return;
        if (n.offsetWidth === 0) {
          let colWd = hdWgt && hdWgt.getWidth && hdWgt.getWidth(),
            restoredWd = null;
          if (colWd && colWd.indexOf('px') > 0) {
            restoredWd = colWd;
          } else if (hdWgt && hdWgt._origWd && hdWgt._origWd.indexOf('px') > 0) {
            restoredWd = hdWgt._origWd;
          } else if (hdWgt && hdWgt._hflexWidth && hdWgt._hflexWidth > 0) {
            restoredWd = jq.px(hdWgt._hflexWidth);
          }
          if (restoredWd) {
            n.style.width = restoredWd;
            if (n.id) {
              let faker;
              if ((faker = document.getElementById(n.id + '-hdfaker'))) faker.style.width = restoredWd;
              if ((faker = document.getElementById(n.id + '-bdfaker'))) faker.style.width = restoredWd;
              if ((faker = document.getElementById(n.id + '-ftfaker'))) faker.style.width = restoredWd;
            }
          }
        }
      },

      _onSizeLaterSticky: function() {
        let p = this.parent;
        if (!p || !p.eheadtbl || !p._nativebar) return;

        let cells = p._getFirstRowCells(p.eheadrows),
          columns = this._columns || 0;
        if (!cells || cells.length <= 0) return;

        /* Restore any column width (including frozen ones) that may have been zeroed */
        if (p.head && p.head.nChildren) {
          for (let w = p.head.firstChild; w; w = w.nextSibling) {
            this._restoreCellWidth(w.$n(), w);
          }
        } else {
          for (let i = 0; i < cells.length; i++) {
            let n = cells[i];
            this._restoreCellWidth(n, zk.Widget.$(n));
          }
        }

        let colWidths = this._measureHeaderColumnWidths(p),
          leftWidth = 0;
        for (let i = 0; i < columns && i < colWidths.length; i++) {
          if (colWidths[i].visible) {
            leftWidth += colWidths[i].width;
          }
        }

        p._deleteFakeRow(p.eheadrows);

        let cave = this.$n('cave'),
          scroll = this.$n('scrollX'),
          frozenEl = p.$n('frozen'),
          ebody = p.ebody,
          ehead = p.ehead;
        if (!scroll || !frozenEl) return;

        if (cave) cave.style.width = jq.px0(leftWidth);

        let bodyWidth = ebody ? ebody.offsetWidth : (ehead ? ehead.offsetWidth : 0);
        frozenEl.style.width = jq.px0(bodyWidth);

        let scrollPortWidth = Math.max(0, bodyWidth - leftWidth);
        scroll.style.width = jq.px0(scrollPortWidth);

        let scrollableDelta = 0;
        if (ebody && ebody.scrollWidth > ebody.clientWidth) {
          scrollableDelta = ebody.scrollWidth - ebody.clientWidth;
        } else if (ehead && ehead.scrollWidth > ehead.clientWidth) {
          scrollableDelta = ehead.scrollWidth - ehead.clientWidth;
        }

        if (scroll.firstChild) {
          scroll.firstChild.style.width = jq.px0(scrollPortWidth + scrollableDelta);
        }

        this._syncScrollSmooth();
      },

      _applyStickyColumns: function() {
        let p = this.parent,
          frozenCols = this._columns || 0;
        if (!p || !frozenCols) return;

        let colWidths = this._measureHeaderColumnWidths(p);
        if (!colWidths.length) return;

        /* Measure the horizontal offset of every frozen column */
        let colOffsets = [],
          colVisible = [],
          accLeft = 0,
          lastFrozenIdx = -1,
          firstScrollableIdx = -1;

        for (let i = 0; i < frozenCols && i < colWidths.length; i++) {
          let vis = colWidths[i].visible;
          colVisible[i] = vis;
          colOffsets[i] = accLeft;
          if (vis) {
            accLeft += colWidths[i].width;
            lastFrozenIdx = i;
          }
        }
        this._frozenWidth = accLeft;

        for (let i = frozenCols; i < colWidths.length; i++) {
          if (colWidths[i].visible) {
            firstScrollableIdx = i;
            break;
          }
        }

        p._deleteFakeRow(p.eheadrows);

        let sections = [p.eheadrows, p.ebodyrows, p.efootrows];
        for (let s = 0; s < sections.length; s++) {
          let section = sections[s];
          if (!section) continue;
          let rows = section.rows || section.children;
          if (!rows) continue;

          /* Columns already occupied by a cell with rowSpan from a previous row, keyed
             "<rowIndex>/<colIndex>", so colspan/rowspan rows keep the right offsets */
          let covered = Object.create(null);

          for (let r = 0; r < rows.length; r++) {
            let row = rows[r];
            if (!row || (row.id && row.id.indexOf('-fakeRow') !== -1)) continue;
            let cells = row.cells || row.children;
            if (!cells) continue;

            let colIdx = 0,
              nextAfterStickyIdx = firstScrollableIdx;
            for (let c = 0; c < cells.length; c++) {
              let cell = cells[c];
              while (covered[r + '/' + colIdx]) colIdx++;

              let colSpan = cell.colSpan || 1,
                rowSpan = cell.rowSpan || 1,
                endColIdx = colIdx + colSpan - 1;
              if (rowSpan > 1) {
                for (let rr = 1; rr < rowSpan; rr++) {
                  for (let cc = 0; cc < colSpan; cc++) {
                    covered[(r + rr) + '/' + (colIdx + cc)] = true;
                  }
                }
              }

              let cl = cell.classList,
                offset = colOffsets[colIdx];
              if (colIdx < frozenCols && colVisible[colIdx] !== false && offset != null) {
                let leftPx = offset + 'px';
                if (cell.style.position !== 'sticky') cell.style.position = 'sticky';
                if (cell.style.left !== leftPx) cell.style.left = leftPx;
                if (!cl.contains('z-frozen-sticky')) cl.add('z-frozen-sticky');

                if (lastFrozenIdx >= 0 && endColIdx >= lastFrozenIdx) {
                  if (!cl.contains('z-frozen-sticky-last')) cl.add('z-frozen-sticky-last');
                  /* If this cell straddles across frozenCols, push the border-stripping
                     target to the column immediately following the span */
                  if (endColIdx + 1 > nextAfterStickyIdx) {
                    nextAfterStickyIdx = endColIdx + 1;
                    while (nextAfterStickyIdx < colWidths.length && !colWidths[nextAfterStickyIdx].visible) {
                      nextAfterStickyIdx++;
                    }
                  }
                } else if (cl.contains('z-frozen-sticky-last')) {
                  cl.remove('z-frozen-sticky-last');
                }
                if (cl.contains('z-frozen-sticky-next')) {
                  cl.remove('z-frozen-sticky-next');
                }
              } else {
                if (cl.contains('z-frozen-sticky') || cell.style.position === 'sticky') {
                  cell.style.position = '';
                  cell.style.left = '';
                  cl.remove('z-frozen-sticky', 'z-frozen-sticky-last');
                } else if (cl.contains('z-frozen-sticky-last')) {
                  cl.remove('z-frozen-sticky-last');
                }

                if (colIdx === nextAfterStickyIdx) {
                  if (!cl.contains('z-frozen-sticky-next')) cl.add('z-frozen-sticky-next');
                } else if (cl.contains('z-frozen-sticky-next')) {
                  cl.remove('z-frozen-sticky-next');
                }
              }
              colIdx += colSpan;
            }
          }
        }
      },

      /* Best effort width of a cell that may have been collapsed to 0px by the legacy
         fake column mechanism, in pixels. */
      _getCellWidth: function(cell, wgt) {
        let w = cell.offsetWidth;
        if (!w) {
          let colWd = wgt && wgt.getWidth && wgt.getWidth();
          if (colWd && colWd.indexOf('px') > 0) {
            w = parseInt(colWd, 10);
          } else if (wgt && wgt._origWd && wgt._origWd.indexOf('px') > 0) {
            w = parseInt(wgt._origWd, 10);
          } else if (wgt && wgt._hflexWidth && wgt._hflexWidth > 0) {
            w = wgt._hflexWidth;
          }
        }
        if (!w && cell.getBoundingClientRect) {
          w = Math.round(cell.getBoundingClientRect().width);
        }
        return w || 0;
      },

      _clearStickyColumns: function() {
        this._frozenWidth = 0;
        let p = this.parent,
          root = p ? p.$n() : null;
        if (!root) return;
        let els = root.querySelectorAll('.z-frozen-sticky, .z-frozen-sticky-last, .z-frozen-sticky-next');
        for (let i = 0; i < els.length; i++) {
          let el = els[i],
            cl = el.classList;
          if (cl.contains('z-frozen-sticky') || el.style.position === 'sticky') {
            el.style.position = '';
            el.style.left = '';
          }
          cl.remove('z-frozen-sticky', 'z-frozen-sticky-last', 'z-frozen-sticky-next');
        }
      }
    });

    zk.override(zul.mesh.MeshWidget.prototype, "clearCache", function() {
		this.$clearCache();
		if (this.eheadrows) this.eheadrows = null;
		if (this.efootrows) this.efootrows = null;
	});
});
