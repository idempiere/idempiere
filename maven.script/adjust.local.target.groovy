String getPropertyValue(String name) {
    def value = session.userProperties[name]
    if (value != null) return value //property was defined from command line e.g.: -DpropertyName=value
    return project.properties[name]
}

ant.echo ("skipGenerateTarget:" + getPropertyValue("skipGenerateTarget"))
ant.echo ("targetLocalPath:" + getPropertyValue("targetLocalPath"))

if (getPropertyValue("skipGenerateTarget") != "true"){
	def targetLocalPath = getPropertyValue("targetLocalPath")
	ant.sequential {
		echo "targetLocalPath:" + targetLocalPath
	    replace(file:targetLocalPath, token:"<unit id=\"javax.validation.api\" version=\"1.1.0.Final\"/>"){
	    	replacevalue("<unit id=\"javax.validation.api\" version=\"1.1.0.Final\"/>\n      <unit id=\"javax.validation.api\" version=\"2.0.1.Final\"/>")
	    }
	}
}