/*
 * Copyright 2009 Minnesota Department of Transportation
 * Author(s): Dennis Carroll
 *
 * This file is part of TestSectionTracking.
 * 
 * TestSectionTracking is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * TestSectionTracking is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with TestSectionTracking.  If not, see <http://www.gnu.org/licenses/>.
 */
import org.codehaus.groovy.grails.commons.ApplicationHolder
import grails.util.GrailsUtil
import grails.util.Environment

class BootStrap {

     def grailsApplication

     def init = { servletContext ->
       def env = GrailsUtil.getEnvironment().toString()
       if (env.toUpperCase() == Environment.PRODUCTION.toString())
         servletContext["dbenv"] = "Production"
       else if (env.toUpperCase() == Environment.TEST.toString())
         servletContext["dbenv"] = "Test"
       else if (env.toUpperCase() == Environment.DEVELOPMENT.toString())
         servletContext["dbenv"] = "Development"
       grailsApplication.applicationMeta.put("app.environment",env)
       servletContext["grailsVersion"] = ApplicationHolder.application.metadata['app.grails.version']
     }

     def destroy = {
     }
} 