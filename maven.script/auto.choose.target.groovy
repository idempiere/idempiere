// not yet use this script by https://github.com/eclipse-cbi/targetplatform-dsl/issues/73

def targetDevPath = session.getExecutionRootDirectory() + "/org.idempiere.p2.targetplatform" + "/org.idempiere.p2.targetplatform.dev.target"
def targetDevFile = new File(targetDevPath)



def targetCmd = session.userProperties["idempiere.target"]
// target select by command line -Didempiere.target
if (targetCmd == null && targetDevFile.exists() && targetDevFile.isFile()){
	// choose dev file in exists
	project.properties.setProperty("targetFileSelection", "org.idempiere.p2.targetplatform.dev.target");
}else if (targetCmd == null){
	// choose default file
	project.properties.setProperty("targetFileSelection", "org.idempiere.p2.targetplatform.target");
}
//targetCmd != null then do nothing, just follow target plugin
