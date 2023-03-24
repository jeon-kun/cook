<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
    <style>
.thumblist {
    display: flex;
    flex-wrap: wrap;
    padding: 0;
    margin: 0;
    list-style: none;
}
.video {
  width: 23%;
  margin-right: 2%;
  margin-bottom: 20px;
  float: left;
}
.video:nth-child(4n) {
  margin-right: 0;
}
.item {
  display: inline-block;
  width: 25%;
  text-align: center;
}

.item .title {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
  text-overflow: ellipsis;
  font-size: 14px;
  line-height: 1.5;
  margin-top: 10px;
  margin-bottom: 5px;
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
		 
<div class="thumblist_wrap">
    <ul class="thumblist">
        <!-- row 별로 반복문 돌면서 출력 -->
        <c:forEach var="row" items="${rows}">
            <li class="row">
                <c:forEach var="post" items="${row}">
                    <li class="item">
                        <a href="${post.select("a").attr("href").replaceFirst("^/","https://blog.naver.com/")}">
                            <div class="area_thumb">
                                <img src="${post.select("img").attr("src")}"
                                     alt=""
                                     onerror="this.onerror=null;this.src='https://ssl.pstatic.net/static/blog/no_image2.svg'"
                                     class="thumb thumbnail"
                                     width="200"
                                     height="150"
                                     style="object-fit: cover;">
                            </div>
                            <div class="area_text">
                                <i class="cline"></i>
                                <strong class="title ell">${post.select(".title").text()}</strong>
                                <div class="wrap_icon_round"></div>
                                <span class="date">${post.select(".date").text()}</span>
                                <span class="read">
                                    <i class="icon">
                                        <span class="blind">댓글수</span>
                                    </i>
                                    ${post.select(".read").text()}
                                </span>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </li>
        </c:forEach>
    </ul>
</div>
<br>
<div class="wrap_blog2_paginate" style="text-align:center;">
    <div class="blog2_paginate" style="color:white;">
        <c:forEach var="pageUrl" items="${pageUrls}">
            <c:set var="pageNum" value="${pageUrl.substring(pageUrl.lastIndexOf('=') + 1)}" />
            <c:choose>
                <c:when test="${currentPage == pageNum}">
                    <strong class="page pcol3 _setTop">${pageNum}<span class="blind">현재 페이지</span><i class="aline pcol2"></i></strong>
                </c:when>
                <c:otherwise>
                    <a href="?page=${pageNum}" class="page pcol2 _setTop">${pageNum}<i class="aline"></i></a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>

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
