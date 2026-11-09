# Session Timeout Warning – Design

Status: draft for review · Date: 2026-11-08 · Target: iDempiere core (`idempiere/idempiere` master), upstream contribution
Jira: none yet (to be created from this document). No existing IDEMPIERE ticket covers this — checked 2026-11-08.

## 1. Intent

Today a ZK web client session ends silently after the idle timeout (`web.xml` = 60 min, or
`ZK_SESSION_TIMEOUT_IN_SECONDS` per tenant/system, applied at login in `LoginWindow.loginCompleted`).
ZK's `automatic-timeout` redirects to `/timeout.zul`, and anything the user had not saved is lost.

We want a warning shortly before the idle timeout: a modal saying
**"Your session will end in X seconds"** with a live countdown and a **Continue** button that
keeps the session alive. This is a UX improvement for every iDempiere install, contributed upstream.

## 2. Goals

- Warn the user W seconds before the idle session timeout, with a live countdown.
- **Continue** extends the session (resets the idle clock) and closes the dialog.
- **Log out** performs the normal logout.
- Works across multiple browser tabs of the same session: activity in any tab, or Continue in
  any tab, keeps the whole session alive and closes the dialog in every tab.
- On by default, 60 seconds, configurable via SysConfig.

## 3. Non-goals

- Changing how long the timeout is, or how it is configured (`ZK_SESSION_TIMEOUT_IN_SECONDS` stays as is).
- Auto-saving unsaved records.
- Changing the existing admin broadcast countdown (`TimeoutPanel`, `BroadCastUtil.EVENT_SESSION_TIMEOUT`,
  `KillCurrentSession`). It stays untouched.
- Coordinating sessions across different browsers/devices (those are separate sessions).
- REST / web services sessions.

## 4. Anti-goals (failure even if it "works")

- The warning keeps a session alive by itself (the countdown's own requests, dashboard timers or
  server push resetting the idle clock) → sessions never expire. This would be a security regression.
- A tab logs out a session that is still active because another tab had activity.
- The dialog appears on the login page, during login/role selection, or when timeout is disabled.
- Existing installs get a different timeout length after upgrade.

## 5. Configuration

| Key | Status | Meaning |
|-----|--------|---------|
| `ZK_SESSION_TIMEOUT_IN_SECONDS` | existing (IDEMPIERE-2110) | Idle timeout; unset → `web.xml`. Negative (≠ -2) → no timeout |
| `ZK_SESSION_TIMEOUT_WARNING_IN_SECONDS` | **new** | Seconds before timeout to show the dialog. Default **60**. `0` = no warning |

- New key: same configuration levels as the existing one (System / Client / Org), read with
  `MSysConfig.getIntValue(..., AD_Client_ID, AD_Org_ID)` at login, next to the existing read.
- No warning when timeout is disabled (≤ 0).
- If W ≥ effective timeout T, use W = T / 2 *(my call)*.
- The effective T must be the real one: SysConfig value if set, otherwise `HttpSession.getMaxInactiveInterval()`
  (which reflects `web.xml`).
- Constant added to `MSysConfig`; AD_SysConfig record created by migration script with value 60
  (on by default — decided).

## 6. Behaviour

```
 login ──► T = effective timeout, W = warning seconds

 ───── real user activity in any tab resets the clock ─────┐
 idle ...................................... T−W            ▼          T
 ├──────────────────────────────────────────┼──────────────┤
                                            │ dialog in     │──► session ends
                                            │ every tab     │    (existing timeout path, timeout.zul)
                                            └──────┬────────┘
                                      Continue (any tab)
                                                   │
                                     server ping resets idle clock,
                                     dialog closes in all tabs
```

Dialog (decided: centred modal over the desktop, Continue + Log out):

```
┌────────────────────────────────────────────┐
│ Session expiring                           │
├────────────────────────────────────────────┤
│   ⏱  Your session will end in 57 seconds   │
│      due to inactivity.                    │
│              [ Continue ]  [ Log out ]     │
└────────────────────────────────────────────┘
```

- Countdown updates every second, client-side (no per-second server round trip).
- Continue has focus; Enter = Continue. Esc does not dismiss without choosing *(my call: Esc = Continue is
  also acceptable; builder decides)*.
- At zero: the existing timeout behaviour runs (session invalidated, redirect to `timeout.zul`). Nothing new.
- Texts are AD_Message entries (translatable), e.g. `SessionTimeoutWarningTitle`,
  `SessionTimeoutWarning` (with `{0}` seconds placeholder), reuse existing `Logout` / Continue messages where they
  exist. Exact names are the builder's call; follow existing naming in `AD_Message`.
- Accessibility: dialog has `role="alertdialog"`; the countdown is announced politely, not every second
  (e.g. at start and at 30/10 s) *(my call)*.

## 7. Detecting the end of the session exactly — iDempiere owns the deadline

### 7.1 How a session ends today (verified in ZK 10.3.0.1 bytecode + iDempiere source, 2026-11-08)

- Every AU request reaches `DHtmlUpdateServlet`, including WebSocket ones: `ServerPushEndPoint.onMessage`
  re-POSTs `zkau;` messages to `/zkau`. The WebSocket `__ping__` does not.
- `keepAlive = Configuration.isTimerKeepAlive()` (false; not set in `zk.xml`) **or** any command in the batch
  other than `onTimer` / `dummy`.
- `SimpleSession.notifyClientRequest(keepAlive)`: keepAlive → `_tmLastReq = now`; otherwise if
  `now − _tmLastReq > maxInactiveInterval` → `invalidate()`. `_tmLastReq` is private with no getter.
- Jetty's `HttpSession.lastAccessed` is touched by every request (timer ticks too); its reaper expires at
  `lastAccessed + T`.
- So idle sessions with dashboard timers **do** expire today (on the first timer tick after T). The
  "timers/push keep sessions alive forever" concern does not apply; nothing in this ticket changes session lifetime.
- The exact end moment cannot be read from ZK (private field, and it depends on which request comes next),
  so it is not predictable from outside.

### 7.2 Design: iDempiere keeps its own stamp and enforces it

1. **Activity stamp.** A ZK `EventInterceptor` (precedent: `LogEventInterceptor` in `zk.xml`, currently
   commented out) sets HTTP-session attribute `lastUserActivity = now` for user events. It ignores
   `onTimer`, `dummy`, `onPiggyback`, the warning's own events and other non-user events (builder classifies
   iDempiere's JS-fired events such as `onClientInfo`, `onUserToken`; when unsure → not activity).
2. **Invariant.** Our stamp counts a *subset* of what ZK counts, so
   `our deadline ≤ ZK deadline ≤ Jetty deadline`. ZK/Jetty can never end the session before ours, so our
   deadline is the true end of the session. *(My call: at most a few seconds earlier than today's ZK behaviour, never later.)*
3. **Enforcement.** At countdown zero the client asks the server; if `now − lastUserActivity ≥ T` the server
   invalidates the session → existing `timeout.zul` path. Any request arriving after our deadline is also
   invalidated server-side (covers laptop sleep / closed lid).
4. **"Time left" query** must not count as activity. Preferred: new WebSocket message alongside `__ping__` in
   `ServerPushEndPoint` (touches neither ZK nor Jetty clocks); fallback for Atmosphere mode: a small servlet.
   Server returns *seconds left*, not a timestamp (no client clock skew).
5. **Client timing.** Deadline kept as `Date.now() + secondsLeft` (immune to background-tab timer throttling);
   re-check on `visibilitychange` and on `BroadcastChannel` messages.
6. **Continue** is a normal user event → resets our stamp and ZK's.
7. **Cluster.** `lastUserActivity` is a plain serializable session attribute (works with Redis/replicated sessions).
8. **Still to check:** ZK's client-side `automatic-timeout` redirect logic — align it with our deadline so it
   neither fires early nor duplicates.

### 7.3 Typing and clicking in the page count as activity (decided)

Typing, clicking and scrolling inside the page often send no request (e.g. a long note until the field loses focus).
These count:
- the client listens for `keydown`, `pointerdown`/`click` and `wheel`/scroll (not mouse movement — my call);
- it sends a throttled "user active" event at most once per 60 s *(my call; never more often than W)*,
  as a user event so it updates our stamp **and** ZK's `_tmLastReq`;
- only real input triggers it; it never fires on a timer by itself (anti-goal 1);
- it is shared across tabs via `BroadcastChannel`, so one tab's input resets the clock in all tabs.

### 7.4 Long-running processes and reports (decided: warn anyway)

A process or report started by the user does not hold back the dialog. If it runs longer than T−W the
user sees the warning and can click Continue. No per-session tracking of running work.

Related known issue: IDEMPIERE-6974 (WebSocket retry loop causing session timeouts).

## 8. Multi-tab (decided: Continue in one tab keeps all tabs alive)

All tabs share one HTTP session but are separate ZK desktops.

- Source of truth is the server: the session's last real activity time and T.
- Tabs coordinate client-side via `BroadcastChannel` (fallback: `storage` event on `localStorage`) to
  share "activity happened" / "continue clicked" / "logged out" and to close dialogs together.
- Before a tab acts on zero, it asks the server for time left; if the session was extended elsewhere, it
  resyncs instead of logging out. The "time left" request itself must not count as activity (§7).
- Logout in one tab: other tabs end on their next request as today *(may also close their dialogs via the channel)*.

## 9. Where it lives (guidance, builder decides specifics)

- `org.adempiere.base`: `MSysConfig` constant.
- `org.adempiere.ui.zk`:
  - read W and T after login (`LoginWindow.loginCompleted` or desktop init in `AdempiereWebUI`/`DefaultDesktop`)
    and pass them to the client;
  - client script under `WEB-INF/src/web/js/adempiere/` (existing iDempiere JS package) for idle tracking,
    countdown, BroadcastChannel and the dialog trigger;
  - server-side handler for Continue (keep-alive) and "time left" query;
  - dialog either a ZK `Window` (consistent look/theme) or client-rendered; builder decides, must follow the
    default theme.
- AD records (AD_SysConfig `ZK_SESSION_TIMEOUT_WARNING_IN_SECONDS` = 60, AD_Message entries): per repo
  `AGENTS.md` rule 3, the **developer creates them in the iDempiere UI with Centralized IDs** and generates the
  migration scripts (`migration/iD14/postgresql` + `oracle`). The builder only specifies what to create and
  reviews what was generated — no hand-written SQL, no invented IDs/UUs.

## 9a. Repo workflow constraints (from `AGENTS.md`)

- Branch must be `IDEMPIERE-####-session-timeout-warning`; current worktree branch
  `session-timeout-warning` gets renamed once the Jira ticket exists.
- Every commit message starts with `IDEMPIERE-####`; one ticket per PR.
- Works on PostgreSQL and Oracle; GPLv2 header on new Java files; English only; minimal diff.
- This design document is a working file and is **not** part of the upstream PR.
- Docs PR to `idempiere/idempiere.github.io`: new entry in
  `docs/basic-development/system-configurator.md` (`ZK_SESSION_TIMEOUT_WARNING_IN_SECONDS`), and a new-features page.

## 10. Testing

- Unit test for the W/T calculation (default, 0, ≥ T, timeout disabled, -2 unset).
- Manual / Selenium scenarios with a short timeout (e.g. T=120, W=60):
  1. idle → dialog at T−W, countdown, timeout page at T;
  2. Continue → dialog closes, no timeout until next T;
  3. two tabs: activity in tab A delays dialog in B; Continue in A closes dialog in B;
  4. dashboard with auto-refresh gadgets open and idle → still times out;
  5. `W=0` → no dialog; timeout disabled → no dialog;
  6. login page left open → no dialog;
  7. typing in a text field for longer than T−W without leaving it → no dialog;
  8. long-running report (> T−W) → dialog appears anyway, Continue works;
  9. laptop sleep past T, then wake → timeout page, not a live session;
  10. background tab (throttled timers) → dialog and timeout at the right moment;
  11. Atmosphere server push mode (no WebSocket) → "time left" fallback works.
- Unit test for the activity classification (which event names update the stamp).

## 11. Left to the builder

Exact AD_Message names, JS structure, dialog implementation (ZK Window vs. client), the exact event used for
"user active" and Continue, Esc behaviour, classification of iDempiere's JS-fired events, Jira ticket wording.
