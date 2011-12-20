<%--
  Created by IntelliJ IDEA.
  User: Carr1Den
  Date: Feb 19, 2009
  Time: 5:57:32 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <gui:resources components="['tabView','dataTable']"/>
    <title>MnDot Test Section Tracking</title>
    <g:javascript library="prototype" />
  </head>
  <body>
    <div class="body">
      <div class="dialog">
      <g:form name="parmForm">
      </g:form>
      </div>
    <div class="dialog">
    <gui:tabView id="myTabView">
      <gui:tab label="Home" active="true">
        <h1 style="margin-left:20px;">Welcome to Grails AJAX Select Sample</h1>
        <div class="dialog" style="margin-left:20px;width:30%;">
          <p>
          Blah blah blahThis sample demonstrates one technique for retrieving data from
          related tables into coordinated Grails select lists. Select one or more counties from the list
          to see which cities lie wholly or partially within the county(ies).
          </p>
<g:formRemote name="myForm"
              url="[ controller: 'home', action: 'getList', params: [ sort: 'title', order: 'desc' ]]">
          <table>
              <thead>
               <td> County List </td>
               <td> Cities in Selected Counties </td>
              </thead>
              <tr>
                <td>
                  <g:select
                    id="counties"
                    name="counties"
                    onchange="
                     getSelected('counties');
                     ${remoteFunction(controller:'home',
                       action:'countySelected',
                       update:'cities',
                       params:'\'idCsv=\' + selectedIds'
                       )}"
                    multiple="5"
                    from="${counties}" keys="${ids}"
                    noSelection="['':'-All-']"
                    >
                  </g:select>
                </td>
                <td>
                  <div id="cities">
                    All Cities
                  </div>
                </td>
              </tr>
            </table>
</g:formRemote>
<div id="updateMe">this div is updated by the form</div>
          </div>
        </gui:tab>
      </gui:tabView>
    </div>
    <g:javascript>
//      var selectedArray = new Array();
var selectedIds = new Array();
var countyNames = new Array();
      function getSelected(arg){
        selectedIds.clear();
        countyNames.clear();
        var selObj = document.getElementById(arg);
        var j = 0;
          for (var i=0; i<selObj.options.length; i++) {
            var item = selObj.options[i];
            if (item.text != '-All-' && item.selected) {
              selectedIds[j] = item.value
              countyNames[j] = item.text
                j++;
            }
          }
//          return selectedArray;
       }
      YAHOO.util.Event.onDOMReady(function(){
          var buttons = ['button0','button1','button2','button3'];
          for (i in buttons) {
              YAHOO.util.Event.on(buttons[i], 'click', function(e) {
                  GRAILSUI.myTabView.set('activeIndex', e.target.value);
              });
          };
      });
    </g:javascript>
    </div>
  </body>
</html>