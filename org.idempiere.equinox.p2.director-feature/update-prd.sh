#!/bin/sh
#

cd "$(dirname "${0}")" || (echo "Cannot cd"; exit 1)
DESTINATION=$(pwd)

VMOPTS="-Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true"
java "$VMOPTS" -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination "$DESTINATION" -repository "$1" -u "$2"
java "$VMOPTS" -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination "$DESTINATION" -repository "$1" -i "$2"
