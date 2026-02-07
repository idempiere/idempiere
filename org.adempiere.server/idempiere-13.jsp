<%@ page import="org.bmlaurus.home.Prop" %>
<!--
Theme Name: iDempiere 13 Theme
Version: 1.0
Description: iDempiere 13 Theme
Author: Zuhri Utama
Author URI: https://zuhriutama.com
-->
<html>
<% Prop.load(); %>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=Prop.getPropertyEscaped(Prop.TITLE) %></title>
    <link rel="icon" href="<%=Prop.getImage("favicon.ico")%>" type="image/x-icon">
    <link href="/resources/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="<%=Prop.loadCss()%>">
</head>

<body>
    <div class="col-lg-12 mx-auto p-2 p-md-5">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
              <div class="navbar-brand d-flex flex-column">
                <span class="fs-4"><%=Prop.getPropertyEscaped(Prop.CLIENT_NAME)%></span>
                <span class="fs-6"><%=Prop.getPropertyEscaped(Prop.CREDITS_TXT)%></span>
              </div>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="menu">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="<%=Prop.getPropertyEscaped(Prop.OPTION_LINK)%>"><%=Prop.getPropertyEscaped(Prop.OPTION_TEXT)%></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="<%=Prop.getPropertyEscaped(Prop.FELIX_LINK)%>"><%=Prop.getPropertyEscaped(Prop.FELIX_TEXT)%></a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="<%=Prop.getPropertyEscaped(Prop.MONITOR_LINK)%>"><%=Prop.getPropertyEscaped(Prop.MONITOR_TEXT)%></a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
        <main class="content">
            <div class="row">
                <div class="col-12 text-center">
                    <a href="<%=Prop.getPropertyEscaped(Prop.WEBUI_LINK)%>" target="_self" class="btn bg-button p-4 rounded-3 d-flex flex-column justify-content-center align-items-center main-button">
                        <img src="<%=Prop.getImage("idempiere-logo.png")%>" alt="iDempiere" style="min-height: 300px;" class="d-none d-md-block">
                        <img src="<%=Prop.getImage("idempiere-square.png")%>" alt="iDempiere" class="d-block d-md-none img-fluid">
                        <span class="fs-1 fs-md-2 mt-2"><%=Prop.getPropertyEscaped(Prop.WEBUI_TEXT)%></span>
                    </a>
                </div>
                <div class="col-12 text-center">
                    <div class="d-flex justify-content-between flex-wrap gap-3 my-4">
                        <a href="<%=Prop.getPropertyEscaped(Prop.SUPPORT_LINK)%>" target="_blank" class="btn bg-button secondary-button d-flex flex-column align-items-center px-4 py-3 flex-fill">
                            <img src="<%=Prop.getImage("support.png")%>" alt="<%=Prop.getPropertyEscaped(Prop.LOCAL_TEXT)%>" class="mb-2">
                            <span><%=Prop.getPropertyEscaped(Prop.LOCAL_TEXT)%></span>
                        </a>
                        <a href="<%=Prop.getPropertyEscaped(Prop.RESOURCE_LINK)%>" target="_blank" class="btn bg-button secondary-button d-flex flex-column align-items-center px-4 py-3 flex-fill">
                            <img src="<%=Prop.getImage("resource.png")%>" alt="<%=Prop.getPropertyEscaped(Prop.RESOURCE_TEXT)%>" class="mb-2">
                            <span><%=Prop.getPropertyEscaped(Prop.RESOURCE_TEXT)%></span>
                        </a>
                        <a href="<%=Prop.getPropertyEscaped(Prop.WIKI_LINK)%>" target="_blank" class="btn bg-button secondary-button d-flex flex-column align-items-center px-4 py-3 flex-fill">
                            <img src="<%=Prop.getImage("wiki.png")%>" alt="<%=Prop.getPropertyEscaped(Prop.WIKI_TEXT)%>" class="mb-2">
                            <span><%=Prop.getPropertyEscaped(Prop.WIKI_TEXT)%></span>
                        </a>
                        <a href="<%=Prop.getPropertyEscaped(Prop.FORUMS_LINK)%>" target="_blank" class="btn bg-button secondary-button d-flex flex-column align-items-center px-4 py-3 flex-fill">
                            <img src="<%=Prop.getImage("forum.png")%>" alt="<%=Prop.getPropertyEscaped(Prop.FORUMS_TEXT)%>" class="mb-2">
                            <span><%=Prop.getPropertyEscaped(Prop.FORUMS_TEXT)%></span>
                        </a>
                        <a href="<%=Prop.getPropertyEscaped(Prop.SUPPORTREQ_LINK)%>" target="_blank" class="btn bg-button secondary-button d-flex flex-column align-items-center px-4 py-3 flex-fill">
                            <img src="<%=Prop.getImage("issue.png")%>" alt="<%=Prop.getPropertyEscaped(Prop.SUPPORTREQUEST_TEXT)%>" class="mb-2">
                            <span><%=Prop.getPropertyEscaped(Prop.SUPPORTREQUEST_TEXT)%></span>
                        </a>
                    </div>
                </div>
            </div>
        </main>
        <footer class="">
            <div class="row">
                <div class="col-12 col-md-5">
                    <p class="text-center text-md-start fs-6">iDempiere license is <a href="http://www.gnu.org/licenses/gpl-2.0.html" target="_blank">GPLv2</a> <%=Prop.getPropertyEscaped(Prop.COPYRIGHT_TXT)%></p>
                </div>
                <div class="col-12 col-md-2 d-flex justify-content-center align-items-center gap-2">
                    <%if(!Prop.getPropertyEscaped(Prop.SOC_FACEBOOK).equals("") && !Prop.getPropertyEscaped(Prop.SOC_FACEBOOK).equals("NONE")){%>
                        <a id="facebook" href="<%=Prop.getPropertyEscaped(Prop.SOC_FACEBOOK)%>" target="_blank" aria-label="Facebook" title="Facebook">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#3b5998" viewBox="0 0 24 24">
	                            <path d="M22.675 0h-21.35C.595 0 0 .592 0 1.326v21.348C0 23.406.595 24 1.325 24H12.82v-9.294H9.692v-3.622h3.128V8.413c0-3.1 1.893-4.788 4.659-4.788 1.325 0 2.463.099 2.797.143v3.24l-1.918.001c-1.504 0-1.797.715-1.797 1.763v2.312h3.587l-.467 3.622h-3.12V24h6.116C23.406 24 24 23.406 24 22.674V1.326C24 .592 23.406 0 22.675 0"/>
	                        </svg>
                        </a>
                    <%} if(!Prop.getPropertyEscaped(Prop.SOC_TWITTER).equals("") && !Prop.getPropertyEscaped(Prop.SOC_TWITTER).equals("NONE")){%>
                        <a id="twitter" href="<%=Prop.getPropertyEscaped(Prop.SOC_TWITTER)%>" target="_blank" aria-label="Twitter" title="Twitter">
                            <svg fill="#DC7633" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="32"
	                        zoomAndPan="magnify" viewBox="0 0 375 374.9999" height="32" preserveAspectRatio="xMidYMid meet" version="1.0">
	                        <defs>
	                            <path d="M 7.09375 7.09375 L 367.84375 7.09375 L 367.84375 367.84375 L 7.09375 367.84375 Z M 7.09375 7.09375 "
	                            fill="#000000"></path>
	                        </defs>
	                        <g>
	                            <path
	                            d="M 187.46875 7.09375 C 87.851562 7.09375 7.09375 87.851562 7.09375 187.46875 C 7.09375 287.085938 87.851562 367.84375 187.46875 367.84375 C 287.085938 367.84375 367.84375 287.085938 367.84375 187.46875 C 367.84375 87.851562 287.085938 7.09375 187.46875 7.09375 "
	                            fill-opacity="1" fill-rule="nonzero" fill="#000000"></path>
	                        </g>
	                        <g transform="translate(85, 75)"> <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" version="1.1"
	                            height="215" width="215">
	                            <path
	                                d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"
	                                fill="#ffffff"></path>
	                            </svg> </g>
	                        </svg>
                        </a>
                    <%} if(!Prop.getPropertyEscaped(Prop.SOC_LINKEDIN).equals("") && !Prop.getPropertyEscaped(Prop.SOC_LINKEDIN).equals("NONE")){%>
                        <a id="linkedin" href="<%=Prop.getPropertyEscaped(Prop.SOC_LINKEDIN)%>" target="_blank" aria-label="LinkedIn" title="LinkedIn">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#0077b5" viewBox="0 0 24 24">
	                            <path d="M22.23 0H1.77C.792 0 0 .775 0 1.729V22.27C0 23.225.792 24 1.77 24h20.46c.978 0 1.77-.775 1.77-1.729V1.729C24 .775 23.208 0 22.23 0zM7.12 20.452H3.56V9h3.56v11.452zM5.34 7.658c-1.145 0-2.07-.927-2.07-2.069 0-1.143.925-2.069 2.07-2.069s2.07.926 2.07 2.069c0 1.142-.925 2.069-2.07 2.069zM20.452 20.452h-3.56v-5.605c0-1.336-.024-3.054-1.863-3.054-1.863 0-2.148 1.453-2.148 2.956v5.703h-3.559V9h3.419v1.561h.048c.476-.9 1.637-1.849 3.37-1.849 3.604 0 4.27 2.37 4.27 5.455v6.285z"/>
	                        </svg>
                        </a>
                    <%} if(!Prop.getPropertyEscaped(Prop.SOC_5).equals("") && !Prop.getPropertyEscaped(Prop.SOC_5).equals("NONE")){%>
                        <a id="soc5" href="<%=Prop.getPropertyEscaped(Prop.SOC_5)%>" target="_blank">
                            <img name="img_soc5" src="<%=Prop.getImage("img_soc5.png")%>" border="0"/>
                        </a>
                    <%} if(!Prop.getPropertyEscaped(Prop.SOC_6).equals("") && !Prop.getPropertyEscaped(Prop.SOC_6).equals("NONE")){%>
                        <a id="soc6" href="<%=Prop.getPropertyEscaped(Prop.SOC_6)%>" target="_blank">
                            <img name="img_soc6" src="<%=Prop.getImage("img_soc6.png")%>" border="0"/>
                        </a>
                    <%} if(!Prop.getPropertyEscaped(Prop.SOC_7).equals("") && !Prop.getPropertyEscaped(Prop.SOC_7).equals("NONE")){%>
                        <a id="soc7" href="<%=Prop.getPropertyEscaped(Prop.SOC_7)%>" target="_blank">
                            <img name="img_soc7" src="<%=Prop.getImage("img_soc7.png")%>" border="0"/>
                        </a>
                    <%}%>
                </div>
                <div class="col-12 col-md-5">
                    <p class="text-center text-md-end fs-6 mt-2 mt-md-0">&copy; Copyright 2013-<%=Prop.getYear()%> iDempiere - All rights reserved</p>
                </div>
            </div>
        </footer>
    </div>
    <script src="/resources/bootstrap/bootstrap.bundle.min.js" type="text/javascript">
    </script>
</body>

</html>
