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

class TestSection {
	static searchable = true              // <-- Make TestSections searchable
//    static belongsTo = ResearchStudy 
//    ResearchStudy resStudy
  
    static mapping = {
      id generator:'sequence', params:[sequence:'TEST_SECTION_TRACKING_SEQ']
    }
    String groupname
    String section
    String sectioncontact
    String routeName
    String system
    String route
    String district
    String closestcity
    String county
    String direction
    String keyword1
    String keyword2
    String keyword3
    String layer1
    String l1thickness
    String l1comment
    String layer2
    String l2thickness
    String l2comment
    String layer3
    String l3thickness
    String l3comment
    String layer4
    String l4thickness
    String l4comment
    String layer5
    String l5thickness
    String l5comment
    String sectionLength
    Double beginmp
    String begindesc
    Double endmp
    String enddesc
    String contractor
    String stateprojectnumber
    String sectionstatus
    Date   datestartconst
    Date   datefinishconst
    String labtesting
    String comments
    String datestarttest
    String dateendtest
    Double truemiles
    Double fromLongitude
    Double fromLatitude
    Double toLongitude
    Double toLatitude
    String latLongMethod
    String projsect

// Maintained by grails
    Date dateCreated
    Date lastUpdated
    String createdBy
    String modifiedBy
//  String lastUpdatedBy
// alter table test_section rename COLUMN MODIFIED_BY to LAST_UPDATED_BY
    static constraints = {
        groupname          (maxSize:60)
        section	           (maxSize:20)
        sectioncontact     (maxSize:60)
        routeName          (maxSize:30 ,nullable:true)
        system             (maxSize:30 ,nullable:true)
        route              (maxSize:30 ,nullable:true)
        district           (maxSize:1  ,nullable:true)
        closestcity        (maxSize:60 ,nullable:true)
        county             (maxSize:36 ,nullable:true)
        direction          (maxSize:6  ,nullable:true)
        keyword1           (maxSize:40 ,nullable:true)
        keyword2           (maxSize:40 ,nullable:true)
        keyword3           (maxSize:40 ,nullable:true)
        layer1             (maxSize:40 ,nullable:true)
        l1thickness        (maxSize:24 ,nullable:true)
        l1comment          (maxSize:500,nullable:true)
        layer2             (maxSize:40 ,nullable:true)
        l2thickness        (maxSize:24 ,nullable:true)
        l2comment          (maxSize:500,nullable:true)
        layer3             (maxSize:40 ,nullable:true)
        l3thickness        (maxSize:24 ,nullable:true)
        l3comment          (maxSize:500,nullable:true)
        layer4             (maxSize:40 ,nullable:true)
        l4thickness        (maxSize:24 ,nullable:true)
        l4comment          (maxSize:500,nullable:true)
        layer5             (maxSize:40 ,nullable:true)
        l5thickness        (maxSize:24 ,nullable:true)
        l5comment          (maxSize:500,nullable:true)
        sectionLength      (maxSize:24 ,nullable:true)
        beginmp            (nullable:true)
        begindesc          (maxSize:120,nullable:true)
        endmp              (nullable:true)
        enddesc            (maxSize:100,nullable:true)
        contractor         (maxSize:60 ,nullable:true)
        stateprojectnumber (maxSize:20 ,nullable:true)
        sectionstatus      (maxSize:12 ,nullable:true)
        datestartconst     (nullable:true)
        datefinishconst    (nullable:true)
        labtesting         (maxSize:160,nullable:true)
        comments           (maxSize:500,nullable:true)
        datestarttest      (maxSize:24 ,nullable:true)
        dateendtest        (maxSize:24 ,nullable:true)
        truemiles          (nullable:true, max:new Double(100), scale:2)
        fromLongitude      (nullable:true, max:new Double(123456), scale:10)
        fromLatitude       (nullable:true, max:new Double(123456), scale:10)
        toLongitude        (nullable:true, max:new Double(123456), scale:10)
        toLatitude         (nullable:true, max:new Double(123456), scale:10)
        latLongMethod      (maxSize:20 ,nullable:true)
        projsect           (maxSize:150,nullable:true)
        dateCreated        (nullable:true)
        lastUpdated        (nullable:true)
        createdBy          (nullable:true)
        modifiedBy         (nullable:true)
    }

      boolean hasFromCoordinates() {
        (fromLatitude && fromLongitude)
      }

      boolean hasToCoordinates() {
        (toLatitude && toLongitude)
      }

      boolean hasCoordinates() {
        hasFromCoordinates() || hasToCoordinates()
      }

    Double centerLatitude() {
      def min_lat=9999999.0
      def max_lat=0.0
      if (fromLatitude != null && toLatitude == null)
        return fromLatitude
      else if (fromLatitude == null && toLatitude != null)
        return toLatitude
      else if (fromLatitude == null && toLatitude == null)
        return null
	  if (fromLatitude > toLatitude) {
	  	min_lat=toLatitude
		max_lat=fromLatitude
	  } else {
	  	min_lat=fromLatitude
		max_lat=toLatitude
	  }
      min_lat + (max_lat-min_lat)/2.0
    }
    
    Double centerLongitude() {
      def min_lon=9999999.0
      def max_lon=0.0
      if (fromLongitude != null && toLongitude == null)
        return fromLongitude
      else if (fromLongitude == null && toLongitude != null)
        return toLongitude
      else if (fromLongitude == null && toLongitude == null)
        return null
	  if (fromLongitude > toLongitude) {
	  	min_lon=toLongitude
		max_lon=fromLongitude
	  } else {
	  	min_lon=fromLongitude
		max_lon=toLongitude
	  }
      min_lon + (max_lon-min_lon)/2.0
    }
}
