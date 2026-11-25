(function() {
  const PING_INTERVAL_MS = 25000;
  const RECONNECT_INITIAL_MS = 1000;
  const RECONNECT_MAX_MS = 15000;
  const DEFAULT_MAX_WS_PAYLOAD_SIZE = 4 * 1024 * 1024;

  org.idempiere.websocket.startServerPush = function(dtid, maxTextMessageSize) {
    let dt = zk.Desktop.$(dtid);
    if (!dt)
      return;
    if (dt._serverpush) {
      dt._serverpush.setMaxPayloadSize(maxTextMessageSize);
      if (dt._serverpush._reconnectId) {
        return;
      }
      dt._serverpush.restart();
    } else {
      let spush = new org.idempiere.websocket.ServerPush(dtid, maxTextMessageSize);
      spush.start();
    }
  };
  org.idempiere.websocket.stopServerPush = function(dtid) {
    let dt = zk.Desktop.$(dtid);
    if (dt && dt._serverpush)
      dt._serverpush.stop();
  };
  org.idempiere.websocket.echoServerPush = function(dtid) {
    let dt = zk.Desktop.$(dtid);
    if (dt) {
      let evtObj = new zk.Event(dt, 'dummy', null, {ignorable: true, rtags: {isDummy: true}});
      zAu.send(evtObj);
    }
  };
  org.idempiere.websocket.ServerPush = zk.$extends(zk.Object, {
    $init: function(dtid, maxTextMessageSize) {
      this.dtid = dtid;
      this.socket = null;
      this.active = false;
      this._stopped = false;
      this._pingTimerId = null;
      this._reconnectId = null;
      this._reconnectAttempts = 0;
      this._inflightReqInf = null;
      this._pendingReqs = new Map();
      this._replayCookieWatcher = null;
      this.maxPayloadSize = DEFAULT_MAX_WS_PAYLOAD_SIZE;
      this.setMaxPayloadSize(maxTextMessageSize);
      let desktop = zk.Desktop.$(this.dtid);
      if (desktop)
        desktop._serverpush = this;
    },
    setMaxPayloadSize: function(maxSize) {
      if (typeof maxSize === 'number' && isFinite(maxSize) && maxSize > 0) {
        this.maxPayloadSize = Math.floor(maxSize);
      }
    },
    _clearTimers: function() {
      if (this._pingTimerId) {
        clearTimeout(this._pingTimerId);
        this._pingTimerId = null;
      }
      if (this._reconnectId) {
        clearTimeout(this._reconnectId);
        this._reconnectId = null;
      }
    },
    _schedulePing: function() {
      if (this._pingTimerId) {
        clearTimeout(this._pingTimerId);
        this._pingTimerId = null;
      }
      if (this._stopped || !this.socket || this.socket.readyState !== WebSocket.OPEN)
        return;
      let me = this;
      let expectedSocket = this.socket;
      this._pingTimerId = setTimeout(function() {
        me._pingTimerId = null;
        if (!me._stopped && me.socket === expectedSocket && expectedSocket.readyState === WebSocket.OPEN) {
          try {
            expectedSocket.send("__ping__");
          } catch (e) {
            console.warn("WebSocket ping failed");
          }
        }
      }, PING_INTERVAL_MS);
    },
    _clearReplayCookieSync: function() {
      if (this._replayCookieWatcher) {
        if (typeof zWatch !== 'undefined') {
          zWatch.unlisten({onResponse: this._replayCookieWatcher});
        }
        this._replayCookieWatcher = null;
      }
    },
    _scheduleReplayCookieSync: function() {
      this._clearReplayCookieSync();
      if (typeof zWatch === 'undefined')
        return;
      let me = this;
      let watcher = {
        onResponse: function() {
          if (me._replayCookieWatcher === watcher) {
            me._clearReplayCookieSync();
          } else {
            zWatch.unlisten({onResponse: watcher});
          }
          if (zk.unloading)
            return;
          let dt = zk.Desktop.$(me.dtid);
          if (dt && !dt.obsolete) {
            let evtObj = new zk.Event(dt, 'onPiggyback', null, {ignorable: true, rtags: {isDummy: true}});
            zAu.send(evtObj);
          }
        }
      };
      this._replayCookieWatcher = watcher;
      zWatch.listen({onResponse: watcher});
    },
    _recoverInflightRequest: function() {
      let reqInf = this._inflightReqInf;
      this._inflightReqInf = null;
      if (reqInf) {
        this._pendingReqs.delete(String(reqInf.sid));
        if (zAu.ajaxReq) {
          zAu.ajaxReq = zAu.ajaxReqInf = undefined;
          zk.endProcessing(reqInf.sid);
          let dt = zk.Desktop.$(this.dtid);
          if (!zk.unloading && dt && !dt.obsolete) {
            if (zAu.seqId == reqInf.sid) {
              this._scheduleReplayCookieSync();
              zAu.ajaxReqResend(reqInf, 200);
            } else {
              let es = zAu.getAuRequests(dt);
              if (es.length > 0) setTimeout(() => zAu.sendNow(dt), 0);
            }
          }
        }
      }
    },
    start: function() {
      let desktop = zk.Desktop.$(this.dtid);
      if (typeof desktop === 'undefined' || !desktop)
        return;
      desktop._serverpush = this;
      this._stopped = false;
      this._clearTimers();

      let protocol = window.location.protocol === "http:" ? "ws://" : "wss://";
      let pathname = (window.location.pathname || "/").split(";")[0];
      let last = pathname.lastIndexOf("/");
      let path = (last > 0 ? pathname.substring(0, last) : "") + "/serverpush/";
      let url = protocol + window.location.host + path + encodeURIComponent(desktop.id);

      let me = this;
      let ws = new WebSocket(url);
      this.socket = ws;

      ws.onopen = function() {
        if (me.socket !== ws)
          return;
        me.active = true;
        me._reconnectAttempts = 0;
        try {
          ws.send("__ping__");
        } catch (e) {
          console.warn("WebSocket initial ping failed");
        }
        me._schedulePing();
      };

      ws.sendAjaxRequest = function(reqInf, serializedMsg) {
        if (me.socket !== ws || ws.readyState !== WebSocket.OPEN) {
          return false;
        }
        let ajaxMsg = serializedMsg || ("zkau;" + JSON.stringify(
          Object.assign({}, reqInf, {dt: (reqInf.dt && reqInf.dt.id) ? reqInf.dt.id : reqInf.dt})
        ));
        zAu.sentTime = jq.now(); //used by server-push (cpsp)
        zk.ausending = true;
        zAu.ajaxReq = true; // processing flag
        zAu.ajaxReqInf = reqInf;
        me._inflightReqInf = reqInf;
        me._pendingReqs.set(String(reqInf.sid), reqInf);
        try {
          ws.send(ajaxMsg);
        } catch (e) {
          me._inflightReqInf = null;
          me._pendingReqs.delete(String(reqInf.sid));
          zAu.ajaxReq = zAu.ajaxReqInf = undefined;
          zk.ausending = false;
          return false;
        }
        me._schedulePing();
        if (!reqInf.implicit)
          zk.startProcessing(zk.procDelay, reqInf.sid); //wait a moment to avoid annoying
        return true;
      };

      ws.onmessage = function(event) {
        if (me.socket !== ws)
          return;
        me._schedulePing();
        if (event.data === "echo") {
          org.idempiere.websocket.echoServerPush(me.dtid);
        } else if (event.data === "stop") {
          me.stop();
        } else if (event.data === "__pong__") {
          // Next idle ping is already scheduled by _schedulePing() above.
        } else if (event.data) {
          let data = event.data.trim();
          if (data.startsWith("{") && data.endsWith("}")) {
            let responseJson;
            try {
              responseJson = JSON.parse(data);
            } catch (e) {
              console.warn("Failed to parse WebSocket AU response");
              return;
            }
            let headers = new Headers();
            if (responseJson.headers) {
              for (const [k, v] of Object.entries(responseJson.headers)) {
                if (k && v !== undefined && v !== null) {
                  try {
                    headers.set(k, String(v));
                  } catch (ignored) {
                    // Skip header values not representable as Fetch ByteStrings.
                  }
                }
              }
            }
            if (!headers.has("ZK-SID") && responseJson.sid !== undefined && responseJson.sid !== null) {
              headers.set("ZK-SID", String(responseJson.sid));
            }
            responseJson.headers = headers;

            let hasSid = responseJson.sid !== undefined && responseJson.sid !== null;
            let reqInf = responseJson.ajaxReqInf;
            if (!reqInf && hasSid) {
              reqInf = me._pendingReqs.get(String(responseJson.sid));
            }
            if (!reqInf) {
              if (hasSid && String(responseJson.sid) !== String(zAu.seqId)) {
                zk.endProcessing(responseJson.sid);
                return;
              }
              reqInf = me._inflightReqInf || zAu.ajaxReqInf;
            }
            if (reqInf) {
              me._pendingReqs.delete(String(reqInf.sid));
              if (me._inflightReqInf === reqInf) {
                me._inflightReqInf = null;
              }
              zAu.ajaxReqInf = reqInf;
            }

            //using undocumented, ZK internal api
            //need verification after every ZK upgrade
            zAu._onResponseReady(responseJson);
            let dt = zk.Desktop.$(me.dtid);
            if (dt) {
              // if server indicates cookies were updated, queue onPiggyback HTTP event immediately to sync browser cookies
              if (responseJson.syncCookies || responseJson.headers.get("Set-Cookie")) {
                let evtObj = new zk.Event(dt, 'onPiggyback', null, {ignorable: true, rtags: {isDummy: true}});
                zAu.send(evtObj);
              } else {
                let es = zAu.getAuRequests(dt);
                if (es.length > 0) setTimeout(() => zAu.sendNow(dt), 0);
              }
            }
          }
        }
      };

      ws.onclose = function(event) {
        if (me.socket !== ws)
          return;
        me._clearTimers();
        me.socket = null;
        me.active = false;
        me._recoverInflightRequest();

        // Automatically reconnect on unexpected disconnects unless explicitly stopped or policy-rejected (1008).
        let serverStopped = event && event.code === 1000 && event.reason === "Server push stopped";
        if (!me._stopped && !zk.unloading && (!event || (event.code !== 1008 && !serverStopped))) {
          let dt = zk.Desktop.$(me.dtid);
          if (dt) {
            let delay = Math.min(RECONNECT_INITIAL_MS * Math.pow(2, me._reconnectAttempts), RECONNECT_MAX_MS);
            me._reconnectAttempts++;
            me._reconnectId = setTimeout(function() {
              me._reconnectId = null;
              if (!me._stopped && !zk.unloading) {
                me.start();
              }
            }, delay);
          }
        }
      };

      ws.onerror = function() {
        if (me.socket !== ws)
          return;
        console.warn("WebSocket server push connection error");
      };
    },
    stop: function() {
      this._stopped = true;
      this.active = false;
      this._clearTimers();
      this._clearReplayCookieSync();
      this._recoverInflightRequest();
      let desktop = zk.Desktop.$(this.dtid);
      if (desktop && desktop._serverpush === this)
        desktop._serverpush = null;
      let ws = this.socket;
      this.socket = null;
      if (ws) {
        try {
          ws.close(1000);
        } catch (error) {
          console.warn("Error closing WebSocket connection");
        }
      }
    },
    restart: function() {
      this._stopped = false;
      this._clearTimers();
      this._reconnectAttempts = 0;
      let ws = this.socket;
      this.socket = null;
      this.active = false;
      if (ws) {
        try {
          ws.close(1000);
        } catch (error) {
          console.warn("Error closing WebSocket connection during restart");
        }
      }
      this._recoverInflightRequest();
      let me = this;
      this._reconnectId = setTimeout(function() {
        me._reconnectId = null;
        if (!me._stopped && !zk.unloading) {
          me.start();
        }
      }, RECONNECT_INITIAL_MS);
    }
  });
  zk.afterLoad(function() {
    let originalSendNow = zAu.sendNow;
    let exceedsMaxPayload = function(msg, limit) {
      if (!limit || limit <= 0)
        return false;
      if (msg.length > limit)
        return true;
      if (msg.length * 3 > limit) {
        if (typeof TextEncoder !== 'undefined')
          return new TextEncoder().encode(msg).length > limit;
        return true;
      }
      return false;
    };
    let hasBinaryData = function(data, depth) {
      if (!data || typeof data !== 'object')
        return false;
      if ((depth || 0) > 16)
        return true;
      if (zAu._isBinary && zAu._isBinary(data))
        return true;
      if (typeof FileList !== 'undefined' && data instanceof FileList)
        return data.length > 0;
      if (Array.isArray(data)) {
        for (let i = 0; i < data.length; ++i) {
          if (hasBinaryData(data[i], (depth || 0) + 1))
            return true;
        }
        return false;
      }
      if (!(data instanceof Date) && !(data instanceof zk.Object)) {
        for (let key in data) {
          if (Object.prototype.hasOwnProperty.call(data, key) && hasBinaryData(data[key], (depth || 0) + 1))
            return true;
        }
      }
      return false;
    };
    //modify from zk/src/archive/web/js/zk/au.ts
    //need verification after every ZK upgrade
    zAu.sendNow = function(dt) {
      if (dt && dt._serverpush && dt._serverpush.socket && dt._serverpush.socket.readyState === WebSocket.OPEN) {
        if (zAu.disabledRequest) {
          if (zk.processing)
            zk.endProcessing();
          return false;
        }
        var es = zAu.getAuRequests(dt);
        if (es.length == 0)
          return false;

        //websocket does not support file upload; forceAjax and onPiggyback must use HTTP AJAX
        for (var j = 0; j < es.length; ++j) {
          var aureq = es[j],
              opts = aureq.opts || {};
          if (aureq.file || opts.forceAjax || hasBinaryData(aureq.data, 0)) {
            return originalSendNow(dt); //fallback to ajax
          } else if (aureq.name == "onPiggyback") {
            return originalSendNow(dt); //ajax event to update cookie
          }
        }

        if (zk.mounting) {
          zk.afterMount(function() {zAu.sendNow(dt);});
          return true; //wait
        }

        if (zAu.ajaxReq || zAu.pendingReqInf) { //send ajax request one by one
          // Delegate to ZK's originalSendNow so ZK's closure-scoped sendPending flag is set properly.
          return originalSendNow(dt);
        }

        var ajaxReqMaxCount = zAu.ajaxReqMaxCount;
        var batch = es;
        if (es.length > ajaxReqMaxCount) {
          console.warn('The count of au requests is unexpectedly huge: ' + es.length);
          batch = es.splice(0, ajaxReqMaxCount);
        }

        //decide implicit (and uri)
        var implicit, uri;
        for (var j = 0, el = batch.length; j < el; ++j) {
          var aureq = batch[j],
              opts = aureq.opts || {};
          if (opts.uri != uri) {
            if (j) break;
            uri = opts.uri;
          }

          //ignorable and defer implies implicit
          if (!(implicit = opts.ignorable || opts.implicit || opts.defer))
            break;
        }

        //notify watches (fckez uses it to ensure its value is sent back correctly)
        try {
          zWatch.fire('onSend', null, implicit);
        } catch (e) {
          zAu.showError('FAILED_TO_SEND', null, null, e);
        }

        //decide ignorable and re-check if onSend watch queued an HTTP-only event
        var ignorable = true;
        var forceAjax = false;
        for (var j = 0, el = batch.length; j < el; ++j) {
          var aureq = batch[j],
              opts = aureq.opts || {};
          if (aureq.file || opts.forceAjax || aureq.name == "onPiggyback" || hasBinaryData(aureq.data, 0)) {
            forceAjax = true;
            break;
          }
          if (opts.uri != uri)
            break;
          ignorable = ignorable && !!opts.ignorable;
        }
        if (forceAjax) {
          if (batch !== es) {
            for (var k = batch.length - 1; k >= 0; --k)
              es.unshift(batch[k]);
          }
          return originalSendNow(dt);
        }

        var content = '', rtags = {},
            requri = uri || zk.ajaxURI(null, {desktop: dt, au: true}),
            lasturi = requri,
            shifted = [];
        for (let j = 0, el = batch.length, aureq; el && (aureq = batch.shift()); ++j, --el) {
          if ((aureq.opts || {}).uri != uri) {
            batch.unshift(aureq);
            break;
          }

          let nextUri = zAu.beforeSend(requri, aureq, dt);
          if (j > 0 && nextUri != lasturi) {
            batch.unshift(aureq);
            break;
          }
          lasturi = nextUri;
          shifted.push(aureq);
          content += zAu.encode(j, aureq, dt);
          zk.copy(rtags, (aureq.opts || {}).rtags);
        }
        requri = lasturi;
        // Return any unconsumed items from a spliced batch back to es so they are never lost.
        if (batch !== es && batch.length > 0) {
          for (let k = batch.length - 1; k >= 0; --k)
            es.unshift(batch[k]);
        }
        // B65-ZK-2210: get resourceURL by desktop id
        if (zk.portlet2Data && zk.portlet2Data[dt.id]) {
          requri = zk.portlet2Data[dt.id].resourceURL;
        }

        if (content) {
          let reqInf = {
            sid: zAu.seqId, uri: requri, dt: dt, content: content,
            implicit: implicit,
            ignorable: ignorable, tmout: 0, rtags: rtags, forceAjax: false
          };
          let ajaxMsg = "zkau;" + JSON.stringify({
            sid: reqInf.sid, uri: reqInf.uri, dt: dt.id, content: reqInf.content,
            implicit: reqInf.implicit, ignorable: reqInf.ignorable, tmout: reqInf.tmout,
            rtags: reqInf.rtags, forceAjax: reqInf.forceAjax
          });
          if (exceedsMaxPayload(ajaxMsg, dt._serverpush.maxPayloadSize) || !dt._serverpush.socket.sendAjaxRequest(reqInf, ajaxMsg)) {
            // Re-queue events and fall back to HTTP AJAX when payload is too large or WS send fails.
            for (let k = shifted.length - 1; k >= 0; --k)
              es.unshift(shifted[k]);
            return originalSendNow(dt);
          }
        }
        return true;
      } else {
        return originalSendNow(dt);
      }
    };
  });
})();
