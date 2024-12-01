CKEDITOR.editorConfig = function(config) {
    config.resize_enabled = false;
    config.toolbarCanCollapse = true;
    config.coreStyles_bold = { element: 'b', overrides: 'strong' };
    config.coreStyles_italic = { element: 'i', overrides: 'em' };
    config.coreStyles_strike = { element: 'strike', overrides: 's' };
    config.toolbar = [
		{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
		{ name: 'colors', items : [ 'TextColor','BGColor' ] },
	];
};
