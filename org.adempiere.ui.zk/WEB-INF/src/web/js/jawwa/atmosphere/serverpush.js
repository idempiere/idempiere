(function() {
  jawwa.atmosphere.startServerPush = function(dtid, timeout) {
    var dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();

    //change to true to enable trace of execution
    var trace = false;
    var spush = new jawwa.atmosphere.ServerPush(dt, timeout, trace);
    spush.start();
  };
  jawwa.atmosphere.stopServerPush = function(dtid) {
    var dt = zk.Desktop.$(dtid);
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
      this.ajaxOptions.url = zk.ajaxURI("/comet", {au: true,desktop:this.desktop.id,ignoreSession:false}),
      this.trace = trace;
      var me = this;
      this.ajaxOptions.error = function(jqxhr, textStatus, errorThrown) {
    	  if (me.trace)
    		  console.log("error: " + textStatus + " dtid: " + me.desktop.id);
    	  if (textStatus != "timeout" && textStatus != "abort") {
	          if (typeof console == "object") {
	        	  console.error(textStatus);
	              console.error(errorThrown);
	          }
	          me.failures += 1;
    	  }
      };
      this.ajaxOptions.success = function(data) {
    	  if (me.trace)
    		  console.log("success" + " dtid: " + me.desktop.id);
          zAu.cmd0.echo(this.desktop);
          me.failures = 0;
      };
      this.ajaxOptions.complete = function() {
    	  if (me.trace)
    		  console.log("complete"+ " dtid: " + me.desktop.id);
    	  if (me._req && me._req.statusText == "SessionNotFound" && me._req.status == 400) {
    		  ;//stop sent request:IDEMPIERE-4237
    	  } else {
    		  me._schedule();
    	  }
      };
    },
    _schedule: function() {
      if (this.failures < 20) {
    	this._req = null;
        setTimeout(this.proxy(this._send), this.delay);
      } else {
        this.stop();
      }
    },
    _send: function() {
      if (!this.active)
        return;

      if (this.trace)
    	  console.log("_send"+ " dtid: " + this.desktop.id);
      var jqxhr = $.ajax(this.ajaxOptions);
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
})();
