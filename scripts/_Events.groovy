import java.text.SimpleDateFormat
import grails.util.Environment

eventCompileStart = { kind ->
	def buildNumber = metadata.'app.buildNumber'
 
	if (!buildNumber)
		buildNumber = 1
	else
		buildNumber = Integer.valueOf(buildNumber) + 1
 
	metadata.'app.buildNumber' = buildNumber.toString()
 
	def formatter = new SimpleDateFormat("MMM dd, yyyy")
	def buildDate = formatter.format(new Date(System.currentTimeMillis()))
	metadata.'app.buildDate' = buildDate
	metadata.'app.buildProfile' = grailsEnv
	
	metadata.persist()
 
	println "**** Compile Starting on Build #${buildNumber}"
}

eventWebXmlStart = { webXmlFile ->
    if(Environment.current == Environment.PRODUCTION) {
      def prodWebXmlFile = new File(projectWorkDir, webXmlFile)
      def jndiName = ""
      jndiName = 'jdbc/prod_mnr'
      ant.echo message: "Change jndi-res-ref-name ${jndiName} for web.xml"
      ant.replace(file: prodWebXmlFile, token: "@jndi-res-ref-name@",
                    value: jndiName.toString())
    }
    else if(Environment.current == Environment.TEST) {
      def testWebXmlFile = new File(projectWorkDir, webXmlFile)
      def jndiName = ""
      jndiName = 'jdbc/test_mnr'
      ant.echo message: "Change jndi-res-ref-name ${jndiName} for web.xml"
      ant.replace(file: testWebXmlFile, token: "@jndi-res-ref-name@",
                    value: jndiName.toString())
    }
}

