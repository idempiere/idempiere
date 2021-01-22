if (typeof window.idempiere === 'undefined')
	window.idempiere = {};
	
window.idempiere.show_popup_window = function(refid, windowid, position) {
	var ref = zk.Widget.$(refid);
	var window = zk(windowid);
	window.position(ref.$n(), position);
};

zk.override(zk.Widget.prototype, "canActivate",
	function () {
	    var b = this.$canActivate.apply(this, arguments);
	    if (b) {
	    	if (zk.currentModal) {
	    		return true;
	    	}
			var wgt = this;
			while (wgt) {
				if (wgt.busy) {					
					if (wgt.busy.className == 'zul.wnd.Window') {
						if (zUtl.isAncestor(wgt.busy, this)) {
							return true;
						} else {
							jq.focusOut();
							wgt.busy.focus(0);
							return false;
						}				 		
					} else {
						jq.focusOut();
					}
					return false;
				}
				if (wgt.className == 'zul.wnd.Window') {
					if (wgt.getMode() == 'overlapped') {
						return true;
					}
				}
				wgt = wgt.parent;
			}
			return true;
		} else {
			return false;
		}
	});
