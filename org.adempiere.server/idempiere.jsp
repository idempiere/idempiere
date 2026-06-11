<%@ page import="org.bmlaurus.home.Prop" %>
<%
    Prop.load();
    String homepage = Prop.getProperty(Prop.HOMEPAGE);
    // Validate homepage to prevent path traversal attacks
    if (homepage == null
            || !(homepage.endsWith(".jsp") || homepage.endsWith(".html"))
            || homepage.contains("/")
            || homepage.contains("\\")
        ) {
            homepage = "idempiere-13.jsp";
        }
%>

<jsp:include page="<%= homepage %>" />
