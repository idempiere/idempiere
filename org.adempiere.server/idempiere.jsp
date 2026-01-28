<%@ page import="org.bmlaurus.home.Prop" %>
<%
    Prop.load();
    String homepage = Prop.getProperty(Prop.HOMEPAGE);
%>

<jsp:include page="<%= homepage %>" />
