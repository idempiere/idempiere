<!DOCTYPE html>
<html>
<head>
<title>OAuth2 Callback Process</title>
</head>
<body>
	<script type="text/javascript">
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        const msg = urlParams.get('msg');
        const error = urlParams.get('error');
        if (error != null) {
            document.write("<h3>There was an error:<br></h3><h4><p style=\"color:red\">" + error + "</p></h4>");
        } else {
            document.write("<h3>" + msg + "</h3>");
        }
        document.write("<br>This window can be closed safely now.");
    </script>
</body>
</html>