#How to Update Target Plaform
* Install Target Platform DSL Editor from https://github.com/eclipse-cbi/targetplatform-dsl
* Update maven.locations.xml (if needed)
* Update org.idempiere.p2.targetplatform.tpd. Note that even if there's only update to maven.locations.xml, you should at minimum update the target timestamp (format is idempiere-yymmdd) value.
* Turn off Project > Build Automatically
* Right click on org.idempiere.p2.targetplatform.tpd and select "Create Target Definition File"
* Open the updated org.idempiere.p2.targetplatform.target, switch to Source tab and copy location entries from maven.locations.xml
* Switch back to Definition tab and wait for resolution of the target plaform. Check target platform state to verify there's no unresolve plugins except the platform launcher fragment (select "Show only unresolved plug-ins")
* If there are update to embedded jars, quit Eclipse, remove the embedded jars and execute "mvn clean verify -U"
* Reload target platform
* Turn on Project > Build Automatically
* If there are features that give missing plugin warnings, try "Clean all projects" and rebuild the whole workspace

