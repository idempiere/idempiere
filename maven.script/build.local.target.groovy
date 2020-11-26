// http://groovy.github.io/gmaven/groovy-maven-plugin/variables.html
// https://groovy.github.io/GMavenPlus/execute-mojo.html
// https://github.com/groovy/GMavenPlus/issues/72

/**
1. properties from command line (-DpropertiesName) access thru session.userProperties['propertiseName']
2. properties declare on pom file (project propertiese) access thru project.properties['propertiseName']

on pom when reference ${propertiesName} then maven first check on commandline, after that pom properties

on groovy script it up to value of bellow configuration 
bindAllProjectProperties, bindAllSessionUserProperties, bindPropertiesToSeparateVariables, bindSessionUserOverrideProperties

3. on gmavenplus-plugin if we declare propertise by use configuration area as bellow (plugin properties) then that properties become script variable by default
refer:https://groovy.github.io/GMavenPlus/execute-mojo.html#bindPropertiesToSeparateVariables
	<configuration>
        <properties>
          <property>
            <name>someProp</name>
            <value>abc</value>
          </property>
        </properties>
    </configuration>
in case set bindPropertiesToSeparateVariables=false then that propertise need to access by properties["propertieseName"]

3. bindAllProjectProperties=true then all project propertiese auto become plugin propertise (overrider plugin propertiese if same name)
https://groovy.github.io/GMavenPlus/execute-mojo.html#bindAllProjectProperties

4. bindAllSessionUserProperties = true then all session propertiese become plugin propertise (overrider project propertiese and plugin propertiese if same name)
https://groovy.github.io/GMavenPlus/execute-mojo.html#bindAllSessionUserProperties

5. bindSessionUserOverrideProperties not bring all, just only propertise exists on project to overide it
https://groovy.github.io/GMavenPlus/execute-mojo.html#bindSessionUserOverrideProperties

bind properties to separate variables look helpful when can use propertiese as varialbe on script
but i don't prefer it because when propertise isn't declare on any scope (plugin, project, session) then it make script invalidate (can't run, make exception on maven)
can't use check null to detect propertise is exists or not

so i prefer access propertiese thru scope variale (project.propertiese, session.userProperties)
to get session overide project, i use bellow function
solution take from:https://stackoverflow.com/questions/43372391/gmavenplus-how-to-get-maven-property-value-in-script-executed-by-gmavenplus-pl
**/
String getPropertyValue(String name) {
    def value = session.userProperties[name]
    if (value != null) return value //property was defined from command line e.g.: -DpropertyName=value
    return project.properties[name]
}

boolean existsFile(File dir, String fileName, boolean isDir) {
	File testFile = new File (dir, fileName)
	return testFile.exists() && (testFile.isDirectory() == isDir)
}

boolean isRepository(File repositoryDir) {
	return existsFile (repositoryDir, "features", true) && existsFile (repositoryDir, "plugins", true) && existsFile (repositoryDir, "binary", true)
			&& existsFile (repositoryDir, "artifacts.jar", false) && existsFile (repositoryDir, "content.jar", false)
}

def localRepositoryPath = getPropertyValue('repositoryPath')
if (localRepositoryPath == null){
	localRepositoryPath = session.getExecutionRootDirectory() + "/localRepository"
}

def reposDevDir = new File(localRepositoryPath)

println ">> param repositoryPath:" + getPropertyValue('repositoryPath')
println ">> repositoryPath:" + reposDevDir.getAbsolutePath()

def forceUpdateRespository = false
if (getPropertyValue('updateRepository') != null)
	forceUpdateRespository = getPropertyValue('updateRepository') == 'true'

def forceGenerate = false
if (getPropertyValue('generateTarget') != null)
	forceGenerate = getPropertyValue('generateTarget') == 'true'

println ">> param updateRepository:" + getPropertyValue('updateRepository')
println ">> updateRepository:" + forceUpdateRespository

def targetPluginPath = session.getExecutionRootDirectory() + "/org.idempiere.p2.targetplatform"
def templateTargetLocalPath = targetPluginPath + "/org.idempiere.p2.targetplatformlocal.template.tpd"
def tpdLocalPath = targetPluginPath + "/org.idempiere.p2.targetplatformlocal.tpd"
def targetLocalPath = targetPluginPath + "/org.idempiere.p2.targetplatformlocal.target"
if (!isRepository(reposDevDir) || forceUpdateRespository){

	// need to delete old one, otherwise bundle from idempiere make it bigger and bigger
	ant.sequential{
		delete(dir: reposDevDir.getAbsolutePath() + "/features")
		delete(dir: reposDevDir.getAbsolutePath() + "/plugins")
		delete(dir: reposDevDir.getAbsolutePath() + "/binary")
		delete(file: reposDevDir.getAbsolutePath() + "/artifacts.jar")
		delete(file: reposDevDir.getAbsolutePath() + "/content.jar")
	}

	// run on project org.idempiere.p2
	def reposOutputDir = new File (project.build.directory, "repository")

	ant.sequential {
	    mkdir(dir: reposDevDir.getAbsolutePath())
	    copy(todir: reposDevDir, overwrite:"true") {
	        fileset(dir: reposOutputDir.getAbsolutePath())
	    }

	    copy(file: templateTargetLocalPath, tofile:tpdLocalPath, overwrite:"true")
	    replace(file:tpdLocalPath, token:"@localRepository@", value:"file:/" + reposDevDir.getAbsolutePath())
	}

	println ">> copy folder = " + reposOutputDir.getAbsolutePath()
	println " to " + reposDevDir.getAbsolutePath()

	forceGenerate = true // re-generate target when repository update
	//ant.ReplaceRegExp(file:tpdLocalPath, match:"location\\s+\"[^\"]+\"\\s+{", replace:"location \"file:/" + reposDevDir.getAbsolutePath() + "\" {", byline:"true")
}

def devTargetFile = new File(targetPluginPath + "/org.idempiere.p2.targetplatformlocal.target")

if (!devTargetFile.exists() || !devTargetFile.isFile() || forceGenerate || forceUpdateRespository)
	project.properties.setProperty("skipGenerateTarget", "false")
else{
	project.properties.setProperty("skipGenerateTarget", "true")
}

project.properties.setProperty("targetLocalPath", targetLocalPath)
project.properties.setProperty("tpdLocalPath", tpdLocalPath)


ant.echo ("targetLocalPath:" + targetLocalPath)