<html>
    <head>
      <title><g:layoutTitle default="Grails" /></title>
      <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
      <style type="text/css">
          /*margin and padding on body element
            can introduce errors in determining
            element position and are not recommended;
            we turn them off as a foundation for YUI
            CSS treatments. */
      body {
          margin: 0;
          padding: 0;
      }
      </style>
      <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
      <link rel="stylesheet" type="text/css" href="${createLinkTo(dir: 'css', file: 'mnr.css')}" />
<!--
     For http://www.dot.state.mn.us
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RTT8_Qm7M4UCH7k6qm_BXRX6NlBURQSh1psxtg60P2ROcGtUJW5XWIa6Q
     For http://www.mrrapps.dot.state.mn.us
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RTHjWGBMjaG5qYsnbqzVi_Fsp04_hRwltvEh0s7KhJd6HSYxlX2AYs7Pw
     For http://mrl2k3dev.ad.dot.state.mn.us/
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RRRlJehMydlFp336_1qcWn0B_tTWRSDn6pLqlbefq2tmGSX2QvdpZbl_Q
     For http://localhost
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RT2yXp_ZAY8_ufC3CFXhHIE1NvwkxTDIQlwf2DZ2gVRWAnInOwLUaHDrw
     For http://mrl2k3loader.ad.dot.state.mn.us
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RTLIkq013gk22Adx5Fd1nd9xqsRSxRq8r5f9kZu0hGPAdKNbt7T107GGg
     For http://mrlxpw017.ad.dot.state.mn.us
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RSD7tuHJ4J0QBGBYRYu8k0kYVQEoxR4_HcqC_CQgVFFZ7n8rX3Usk7R9A
     For http://mrl2k3loader.ad.dot.state.mn.us/TestSectionTracking/
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RRt_2dAUsbIFMj7ueGjcTNTKmVyUhT_Mg2XiYk75RZdiIZCxsNt7U6Tng
     for http://dotapp6.dot.state.mn.us
       ABQIAAAAPZMJngdDwEVH8HNIYrfX4RTmw4c9U-rCtHDeDsV0tROf_L4ifhSCyahUSQuLDvVHiRRIaWAM3GZ10w
-->            
      <g:layoutHead />
      <g:javascript src="jquery/jquery-1.3.2.js" />
      <g:javascript src="jquery/jquery-ui-1.7.2.js" />
      <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAPZMJngdDwEVH8HNIYrfX4RTmw4c9U-rCtHDeDsV0tROf_L4ifhSCyahUSQuLDvVHiRRIaWAM3GZ10w" type="text/javascript"></script>
      <g:javascript library="application" />
    </head>
    <body onload="loadMap()">
      <div style="display: table; #position: relative; overflow: hidden;">
      <div style=" height:50px;">
          <img src="${createLinkTo(dir:'images',file:'mnroad.jpg')}" alt="MnRoad"
            STYLE="position:relative; overflow: scroll; WIDTH: 230px; HEIGHT: 50px; LEFT: 0px; TOP: 0px;" />
          </div>
          <div  class="appHeader" style="  HEIGHT: 50px; #position: absolute; LEFT: 230px; TOP: 0px; display: table-cell; vertical-align: middle;">
            MnDOT / LRRB Test Section Tracking  <br>            
          <span class="menuButton"><mr:signOutLink/></span>
          </div>
      </div>
      <div id="spinner" class="spinner" style="display:none;">
        <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
      </div>
      <div style="padding: 0px 0px">
        <table><tbody><tr><td>
        <g:layoutBody />
          </td></tr></tbody></table>
      </div>

      <div class='footer'>
        <div class='footer-left'>
          <p>
          <g:if test="${grailsApplication?.metadata['app.version']}">
            v${grailsApplication.metadata['app.version']}
            (Build #${grailsApplication.metadata['app.buildNumber']}
                ${grailsApplication.metadata['app.buildDate']}
                ${grailsApplication.metadata['app.buildProfile']})
          </g:if>

          %{--<a href="http://www.dot.state.mn.us/mnroad/">MnRoad</a> ${grailsApplication.getMetadata()['app.name']} ${grailsApplication.getMetadata()['app.version']} --}%
	%{--<g:meta name="app.environment"></g:meta>--}%
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          </p>
        </div>
          <div class='footer-left'>
            <p>
          Brought to you by the <a href="http://www.lrrb.org">Minnesota Local Road Research Board</a> in cooperation with the <a href="http://www.dot.state.mn.us/">Minnesota Department of Transportation</a>.
          </p>
        </div>
<%--     using session causes IllegalStateException
        <div class='footer-right'>Powered by <a href="http://grails.org/">Grails</a><g:if test="${session.servletContext['grailsVersion']}">&nbsp;${session.servletContext['grailsVersion']}</g:if></div>
          <g:if test="${session.servletContext['dbenv']}">Database: <b>${session.servletContext["dbenv"]}</b></g:if>
--%>
      </div>

    </body>
</html>