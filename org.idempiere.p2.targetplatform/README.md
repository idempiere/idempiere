#How to Update Target Plaform
* Install Target Platform DSL Editor from https://github.com/eclipse-cbi/targetplatform-dsl
* Update maven.locations.xml (if needed)
* Update org.idempiere.p2.targetplatform.tpd. Note that even if there's only update to maven.locations.xml, you should at minimum update the target timestamp (format is idempiere-yymmdd) value.
* Turn off Project > Build Automatically
* Right click on org.idempiere.p2.targetplatform.tpd and select "Create Target Definition File"
* Open the updated org.idempiere.p2.targetplatform.target, switch to Source tab and copy location entries from maven.locations.xml
* Switch back to Definition tab and wait for resolution of the target plaform. Check target platform state to verify there's no unresolve plugins except the platform launcher fragment (select "Show only unresolved plug-ins"). If resolution of target platform is very slow, you can try "rm .metadata/.plugins/org.eclipse.pde.core/.p2/org.eclipse.equinox.p2.engine/.settings/org.eclipse.equinox.p2.artifact.repository.prefs" (run at the root of your workspace folder) to speed it up.
* If there are update to embedded jars, quit Eclipse, remove the embedded jars and execute "mvn clean verify -U"
* Reload target platform
* Turn on Project > Build Automatically
* If there are features that give missing plugin warnings, try "Clean all projects" and rebuild the whole workspace
* If necessary, update server.product (in org.idempiere.p2 and org.adempiere.server.feature), org.idempiere.eclipse.platform.feature/feature.xml and org.adempiere.server.feature/feature.xml
* If necessary, update org.idempiere.server.feature/setup/configuration/config.ini and org.idempiere.equinox.p2.feature/director/configuration/config.ini
* Validate all Eclipse application launch configuration is working.
* Validate unit test launch configuration is working.
* Validate application created by mvn verify is working as expected.
* Update org.idempiere.p2.repository.target - open in target editor, switch to Content tab and update the list of selected bundle.
* Update org.idempiere.p2.targetplatform.mirror.feature/feature.xml (Follow instructions in org.idempiere.p2.targetplatform.mirror.feature).
* Update name and "idempiere.target.platform" setup task in utils_dev/oomph/idempiere.setup

