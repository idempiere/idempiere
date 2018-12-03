(function() {
  org.idempiere.websocket.startServerPush = function(dtid) {
    var dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();

    var spush = new org.idempiere.websocket.ServerPush(dt);
    spush.start();
  };
  org.idempiere.websocket.stopServerPush = function(dtid) {
    var dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();
  };
  org.idempiere.websocket.ServerPush = zk.$extends(zk.Object, {
    desktop: null,
    socket: null,
    active: false,
    delay: 10,
    $init: function(desktop) {
      this.desktop = desktop;           
    },
    start: function() {
      this.desktop._serverpush = this;
      var url = window.location.protocol == "http:" ? "ws://" : "wss://";
      var path = window.location.href.substring(window.location.protocol.length+2);
      path = path.substring(location.host.length+1);
      var last=path.lastIndexOf("/");
      if (last > 0) {
    	  path = path.substring(0, last);
      } else {
    	  path = "";
      }
      url = url + window.location.host + "/" + path + "/serverpush/" + this.desktop.id;
      var me = this;
      this.socket = new WebSocket(url);
      this.socket.onopen = function (event) {
    	  me.active = true;
      };
      this.socket.onmessage = function (event) {
    	  if (event.data=="echo") {
    		  zAu.cmd0.echo(this.desktop);
    	  } else if (event.data=="stop") {
    		  me.stop();  
    	  }    	  
      }
      this.socket.onerror = function(event) {
    	  console.log(event);
      };
    },
    stop: function() {
      this.active = false;
      this.desktop._serverpush = null;      
      if (this.socket) {
    	try {
    		this.socket.close();
    	} catch (error) {}
        this.socket = null;
      }
    }
  });
})();