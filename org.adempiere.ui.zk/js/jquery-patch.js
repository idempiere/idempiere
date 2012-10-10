//patch for jquery bug under firefox
(function(undefined) {
var rupper = /([A-Z]|^ms)/g;
if ( document.defaultView && document.defaultView.getComputedStyle ) {
	getComputedStyle = function( elem, name ) {
		var ret, defaultView, computedStyle;

		//added try catch for firefox
		try {
			name = name.replace( rupper, "-$1" ).toLowerCase();
	
			if ( !(defaultView = elem.ownerDocument.defaultView) ) {
				return undefined;
			}
		
			if ( (computedStyle = defaultView.getComputedStyle( elem, null )) ) {
				ret = computedStyle.getPropertyValue( name );
				if ( ret === "" && !jQuery.contains( elem.ownerDocument.documentElement, elem ) ) {
					ret = jQuery.style( elem, name );
				}
			}
		} catch (err) {}

		return ret;
	};
}
})();