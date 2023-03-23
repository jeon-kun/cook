<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat with AI</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Custom styles for this template-->
    <link href="/resources/chatstyle/css/styles.css" rel="stylesheet">
    <script src="/resources/chatstyle/js/scripts.js"></script>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <!------ Include the above in your HEAD tag ---------->
</head>
<body>
    <h1>Chat with AI</h1>
    <div id="chatLog"></div>
    <form onsubmit="return sendMessage()">
        <input type="text" id="messageInput" placeholder="Type your message here...">
        <button type="submit">Send</button>
    </form>

    <script>
        function sendMessage() {
            var message = document.getElementById("messageInput").value;
            if (message.trim() === "") {
                return false;
            }
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    var chatLog = document.getElementById("chatLog");
                    chatLog.innerHTML += "<p><strong>You:</strong> " + message + "</p>";
                    chatLog.innerHTML += "<p><strong>AI:</strong> " + response.choices[0].text + "</p>";
                    document.getElementById("messageInput").value = "";
                }
            }
            xhr.open("POST", "${pageContext.request.contextPath}/chat/chatai");
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            var params = "message=" + encodeURIComponent(message);
            xhr.send(params);
            return false;
        }
    </script>
</body>
</html>
