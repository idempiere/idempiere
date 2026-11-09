# Jira draft — IDEMPIERE (New Feature)

**Project:** IDEMPIERE · **Type:** New Feature · **Component:** ZK WebUI · **Affects/Fix version:** 14

## Summary

Warn ZK web client users before their idle session times out, with a countdown and a Continue button

## Description

### Problem

When a ZK web client session has been idle for its timeout (`web.xml` default 60 min, or `ZK_SESSION_TIMEOUT_IN_SECONDS` — IDEMPIERE-2110) it ends silently: the user is sent to `timeout.zul` and loses anything not yet saved, with no warning and no chance to stay logged in.

The existing countdown (`TimeoutPanel`) only appears when an administrator broadcasts a forced logout; it is not tied to idleness and has no way to continue.

### Proposal

1. Shortly before the idle timeout, show a modal dialog centred over the desktop:
   > **Session expiring**
   > Your session will end in 57 seconds due to inactivity.
   > [Continue] [Log out]

   The countdown updates every second.
2. **Continue** resets the idle clock and closes the dialog. **Log out** runs the normal logout. If the countdown reaches zero, the existing timeout behaviour runs (`timeout.zul`).
3. Browser tabs of the same session behave as one: activity in any tab delays the warning in all tabs; Continue in any tab closes the dialog in every tab.
4. Only user actions count as activity. Typing, clicking and scrolling in the page count even when no server request is sent. Dashboard refresh timers, server push and the warning's own checks do not keep the session alive.
5. The server owns the deadline. iDempiere keeps its own "last user activity" time in the HTTP session, counting a subset of what ZK counts (ZK: every AU command except `onTimer` / `dummy`), so its deadline is never later than ZK's or the container's. The browser asks the server for the remaining time (over the existing server-push WebSocket, without counting as activity) before warning and before ending; the server invalidates the session when the deadline has passed. This covers laptop sleep, background-tab timer throttling and several tabs.
6. New SysConfig `ZK_SESSION_TIMEOUT_WARNING_IN_SECONDS` (System / Client / Org, like `ZK_SESSION_TIMEOUT_IN_SECONDS`):
   - default **60** (on by default)
   - `0` = no warning
   - no warning when the session timeout is disabled
   - if the value is ≥ the timeout, half the timeout is used
7. Dialog texts are `AD_Message` entries (translatable).
8. Not shown on the login page or during login / role selection.
9. A process or report running longer than the warning period does not hold back the warning.

### Example

`ZK_SESSION_TIMEOUT_IN_SECONDS = 1800`, warning = 60: after 29 idle minutes the dialog appears; Continue keeps the user logged in for another 30 minutes of idleness.

### Who benefits

Every ZK web client user. Losing half-entered documents to a silent timeout is a common complaint, and an expiry warning is standard in business web applications.

### Affected areas

- **UI:** ZK web client — new dialog, client-side idle tracking and tab coordination; one handler for the status message in `ServerPushEndPoint` / `serverpush.js`; one call at the end of `AdempiereWebUI.loginCompleted()`.
- **Dictionary:** one new `AD_SysConfig` record, new `AD_Message` records (migration scripts for PostgreSQL and Oracle).
- **Base:** new `MSysConfig` constant.
- **Docs:** System Configurator page and a new-feature page on docs.idempiere.org.

### Impact

- Session timeout length and its configuration are unchanged.
- Visible change after upgrade: users see the warning by default. Set the new key to `0` for the previous silent behaviour.
- A session may end a few seconds earlier than today's ZK timing, never later.
- The admin-broadcast `TimeoutPanel` is unchanged. Nothing is auto-saved.

### Alternatives considered

- **ZK `timeout-message` instead of `timeout-uri`:** only changes what is shown after the session has already ended.
- **Longer timeouts:** hides the problem and weakens security.
- **Client-side keep-alive pinging:** would keep idle sessions alive indefinitely — a security regression.
- **Reading ZK's own idle time:** `SimpleSession._tmLastReq` is private with no getter, and the actual end depends on which request arrives next, so it cannot be predicted from outside.
- **Plugin:** needs hooks in login and the server-push endpoint, and is useful to every install, so core is the natural place.

### Core or plugin

Core: a general UX improvement for all ZK web client users, not company-specific.

### Proof of concept

Built from master and run as a server product in Docker with a fresh GardenWorld database, with a 3-minute session and the 60-second warning. Verified with a scripted browser:

- the browser asked the server at 120 s; the server said 63 s left, so the dialog waited
- the dialog appeared at "59 seconds" and counted down
- Continue closed it and restarted the clock
- the dialog appeared again after 120 s idle
- at 183 s the server reported 0 s left, invalidated the session, and the browser landed on `timeout.zul`

Change to existing core files: 15 added lines, no removed lines.

Not verified yet: several tabs, typing, Atmosphere server push mode, the Log out button.

### Related

- IDEMPIERE-2110 — configurable session timeout
- IDEMPIERE-986 — nicer timeout message
- IDEMPIERE-6974 — WebSocket retry loop causing session timeouts (relevant to the status channel)
