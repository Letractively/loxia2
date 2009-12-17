<%@ taglib prefix="s" uri="/struts-tags"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>

<link rel="stylesheet" type="text/css"  href="<s:url value='/css/jquery-ui-1.7.2.custom.css' includeParams='none' encode='false'/>"/>
<link rel="stylesheet" type="text/css"  href="<s:url value='/css/main.css' includeParams='none' encode='false'/>"/>
<script type="text/javascript" src="<s:url value='/scripts/jquery-1.3.2.min.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<s:url value='/scripts/jquery-ui-1.7.2.custom.min.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<s:url value='/scripts/jquery.bgiframe.min.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<s:url value='/scripts/jquery.livequery.js' includeParams='none' encode='false'/>"></script>
<script type="text/javascript" src="<s:url value='/scripts/jquery.loxia-1.1.min.js' includeParams='none' encode='false'/>"></script>

<script type="text/javascript">
	var $j = jQuery.noConflict();
	
	$j(document).ready(function(){
		loxia.init({debug: true});		
	});	
</script>