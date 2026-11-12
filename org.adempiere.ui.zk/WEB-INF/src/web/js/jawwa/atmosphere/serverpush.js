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
      this.ajaxOptions.timeout = this.timeout;
      this.ajaxOptions.url = zk.ajaxURI("/comet", {au: true,desktop:this.desktop.id,ignoreSession:true}),
      this.trace = trace;
      let me = this;
      this.ajaxOptions.error = function(jqxhr, textStatus, errorThrown) {
    	  if (me.trace)
    		  console.log("error: " + textStatus + " dtid: " + me.desktop.id + " errorThrown: " + errorThrown + " status: " + jqxhr.status);
    	  if (textStatus == "timeout") {
    		  // normal idle long-poll timeout: the server is reachable
    		  me.failures = 0;
    	  } else if (textStatus != "abort" && errorThrown != "SessionNotFound") {
	          console.error("error: " + textStatus + " errorThrown: " + errorThrown + " status: " + jqxhr.status);
	          me.failures += 1;
    	  }
      };
      this.ajaxOptions.success = function() {
    	  if (me.trace)
    		  console.log("success" + " dtid: " + me.desktop.id);
          zAu.cmd0.echo(this.desktop);
          me.failures = 0;
      };
      this.ajaxOptions.complete = function() {
    	  if (me.trace) {
    		  console.log("complete"+ " dtid: " + me.desktop.id);
    		  if (me._req)
    		  	console.log(me._req.status + " " + me._req.statusText);
    	  }
    	  if (me._req && (me._req.statusText == "SessionNotFound" || me._req.statusText == "DesktopNotFound") && me._req.status == 400) {
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
