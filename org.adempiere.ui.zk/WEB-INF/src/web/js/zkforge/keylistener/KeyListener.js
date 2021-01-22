/* keylistener.js

{{IS_NOTE
	Purpose:
		zkforge.keylistener.KeyListener
	Description:
		Keylistener component for ZK.
}}IS_NOTE

Copyright 2007 by Easit AB. All rights reserved.

{{IS_RIGHT
	This program is distributed under GPL Version 2.0 in the hope that
	it will be useful, but WITHOUT ANY WARRANTY.
}}IS_RIGHT
*/

zk.$package('zkforge.keylistener');
zkforge.keylistener.KeyListener = zk.$extends(zul.Widget, {
	_ctrlKeys: null,
	_autoBlur: true,

	getCtrlKeys: function() {
		return this._ctrlKeys;
	},
	
	setCtrlKeys: function(ctrlKeys) {
		if(this._ctrlKeys != ctrlKeys) {
			this._ctrlKeys = ctrlKeys;
		}
	},
	
	getAutoBlur: function() {
		return this._autoBlur;
	},
	
	setAutoBlur: function(autoBlur) {
		if(this._autoBlur != autoBlur) {
			this._autoBlur = autoBlur;
		}
	},
	
	bind_: function (desktop, skipper, after) {
		this.$supers('bind_', arguments);
		
		var self = this;
		jq(document).ready(function () { 
			jq(document).keydown(self, self.keyDownHandle);
		});
	},
	
	unbind_: function (skipper, after) {
		this.$supers('unbind_', arguments);
		
		var self = this;
		jq(document).off("keydown", self.keyDownHandle);
	},
	
	keyDownHandle: function(evt){
		var self = evt.data;
		self.keyDown(evt);
		
	},
	
	keyDown: function(evt) {
		if (!evt) evt = window.event;

		var keycode = evt.keyCode, zkcode=''; //zkcode used to search z.ctkeys
		switch (keycode) {
			case 13: //ENTER
				zkcode = 'K';
			break;
			case 27: //ESC
			break;
			case 16: //Shift
			case 17: //Ctrl
			case 18: //Alt
			return true;
			case 44: //Ins
			case 45: //Del
				zkcode = keycode == 44 ? 'I': 'J';
			break;
			default:
				if (keycode >= 33 && keycode <= 40) { //PgUp, PgDn, End, Home, L, U, R, D
					zkcode = String.fromCharCode('A'.charCodeAt(0) + (keycode - 33));
						//A~H: PgUp, ...
					break;
				} else if (keycode >= 112 && keycode <= 123) { //F1: 112, F12: 123
					zkcode = String.fromCharCode('P'.charCodeAt(0) + (keycode - 112));
						//M~Z: F1~F12
					break;
				} else if (evt.ctrlKey || evt.altKey) {
					zkcode = String.fromCharCode(keycode).toLowerCase();
					break;
				}
			return true;
		}
		
		// If keyboard command is registered for this component, send request
		if(this.inCtrlKeys(evt, zkcode, this._ctrlKeys) ) {

			// If autoblur is specified, set focus to keylistener to trigger onBlur for focused component
			if(this._autoBlur == true){
				this.tabIndex = 32000;
				this.focus();
				this.tabIndex = 0;
			}

			evt.preventDefault();
			// _autoBlur = true will let current focus control blur but this event is sent after key event, so haven't valuable
			if (zk.currentFocus)//just need to raise it when have control got focus, other NPE
				id.zk.Extend.fakeOnchange (zk.currentFocus);
			zAu.send(new zk.Event(zk.Widget.$(this), 'onCtrlKey', {keyCode: keycode, ctrlKey: evt.ctrlKey, shiftKey: evt.shiftKey, altKey: evt.altKey}, {toServer: true}));
			
			return false;
		}
		return true;
	},
	
	inCtrlKeys: function(evt, zkcode, keys) {
		if (keys) {
			//format: ctl+k;alt+k;shft+k;k
			var cc = evt.ctrlKey ? '^': evt.altKey ? '@': evt.shiftKey ? '$': '#';
			var j = keys.indexOf(cc), k = keys.indexOf(';', j + 1);
			if (j >=0 && k >= 0) {
				keys = keys.substring(j + 1, k);
				return keys.indexOf(zkcode) >= 0;
			}
		}
		return false;
	}
});
