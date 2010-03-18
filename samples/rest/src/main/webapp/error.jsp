<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Error</title>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
		<meta http-equiv="Cache-Control" content="no-store"/>
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Expires" content="0"/>
		
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/css/jquery-ui-1.7.2.custom.css"/>
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/css/main.css"/>
	</head>
	<body>
		<p>Exception:</p>
		<p>${exception.errorCode}</p>
	</body>
</html>