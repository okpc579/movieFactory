<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
#mine,#yours{
   height: 50px;
   width: 100px;
}
</style>
</head>
<body>
<div id="section">
<button id="mine" class="btn btn-info" type="button">내소식</button>
<button id="yours" class="btn btn-info" type="button">니소식</button>
<div id="alarm">
</div>
</div>
</body>
</html>