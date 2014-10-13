#!/bin/sh
#

java -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true $*

