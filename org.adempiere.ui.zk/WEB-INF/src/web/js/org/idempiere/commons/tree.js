zk.afterLoad("zul.sel", function () {
    let _tWgt = {},
        _tiWgt = {};
    zk.override(zul.sel.Treerow.prototype, _tiWgt, {
        getDragOptions_: function (map) {
            let copy = map.constructor(),
                wgt = this;
            // clone map
            for (let attr in map) {
                if (map.hasOwnProperty(attr)) copy[attr] = map[attr];
            }
            // change functions as needed
            let oldChange = copy.change,
                oldEnd = copy.endeffect;
            copy.change =  function (drag, pt, evt) {
                let tree = wgt.getTree();
                oldChange(drag, pt, evt);
                tree.triggerAutoScroll(evt.pageX, evt.pageY);
            };
            copy.endeffect = function (drag, evt) {
                let tree = wgt.getTree();
                oldEnd(drag, evt);
                tree.stopAutoScroll();
            }
            return copy;
        }
    });
    
    zk.override(zul.sel.Tree.prototype, _tWgt, {
        scrollValue: 10,
        scrollDelay: 0,
        initialScrollDelay: 200,        
        currentY: 0,
        previousY: 0,
        delayCount: 0,
        speedGap: 50,
        speedGapCounter: 0,
        triggerAutoScroll: function (x, y) {
            let $n = jq(this.$n()),
                offset = $n.offset(),
                top = offset.top + (this.$n('head')? 10 : 0),
                bottom = $n.outerHeight(true);
            if (y < top)
                this.startScrollToTop(y);
            else if (y > bottom)
                this.startScrollToBottom(y);
            else
                this.stopAutoScroll();
        },
        stopAutoScroll: function () {
            this.clearScrollToTopTimer();
            this.clearScrollToBottomTimer();
        },
        startScrollToTop: function (y) {
            let wgt = this;
            this.clearScrollToBottomTimer();
            if (!this._scrollToTopTimer) {
            	this.scrollDelay = this.initialScrollDelay;
            	this.previousY = this.currentY = y;
            	this.delayCount = this.speedGapCounter = 0;
                this._scrollToTopTimer = setInterval(function () {
                	wgt.delayCount = wgt.delayCount + 5;
                	if (wgt.delayCount >= wgt.scrollDelay) {
                		wgt.delayCount = 0;
                		wgt.speedGapCounter++;
                    	wgt.$n('body').scrollTop -= wgt.scrollValue;
                    	if (wgt.speedGapCounter == 5) {
                    		wgt.speedGapCounter = 0;
                    		if (wgt.scrollDelay > wgt.speedGap) {
	                    		wgt.scrollDelay = wgt.scrollDelay - wgt.speedGap;
	                    	} else if (wgt.scrollDelay == wgt.speedGap) {
	                    		wgt.scrollDelay = 10;
	                    	}
                    	} 
                    }
                }, 5);
            } else {
            	this.previousY = this.currentY;
            	this.currentY = y;
            	if (this.previousY != this.currentY) {
            		this.scrollDelay = this.initialScrollDelay;
            		this.speedGapCounter = 0;
            	}
            }
        },
        startScrollToBottom: function (y) {
            let wgt = this;
            this.clearScrollToTopTimer();
            if (!this._scrollToBottomTimer) {
            	this.scrollDelay = this.initialScrollDelay;
            	this.previousY = this.currentY = y;
            	this.delayCount = this.speedGapCounter = 0;
                this._scrollToBottomTimer = setInterval(function () {
                    wgt.delayCount = wgt.delayCount + 5;
                	if (wgt.delayCount >= wgt.scrollDelay) {
                		wgt.delayCount = 0;
                		wgt.speedGapCounter++;
                    	wgt.$n('body').scrollTop += wgt.scrollValue;
                    	if (wgt.speedGapCounter == 5) {
                    		wgt.speedGapCounter = 0;
                    		if (wgt.scrollDelay > wgt.speedGap) {
	                    		wgt.scrollDelay = wgt.scrollDelay - wgt.speedGap;
	                    	} else if (wgt.scrollDelay == wgt.speedGap) {
	                    		wgt.scrollDelay = 10;
	                    	}
                    	} 
                    }
                }, 5);
            } else {
            	this.previousY = this.currentY;
            	this.currentY = y;
            	if (this.previousY != this.currentY) {
            		this.scrollDelay = this.initialScrollDelay;
            		this.speedGapCounter = 0;
            	}
            }
        },
        clearScrollToTopTimer: function () {
            let timer = this._scrollToTopTimer;
            if (timer)
                clearInterval(timer);
            this._scrollToTopTimer = null;
        },
        clearScrollToBottomTimer: function () {
            let timer = this._scrollToBottomTimer;
            if (timer)
                clearInterval(timer);
            this._scrollToBottomTimer = null;
        }
    });
});