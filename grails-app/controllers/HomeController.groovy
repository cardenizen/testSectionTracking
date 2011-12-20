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
import groovy.sql.Sql

class HomeController {
  def dataSource
  def personService
  def authenticateService

  def index = {
    Sql sql = new groovy.sql.Sql(dataSource)
    def names = []
    def county_ids = []
    String query = 'SELECT county_id,county_name FROM mnr.counties'
    sql.eachRow(query, { row ->
        county_ids << row.county_id
        names << row.county_name
        }
      )
    def routes = [""]
    query = 'SELECT distinct route_name FROM mnr.test_section where route_name is not null order by route_name'
    sql.eachRow(query, { row ->
        routes << row.route_name
        }
      )

    def districts = [""]
    query = 'SELECT distinct district FROM mnr.test_section where district is not null order by district'
    sql.eachRow(query, { row ->
        districts << row.district
        }
      )

    def keywords = [""]
    query = """
select distinct * from (
select distinct keyword1 as keyword from mnr.test_section where keyword1 is not null and keyword1 <> ' '
union all
select distinct keyword2 as keyword from mnr.test_section where keyword2 is not null and keyword2 <> ' '
union all
select distinct keyword3 as keyword from mnr.test_section where keyword3 is not null and keyword3 <> ' '
)
order by 1
"""
    sql.eachRow(query, { row ->
        keywords << row.keyword
        }
      )

    String countySelection = params['counties']
    String routeSelection = params['routes']
    String districtSelection = params['districts']
    String keywordSelection = params['keywords']
    String filterGroup = params['filterGroup']
    if (filterGroup == 'countyOpt') {
      if (countySelection != null && countySelection != "") {
        String name = ""
        for (int i = 0; i < county_ids.size(); i++) {
          String id = county_ids[i]
          if (id.equals(countySelection)) {
            name = names[i]
            break
          }
        }
        redirect(controller:'testSection', action:'listSelected', params:['searchColumn':'county','searchValue':name.toUpperCase()])
        return
      }
    }
    else if (filterGroup == 'routeOpt') {
      if (routeSelection != null && routeSelection != "") {
        redirect(controller:'testSection', action:'listSelected', params:['searchColumn':'routeName','searchValue':routeSelection.toUpperCase()])
        return
      }
    }
    else if  (filterGroup == 'districtOpt') {
        if (districtSelection != null && districtSelection != "") {
          redirect(controller:'testSection', action:'listSelected', params:['searchColumn':'district','searchValue':districtSelection.toUpperCase()])
        }
    }
    else if  (filterGroup == 'keywordOpt') {
        if (keywordSelection != null && keywordSelection != "") {
          redirect(controller:'testSection', action:'listSelected', params:['searchColumn':'keyword','searchValue':keywordSelection.toUpperCase()])
        }
    }
// implied else
    render(view:'home', model:['counties':names
            ,'county_ids':county_ids
            , 'routes':routes
            , 'districts':districts
            , 'keywords':keywords
    ])
  }

  def changePassword = {
    if (request.method == 'GET') {
      def personInstance = personService.currentUser()
      return [ personInstance : personInstance ]
    }
    if (request.method == 'POST') {
      def personInstance = personService.currentUser()

      if(params.confirmPass == params.pass) {
        personInstance.pass = params.pass
        personInstance.passwd = authenticateService.encodePassword(personInstance.pass)

        if (!personInstance.hasErrors() && personInstance.save(flush: true)) {
          //userCache.removeUserFromCache(personInstance.loginName)
          flash.message = "Password changed successfully."
          redirect(action:index)
        }
        else {
          render(view:'changePassword',model:[personInstance:personInstance])
        }
      }
      else {
        personInstance.errors.reject('person.pass.doesNotMatch',            // Error code, see grails-app/i18n/message.properties
          ['pass', 'class Person'].toArray(),      // Groovy ListArray cast to Object[]
           '[NothingUseMessageProperites]')  // Default mapping string.
        render(view:'changePassword',model:[personInstance:personInstance])
      }
    }
  }
  
}
