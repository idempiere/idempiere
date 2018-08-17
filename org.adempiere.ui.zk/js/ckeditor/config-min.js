CKEDITOR.editorConfig = function(config) {
    config.resize_enabled = false;
    config.toolbarCanCollapse = true;
    config.toolbar = 'MyToolbar';
    config.coreStyles_bold = { element: 'b', overrides: 'strong' };
    config.coreStyles_italic = { element: 'i', overrides: 'em' };
    config.coreStyles_strike = { element: 'strike', overrides: 's' };
    config.toolbar_MyToolbar =
[
	{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
	{ name: 'colors', items : [ 'TextColor','BGColor' ] },
	{ name: 'clipboard', items : [ 'Undo','Redo' ] },
	{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
	{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
	{ name: 'tools', items : [ 'Maximize' ] }
];
};
