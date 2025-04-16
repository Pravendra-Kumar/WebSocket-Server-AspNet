# WebSocket in ASP.NET

A simple WebSocket server built with ASP.NET, enabling real-time communication between clients and the server. This project demonstrates how to handle WebSocket requests, process messages, and send real-time responses. Ideal for chat apps, live notifications, and real-time data streaming.

## Features
- WebSocket server implementation using ASP.NET.
- Handles real-time message processing.
- Responds to client messages with server-side echo.

## Requirements
- .NET Framework 4.6.1 or higher.
- Visual Studio 2017 or higher.
- IIS Express or local server for testing.

## Installation

1. Clone or download the repository.
2. Open the solution in Visual Studio.
3. Build and run the project using Visual Studio or IIS Express.

## Usage

1. Start the application locally.
2. Open a WebSocket client (like a browser or Postman).
3. Connect to the WebSocket server using the URL:
4. Send a message to the server.
5. The server will respond with an echoed message: `Echo from server: <your message>`.

## Example Client Code (JavaScript)

```javascript
const socket = new WebSocket("ws://localhost:<PORT>/ws");

socket.onopen = function() {
console.log("Connected to the server");
socket.send("Hello Server");
};

socket.onmessage = function(event) {
console.log("Received message: " + event.data);
};
