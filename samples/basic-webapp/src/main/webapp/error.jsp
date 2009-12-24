<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Errors</title>		
		<s:include value="commons/meta.jsp"/>
	</head>
	<body>
		<s:actionerror/>
		<s:fielderror/>
		<ul>
		<s:iterator value="#request.exception.errorMessages">
			<li><s:property/></li>
		</s:iterator>
		</ul>
		<p></p>
		<pre>
			<s:property value="#request.exception.stackTrace"/>
		</pre>
	</body>
</html>