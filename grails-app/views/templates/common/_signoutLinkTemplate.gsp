<g:isLoggedIn>Logged in as: <g:loggedInUserInfo field="username">Not logged in user</g:loggedInUserInfo>
(<g:link controller="logout" action="index">Sign out</g:link>&nbsp;<a href="${createLink(action:'changePassword')}">Change Password</a>)
</g:isLoggedIn>
<g:isNotLoggedIn><g:link controller="login">Sign In</g:link></g:isNotLoggedIn>
