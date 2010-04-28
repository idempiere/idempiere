#!/bin/sh

export ANT_OPTS="-Xms128m -Xmx512m -Dworkspace=`pwd`/.."

ANT4ECLIPSE=../tools/lib/ant4eclipse/
ANT4OSGI=../equinox-target/org.eclipse.osgi_3.5.0.v20090520.jar

ant -Dplugin=$1 -lib $ANT4ECLIPSE -lib $ANT4OSGI -lib ../tools/lib/ant-contrib-1.0b1.jar plugin
