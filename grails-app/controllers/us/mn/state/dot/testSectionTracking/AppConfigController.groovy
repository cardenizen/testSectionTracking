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

import us.mn.state.dot.testSectionTracking.AppConfig
import org.springframework.web.context.request.RequestContextHolder

class AppConfigController {
    
    def index = { redirect(action:list,params:params) }

    def list = {
      if (!params.max) {
          params.max = 10
      }
      [ appConfigInstanceList: AppConfig.list(params) ]
    }

    def classSelected = {
      def pln = params.pickListName
      render(template:"/templates/common/menuListTemplate",
          model:[appConfigInstanceList:AppConfig.findAllByName(pln)])
    }

    def show = {
        def appConfigInstance = AppConfig.get( params.id )
        if(!appConfigInstance) {
            flash.message = "AppConfig not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ appConfigInstance : appConfigInstance ] }
    }

    def delete = {
        def appConfigInstance = AppConfig.get( params.id )
        if(appConfigInstance) {
            appConfigInstance.delete()
            flash.message = "AppConfig ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "AppConfig not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def appConfigInstance = AppConfig.get( params.id )

        if(!appConfigInstance) {
            flash.message = "AppConfig not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ appConfigInstance : appConfigInstance ]
        }
    }

    def update = {
        def appConfigInstance = AppConfig.get( params.id )
        if(appConfigInstance) {
            appConfigInstance.properties = params
            appConfigInstance.lastUpdatedBy = getUserName()
            if(!appConfigInstance.hasErrors() && appConfigInstance.save()) {
                flash.message = "AppConfig ${params.id} updated"
                redirect(action:show,id:appConfigInstance.id)
            }
            else {
                render(view:'edit',model:[appConfigInstance:appConfigInstance])
            }
        }
        else {
            flash.message = "AppConfig not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def appConfigInstance = new AppConfig()
        appConfigInstance.properties = params
        return ['appConfigInstance':appConfigInstance]
    }

    def save = {
        def appConfigInstance = new AppConfig(params)
        appConfigInstance.createdBy = getUserName()
        appConfigInstance.lastUpdatedBy = getUserName()
        appConfigInstance.dateCreated = new Date()
        appConfigInstance.lastUpdated = new Date()
        if(!appConfigInstance.hasErrors() && appConfigInstance.save()) {
            flash.message = "AppConfig ${appConfigInstance.id} created"
            redirect(action:show,id:appConfigInstance.id)
        }
        else {
            render(view:'create',model:[appConfigInstance:appConfigInstance])
        }
    }

    def getUserName = {
      String userName="anon"
      def webRequest =  RequestContextHolder.currentRequestAttributes()
      if (webRequest) {
        userName = webRequest.getRemoteUser()
      }
      return userName
    }

}
