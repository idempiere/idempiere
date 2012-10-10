//patch for jquery bug under firefox
(function(undefined) {
var rupper = /([A-Z]|^ms)/g;
if ( document.defaultView && document.defaultView.getComputedStyle ) {
	var old = document.defaultView.getComputedStyle;
	getComputedStyle = function( elem, name ) {
		var ret, defaultView, computedStyle;

		if ( !(defaultView = elem.ownerDocument.defaultView) ) {
			return undefined;
		}
		
		if (name == undefined || name == null) {
			try {
				return old(elem, null);
			} catch (err) {
				return "";
			}
		}
		
		name = name.replace( rupper, "-$1" ).toLowerCase();
		
		try {			
			if ( (computedStyle = old( elem, null )) ) {
				ret = computedStyle.getPropertyValue( name );
				if ( ret === "" && !jQuery.contains( elem.ownerDocument.documentElement, elem ) ) {
					ret = jQuery.style( elem, name );
				}
			}
		} catch (err) {
			return "";
		}

		return ret;
	};
}
})();