package us.mn.state.dot.testSectionTracking
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

import org.codehaus.groovy.grails.commons.GrailsApplication
import grails.util.GrailsUtil
import us.mn.state.dot.testSectionTracking.AppConfig
//import groovy.sql.Sql

/**
 * Created by IntelliJ IDEA.
 * User: carr1den
 * Date: Jul 30, 2009
 * Time: 7:55:36 AM
 * To change this template use File | Settings | File Templates.
 */
public class MrUtils {

  static List attrsList(String cls, String attrName) {
    def ml = []
    AppConfig ac = AppConfig.findByNameAndParameter( cls, attrName)
    if (ac) {
      String al = ac.val
    boolean hasCommas = al.contains('\\,')
    if (al.startsWith("[") && al.endsWith("]"))  {
      al = al.substring(1, al.size()-1) // strip off the "[" and "]" from the ends
    }
    if (hasCommas) {
      al = al.replace('\\,','^')
    }
    al.split(",").each {
      ml.add(it)
    }
    if (hasCommas) {
      ml = ml.collect {it.replace('^',',')} 
      }
    }
    return ml
  }

  static def plotClasses() {
    def m = [] as Set
    m.add("AnnotatedTimeLine")
    m.add("ScatterPlot")
    return m
  }

  static def pickListClasses() {
    def m = [] as Set
    def r = AppConfig.findAll()
    r.each   {
      m.add(it.name)
    }
    return m
  }

  static String grailsEnvironment() {
    String env = "envUnknown"
//check if production
    if ( GrailsUtil.getEnvironment().equals(GrailsApplication.ENV_PRODUCTION))
      {env="production"}
//check if development
    else if ( GrailsUtil.getEnvironment().equals(GrailsApplication.ENV_DEVELOPMENT))
      {env="development"}
//check if testing
    else if ( GrailsUtil.getEnvironment().equals(GrailsApplication.ENV_TEST) )
      {env="test"}
    return env
  }
}