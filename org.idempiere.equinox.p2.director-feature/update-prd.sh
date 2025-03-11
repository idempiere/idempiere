#!/bin/sh

# This script uninstall and reinstall a feature from a P2 repository
# Usage:
#   update-prd.sh p2Repository feature
# for example:
#   update-prd.sh https://jenkins.idempiere.org/job/idempiere-rest/ws/com.trekglobal.idempiere.extensions.p2/target/repository/ com.trekglobal.idempiere.rest.api

cd "$(dirname "${0}")" || (echo "Cannot cd"; exit 1)
DESTINATION=$(pwd)

VMOPTS="-Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true"
java "$VMOPTS" -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination "$DESTINATION" -repository "$1" -u "$2"
java "$VMOPTS" -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination "$DESTINATION" -repository "$1" -i "$2"
