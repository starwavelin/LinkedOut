<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />

<link rel="stylesheet" type="text/css" href="./css/bootstrap-responsive.css" />
<link rel="stylesheet" type="text/css" href="./css/bootstrap-responsive.min.css" />
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="./css/punch.css" />

<script src="./js/jquery-1.9.1.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/bootstrap.js"></script>
<script src="./js/punch.js"></script>

<title>Linked Out</title>
</head>
<body> 
	<div class="container">
		<div class="navbar navbar-fixed-top">
			<div class="navbar-inner">
				<div class="container">
					<ul class="nav">
						<li class="active"><a class="brand">Linked Out</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row-fluid">
				
				<div class="span3" style="magin-top: 70px">
					<ul id="query_chosen">
						<li><a href="#">Q1: Endorsement pairs sharing a common organization on 09/18/2013</a></li>
						<li><a href="#">Q2: Highly qualified endorsements</a></li>
						<li><a href="#">Q3: Users endorsed for unclaimed skills</a></li>
						<li><a href="#">Q4: Strictly more skilled users</a></li>
						<li><a href="#">Q5: Strictly more certified users</a></li>
						<li><a href="#">Q6: Indirect endorsements</a></li>
						<li><a href="#">Q7: Skill-descending indirect endorsements</a></li>
					</ul>
				</div>
				
				<div class="span9" style="magin-top: 70px">
					<div id="result"></div>
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>