#!/bin/sh
#

cd $(dirname "${0}")
DESTINATION=$(pwd)

VMOPTS="-Declipse.log.level=ALL -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true"

INSTALL_UI="$2"
UNINSTALL_UI="$2"
if [ -n "$3" ]; then
	# case update org.adempiere.server.product, install and un-install is difference 
	UNINSTALL_UI="$3"
fi
java $VMOPTS -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination $DESTINATION -repository $1 -u "$UNINSTALL_UI"
java $VMOPTS -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination $DESTINATION -repository $1 -i "$INSTALL_UI"