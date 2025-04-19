<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="webSoc.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <title>WebSocket Chat App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        #chatContainer {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        #chatLog {
            flex: 1;
            padding: 10px;
            overflow-y: auto;
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            background: #f7f7f7;
            display: flex;
            flex-direction: column;
        }

        .message {
            max-width: 70%;
            padding: 8px 12px;
            margin: 5px;
            border-radius: 10px;
            word-wrap: break-word;
        }

        .you {
            align-self: flex-end;
            background-color: #dcf8c6;
        }

        .other {
            align-self: flex-start;
            background-color: #ffffff;
        }

        #inputArea {
            display: flex;
            border-top: 1px solid #ccc;
            padding: 10px;
            background-color: #fff;
        }

        #messageInput {
            flex: 1;
            padding: 8px;
            font-size: 16px;
        }

        button {
            padding: 8px 16px;
            font-size: 16px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <h2>Welcome to WebSocket Demo</h2>
             <div id="chatContainer">
            <div id="chatLog"></div>
            <div id="inputArea">
                <input id="messageInput" type="text" placeholder="Type a message..." />
                <button type="button" onclick="sendMessage()">Send</button>
            </div>
        </div>
        </div>
    </form>
    <script>
        const socket = new WebSocket("ws://localhost:59257/ws");

        socket.onopen = () => {
            appendMessage("System", "✅ Connected to WebSocket server");
        };

        socket.onmessage = (event) => {
            appendMessage("Other", event.data);
        };

        socket.onerror = (error) => {
            appendMessage("System", "❌ WebSocket error");
        };

        socket.onclose = () => {
            appendMessage("System", "🔌 Disconnected");
        };

        function sendMessage() {
            const input = document.getElementById("messageInput");
            const message = input.value.trim();
            if (!message) return;

            if (socket.readyState === WebSocket.OPEN) {
                socket.send(message);
                appendMessage("You", message);
                input.value = "";
            } else {
                appendMessage("System", "❌ WebSocket is not open.");
            }
        }

        function appendMessage(sender, message) {
            const chatLog = document.getElementById("chatLog");
            const msgDiv = document.createElement("div");
            msgDiv.classList.add("message");

            if (sender === "You") msgDiv.classList.add("you");
            else if (sender === "Other") msgDiv.classList.add("other");
            else msgDiv.style.color = "#888";

            msgDiv.textContent = `${sender === "System" ? message : message}`;
            chatLog.appendChild(msgDiv);
            chatLog.scrollTop = chatLog.scrollHeight;
        }
    </script>
</body>
</html>
