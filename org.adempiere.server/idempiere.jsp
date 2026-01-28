<%@ page import="org.bmlaurus.home.Prop" %>
<%
    Prop.load();
    String homepage = Prop.getProperty(Prop.HOMEPAGE);
    if (homepage == null || !homepage.matches("^idempiere-\\d+\\.jsp$")) {
		homepage = "idempiere-13.jsp";
	}
%>

<jsp:include page="<%= homepage %>" />
