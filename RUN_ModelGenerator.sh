#!/bin/bash
# Cross-platform compatibility (macOS and Linux)

# Determine the OS and set appropriate readlink command
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v greadlink >/dev/null 2>&1; then
        READLINK_CMD="greadlink"
    else
        echo "The 'greadlink' command is not installed. Install it with 'brew install coreutils'."
        exit 1
    fi
else
    # Linux
    READLINK_CMD="readlink"
fi

# Set IDEMPIERE_HOME using the appropriate readlink command
IDEMPIERE_HOME=$( dirname "$($READLINK_CMD -f "${BASH_SOURCE[0]}")" )

if [ "$#" -eq 0 ] || [ "$1" = "-h" ]; then
    echo "
Usage: ${BASH_SOURCE[0]} [property_file] generator_arguments
Runs the model generator without Eclipse and without the Swing dialog, for scripts and builds.
The generator arguments are the ones of the command line of the model generator, either
  folder packageName tableEntityType tableName [columnEntityType]
or the named form
  --folder=DIR --package=PKG --tables=NAMES [--table-entity-type=ET] [--column-entity-type=ET] [--output=interface,class,accessor]
  [--suffix=XYZ] [--columns=A,B] [--template=NAME] [--check] [--write-launch=FILE] ...
Call it with --help to see the full description of the generator arguments.
Relative folders are relative to the folder you call the script from.

It needs the server product built with ./mvnw verify, in $IDEMPIERE_HOME/org.idempiere.p2/target/products/org.adempiere.server.product
(set PRODUCT_DIR to use another folder), and a database connection:
  - without a property_file it uses $IDEMPIERE_HOME/idempiere.properties, which requires that install.app or install.console.app
    has been previously executed in Eclipse;
  - if the first parameter is a file, the script uses that properties file instead.
The product needs the database password: if its folder has no .idpass and no idempiereEnv.properties, the script links the ones of
$IDEMPIERE_HOME (also created by install.app).

The exit code is 0 when the generator succeeded, 1 when it refused the call, failed, or --check found a difference.
The generator prints about 200 lines of framework log, so the script shows only the lines of the generator, the last one being
  result: ok | refused | error | differs
After a failure the complete output is kept in /tmp/ModelGenerator_out.<random>. Set MODELGEN_VERBOSE=Y to show all of it.
Set MODELGEN_READ_ONLY=Y to open the database session read-only (PostgreSQL); the first start of a database whose AD_System
differs from this connection needs a writable session.
When called without parameters or with parameter -h, it prints this help message."
    exit 0
fi

PROPFILE=""
if [ -f "$1" ] && [ -s "$1" ]; then
    PROPFILE="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
    shift
fi

if [ -z "$PROPFILE" ]; then
    if [ -s "$IDEMPIERE_HOME/idempiere.properties" ]; then
        PROPFILE="$IDEMPIERE_HOME/idempiere.properties"
    fi
fi

if [ -z "$PROPFILE" ]; then
    echo "There is no idempiere.properties in folder $IDEMPIERE_HOME.
Please run install.app or install.console.app within Eclipse first."
    exit 1
fi

# Find the server product
if [ -z "$PRODUCT_DIR" ]; then
    PRODUCTS="$IDEMPIERE_HOME/org.idempiere.p2/target/products/org.adempiere.server.product"
    case "$(uname -s)" in
        Darwin) PRODUCT_DIR="$PRODUCTS/macosx/cocoa/x86_64/Eclipse.app/Contents/Eclipse" ;;
        Linux) PRODUCT_DIR="$PRODUCTS/linux/gtk/x86_64" ;;
        *) PRODUCT_DIR="$PRODUCTS/win32/win32/x86_64" ;;
    esac
fi

LAUNCHER=""
for jar in "$PRODUCT_DIR"/plugins/org.eclipse.equinox.launcher_1.*.jar; do
    [ -f "$jar" ] && LAUNCHER="$jar"
done
if [ -z "$LAUNCHER" ]; then
    echo "There is no server product in $PRODUCT_DIR.
Please build it first with ./mvnw verify (or set PRODUCT_DIR)."
    exit 1
fi

# The product reads the database password through its own utils/getVar.sh, from .idpass or idempiereEnv.properties
for f in .idpass idempiereEnv.properties; do
    if [ ! -e "$PRODUCT_DIR/$f" ] && [ -f "$IDEMPIERE_HOME/$f" ]; then
        echo "Linking $IDEMPIERE_HOME/$f into $PRODUCT_DIR"
        ln -s "$IDEMPIERE_HOME/$f" "$PRODUCT_DIR/$f"
    fi
done
if [ ! -e "$PRODUCT_DIR/.idpass" ] && [ ! -e "$PRODUCT_DIR/idempiereEnv.properties" ]; then
    echo "Neither .idpass nor idempiereEnv.properties exists in $PRODUCT_DIR or in $IDEMPIERE_HOME.
Please run install.app or install.console.app within Eclipse first, or the silent-setup-alt.sh of the product."
    exit 1
fi

if [ -n "$JAVA_HOME" ]; then
    JAVA="$JAVA_HOME/bin/java"
else
    JAVA=java
fi

DB_OPTS=""
if [ "$MODELGEN_READ_ONLY" = "Y" ]; then
    DB_OPTS="-Dorg.idempiere.postgresql.URLParameters=options=-c%20default_transaction_read_only=on"
fi

LOG="$(mktemp /tmp/ModelGenerator_out.XXXXXX)"

# the product finds its utils folder (database password) from IDEMPIERE_HOME, otherwise from the current folder
IDEMPIERE_HOME="$PRODUCT_DIR" "$JAVA" \
    --add-modules java.se \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    --add-opens java.base/java.nio=ALL-UNNAMED \
    --add-opens java.base/sun.nio.ch=ALL-UNNAMED \
    --add-opens java.management/sun.management=ALL-UNNAMED \
    --add-opens jdk.management/com.sun.management.internal=ALL-UNNAMED \
    --add-exports java.base/jdk.internal.ref=ALL-UNNAMED \
    --add-exports java.desktop/sun.awt=ALL-UNNAMED \
    --add-exports java.sql.rowset/com.sun.rowset=ALL-UNNAMED \
    --add-exports java.naming/com.sun.jndi.ldap=ALL-UNNAMED \
    -Djava.awt.headless=true \
    -Dosgi.noShutdown=false \
    -Dorg.osgi.framework.bootdelegation=sun.security.ssl \
    -Dosgi.compatibility.bootdelegation=true \
    -DIDEMPIERE_HOME="$PRODUCT_DIR" \
    -DPropertyFile="$PROPFILE" \
    $DB_OPTS \
    -jar "$LAUNCHER" -application org.adempiere.base.ModelGeneratorApplication -noSplash "$@" > "$LOG" 2>&1
RC=$?

if [ "$MODELGEN_VERBOSE" = "Y" ]; then
    cat "$LOG"
else
    # only the lines of the generator: the usage text and its messages, generated files, check results and the closing result line
    awk '
        /^usage:/ { usage = 1 }
        usage { print; if ($0 ~ /^  Exit code/) usage = 0; next }
        /^(REFUSED|WARNING|ERROR|No data found|differs|missing|check:|launch written|result:|Launch template|Generate Model Template|Unknown argument|Missing:|Positional form|--[a-z=-]+ (writes|needs|may|takes))/ { print; next }
        /\.java - / { print }
    ' "$LOG"
    if ! grep -q "^result:" "$LOG" && [ "$RC" -ne 0 ]; then
        echo "The generator did not finish; the last lines of the log:"
        tail -n 30 "$LOG"
    fi
fi
if [ "$RC" -ne 0 ]; then
    echo "Complete output: $LOG"
else
    rm -f "$LOG"
fi
exit $RC
