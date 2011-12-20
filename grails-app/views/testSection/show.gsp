<%@ page import="us.mn.state.dot.testSectionTracking.TestSection" %>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta name="layout" content="main" />

      <g:set var="entityName" value="${message(code: 'testSection.label', default: 'Test Section')}" />
      <title><g:message code="default.edit.label" args="[entityName]" /></title>

      <link rel="stylesheet" type="text/css" href="${createLinkTo(dir: 'css', file: 'jquery-ui-1.7.2.custom.css')}" />
      <g:javascript src="jquery/jquery-1.3.2.js" />
      <g:javascript src="jquery/jquery-ui-1.7.2.js" />
      <script type="text/javascript">
      $(function() {
        $("#tabs").tabs();
      });
      </script>
      <g:javascript src="mapiconmaker.js" />
      <script   type="text/javascript">
        var map;
        var directions;
        function loadMap() {
          <g:if test="${testSectionInstance.hasCoordinates()}">
          if (GBrowserIsCompatible()) {
            var bounds = new GLatLngBounds();
            var from_point;
            var to_point;
            map = new GMap2(document.getElementById("map"));
            <g:if test="${testSectionInstance.hasFromCoordinates() && testSectionInstance.hasToCoordinates()}">
            map.setCenter(new GLatLng(${testSectionInstance.centerLatitude()}, ${testSectionInstance.centerLongitude()}), 1);
              from_point = new GLatLng(${testSectionInstance.fromLatitude},${testSectionInstance.fromLongitude});
              bounds.extend(from_point);
              to_point = new GLatLng(${testSectionInstance.toLatitude},${testSectionInstance.toLongitude});
              bounds.extend(to_point);
              var wp = new Array(2);
              wp[0] = from_point;
              wp[1] = to_point;
            // load directions
              directions = new GDirections(map);
            // Listen for GDirections errors.
              GEvent.addListener(directions, "error", directionsError);
              directions.loadFromWaypoints(wp);
            // Replace the default route markers (A, B, C, ...) with F (from) and T (To) markers when signaled.
              GEvent.addListener(directions, "addoverlay", replaceDirMarkers);
            </g:if>
            <g:elseif test="${testSectionInstance.hasFromCoordinates()}">
            map.setCenter(new GLatLng(${testSectionInstance.fromLatitude}, ${testSectionInstance.fromLongitude}), 1);
            from_point = new GLatLng(${testSectionInstance.fromLatitude},${testSectionInstance.fromLongitude});
            bounds.extend(from_point);
            var marker = new GMarker(from_point);
            marker.setImage("http://www.google.com/mapfiles/markerF.png");
            map.addOverlay(marker);
            </g:elseif>
            <g:else test="${testSectionInstance.hasToCoordinates()}">
            map.setCenter(new GLatLng(${testSectionInstance.toLatitude}, ${testSectionInstance.toLongitude}), 1);
            to_point = new GLatLng(${testSectionInstance.toLatitude},${testSectionInstance.toLongitude});
            bounds.extend(to_point);
            var marker = new GMarker(from_point);
            marker.setImage("http://www.google.com/mapfiles/markerT.png");
            map.addOverlay(marker);
            </g:else>

            map.setZoom(map.getBoundsZoomLevel(bounds));
            map.setCenter(bounds.getCenter());
            map.addControl(new GSmallMapControl());
          </g:if>
          }
        }
        
        // "addoverlay" listener calls:
        // This expects the caller to have created a GDirections using only two points - from (marker index 0) and to (marker index 1).
          function replaceDirMarkers(){
            var numMarkers = directions.getNumGeocodes()
            for (var i = 0; i < numMarkers; i++) {
                var marker = directions.getMarker(i);
                if (marker != null){
                var letter = String.fromCharCode("A".charCodeAt(0) + i);
                if (i == 0)
                    marker.setImage("http://www.google.com/mapfiles/markerF.png");
                else
                    marker.setImage("http://www.google.com/mapfiles/markerT.png");
                }
                else
	                alert("Marker is null");
                }
	        }         

// This event is triggered if a directions request results in an error.
function directionsError() {
    var geoStatus = [
        [ G_GEO_SUCCESS, "No errors occurred; the address was successfully parsed and its geocode has been returned." ],
        [ G_GEO_BAD_REQUEST, "A directions request could not be successfully parsed. For example, the request may have been rejected if it contained more than the maximum number of waypoints allowed." ],
        [ G_GEO_SERVER_ERROR, "A geocoding or directions request could not be successfully processed, yet the exact reason for the failure is not known." ],
        [ G_GEO_MISSING_QUERY, "The HTTP q parameter was either missing or had no value. For geocoding requests, this means that an empty address was specified as input. For directions requests, this means that no query was specified in the input." ],
        [ G_GEO_MISSING_ADDRESS, "The HTTP q parameter was either missing or had no value. For geocoding requests, this means that an empty address was specified as input. For directions requests, this means that no query was specified in the input." ],
        [ G_GEO_UNKNOWN_ADDRESS, "No corresponding geographic location could be found for the specified address. This may be due to the fact that the address is relatively new, or it may be incorrect." ],
        [ G_GEO_UNAVAILABLE_ADDRESS, "The geocode for the given address or the route for the given directions query cannot be returned due to legal or contractual reasons." ],
        [ G_GEO_UNKNOWN_DIRECTIONS, "The GDirections object could not compute directions between the points mentioned in the query. This is usually because there is no route available between the two points, or because we do not have data for routing in that region." ],
        [ G_GEO_BAD_KEY, "The given key is either invalid or does not match the domain for which it was given." ],
        [ G_GEO_TOO_MANY_QUERIES, "The given key has gone over the requests limit in the 24 hour period or has submitted too many requests in too short a period of time." ]
    ];
    var directionsStatus = directions.getStatus();
    for (var i = 0; geoStatus.length > i; i++) {
        if (directionsStatus.code === geoStatus[i][0]) {
            displayStatus("Directions Error: " + geoStatus[i][1]);
        }
    }
}

//          // add an event listener
//          GEvent.addListener(map, "click", function(marker, point) {
//            if (marker) {
//              map.removeOverlay(marker);
//            } else {
//              map.addOverlay(new GMarker(point));
//            }
//            document.getElementById("message").innerHTML = point.toString();
//            // get and append the values inthe text box
//            currentContent = document.mymap.points.value;
//            document.mymap.points.value = currentContent + "new GLatLng" + point.toString() + "," + "\n";
//          });


      </script>

    </head>
    <body onunload="GUnload()">
    <g:def var="idParm" value="${testSectionInstance?.id}"/>
        <div class="nav">
          <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
          <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
         <g:if test="${request.isUserInRole('ROLE_ADMIN') || request.isUserInRole('ROLE_STAFF')}">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="edit" action="edit" params="['id':idParm]"><g:message code="default.edit.label" args="[entityName]" /></g:link></span>
        </g:if>
      <g:form>
          <input type="hidden" name="id" value="${testSectionInstance?.id}" />
      </g:form>
        </div>
        <div class="body">
          <table>
            <tr>
              <td> <!-- Column 1 -->
                <h1><g:message code="default.show.label" args="[entityName]" /></h1>
              <g:if test="${flash.message}">
              <div class="message">${flash.message}</div>
              </g:if>
              <div class="dialog">
                  <table>
                      <tbody>
                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.groupname.label" default="Group Name" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'groupname')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.section.label" default="Section" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'section')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.sectioncontact.label" default="Section Contact" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'sectioncontact')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.routeName.label" default="Route Name" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'routeName')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.system.label" default="System" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'system')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.route.label" default="Route" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'route')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.district.label" default="District" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'district')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.closestcity.label" default="Closest City" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'closestcity')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.county.label" default="County" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'county')}</td>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.direction.label" default="Direction" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'direction')}</td>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.keyword1.label" default="Keyword1" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'keyword1')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.keyword2.label" default="Keyword2" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'keyword2')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.keyword3.label" default="Keyword3" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'keyword3')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.layer1.label" default="Layer 1" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'layer1')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.l1thickness.label" default="Lyr 1 Thickness" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l1thickness')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.l1comment.label" default="Layer 1 Comment" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l1comment')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.layer2.label" default="Layer 2" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'layer2')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.l2thickness.label" default="Lyr 2 Thickness" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l2thickness')}</td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name"><g:message code="testSection.l2comment.label" default="Lyr 2 Comment" />:</td>
                              <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l2comment')}</td>
                          </tr>
                      </tbody>
                  </table>
              </div>
              </td> <!-- End Column 1 -->
              <br/>
              <td> <!-- Column 2 -->
                <table>
                    <tbody>
                      <tr><h1>(con't)</h1></tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.layer3.label" default="Layer 3" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'layer3')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.l3thickness.label" default="Lyr 3 Thickness" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l3thickness')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.l3comment.label" default="Lyr 3 Comment" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l3comment')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.layer4.label" default="Layer 4" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'layer4')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.l4thickness.label" default="Lyr 4 Thickness" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l4thickness')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.l4comment.label" default="Lyr 4 Comment" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l4comment')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.layer5.label" default="Layer 5" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'layer5')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.l5thickness.label" default="Lyr 5 Thickness" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l5thickness')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.l5comment.label" default="Lyr 5 Comment" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'l5comment')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.contractor.label" default="Contractor" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'contractor')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.stateprojectnumber.label" default="Stateprojectnumber" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'stateprojectnumber')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.sectionstatus.label" default="Section Status" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'sectionstatus')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.datestartconst.label" default="Date Start Construction" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'datestartconst')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.datefinishconst.label" default="Date Finish Construction" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'datefinishconst')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.labtesting.label" default="Lab Testing" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'labtesting')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.comments.label" default="Project Comments" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'comments')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.datestarttest.label" default="Start Test Date" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'datestarttest')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.dateendtest.label" default="End Test Date" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'dateendtest')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.truemiles.label" default="True Miles" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'truemiles')}</td>
                      </tr>

                      <tr class="prop">
                          <td valign="top" class="name"><g:message code="testSection.projsect.label" default="Project Section" />:</td>
                          <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'projsect')}</td>
                      </tr>
                    </tbody>
                </table>
              </td>  <!-- End Column 2 -->
              <td>  <!-- Column 3 -->
              <h1>Location</h1>

              <g:if test="${testSectionInstance.fromLatitude != null}">
                <div id="map" style="width: 400px; height: 400px; float:left; border: 1px solid black;"></div>
              </g:if>
                <br/>
                <table>
                  <tbody>
                    <tr>
                      <g:if test="${testSectionInstance.fromLatitude != null}">
                      <td>
                        <table>
                          <tbody>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.fromLongitude.label" default="From Longitude" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'fromLongitude')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.fromLatitude.label" default="From Latitude" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'fromLatitude')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.toLongitude.label" default="To Longitude" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'toLongitude')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.toLatitude.label" default="To Latitude" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'toLatitude')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.latLongMethod.label" default="Lat Long Method" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'latLongMethod')}</td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                      </g:if>
                      <td>
                        <table>
                          <tbody>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.sectionLength.label" default="Section Length (miles)" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'sectionLength')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.beginmp.label" default="Begin Milepoint" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'beginmp')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.begindesc.label" default="Begin Desciption" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'begindesc')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.endmp.label" default="End Milepoint" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'endmp')}</td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="testSection.enddesc.label" default="End Description" />:</td>
                                <td valign="top" class="value">${fieldValue(bean:testSectionInstance, field:'enddesc')}</td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </td>
            </tr>
          </table>
        </div>
    </body>
</html>
