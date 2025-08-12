#!/bin/sh
#
# $Id: RUN_ImportIdempiere.sh,v 1.9 2005/01/22 21:59:15 jjanke Exp $

if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh
echo Import idempiere - "$IDEMPIERE_HOME" \("$ADEMPIERE_DB_NAME"\)

if [ -z "$ADEMPIERE_DB_SYSTEM_USER" ]; then
    if [ "$ADEMPIERE_DB_PATH" = "postgresql" ]; then
        ADEMPIERE_DB_SYSTEM_USER=postgres
    else
        ADEMPIERE_DB_SYSTEM_USER=SYSTEM
    fi
fi

SUFFIX=""
if [ "$ADEMPIERE_DB_PATH" = "postgresql" ]; then
    SUFFIX="_pg"
fi

echo Re-Create idempiere User and import "$IDEMPIERE_HOME"/data/seed/Adempiere${SUFFIX}.dmp - \("$ADEMPIERE_DB_NAME"\)
echo "== The import will show warnings. This is OK =="
cd "$IDEMPIERE_HOME"/data/seed || exit
jar xvf Adempiere${SUFFIX}.jar
cd "$IDEMPIERE_HOME"/utils || exit
ls -lsa "$IDEMPIERE_HOME"/data/seed/Adempiere${SUFFIX}.dmp
echo Press enter to continue ...
read -r _

# Parameter: <adempiereID> <adempierePwd> <systemUser> <systemPwd> <dmpSuffix>
"$ADEMPIERE_DB_PATH"/ImportIdempiere.sh "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_SYSTEM_USER" "$ADEMPIERE_DB_SYSTEM" "$SUFFIX"

./RUN_SyncDB.sh

cd ..
./sign-database-build-alt.sh
