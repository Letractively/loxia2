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
			function getTimeUrl(url){
				var iTime=(new Date()).getTime();
				if (url.indexOf("loxiaflag=") >= 0 ){
					url = url.replace(/loxiaflag=\d{13}/, "loxiaflag="+iTime.toString());
					return url ;
				}

				url+=(/\?/.test(url)) ? "&" : "?";
				return (url+"loxiaflag="+iTime.toString());
			};
			$j(document).ready(function(){
				var errorMessage = $j("#errorMsg").val();
				if(!errorMessage){
<s:if test="#request.userInformation != null">		
					$j("div[name='attachInfo'] img").attr("src",getTimeUrl($j("div[name='attachInfo'] img").attr("src")));
					parent.$portrait.html($j("div[name='attachInfo']").html());
					parent.$userlistTable.reload();
</s:if>
				}
			});	
			
		</script>
	</head>
	<body>
	<s:hidden name="errorMsg" id="errorMsg" value="%{#request.errorMessage}"/>
	<s:if test="#request.userInformation != null">
		<div name="attachInfo"><img src='<s:url value="/commons/userportrait"/>/<s:property value="#request.userInformation.id"/>.jpg'></img></div>
	</s:if>	
	</body>
</html>
