Install Groovy 1.7 (http://groovy.codehaus.org) and Grails 1.2.2 (http://www.grails.org)

Assume this app is installed at C:\app. 

Database
--------
Setup of the database.  OracleXE scripts are provided, acegiDDL.sql to create security tables (PERSON, REQUESTMAP, AUTHORITY, and AUTHORITY_PERSON) and appddl.sql to create application data tables (APP_CONFIG, COUNTIES and TEST_SECTION).
To use Oracle XE modify the 8080 port Oracle grabs when it installs.  Start SqlPlus and change it to another port like 8081.
C:\>sqlplus / as sysdba
SQL*Plus: Release 10.2.0.1.0 - Production on Sat Jun 10 18:49:14 2006
Copyright (c) 1982, 2005, Oracle.  All rights reserved.
Connected to:
Oracle Database 10g Express Edition Release 10.2.0.1.0 - Production
SQL> exec dbms_xdb.sethttpport(8081);
PL/SQL procedure successfully completed.
SQL>exit
C:\>
Download the oracle JDBC driver into the lib folder. 

To use HSQL as the databse configure a HSQL DB connection in grails-app/conf/DataSource.groovy 

Listing and viewing application data is open to anyone.  Modifying data requires login and permissions.
Uncomment and modify default usernames and passwords in BootStrap.groovy as necessary.

Run grails run-app to download and install required plugins.
Once the database is created and populated with security and application data  and default users are in place comment out the code used to populate security data in grails-app/conf/BootStrap.groovy.

Start the application:
grails run-app
Point your browser to http://localhost:8080/TestSectionTracking

Deployment via Apache web server reverse proxy
Modify file conf/httpd.conf

1. Uncomment these line 
LoadModule headers_module modules/mod_headers.so
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so

2. Modify these lines appropriately
ServerAdmin admin@ad.dot.state.mn.us
#ErrorDocument 404 /missing.html

3. Add these line to the end of file conf/httpd.conf
ProxyPreserveHost On
<Proxy *>
Order Deny,Allow
Deny from all
Allow from dot.state.mn.us
</Proxy>
ProxyPass /mnroad/ http://localhost:9090/mnroad/
ProxyPass /TestSectionTracking/ http://localhost:9090/TestSectionTracking/
ProxyPass /xwiki/ http://localhost:8080/xwiki/

Bootstrap:
//import us.mn.state.dot.secure.Person
//import us.mn.state.dot.secure.Requestmap
//import us.mn.state.dot.secure.Authority

     def authenticateService
     def dataSource

		println "Adding Users"
        def userAdmin = new Person( username:'Carr1Den',
            userRealName:'Dennis Carroll',
            enabled: true,
            emailShow: true,
            email: 'dennis.carroll@state.mn.us',
            description:'A MnRoad Administrator',
            passwd: authenticateService.encodePassword('admin')).save()

         def userStaff = new Person(username:'Wore1Ben',
             userRealName:'Ben Worel',
             enabled: true,
             emailShow: true,
             email: 'Ben.Worel@dot.state.mn.us',
             description:'A MnRoad Maintainer',
             passwd: authenticateService.encodePassword('staff')).save()

         def userRegistered = new Person(username:'user',
             userRealName:'Some roadie',
             enabled: true,
             emailShow: true,
             email: 'c@hotmail.com',
             description:'A MnRoad User',
             passwd: authenticateService.encodePassword('user')).save()
// Permissions for user management
        def secureUserEdit = new Requestmap(url: '/person/edit/*', configAttribute:'ROLE_ADMIN, ROLE_STAFF').save()
        def secureUserSave = new Requestmap(url: '/person/save', configAttribute:'ROLE_ADMIN, ROLE_STAFF').save()
        def secureUserCreate = new Requestmap(url: '/person/create', configAttribute:'ROLE_ADMIN, ROLE_STAFF').save()
        def secureUserList = new Requestmap(url: '/person/list', configAttribute:'ROLE_ADMIN, ROLE_STAFF').save()

        def secureRoleEdit = new Requestmap(url: '/authority/edit/*', configAttribute:'ROLE_ADMIN').save()
        def secureRoleSave = new Requestmap(url: '/authority/save', configAttribute:'ROLE_ADMIN').save()
        def secureRoleCreate = new Requestmap(url: '/authority/create', configAttribute:'ROLE_ADMIN').save()
        def secureRoleList = new Requestmap(url: '/authority/list', configAttribute:'ROLE_ADMIN').save()

        def secureRequestmapEdit = new Requestmap(url: '/requestmap/edit/*', configAttribute:'ROLE_ADMIN').save()
        def secureRequestmapSave = new Requestmap(url: '/requestmap/save', configAttribute:'ROLE_ADMIN').save()
        def secureRequestmapCreate = new Requestmap(url: '/requestmap/create', configAttribute:'ROLE_ADMIN').save()
        def secureRequestmapList = new Requestmap(url: '/requestmap/list', configAttribute:'ROLE_ADMIN').save()

// Permissions for test section tracking
//        def secureTestSectionList = new Requestmap(url: '/testSection/list', configAttribute:'ROLE_ADMIN, ROLE_STAFF, ROLE_USER').save()
//        def secureTestSectionListSelected = new Requestmap(url: '/testSection/listSelected', configAttribute:'ROLE_ADMIN, ROLE_STAFF, ROLE_USER').save()
//        def secureTestSectionShow = new Requestmap(url: '/testSection/show', configAttribute:'ROLE_ADMIN, ROLE_STAFF, ROLE_USER').save()
        def secureTestSectionEdit = new Requestmap(url: '/testSection/edit/**', configAttribute:'ROLE_ADMIN, ROLE_STAFF').save()
        def secureTestSectionCreate = new Requestmap(url: '/testSection/create', configAttribute:'ROLE_ADMIN, ROLE_STAFF').save()
        def secureTestSectionUpdate = new Requestmap(url: '/testSection/update/**', configAttribute:'ROLE_ADMIN, ROLE_STAFF').save()

         //new Requestmap(url: '/runtimelogging/**', configAttribute: 'ROLE_ADMIN').save()

        //Adding Roles
        def roleAdmin = new Authority(authority:'ROLE_ADMIN', description:'App admin').save()
        def roleStaff  = new Authority(authority:'ROLE_STAFF', description:'MnRoad staff user').save()
        def roleUser  = new Authority(authority:'ROLE_USER', description:'App user').save()

         //Note that here we associate users with their respective roles
        roleAdmin.addToPeople(userAdmin)
        roleStaff.addToPeople(userStaff)
        roleUser.addToPeople(userRegistered)
        
        println "******************************************************"
        println "******************************************************"
        println "**  Security system initialized.  Change Bootstrap. **"
        println "******************************************************"
        println "******************************************************"
