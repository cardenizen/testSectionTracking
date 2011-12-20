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
    <title>MnDot Test Section Tracking</title>
    <style>
      fieldset{display: none; padding: 10px;}
    </style>
    <g:javascript library="prototype" />
  </head>
  <body>
    <div class="nav">
      <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
      %{--<g:if test="${request.isUserInRole('ROLE_ADMIN') || request.isUserInRole('ROLE_STAFF')}">--}%
        %{--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>--}%
      %{--</g:if>--}%
      <g:if test="${request.isUserInRole('ROLE_ADMIN')}">
        %{--<span class="menuButton"><g:link class="list" controller="researchStudy" action="list">List Research Studies</g:link></span>--}%
        <span class="menuButton"><g:link class="list" controller="person" action="list">Manage Users</g:link></span>
        <span class="menuButton"><g:link class="list" controller="authority" action="list">Manage Roles</g:link></span>
        <span class="menuButton"><g:link class="list" controller="requestmap" action="list">Manage Permissions</g:link></span>
        <span class="menuButton"><g:link class="list" action="list" controller="appConfig">Pick Lists</g:link></span>
      </g:if>
<%--
      <g:isNotLoggedIn>
        <span class="menuButton"><g:link controller="register">Sign Up</g:link></span>
      </g:isNotLoggedIn>
--%>      
    </div>
  <hr>
  <br>
  What is Research Test Section Tracking?<br><br>
  Have you tried a new product, material or method and want to keep track of it over time? Want to see what others around the state have tried?
  <br>
  Minnesota city, county and state engineers have developed hundreds of test sections and experimental projects relating to every aspect of roadways.   The problem is that projects tend to be forgotten as people move on before the benefits of research are learned.   The locations and purpose of the test sections are lost over time and can't be revived.
  <br>
  The Local Road Research Board and the Mn/DOT Office of Materials is developing this system so that you can enter basic information about experimental test sections and track them over time. It will allow engineers and researchers to learn from what has already been tried around the state.
  <br><br>
  Take a look and see what's been done all around the state, or enter a new test section. Modifications required user registration but anonymous viewing is available.<br>
<!--  <br>
  Microsoft Internet Explorer users may need to install the <a href="http://www.mozilla.com/firefox">Firefox browser</a> to view google map displays.  -->
  <br>
  <br>
  Questions?<br>
  Contact Melissa Cole <a href="mailto:melissa.cole@state.mn.us">melissa.cole@state.mn.us</a> (651) 366-5432 <br>
  or
  Rolf Benson   rolf.benson@.state.mn.us (651) 366-5511<br><br>
  <hr>
  <g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
  </g:if>
  <div class="nav">
  <table>
    <tr>
      <td>

      <div class="dialog">
        <g:form name="parmForm">
          <span class="menuButton">
            <g:actionSubmit value="List All(~2000)" action="" /> or
          </span>
        <table>
          <tr>
            <td>
              <span class="menuButton">
                <g:submitButton id="listby" name="getList" value="Filter ..." />
              </span>
            </td>
            <td><g:radio name="filterGroup" value="countyOpt" onclick="toggleSet(this)"/>County</td>
            <td><g:radio name="filterGroup" value="routeOpt" onclick="toggleSet(this)"/>Route Name</td>
            <td><g:radio name="filterGroup" value="districtOpt" onclick="toggleSet(this)"/>District</td>
<%--            <td><g:radio name="filterGroup" value="keywordOpt" onclick="toggleSet(this)"/>Keyword</td> --%>
          </tr>
          <fieldset id="Opts"><legend>Filter Options</legend>
          <tr>
            <td colspan="4">
              <fieldset id="countyOpt" class="item">
                <legend>Counties</legend>
                 <g:select
                  id="counties"
                  name="counties"
                  from="${counties}" keys="${county_ids}"
                  noSelection="['':'']"
                  >
                </g:select>
              </fieldset>
              <fieldset id="routeOpt" class="item">
                <legend>Routes</legend>
                <g:select
                  id="routes"
                  name="routes"
                  from="${routes}" keys="${routes}"
                  noSelection="['':'']"
                  >
                </g:select>
              </fieldset>
              <fieldset id="districtOpt" class="item">
                <legend>Districts</legend>
                <g:select
                  id="districts"
                  name="districts"
                  from="${districts}" keys="${districts}"
                  noSelection="['':'']"
                  >
                </g:select>
              </fieldset>
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>
          </fieldset>
        </table>
        </g:form>
        </div>
      </td>
    <td> <-- List All, Select a Filter Option OR&nbsp;
    <g:form url='[controller: "testSection", action: "listSelected"]' id="searchTs" name="searchTs" method="get">
      <g:textField name="query" value="${params.query}" size="30"/> <br/>
      <input type="submit" value="Search all Text" />
    </g:form>
    </td>
    </tr>
  </table>
  </div>

    <g:javascript>
      var selectedIds = new Array();
      var countyNames = new Array();

      function getSelected(arg) {
        selectedIds.clear();
        countyNames.clear();
        var selObj = document.getElementById(arg);
        var j = 0;
        for (var i=0; i < selObj.options.length; i++) {
          var item = selObj.options[i];
          if (item.text != '' && item.selected) {
            selectedIds[j] = item.value;
            countyNames[j] = item.text;
            j++;
          }
        }
      }

      function toggleSet(rad) {
        var type = rad.value;
        for(var k=0,elm;elm=rad.form.elements[k];k++) {
          if(elm.className=='item') {
            elm.style.display = elm.id==type? 'inline':'';
          }
        }
        var selectedOption = rad.value.substring(0,1).toUpperCase() + rad.value.substring(1,rad.value.indexOf('Opt'));
        document.getElementById('listby').value='List by ' + selectedOption;
      }
    </g:javascript>
  </body>
</html>