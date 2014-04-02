#!/bin/sh
#

java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar plugins/org.eclipse.osgi_3.9.*.jar -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true $*

