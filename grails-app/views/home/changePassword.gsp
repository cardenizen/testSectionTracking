<head>
    <meta name="layout" content="main" />
    <title>Change Password</title>
    <nav:resources override="true"/>
</head>

<body onload="document.changePasswordForm.pass.focus();">
    <div class="nav">
        <nav:renderSubItems group="nav"/>
    </div>

    <div class="body">
        <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${personInstance}">
        <div class="errors">
            <g:renderErrors bean="${personInstance}" as="list" />
        </div>
        </g:hasErrors>

            <g:form name="changePasswordForm" id="changePasswordForm">
                <div class="dialog">
                    <table>
                        <tbody>

                        <tr class="prop">
                            <td valign="top" class="name"><label for="pass">Password:</label></td>
                            <td valign="top" class="value ${hasErrors(bean:personInstance,field:'pass','errors')}">
                                <input type="password" id="pass" name="pass" />
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><label for="confirmPass">Confirm password:</label></td>
                            <td valign="top" class="value">
                                <input type="password" id="confirmPass" name="confirmPass" />
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>

            <div class="buttons">
                <span class="button"><g:actionSubmit class="save" value="Change Password" action="changePassword"/></span>
            </div>
        </g:form>

    </div>

</body>
