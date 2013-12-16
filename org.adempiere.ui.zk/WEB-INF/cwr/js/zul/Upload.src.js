
(function () {

	function _cancel(o, sid, finish) {
		var key = o.getKey(sid),
			uplder = o.uploaders[key];
		if (uplder)
			uplder.destroy(finish);
		delete o.uploaders[key];
	}
	function _initUploader(o, form, val) {
		var key = o.getKey(o.sid),
			uplder = new zul.Uploader(o, key, form, val);
		zul.Upload.start(uplder);
		o.uploaders[key] = uplder;
	}
	function _start(o, form, val) { 
		
		
		_initUploader(o, form, val);
		o.sid++;
		o.initContent();
	}
	function _onchange(evt) {
		var n = this,
			upload = n._ctrl,
			wgt = upload._wgt,
			dt = wgt.desktop,
			action = zk.ajaxURI('/upload', {desktop:dt,au:true}) + '?uuid=' + wgt.uuid + '&dtid=' + dt.id + '&sid=' + upload.sid
				+ (upload.maxsize !== '' ? '&maxsize=' + upload.maxsize : '')
				+ (upload.isNative ? '&native=true' : ''),
			form = n.form;
		form.action = action;
		
		
		var p = form.parentNode;
		p.parentNode.removeChild(p);
		upload._formDetached = true;
		var fileName = !n.files || n.files.length == 1 ? n.value : (function(files){
			var fns = [];
			for (var len = files.length; len--;)
				fns.unshift(files[len].name);
			return fns.join(",");
		})(n.files); 
		_start(n._ctrl, form, fileName);
	}

	if (zk.opera) { 
		var _syncQue = [], _syncId;
		function _syncNow() {
			for (var j = _syncQue.length; j--;)
				_syncQue[j].sync();
		}
		function _addSyncQue(upld) {
			if (!_syncQue.length)
				_syncId = setInterval(_syncNow, 1500);

			_syncQue.push(upld);
		}
		function _rmSyncQue(upld) {
			_syncQue.$remove(upld);
			if (_syncId && !_syncQue.length) {
				clearInterval(_syncId);
				_syncId = null;
			}
		}
	}


zul.Upload = zk.$extends(zk.Object, {
	sid: 0,
	
	$init: function(wgt, parent, clsnm) {
		this.uploaders = {};

		var cls;
		for (var attrs = clsnm.split(','), i = 0, len = attrs.length; i < len; i++) {
			var attr = attrs[i].trim(); 
			if (attr.startsWith('maxsize='))
				this.maxsize = attr.match(new RegExp(/maxsize=([^,]*)/))[1];
			else if (attr.startsWith('multiple='))
				this.multiple = attr.match(new RegExp(/multiple=([^,]*)/))[1];
			else if (attr.startsWith('accept='))
				this.accept = attr.match(new RegExp(/accept=([^,]*)/))[1];
			else if (attr == 'native')
				this.isNative = true;
			else if (attr != 'true')
				cls = attr;
		}
		
		this._clsnm = cls || '';
		
		this._wgt = wgt;
		this._parent = parent;
		if (wgt._tooltiptext) 
			this._tooltiptext = wgt._tooltiptext;
		
		this.initContent();
	},
	
	sync: function () {
		if (!this._formDetached) {
			var wgt = this._wgt,
				ref = wgt.$n(),
				parent = this._parent,
				outer = parent ? parent.lastChild : ref.nextSibling,
				inp = outer.firstChild.firstChild,
				refof = zk(ref).revisedOffset(),
				outerof = jq(outer).css({top: '0', left: '0'}).zk.revisedOffset(),
				diff = inp.offsetWidth - ref.offsetWidth,
				st = outer.style;
			st.top = (refof[1] - outerof[1]) + "px";
			st.left = refof[0] - outerof[0] - diff + "px";

			inp.style.height = ref.offsetHeight + 'px';
			inp.style.clip = 'rect(auto,auto,auto,' + diff + 'px)';
		}
	},
	initContent: function () {
		var wgt = this._wgt,
			parent = this._parent,
			ref = wgt.$n(), dt = wgt.desktop,
			html = '<span class="z-upload"'
				 + (this._tooltiptext? ' title="'+ this._tooltiptext+'"' : '') 
				 +'><form enctype="multipart/form-data" method="POST">'
				 + '<input name="file" type="file"'
				
				 + (this.multiple == 'true' ? ' multiple="" multiple' : '')
				 + (this.accept ? ' accept="' + this.accept + '"' : '')
				 + ' hidefocus="true" style="height:'
				 + ref.offsetHeight + 'px"/></form></span>';
		
		if (parent) 
			jq(parent).append(html);
		else 
			jq(wgt).after(html);
		delete this._formDetached;

		
		if (!wgt._autodisable_self)
			this.sync();

		var outer = this._outer = parent ? parent.lastChild : ref.nextSibling,
			inp = outer.firstChild.firstChild;

		if (zk.opera) { 
			outer.style.position = 'absolute';
			_addSyncQue(this);
		}

		inp.z$proxy = ref;
		inp._ctrl = this;
		
		jq(inp).change(_onchange);
	},
	
	destroy: function () {
		if (zk.opera)
			_rmSyncQue(this);

		jq(this._outer).remove();
		this._wgt = this._parent = null;
		for (var v in this.uploaders) {
			var uplder = this.uploaders[v];
			if (uplder) {
				delete this.uploaders[v];
				uplder.destroy();
			}
		}
	},
	
	getKey: function (sid) {
		return (this._wgt ? this._wgt.uuid : '' )+ '_uplder_' + sid; 
	},
	
	cancel: function (sid) { 
		_cancel(this, sid);
	},
	
	finish: function (sid) {
		_cancel(this, sid, true);
	}
},{
	
	error: function (msg, uuid, sid) {
		var wgt = zk.Widget.$(uuid);
		if (wgt) {
			jq.alert(msg, {desktop: wgt.desktop, icon: 'ERROR'});
			zul.Upload.close(uuid, sid);
		}
	},
	
	close: function (uuid, sid) {
		var wgt = zk.Widget.$(uuid);
		if (!wgt || !wgt._uplder) return;
		wgt._uplder.cancel(sid);
	},
	
	sendResult: function (uuid, contentId, sid) {
		var wgt = zk.Widget.$(uuid);
		if (!wgt || !wgt._uplder) return;
		wgt._uplder.finish(sid);
		zAu.send(new zk.Event(wgt.desktop, "updateResult", {
			contentId: contentId,
			wid: wgt.uuid,
			sid: sid
		}));
	},
	
	isFinish: function (wgt) {
		for (var key = (typeof wgt == 'string' ? wgt : wgt.uuid) + '_uplder_',
				f = zul.Upload.files, i = f.length; i--;)
			if (f[0].id.startsWith(key))
				return false;
		return true;
	},
	
	start: function (uplder) {
		var files = zul.Upload.files;
		if (uplder)
			files.push(uplder);
		if (files[0] && !files[0].isStart) {
			files[0].isStart = true;
			files[0].start();
		}
	},
	
	destroy: function (uplder) {
		for (var files = zul.Upload.files, i = files.length; i--;) 
			if (files[i].id == uplder.id) {
				files.splice(i, 1);
				break;
			}
		zul.Upload.start();
	},
	files: []
});

zul.Uploader = zk.$extends(zk.Object, {
	
	$init: function (upload, id, form, flnm) {
		this.id = id;
		this.flnm = flnm;
		this._upload = upload;
		this._form = form;
		this._parent = form.parentNode;
		this._sid = upload.sid;
		this._wgt = upload._wgt;
		
		var viewer, self = this;
		if (!upload._clsnm) viewer = new zul.UploadViewer(this, flnm);
		else
			zk.$import(upload._clsnm, function (cls) {
				viewer = new cls(self, flnm);
			});
		this.viewer = viewer;
	},
	
	getWidget: function () {
		return this._wgt;
	},
	
	destroy: function (finish) {
		this.end(finish);
		if (this._form) {
			jq(this._form.parentNode).remove();
			jq('#' + this.id + '_ifm').remove();
		}
		this._form = this._upload = this._wgt = null;
	},
	
	start: function () {
		var wgt = this._wgt,
			frameId = this.id + '_ifm';

		document.body.appendChild(this._parent);
		if (!jq('#' + frameId).length) 
			jq.newFrame(frameId);
		this._form.target = frameId;
		this._form.submit();
		this._form.style.display = "none";
		
		var self = this,
			data = 'cmd=uploadInfo&dtid=' + wgt.desktop.id
				+ '&wid=' + wgt.uuid + '&sid=' + this._sid;
		
		if (zul.Uploader._tmupload)
			clearInterval(zul.Uploader._tmupload);
		
		function t() {
			jq.ajax({
				type: 'POST',
				url: zk.ajaxURI('/upload', {desktop: wgt.desktop, au: true}),
				data: data,
				dataType: 'text',
				success: function(data) {
					var d = data.split(',');
					if (data.startsWith('error:')) {
						self._echo = true; 
						zul.Uploader.clearInterval(self.id);
						if (wgt) {
							self.cancel();
							zul.Upload.error(data.substring(6, data.length), wgt.uuid, self._sid);
						}
					} else if (!self.update(zk.parseInt(d[0]), zk.parseInt(d[1])))
						zul.Uploader.clearInterval(self.id);
				},
				complete: function(req, status) {
					var v;
					if ((v = req.getResponseHeader("ZK-Error")) == "404"
					|| v == "410" || status == 'error'
					|| status == 404 || status == 405 || status == 410) {
						zul.Uploader.clearInterval(self.id);
						var wgt = self.getWidget();
						if (wgt) {
							self.cancel();
							zul.Upload.error(msgzk.FAILED_TO_RESPONSE, wgt.uuid, self._sid);
						}
						return;
					}
				}
			});
		}
		t.id = this.id;
		
		zul.Uploader.clearInterval = function (id) {
			if (t.id == id) {
				clearInterval(zul.Uploader._tmupload);
				zul.Uploader._tmupload = undefined;
			}
		};
		zul.Uploader._tmupload = setInterval(t, 1000);
		
		zul.wgt.ADBS.autodisable(wgt);
	},
	
	cancel: function () {
		zul.Uploader.clearInterval(this.id);
		if (this._upload)
			this._upload.cancel(this._sid);
	},
	
	update: function (sent, total) {
		var wgt = this.getWidget();
		if (!wgt || total <= 0)
			if (this._echo)
				this.end();
			else
				return true; 
		else if (zul.Uploader._tmupload) {
			this._echo = true;
			if (sent >= 0 && sent <= 100)
				this.viewer.update(sent, total);
			return sent >= 0 && sent < 100;
		}
		return false;
	},
	
	end: function (finish) {
		this.viewer.destroy(finish);
		zul.Upload.destroy(this);
		this._echo = true;
		
		
		var wgt, upload, aded, parent;
		if ((wgt = this._wgt) && (upload = this._upload) && 
			(aded = upload._aded)) {
			wgt._uplder = null; 
			aded.onResponse();
			upload._aded = null;
			
			
			if (wgt._uplder != null)
				wgt._uplder.destroy();
			if ((parent = upload._parent) && !jq(parent).parents('html').length) {
				upload._parent = wgt._getUploadRef();
				upload.initContent();
			}
			wgt._uplder = upload;
			wgt._uplder.sync();
			delete wgt._autodisable_self;
		}
	}
});


	function _addUM(uplder, flnm) {
		var flman = zul.UploadViewer.flman;
		if (!flman || !flman.desktop) {
			if (flman) flman.detach();
			zul.UploadViewer.flman = flman = new zul.UploadManager();
			uplder.getWidget().getPage().appendChild(flman);
		}
		flman.removeFile(uplder);
		flman.addFile(uplder);
	}
	function _initUM(uplder, flnm) {
		if (zul.UploadManager)
			return _addUM(uplder, flnm);

		zk.load('zul.wgt,zul.box', function() {
			
			zul.UploadManager = zk.$extends(zul.wgt.Popup, {
				$init: function () {
					this.$supers('$init', arguments);
					this._files = {};
					this.setSclass('z-fileupload-manager');
				},
				onFloatUp: function(ctl) {
					var wgt = ctl.origin;
					if (!this.isVisible()) 
						return;
					this.setTopmost();
				},
				
				getFileItem: function(id) {
					return this._files[id] || zk.Widget.$(id);
				},
				
				addFile: function(uplder) {
					var id = uplder.id,
						flnm = uplder.flnm,
						prog = this.getFileItem(id);
					if (!prog) {
						prog = new zul.wgt.Div({
							uuid: id,
							children: [new zul.wgt.Label({
								value: flnm + ':'
							}), new zul.box.Box({
								mold: 'horizontal',
								children: [new zul.wgt.Progressmeter({
									id: id,
									sclass: 'z-fileupload-progress'
								})
								, new zul.wgt.Div({
									sclass: 'z-fileupload-remove z-icon-times',
									listeners: {
										onClick: function () {
											var uuid = id.substring(0, id.indexOf('_uplder_'));
											zul.Uploader.clearInterval(id);
											var wgt = zk.Widget.$(uuid);
											if (wgt) wgt._uplder.cancel(id.substring(id.lastIndexOf('_')+1, id.length));
										}
									}
								})]
							}), new zul.wgt.Label({id: id + '_total'}), new zul.wgt.Separator()]
						});
						
						try {
							this.appendChild(prog);
						} catch (e) {}
						this._files[id] = prog;
					}
					return prog;
				},
				
				updateFile: function(uplder, val, total) {
					var id = uplder.id,
						prog = this.getFileItem(id);
					if (!prog) return;
					prog.$f(id).setValue(val);
					prog.$f(id + '_total').setValue(total);
				},
				
				removeFile: function(uplder) {
					var id = uplder.id,
						prog = this.getFileItem(id);
					if (prog) 
						prog.detach();
					delete this._files[id];
					var close = true;
					for (var p in this._files) 
						if (!(close = false)) 
							break;
					
					if (close) 
						this.close();
				},
				
				open: function(wgt, position) {
					this.$super('open', wgt, null, position || 'after_start', {
						sendOnOpen: false,
						disableMask: true
					});
				}
			});
			_addUM(uplder, flnm);
		});
	}

zul.UploadViewer = zk.$extends(zk.Object, {
	
	$init: function (uplder,  flnm) {
		this._uplder = uplder;
		_initUM(uplder, flnm);
	},
	
	update: function (sent, total) {
		var flman = zul.UploadViewer.flman;
		if (flman) {
			if (!flman.isOpen())
					flman.open(this._uplder.getWidget());
			flman.updateFile(this._uplder, sent, msgzk.FILE_SIZE+Math.round(total/1024)+msgzk.KBYTES);
		}
	},
	
	destroy: function () {
		var flman = zul.UploadViewer.flman;
		if (flman)
			flman.removeFile(this._uplder);
	}
});

})();
