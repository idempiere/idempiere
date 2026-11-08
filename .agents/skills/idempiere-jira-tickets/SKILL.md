---
name: idempiere-jira-tickets
description: Drafting iDempiere Jira tickets (bug reports and enhancement or feature requests) for https://idempiere.atlassian.net, deciding whether something belongs in core or in a plugin, and handling suspected security vulnerabilities (which must NOT go to a public ticket). Use when the developer needs a new IDEMPIERE ticket, wants to improve a ticket description, or found a possible vulnerability.
---

# Jira tickets

References:
- https://docs.idempiere.org/docs/basic-development/contributing-to-core/bug-reporting-guidelines
- https://docs.idempiere.org/docs/basic-development/contributing-to-core/new-feature-suggestion-guidelines
- https://docs.idempiere.org/docs/basic-development/contributing-to-core/how-to-report-a-vulnerability

You **draft** the ticket text. The developer files it. Never create tickets or invent ticket numbers yourself.

## Security vulnerabilities: stop first

If the issue may be a security vulnerability (injection, auth bypass, data exposure across clients, RCE, XSS…):

- **Don't draft a public Jira ticket, public PR description or commit message that explains the vulnerability.**
- Tell the developer to report it by email to `security at idempiere dot com`, with full version details, clear reproduction steps, the impact, and whether they want to coordinate disclosure timing.
- You may help write that private email.

## Before drafting

- Check whether it can be reproduced on the latest version (`master` or the latest release), ideally on GardenWorld or a public test site (https://www.idempiere.org/test-sites).
- Ask the developer to search existing issues (https://idempiere.atlassian.net/issues/). If a **closed** issue matches, open a new one that links to it.
- For enhancements: Jira is mainly for bugs and fixes. New features should first get positive feedback on the forum (https://www.idempiere.org/forums) or Mattermost.

## Bug report

**Summary**: precise and searchable. It states what is wrong and under which condition.
- Weak: `Incorrect price is shown on order line`
- Good: `Prices from the price list are still displayed after updating them manually`

**Description** template:

```text
iDempiere Version: <from About>
Operating System: <OS and version>
Database: <engine and version>
Java Version: <version>

Steps to reproduce:
1. <one action per step, with concrete values, e.g. "Open window Sales Order">
2. <...>
3. Observe that <the problem>

Expected results:
<the action and the outcome that should happen>

Actual results:
<what happens instead, with context>

Additional information:
<stack trace from the log, screenshots, frequency, version where it last worked>
```

Rules: be specific (`Name=ABC`, `Code=XYZ`), avoid ambiguous "it"/"there", one action per step, end with an explicit observation, attach stack traces for crashes and real numbers for performance problems.

## Enhancement or feature request

Structure:

1. **Problem**: the current behavior and why it's insufficient (problem first, not the solution).
2. **Proposal**: step-by-step description of the new behavior with concrete examples.
3. **Who benefits**: why it's useful to a broad part of the community.
4. **Affected areas**: dictionary, business logic, UI, reports, integrations.
5. **Impact**: compatibility, migration, training.
6. **Alternatives considered** and why this one is preferred.
7. **Core or plugin?** A feature belongs in core when it benefits a large part of the community, fits the project direction, and isn't narrow or company-specific. Otherwise suggest a plugin.

## After the ticket exists

Continue with `idempiere-contribution-workflow`: branch `IDEMPIERE-####-...`, commits prefixed with the ticket, PR body starting with the ticket link.
