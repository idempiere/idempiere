/* Idle session timeout warning (POC).
 * The server owns the deadline; this script estimates it locally, asks the server ("__session__"
 * over the server push WebSocket) before warning or ending, and coordinates browser tabs of the
 * same session through BroadcastChannel.
 */
(function() {
  const CHANNEL = 'idempiere-session-timeout';
  const STATUS_WAIT = 5000;
  let st = null;
  let channel = null;

  function now() { return Date.now(); }
  function desktop() { return zk.Desktop.$(); }

  function post(msg) {
    if (channel) {
      try { channel.postMessage(msg); } catch (e) { /* ignore */ }
    }
  }

  function sendActive() {
    let dt = desktop();
    if (!dt) return;
    zAu.send(new zk.Event(dt, 'onSessionActive', null, {ignorable: true}));
    st.lastSent = now();
    post({type: 'sent', at: st.lastSent});
  }

  /** ask server for seconds left; false when no WebSocket is available */
  function requestStatus() {
    let dt = desktop();
    let sp = dt && dt._serverpush;
    if (sp && sp.socket && sp.socket.readyState === WebSocket.OPEN) {
      st.pendingAt = now();
      sp.socket.send('__session__');
      return true;
    }
    return false;
  }

  function statusPending() {
    return st.pendingAt && now() - st.pendingAt < STATUS_WAIT;
  }

  function onInput() {
    if (!st || st.ended || st.dialog) return;
    let t = now();
    st.lastInput = t;
    st.deadline = t + st.T;
    post({type: 'input', at: t});
    if (t - st.lastSent >= st.throttle) sendActive();
  }

  function secondsLeft() {
    return Math.max(0, Math.ceil((st.deadline - now()) / 1000));
  }

  function showDialog() {
    if (st.dialog) { updateDialog(); return; }
    let d = document.createElement('dialog');
    d.setAttribute('role', 'alertdialog');
    d.setAttribute('aria-labelledby', 'z-session-timeout-title');
    d.setAttribute('aria-describedby', 'z-session-timeout-msg');
    d.style.cssText = 'padding:0;border:1px solid #bbb;border-radius:6px;min-width:340px;font-family:inherit;box-shadow:0 8px 24px rgba(0,0,0,.25)';
    d.innerHTML =
      '<div id="z-session-timeout-title" style="padding:10px 16px;font-weight:bold;border-bottom:1px solid #ddd">Session expiring</div>' +
      '<div style="padding:16px"><span id="z-session-timeout-msg"></span>' +
      '<div style="margin-top:16px;text-align:right">' +
      '<button type="button" data-act="continue" autofocus style="margin-right:8px">Continue</button>' +
      '<button type="button" data-act="logout">Log out</button></div></div>';
    d.addEventListener('cancel', function(e) { e.preventDefault(); }); // Esc does not dismiss
    d.addEventListener('click', function(e) {
      let act = e.target && e.target.getAttribute && e.target.getAttribute('data-act');
      if (act === 'continue') onContinue();
      else if (act === 'logout') onLogout();
    });
    document.body.appendChild(d);
    st.dialog = d;
    updateDialog();
    d.showModal();
  }

  function updateDialog() {
    if (!st.dialog) return;
    let msg = st.dialog.querySelector('#z-session-timeout-msg');
    msg.textContent = 'Your session will end in ' + secondsLeft() + ' seconds due to inactivity.';
  }

  function hideDialog() {
    if (st.dialog) {
      try { st.dialog.close(); } catch (e) { /* ignore */ }
      st.dialog.remove();
      st.dialog = null;
    }
  }

  function onContinue() {
    sendActive();
    st.deadline = now() + st.T;
    hideDialog();
    post({type: 'continue', at: st.lastSent});
  }

  function onLogout() {
    let dt = desktop();
    hideDialog();
    st.ended = true;
    post({type: 'logout'});
    if (dt) zAu.send(new zk.Event(dt, 'onSessionLogout', null));
  }

  /** countdown reached zero in this tab: ask the server to log out (full iDempiere logout) */
  function expire() {
    if (st.ended) return;
    st.ended = true;
    hideDialog();
    post({type: 'expired'});
    let dt = desktop();
    if (dt) zAu.send(new zk.Event(dt, 'onSessionTimeout', null));
    // the server redirects after logout; fall back when it does not answer (session already gone)
    st.fallback = setTimeout(function() { window.location.href = 'timeout.zul'; }, 5000);
  }

  /** another tab ended the session */
  function expired() {
    if (st.ended) return;
    st.ended = true;
    hideDialog();
    window.location.href = 'timeout.zul';
  }

  // developer mode only: countdown badge in the header, left of the notification bell
  function renderBadge() {
    if (!st.debug) return;
    let b = document.getElementById('z-session-timeout-badge');
    if (!b || !b.isConnected) {
      b = document.createElement('div');
      b.id = 'z-session-timeout-badge';
      b.title = 'Session time left (developer mode); srv = last reply from server';
      let style = 'font:12px monospace;padding:3px 10px;border-radius:12px;border:1px solid #99a;' +
        'pointer-events:none;white-space:nowrap;';
      // the header is redrawn by ZK; the badge is re-inserted on the next tick when that happens
      let bell = document.querySelector('.desktop-user-panel .desktop-header-notification-btn');
      let anchor = bell && bell.closest('.desktop-user-panel > *');
      if (anchor && anchor.parentElement) {
        b.style.cssText = style + 'align-self:center;margin-right:8px;';
        anchor.parentElement.insertBefore(b, anchor);
      } else {
        b.style.cssText = style + 'position:fixed;top:12px;left:50%;transform:translateX(-50%);z-index:100000;';
        document.body.appendChild(b);
      }
    }
    let s = st.ended ? 0 : secondsLeft();
    let text = '\u23f1 ' + Math.floor(s / 60) + ':' + String(s % 60).padStart(2, '0');
    if (st.serverLeft != null) text += '  srv ' + st.serverLeft + 's';
    b.textContent = text;
    b.style.background = s * 1000 <= st.W ? '#fdd' : '#eef';
  }

  function tick() {
    if (!st) return;
    renderBadge();
    if (st.ended) return;
    let t = now();
    if (!st.dialog) {
      if (t >= st.deadline - st.W) {
        if (st.lastInput > st.lastSent) {
          // input not yet reported to the server (throttled): report it instead of warning
          sendActive();
          st.deadline = st.lastInput + st.T;
          return;
        }
        if (!statusPending() && !requestStatus()) {
          // no WebSocket (POC: no fallback), trust local estimate
          if (t >= st.deadline) expire(); else showDialog();
        }
      }
    } else {
      updateDialog();
      if (t >= st.deadline && !statusPending() && !requestStatus())
        expire();
    }
  }

  function onChannel(e) {
    let m = e.data || {};
    if (!st || st.ended) return;
    if (m.type === 'input') {
      st.lastInput = Math.max(st.lastInput, m.at);
      st.deadline = Math.max(st.deadline, m.at + st.T);
    } else if (m.type === 'sent') {
      st.lastSent = Math.max(st.lastSent, m.at);
    } else if (m.type === 'continue') {
      st.lastSent = Math.max(st.lastSent, m.at);
      st.deadline = Math.max(st.deadline, m.at + st.T);
      hideDialog();
    } else if (m.type === 'logout' || m.type === 'expired') {
      expired();
    }
  }

  /** server reply to "__session__": seconds left, -2 = not tracked */
  org.idempiere.session.onStatus = function(left) {
    if (!st || st.ended) return;
    st.pendingAt = 0;
    st.serverLeft = left;
    if (left === -2) return;
    if (left <= 0) { expire(); return; }
    st.deadline = now() + left * 1000;
    if (left * 1000 > st.W) hideDialog(); else showDialog();
  };

  /** server answer to onSessionTimeout when time is left (another tab was active) */
  org.idempiere.session.resume = function(left) {
    if (!st) return;
    clearTimeout(st.fallback);
    st.ended = false;
    org.idempiere.session.onStatus(left);
  };

  /** called by the server after login: timeout and warning in seconds, debug = developer mode */
  org.idempiere.session.start = function(timeout, warning, debug) {
    let t = now();
    if (st) hideDialog();
    st = {
      T: timeout * 1000, W: warning * 1000,
      throttle: Math.min(60000, Math.max(1000, warning * 500)),
      deadline: t + timeout * 1000, lastInput: 0, lastSent: t,
      pendingAt: 0, dialog: null, ended: false, debug: !!debug
    };
    if (!org.idempiere.session._installed) {
      org.idempiere.session._installed = true;
      let opts = {capture: true, passive: true};
      document.addEventListener('keydown', onInput, opts);
      document.addEventListener('pointerdown', onInput, opts);
      document.addEventListener('wheel', onInput, opts);
      document.addEventListener('visibilitychange', function() {
        if (document.visibilityState === 'visible') tick();
      });
      if (typeof BroadcastChannel !== 'undefined') {
        channel = new BroadcastChannel(CHANNEL);
        channel.onmessage = onChannel;
      }
      setInterval(tick, 1000);
    }
  };
})();
