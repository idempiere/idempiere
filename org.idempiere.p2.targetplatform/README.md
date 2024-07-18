#How to Update Target Plaform
* Install Target Platform DSL Editor from https://github.com/eclipse-cbi/targetplatform-dsl
* Update maven.locations.xml (if needed)
* Update org.idempiere.p2.targetplatform.tpd. Target name is of format idempiere-{version} (for e.g idempiere-12)
* Turn off Project > Build Automatically
* Right click on org.idempiere.p2.targetplatform.tpd and select "Create Target Definition File"
* Open the updated org.idempiere.p2.targetplatform.target, switch to Source tab and copy location entries from maven.locations.xml
* Use current date (with format yyyymmdd) as sequenceNumber of org.idempiere.p2.targetplatform.target (for e.g 20240215)
* Switch back to Definition tab and wait for resolution of the target plaform. Check target platform state to verify there's no unresolve plugins except the platform launcher fragment (select "Show only unresolved plug-ins"). If resolution of target platform is very slow, you can try "rm .metadata/.plugins/org.eclipse.pde.core/.p2/org.eclipse.equinox.p2.engine/.settings/org.eclipse.equinox.p2.artifact.repository.prefs" (run at the root of your workspace folder) to speed it up.
* If there are update to embedded jars or there are new embedded jars to download, quit Eclipse, remove the embedded jars and execute "mvn clean validate"
* Reload target platform
* Turn on Project > Build Automatically
* If there are features that give missing plugin warnings, try "Clean all projects" and rebuild the whole workspace
* If necessary, update server.product (in org.idempiere.p2 and org.adempiere.server.feature), org.idempiere.eclipse.platform.feature/feature.xml and org.adempiere.server.feature/feature.xml
* If necessary, update org.idempiere.server.feature/setup/configuration/config.ini and org.idempiere.equinox.p2.feature/director/configuration/config.ini
* Validate all Eclipse application launch configuration is working.
* Validate unit test launch configuration is working.
* Validate application created by mvn verify is working as expected.
* Validate unit test can be completed successfully using maven (mvn verify -DskipTests=false).
* If necessary, update name and "idempiere.target.platform" setup task in utils_dev/oomph/idempiere.setup

#Auto generation of local mirror
* A local mirror of org.idempiere.p2.targetplatform.target is auto generated at target/target-platform-repository

#Usage of files
* org.idempiere.p2.targetplatform.tpd - to generate org.idempiere.p2.targetplatform.target
* org.idempiere.p2.targetplatform.target - iDempiere target platform definition
* org.idempiere.p2.targetplatform.mirror.target - target platform definition for the local mirror of org.idempiere.p2.targetplatform.target at target/target-platform-repository
* maven.locations.xml - list of maven artifacts location to be appended to the end of the generated org.idempiere.p2.targetplatform.target
