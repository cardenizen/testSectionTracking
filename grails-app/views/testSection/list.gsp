
<%@ page import="us.mn.state.dot.testSectionTracking.TestSection" %>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta name="layout" content="main" />

      <g:set var="entityName" value="${message(code: 'testSection.label', default: 'Test Section')}" />
      <title><g:message code="default.list.label" args="[entityName]" /></title>

      <export:resource />
    </head>
    <body>
        <div class="nav">
          <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
          <g:if test="${request.isUserInRole('ROLE_ADMIN') || request.isUserInRole('ROLE_STAFF')}">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
         </g:if>
        </div>
        <div class="body">
            <h1>TestSection List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                          <g:sortableColumn property="id" title="${message(code: 'testSection.id.label', default: 'Id')}" />
                          <g:sortableColumn property="groupname" title="${message(code: 'testSection.groupname.label', default: 'Groupname')}" />
                          <g:sortableColumn property="section" title="${message(code: 'testSection.section.label', default: 'Section')}" />
                          <g:sortableColumn property="sectioncontact" title="${message(code: 'testSection.sectioncontact.label', default: 'Sectioncontact')}" />
                          <g:sortableColumn property="routeName" title="${message(code: 'testSection.routeName.label', default: 'Route Name')}" />
                          <g:sortableColumn property="system" title="${message(code: 'testSection.system.label', default: 'System')}" />
                          <g:sortableColumn property="county" title="${message(code: 'testSection.county.label', default: 'County')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${testSectionInstanceList}" status="i" var="testSectionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${testSectionInstance.id}">${fieldValue(bean:testSectionInstance, field:'id')}</g:link></td>
                            <td>${fieldValue(bean:testSectionInstance, field:'groupname')}</td>
                            <td>${fieldValue(bean:testSectionInstance, field:'section')}</td>
                            <td>${fieldValue(bean:testSectionInstance, field:'sectioncontact')}</td>
                            <td>${fieldValue(bean:testSectionInstance, field:'routeName')}</td>
                            <td>${fieldValue(bean:testSectionInstance, field:'system')}</td>
                            <td>${fieldValue(bean:testSectionInstance, field:'county')}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
          <!-- Added for the export plugin -->
          <export:formats formats="['excel', 'xml']" />
            <div class="paginateButtons">
                <g:paginate total="${TestSection.count()}" />
            </div>
        </div>
    </body>
</html>
