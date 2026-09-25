zk.afterLoad('calendar', function() {
    zk.override(calendar.Item.prototype, "calculate_", function() {
      if (typeof this.item === "undefined" || this.item == null) {
        return;
      }
      this.$calculate_.apply(this, arguments);
    });

    zk.override(calendar.Item.prototype, "unbind_", function() {
      let node = this.$n();
      if (typeof node === "undefined") {
        return;
      }
      if (typeof this.$unbind_ === "undefined") {
        return;
      }
      this.$unbind_.apply(this, arguments);
    });

    zk.override(calendar.CalendarsMonth.prototype, "onSize", function() {
      let cmp = this.$n();
      if (typeof cmp === "undefined" || cmp == null) {
        return;
      }
      this.$onSize.apply(this, arguments);
    });

    zk.override(calendar.CalendarsDefault.prototype, "onSize", function() {
      let cmp = this.$n();
      if (typeof cmp === "undefined" || cmp == null) {
        return;
      }
      this.$onSize.apply(this, arguments);
    });
});