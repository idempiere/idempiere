---
name: idempiere-design-level-changes
description: Deciding whether an iDempiere core change needs a community design discussion before any code is written. Use before implementing any new feature, enhancement or behaviour change in core, especially one that adds Application Dictionary content, changes a public API or extension point, changes default behaviour, adds a dependency or configuration point, removes or deprecates something, or migrates existing data.
---

# Design-level changes: discuss before coding

Some changes shape iDempiere for every installation, often permanently. For these the question is not "does the code work?" but "does the project want this change?". That decision happens in an open discussion **before** coding, not in the PR review.

## Is it design-level?

A change is design-level if it does **any** of the following:

- Adds or changes Application Dictionary content in core: tables, columns, windows, processes. This is a shared namespace and effectively permanent for everyone (see `idempiere-database-changes`).
- Changes a public API or an extension point that plugins build on.
- Changes default behaviour, so an existing install behaves differently after upgrade with no configuration change. This is usually discouraged.
- Introduces a new dependency: a library, a database feature, a Java version or a build tool.
- Adds a second way to do something that already exists, or introduces a new architectural pattern.
- Adds a new configuration point (SysConfig key, preference). Each one is permanent surface area someone maintains.
- Removes or deprecates anything.
- Contains a migration script that touches existing data.
- Is hard to revert once released.

**If unsure, treat it as design-level.**

Not design-level, proceed normally: bug fixes, tests, refactors with no behaviour change, translations.

## Workflow

1. Discuss the change on Mattermost (https://mattermost.idempiere.org/idempiere/channels/marketing) before writing code: the problem, the use case and the proposed approach.
2. Core developers and implementers give feedback. There is no fixed waiting period: contributors can always ask there.
3. The contributor can also bring the topic to the weekly Friday meeting and ask for a review or a decision.
4. Possible outcomes: yes, yes with changes, or no. "No" is a valid, published outcome, given with a reason. A declined idea can often be built as a plugin instead.
5. When opening the PR, link the discussion in the description (see `idempiere-contribution-workflow`).

## What the agent does

- Before implementing a requested change, check it against the list above.
- If it matches, **do not start implementing.** Tell the developer which criteria it matches and why, and suggest discussing it on Mattermost first. Offer to draft the post:

  ```text
  Problem: <what is wrong or missing today>
  Use case: <who needs it and the concrete business scenario>
  Proposed approach: <what would change in core>
  Alternatives considered: <including a plugin or existing extension point>
  Impact on existing installs: <defaults, data, upgrade, compatibility>
  ```

- If the developer says the discussion already happened and the change was approved, continue. Ask for the link so it can go into the PR description.
- Whenever a plugin or an existing extension point would avoid touching core, suggest it as an alternative.
- For changes that are clearly not design-level, don't slow the developer down.
