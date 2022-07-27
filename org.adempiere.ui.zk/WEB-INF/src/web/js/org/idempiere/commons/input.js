zk.afterLoad(function() {
    zk.$package('id.zk');

    id.zk.Extend = zk.$extends(zk.Object, {}, {
      fakeOnchange: function(wgt) {
        // just sent fake event when control is textfield and value is not yet sync to server
        if ((wgt.$instanceof(zul.inp.Textbox) || wgt.$instanceof(zul.inp.Decimalbox)) && wgt.$n().value != wgt.getText())
          zAu.send(new zk.Event(zk.Widget.$(wgt), 'onChange', {
            "value": wgt.$n().value
          }));

        else if (zk.$import("ckez.CKeditor") != undefined && wgt.$instanceof(ckez.CKeditor)) { //https://www.zkoss.org/javadoc/latest/jsdoc/_global_/zk.html#$import(_global_.String)
          // CKEditor extend from zul.Widget not from wget zul.inp.InputWidget
          // so some behavior is not same standard input
          // this code bring from ckez.CKeditor.onBlur
          let editor = wgt._editor;

          if (wgt._tidChg) {
            clearInterval(wgt._tidChg);
            wgt._tidChg = null;
          }

          if (!editor.document)
            editor.document = editor.element.getDocument();

          if (wgt.$class._checkEditorDirty(editor)) { // Issue #13
            let val = editor.getData();
            wgt._value = val; //save for onRestore
            //ZKCK-16, 17 use sendAhead to make sure onChange always happens first
            wgt.fire('onChange', {
              value: val
            });
            editor.resetDirty();
          }
        }
      },

      fireOnInitEdit: function(wgt) {
        // sent even to indicate field is start edit, this event sent new value to server but now don't use this data.
        if (wgt.$instanceof(zul.inp.Textbox))
          zAu.send(new zk.Event(zk.Widget.$(wgt), 'onInitEdit', {
            "value": wgt.$n().value
          }));
      }
    });
});

zk.afterLoad('zul.inp', function() {

    // should filter out for only component inside standard window or component wish fire this event,
    // or ever rise other event like start editting to distinguish with true onChange event
    zk.override(zul.inp.InputWidget.prototype, "doInput_", function(evt) {
      this.$doInput_(evt);

      if (this.get("isOnStardardWindow") == 'false' || this.get("isChangeEventWhenEditing") != true) {
        return; // don't waste time to check component don't lay on standard window
      }

      let domElemOfLayout = jq('#' + this.$n().id).closest(".adwindow-layout"); // return a array
      if (domElemOfLayout.length == 0) {
        this.set("isOnStardardWindow", "false"); // next time don't waste time to check this component
        // in case, you move this component to a standard window, please update this properties at client by javascript Widget.set ()
        // or at server by java function component.setWidgetOverride
      } else {
        let winLayoutWg = zk.Widget.$(domElemOfLayout);
        if (winLayoutWg == null) {
          ; // do nothing, this case rare happen because ".adwindow-layout" always is a component
        } else {
          let isEditting = winLayoutWg.get("isEditting");
          // winLayoutWg should cache to improve perfomance
          if (isEditting == "false") {
            winLayoutWg.set("isEditting", "true");
            id.zk.Extend.fireOnInitEdit(this); //fire change event to move to edit
          }
        }
      }
    });

    zk.override(zk.Widget.prototype, "onAutofill", function(evt) {
      id.zk.Extend.fakeOnchange(this); //fire change event to move to edit
    });

    zk.override(zul.inp.Textbox.prototype, "bind_", function(dt, skipper, after) {
      if (!this.$bind_)
        return;

      this.$bind_(dt, skipper, after);

      let txtid = this.getId()
      if (txtid != "txtUserId" && txtid != "txtPassword") {
        return;
      }

      this.domListen_(this.$n(), "onChange", "onAutofill");
    });

    zk.override(zul.inp.Textbox.prototype, "unbind_", function(dt, skipper) {
      if (!this.$unbind_)
        return;

      this.$unbind_(dt, skipper);

      let txtid = this.getId()
      if (txtid != "txtUserId" && txtid != "txtPassword") {
        return;
      }

      this.domUnlisten_(this.$n(), "onChange", "onAutofill"); //unlisten
    });

    zk.override(zul.inp.Combobox.prototype, "doKeyDown_", function(evt) {
      // avoid confuse of idempiere shortcut key and function key of combobox
      if ((evt.altKey || evt.ctrlKey || evt.shiftKey) &&
        (evt.keyCode == 33 || evt.keyCode == 34 || evt.keyCode == 35 || evt.keyCode == 36 || evt.keyCode == 38 || evt.keyCode == 40 || evt.keyCode == 37 || evt.keyCode == 39)) { //page up | page down | end | home | up | down | left | write

        if (this.isOpen()) //close drop down if already open. it will let combobox select current item, it's consistent with lost focus
          this.close({
            sendOnOpen: true
          });

        return;
        // TODO:current idempiere use alt + down/up to move child parrent tab, but combobox also use it to open, close drop down
        // at the moment, idempiere shortcut is more useful, so just get it work
      } else {
        this.$doKeyDown_(evt);
      }

    });
});