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
      }
    });
    
    zk.override(zul.mesh.MeshWidget.prototype, "clearCache", function() {
		this.$clearCache();
		if (this.eheadrows) this.eheadrows = null;
		if (this.efootrows) this.efootrows = null;
	});	
});