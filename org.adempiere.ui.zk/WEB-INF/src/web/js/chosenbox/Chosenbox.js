/* Chosenbox.js

	Purpose:
		
	Description:
		
	History:
		Tue Nov 16 15:15:52 TST 2011, Created by benbai

Copyright (C) 2011 Potix Corporation. All Rights Reserved.

This program is distributed under LGPL Version 3.0 in the hope that
it will be useful, but WITHOUT ANY WARRANTY.
 */
(function() {
	function clearAllData(wgt) {
		wgt._clearSelection();
		wgt._ppMaxHeight = wgt.fixDisplay = wgt._separatorCode = wgt._startOnSearching = wgt._chgSel = wgt.fixInputWidth = null;
	}
	function startOnSearching(wgt) {
		if (!wgt._startOnSearching)
			wgt._startOnSearching = setTimeout(function() {
				wgt._fireOnSearching(wgt.$n(('inp')).value);
				wgt._startOnSearching = null;
			}, 350);
	}

	let Chosenbox =

	chosenbox.Chosenbox = zk.$extends(zul.Widget, {
				$init : function(props) {
					this.$supers('$init', arguments);
					this._selItems = [];
					this._separatorCode = [];
					this._ppMaxHeight = 350;
				},
				$define : {
					items : function(v) {
						if (!this._renderByServer)
							this.setListContent();
					},
					/**
					 * Returns the tab order of the input of this
					 * component.
					 * <p>
					 * Default: 0 (means the same as browser's default).
					 * 
					 * @return int
					 */
					/**
					 * Sets the tab order of the input of this
					 * component.
					 * 
					 * @param int
					 *            tabindex
					 */
					tabindex : function(tabindex) {
						let n = this.$n('inp');
						if (n)
							n.tabindex = tabindex || '';
					},
					/**
					 * Returns the index of the selected item (-1 if no
					 * one is selected).
					 * 
					 * @return int
					 */
					/**
					 * Selects the item with the given index.
					 * 
					 * @param int
					 *            selectedIndex
					 */
					selectedIndex : function(v, opts) {
						let options, sel;
						this._clearSelection();
						if ((sel = this.$n('sel')) && v >= 0) {
							options = jq(sel).children();
							this._doSelect(this._getItemByIndex(v));
						}
						if (v == -1)
							this._fixEmptyMessage(true);
					},
					renderByServer : function(v) {
						if (v && this.$n())
							this._clearListContent();
					},
					/**
					 * Returns whether it is disabled.
					 * <p>
					 * Default: false.
					 * 
					 * @return boolean
					 */
					/**
					 * Sets whether it is disabled.
					 * 
					 * @param boolean
					 *            disabled
					 */
					disabled : function(disabled) {
						let n = this.$n('inp');
						if (n)
							n.disabled = disabled ? 'disabled' : '';
					},
					/**
					 * Returns the name of the input of this component.
					 * <p>
					 * Default: null.
					 * <p>
					 * The name is used only to work with "legacy" Web
					 * application that handles user's request by
					 * servlets. It works only with HTTP/HTML-based
					 * browsers. It doesn't work with other kind of
					 * clients.
					 * <p>
					 * Don't use this method if your application is
					 * purely based on ZK's event-driven model.
					 * 
					 * @return String
					 */
					/**
					 * Sets the name of the input of this component.
					 * <p>
					 * The name is used only to work with "legacy" Web
					 * application that handles user's request by
					 * servlets. It works only with HTTP/HTML-based
					 * browsers. It doesn't work with other kind of
					 * clients.
					 * <p>
					 * Don't use this method if your application is
					 * purely based on ZK's event-driven model.
					 * 
					 * @param String
					 *            name the name of this component.
					 */
					name : function(name) {
						let n = this.$n('inp');
						if (n)
							n.name = name;
					},
					/**
					 * Returns the emptyMessage, it will be displayed if
					 * no selected items while not focused.
					 * 
					 * @return String
					 */
					/**
					 * Sets the emptyMessage.
					 * 
					 * @param String
					 *            emptyMessage
					 */
					emptyMessage : null,
					/**
					 * Returns the no-result text of this component.
					 * <p>
					 * Default: null.
					 * <p>
					 * The no-result text will be displayed in popup if
					 * nothing match to the input value and can not
					 * create either, the syntax "{0}" will be replaced
					 * with the input value at client side.
					 * 
					 * @return String
					 */
					/**
					 * Sets the no-result text of this component.
					 * <p>
					 * The no-result text will be displayed in popup if
					 * nothing match to the input value and can not
					 * create either, the syntax "{0}" will be replaced
					 * with the input value at client side.
					 * 
					 * @param String
					 *            noResultsText the no-result text of
					 *            this component.
					 */
					noResultsText : null,
					/**
					 * Returns the create message of this component.
					 * <p>
					 * Default: null.
					 * <p>
					 * The create message will be displayed in popup if
					 * nothing match to the input value but can create
					 * as new label, the syntax "{0}" will be replaced
					 * with the input value at client side.
					 * 
					 * @return String
					 */
					/**
					 * Sets the create message of this component.
					 * <p>
					 * The create message will be displayed in popup if
					 * nothing match to the input value but can create
					 * as new label, the syntax "{0}" will be replaced
					 * with the input value at client side.
					 * 
					 * @param String
					 *            createMessage the create message of
					 *            this component.
					 */
					createMessage : null,
					/**
					 * Returns the separate chars of this component.
					 * <p>
					 * Support: 0-9, A-Z (case insensitive), and
					 * ,.;'[]/\-=
					 * <p>
					 * Default: null.
					 * <p>
					 * The separate chars will work as 'Enter' key, it
					 * will not considered as input value but send
					 * onSerch or onSearching while key up.
					 * 
					 * @return String
					 */
					/**
					 * Sets the separate chars of this component.
					 * <p>
					 * Support: 0-9, A-Z (case insensitive), and
					 * ,.;'[]/\-=
					 * <p>
					 * The separate chars will work as 'Enter' key, it
					 * will not considered as input value but send
					 * onSerch or onSearching while key up.
					 * 
					 * @param String
					 *            createMessage the create message of
					 *            this component.
					 */
					separator : function(v) {
						let separatorCode = this._separatorCode;
						separatorCode.length = 0;
						// save keycode for special symble
						// handle the code of special char because
						// we need process it with both keyUp and
						// keyDown
						// which has different code with keyPress
						if (v.indexOf(',') != -1)
							separatorCode.push(188);
						if (v.indexOf('.') != -1)
							separatorCode.push(190);
						if (v.indexOf('/') != -1)
							separatorCode.push(191);
						if (v.indexOf(';') != -1)
							separatorCode.push(zk.ie ? 186 : 59);
						if (v.indexOf("'") != -1)
							separatorCode.push(222);
						if (v.indexOf('[') != -1)
							separatorCode.push(219);
						if (v.indexOf(']') != -1)
							separatorCode.push(221);
						if (v.indexOf('\\') != -1)
							separatorCode.push(220);
						if (v.indexOf('-') != -1)
							separatorCode.push(zk.ie ? 189 : 109);
						if (v.indexOf('=') != -1)
							separatorCode.push(107);
					},
					/**
					 * Returns whether can create new item, The input
					 * will considered to be a new item if it is not
					 * exist and this property is true.
					 * 
					 * @return boolean
					 */
					/**
					 * Sets whether can create new item.
					 * 
					 * @param boolean
					 *            creatable
					 */
					creatable : null,
					/**
					 * Returns the open status of drop down list.
					 * 
					 * @return boolean
					 */
					/**
					 * Sets the drop down list open status, and
					 * open/close drop down list as need.
					 * 
					 * @param boolean
					 *            open
					 */
					open : null
				},
				setListContent : function(v) {
					let sel, out, oldHlite, value;
					if (sel = this.$n('sel')) {
						if (oldHlite = jq(this.$n('sel'))
								.find(
										'.' + this.getZclass()
												+ '-option-over')[0])
							value = oldHlite.innerHTML;
						out = [];
						this._renderItems(out, v);
						this._clearListContent();
						sel.innerHTML = out.join('');
						// restore old high-light
						if (value
								&& (oldHlite = this
										._getItemByValue(value)))
							this._hliteOpt(oldHlite, true);
						this._startFixDisplay({
							hliteFirst : true,
							fromServer : true
						});
					}
				},
				_clearListContent : function() {
					if (this.$n()) {
						this.$n('sel').innerHTML = '';
						this.$n('empty').style.display = 'none';
					}
				},
				_renderItems : function(out, content) {
					let s = $eval(content ? content : this._items)
							|| [], zcls = this.getZclass();
					for (let i = 0, j = s.length; i < j; i++) {
						out.push('<div class="', zcls, '-option">',
								zUtl.encodeXML(s[i]), '</div>');
					}
					return out;
				},
				getZclass : function() {
					let zcls = this._zclass;
					return zcls != null ? zcls : "z-chosenbox";
				},
				// update the selected items, the old selection will be
				// cleared at first
				setChgSel : function(val) { // called from the server
					this._clearSelection();
					let sel, options;
					if (sel = this.$n('sel')) { // select each item
						options = jq(sel).children();
						let s = $eval(val), renderByServer = this._renderByServer, item, value;
						for (let i = 0; i < s.length; i++) {
							value = s[i];
							if (item = this._getItemByValue(value))
								this._doSelect(item);
							else
								this._selectItemDirectly(value);
						}
					} else
						this._chgSel = val; // not binded, just store it
					this._fixEmptyMessage(true);
				},
				bind_ : function() {
					this.$supers(Chosenbox, 'bind_', arguments);					
					let n = this.$n(), inp = this.$n('inp');

					this.domListen_(inp, 'onFocus', 'doFocus_')
							.domListen_(inp, 'onBlur', 'doBlur_');
					zWatch.listen({
						onFloatUp : this,
						onSize : this
					});
					this._fixWidth(n);					
					//fix selection
					if (this._selItems && this._selItems.length > 0) {
						let s = this._selItems;
						this._selItems = [];
						for (let i = 0; i < s.length; i++) {
							let value = s[i];
							if (item = this._getItemByValue(value))
								this._doSelect(item);
							else
								this._selectItemDirectly(value);
						}
					} else if (this._chgSel) {
						let s = this._chgSel;
						this._chgSel = null;
						for (let i = 0; i < s.length; i++) {
							value = s[i];
							if (item = this._getItemByValue(value))
								this._doSelect(item);
							else
								this._selectItemDirectly(value);
						}
					}
					// fix emptyMessage
					this._fixEmptyMessage(true);
					if (this._open && !this.isDisabled())
						this.setOpen(true);
				},
				unbind_ : function() {
					let inp = this.$n('inp');
					this.domUnlisten_(inp, 'onFocus', 'doFocus_')
							.domUnlisten_(inp, 'onBlur', 'doBlur_');
					zWatch.unlisten({
						onFloatUp : this,
						onSize : this
					});
					clearAllData(this);
					this.$supers(Chosenbox, 'unbind_', arguments);
				},
				redraw: function (out) {
					this.$supers('redraw', arguments);					
				},
				onSize : function() {
					this._fixInputWidth();
				},
				_fixWidth : function(n) {
					if (this._width)
						n.style.width = this._width;
					this.$n('pp').style.width = jq(n).width() + 'px';
				},
				doBlur_ : function(evt) {
					jq(this.$n()).removeClass(
							this.getZclass() + '-focus');
				},
				doFocus_ : function(evt) {
					if (!this.isDisabled())
						jq(this.$n()).addClass(
								this.getZclass() + '-focus');
				},
				doMouseOver_ : function(evt) {
					let target = evt.domTarget;
					// mouseover option
					if (jq(target).hasClass(
							this.getZclass() + '-option'))
						this._hliteOpt(target, true);
				},
				doMouseOut_ : function(evt) {
					let target = evt.domTarget;
					// mouseout option
					if (jq(target).hasClass(
							this.getZclass() + '-option-over'))
						this._hliteOpt(target, false);
				},
				_hliteOpt : function(target, highlight) {
					let zcls = this.getZclass() + '-option-over';
					if (highlight) {
						// clear old first
						let oldHlite = jq(this.$n('sel'))
								.find(
										'.' + this.getZclass()
												+ '-option-over')[0];
						if (oldHlite)
							jq(oldHlite).removeClass(zcls);
						jq(target).addClass(zcls);
					} else
						jq(target).removeClass(zcls);
				},
				_doArrowDown : function(key, evt) {
					if (key == 'up')
						this._moveOptionFocus('prev');
					else if (key == 'down')
						this._moveOptionFocus('next');
					else {
						let inp = this.$n('inp'), pos = zk(inp)
								.getSelectionRange(), label = jq(
								this.$n()).find(
								'.' + this.getZclass()
										+ '-sel-item-focus')[0];
						// only works if cursor is at the begining of
						// input
						if (pos[0] == 0 && pos[1] == 0) {
							if (key == 'left')
								this._moveLabelFocus(label, 'prev');
							else if (key == 'right') {
								if (label)
									evt.stop();
								this._moveLabelFocus(label, 'next');
							}
						}
					}
				},
				// focus previous or next visible option,
				// depends on dir
				_moveOptionFocus : function(dir) {
					let sel = this.$n('sel'), $sel = jq(sel), oldHlite = $sel
							.find('.' + this.getZclass()
									+ '-option-over')[0], newHlite, next = dir == 'next', prev = dir == 'prev';
					if (next && !this._open) // default focus first
												// while open
						this.setOpen(true, {
							sendOnOpen : true
						});
					else {
						// preset newHlite
						if (oldHlite) // get previous or next item of
										// old hi-lighted one
							newHlite = next ? oldHlite.nextSibling
									: oldHlite.previousSibling;
						else
							// get first/last item if no old hi-lighted
							newHlite = next ? sel.firstChild : // choose
																// first/last
																// option
																// if no
																// old
																// highlighted
							prev ? sel.lastChild : null;
						if (newHlite) // find closest visible new item
							while (newHlite
									&& newHlite.style.display == 'none')
								newHlite = next ? newHlite.nextSibling
										: prev ? newHlite.previousSibling
												: null;

						if (newHlite)
							this._hliteOpt(newHlite, true);
						else if (oldHlite)
							this._hliteOpt(oldHlite, false);
					}
				},
				// focus previous or next label,
				// depends on dir
				_moveLabelFocus : function(label, dir) {
					let zcls = this.getZclass() + '-sel-item-focus', newLabel, prev = dir == 'prev', next = dir == 'next';
					if (label) {
						jq(label).removeClass(zcls);
						newLabel = prev ? label.previousSibling
								: next ? label.nextSibling : null;
						if (prev && !newLabel)
							newLabel = label;
						else if (next && newLabel == this.$n('inp'))
							newLabel = null;
					} else if (prev)
						newLabel = this.$n('inp').previousSibling;
					if (newLabel)
						jq(newLabel).addClass(zcls);
				},
				// called after press backspace or del and release
				_deleteLabel : function(key, evt) {
					let inp = this.$n('inp'), pos = zk(inp)
							.getSelectionRange(), label;

					// only works if cursor is at the begining of input
					if (pos[0] == 0 && pos[1] == 0) {
						let zcls = this.getZclass() + '-sel-item-focus';
						if (label = jq(this.$n()).find('.' + zcls)[0]) {
							let dir = (label.previousSibling && key == 'backspace') ? 'prev'
									: 'next';
							this._moveLabelFocus(label, dir);
							this._doDeselect(label, {
								sendOnSelect : true
							});
							evt.stop(); // should stop or will delete
										// text
							// maybe have to filt out deselected item
							this._startFixDisplay();
						} else if ((label = inp.previousSibling)
								&& key == 'backspace')
							jq(label).addClass(zcls);
					}
				},
				_removeLabelFocus : function() {
					let zcls = this.getZclass() + '-sel-item-focus', label = jq(
							this.$n()).find('.' + zcls)[0];
					if (label)
						jq(label).removeClass(zcls);
				},
				// called after press enter and release
				_doEnterPressed : function(evt) {
					let $sel, hlited, old;
					// clear timer and fix display before process
					if (old = this.fixDisplay)
						clearTimeout(old);
					this._fixDisplay();
					if (this._open) {
						if ((hlited = this.$n('empty'))
								&& jq(hlited).hasClass(
										this.getZclass()
												+ '-empty-creatable')) {
							this._fireOnSearch(this.$n('inp').value);
							if (this._open) {
								this.setOpen(false, {
									sendOnOpen : true
								});
							}
						} else if (($sel = jq(this.$n('sel')))
								&& (hlited = $sel.find('.'
										+ this.getZclass()
										+ '-option-over')[0])) {
							let options = $sel.children();
							this._doSelect(hlited, {
								sendOnSelect : true
							});
							if (this._open) {
								this.setOpen(false, {
									sendOnOpen : true
								});
							}
						}
					}
				},
				doClick_ : function(evt) {
					if (!this.isDisabled()) {
						let target = evt.domTarget, $target = jq(target), inp = this
								.$n('inp'), zcls = this.getZclass();
						this._removeLabelFocus();
						if (inp.value == this._emptyMessage)
							inp.value = '';
						if ($target.hasClass(zcls + '-option')) { // click
																	// on
																	// option
							this._doSelect(target, {
								sendOnSelect : true
							});
							if (this._open)
								this.setOpen(false, {
									sendOnOpen : true,
									fixEmptyMessage : true
								});
						} else if ($target.hasClass(zcls
								+ '-empty-creatable')) { // click on
															// new label
							this._fireOnSearch(inp.value);
							if (this._open)
								this.setOpen(false, {
									sendOnOpen : true
								});
						} else {
							let label = target, zcls = this.getZclass()
									+ '-sel-item';
							if ($target.hasClass(zcls)
									|| (label = $target.parent('.'
											+ zcls)[0])) { // click on
															// label
								jq(label).addClass(zcls + '-focus');
							}
							if (!this._open)
								this.setOpen(true, {
									sendOnOpen : true
								});
						}

						inp.focus();
						this.$supers('doClick_', arguments);
					}
				},
				// select an item
				_doSelect : function(target, opts) {
					this._hliteOpt(target, false);
					let value = target.innerHTML;
					if (this._selItems.indexOf(value) == -1) {
						this._createLabel(value);
						target.style.display = 'none'; // hide selected
														// item
						// record the selected item
						this._selItems.push(value);
						this._fixEmptyMessage(true);

						if (opts && opts.sendOnSelect)
							this.fireSelectEvent();
					}
				},
				_selectItemDirectly : function(value) {
					if (this._selItems.indexOf(value) == -1) {
						this._createLabel(value);
						// record the selected item
						this._selItems.push(value);
						this._fixEmptyMessage(true);
					}
				},
				// deselect an item
				_doDeselect : function(selectedItem, opts) {
					let value = jq(selectedItem).find(
							'.' + this.getZclass() + '-sel-item-cnt')[0].innerHTML, element = this
							._getItemByValue(value), _selItems = this._selItems;
					if (this._open)
						this.setOpen(false, {
							sendOnOpen : true
						});
					// remove record
					_selItems.splice(_selItems.indexOf(value), 1);
					// show origin option of deselected item if it
					// exists
					if (element)
						element.style.display = 'block';
					// remove label of deselected item
					jq(selectedItem).remove();
					if (opts && opts.sendOnSelect)
						this.fireSelectEvent(); // only fire if active
												// from client
					// maybe have to filt out deselected item
					this._startFixDisplay();
				},
				_getItemByValue : function(value) {
					let options = jq(this.$n('sel')).children(), item;
					for (let i = 0; i < options.length; i++)
						if ((item = options[i])
								&& item.innerHTML == value)
							return item;
						else if (!item) // over index
							return null;
				},
				// create label for selected item
				_createLabel : function(value) {
					let span = document.createElement("span"), content = document
							.createElement("div"), delbtn = document
							.createElement("div"), wgt = this, zcls = this
							.getZclass();
					span.className = zcls + '-sel-item';
					content.innerHTML = value;
					content.className = zcls + '-sel-item-cnt';
					delbtn.className = zcls + '-del-btn';

					span.appendChild(content);
					span.appendChild(delbtn);
					jq(delbtn).bind('click', function() {
						if (!wgt.isDisabled()) {
							wgt.$n('inp').focus();
							wgt._doDeselect(span, {
								sendOnSelect : true
							});
						}
					});
					this.$n().insertBefore(span, this.$n('inp')); // add
																	// div
																	// mark
				},
				// clear all selected items
				_clearSelection : function(opts) {
					let n = this.$n(), inp = this.$n('inp'), c, // selected
																// item
					del;
					if (n)
						c = n.firstChild;
					while (c && c != inp) {
						del = c;
						c = c.nextSibling;
						this._doDeselect(del, opts);
					}
					this._selItems.length = 0;
				},
				// fire onSelectevent to server
				fireSelectEvent : function() {
					let data = [], selItems = this._selItems; // selected
																// item
					for (let i = 0; i < selItems.length; i++)
						data.push(selItems[i]);
					this.fire('onSelect', data);
				},
				// fire onSearch event
				_fireOnSearch : function(value) {
					let data = [];
					data.push(value);
					this.fire('onSearch', data);
				},
				// fire onSearching event
				_fireOnSearching : function(value) {
					let data = [];
					data.push(value);
					this.fire('onSearching', data);
				},
				// should close drop-down list if not click self
				onFloatUp : function(ctl) {
					if (ctl.origin != this) {
						if (this._open)
							this.setOpen(false, {
								sendOnOpen : true,
								fixEmptyMessage : true
							});
						this._removeLabelFocus();
					}
				},

				doKeyDown_ : function(evt) {
					let keyCode = evt.keyCode;
					switch (keyCode) {
					case 8:// backspace
						this._deleteLabel('backspace', evt);
						break;
					case 13:// enter processed in key up only
						break;
					case 27:// esc processed in key up only
						break;
					case 37:// left
						this._doArrowDown('left', evt);
						break;
					case 38:// up
						this._doArrowDown('up');
						break;
					case 39:// right
						this._doArrowDown('right', evt);
						break;
					case 40:// down
						this._doArrowDown('down');
						break;
					case 46:// del
						this._deleteLabel('del', evt);
						break;
					default:
						// separator processed in key up only
						if (!this._isSeparator(keyCode)) {
							this._updateInput(evt);
							if (!this._open)
								this.setOpen(true, {
									sendOnOpen : true
								});
						} else
							evt.stop();
					}
					if (!(keyCode == 39 || keyCode == 46
							|| keyCode == 8 || keyCode == 37))
						this._removeLabelFocus();
				},
				doKeyUp_ : function(evt) {
					let keyCode = evt.keyCode, opts = {
						hliteFirst : true
					};
					switch (keyCode) {
					case 13:// enter
						this._doEnterPressed(evt);
						break;
					case 27:// esc
						if (this._open)
							this.setOpen(false, {
								sendOnOpen : true
							});
						this._fixEmptyMessage();
						break;
					default:
						if (this._isSeparator(keyCode))
							this._doEnterPressed(evt);
						else {
							this._fixInputWidth();
							if (keyCode == 38 || keyCode == 40)
								opts = null;
							if (!this._renderByServer)
								this._startFixDisplay(opts);
						}
					}
					if (!(keyCode >= 37 && keyCode <= 40 || keyCode == 13))
						startOnSearching(this);
				},
				_isSeparator : function(keyCode) {
					let separator = this._separator, separatorCode = this._separatorCode;
					return (separatorCode && separatorCode
							.indexOf(keyCode) != -1)
							|| ((keyCode >= 48 && keyCode <= 122)
									&& separator && separator
									.toUpperCase()
									.indexOf(
											String
													.fromCharCode(keyCode)) != -1);
				},
				_updateInput : function(evt) {
					let inp = evt ? evt.domTarget : this.$n('inp'), txcnt = this
							.$n('txcnt'), wgt = this;

					// check every 100ms while input
					if (!this.fixInputWidth)
						this.fixInputWidth = setTimeout(function() {
							wgt._fixInputWidth()
						}, 100);
				},
				setOpen : function(open, opts) {
					if (!this.isDisabled())
						this._open = open;
					if (this.$n('pp')) {
						let pp = this.$n('pp');
						if (open)
							this.open(this.$n(), pp, opts);
						else
							this.close(pp, opts);
					}
				},
				open : function(n, pp, opts) {
					let ppstyle = pp.style;

					this._fixWidth(n);
					this._fixsz(pp);

					zk(pp).makeVParent();
					// required for setTopmost
					this.setFloating_(true);
					this.setTopmost();
					ppstyle.zIndex = n.style.zIndex;
					ppstyle.display = 'block';
					if (opts) {
						let inp = this.$n();
						zk(pp).position(inp, "after_start");
					}

					zk(pp).slideDown(this, {
						duration : 100
					});
					this._startFixDisplay({
						hliteFirst : true
					});

					if (opts && opts.sendOnOpen)
						this.fire('onOpen', {
							open : true
						});
				},
				close : function(pp, opts) {
					zk(pp).undoVParent();
					this.setFloating_(false);
					pp.style.display = 'none';

					if (opts) {
						if (opts.sendOnOpen)
							this.fire('onOpen', {
								open : false
							});
						if (opts.fixEmptyMessage)
							this._fixEmptyMessage();
					}
					if (this._renderByServer)
						this._clearListContent();
				},
				_fixsz : function(pp) {
					let ppstyle = pp.style, maxh = this._ppMaxHeight;
					ppstyle.height = 'auto';
					ppstyle.left = "-10000px";
					ppstyle.display = "block";
					ppstyle.visibility = "hidden";
					if (jq(pp).height() > maxh)
						ppstyle.height = maxh + 'px';
					ppstyle.display = "none";
					ppstyle.visibility = "visible";
				},
				// calculate the width for input field
				_fixInputWidth : function() {
					let n = this.$n(), inp = this.$n('inp'), txcnt = this
							.$n('txcnt'), oldh = jq(n).height(), width, max = parseInt(this._width) - 10;
					// copy value to hidden txcnt
					txcnt.innerHTML = inp.value;
					// get width from hidden txcnt
					width = jq(txcnt).width() + 30;

					if (width > max)
						inp.style.width = max + 'px';
					else
						inp.style.width = width + 'px';
					if (this.fixInputWidth)
						clearTimeout(this.fixInputWidth);
					this.fixInputWidth = null;
				},
				// prevent redundent fix display
				_startFixDisplay : function(opts) {
					// fix asap if from server
					if (opts && opts.fromServer)
						this._fixDisplay(opts);
					else { // replace old if exist and hold a while
							// while input
						let wgt = this, old;
						if (old = this.fixDisplay)
							clearTimeout(old);
						this.fixDisplay = setTimeout(function() {
							wgt._fixDisplay(opts);
						}, 200);
					}
				},
				// filt out not matched item
				_fixDisplay : function(opts) {
					if (!this._open)
						return;
					let fromServer = opts && opts.fromServer;
					if (!this._renderByServer
							|| (opts && opts.fromServer)) {
						let str = this.$n('inp').value, oldhlite = jq(
								this.$n('sel'))
								.find(
										'.' + this.getZclass()
												+ '-option-over')[0], existance = this
								._fixSelDisplay(opts && opts.hliteFirst
										&& !oldhlite, str, fromServer);
						str = str ? str.trim() : '';
						this._fixEmptyDisplay({
							showExistance : true
						}, str, existance._found, existance._exist);
					} else {
						this._fixEmptyDisplay({
							showBlank : !this.$n('sel').firstChild
						});
					}
				},
				// fix the display content of options
				_fixSelDisplay : function(hliteFirst, str, fromServer) {
					let pp = this.$n('pp'), $pp = jq(pp), maxh = this._ppMaxHeight, ppstyle = pp.style, selItems = this._selItems, options = jq(
							this.$n('sel')).children(), found = false, // unselected
																		// match
																		// item
																		// exist
					exist = false, // selected match item exist
					index, element, showAll, selected;
					str = str ? str.trim() : '';
					showAll = str && str == this._emptyMessage
							|| str == '';
					if (fromServer && str && str != this._emptyMessage && str != '' && this._renderByServer)
						showAll = true;
					// iterate through item list
					for (index = 0, element = options[index]; index < options.length; index++, element = options[index]) {
						// should fix each element if renew content from
						// server
						selected = selItems.indexOf(element.innerHTML) != -1;
						if (fromServer || !selected) {
							if (!selected
									&& (showAll || str
											&& element.innerHTML
													.toLowerCase()
													.startsWith(
															str
																	.toLowerCase()))) {
								if (!found) {
									found = true;
									if (hliteFirst)
										this._hliteOpt(element, true);
								}
								element.style.display = 'block';
							} else {
								this._hliteOpt(element, false);
								element.style.display = 'none'; // hide
																// if
																// has
																// input
																// and
																// not
																// match
							}
						}
						if (!exist
								&& str
								&& element.innerHTML.toLowerCase() == str
										.toLowerCase())
							exist = true;
					}
					ppstyle.height = 'auto';
					if ($pp.height() > maxh)
						ppstyle.height = maxh + 'px';
					return {
						_found : found,
						_exist : exist
					};
				},
				// fix the display of no-result text block
				_fixEmptyDisplay : function(type, str, found, exist) {
					let ecls = this.getZclass() + '-empty-creatable', empty = this
							.$n('empty');
					if (type
							&& (type.showBlank || type.showExistance
									&& this._renderByServer && !str)) {
						empty.innerHTML = '&nbsp;';
						jq(empty).removeClass(ecls);
						empty.style.display = 'block';
					} else if (type && type.showExistance) {
						// set the status of empty block
						if (!found) {
							if (this._creatable && !exist && str) {// show
																	// create
																	// message
																	// if
																	// input
																	// new
																	// item
																	// and
																	// creatable
								let createMsg = this._createMessage;
								if (createMsg)
									createMsg = zUtl.encodeXML(
											createMsg.replace(/\{0\}/g,
													str)).replace(
											/\n/g, '<br />');
								else
									createMsg = '&nbsp;';
								empty.innerHTML = createMsg;
								jq(empty).addClass(ecls);
							} else { // show no-result text if
										// nothing can be selected
								let empMsg = this._noResultsText;
								if (empMsg)
									empMsg = zUtl.encodeXML(
											empMsg.replace(/\{0\}/g,
													str)).replace(
											/\n/g, '<br />');
								else
									empMsg = '&nbsp;';
								empty.innerHTML = empMsg;
								jq(empty).removeClass(ecls);
							}
							empty.style.display = 'block';
						} else {
							empty.style.display = 'none';
							jq(empty).removeClass(ecls);
						}
					}
				},
				// show emptyMessage or clear input
				_fixEmptyMessage : function(force) {
					let inp;
					if ((!this._open || force)
							&& (inp = this.$n('inp'))) {

						inp.value = this._selItems.length == 0 ? zUtl
								.encodeXML(this.getEmptyMessage()) : '';
						this._fixInputWidth();
						if (this._open) {
							this._startFixDisplay();
						}
					}
				},
				domAttrs_ : function() {
					let v;
					return this.$supers('domAttrs_', arguments)
							+ (this.isDisabled() ? ' disabled="disabled"'
									: '')
							+ ((v = this.getEmptyMessage()) ? ' value="'
									+ zUtl.encodeXML(v) + '"'
									: '')
							+ ((v = this.getTabindex()) ? ' tabindex="'
									+ v + '"' : '')
							+ ((v = this.getName()) ? ' name="'
									+ zUtl.encodeXML(v) + '"' : '');
				}
			});
})();