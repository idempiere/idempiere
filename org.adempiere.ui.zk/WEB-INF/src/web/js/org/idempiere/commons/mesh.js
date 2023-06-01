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
      _doScrollNow: function() {
        let result = _xFrozen._doScrollNow.apply(this, arguments);
        /*Patch: add class to non-visible columns*/
        let mesh = this.parent;
        if (mesh.head) {
          let totalCols = mesh.head.nChildren,
            hdcol = mesh.ehdfaker.firstChild;

          for (let faker, i = 0; hdcol && i < totalCols; hdcol = hdcol.nextSibling, i++) {
            if (hdcol.style.width.indexOf('0.001px') != -1 || hdcol.style.width.indexOf('0px') != -1) {
              jq(zk.$(hdcol).$n()).addClass("hiddencol");
            } else {
              jq(zk.$(hdcol).$n()).removeClass("hiddencol");
            }
          }
        }
        return result;
      },
      //workarond from https://tracker.zkoss.org/browse/ZK-5159
      bind_: function () {
		this.$supers(zul.mesh.Frozen, 'bind_', arguments);
		var p = this.parent,
			body = p.$n('body'),
			foot = p.$n('foot');

		if (p._nativebar) {
			//B70-ZK-2130: No need to reset when beforeSize, ZK-343 with native bar works fine too.
			zWatch.listen({onSize: this});
			var scroll = this.$n('scrollX'),
				scrollbarWidth = jq.scrollbarWidth();
			if(scrollbarWidth == 0){
				scrollbarWidth = 12;
			}
			// ZK-2583: native IE bug, add 1px in scroll div's height for workaround
			this.$n().style.height = this.$n('cave').style.height = this.$n('right').style.height = scroll.style.height
				 = scroll.firstChild.style.height = jq.px0(zk.ie ? scrollbarWidth + 1 : scrollbarWidth);
			p._currentLeft = 0;
			this.domListen_(scroll, 'onScroll');

			var head = p.$n('head');
			if (head)
				this.domListen_(head, 'onScroll', '_doHeadScroll');

		} else {
			// Bug ZK-2264
			this._shallSyncScale = true;
		}
		// refix-ZK-3100455 : grid/listbox with frozen trigger "invalidate" should _syncFrozenNow
		zWatch.listen({onResponse: this});
		if (body)
			jq(body).addClass('z-word-nowrap');
		if (foot)
			jq(foot).addClass('z-word-nowrap');
	  }
    });
    
    zk.override(zul.mesh.MeshWidget.prototype, "clearCache", function() {
		this.$clearCache();
		if (this.eheadrows) this.eheadrows = null;
		if (this.efootrows) this.efootrows = null;
	});	
});