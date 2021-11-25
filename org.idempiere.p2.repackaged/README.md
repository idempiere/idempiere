# repackage osgi bundles
Repackage osgi bundles to fix MANIFEST.MF issues

##Usage:
* mvn verify
* Create a new version folder at binary.file/p2.repackaged, for e.g 9.0.0. Copy all files at target/repository to the newly created folder.
* Add, commit and push the files added to binary.file/p2.repackaged.
* To update, just remove everything at binary.file/p2.repackaged (for e.g, binary.file/p2.repackaged/9.0.0) and copy latest output contents from target repository.

##Bundles:
* org.atmosphere:atmosphere-runtime:2.7.2
  * Make all Import-Package optional. This remove dependency that iDempiere doesn't use.
* jakarta.xml.ws:jakarta.xml.ws-api:2.3.3
  * Remove Private-Package header and do not re-import exported packages. Fix access restriction issue.
* com.sun.xml.fastinfoset:FastInfoset:1.2.18
  * Do not re-import exported packages. Fix version conflict with FastInfoset 2.
* org.apache.felix:org.apache.felix.webconsole:4.6.4
  * Remove version constraint from Import-Package of javax.servlet.*. This make it run under Servlet 4.
* com.google.guava:guava:30.1.1-jre
  * Remove version constraint from Import-Package of javax.annotation. This remove depency to org.jsr305 that iDempeire doesn't use and causes conflict with jakarta.annotation bundle.
* com.google.http-client:google-http-client:1.39.2-sp.1
  * Remove version constraint from Import-Package of javax.annotation. This remove depency to org.jsr305 that iDempeire doesn't use and causes conflict with jakarta.annotation bundle.
* org.apache.poi:poi-ooxml-schemas:4.1.2
  * Add missing org.apache.xmlbeans.impl.schema Import-Package.
