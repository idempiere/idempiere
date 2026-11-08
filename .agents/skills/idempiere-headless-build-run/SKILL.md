---
name: idempiere-headless-build-run
description: Building and running iDempiere core from the terminal without Eclipse. Use when you need to compile the project with Maven/Tycho, check that a change builds, apply pending migration scripts to the local database (RUN_SyncDBDev.sh), build and start the server product, find logs, or diagnose build failures.
---

# Headless build and run

References:
- https://docs.idempiere.org/docs/basic-installation/installing-for-development/manual-install/building-idempiere-without-eclipse
- https://docs.idempiere.org/docs/basic-installation/installing-for-development/manual-install/applying-additional-migration-scripts
- https://docs.idempiere.org/docs/basic-installation/installing-for-development/fast-linux-dev-setup

Requirements: JDK 17 and git. Maven comes through the wrapper `./mvnw`. A PostgreSQL (or Oracle) database with the iDempiere seed is needed for tests and for running the server.

The commands below use Linux/macOS syntax. On Windows, run the `.sh` scripts (including `RUN_SyncDBDev.sh`) from Git Bash, use `mvnw.cmd` in `cmd`/PowerShell, and use the `.bat` server scripts listed below.

## Credentials

`idempiere.properties` and `idempiereEnv.properties` usually contain the database password, often unencrypted (`RUN_SyncDBDev.sh` requires an unencrypted connection).

- Never print, `cat`, log or paste their contents, not even in a summary or an error report.
- Never commit them. They are gitignored; never bypass that with `git add -f`.
- If you need connection details (host, port, database name), ask the developer.

## Build

From the repo root:

```bash
./mvnw verify                 # full build, tests skipped by default
./mvnw verify -o              # offline, once dependencies are cached
./mvnw verify -DskipTests=false   # build + full unit test suite (see idempiere-unit-tests)
```

- The parent POM is `org.idempiere.parent/pom.xml`. It's a Tycho (OSGi) build, so bundles resolve against the target platform in `org.idempiere.p2.targetplatform`.
- The first build downloads many dependencies and is slow. Later builds are faster.
- After switching branches (e.g. between pull requests), use `./mvnw clean verify`. Leftover `target/` output from the previous branch can hide compile errors.
- A full build is the reliable way to check compilation across all bundles. Tycho doesn't handle partial `-pl` builds as well as plain Maven does.
- Run long builds in the background if your environment allows, and read the tail of the output for `BUILD SUCCESS` / `BUILD FAILURE`.

### Reading build failures
- `Compilation failure`: the bundle and file are named in the error. Fix the code.
- `Missing requirement` / `Unable to satisfy dependency`: an OSGi `MANIFEST.MF` `Import-Package` / `Require-Bundle` is missing or wrong, or the target platform didn't resolve. Check whether a new import needs a manifest entry in the bundle you changed.
- Network or repository errors: retry, or ask the developer about proxy settings. Don't change repository URLs in the POMs.

Don't edit POMs, `MANIFEST.MF` or target platform files beyond what the ticket needs, and mention any such change in the PR.

## Sync the local database with migration scripts

After pulling upstream changes, or after the developer generated new scripts on another database:

```bash
bash RUN_SyncDBDev.sh                 # uses ./idempiere.properties
bash RUN_SyncDBDev.sh -h              # usage
```

- It needs `idempiere.properties` in the repo root (created by the install/setup step) with an unencrypted connection.
- It applies every script in `migration/` not yet recorded in `AD_MigrationScript`, in order.
- Check the output for errors. Per-script logs are in `/tmp/SyncDB_out_<pid>`. On error, fix the cause and run again.
- This changes the developer's database. Tell them before running it.

## Build and start the server product

After `./mvnw verify`, the server product for each platform is under `org.idempiere.p2/target/products/org.adempiere.server.product/`:

| OS | Folder | Scripts |
|---|---|---|
| Linux | `linux/gtk/x86_64/` | `.sh` |
| Windows | `win32/win32/x86_64/` | `.bat` |
| macOS | `macosx/cocoa/x86_64/Eclipse.app/Contents/Eclipse/` | `.sh` |

In that folder:

```bash
# Linux / macOS
bash console-setup.sh          # interactive configuration (DB, ports, keystore)
bash silent-setup-alt.sh       # or non-interactive, using an idempiereEnv.properties prepared by the developer
bash idempiere-server.sh       # start (add "debug" to open the JDWP port 4554)
```

```bat
REM Windows
console-setup.bat
silent-setup-alt.bat
idempiere-server.bat
```

- The web UI is at `http://localhost:8080/webui/` by default (port as configured).
- Logs: `log/` under the product directory. The console output also shows OSGi startup errors.
- Stop it with Ctrl+C, or by killing the process if it was started in the background.
- Developers working in Eclipse run the `server.product` launch configuration instead. Ask which setup they use before starting anything.

Starting a server is long-running and uses ports. Ask the developer before doing it, and stop it when you're done.

## Verifying a change end to end

1. `./mvnw verify` succeeds.
2. `bash RUN_SyncDBDev.sh` applies the ticket's migration scripts without errors (if there are any).
3. Relevant unit tests pass (`idempiere-unit-tests`).
4. For UI or behavior changes, the developer (or you, if you can drive a browser) tests the scenario in the running web UI with GardenWorld data, including at least one non-happy path.
5. Report exactly which of these steps ran and what the result was.
