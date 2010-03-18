<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Desktop</title>
		<style>			
		</style>
		<jsp:include page="commons/meta.jsp" flush="true"></jsp:include>
		<script type="text/javascript">
			$j(document).ready(function(){
				$j("#errorBtn").click(function(){
					var data = loxia.syncXhrGet("${pageContext.request.contextPath}/error",{data: {}});		
					console.dir(data);			
					});
			});
			
		</script>
	</head>
	<body>
		<input type="button" id="errorBtn" value="Go Error!" />
	</body>
</html>