<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<style>
 .video-container {
    margin-bottom: 1rem;
    display: block;
    width: 35px;
    height: 250px;
    text-align: center;
  }
  .row.justify-content-center {
    text-align: center;
  }
</style>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Yutube - Start Bootstrap Theme</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap Icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
        <!-- SimpleLightbox plugin CSS-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="resources/mainstyle/css/styles.css" rel="stylesheet" />
    </head>
    <body id="page-top">
		<%@include file="nav.jsp" %>
		 <header class="masthead">
<% List<String> videoIds = (List<String>) request.getAttribute("videoIds"); %>
    <% if (videoIds == null || videoIds.isEmpty()) { %>
      <p>No results found.</p>
    <% } else { %>
      <div> <!-- 감싸는 div 태그 추가 -->
<div class="row justify-content-center"> <!-- 감싸는 div 태그 추가 -->
<% for (int i = 0; i < videoIds.size() && i < 12; i++) { %>
    <div class="col-lg-3 col-md-6 mb-4"> <!-- col 클래스 추가 -->
        <div class="video-container">
            <iframe width="350" height="250" src="https://www.youtube.com/embed/<%= videoIds.get(i) %>
            " frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
        </div>
    </div>
<% if ((i+1) % 4 == 0) { %> <!-- 한 줄에 4개씩 보이도록 처리 -->
    </div><div class="row justify-content-center">
<% } %>
<% } %>
</div> <!-- 감싸는 div 태그 닫기 -->
      </div>
    <% } %>
      </header>
        <%@include file="foot.jsp" %>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- SimpleLightbox plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
        <!-- Core theme JS-->
        <script src="resources/mainstyle/js/scripts.js"></script>

        
    </body>
</html>
