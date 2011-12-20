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
// Added for the export plugin
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import us.mn.state.dot.testSectionTracking.MrUtils

class TestSectionController {
// this is the ID list for Gmap balloon markers
    def alpha = [
        'A','B','C','D','E','F','G','H','I','J',
        'K','L','M','N','O','P','Q','R','S','T',
        'U','V','W','X','Y','Z','1','2','3','4',
        '5','6','7','8','9','a','b','c','d','e',
        'f','g','h','i','j','k','l','m','n','o',
        'p','q','r','s','t','u','v','w','x','y','z'
      ]
    def index = {
      redirect(action:list,params:params)
    }

    // the delete, save and update actions only accept POST requests
    static def allowedMethods = [delete:'POST', save:'POST', update:'POST']

      def list = {
        if(!params.max) params.max = 10
        [ testSectionInstanceList: TestSection.list( params ) ]
      }

    def exportService
    def testSectionService
    def searchableService

    def listSelected = {

        if (!session[controllerName]) session[controllerName] = [:]
        if (!session[controllerName]?.max) session[controllerName].max = 10
        if (!session[controllerName]?.offset) session[controllerName].offset = 0
        if (!session[controllerName]?.sort) session[controllerName].sort = "id"
        if (!session[controllerName]?.order) session[controllerName].order = "asc"
        if (!session[controllerName]?.searchColumn) session[controllerName].searchColumn = ""
        if (!session[controllerName]?.searchValue) session[controllerName].searchValue = ""
        if (!session[controllerName]?.query) session[controllerName].query = ""
        if (!session[controllerName].method) session[controllerName].method = ""
        if (!session[controllerName].word) session[controllerName].word = ""

        def iquery = ((params.query != null)&&(params.query != ''))
        def ival = ((params.searchValue != null)&&(params.searchValue != ''))

        params.max = session[controllerName].max = params.max ?: session[controllerName].max
        params.offset = session[controllerName].offset = params.offset ?: session[controllerName].offset
        if (params.searchColumn && !session[controllerName].searchColumn.equals(params.searchColumn)) {
          params.offset = session[controllerName].offset = 0
        }
        params.sort = session[controllerName].sort = params.sort ?: session[controllerName].sort
        params.order = session[controllerName].order = params.order ?: session[controllerName].order

        params.query = session[controllerName].query = params.query ?: session[controllerName].query
        params.searchColumn = session[controllerName].searchColumn = params.searchColumn ?: session[controllerName].searchColumn
        params.searchValue = session[controllerName].searchValue = params.searchValue ?: session[controllerName].searchValue

      println "query: ${((params.query != null)&&(params.query != ''))} session: ${session[controllerName].query} params: ${params.query}"
      println "searchValue: ${((params.searchValue != null)&&(params.searchValue != ''))} session: ${session[controllerName].searchValue} params: ${params.searchValue}"

        // Get the list subset to display
        def tsl = []
        def tot = 0
        boolean isSearchQuery = iquery  && !ival//((params.query != null)&&(params.query != ""))
        if (isSearchQuery) {
          def searchResults = TestSection.search(params.query, [offset: params.offset, max: params.max])
          tsl = searchResults.results
          tot = searchResults.total

          session[controllerName].searchColumn = ""
          session[controllerName].searchValue = ""
        }
        else {
          tsl = testSectionService.listSelected(params)
          tot = tsl?tsl.totalCount:0

          session[controllerName].query = "" 
        }
        boolean hasCoordinates = false
      def min_lat=9999999.0
      def min_lon=9999999.0
      def max_lat=0.0
      def max_lon=0.0
        tsl?.each {
          if (it.hasCoordinates()) {
            if (it.fromLatitude != null)
            min_lat = Math.min(min_lat,it.fromLatitude)
            if (it.toLatitude != null)
            min_lat = Math.min(min_lat,it.toLatitude)
            if (it.fromLongitude != null)
            min_lon = Math.min(min_lon,Math.abs(it.fromLongitude))
            if (it.toLongitude != null)
            min_lon = Math.min(min_lon,Math.abs(it.toLongitude))
            if (it.fromLatitude != null)
            max_lat = Math.max(max_lat,it.fromLatitude)
            if (it.toLatitude != null)
            max_lat = Math.max(max_lat,it.toLatitude)
            if (it.fromLongitude != null)
            max_lon = Math.max(max_lon,Math.abs(it.fromLongitude))
            if (it.toLongitude != null)
            max_lon = Math.max(max_lon,Math.abs(it.toLongitude))
            hasCoordinates = true
          }
        }
      def center_lat
      def center_lon
      if (hasCoordinates) {
        center_lat = min_lat + (max_lat-min_lat)/2.0
        center_lon = min_lon + (max_lon-min_lon)/2.0
        }
        // Added for the export plugin
        if(params?.format && params.format != "html"){
          params.offset = 0
          params.max = 10000
          def allSelected = []
          if (session[controllerName].method ==  "index") {
            def searchResults = TestSection.search(session[controllerName].word, [offset: params.offset, max: params.max])
            allSelected = searchResults.results
          }
          else {
            def word = session[controllerName].word
            if (word) {
              String []listParms = session[controllerName].word.split("=")
              if (listParms && listParms.size()==2) {
                params.searchColumn = listParms[0]
                params.searchValue = listParms[1]
              }
            }
            allSelected = testSectionService.listSelected(params)
          }
          if (allSelected.size() > 0) {
            response.contentType = ConfigurationHolder.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=testSections.${params.format}")
            exportService.export(params.format, response.outputStream,allSelected, [:], [:])
          }
        }
      def msg
      def srcPhrase = " selected"

      if (isSearchQuery) {
        srcPhrase += " for index search on '${params.query}'"
        session[controllerName].method = "index"
        session[controllerName].word = params.query
      }
      else
      {
        srcPhrase += " for list query on '${params.searchValue}'"
        session[controllerName].method = "list"
        session[controllerName].word = "${params.searchColumn}=${params.searchValue}"
        }
      msg = "${tot}" + srcPhrase
      def rc = [:]
      rc.put('testSectionInstanceList', tsl)
      rc.put('totalCount'     ,tot)
      rc.put('hasCoordinates' ,hasCoordinates)
      rc.put('alpha'          ,alpha)
      rc.put('queryMessage'   ,msg)
      if (hasCoordinates) {
        rc.put('max_lat'        ,max_lat)
        rc.put('max_lon'        ,max_lon)
        rc.put('map_center_lat' ,center_lat)
        rc.put('map_center_lon' ,-1.0 * center_lon)
      }
      return rc
    }

    boolean hasLatLong(List tsl)  {
    	boolean rc = false
    	return rc
    }
    
    def show = {
      if (params.id instanceof java.lang.String)
        params.id = params.id.toLong()
      def testSectionInstance = TestSection.get( params.id )

      if(!testSectionInstance) {
          flash.message = "TestSection not found with id ${params.id}"
          redirect(action:list)
      }
      else { 
	    def rc = [:]
	    rc.put('testSectionInstance', testSectionInstance)
//        if (testSectionInstance.centerLatitude())
//          rc.put('map_center_lat' , testSectionInstance.centerLatitude())
//        if (testSectionInstance.centerLongitude())
//          rc.put('map_center_lon' , -1.0 * testSectionInstance.centerLongitude())
      	return rc
      }
    }

    def delete = {
      if (params.id instanceof java.lang.String)
        params.id = params.id.toLong()
      def testSectionInstance = TestSection.get( params.id )
      if(testSectionInstance) {
          testSectionInstance.delete()
          flash.message = "TestSection ${params.id} deleted"
          redirect(action:list)
      }
      else {
          flash.message = "TestSection not found with id ${params.id}"
          redirect(action:list)
      }
    }

    def edit = {
      if (params.id instanceof java.lang.String)
        params.id = params.id.toLong()
      def testSectionInstance = TestSection.get( params.id )

      if(!testSectionInstance) {
          flash.message = "TestSection not found with id ${params.id}"
          redirect(action:list)
      }
      else {
          return [ testSectionInstance : testSectionInstance 
          , districts: MrUtils.attrsList('TestSection', 'district')
          , groupnames: MrUtils.attrsList('TestSection', 'groupname')
          , systems: MrUtils.attrsList('TestSection', 'system')
          ]
      }
    }

    def update = {
      if (params.id instanceof java.lang.String)
        params.id = params.id.toLong()
      // paramsDateCheck - Workaround for http://jira.codehaus.org/browse/GRAILS-1793
      // enables saving a null date
        def dateError = paramsDateCheck(params)
        def testSectionInstance = TestSection.get( params.id )
        if(testSectionInstance) {
            testSectionInstance.properties = params
            if(!testSectionInstance.hasErrors() && testSectionInstance.save()) {
                flash.message = "TestSection ${params.id} updated"
                redirect(action:show,id:testSectionInstance.id)
            }
            else {
                render(view:'edit',model:[testSectionInstance:testSectionInstance])
            }
        }
        else {
            flash.message = "TestSection not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def testSectionInstance = new TestSection()
        testSectionInstance.properties = params
        return ['testSectionInstance':testSectionInstance]
    }

    def save = {
//        def testSectionInstance = new TestSection(params)
// Workaround for http://jira.codehaus.org/browse/GRAILS-1793
      def testSectionInstance = new TestSection()
      def excludes = []
      if ((!params.datefinishconst_month) ||(!params.datefinishconst_day)||(!params.datefinishconst_year))
        excludes << "datefinishconst"
      if ((!params.datestartconst_month) ||(!params.datestartconst_day)||(!params.datestartconst_year))
        excludes << "datestartconst"
      bindData(testSectionInstance, params, excludes)
      if(!testSectionInstance.hasErrors() && testSectionInstance.save()) {
            flash.message = "TestSection ${testSectionInstance.id} created"
            redirect(action:show,id:testSectionInstance.id)
        }
        else {
            render(view:'create',model:[testSectionInstance:testSectionInstance])
        }
    }
  
    // Workaround for http://jira.codehaus.org/browse/GRAILS-1793
    def paramsDateCheck ( params ) {
      def rc
      def names = []
      params.each{
        if (it.value == "struct")
          names.add(it.key)
      }
      names.each {
        def aDateString = ""
        def allBlank = (params[it+"_day"] == '' & params[it+"_month"] == '' & params[it+"_year"] == '')
        def someBlank = (params[it+"_day"] == '' | params[it+"_month"] == '' | params[it+"_year"] == '')
        if (allBlank)
          params[it] =  null
        if (someBlank & !allBlank){
          params[it] =  null
          def day = params[it+"_day"] == ''?'dd':params[it+"_day"]
          def mon = params[it+"_month"] == ''?'mm':params[it+"_month"]
          def year = params[it+"_year"] == ''?'yyyy':params[it+"_year"]
          aDateString = "${day}/${mon}/${year}"
          rc = ", ${it}, ${aDateString}, ignored"
        }
      }
      return rc?rc:""
    }

}
