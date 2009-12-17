<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Dashboard for Basic Webapp</title>		
		<s:include value="commons/meta.jsp"/>
		<link rel="stylesheet" type="text/css"  href="<s:url value='/css/dashboard/default.css' includeParams='none' encode='false'/>"/>
		<style>		
			#main {height: 400px;}				
		</style>
		<script type="text/javascript">			
		</script>
	</head>
	<body>
		<div class="container">
			<div class="header">

				<div class="title">
					<h1>Basic Webapp</h1>
				</div>
		
				<div class="navigation">
					<a href="#">Vestibulum</a>
					<a href="#">Suspendisse</a>
					<a href="#">Elemen</a>
					<div class="clearer"><span></span></div>
				</div>				
			</div>
			<div class="main" id="main">
				<div class="content">
					<p>Main Content Here.</p>
				</div>
				<div class="sidenav">
					<p>Side Nav Here.</p>
				</div>
				<div class="clearer"><span></span></div>
			</div>			
		</div>
		<div class="footer">&copy; 2006 <a href="#">Aixol.com</a>. 
		</div>
	</body>
</html>
