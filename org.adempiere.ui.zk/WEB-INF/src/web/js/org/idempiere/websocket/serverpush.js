(function() {
  org.idempiere.websocket.startServerPush = function(dtid) {
    var dt = zk.Desktop.$(dtid);
    if (dt._serverpush && dt._serverpush.socket) {
    	if (dt._serverpush._reconnectId) {
    		return;
    	}
    	dt._serverpush.restart();    	
    } else {
    	var spush = new org.idempiere.websocket.ServerPush(dtid);
        spush.start();
    }    
  };
  org.idempiere.websocket.stopServerPush = function(dtid) {
    var dt = zk.Desktop.$(dtid);
    if (dt._serverpush)
      dt._serverpush.stop();
  };
  org.idempiere.websocket.ServerPush = zk.$extends(zk.Object, {    
    $init: function(dtid) {
      this.dtid = dtid;           
      this.socket = null;
      this.active = false;
      this.reconnect = false;
      var desktop = zk.Desktop.$(this.dtid);
      desktop._serverpush = this;
    },
    start: function() {
      var desktop = zk.Desktop.$(this.dtid);
      if (typeof desktop === 'undefined')
    	  return;      
      this.reconnect = false;
      this._reconnectId = null;
      var url = window.location.protocol == "http:" ? "ws://" : "wss://";
      var path = window.location.href.substring(window.location.protocol.length+2);
      path = path.substring(location.host.length+1);
      var last=path.lastIndexOf("/");
      if (last > 0) {
    	  path = "/" + path.substring(0, last) + "/serverpush/";
      } else {
    	  path = "/serverpush/";
      }
      url = url + window.location.host + path + desktop.id;
      var me = this;
      this.socket = new WebSocket(url);
      this.socket.onopen = function (event) {
    	  me.active = true;
    	  me.socket.send("__ping__");
      };
      this.socket.onmessage = function (event) {
    	  if (event.data=="echo") {
    		  var desktop = zk.Desktop.$(me.dtid);
    		  zAu.cmd0.echo(desktop);
    	  } else if (event.data=="stop") {
    		  me.stop();  
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
      var desktop = zk.Desktop.$(this.dtid);
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
})();