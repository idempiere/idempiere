(function() {
  jawwa.atmosphere.startServerPush = function(dtid, timeout) {
    var dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();

    var spush = new jawwa.atmosphere.ServerPush(dt, timeout);
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
    timeout: 300000,
    delay: 1000,
    failures: 0,
    count: 0,

    $init: function(desktop, timeout) {
      this.desktop = desktop;
      this.timeout = timeout;
    },
    _schedule: function() {
      if (this.failures < 10) {
        var delay = this.delay * Math.pow(2, Math.min(this.failures, 7));
        setTimeout(this.proxy(this._send), delay);
      } else {
        this.stop();
      }
    },
    _send: function() {
      if (!this.active)
        return;
      
      var me = this;
      
      var socket = $.atmosphere;
      var request = { 
    		url: zk.ajaxURI("/comet", {
    	          au: true
    	        }),    	        
		  	logLevel : 'debug',
		  	transport :  'streaming',
		  	fallbackTransport: 'long-polling',
			method: "GET",
			cache: false,
			async: true,
		    timeout: me.timeout,
		    onError: function(response) {
		    	me.failures += 1;
		    	me.count--;
		    	if (response.transport == 'long-polling' && me.count == 0) {
		    		me._schedule();
		    	} else if (me.failures >= 10) {
		    		me.stop();
		    	}
            },
            onMessage: function(response) {
            	zAu.cmd0.echo(me.desktop);
            	me.failures = 0;
            	me.count--;
                if (response.transport == 'long-polling' && me.count == 0) {
                	me._schedule();
                }
            }
      };
      
      request.url = request.url+'?dtid='+me.desktop.id;
      this.count++;
      socket.subscribe(request);      
    },
    start: function() {
      this.desktop._serverpush = this;
      this.active = true;
      this._send();
    },
    stop: function() {
      this.desktop._serverpush = null;
      this.active = false;
      if (this._req) {
        this._req.abort();
        this._req = null;
      }
    }
  });
})();
