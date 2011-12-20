
<%@ page import="us.mn.state.dot.testSectionTracking.MrUtils; us.mn.state.dot.area.County; us.mn.state.dot.testSectionTracking.TestSection" %>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta name="layout" content="main" />
      <g:set var="entityName" value="${message(code: 'temp.label', default: 'Temp')}" />
      <title><g:message code="default.edit.label" args="[entityName]" /></title>
      <link rel="stylesheet" type="text/css" href="${createLinkTo(dir: 'css', file: 'jquery-ui-1.7.2.custom.css')}" />
      <g:javascript src="jquery/jquery-1.3.2.js" />
      <g:javascript src="jquery/jquery-ui-1.7.2.js" />
    </head>
    <body>
        <div class="nav">
          <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
        </div>
        <div class="body">
          <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${testSectionInstance}">
            <div class="errors">
                <g:renderErrors bean="${testSectionInstance}" as="list" />
            </div>
            </g:hasErrors>
      <div class="dialog">
            <g:form action="save" method="post" >
          <div id="tabs">
            <ul>
              <li class="controller"><a href="#Status">Status</a></li>
              <li class="controller"><a href="#Location">Location</a></li>
              <li class="controller"><a href="#Project">Project</a></li>
              <li class="controller"><a href="#Testing">Testing</a></li>
            </ul>

            <div id="Status">
                      <table>
                          <tbody>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="section"><g:message code="testSection.section.label" default="Section" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'section','errors')}">
                                  <input type="text" maxlength="20" id="section" name="section" value="${fieldValue(bean:testSectionInstance,field:'section')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="groupname"><g:message code="testSection.groupname.label" default="Group Name" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'groupname','errors')}">
                                <g:select name="groupname"
                                  from="${MrUtils.attrsList('TestSection', 'groupname').collect{it.encodeAsHTML()}}"
                                  keys="${MrUtils.attrsList('TestSection', 'groupname').collect{it.encodeAsHTML()}}"
                                  value="${testSectionInstance.groupname?.encodeAsHTML()}"
                                  noSelection="['':'']"
                                  >
                                </g:select>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="projsect"><g:message code="testSection.projsect.label" default="Project Section" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'projsect','errors')}">
                                  <input type="text" size="150" maxlength="150" id="projsect" name="projsect" value="${fieldValue(bean:testSectionInstance,field:'projsect')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="sectionstatus"><g:message code="testSection.sectionstatus.label" default="Section Status" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'sectionstatus','errors')}">
                                  <input type="text" size="12" maxlength="12" id="sectionstatus" name="sectionstatus" value="${fieldValue(bean:testSectionInstance,field:'sectionstatus')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="datestartconst"><g:message code="testSection.datestartconst.label" default="Datestartconst" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'datestartconst','errors')}">
                                  <g:datePicker name="datestartconst"
                                          precision="day" years="${2020..1992}"
                                          value="${testSectionInstance?.datestartconst}"
                                    noSelection="['':'']"
                                    default="none"
                                    >
                                  </g:datePicker>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="datefinishconst"><g:message code="testSection.datefinishconst.label" default="Date Finish Construction" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'datefinishconst','errors')}">
                                  <g:datePicker name="datefinishconst"
                                          precision="day" years="${2020..1992}"
                                          value="${testSectionInstance?.datefinishconst}"
                                    noSelection="['':'']"
                                    default="none"
                                    >
                                  </g:datePicker>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="sectioncontact"><g:message code="testSection.sectioncontact.label" default="Section Contact" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'sectioncontact','errors')}">
                                  <input type="text" size="60" maxlength="60" id="sectioncontact" name="sectioncontact" value="${fieldValue(bean:testSectionInstance,field:'sectioncontact')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="datestarttest"><g:message code="testSection.datestarttest.label" default="Start Test Date" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'datestarttest','errors')}">
                                  <input type="text" size="24" maxlength="24" id="datestarttest" name="datestarttest" value="${fieldValue(bean:testSectionInstance,field:'datestarttest')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="dateendtest"><g:message code="testSection.dateendtest.label" default="End Test Date" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'dateendtest','errors')}">
                                  <input type="text" size="24" maxlength="24" id="dateendtest" name="dateendtest" value="${fieldValue(bean:testSectionInstance,field:'dateendtest')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="keyword1"><g:message code="testSection.keyword1.label" default="Keyword1" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'keyword1','errors')}">
                                  <input type="text" size="40" maxlength="40" id="keyword1" name="keyword1" value="${fieldValue(bean:testSectionInstance,field:'keyword1')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="keyword2"><g:message code="testSection.keyword2.label" default="Keyword2" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'keyword2','errors')}">
                                  <input type="text" size="40" maxlength="40" id="keyword2" name="keyword2" value="${fieldValue(bean:testSectionInstance,field:'keyword2')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="keyword3"><g:message code="testSection.keyword3.label" default="Keyword3" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'keyword3','errors')}">
                                  <input type="text" size="40" maxlength="40" id="keyword3" name="keyword3" value="${fieldValue(bean:testSectionInstance,field:'keyword3')}"/>
                              </td>
                          </tr>
                          </tbody>
                      </table>
          </div>         <!-- Status tab -->
            <div id="Location">
                      <table>
                          <tbody>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="system"><g:message code="testSection.system.label" default="System" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'system','errors')}">
	                              <g:select name="system"
	                                from="${MrUtils.attrsList('TestSection', 'system').collect{it.encodeAsHTML()}}"
	                                keys="${MrUtils.attrsList('TestSection', 'system').collect{it.encodeAsHTML()}}"
	                                value="${testSectionInstance.system?.encodeAsHTML()}"
	                                noSelection="['':'']"
	                                >
	                              </g:select>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="routeName"><g:message code="testSection.routeName.label" default="Route Name" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'routeName','errors')}">
                                  <input type="text" size="30" maxlength="30" id="routeName" name="routeName" value="${fieldValue(bean:testSectionInstance,field:'routeName')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="route"><g:message code="testSection.route.label" default="Route" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'route','errors')}">
                                  <input type="text" size="30" maxlength="30" id="route" name="route" value="${fieldValue(bean:testSectionInstance,field:'route')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="district"><g:message code="testSection.district.label" default="District" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'district','errors')}">
                                <g:select name="district"
                                  from="${MrUtils.attrsList('TestSection', 'district').collect{it.encodeAsHTML()}}"
                                  keys="${MrUtils.attrsList('TestSection', 'district').collect{it.encodeAsHTML()}}"
                                  value="${testSectionInstance.district?.encodeAsHTML()}"
                                  noSelection="['':'']"
                                  >
                                </g:select>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="county"><g:message code="testSection.county.label" default="County" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'county','errors')}">
                                <g:select name="county"
                                  value="${fieldValue(bean:testSectionInstance,field:'county')}"
                                  from="${County.list()}"
                                  optionValue="countyName"
                                  optionKey="countyName"
                                  noSelection="['':'']"
                               >
                             </g:select>
                                  %{--<input type="text" size="36" maxlength="36" id="county" name="county" value="${fieldValue(bean:testSectionInstance,field:'county')}"/>--}%
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="direction"><g:message code="testSection.direction.label" default="Direction" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'direction','errors')}">
                                  <input type="text" size="6" maxlength="6" id="direction" name="direction" value="${fieldValue(bean:testSectionInstance,field:'direction')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="closestcity"><g:message code="testSection.closestcity.label" default="Closest City" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'closestcity','errors')}">
                                            <g:select name="closestcity"
                                                     from="${grailsApplication.config.cities}"
                                                     value="${testSectionInstance.closestcity}"
                                                     noSelection="${['':'']}"
                                                     />
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="sectionLength"><g:message code="testSection.sectionLength.label" default="Section Length (miles)" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'sectionLength','errors')}">
                                  <input type="text" size="24" maxlength="24" id="sectionLength" name="sectionLength" value="${fieldValue(bean:testSectionInstance,field:'sectionLength')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="beginmp"><g:message code="testSection.beginmp.label" default="Begin Milepoint" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'beginmp','errors')}">
                                  <input type="text" id="beginmp" name="beginmp" value="${fieldValue(bean:testSectionInstance,field:'beginmp')}" />
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="begindesc"><g:message code="testSection.begindesc.label" default="Begin Desciption" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'begindesc','errors')}">
                                  <input type="text" size="120" maxlength="120" id="begindesc" name="begindesc" value="${fieldValue(bean:testSectionInstance,field:'begindesc')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="endmp"><g:message code="testSection.endmp.label" default="End Milepoint" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'endmp','errors')}">
                                  <input type="text" id="endmp" name="endmp" value="${fieldValue(bean:testSectionInstance,field:'endmp')}" />
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="enddesc"><g:message code="testSection.enddesc.label" default="End Description" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'enddesc','errors')}">
                                  <input type="text" size="100" maxlength="100" id="enddesc" name="enddesc" value="${fieldValue(bean:testSectionInstance,field:'enddesc')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="fromLongitude"><g:message code="testSection.fromLongitude.label" default="From Longitude" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'fromLongitude','errors')}">
                                  <input type="text" id="fromLongitude" name="fromLongitude" value="${fieldValue(bean:testSectionInstance,field:'fromLongitude')}" />
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="fromLatitude"><g:message code="testSection.fromLatitude.label" default="From Latitude" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'fromLatitude','errors')}">
                                  <input type="text" id="fromLatitude" name="fromLatitude" value="${fieldValue(bean:testSectionInstance,field:'fromLatitude')}" />
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="toLongitude"><g:message code="testSection.toLongitude.label" default="To Longitude" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'toLongitude','errors')}">
                                  <input type="text" id="toLongitude" name="toLongitude" value="${fieldValue(bean:testSectionInstance,field:'toLongitude')}" />
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="toLatitude"><g:message code="testSection.toLatitude.label" default="To Latitude" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'toLatitude','errors')}">
                                  <input type="text" id="toLatitude" name="toLatitude" value="${fieldValue(bean:testSectionInstance,field:'toLatitude')}" />
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="latLongMethod"><g:message code="testSection.latLongMethod.label" default="Lat Long Method" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'latLongMethod','errors')}">
                                  <input type="text" size="20" maxlength="20" id="latLongMethod" name="latLongMethod" value="${fieldValue(bean:testSectionInstance,field:'latLongMethod')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="truemiles"><g:message code="testSection.truemiles.label" default="True Miles" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'truemiles','errors')}">
                                  <input type="text" id="truemiles" name="truemiles" value="${fieldValue(bean:testSectionInstance,field:'truemiles')}" />
                              </td>
                          </tr>
                          </tbody>
                      </table>
          </div>         <!-- Location tab -->
            <div id="Project">
                      <table>
                          <tbody>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="contractor"><g:message code="testSection.contractor.label" default="Contractor" />:</label>
                              </td>
                              <td colspan="2" valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'contractor','errors')}">
                                  <input type="text" size="60" maxlength="60" id="contractor" name="contractor" value="${fieldValue(bean:testSectionInstance,field:'contractor')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="stateprojectnumber"><g:message code="testSection.stateprojectnumber.label" default="Stateprojectnumber" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'stateprojectnumber','errors')}">
                                  <input type="text" size="20" maxlength="20" id="stateprojectnumber" name="stateprojectnumber" value="${fieldValue(bean:testSectionInstance,field:'stateprojectnumber')}"/>
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable><g:message code="testSection.comments.label" default="Project Comments" />:</lable>
                              </td>
                              <td  valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'comments','errors')}">
                                  <textarea rows="2" cols="40" name="comments">${fieldValue(bean:testSectionInstance, field:'comments')}</textarea>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="layer1"><g:message code="testSection.layer1.label" default="Layer 1" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'layer1','errors')}">
                                  <input type="text" size="40" maxlength="40" id="layer1" name="layer1" value="${fieldValue(bean:testSectionInstance,field:'layer1')}"/>
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable><g:message code="testSection.l1comment.label" default="Layer 1 Comment" />:</lable>
                              </td>
                              <td rowspan="2" valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l1comment','errors')}">
                                  <textarea rows="5" cols="40" name="l1comment">${fieldValue(bean:testSectionInstance, field:'l1comment')}</textarea>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="l1thickness"><g:message code="testSection.l1thickness.label" default="Lyr 1 Thickness" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l1thickness','errors')}">
                                  <input type="text" size="24" maxlength="24" id="l1thickness" name="l1thickness" value="${fieldValue(bean:testSectionInstance,field:'l1thickness')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="layer2"><g:message code="testSection.layer2.label" default="Layer 2" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'layer2','errors')}">
                                  <input type="text" size="40" maxlength="40" id="layer2" name="layer2" value="${fieldValue(bean:testSectionInstance,field:'layer2')}"/>
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable><g:message code="testSection.l2comment.label" default="Lyr 2 Comment" />:</lable>
                              </td>
                              <td rowspan="2" valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l2comment','errors')}">
                                  <textarea rows="5" cols="40" name="l2comment">${fieldValue(bean:testSectionInstance, field:'l2comment')}</textarea>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="l2thickness"><g:message code="testSection.l2thickness.label" default="Lyr 2 Thickness" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l2thickness','errors')}">
                                  <input type="text" size="24" maxlength="24" id="l2thickness" name="l2thickness" value="${fieldValue(bean:testSectionInstance,field:'l2thickness')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="layer3"><g:message code="testSection.layer3.label" default="Layer 3" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'layer3','errors')}">
                                  <input type="text" size="40" maxlength="40" id="layer3" name="layer3" value="${fieldValue(bean:testSectionInstance,field:'layer3')}"/>
                              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable><g:message code="testSection.l3comment.label" default="Lyr 3 Comment" />:</lable>
                              </td>
                              <td rowspan="2" valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l3comment','errors')}">
                                  <textarea rows="2" cols="40" name="l3comment">${fieldValue(bean:testSectionInstance, field:'l3comment')}</textarea>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="l3thickness"><g:message code="testSection.l3thickness.label" default="Lyr 3 Thickness" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l3thickness','errors')}">
                                  <input type="text" size="24" maxlength="24" id="l3thickness" name="l3thickness" value="${fieldValue(bean:testSectionInstance,field:'l3thickness')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="layer4"><g:message code="testSection.layer4.label" default="Layer 4" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'layer4','errors')}">
                                  <input type="text" size="40" maxlength="40" id="layer4" name="layer4" value="${fieldValue(bean:testSectionInstance,field:'layer4')}"/>
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable><g:message code="testSection.l4comment.label" default="Lyr 4 Comment" />:</lable>
                              </td>
                              <td rowspan="2" valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l4comment','errors')}">
                                  <textarea rows="2" size="40" cols="40" name="l4comment">${fieldValue(bean:testSectionInstance, field:'l4comment')}</textarea>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="l4thickness"><g:message code="testSection.l4thickness.label" default="Lyr 4 Thickness" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l4thickness','errors')}">
                                  <input type="text" size="24" maxlength="24" id="l4thickness" name="l4thickness" value="${fieldValue(bean:testSectionInstance,field:'l4thickness')}"/>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="layer5"><g:message code="testSection.layer5.label" default="Layer 5" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'layer5','errors')}">
                                  <input type="text" size="40" maxlength="40" id="layer5" name="layer5" value="${fieldValue(bean:testSectionInstance,field:'layer5')}"/>
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<lable><g:message code="testSection.l5comment.label" default="Lyr 5 Comment" />:</lable>
                              </td>
                              <td rowspan="2" valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l5comment','errors')}">
                                  <textarea rows="2" cols="40" name="l5comment">${fieldValue(bean:testSectionInstance, field:'l5comment')}</textarea>
                              </td>
                          </tr>

                          <tr class="prop">
                              <td valign="top" class="name">
                                  <label for="l5thickness"><g:message code="testSection.l5thickness.label" default="Lyr 5 Thickness" />:</label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'l5thickness','errors')}">
                                  <input type="text" size="24" maxlength="24" id="l5thickness" name="l5thickness" value="${fieldValue(bean:testSectionInstance,field:'l5thickness')}"/>
                              </td>
                          </tr>

                          </tbody>
                      </table>
          </div>          <!-- Project tab -->
            <div id="Testing">
                      <table>
                          <tbody>
                          <tr class="prop">
                              <td valign="top" class="name">
                                <label for="labtesting"><g:message code="testSection.labtesting.label" default="Lab Testing" /></label>
                              </td>
                              <td valign="top" class="value ${hasErrors(bean:testSectionInstance,field:'labtesting','errors')}">
                                  <input type="text" size="160" maxlength="160" id="labtesting" name="labtesting" value="${fieldValue(bean:testSectionInstance,field:'labtesting')}"/>
                              </td>
                          </tr>
                          </tbody>
                      </table>
          </div>         <!-- Testing tab -->
            </div>         <!-- end tabs -->
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </div>
    </body>
</html>
