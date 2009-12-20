<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
		<meta http-equiv="Cache-Control" content="no-store"/>
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Expires" content="0"/>

		<script type="text/javascript" src="<s:url value='/scripts/jquery-1.3.2.min.js' includeParams='none' encode='false'/>"></script>

		<script type="text/javascript">		
			var $j = jQuery.noConflict();
			
			$j(document).ready(function(){
				var errorMessage = $j("#errorMsg").val();
				if(!errorMessage){
<s:if test="#request.userInformation != null">
					parent.$portrait.html($j("div[name='attachInfo']").html());
</s:if>
				}
			});	
			
		</script>
	</head>
	<body>
	<s:hidden name="errorMsg" id="errorMsg" value="%{#request.errorMessage}"/>
	<s:if test="#request.userInformation != null">
		<div name="attachInfo"><img src='<s:url value="/commons/getattachment.do"/>?userInfoIdForPortrait=<s:property value="#request.userInformation.id"/>'></img></div>
	</s:if>	
	</body>
</html>
