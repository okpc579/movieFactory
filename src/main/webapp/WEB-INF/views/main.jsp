<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>무비 팩토리</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/moviefactory/css/main.css?after">
</head>
<body>
   <div id="page">
      <header>
         <jsp:include page="include/header.jsp" />
      </header>
      <nav>
         <jsp:include page="include/nav.jsp" />
      </nav>
      
      <div id="main">
         <aside>
            <jsp:include page="include/aside.jsp" />
         </aside>
         <section>
            <jsp:include page="${viewName}" />
         </section>
         <aside>
            <jsp:include page="include/aside1.jsp" />
         </aside>
      </div>
      <footer>
         <jsp:include page="include/footer.jsp" />
      </footer>
   </div>
</body>
</html>