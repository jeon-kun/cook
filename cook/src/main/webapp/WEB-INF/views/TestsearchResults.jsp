<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Youtube Search Results</title>
<style>
  .video-container {
    margin-bottom: 1rem;
    display: inline-block; /* display 속성 추가 */
    width: 400px; /* 가로 크기 조정 */
    height: 150px; /* 세로 크기 조정 */
  }
</style>
</head>
<body>
	<%@include file="nav.jsp" %>
    <h1>Youtube Search Results</h1>
    <% List<String> videoIds = (List<String>) request.getAttribute("videoIds"); %>
    <% if (videoIds == null || videoIds.isEmpty()) { %>
      <p>No results found.</p>
    <% } else { %>
      <div> <!-- 감싸는 div 태그 추가 -->
      <% for (int i = 0; i < videoIds.size() && i < 15; i++) { %>
        <div class="video-container">
          <iframe width="400" height="250" src="https://www.youtube.com/embed/<%= videoIds.get(i) %>" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
        </div>
        <% if ((i+1) % 10 == 0) { %> <!-- 한 줄에 5개씩 보이도록 줄 바꿈 처리 -->
          <br>
        <% } %>
      <% } %>
      </div>
    <% } %>
</body>
</html>
