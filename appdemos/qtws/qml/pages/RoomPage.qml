import Felgo
import QtQuick

FlickablePage {
  id: roomPage
  title: room
  property string room

  flickable.flickableDirection: Flickable.AutoFlickIfNeeded
  flickable.contentWidth: roomPage.width
  flickable.contentHeight: roomPage.height

  scrollIndicator.visible: false

  function ensureMinSize() {
    if(flickable.contentWidth < roomPage.width) {
      flickable.resizeContent(roomPage.width, roomPage.height, Qt.point(0,0))
    }
  }

  PinchArea {
    width: Math.max(flickable.contentWidth, flickable.width)
    height: Math.max(flickable.contentHeight, flickable.height)

    property real initialWidth
    property real initialHeight

    onPinchStarted: {
      initialWidth = flickable.contentWidth
      initialHeight = flickable.contentHeight
    }

    onPinchUpdated: {
      // adjust content pos due to drag
      flickable.contentX += pinch.previousCenter.x - pinch.center.x
      flickable.contentY += pinch.previousCenter.y - pinch.center.y

      // resize content
      flickable.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
    }

    onPinchFinished: {
      roomPage.ensureMinSize()
      // Move its content within bounds.
      flickable.returnToBounds()
    }

    Rectangle {
      width: flickable.contentWidth
      height: flickable.contentHeight
      color: "white"

      AppImage {
        width: parent.width
        fillMode: AppImage.PreserveAspectFit
        property string fileName: room !== "Agenda" ? "Room " + room + ".png" : "Agenda.jpg"
        source: "../../assets/rooms/" + fileName

        MouseArea {
          anchors.fill: parent
          onDoubleClicked: {
            flickable.contentWidth = roomPage.width
            flickable.contentHeight = roomPage.height
          }
        }
      }
    }
  }
}
