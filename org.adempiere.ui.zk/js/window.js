function _idempiere_popup_window(refid, windowid, position) {
	var ref = zk.Widget.$(refid);
	var window = zk(windowid);
	window.position(ref.$n(), position);
}
