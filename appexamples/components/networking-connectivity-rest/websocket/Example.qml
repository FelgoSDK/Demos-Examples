import QtQuick 2.0
import QtWebSockets 1.0
import QtQuick.Controls 2.0
import Felgo 3.0


App {
  // Helper function to get socket status as a string
  function getSocketStatusString(socket) {
    switch (socket.status) {
    case WebSocket.Connecting: return "Connecting"
    case WebSocket.Open: return "Open"
    case WebSocket.Closing: return "Closing";
    case WebSocket.Closed: return "Closed";
    case WebSocket.Error: return "Error";
    }
    return "Unknown"
  }

  NavigationStack {
    Page {
      id: page
      title: "WebSocket"

      WebSocket {
        id: socket
        url: "ws://echo.websocket.org"
        active: false
        onTextMessageReceived: {
          messageBox.text = messageBox.text + "\nReceived message: " + message
        }
        onStatusChanged: {
          if (socket.status === WebSocket.Error) {
            console.log("Error: " + socket.errorString)
          } else if (socket.status === WebSocket.Open) {
            socket.sendTextMessage("Hello World")
          } else if (socket.status === WebSocket.Closed) {
            messageBox.text += "\nSocket closed"
          }
        }
      }

      WebSocket {
        id: secureWebSocket
        url: "wss://echo.websocket.org"
        active: false
        onTextMessageReceived: {
          messageBox.text = messageBox.text + "\nReceived secure message: " + message
        }
        onStatusChanged: {
          if (secureWebSocket.status === WebSocket.Error) {
            console.log("Error: " + secureWebSocket.errorString)
          } else if (secureWebSocket.status === WebSocket.Open) {
            secureWebSocket.sendTextMessage("Hello Secure World")
          } else if (secureWebSocket.status === WebSocket.Closed) {
            messageBox.text += "\nSecure socket closed"
          }
        }
      }

      Column {
        id: column
        anchors.fill: parent
        spacing: dp(20)

        AppText {
          font.bold: true
          text: "Current socket status: " + getSocketStatusString(socket)
                + "\nCurrent secure socket status: " + getSocketStatusString(secureWebSocket)
        }

        AppFlickable {
          id: flick
          width: page.width - 2 * column.spacing
          height: page.height / 2
          contentWidth: messageBox.paintedWidth
          contentHeight: messageBox.paintedHeight
          clip: true

          AppTextEdit {
            id: messageBox
            width: flick.width
            height: flick.height
            readOnly: true
          }

          ScrollBar.vertical: ScrollBar { policy: ScrollBar.AlwaysOn }
        }

        AppButton {
          text: socket.active ? "Close sockets" : "Open Sockets"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            socket.active = !socket.active
            secureWebSocket.active = !secureWebSocket.active
          }
        }
      }
    }
  }
}
