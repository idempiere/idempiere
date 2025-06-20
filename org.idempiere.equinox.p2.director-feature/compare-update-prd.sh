#!/bin/sh

# This script uninstall if required and install a new version of a feature from a P2 repository
# Usage:
#   compare-update-prd.sh p2Repository plugin feature
#  the plugin must be one of the plugins included in the feature and is required to compare the version to check if it needs update or not
# for example:
#   compare-update-prd.sh https://jenkins.idempiere.org/job/idempiere-rest/ws/com.trekglobal.idempiere.extensions.p2/target/repository/ com.trekglobal.idempiere.rest.api com.trekglobal.idempiere.rest.api

cd "$(dirname "${0}")" || (echo "Cannot cd"; exit 1)
DESTINATION=$(pwd)

VMOPTS="-Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true"

output=$(java "$VMOPTS" -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -repository "$1" -list "$2" | grep "$2=")

# Check if the line was found
if [ -n "$output" ]; then
  # Extract the version and name using cut
  version=$(echo "$output" | cut -d'=' -f2)
  name=$(echo "$output" | cut -d'=' -f1)

  # Construct jar file name
  jarfile="${name}_${version}.jar"
  jarfolder="${name}_${version}"

  if [ -f "$DESTINATION/plugins/$jarfile" ] || [ -d "$DESTINATION/plugins/$jarfolder" ] ; then
      echo "No new version from repository"
  else
      if stat -t "$DESTINATION/plugins/$name"_* > /dev/null; then
        echo "Updating plugin"
        java "$VMOPTS" -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination "$DESTINATION" -repository "$1" -u "$3" -i "$3"
      else
        echo "Installing plugin"
        java "$VMOPTS" -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination "$DESTINATION" -repository "$1" -i "$3"
      fi
  fi
else
  echo "Invalid repository: $1"
fi
