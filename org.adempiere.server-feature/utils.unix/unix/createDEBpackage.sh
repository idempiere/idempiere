TMP=/tmp
cd `dirname $0`/../../..
IDEMPIERE_HOME=`pwd`
RWD=$IDEMPIERE_HOME/idempiere-server/utils/unix
PACKAGE=`ls -d $IDEMPIERE_HOME`
PACKAGE=`basename $PACKAGE`
# VERSION=dev
# TIMESTAMP=`date +%Y%m%d`
# PACKFILE=$IDEMPIERE_HOME/../${PACKAGE}_${VERSION}_${TIMESTAMP}.deb
PACKFILE=$IDEMPIERE_HOME/../${PACKAGE}.deb
find $RWD/../.. -name "*.sh" -exec chmod +x {} \;
chmod +x $RWD/DebianInstaller/etc/init.d/idempiere
rm -f $TMP/debian-binary $TMP/control.tar.gz $TMP/data.tar.gz $TMP/control.tar $TMP/data.tar $PACKFILE
echo 2.0 > $TMP/debian-binary
tar cvf $TMP/control.tar -C $RWD/DebianInstaller/DEBIAN .
gzip -v -9 $TMP/control.tar
tar cvf $TMP/data.tar -C $RWD/DebianInstaller/ ./usr
tar rvf $TMP/data.tar --exclude='idempiere.gtk.linux.x86_64/idempiere-server/utils/unix/createDEBpackage.sh' --exclude='idempiere.gtk.linux.x86_64/idempiere-server/utils/unix/DebianInstaller' --transform 's:^idempiere.gtk.linux.x86_64/idempiere-server:./opt/idempiere-server:' -C $RWD/../../../.. $PACKAGE > /dev/null
tar rvf $TMP/data.tar -C $RWD/DebianInstaller/ ./etc
gzip -v -9 $TMP/data.tar
cd $TMP
ar q $PACKFILE debian-binary control.tar.gz data.tar.gz
rm debian-binary control.tar.gz data.tar.gz
echo "Created $PACKFILE"
