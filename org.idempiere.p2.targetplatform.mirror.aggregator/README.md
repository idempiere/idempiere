# How to Create iDempiere Target Platform Mirror
* With following layout:
  * {workspace}/idempiere/pom.xml
  * {workspace}/idempiere/org.adempiere.base
  * {workspace}/idempiere/org.idempiere.p2.targetplatform.mirror
  * {workspace}/idempiere/org.idempiere.p2.targetplatform.mirror.feature
  * {workspace}/idempiere/org.idempiere.p2.targetplatform.mirror.aggregator
  * ...
* At {workspace}/idempiere, run "mvn verify"
* At {workspace}/idempiere/org.idempiere.p2.targetplatform.mirror.aggregator, run "mvn verify"
* Mirror repository will be created at {workspace}/org.idempiere.p2.targetplatform.mirror/target/repository
* Archive of mirror repository will be created at {workspace}/org.idempiere.p2.targetplatform.mirror with name org.idempiere.p2.targetplatform.mirror-{version}-SNAPSHOT.zip
  (replace {version} with current version of the build, for e.g 10.0.0)
* The generated mirror repository can be used as folder base target platform for development work
