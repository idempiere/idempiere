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
    delay: 100,
    failures: 0,

    $init: function(desktop, timeout) {
      this.desktop = desktop;
      this.timeout = timeout;
    },
    _schedule: function() {
      if (this.failures < 100) {
        setTimeout(this.proxy(this._send), this.delay);
      } else {
        this.stop();
      }
    },
    _send: function() {
      if (!this.active)
        return;

      var me = this;
      var jqxhr = $.ajax({
        url: zk.ajaxURI("/comet", {
          au: true
        }),
        type: "GET",
        cache: false,
        async: true,
        global: false,
        data: {
          dtid: this.desktop.id
        },
        accepts: "text/plain",
        dataType: "text",
        timeout: me.timeout,
        error: function(jqxhr, textStatus, errorThrown) {
          if (typeof console == "object") {
            console.error(errorThrown);
          }
          me.failures += 1;
          me._schedule();
        },
        success: function(data) {
          zAu.cmd0.echo(me.desktop);
          me.failures = 0;
          me._schedule();
        }
      });
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