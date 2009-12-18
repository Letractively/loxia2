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
				/*
				var errorMessage = "";
				if($j(".errorMessage").length > 0) {
					errorMessage = $j(".errorMessage").html();
					if(errorMessage != null && errorMessage != "") {
						parent.errorMsg.innerHTML = '<p>' + errorMessage + '</p>';
						parent.panelCtl.click();
						return;
				    }	
				}	
				var exceptionMsg = $j("#uploadErrorMsg").html();	
				if(exceptionMsg != null && exceptionMsg != "") {	
					parent.errorMsg.innerHTML = exceptionMsg;
					parent.panelCtl.click();
					return;
				}	
				if($j("#isUpload").html() != "") {
					if($j("#attachmentId").html() != "" && parent.document.getElementById("newAttId") != null) {		
					  parent.document.getElementById("newAttId").value = $j("#attachmentId").html(); 
					}
					parent.goNext();		
				} 	 
				
				if($j("#projectGroupReportFieldInfoId").html() != ""){
					parent.downloadCtl.click();
				} */
			});	
			
		</script>
	</head>
	<body>
	<!-- 
		<s:fielderror/>
		<div id="uploadErrorMsg"><s:property value="exception.message"/></div>
		<div id="isUpload">${isUpload}</div>
		<div id="attachmentId">${attachmentId}</div>
		<div id="projectGroupReportFieldInfoId">${projectGroupReportFieldInfoId}</div>
	 -->
	</body>
</html>
