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
  <style>
  </style>
<script>
var strArray;
var collections;
var page;
var username="";
var mno="";

function printPaging(result) {
	//$("#pagination>*").remove(); 
	var pageno = page;
	var pagesize = 10;
	var totalcount = result.totalcount;
	var pagesPerBlock = 10;
	var cntOfPage = totalcount/pagesize + 1;
	if(totalcount%pagesize==0) cntOfPage--;
	var blockNo = Math.floor((pageno-1)/pagesPerBlock);
	var startPage = blockNo * pagesPerBlock + 1;
	var endPage = startPage + pagesPerBlock - 1;
	if(endPage>cntOfPage)
		endPage = cntOfPage;
	
	var $pagination = $("#pagination");	
	if(username!="")
		var serverUrl = "http://localhost:8081/moviefactory/collection/list?username="+ username+"&pageno=";
	else if(mno!="")
		var serverUrl = "http://localhost:8081/moviefactory/collection/list?mno=" +mno +"&pageno=";
	console.log("페이징함수 들어옴");
	
	
	
	var pagearr = new Array();
	for(var i=startPage;i<=endPage; i++){
		pagearr[i]=i;
	}
	if(blockNo>0) {
		var $li = $("<li>").attr("class","previous").appendTo($pagination);
		$("<a>").attr("href", serverUrl + (startPage-1)).text("<").appendTo($li);		
	}
	for(var i=startPage; i<=endPage; i++) {
		if(pageno==i) {
			var $li = $("<li>").attr("class","active").appendTo($pagination);
			$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
			} 
		else{
			var $li = $("<li>").appendTo($pagination);
			$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
		}
	}
	if(endPage<cntOfPage) {
		var $li = $("<li>").attr("class","next").appendTo($pagination);
		$("<a>").attr("href", serverUrl + (endPage+1)).text(">").appendTo($li);
	}
}






function printData() {
	var $body = $("#list");
	$.each(collections, function(i, collection) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(collection.collIntro).appendTo($tr);
		$("<td>").text(collection.collName).appendTo($tr);
		$("<td>").text(collection.collNo).appendTo($tr);
		$("<td>").text(collection.username).appendTo($tr);
		$("<td>").text(collection.writingDate).appendTo($tr);
		var $td = $("<td>").appendTo($tr)
		$("<a>").attr("href","/moviefactory/collection/read?collNo=" + collection.collNo).text("링크열기").appendTo($td);
		
	});
}




$(function() {
	console.log(location.search.split('&'));
	strArray = location.search.split('&');
	console.log(strArray[0].split('=')[0]);
	console.log(strArray[1].split('=')[0]);
	console.log(strArray[0].split('=')[1]);
	console.log(strArray[1].split('=')[1]);
	page=strArray[1].split('=')[1];
	if(strArray[0].split('=')[0]=='?mno'){
		mno=strArray[0].split('=')[1];
		$.ajax({
			url: "/moviefactory/api/collection/list?mNo=" + strArray[0].split('=')[1] + "&pageno=" + strArray[1].split('=')[1],
			method: "get",
			success: function(result) {
				console.log(result);
				collections=result.collections;
				printData();
				printPaging(result);
			}
		});	
	}else if(strArray[0].split('=')[0]=='?username'){
		username=strArray[0].split('=')[1];
		$.ajax({
			url: "/moviefactory/api/collection/userlist?username=" + strArray[0].split('=')[1] + "&pageno=" + strArray[1].split('=')[1],
			method: "get",
			success: function(result) {
				console.log(result);
				collections=result.collections;
				printData();
				printPaging(result);
			}
		});	
	}
	
});
</script>
<title>Insert title here</title>
</head>
<body>
<div id="section">
<div id="list"></div>
<div id="pagination"></div>
</div>
</body>
</html>