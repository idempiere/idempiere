CKEDITOR.editorConfig = function(config) {
    config.resize_enabled = false;
    config.toolbarCanCollapse = true;
    config.toolbar = 'MyToolbar';
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
