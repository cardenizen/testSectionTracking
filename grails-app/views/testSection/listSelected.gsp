<%@ page import="us.mn.state.dot.testSectionTracking.TestSection" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>TestSection List</title>
    <!-- Added for the export plugin -->
    <export:resource />
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
    <!--<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAPZMJngdDwEVH8HNIYrfX4RTmw4c9U-rCtHDeDsV0tROf_L4ifhSCyahUSQuLDvVHiRRIaWAM3GZ10w" type="text/javascript"></script>-->
    <g:javascript src="mapiconmaker.js" />
    <script   type="text/javascript">
      var map;

      function loadMap() {

        if (GBrowserIsCompatible()) {
        <g:if test="${hasCoordinates}">
          map = new GMap2(document.getElementById("map"));
          map.setCenter(new GLatLng(${map_center_lat}, ${map_center_lon}), 1);
          var bounds = new GLatLngBounds();
          <g:each in="${testSectionInstanceList}" status="i" var="testSectionInstance">
            <g:if test="${testSectionInstance.fromLatitude != null}">
            var point = new GLatLng(${testSectionInstance.fromLatitude},${testSectionInstance.fromLongitude});
            bounds.extend(point);
            var newIcon = MapIconMaker.createLabeledMarkerIcon({addStar: false, label: "${alpha[i]}", primaryColor: "#00ff00"});
            var mkr = new GMarker(point, {icon: newIcon,title:"${alpha[i]} - ${fieldValue(bean:testSectionInstance, field:'groupname')}"});
            map.addOverlay(mkr);
            </g:if>
          </g:each>
          map.setZoom(map.getBoundsZoomLevel(bounds));
          map.setCenter(bounds.getCenter());
          map.addControl(new GSmallMapControl());
          } //GBrowserIsCompatible
        </g:if> <!-- hasCoordinates -->
      } // loadMap

      // letterLabel is an alternate method of putting letter labels on GMarkers
      // if used, it s/b called with a listener:     	    GEvent.addListener(directions, "addoverlay", letterLabels);
      function letterLabels(){
        var numMarkers = directions.getNumGeocodes();
        for (var i = 0; i < numMarkers; i++) {
          var marker = directions.getMarker(i);
          if (marker != null){
            var letter = String.fromCharCode("A".charCodeAt(0) + i);
            marker.setImage("http://www.google.com/mapfiles/marker" + letter + ".png");
            }
          else
            alert("Marker is null");
          }
        }         
      
    </script>
  </head>
  <body onunload="GUnload()">
    <div class="nav">
      <span class="menuButton"><a class="home" href="${createLinkTo(dir:'/')}">Home</a></span>
      <span class="menuButton"><g:link class="create" action="create">New TestSection</g:link></span>
    </div>
    <div class="body">
      <h1>TestSection List</h1>
      <g:if test="${queryMessage}">
      <div class="message">${queryMessage}</div>
      </g:if>
      <table>
        <tr>
          <td>
            <div class="paginateButtons">
              <g:paginate
                total="${totalCount}"
                action="listSelected"
                params="[query:params?.query]"
              />
            </div>
            <div class="list">
              <table>
                <thead>
                  <tr>
                    <g:if test="${alpha}">
                      <th>Map ID</th>
                    </g:if>
                    <g:sortableColumn property="groupname" title="${message(code: 'testSection.groupname.label', default: 'Groupname')}" params="[sort:params.sort,searchValue:params.searchValue]" />
                    <g:sortableColumn property="sectioncontact" title="Sectioncontact"  params="[sort:params.sort,searchValue:params.searchValue]"/>
                    <g:sortableColumn property="routeName" title="Route Name"  params="[sort:params.sort,searchValue:params.searchValue]"/>
                    %{--<g:sortableColumn property="closestcity" title="ClosestCity"  params="[sort:params.sort,searchValue:params.searchValue]"/>--}%
                    <g:sortableColumn property="fromLatitude" title="FromLatitude"  params="[sort:params.sort,searchValue:params.searchValue]"/>
                    <g:sortableColumn property="county" title="County"  params="[sort:params.sort,searchValue:params.searchValue]"/>
                    <g:sortableColumn property="begindesc" title="Begin Description"  params="[sort:params.sort,searchValue:params.searchValue]"/>
                    <g:sortableColumn property="enddesc" title="Begin Milepoint"  params="[sort:params.sort,searchValue:params.searchValue]"/>
                  </tr>
                </thead>
                <tbody>
                  <g:each in="${testSectionInstanceList}" status="i" var="testSectionInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                      <g:if test="${alpha}">
                        <td>${alpha[i]}</td>
                      </g:if>
                      <td><g:link action="show" id="${testSectionInstance.id}">${fieldValue(bean:testSectionInstance, field:'groupname')}</g:link></td>
                      <td>${fieldValue(bean:testSectionInstance, field:'sectioncontact')}</td>
                      <td>${fieldValue(bean:testSectionInstance, field:'routeName')}</td>
                      %{--<td>${fieldValue(bean:testSectionInstance, field:'closestcity')}</td>--}%
                      <td>${fieldValue(bean:testSectionInstance, field:'fromLatitude')}</td>
                      <td>${fieldValue(bean:testSectionInstance, field:'county')}</td>
                      <td>${fieldValue(bean:testSectionInstance, field:'begindesc')}</td>
                      <td>${fieldValue(bean:testSectionInstance, field:'beginmp')}</td>
                    </tr>
                  </g:each>
                </tbody>
              </table>
            </div>
            <!-- Added for the export plugin -->
            <export:formats formats="['excel', 'xml']" />
          </td>
          <td>
            <g:if test="${hasCoordinates}">
              <div id="map" style="width: 400px; height: 450px; float:left; border: 1px solid black;"></div>
            </g:if>
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>
