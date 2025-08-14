#!/bin/sh
#
# $Id: RUN_ImportReference.sh,v 1.11 2005/12/13 00:17:54 jjanke Exp $

if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh
echo Import Reference - "$IDEMPIERE_HOME" \("$ADEMPIERE_DB_NAME"\)

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

echo Re-Create Reference User and import "$IDEMPIERE_HOME"/data/seed/Adempiere.dmp - \("$ADEMPIERE_DB_NAME"\)
echo "== The import will show warnings. This is OK =="
cd "$IDEMPIERE_HOME"/data/seed || exit
jar xvf Adempiere${SUFFIX}.jar
cd "$IDEMPIERE_HOME"/utils || exit
ls -lsa "$IDEMPIERE_HOME"/data/seed/Adempiere${SUFFIX}.dmp
echo Press enter to continue ...
read -r _

# Parameter: <adempiereID> <adempierePwd> <systemUser> <systemPwd>
sh "$ADEMPIERE_DB_PATH"/ImportIdempiere.sh reference reference "$ADEMPIERE_DB_SYSTEM_USER" "$ADEMPIERE_DB_SYSTEM"
