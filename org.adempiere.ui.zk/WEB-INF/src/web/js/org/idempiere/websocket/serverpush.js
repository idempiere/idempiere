(function() {
  org.idempiere.websocket.startServerPush = function(dtid) {
    let dt = zk.Desktop.$(dtid);
    if (dt._serverpush && dt._serverpush.socket) {
    	if (dt._serverpush._reconnectId) {
    		return;
    	}
    	dt._serverpush.restart();    	
    } else {
    	let spush = new org.idempiere.websocket.ServerPush(dtid);
        spush.start();
    }    
  };
  org.idempiere.websocket.stopServerPush = function(dtid) {
    let dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();
  };
  org.idempiere.websocket.ServerPush = zk.$extends(zk.Object, {    
    $init: function(dtid) {
      this.dtid = dtid;           
      this.socket = null;
      this.active = false;
      this.reconnect = false;
      let desktop = zk.Desktop.$(this.dtid);
      desktop._serverpush = this;
    },
    start: function() {
      let desktop = zk.Desktop.$(this.dtid);
      if (typeof desktop === 'undefined')
    	  return;      
      this.reconnect = false;
      this._reconnectId = null;
      let url = window.location.protocol == "http:" ? "ws://" : "wss://";
      let path = window.location.href.substring(window.location.protocol.length+2);
      path = path.substring(location.host.length+1);
      let last=path.lastIndexOf("/");
      if (last > 0) {
    	  path = "/" + path.substring(0, last) + "/serverpush/";
      } else {
    	  path = "/serverpush/";
      }
      url = url + window.location.host + path + desktop.id;
      let me = this;
      this.socket = new WebSocket(url);
      this.socket.onopen = function (event) {
    	  me.active = true;
    	  me.socket.send("__ping__");
      };
	  this.socket.sendAjaxRequest = function(ajaxReqInf) {
		  let ajaxMsg = "zkau;"+JSON.stringify(ajaxReqInf);
		  me.socket.send(ajaxMsg);
	  }
      this.socket.onmessage = function (event) {
		  if (event.data=="echo") {
			  let dt = zk.Desktop.$(me.dtid);
			  let evtObj = new zk.Event(dt, 'dummy', null, {ignorable: true, rtags: {isDummy: true}});
			  let requri = zk.ajaxURI(null, {desktop: dt, au: true});
			  let content = zAu.encode(0, evtObj, dt);
			  let ajaxReqInf = {
			          sid: zAu.seqId, uri: requri, dt: dt, content: content,
			          implicit: true,
			          ignorable: true, tmout: 0, rtags: evtObj.rtags, forceAjax: false
			  };
			  me.socket.sendAjaxRequest(ajaxReqInf);			  
		  } else if (event.data=="stop") {
			  me.stop();
		  } else if (event.data=="__pong__") {
			  setTimeout(() => {if (me.socket) me.socket.send("__ping__");}, 10000);	  
		  } else if (event.data) {
	          let data = event.data.trim();
	          if (data.startsWith("{") && data.endsWith("}")) {
	            let responseJson = JSON.parse(data);
				if (responseJson.headers) {
					responseJson.headers = new Map(Object.entries(responseJson.headers));
				} else {
					responseJson.headers = new Map();
				}
				zAu.ajaxReqInf = responseJson.ajaxReqInf;
				//using undocumented, ZK internal api
				//need verification after every ZK upgrade
	            zAu._onResponseReady(responseJson);
	          }
	      }
      }
      this.socket.onclose = function (event) {
    	  if (me.socket) {
    		  me.socket = null;
    	  }
    	  if (me.reconnect) {
    		  me._reconnectId = setTimeout(function() {me.start();}, 2000);
    	  } 
      }
      this.socket.onerror = function(event) {
    	  console.log(event);
      };
    },
    stop: function() {
      this.active = false;
      let desktop = zk.Desktop.$(this.dtid);
      desktop._serverpush = null;      
      if (this.socket) {
    	try {
    		this.socket.close(1000);
    	} catch (error) {
    		console.log(error);
    	}
      }
    },
    restart: function() {
    	this.reconnect = true;
    	this.stop();    	
    }
  });
  zk.afterLoad(function() {
	let originalSendNow = zAu.sendNow;	
	//modify from zk/src/archive/web/js/zk/au.ts
	//need verification after every ZK upgrade
	zAu.sendNow = function(dt) {
      if (dt._serverpush && dt._serverpush.socket && dt._serverpush.socket.readyState === WebSocket.OPEN) {
		if (zAu.disabledRequest) {
			if (zk.processing)
				zk.endProcessing();
			return false;
		}
		var es = zAu.getAuRequests(dt);
		if (es.length == 0)
			return false;

		if (zk.mounting) {
			zk.afterMount(function () {zAu.sendNow(dt);});
			return true; //wait
		}

		if (zAu.ajaxReq || zAu.pendingReqInf) { //send ajax request one by one
			sendPending = true;
			return true;
		}

		var ajaxReqMaxCount = zAu.ajaxReqMaxCount;
		if (es.length > ajaxReqMaxCount) {
			console.warn('The count of au requests is unexpectedly huge: ' + es.length); // eslint-disable-line no-console
			es = es.splice(0, ajaxReqMaxCount);
			sendPending = true;
		}

		//decide implicit (and uri)
		var implicit, uri;
		for (var j = 0, el = es.length; j < el; ++j) {
			var aureq = es[j],
				opts = aureq.opts || {};
			if (opts.uri != uri) {
				if (j) break;
				uri = opts.uri;
			}

			//ignorable and defer implies implicit
			if (!(implicit = opts.ignorable || opts.implicit || opts.defer))
				break;
		}

		//notify watches (fckez uses it to ensure its value is sent back correctly
		try {
			zWatch.fire('onSend', null, implicit);
		} catch (e) {
			zAu.showError('FAILED_TO_SEND', null, null, e);
		}

		//decide ignorable
		var ignorable = true;
		for (var j = 0, el = es.length; j < el; ++j) {
			var aureq = es[j],
				opts = aureq.opts || {};
			if ((opts.uri != uri)
			|| !(ignorable = ignorable && !!opts.ignorable)) //all ignorable
				break;
		}
		var forceAjax = false;
		for (var j = 0, el = es.length; j < el; ++j) {
			var aureq = es[j],
				opts = aureq.opts || {};
			if (opts.forceAjax) {
				forceAjax = true;
				break;
			}
		}
		//Consider XML (Pros: ?, Cons: larger packet)
		var content, rtags = {},
			requri = uri || zk.ajaxURI(null, {desktop: dt, au: true}),
			ws = typeof zWs != 'undefined' && zWs.ready;
		if (!forceAjax && ws) {
			content = {};
		} else {
			content = '';
		}
		for (let j = 0, el = es.length, aureq; el && (aureq = es.shift()); ++j, --el) {
			if ((aureq.opts || {}).uri != uri) {
				es.unshift(aureq);
				break;
			}

			requri = zAu.beforeSend(requri, aureq, dt);
			if (!forceAjax && ws) {
				zk.copy(content, zWs.encode(j, aureq, dt));
			} else {
				content += zAu.encode(j, aureq, dt);
			}
			zk.copy(rtags, (aureq.opts || {}).rtags);
		}
		// B65-ZK-2210: get resourceURL by desktop id
		if (zk.portlet2Data && zk.portlet2Data[dt.id]) {
			requri = zk.portlet2Data[dt.id].resourceURL;
		}

		//if (zk.portlet2AjaxURI)
			//requri = zk.portlet2AjaxURI;
		//modify to use WebSocket connection for au requests
		if (content)
			dt._serverpush.socket.sendAjaxRequest({
				sid: zAu.seqId, uri: requri, dt: dt, content: content,
				implicit: implicit,
				ignorable: ignorable, tmout: 0, rtags: rtags, forceAjax: forceAjax
			});
		return true;
	  } else {
		return originalSendNow(dt);
	  }
    };
  });
})();
