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
package us.mn.state.dot.testSectionTracking

class AppConfig {
  String name
  String parameter
  String val
  String status

  Date dateCreated
  Date lastUpdated
  String createdBy
  String lastUpdatedBy

  static mapping = {
    columns {
      id column:'id'
    }
    id generator:'sequence', params:[sequence:'PICKLIST_ID_SEQ']
  }

  static constraints = {
    name          (nullable:false, size:1..30)
    parameter     (nullable:false, size:1..25)
    val           (nullable:false, size:1..4000)
    status        (nullable:false, size:1..20)
    createdBy     (nullable:true)
    lastUpdatedBy (nullable:true)
  }
}
