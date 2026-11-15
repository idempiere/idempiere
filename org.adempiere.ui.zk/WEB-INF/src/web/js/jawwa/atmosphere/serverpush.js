(function() {
  jawwa.atmosphere.startServerPush = function(dtid, timeout) {
    let dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();

    //change to true to enable trace of execution
    let trace = false;
    let spush = new jawwa.atmosphere.ServerPush(dt, timeout, trace);
    spush.start();
  };
  jawwa.atmosphere.stopServerPush = function(dtid) {
    let dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();
  };
  jawwa.atmosphere.ServerPush = zk.$extends(zk.Object, {
    desktop: null,
    active: false,
    delay: 10,
    failures: 0,
    timeout: 0,
    trace: false,
    ajaxOptions: {
        url: zk.ajaxURI("/comet", {au: true}),
        type: "POST",
        cache: false,
        async: true,
        global: false,
        data: null,
        dataType: "text" 
    },
    $init: function(desktop, timeout, trace) {
      this.desktop = desktop;
      this.timeout = timeout;
      this.ajaxOptions.data = { dtid: this.desktop.id };
      // Server suspends for `timeout` ms and resumes with HTTP 200 on idle timeout;
	  // add 30s grace period so XHR timeout only fires when the server/network is unresponsive
	  this.ajaxOptions.timeout = this.timeout + 30000;
      this.ajaxOptions.url = zk.ajaxURI("/comet", {au: true,desktop:this.desktop.id,ignoreSession:true}),
      this.trace = trace;
      let me = this;
      this.ajaxOptions.error = function(jqxhr, textStatus, errorThrown) {
		  let errorCode = jqxhr.getResponseHeader("X-Atmosphere-Error") || errorThrown;
    	  if (me.trace)
    		  console.log("error: " + textStatus + " dtid: " + me.desktop.id + " errorThrown: " + errorCode + " status: " + jqxhr.status);
		  if (textStatus != "abort" && errorCode != "SessionNotFound" && errorCode != "DesktopNotFound") {
	          console.error("error: " + textStatus + " errorThrown: " + errorCode + " status: " + jqxhr.status);
	          me.failures += 1;
    	  }
      };
      this.ajaxOptions.success = function() {
    	  if (me.trace)
    		  console.log("success" + " dtid: " + me.desktop.id);
          zAu.cmd0.echo(me.desktop);
          me.failures = 0;
      };
      this.ajaxOptions.complete = function(jqxhr) {
		  let req = jqxhr || me._req;
		  let errorCode = req ? (req.getResponseHeader("X-Atmosphere-Error") || req.statusText) : null;
    	  if (me.trace) {
    		  console.log("complete"+ " dtid: " + me.desktop.id);
			  if (req)
			    console.log(req.status + " " + errorCode);
    	  }
		  if (req && req.status == 400 && (errorCode == "SessionNotFound" || errorCode == "DesktopNotFound")) {
    		  ;
    	  } else {
    		  me._schedule();
    	  }
      };
    },
    _schedule: function() {
      if (this.failures < 5) {
		let d = this.delay;
		// exponential backoff (1, 2, 4, 8 s: about 15 s in total) for connectivity and proxy/upstream errors,
		// so that a short outage, e.g. a proxy reload or a load balancer returning 502/503 during a deployment,
		// does not end the session
		if (this._req && (this._req.status == 0 || this._req.status >= 500))
			d = Math.min(500 * Math.pow(2, this.failures), 10000);
    	this._req = null;
        setTimeout(this.proxy(this._send), d);
      } else {
        this.stop();
        jawwa.atmosphere.serverNotAvailable();
      }
    },
    _send: function() {
      if (!this.active)
        return;

      if (this.trace)
    	  console.log("_send"+ " dtid: " + this.desktop.id);
      let jqxhr = $.ajax(this.ajaxOptions);
      this._req = jqxhr;
      zAu.cmd0.echo(this.desktop);
    },
    start: function() {
      if (this.trace)
    	  console.log("start"+ " dtid: " + this.desktop.id);
      this.desktop._serverpush = this;
      this.active = true;
      this._send();
    },
    stop: function() {
      if (this.trace)
    	  console.log("stop"+ " dtid: " + this.desktop.id);
      this.active = false;
      this.desktop._serverpush = null;      
      if (this._req) {
        this._req.abort();
        this._req = null;
      }
    }
  });
  jawwa.atmosphere.serverNotAvailable = function() {
    	zk.confirmClose = false;
    	zk.errorDismiss();
    	// no blocking alert: reload with a full page request, which shows the login page
    	// or the maintenance page of a proxy / load balancer in front of the server
    	window.location.href="index.zul";
   };
   jawwa.atmosphere.sessionTimeout = function() {
    	zk.confirmClose = false;
    	adempiere.get("zkTimeoutText", function(ok, val) {
			if (ok && !!val)
			{
				zk.errorDismiss();
				alert(val);
			}
			window.location.href="index.zul";
		});
   };
})();
