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
    delay: 250,
    failures: 0,
    timeout: 0,
    ajaxOptions: {
        url: zk.ajaxURI("/comet", {au: true}),
        type: "GET",
        cache: false,
        async: true,
        global: false,
        data: null,
        dataType: "text" 
    },
    $init: function(desktop, timeout) {
      this.desktop = desktop;
      this.timeout = timeout;
      this.ajaxOptions.data = { dtid: this.desktop.id };
      this.ajaxOptions.timeout = this.timeout;
      var me = this;
      this.ajaxOptions.error = function(jqxhr, textStatus, errorThrown) {
          if (typeof console == "object") {
        	  console.error(textStatus);
              console.error(errorThrown);
          }
          me.failures += 1;
          me._schedule();
      };
      this.ajaxOptions.success = function(data) {
          zAu.cmd0.echo(this.desktop);
          me.failures = 0;
          me._schedule();
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

      var jqxhr = $.ajax(this.ajaxOptions);
      this._req = jqxhr;
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